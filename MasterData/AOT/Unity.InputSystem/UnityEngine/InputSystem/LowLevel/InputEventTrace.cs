using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Profiling;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[Serializable]
public sealed class InputEventTrace : IDisposable, IEnumerable<InputEventPtr>, IEnumerable
{
	private class Enumerator : IEnumerator<InputEventPtr>, IEnumerator, IDisposable
	{
		private InputEventTrace m_Trace;

		private int m_ChangeCounter;

		internal InputEventPtr m_Current;

		public InputEventPtr Current => m_Current;

		object IEnumerator.Current => Current;

		public Enumerator(InputEventTrace trace)
		{
			m_Trace = trace;
			m_ChangeCounter = trace.m_ChangeCounter;
		}

		public void Dispose()
		{
			m_Trace = null;
			m_Current = default;
		}

		public bool MoveNext()
		{
			if (m_Trace == null)
			{
				throw new ObjectDisposedException(ToString());
			}
			if (m_Trace.m_ChangeCounter != m_ChangeCounter)
			{
				throw new InvalidOperationException("Trace has been modified while enumerating!");
			}
			return m_Trace.GetNextEvent(ref m_Current);
		}

		public void Reset()
		{
			m_Current = default;
			m_ChangeCounter = m_Trace.m_ChangeCounter;
		}
	}

	[Flags]
	private enum FileFlags
	{
		FixedUpdate = 1
	}

	public class ReplayController : IDisposable
	{
		private InputEventTrace m_EventTrace;

		private Enumerator m_Enumerator;

		private InlinedArray<KeyValuePair<int, int>> m_DeviceIDMappings;

		private bool m_CreateNewDevices;

		private InlinedArray<InputDevice> m_CreatedDevices;

		private Action m_OnFinished;

		private Action<InputEventPtr> m_OnEvent;

		private double m_StartTimeAsPerFirstEvent;

		private double m_StartTimeAsPerRuntime;

		private int m_AllEventsByTimeIndex;

		private List<InputEventPtr> m_AllEventsByTime;

		public InputEventTrace trace => m_EventTrace;

		public bool finished { get; private set; }

		public bool paused { get; set; }

		public int position { get; private set; }

		public IEnumerable<InputDevice> createdDevices => m_CreatedDevices;

		internal ReplayController(InputEventTrace trace)
		{
			if (trace == null)
			{
				throw new ArgumentNullException("trace");
			}
			m_EventTrace = trace;
		}

		public void Dispose()
		{
			InputSystem.onBeforeUpdate -= OnBeginFrame;
			finished = true;
			foreach (InputDevice createdDevice in m_CreatedDevices)
			{
				InputSystem.RemoveDevice(createdDevice);
			}
			m_CreatedDevices = default;
		}

		public ReplayController WithDeviceMappedFromTo(InputDevice recordedDevice, InputDevice playbackDevice)
		{
			if (recordedDevice == null)
			{
				throw new ArgumentNullException("recordedDevice");
			}
			if (playbackDevice == null)
			{
				throw new ArgumentNullException("playbackDevice");
			}
			WithDeviceMappedFromTo(recordedDevice.deviceId, playbackDevice.deviceId);
			return this;
		}

		public ReplayController WithDeviceMappedFromTo(int recordedDeviceId, int playbackDeviceId)
		{
			for (int i = 0; i < m_DeviceIDMappings.length; i++)
			{
				if (m_DeviceIDMappings[i].Key == recordedDeviceId)
				{
					if (recordedDeviceId == playbackDeviceId)
					{
						m_DeviceIDMappings.RemoveAtWithCapacity(i);
					}
					else
					{
						m_DeviceIDMappings[i] = new KeyValuePair<int, int>(recordedDeviceId, playbackDeviceId);
					}
					return this;
				}
			}
			if (recordedDeviceId == playbackDeviceId)
			{
				return this;
			}
			m_DeviceIDMappings.AppendWithCapacity(new KeyValuePair<int, int>(recordedDeviceId, playbackDeviceId));
			return this;
		}

		public ReplayController WithAllDevicesMappedToNewInstances()
		{
			m_CreateNewDevices = true;
			return this;
		}

		public ReplayController OnFinished(Action action)
		{
			m_OnFinished = action;
			return this;
		}

		public ReplayController OnEvent(Action<InputEventPtr> action)
		{
			m_OnEvent = action;
			return this;
		}

		public ReplayController PlayOneEvent()
		{
			if (!MoveNext(skipFrameEvents: true, out var eventPtr))
			{
				throw new InvalidOperationException("No more events");
			}
			QueueEvent(eventPtr);
			return this;
		}

		public ReplayController Rewind()
		{
			m_Enumerator = null;
			m_AllEventsByTime = null;
			m_AllEventsByTimeIndex = -1;
			position = 0;
			return this;
		}

		public ReplayController PlayAllFramesOneByOne()
		{
			finished = false;
			InputSystem.onBeforeUpdate += OnBeginFrame;
			return this;
		}

		public ReplayController PlayAllEvents()
		{
			finished = false;
			try
			{
				InputEventPtr eventPtr;
				while (MoveNext(skipFrameEvents: true, out eventPtr))
				{
					QueueEvent(eventPtr);
				}
			}
			finally
			{
				Finished();
			}
			return this;
		}

		public ReplayController PlayAllEventsAccordingToTimestamps()
		{
			List<InputEventPtr> list = new List<InputEventPtr>();
			InputEventPtr eventPtr;
			while (MoveNext(skipFrameEvents: true, out eventPtr))
			{
				list.Add(eventPtr);
			}
			list.Sort((InputEventPtr a, InputEventPtr b) => a.time.CompareTo(b.time));
			m_Enumerator.Dispose();
			m_Enumerator = null;
			m_AllEventsByTime = list;
			position = 0;
			finished = false;
			m_StartTimeAsPerFirstEvent = -1.0;
			m_AllEventsByTimeIndex = -1;
			InputSystem.onBeforeUpdate += OnBeginFrame;
			return this;
		}

		private void OnBeginFrame()
		{
			if (paused)
			{
				return;
			}
			if (!MoveNext(skipFrameEvents: false, out var eventPtr))
			{
				if (m_AllEventsByTime == null || m_AllEventsByTimeIndex >= m_AllEventsByTime.Count)
				{
					Finished();
				}
				return;
			}
			if (eventPtr.type == FrameMarkerEvent)
			{
				if (!MoveNext(skipFrameEvents: false, out var eventPtr2))
				{
					Finished();
					return;
				}
				if (eventPtr2.type == FrameMarkerEvent)
				{
					int num = position - 1;
					position = num;
					m_Enumerator.m_Current = eventPtr;
					return;
				}
				eventPtr = eventPtr2;
			}
			while (true)
			{
				QueueEvent(eventPtr);
				if (!MoveNext(skipFrameEvents: false, out var eventPtr3))
				{
					if (m_AllEventsByTime == null || m_AllEventsByTimeIndex >= m_AllEventsByTime.Count)
					{
						Finished();
					}
					break;
				}
				if (eventPtr3.type == FrameMarkerEvent)
				{
					m_Enumerator.m_Current = eventPtr;
					int num = position - 1;
					position = num;
					break;
				}
				eventPtr = eventPtr3;
			}
		}

		private void Finished()
		{
			finished = true;
			InputSystem.onBeforeUpdate -= OnBeginFrame;
			m_OnFinished?.Invoke();
		}

		private void QueueEvent(InputEventPtr eventPtr)
		{
			double internalTime = eventPtr.internalTime;
			if (m_AllEventsByTime != null)
			{
				eventPtr.internalTime = m_StartTimeAsPerRuntime + (eventPtr.internalTime - m_StartTimeAsPerFirstEvent);
			}
			else
			{
				eventPtr.internalTime = InputRuntime.s_Instance.currentTime;
			}
			int id = eventPtr.id;
			int deviceId = eventPtr.deviceId;
			eventPtr.deviceId = ApplyDeviceMapping(deviceId);
			m_OnEvent?.Invoke(eventPtr);
			try
			{
				InputSystem.QueueEvent(eventPtr);
			}
			finally
			{
				eventPtr.internalTime = internalTime;
				eventPtr.id = id;
				eventPtr.deviceId = deviceId;
			}
		}

		private bool MoveNext(bool skipFrameEvents, out InputEventPtr eventPtr)
		{
			eventPtr = default;
			if (m_AllEventsByTime != null)
			{
				if (m_AllEventsByTimeIndex + 1 >= m_AllEventsByTime.Count)
				{
					position = m_AllEventsByTime.Count;
					m_AllEventsByTimeIndex = m_AllEventsByTime.Count;
					return false;
				}
				if (m_AllEventsByTimeIndex < 0)
				{
					m_StartTimeAsPerFirstEvent = m_AllEventsByTime[0].internalTime;
					m_StartTimeAsPerRuntime = InputRuntime.s_Instance.currentTime;
				}
				else if (m_AllEventsByTimeIndex < m_AllEventsByTime.Count - 1 && m_AllEventsByTime[m_AllEventsByTimeIndex + 1].internalTime > m_StartTimeAsPerFirstEvent + (InputRuntime.s_Instance.currentTime - m_StartTimeAsPerRuntime))
				{
					return false;
				}
				m_AllEventsByTimeIndex++;
				int num = position + 1;
				position = num;
				eventPtr = m_AllEventsByTime[m_AllEventsByTimeIndex];
			}
			else
			{
				if (m_Enumerator == null)
				{
					m_Enumerator = new Enumerator(m_EventTrace);
				}
				do
				{
					if (!m_Enumerator.MoveNext())
					{
						return false;
					}
					int num = position + 1;
					position = num;
					eventPtr = m_Enumerator.Current;
				}
				while (skipFrameEvents && eventPtr.type == FrameMarkerEvent);
			}
			return true;
		}

		private int ApplyDeviceMapping(int originalDeviceId)
		{
			for (int i = 0; i < m_DeviceIDMappings.length; i++)
			{
				KeyValuePair<int, int> keyValuePair = m_DeviceIDMappings[i];
				if (keyValuePair.Key == originalDeviceId)
				{
					return keyValuePair.Value;
				}
			}
			if (m_CreateNewDevices)
			{
				try
				{
					int num = m_EventTrace.deviceInfos.IndexOf((DeviceInfo x) => x.deviceId == originalDeviceId);
					if (num != -1)
					{
						DeviceInfo deviceInfo = m_EventTrace.deviceInfos[num];
						InternedString internedString = new InternedString(deviceInfo.layout);
						if (!InputControlLayout.s_Layouts.HasLayout(internedString))
						{
							if (string.IsNullOrEmpty(deviceInfo.m_FullLayoutJson))
							{
								return originalDeviceId;
							}
							InputSystem.RegisterLayout(deviceInfo.m_FullLayoutJson);
						}
						InputDevice inputDevice = InputSystem.AddDevice(internedString);
						WithDeviceMappedFromTo(originalDeviceId, inputDevice.deviceId);
						m_CreatedDevices.AppendWithCapacity(inputDevice);
						return inputDevice.deviceId;
					}
				}
				catch
				{
				}
			}
			return originalDeviceId;
		}
	}

	[Serializable]
	public struct DeviceInfo
	{
		[SerializeField]
		internal int m_DeviceId;

		[SerializeField]
		internal string m_Layout;

		[SerializeField]
		internal FourCC m_StateFormat;

		[SerializeField]
		internal int m_StateSizeInBytes;

		[SerializeField]
		internal string m_FullLayoutJson;

		public int deviceId
		{
			get
			{
				return m_DeviceId;
			}
			set
			{
				m_DeviceId = value;
			}
		}

		public string layout
		{
			get
			{
				return m_Layout;
			}
			set
			{
				m_Layout = value;
			}
		}

		public FourCC stateFormat
		{
			get
			{
				return m_StateFormat;
			}
			set
			{
				m_StateFormat = value;
			}
		}

		public int stateSizeInBytes
		{
			get
			{
				return m_StateSizeInBytes;
			}
			set
			{
				m_StateSizeInBytes = value;
			}
		}
	}

	private const int kDefaultBufferSize = 1048576;

	private static readonly ProfilerMarker k_InputEvenTraceMarker = new ProfilerMarker("InputEventTrace");

	[NonSerialized]
	private int m_ChangeCounter;

	[NonSerialized]
	private bool m_Enabled;

	[NonSerialized]
	private Func<InputEventPtr, InputDevice, bool> m_OnFilterEvent;

	[SerializeField]
	private int m_DeviceId;

	[NonSerialized]
	private CallbackArray<Action<InputEventPtr>> m_EventListeners;

	[SerializeField]
	private long m_EventBufferSize;

	[SerializeField]
	private long m_MaxEventBufferSize;

	[SerializeField]
	private long m_GrowIncrementSize;

	[SerializeField]
	private long m_EventCount;

	[SerializeField]
	private long m_EventSizeInBytes;

	[SerializeField]
	private ulong m_EventBufferStorage;

	[SerializeField]
	private ulong m_EventBufferHeadStorage;

	[SerializeField]
	private ulong m_EventBufferTailStorage;

	[SerializeField]
	private bool m_HasWrapped;

	[SerializeField]
	private bool m_RecordFrameMarkers;

	[SerializeField]
	private DeviceInfo[] m_DeviceInfos;

	private static int kFileVersion = 1;

	public static FourCC FrameMarkerEvent => new FourCC('F', 'R', 'M', 'E');

	public int deviceId
	{
		get
		{
			return m_DeviceId;
		}
		set
		{
			m_DeviceId = value;
		}
	}

	public bool enabled => m_Enabled;

	public bool recordFrameMarkers
	{
		get
		{
			return m_RecordFrameMarkers;
		}
		set
		{
			if (m_RecordFrameMarkers == value)
			{
				return;
			}
			m_RecordFrameMarkers = value;
			if (m_Enabled)
			{
				if (value)
				{
					InputSystem.onBeforeUpdate += OnBeforeUpdate;
				}
				else
				{
					InputSystem.onBeforeUpdate -= OnBeforeUpdate;
				}
			}
		}
	}

	public long eventCount => m_EventCount;

	public long totalEventSizeInBytes => m_EventSizeInBytes;

	public unsafe long allocatedSizeInBytes
	{
		get
		{
			if (m_EventBuffer == null)
			{
				return 0L;
			}
			return m_EventBufferSize;
		}
	}

	public long maxSizeInBytes => m_MaxEventBufferSize;

	public ReadOnlyArray<DeviceInfo> deviceInfos => m_DeviceInfos;

	public Func<InputEventPtr, InputDevice, bool> onFilterEvent
	{
		get
		{
			return m_OnFilterEvent;
		}
		set
		{
			m_OnFilterEvent = value;
		}
	}

	private unsafe byte* m_EventBuffer
	{
		get
		{
			return (byte*)m_EventBufferStorage;
		}
		set
		{
			m_EventBufferStorage = (ulong)value;
		}
	}

	private unsafe byte* m_EventBufferHead
	{
		get
		{
			return (byte*)m_EventBufferHeadStorage;
		}
		set
		{
			m_EventBufferHeadStorage = (ulong)value;
		}
	}

	private unsafe byte* m_EventBufferTail
	{
		get
		{
			return (byte*)m_EventBufferTailStorage;
		}
		set
		{
			m_EventBufferTailStorage = (ulong)value;
		}
	}

	private static FourCC kFileFormat => new FourCC('I', 'E', 'V', 'T');

	public event Action<InputEventPtr> onEvent
	{
		add
		{
			m_EventListeners.AddCallback(value);
		}
		remove
		{
			m_EventListeners.RemoveCallback(value);
		}
	}

	public InputEventTrace(InputDevice device, long bufferSizeInBytes = 1048576L, bool growBuffer = false, long maxBufferSizeInBytes = -1L, long growIncrementSizeInBytes = -1L)
		: this(bufferSizeInBytes, growBuffer, maxBufferSizeInBytes, growIncrementSizeInBytes)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		m_DeviceId = device.deviceId;
	}

	public InputEventTrace(long bufferSizeInBytes = 1048576L, bool growBuffer = false, long maxBufferSizeInBytes = -1L, long growIncrementSizeInBytes = -1L)
	{
		m_EventBufferSize = (uint)bufferSizeInBytes;
		if (growBuffer)
		{
			if (maxBufferSizeInBytes < 0)
			{
				m_MaxEventBufferSize = 268435456L;
			}
			else
			{
				m_MaxEventBufferSize = maxBufferSizeInBytes;
			}
			if (growIncrementSizeInBytes < 0)
			{
				m_GrowIncrementSize = 1048576L;
			}
			else
			{
				m_GrowIncrementSize = growIncrementSizeInBytes;
			}
		}
		else
		{
			m_MaxEventBufferSize = m_EventBufferSize;
		}
	}

	public void WriteTo(string filePath)
	{
		if (string.IsNullOrEmpty(filePath))
		{
			throw new ArgumentNullException("filePath");
		}
		using FileStream stream = File.OpenWrite(filePath);
		WriteTo(stream);
	}

	public unsafe void WriteTo(Stream stream)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		if (!stream.CanSeek)
		{
			throw new ArgumentException("Stream does not support seeking", "stream");
		}
		BinaryWriter binaryWriter = new BinaryWriter(stream);
		FileFlags fileFlags = (FileFlags)0;
		if (InputSystem.settings.updateMode == InputSettings.UpdateMode.ProcessEventsInFixedUpdate)
		{
			fileFlags |= FileFlags.FixedUpdate;
		}
		binaryWriter.Write(kFileFormat);
		binaryWriter.Write(kFileVersion);
		binaryWriter.Write((int)fileFlags);
		binaryWriter.Write((int)Application.platform);
		binaryWriter.Write((ulong)m_EventCount);
		binaryWriter.Write((ulong)m_EventSizeInBytes);
		using (IEnumerator<InputEventPtr> enumerator = GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				InputEventPtr current = enumerator.Current;
				uint sizeInBytes = current.sizeInBytes;
				byte[] array = new byte[sizeInBytes];
				fixed (byte* destination = array)
				{
					UnsafeUtility.MemCpy(destination, current.data, sizeInBytes);
					binaryWriter.Write(array);
				}
			}
		}
		binaryWriter.Flush();
		long position = stream.Position;
		int num = m_DeviceInfos.LengthSafe();
		binaryWriter.Write(num);
		for (int i = 0; i < num; i++)
		{
			ref DeviceInfo reference = ref m_DeviceInfos[i];
			binaryWriter.Write(reference.deviceId);
			binaryWriter.Write(reference.layout);
			binaryWriter.Write(reference.stateFormat);
			binaryWriter.Write(reference.stateSizeInBytes);
			binaryWriter.Write(reference.m_FullLayoutJson ?? string.Empty);
		}
		binaryWriter.Flush();
		long value = stream.Position - position;
		binaryWriter.Write(value);
	}

	public void ReadFrom(string filePath)
	{
		if (string.IsNullOrEmpty(filePath))
		{
			throw new ArgumentNullException("filePath");
		}
		using FileStream stream = File.OpenRead(filePath);
		ReadFrom(stream);
	}

	public unsafe void ReadFrom(Stream stream)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		if (!stream.CanRead)
		{
			throw new ArgumentException("Stream does not support reading", "stream");
		}
		BinaryReader binaryReader = new BinaryReader(stream);
		if (binaryReader.ReadInt32() != kFileFormat)
		{
			throw new IOException($"Stream does not appear to be an InputEventTrace (no '{kFileFormat}' code)");
		}
		if (binaryReader.ReadInt32() > kFileVersion)
		{
			throw new IOException($"Stream is an InputEventTrace but a newer version (expected version {kFileVersion} or below)");
		}
		binaryReader.ReadInt32();
		binaryReader.ReadInt32();
		ulong num = binaryReader.ReadUInt64();
		ulong num2 = binaryReader.ReadUInt64();
		byte* eventBuffer = m_EventBuffer;
		if (num != 0 && num2 != 0)
		{
			byte* ptr;
			if (m_EventBuffer != null && m_EventBufferSize >= (long)num2)
			{
				ptr = m_EventBuffer;
			}
			else
			{
				ptr = (byte*)UnsafeUtility.Malloc((long)num2, 4, Allocator.Persistent);
				m_EventBufferSize = (long)num2;
			}
			try
			{
				byte* ptr2 = ptr;
				byte* ptr3 = ptr2 + num2;
				long num3 = 0L;
				for (ulong num4 = 0uL; num4 < num; num4++)
				{
					int num5 = binaryReader.ReadInt32();
					uint num6 = binaryReader.ReadUInt16();
					uint num7 = binaryReader.ReadUInt16();
					if (num6 > ptr3 - ptr2)
					{
						break;
					}
					*(int*)ptr2 = num5;
					ptr2 += 4;
					*(ushort*)ptr2 = (ushort)num6;
					ptr2 += 2;
					*(ushort*)ptr2 = (ushort)num7;
					ptr2 += 2;
					int num8 = (int)(num6 - 4 - 2 - 2);
					byte[] array = binaryReader.ReadBytes(num8);
					fixed (byte* source = array)
					{
						UnsafeUtility.MemCpy(ptr2, source, num8);
					}
					ptr2 += num8.AlignToMultipleOf(4);
					num3 += num6.AlignToMultipleOf(4u);
					if (ptr2 >= ptr3)
					{
						break;
					}
				}
				int num9 = binaryReader.ReadInt32();
				DeviceInfo[] array2 = new DeviceInfo[num9];
				for (int i = 0; i < num9; i++)
				{
					array2[i] = new DeviceInfo
					{
						deviceId = binaryReader.ReadInt32(),
						layout = binaryReader.ReadString(),
						stateFormat = binaryReader.ReadInt32(),
						stateSizeInBytes = binaryReader.ReadInt32(),
						m_FullLayoutJson = binaryReader.ReadString()
					};
				}
				m_EventBuffer = ptr;
				m_EventBufferHead = m_EventBuffer;
				m_EventBufferTail = ptr3;
				m_EventCount = (long)num;
				m_EventSizeInBytes = num3;
				m_DeviceInfos = array2;
			}
			catch
			{
				if (ptr != eventBuffer)
				{
					UnsafeUtility.Free(ptr, Allocator.Persistent);
				}
				throw;
			}
		}
		else
		{
			m_EventBuffer = null;
			m_EventBufferHead = null;
			m_EventBufferTail = null;
		}
		if (m_EventBuffer != eventBuffer && eventBuffer != null)
		{
			UnsafeUtility.Free(eventBuffer, Allocator.Persistent);
		}
		m_ChangeCounter++;
	}

	public static InputEventTrace LoadFrom(string filePath)
	{
		if (string.IsNullOrEmpty(filePath))
		{
			throw new ArgumentNullException("filePath");
		}
		using FileStream stream = File.OpenRead(filePath);
		return LoadFrom(stream);
	}

	public static InputEventTrace LoadFrom(Stream stream)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		if (!stream.CanRead)
		{
			throw new ArgumentException("Stream must be readable", "stream");
		}
		InputEventTrace inputEventTrace = new InputEventTrace(1048576L, growBuffer: false, -1L, -1L);
		inputEventTrace.ReadFrom(stream);
		return inputEventTrace;
	}

	public ReplayController Replay()
	{
		Disable();
		return new ReplayController(this);
	}

	public unsafe bool Resize(long newBufferSize, long newMaxBufferSize = -1L)
	{
		if (newBufferSize <= 0)
		{
			throw new ArgumentException("Size must be positive", "newBufferSize");
		}
		if (m_EventBufferSize == newBufferSize)
		{
			return true;
		}
		if (newMaxBufferSize < newBufferSize)
		{
			newMaxBufferSize = newBufferSize;
		}
		byte* ptr = (byte*)UnsafeUtility.Malloc(newBufferSize, 4, Allocator.Persistent);
		if (ptr == null)
		{
			return false;
		}
		if (m_EventCount > 0)
		{
			if (newBufferSize < m_EventBufferSize || m_HasWrapped)
			{
				InputEventPtr current = new InputEventPtr((InputEvent*)m_EventBufferHead);
				InputEvent* ptr2 = (InputEvent*)ptr;
				int num = 0;
				int num2 = 0;
				long num3 = m_EventSizeInBytes;
				for (int i = 0; i < m_EventCount; i++)
				{
					uint sizeInBytes = current.sizeInBytes;
					uint num4 = sizeInBytes.AlignToMultipleOf(4u);
					if (num3 <= newBufferSize)
					{
						UnsafeUtility.MemCpy(ptr2, current.ToPointer(), sizeInBytes);
						ptr2 = InputEvent.GetNextInMemory(ptr2);
						num2 += (int)num4;
						num++;
					}
					num3 -= num4;
					if (!GetNextEvent(ref current))
					{
						break;
					}
				}
				m_HasWrapped = false;
				m_EventCount = num;
				m_EventSizeInBytes = num2;
			}
			else
			{
				UnsafeUtility.MemCpy(ptr, m_EventBufferHead, m_EventSizeInBytes);
			}
		}
		if (m_EventBuffer != null)
		{
			UnsafeUtility.Free(m_EventBuffer, Allocator.Persistent);
		}
		m_EventBufferSize = newBufferSize;
		m_EventBuffer = ptr;
		m_EventBufferHead = ptr;
		m_EventBufferTail = m_EventBuffer + m_EventSizeInBytes;
		m_MaxEventBufferSize = newMaxBufferSize;
		m_ChangeCounter++;
		return true;
	}

	public unsafe void Clear()
	{
		byte* eventBufferHead = (m_EventBufferTail = default);
		m_EventBufferHead = eventBufferHead;
		m_EventCount = 0L;
		m_EventSizeInBytes = 0L;
		m_ChangeCounter++;
		m_DeviceInfos = null;
	}

	public unsafe void Enable()
	{
		if (!m_Enabled)
		{
			if (m_EventBuffer == null)
			{
				Allocate();
			}
			InputSystem.onEvent += new Action<InputEventPtr, InputDevice>(OnInputEvent);
			if (m_RecordFrameMarkers)
			{
				InputSystem.onBeforeUpdate += OnBeforeUpdate;
			}
			m_Enabled = true;
		}
	}

	public void Disable()
	{
		if (m_Enabled)
		{
			InputSystem.onEvent -= new Action<InputEventPtr, InputDevice>(OnInputEvent);
			InputSystem.onBeforeUpdate -= OnBeforeUpdate;
			m_Enabled = false;
		}
	}

	public unsafe bool GetNextEvent(ref InputEventPtr current)
	{
		if (m_EventBuffer == null)
		{
			return false;
		}
		if (m_EventBufferHead == null)
		{
			return false;
		}
		if (!current.valid)
		{
			current = new InputEventPtr((InputEvent*)m_EventBufferHead);
			return true;
		}
		byte* ptr = (byte*)current.Next().data;
		byte* ptr2 = m_EventBuffer + m_EventBufferSize;
		if (ptr == m_EventBufferTail)
		{
			return false;
		}
		if (ptr2 - ptr < 20 || ((InputEvent*)ptr)->sizeInBytes == 0)
		{
			ptr = m_EventBuffer;
			if (ptr == current.ToPointer())
			{
				return false;
			}
		}
		current = new InputEventPtr((InputEvent*)ptr);
		return true;
	}

	public IEnumerator<InputEventPtr> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void Dispose()
	{
		Disable();
		Release();
	}

	private unsafe void Allocate()
	{
		m_EventBuffer = (byte*)UnsafeUtility.Malloc(m_EventBufferSize, 4, Allocator.Persistent);
	}

	private unsafe void Release()
	{
		Clear();
		if (m_EventBuffer != null)
		{
			UnsafeUtility.Free(m_EventBuffer, Allocator.Persistent);
			m_EventBuffer = null;
		}
	}

	private unsafe void OnBeforeUpdate()
	{
		if (m_RecordFrameMarkers)
		{
			InputEvent output = new InputEvent
			{
				type = FrameMarkerEvent,
				internalTime = InputRuntime.s_Instance.currentTime,
				sizeInBytes = (uint)UnsafeUtility.SizeOf<InputEvent>()
			};
			OnInputEvent(new InputEventPtr((InputEvent*)UnsafeUtility.AddressOf(ref output)), null);
		}
	}

	private unsafe void OnInputEvent(InputEventPtr inputEvent, InputDevice device)
	{
		if (inputEvent.handled || (m_DeviceId != 0 && inputEvent.deviceId != m_DeviceId && inputEvent.type != FrameMarkerEvent) || (m_OnFilterEvent != null && !m_OnFilterEvent(inputEvent, device)) || m_EventBuffer == null)
		{
			return;
		}
		uint num = inputEvent.sizeInBytes.AlignToMultipleOf(4u);
		if (num > m_MaxEventBufferSize)
		{
			return;
		}
		if (m_EventBufferTail == null)
		{
			m_EventBufferHead = m_EventBuffer;
			m_EventBufferTail = m_EventBuffer;
		}
		byte* ptr = m_EventBufferTail + num;
		bool flag = ptr > m_EventBufferHead && m_EventBufferHead != m_EventBuffer;
		if (ptr > m_EventBuffer + m_EventBufferSize)
		{
			if (m_EventBufferSize < m_MaxEventBufferSize && !m_HasWrapped)
			{
				long num2 = Math.Max(m_GrowIncrementSize, num.AlignToMultipleOf(4u));
				long num3 = m_EventBufferSize + num2;
				if (num3 > m_MaxEventBufferSize)
				{
					num3 = m_MaxEventBufferSize;
				}
				if (num3 < num)
				{
					return;
				}
				Resize(num3, -1L);
				ptr = m_EventBufferTail + num;
			}
			long num4 = m_EventBufferSize - (m_EventBufferTail - m_EventBuffer);
			if (num4 < num)
			{
				m_HasWrapped = true;
				if (num4 >= 20)
				{
					UnsafeUtility.MemClear(m_EventBufferTail, 20L);
				}
				m_EventBufferTail = m_EventBuffer;
				ptr = m_EventBuffer + num;
				if (flag)
				{
					m_EventBufferHead = m_EventBuffer;
				}
				flag = ptr > m_EventBufferHead;
			}
		}
		if (flag)
		{
			byte* ptr2 = m_EventBufferHead;
			byte* ptr3 = m_EventBuffer + m_EventBufferSize - 20;
			while (ptr2 < ptr)
			{
				uint sizeInBytes = ((InputEvent*)ptr2)->sizeInBytes;
				ptr2 += sizeInBytes;
				m_EventCount--;
				m_EventSizeInBytes -= sizeInBytes;
				if (ptr2 > ptr3 || ((InputEvent*)ptr2)->sizeInBytes == 0)
				{
					ptr2 = m_EventBuffer;
					break;
				}
			}
			m_EventBufferHead = ptr2;
		}
		byte* eventBufferTail = m_EventBufferTail;
		m_EventBufferTail = ptr;
		UnsafeUtility.MemCpy(eventBufferTail, inputEvent.data, inputEvent.sizeInBytes);
		m_ChangeCounter++;
		m_EventCount++;
		m_EventSizeInBytes += num;
		if (device != null)
		{
			bool flag2 = false;
			if (m_DeviceInfos != null)
			{
				for (int i = 0; i < m_DeviceInfos.Length; i++)
				{
					if (m_DeviceInfos[i].deviceId == device.deviceId)
					{
						flag2 = true;
						break;
					}
				}
			}
			if (!flag2)
			{
				ArrayHelpers.Append(ref m_DeviceInfos, new DeviceInfo
				{
					m_DeviceId = device.deviceId,
					m_Layout = device.layout,
					m_StateFormat = device.stateBlock.format,
					m_StateSizeInBytes = (int)device.stateBlock.alignedSizeInBytes,
					m_FullLayoutJson = (InputControlLayout.s_Layouts.IsGeneratedLayout(device.m_Layout) ? InputSystem.LoadLayout(device.layout).ToJson() : null)
				});
			}
		}
		if (m_EventListeners.length > 0)
		{
			DelegateHelpers.InvokeCallbacksSafe(ref m_EventListeners, new InputEventPtr((InputEvent*)eventBufferTail), "InputEventTrace.onEvent");
		}
	}
}
