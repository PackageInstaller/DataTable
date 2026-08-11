using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public sealed class InputRemoting : IObservable<InputRemoting.Message>, IObserver<InputRemoting.Message>
{
	public enum MessageType
	{
		Connect,
		Disconnect,
		NewLayout,
		NewDevice,
		NewEvents,
		RemoveDevice,
		RemoveLayout,
		ChangeUsages,
		StartSending,
		StopSending
	}

	public struct Message
	{
		public int participantId;

		public MessageType type;

		public byte[] data;
	}

	[Flags]
	private enum Flags
	{
		Sending = 1,
		StartSendingOnConnect = 2
	}

	[Serializable]
	internal struct RemoteSender
	{
		public int senderId;

		public InternedString[] layouts;

		public RemoteInputDevice[] devices;
	}

	[Serializable]
	internal struct RemoteInputDevice
	{
		public int remoteId;

		public int localId;

		public InputDeviceDescription description;
	}

	internal class Subscriber : IDisposable
	{
		public InputRemoting owner;

		public IObserver<Message> observer;

		public void Dispose()
		{
			ArrayHelpers.Erase(ref owner.m_Subscribers, this);
		}
	}

	private static class ConnectMsg
	{
		public static void Process(InputRemoting receiver)
		{
			if (receiver.sending)
			{
				receiver.SendInitialMessages();
			}
			else if ((receiver.m_Flags & Flags.StartSendingOnConnect) == Flags.StartSendingOnConnect)
			{
				receiver.StartSending();
			}
		}
	}

	private static class StartSendingMsg
	{
		public static void Process(InputRemoting receiver)
		{
			receiver.StartSending();
		}
	}

	private static class StopSendingMsg
	{
		public static void Process(InputRemoting receiver)
		{
			receiver.StopSending();
		}
	}

	private static class DisconnectMsg
	{
		public static void Process(InputRemoting receiver, Message msg)
		{
			Debug.Log("DisconnectMsg.Process");
			receiver.RemoveRemoteDevices(msg.participantId);
			receiver.StopSending();
		}
	}

	private static class NewLayoutMsg
	{
		[Serializable]
		public struct Data
		{
			public string name;

			public string layoutJson;

			public bool isOverride;
		}

		public static Message? Create(InputRemoting sender, string layoutName)
		{
			InputControlLayout inputControlLayout;
			try
			{
				inputControlLayout = sender.m_LocalManager.TryLoadControlLayout(new InternedString(layoutName));
				if (inputControlLayout == null)
				{
					Debug.Log($"Could not find layout '{layoutName}' meant to be sent through remote connection; this should not happen");
					return null;
				}
			}
			catch (Exception arg)
			{
				Debug.Log($"Could not load layout '{layoutName}'; not sending to remote listeners (exception: {arg})");
				return null;
			}
			Data data = new Data
			{
				name = layoutName,
				layoutJson = inputControlLayout.ToJson(),
				isOverride = inputControlLayout.isOverride
			};
			return new Message
			{
				type = MessageType.NewLayout,
				data = SerializeData(data)
			};
		}

		public static void Process(InputRemoting receiver, Message msg)
		{
			Data data = DeserializeData<Data>(msg.data);
			int num = receiver.FindOrCreateSenderRecord(msg.participantId);
			InternedString value = new InternedString(data.name);
			receiver.m_LocalManager.RegisterControlLayout(data.layoutJson, data.name, data.isOverride);
			ArrayHelpers.Append(ref receiver.m_Senders[num].layouts, value);
		}
	}

	private static class NewDeviceMsg
	{
		[Serializable]
		public struct Data
		{
			public string name;

			public string layout;

			public int deviceId;

			public string[] usages;

			public InputDeviceDescription description;
		}

		public static Message Create(InputDevice device)
		{
			Data data = new Data
			{
				name = device.name,
				layout = device.layout,
				deviceId = device.deviceId,
				description = device.description,
				usages = device.usages.Select((InternedString x) => x.ToString()).ToArray()
			};
			return new Message
			{
				type = MessageType.NewDevice,
				data = SerializeData(data)
			};
		}

		public static void Process(InputRemoting receiver, Message msg)
		{
			int num = receiver.FindOrCreateSenderRecord(msg.participantId);
			Data data = DeserializeData<Data>(msg.data);
			RemoteInputDevice[] devices = receiver.m_Senders[num].devices;
			if (devices != null)
			{
				RemoteInputDevice[] array = devices;
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i].remoteId == data.deviceId)
					{
						Debug.LogError(string.Format("Already received device with id {0} (layout '{1}', description '{3}) from remote {2}", data.deviceId, data.layout, msg.participantId, data.description));
						return;
					}
				}
			}
			InputDevice inputDevice;
			try
			{
				InternedString internedString = new InternedString(data.layout);
				inputDevice = receiver.m_LocalManager.AddDevice(internedString, data.name);
				inputDevice.m_ParticipantId = msg.participantId;
			}
			catch (Exception arg)
			{
				Debug.LogError($"Could not create remote device '{data.description}' with layout '{data.layout}' locally (exception: {arg})");
				return;
			}
			inputDevice.m_Description = data.description;
			inputDevice.m_DeviceFlags |= InputDevice.DeviceFlags.Remote;
			string[] usages = data.usages;
			foreach (string text in usages)
			{
				receiver.m_LocalManager.AddDeviceUsage(inputDevice, new InternedString(text));
			}
			RemoteInputDevice value = new RemoteInputDevice
			{
				remoteId = data.deviceId,
				localId = inputDevice.deviceId,
				description = data.description
			};
			ArrayHelpers.Append(ref receiver.m_Senders[num].devices, value);
		}
	}

	private static class NewEventsMsg
	{
		public unsafe static Message CreateResetEvent(InputDevice device, bool isHardReset)
		{
			DeviceResetEvent output = DeviceResetEvent.Create(device.deviceId, isHardReset);
			return Create((InputEvent*)UnsafeUtility.AddressOf(ref output), 1);
		}

		public unsafe static Message CreateStateEvent(InputDevice device)
		{
			InputEventPtr eventPtr;
			using (StateEvent.From(device, out eventPtr))
			{
				return Create(eventPtr.data, 1);
			}
		}

		public unsafe static Message Create(InputEvent* events, int eventCount)
		{
			uint num = 0u;
			InputEventPtr inputEventPtr = new InputEventPtr(events);
			int num2 = 0;
			while (num2 < eventCount)
			{
				num = num.AlignToMultipleOf(4u) + inputEventPtr.sizeInBytes;
				num2++;
				inputEventPtr = inputEventPtr.Next();
			}
			byte[] array = new byte[num];
			fixed (byte* destination = array)
			{
				UnsafeUtility.MemCpy(destination, events, num);
			}
			return new Message
			{
				type = MessageType.NewEvents,
				data = array
			};
		}

		public unsafe static void Process(InputRemoting receiver, Message msg)
		{
			InputManager localManager = receiver.m_LocalManager;
			fixed (byte* data = msg.data)
			{
				IntPtr intPtr = new IntPtr(data + msg.data.Length);
				int num = 0;
				InputEventPtr ptr = new InputEventPtr((InputEvent*)data);
				int senderIndex = receiver.FindOrCreateSenderRecord(msg.participantId);
				while (ptr.data < intPtr.ToPointer())
				{
					int deviceId = ptr.deviceId;
					if ((ptr.deviceId = receiver.FindLocalDeviceId(deviceId, senderIndex)) != 0)
					{
						localManager.QueueEvent(ptr);
					}
					num++;
					ptr = ptr.Next();
				}
			}
		}
	}

	private static class ChangeUsageMsg
	{
		[Serializable]
		public struct Data
		{
			public int deviceId;

			public string[] usages;
		}

		public static Message Create(InputDevice device)
		{
			Data data = new Data
			{
				deviceId = device.deviceId,
				usages = device.usages.Select((InternedString x) => x.ToString()).ToArray()
			};
			return new Message
			{
				type = MessageType.ChangeUsages,
				data = SerializeData(data)
			};
		}

		public static void Process(InputRemoting receiver, Message msg)
		{
			int senderIndex = receiver.FindOrCreateSenderRecord(msg.participantId);
			Data data = DeserializeData<Data>(msg.data);
			InputDevice inputDevice = receiver.TryGetDeviceByRemoteId(data.deviceId, senderIndex);
			if (inputDevice == null)
			{
				return;
			}
			foreach (InternedString usage in inputDevice.usages)
			{
				if (!data.usages.Contains(usage))
				{
					receiver.m_LocalManager.RemoveDeviceUsage(inputDevice, new InternedString(usage));
				}
			}
			string[] usages = data.usages;
			foreach (string text in usages)
			{
				if (!ReadOnlyArrayExtensions.Contains(value: new InternedString(text), array: inputDevice.usages))
				{
					receiver.m_LocalManager.AddDeviceUsage(inputDevice, new InternedString(text));
				}
			}
		}
	}

	private static class RemoveDeviceMsg
	{
		public static Message Create(InputDevice device)
		{
			return new Message
			{
				type = MessageType.RemoveDevice,
				data = BitConverter.GetBytes(device.deviceId)
			};
		}

		public static void Process(InputRemoting receiver, Message msg)
		{
			int senderIndex = receiver.FindOrCreateSenderRecord(msg.participantId);
			int remoteDeviceId = BitConverter.ToInt32(msg.data, 0);
			InputDevice inputDevice = receiver.TryGetDeviceByRemoteId(remoteDeviceId, senderIndex);
			if (inputDevice != null)
			{
				receiver.m_LocalManager.RemoveDevice(inputDevice);
			}
		}
	}

	private Flags m_Flags;

	private InputManager m_LocalManager;

	private Subscriber[] m_Subscribers;

	private RemoteSender[] m_Senders;

	public bool sending
	{
		get
		{
			return (m_Flags & Flags.Sending) == Flags.Sending;
		}
		private set
		{
			if (value)
			{
				m_Flags |= Flags.Sending;
			}
			else
			{
				m_Flags &= ~Flags.Sending;
			}
		}
	}

	internal InputManager manager => m_LocalManager;

	internal InputRemoting(InputManager manager, bool startSendingOnConnect = false)
	{
		if (manager == null)
		{
			throw new ArgumentNullException("manager");
		}
		m_LocalManager = manager;
		if (startSendingOnConnect)
		{
			m_Flags |= Flags.StartSendingOnConnect;
		}
	}

	public void StartSending()
	{
		if (!sending)
		{
			m_LocalManager.onEvent += SendEvent;
			m_LocalManager.onDeviceChange += SendDeviceChange;
			m_LocalManager.onLayoutChange += SendLayoutChange;
			sending = true;
			SendInitialMessages();
		}
	}

	public void StopSending()
	{
		if (sending)
		{
			m_LocalManager.onEvent -= SendEvent;
			m_LocalManager.onDeviceChange -= SendDeviceChange;
			m_LocalManager.onLayoutChange -= SendLayoutChange;
			sending = false;
		}
	}

	void IObserver<Message>.OnNext(Message msg)
	{
		switch (msg.type)
		{
		case MessageType.Connect:
			ConnectMsg.Process(this);
			break;
		case MessageType.Disconnect:
			DisconnectMsg.Process(this, msg);
			break;
		case MessageType.NewLayout:
			NewLayoutMsg.Process(this, msg);
			break;
		case MessageType.NewDevice:
			NewDeviceMsg.Process(this, msg);
			break;
		case MessageType.NewEvents:
			NewEventsMsg.Process(this, msg);
			break;
		case MessageType.ChangeUsages:
			ChangeUsageMsg.Process(this, msg);
			break;
		case MessageType.RemoveDevice:
			RemoveDeviceMsg.Process(this, msg);
			break;
		case MessageType.StartSending:
			StartSendingMsg.Process(this);
			break;
		case MessageType.StopSending:
			StopSendingMsg.Process(this);
			break;
		case MessageType.RemoveLayout:
			break;
		}
	}

	void IObserver<Message>.OnError(Exception error)
	{
	}

	void IObserver<Message>.OnCompleted()
	{
	}

	public IDisposable Subscribe(IObserver<Message> observer)
	{
		if (observer == null)
		{
			throw new ArgumentNullException("observer");
		}
		Subscriber subscriber = new Subscriber
		{
			owner = this,
			observer = observer
		};
		ArrayHelpers.Append(ref m_Subscribers, subscriber);
		return subscriber;
	}

	private void SendInitialMessages()
	{
		SendAllGeneratedLayouts();
		SendAllDevices();
	}

	private void SendAllGeneratedLayouts()
	{
		foreach (KeyValuePair<InternedString, Func<InputControlLayout>> layoutBuilder in m_LocalManager.m_Layouts.layoutBuilders)
		{
			SendLayout(layoutBuilder.Key);
		}
	}

	private void SendLayout(string layoutName)
	{
		if (m_Subscribers != null)
		{
			Message? message = NewLayoutMsg.Create(this, layoutName);
			if (message.HasValue)
			{
				Send(message.Value);
			}
		}
	}

	private void SendAllDevices()
	{
		foreach (InputDevice device in m_LocalManager.devices)
		{
			SendDevice(device);
		}
	}

	private void SendDevice(InputDevice device)
	{
		if (m_Subscribers != null && !device.remote)
		{
			Message msg = NewDeviceMsg.Create(device);
			Send(msg);
			Message msg2 = NewEventsMsg.CreateStateEvent(device);
			Send(msg2);
		}
	}

	private unsafe void SendEvent(InputEventPtr eventPtr, InputDevice device)
	{
		if (m_Subscribers != null && (device == null || !device.remote))
		{
			Message msg = NewEventsMsg.Create(eventPtr.data, 1);
			Send(msg);
		}
	}

	private void SendDeviceChange(InputDevice device, InputDeviceChange change)
	{
		if (m_Subscribers != null && !device.remote)
		{
			Message msg;
			switch (change)
			{
			case InputDeviceChange.Added:
				msg = NewDeviceMsg.Create(device);
				break;
			case InputDeviceChange.Removed:
				msg = RemoveDeviceMsg.Create(device);
				break;
			case InputDeviceChange.UsageChanged:
				msg = ChangeUsageMsg.Create(device);
				break;
			case InputDeviceChange.SoftReset:
				msg = NewEventsMsg.CreateResetEvent(device, isHardReset: false);
				break;
			case InputDeviceChange.HardReset:
				msg = NewEventsMsg.CreateResetEvent(device, isHardReset: true);
				break;
			default:
				return;
			}
			Send(msg);
		}
	}

	private void SendLayoutChange(string layout, InputControlLayoutChange change)
	{
		if (m_Subscribers != null && m_LocalManager.m_Layouts.IsGeneratedLayout(new InternedString(layout)) && (change == InputControlLayoutChange.Added || change == InputControlLayoutChange.Replaced))
		{
			Message? message = NewLayoutMsg.Create(this, layout);
			if (message.HasValue)
			{
				Send(message.Value);
			}
		}
	}

	private void Send(Message msg)
	{
		Subscriber[] subscribers = m_Subscribers;
		for (int i = 0; i < subscribers.Length; i++)
		{
			subscribers[i].observer.OnNext(msg);
		}
	}

	private int FindOrCreateSenderRecord(int senderId)
	{
		if (m_Senders != null)
		{
			int num = m_Senders.Length;
			for (int i = 0; i < num; i++)
			{
				if (m_Senders[i].senderId == senderId)
				{
					return i;
				}
			}
		}
		RemoteSender value = new RemoteSender
		{
			senderId = senderId
		};
		return ArrayHelpers.Append(ref m_Senders, value);
	}

	private static InternedString BuildLayoutNamespace(int senderId)
	{
		return new InternedString($"Remote::{senderId}");
	}

	private int FindLocalDeviceId(int remoteDeviceId, int senderIndex)
	{
		RemoteInputDevice[] devices = m_Senders[senderIndex].devices;
		if (devices != null)
		{
			int num = devices.Length;
			for (int i = 0; i < num; i++)
			{
				if (devices[i].remoteId == remoteDeviceId)
				{
					return devices[i].localId;
				}
			}
		}
		return 0;
	}

	private InputDevice TryGetDeviceByRemoteId(int remoteDeviceId, int senderIndex)
	{
		int id = FindLocalDeviceId(remoteDeviceId, senderIndex);
		return m_LocalManager.TryGetDeviceById(id);
	}

	public void RemoveRemoteDevices(int participantId)
	{
		int num = FindOrCreateSenderRecord(participantId);
		RemoteInputDevice[] devices = m_Senders[num].devices;
		if (devices != null)
		{
			RemoteInputDevice[] array = devices;
			for (int i = 0; i < array.Length; i++)
			{
				RemoteInputDevice remoteInputDevice = array[i];
				InputDevice inputDevice = m_LocalManager.TryGetDeviceById(remoteInputDevice.localId);
				if (inputDevice != null)
				{
					m_LocalManager.RemoveDevice(inputDevice);
				}
			}
		}
		ArrayHelpers.EraseAt(ref m_Senders, num);
	}

	private static byte[] SerializeData<TData>(TData data)
	{
		string s = JsonUtility.ToJson((object)data);
		return Encoding.UTF8.GetBytes(s);
	}

	private static TData DeserializeData<TData>(byte[] data)
	{
		return JsonUtility.FromJson<TData>(Encoding.UTF8.GetString(data));
	}
}
