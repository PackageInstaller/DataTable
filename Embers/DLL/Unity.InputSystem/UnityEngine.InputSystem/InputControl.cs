using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[DebuggerDisplay("{DebuggerDisplay(),nq}")]
public abstract class InputControl
{
	[Flags]
	internal enum ControlFlags
	{
		ConfigUpToDate = 1,
		IsNoisy = 2,
		IsSynthetic = 4,
		IsButton = 8,
		DontReset = 0x10,
		SetupFinished = 0x20,
		UsesStateFromOtherControl = 0x40
	}

	protected internal InputStateBlock m_StateBlock;

	internal InternedString m_Name;

	internal string m_Path;

	internal string m_DisplayName;

	internal string m_DisplayNameFromLayout;

	internal string m_ShortDisplayName;

	internal string m_ShortDisplayNameFromLayout;

	internal InternedString m_Layout;

	internal InternedString m_Variants;

	internal InputDevice m_Device;

	internal InputControl m_Parent;

	internal int m_UsageCount;

	internal int m_UsageStartIndex;

	internal int m_AliasCount;

	internal int m_AliasStartIndex;

	internal int m_ChildCount;

	internal int m_ChildStartIndex;

	internal ControlFlags m_ControlFlags;

	internal bool m_CachedValueIsStale = true;

	internal bool m_UnprocessedCachedValueIsStale = true;

	internal PrimitiveValue m_DefaultState;

	internal PrimitiveValue m_MinValue;

	internal PrimitiveValue m_MaxValue;

	internal FourCC m_OptimizedControlDataType;

	public string name => m_Name;

	public string displayName
	{
		get
		{
			RefreshConfigurationIfNeeded();
			if (m_DisplayName != null)
			{
				return m_DisplayName;
			}
			if (m_DisplayNameFromLayout != null)
			{
				return m_DisplayNameFromLayout;
			}
			return m_Name;
		}
		protected set
		{
			m_DisplayName = value;
		}
	}

	public string shortDisplayName
	{
		get
		{
			RefreshConfigurationIfNeeded();
			if (m_ShortDisplayName != null)
			{
				return m_ShortDisplayName;
			}
			if (m_ShortDisplayNameFromLayout != null)
			{
				return m_ShortDisplayNameFromLayout;
			}
			return null;
		}
		protected set
		{
			m_ShortDisplayName = value;
		}
	}

	public string path
	{
		get
		{
			if (m_Path == null)
			{
				m_Path = InputControlPath.Combine(m_Parent, m_Name);
			}
			return m_Path;
		}
	}

	public string layout => m_Layout;

	public string variants => m_Variants;

	public InputDevice device => m_Device;

	public InputControl parent => m_Parent;

	public ReadOnlyArray<InputControl> children => new ReadOnlyArray<InputControl>(m_Device.m_ChildrenForEachControl, m_ChildStartIndex, m_ChildCount);

	public ReadOnlyArray<InternedString> usages => new ReadOnlyArray<InternedString>(m_Device.m_UsagesForEachControl, m_UsageStartIndex, m_UsageCount);

	public ReadOnlyArray<InternedString> aliases => new ReadOnlyArray<InternedString>(m_Device.m_AliasesForEachControl, m_AliasStartIndex, m_AliasCount);

	public InputStateBlock stateBlock => m_StateBlock;

	public bool noisy
	{
		get
		{
			return (m_ControlFlags & ControlFlags.IsNoisy) != 0;
		}
		internal set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.IsNoisy;
				ReadOnlyArray<InputControl> readOnlyArray = children;
				for (int i = 0; i < readOnlyArray.Count; i++)
				{
					if (readOnlyArray[i] != null)
					{
						readOnlyArray[i].noisy = true;
					}
				}
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.IsNoisy;
			}
		}
	}

	public bool synthetic
	{
		get
		{
			return (m_ControlFlags & ControlFlags.IsSynthetic) != 0;
		}
		internal set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.IsSynthetic;
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.IsSynthetic;
			}
		}
	}

	public InputControl this[string path] => InputControlPath.TryFindChild(this, path) ?? throw new KeyNotFoundException($"Cannot find control '{path}' as child of '{this}'");

	public abstract Type valueType { get; }

	public abstract int valueSizeInBytes { get; }

	public float magnitude => EvaluateMagnitude();

	protected internal unsafe void* currentStatePtr => InputStateBuffers.GetFrontBufferForDevice(GetDeviceIndex());

	protected internal unsafe void* previousFrameStatePtr => InputStateBuffers.GetBackBufferForDevice(GetDeviceIndex());

	protected internal unsafe void* defaultStatePtr => InputStateBuffers.s_DefaultStateBuffer;

	protected internal unsafe void* noiseMaskPtr => InputStateBuffers.s_NoiseMaskBuffer;

	protected internal uint stateOffsetRelativeToDeviceRoot
	{
		get
		{
			uint byteOffset = device.m_StateBlock.byteOffset;
			return m_StateBlock.byteOffset - byteOffset;
		}
	}

	public FourCC optimizedControlDataType => m_OptimizedControlDataType;

	internal bool isSetupFinished
	{
		get
		{
			return (m_ControlFlags & ControlFlags.SetupFinished) == ControlFlags.SetupFinished;
		}
		set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.SetupFinished;
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.SetupFinished;
			}
		}
	}

	internal bool isButton
	{
		get
		{
			return (m_ControlFlags & ControlFlags.IsButton) == ControlFlags.IsButton;
		}
		set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.IsButton;
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.IsButton;
			}
		}
	}

	internal bool isConfigUpToDate
	{
		get
		{
			return (m_ControlFlags & ControlFlags.ConfigUpToDate) == ControlFlags.ConfigUpToDate;
		}
		set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.ConfigUpToDate;
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.ConfigUpToDate;
			}
		}
	}

	internal bool dontReset
	{
		get
		{
			return (m_ControlFlags & ControlFlags.DontReset) == ControlFlags.DontReset;
		}
		set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.DontReset;
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.DontReset;
			}
		}
	}

	internal bool usesStateFromOtherControl
	{
		get
		{
			return (m_ControlFlags & ControlFlags.UsesStateFromOtherControl) == ControlFlags.UsesStateFromOtherControl;
		}
		set
		{
			if (value)
			{
				m_ControlFlags |= ControlFlags.UsesStateFromOtherControl;
			}
			else
			{
				m_ControlFlags &= ~ControlFlags.UsesStateFromOtherControl;
			}
		}
	}

	internal bool hasDefaultState => !m_DefaultState.isEmpty;

	public override string ToString()
	{
		return layout + ":" + path;
	}

	private string DebuggerDisplay()
	{
		if (!device.added)
		{
			return ToString();
		}
		try
		{
			return $"{layout}:{path}={this.ReadValueAsObject()}";
		}
		catch (Exception)
		{
			return ToString();
		}
	}

	public unsafe float EvaluateMagnitude()
	{
		return EvaluateMagnitude(currentStatePtr);
	}

	public unsafe virtual float EvaluateMagnitude(void* statePtr)
	{
		return -1f;
	}

	public unsafe abstract object ReadValueFromBufferAsObject(void* buffer, int bufferSize);

	public unsafe abstract object ReadValueFromStateAsObject(void* statePtr);

	public unsafe abstract void ReadValueFromStateIntoBuffer(void* statePtr, void* bufferPtr, int bufferSize);

	public unsafe virtual void WriteValueFromBufferIntoState(void* bufferPtr, int bufferSize, void* statePtr)
	{
		throw new NotSupportedException($"Control '{this}' does not support writing");
	}

	public unsafe virtual void WriteValueFromObjectIntoState(object value, void* statePtr)
	{
		throw new NotSupportedException($"Control '{this}' does not support writing");
	}

	public unsafe abstract bool CompareValue(void* firstStatePtr, void* secondStatePtr);

	public InputControl TryGetChildControl(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			throw new ArgumentNullException("path");
		}
		return InputControlPath.TryFindChild(this, path);
	}

	public TControl TryGetChildControl<TControl>(string path) where TControl : InputControl
	{
		if (string.IsNullOrEmpty(path))
		{
			throw new ArgumentNullException("path");
		}
		InputControl inputControl = TryGetChildControl(path);
		if (inputControl == null)
		{
			return null;
		}
		if (!(inputControl is TControl result))
		{
			throw new InvalidOperationException("Expected control '" + path + "' to be of type '" + typeof(TControl).Name + "' but is of type '" + inputControl.GetType().Name + "' instead!");
		}
		return result;
	}

	public InputControl GetChildControl(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			throw new ArgumentNullException("path");
		}
		return TryGetChildControl(path) ?? throw new ArgumentException("Cannot find input control '" + MakeChildPath(path) + "'", "path");
	}

	public TControl GetChildControl<TControl>(string path) where TControl : InputControl
	{
		InputControl childControl = GetChildControl(path);
		if (!(childControl is TControl result))
		{
			throw new ArgumentException("Expected control '" + path + "' to be of type '" + typeof(TControl).Name + "' but is of type '" + childControl.GetType().Name + "' instead!", "path");
		}
		return result;
	}

	protected InputControl()
	{
		m_StateBlock.byteOffset = 4294967294u;
	}

	protected virtual void FinishSetup()
	{
	}

	protected void RefreshConfigurationIfNeeded()
	{
		if (!isConfigUpToDate)
		{
			RefreshConfiguration();
			isConfigUpToDate = true;
		}
	}

	protected virtual void RefreshConfiguration()
	{
	}

	protected virtual FourCC CalculateOptimizedControlDataType()
	{
		return 0;
	}

	public void ApplyParameterChanges()
	{
		SetOptimizedControlDataTypeRecursively();
		for (InputControl inputControl = parent; inputControl != null; inputControl = inputControl.parent)
		{
			inputControl.SetOptimizedControlDataType();
		}
		MarkAsStaleRecursively();
	}

	[MethodImpl((MethodImplOptions)256)]
	private void SetOptimizedControlDataType()
	{
		m_OptimizedControlDataType = (InputSettings.optimizedControlsFeatureEnabled ? CalculateOptimizedControlDataType() : ((FourCC)0));
	}

	[MethodImpl((MethodImplOptions)256)]
	internal void SetOptimizedControlDataTypeRecursively()
	{
		if (m_ChildCount > 0)
		{
			foreach (InputControl child in children)
			{
				child.SetOptimizedControlDataTypeRecursively();
			}
		}
		SetOptimizedControlDataType();
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("DEVELOPMENT_BUILD")]
	[Conditional("UNITY_EDITOR")]
	internal void EnsureOptimizationTypeHasNotChanged()
	{
		if (!InputSettings.optimizedControlsFeatureEnabled)
		{
			return;
		}
		FourCC fourCC = CalculateOptimizedControlDataType();
		if (fourCC != optimizedControlDataType)
		{
			Debug.LogError("Control '" + name + "' / '" + path + "' suddenly changed optimization state due to either format " + $"change or control parameters change (was '{optimizedControlDataType}' but became '{fourCC}'), " + "this hinders control hot path optimization, please call control.ApplyParameterChanges() after the changes to the control to fix this error.");
			m_OptimizedControlDataType = fourCC;
		}
		if (m_ChildCount <= 0)
		{
			return;
		}
		foreach (InputControl child in children)
		{
			_ = child;
		}
	}

	internal void CallFinishSetupRecursive()
	{
		ReadOnlyArray<InputControl> readOnlyArray = children;
		for (int i = 0; i < readOnlyArray.Count; i++)
		{
			readOnlyArray[i].CallFinishSetupRecursive();
		}
		FinishSetup();
		SetOptimizedControlDataTypeRecursively();
	}

	internal string MakeChildPath(string path)
	{
		if (this is InputDevice)
		{
			return path;
		}
		return this.path + "/" + path;
	}

	internal void BakeOffsetIntoStateBlockRecursive(uint offset)
	{
		m_StateBlock.byteOffset += offset;
		ReadOnlyArray<InputControl> readOnlyArray = children;
		for (int i = 0; i < readOnlyArray.Count; i++)
		{
			readOnlyArray[i].BakeOffsetIntoStateBlockRecursive(offset);
		}
	}

	internal int GetDeviceIndex()
	{
		int deviceIndex = m_Device.m_DeviceIndex;
		if (deviceIndex == -1)
		{
			throw new InvalidOperationException("Cannot query value of control '" + path + "' before '" + device.name + "' has been added to system!");
		}
		return deviceIndex;
	}

	internal bool IsValueConsideredPressed(float value)
	{
		if (isButton)
		{
			return ((ButtonControl)this).IsValueConsideredPressed(value);
		}
		return value >= ButtonControl.s_GlobalDefaultButtonPressPoint;
	}

	internal virtual void AddProcessor(object first)
	{
	}

	internal void MarkAsStale()
	{
		m_CachedValueIsStale = true;
		m_UnprocessedCachedValueIsStale = true;
	}

	internal void MarkAsStaleRecursively()
	{
		MarkAsStale();
		foreach (InputControl child in children)
		{
			child.MarkAsStale();
		}
	}
}
public abstract class InputControl<TValue> : InputControl where TValue : struct
{
	internal InlinedArray<InputProcessor<TValue>> m_ProcessorStack;

	private TValue m_CachedValue;

	private TValue m_UnprocessedCachedValue;

	internal bool evaluateProcessorsEveryRead;

	public override Type valueType => typeof(TValue);

	public override int valueSizeInBytes => UnsafeUtility.SizeOf<TValue>();

	public ref readonly TValue value
	{
		get
		{
			if (!InputSettings.readValueCachingFeatureEnabled || m_CachedValueIsStale || evaluateProcessorsEveryRead)
			{
				m_CachedValue = ProcessValue(unprocessedValue);
				m_CachedValueIsStale = false;
			}
			return ref m_CachedValue;
		}
	}

	internal unsafe ref readonly TValue unprocessedValue
	{
		get
		{
			if (!InputSettings.readValueCachingFeatureEnabled || m_UnprocessedCachedValueIsStale)
			{
				m_UnprocessedCachedValue = ReadUnprocessedValueFromState(base.currentStatePtr);
				m_UnprocessedCachedValueIsStale = false;
			}
			return ref m_UnprocessedCachedValue;
		}
	}

	internal InputProcessor<TValue>[] processors => m_ProcessorStack.ToArray();

	public TValue ReadValue()
	{
		return value;
	}

	public unsafe TValue ReadValueFromPreviousFrame()
	{
		return ReadValueFromState(base.previousFrameStatePtr);
	}

	public unsafe TValue ReadDefaultValue()
	{
		return ReadValueFromState(base.defaultStatePtr);
	}

	public unsafe TValue ReadValueFromState(void* statePtr)
	{
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		return ProcessValue(ReadUnprocessedValueFromState(statePtr));
	}

	public unsafe TValue ReadValueFromStateWithCaching(void* statePtr)
	{
		if (statePtr != base.currentStatePtr)
		{
			return ReadValueFromState(statePtr);
		}
		return value;
	}

	public unsafe TValue ReadUnprocessedValueFromStateWithCaching(void* statePtr)
	{
		if (statePtr != base.currentStatePtr)
		{
			return ReadUnprocessedValueFromState(statePtr);
		}
		return unprocessedValue;
	}

	public TValue ReadUnprocessedValue()
	{
		return unprocessedValue;
	}

	public unsafe abstract TValue ReadUnprocessedValueFromState(void* statePtr);

	public unsafe override object ReadValueFromStateAsObject(void* statePtr)
	{
		return ReadValueFromState(statePtr);
	}

	public unsafe override void ReadValueFromStateIntoBuffer(void* statePtr, void* bufferPtr, int bufferSize)
	{
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		if (bufferPtr == null)
		{
			throw new ArgumentNullException("bufferPtr");
		}
		int num = UnsafeUtility.SizeOf<TValue>();
		if (bufferSize < num)
		{
			throw new ArgumentException($"bufferSize={bufferSize} < sizeof(TValue)={num}", "bufferSize");
		}
		TValue output = ReadValueFromState(statePtr);
		void* source = UnsafeUtility.AddressOf(ref output);
		UnsafeUtility.MemCpy(bufferPtr, source, num);
	}

	public unsafe override void WriteValueFromBufferIntoState(void* bufferPtr, int bufferSize, void* statePtr)
	{
		if (bufferPtr == null)
		{
			throw new ArgumentNullException("bufferPtr");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		int num = UnsafeUtility.SizeOf<TValue>();
		if (bufferSize < num)
		{
			throw new ArgumentException($"bufferSize={bufferSize} < sizeof(TValue)={num}", "bufferSize");
		}
		TValue output = default(TValue);
		UnsafeUtility.MemCpy(UnsafeUtility.AddressOf(ref output), bufferPtr, num);
		WriteValueIntoState(output, statePtr);
	}

	public unsafe override void WriteValueFromObjectIntoState(object value, void* statePtr)
	{
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (!(value is TValue))
		{
			value = Convert.ChangeType(value, typeof(TValue));
		}
		TValue val = (TValue)value;
		WriteValueIntoState(val, statePtr);
	}

	public unsafe virtual void WriteValueIntoState(TValue value, void* statePtr)
	{
		throw new NotSupportedException($"Control '{this}' does not support writing");
	}

	public unsafe override object ReadValueFromBufferAsObject(void* buffer, int bufferSize)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = UnsafeUtility.SizeOf<TValue>();
		if (bufferSize < num)
		{
			throw new ArgumentException($"Expecting buffer of at least {num} bytes for value of type {typeof(TValue).Name} but got buffer of only {bufferSize} bytes instead", "bufferSize");
		}
		TValue output = default(TValue);
		UnsafeUtility.MemCpy(UnsafeUtility.AddressOf(ref output), buffer, num);
		return output;
	}

	private unsafe static bool CompareValue(ref TValue firstValue, ref TValue secondValue)
	{
		void* ptr = UnsafeUtility.AddressOf(ref firstValue);
		void* ptr2 = UnsafeUtility.AddressOf(ref secondValue);
		return UnsafeUtility.MemCmp(ptr, ptr2, UnsafeUtility.SizeOf<TValue>()) != 0;
	}

	public unsafe override bool CompareValue(void* firstStatePtr, void* secondStatePtr)
	{
		TValue firstValue = ReadValueFromState(firstStatePtr);
		TValue secondValue = ReadValueFromState(secondStatePtr);
		return CompareValue(ref firstValue, ref secondValue);
	}

	[MethodImpl((MethodImplOptions)256)]
	public TValue ProcessValue(TValue value)
	{
		ProcessValue(ref value);
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void ProcessValue(ref TValue value)
	{
		if (m_ProcessorStack.length <= 0)
		{
			return;
		}
		value = m_ProcessorStack.firstValue.Process(value, this);
		if (m_ProcessorStack.additionalValues != null)
		{
			for (int i = 0; i < m_ProcessorStack.length - 1; i++)
			{
				value = m_ProcessorStack.additionalValues[i].Process(value, this);
			}
		}
	}

	internal TProcessor TryGetProcessor<TProcessor>() where TProcessor : InputProcessor<TValue>
	{
		if (m_ProcessorStack.length > 0)
		{
			if (m_ProcessorStack.firstValue is TProcessor result)
			{
				return result;
			}
			if (m_ProcessorStack.additionalValues != null)
			{
				for (int i = 0; i < m_ProcessorStack.length - 1; i++)
				{
					if (m_ProcessorStack.additionalValues[i] is TProcessor result2)
					{
						return result2;
					}
				}
			}
		}
		return null;
	}

	internal override void AddProcessor(object processor)
	{
		if (!(processor is InputProcessor<TValue> inputProcessor))
		{
			throw new ArgumentException("Cannot add processor of type '" + processor.GetType().Name + "' to control of type '" + GetType().Name + "'", "processor");
		}
		m_ProcessorStack.Append(inputProcessor);
	}

	protected override void FinishSetup()
	{
		foreach (InputProcessor<TValue> item in m_ProcessorStack)
		{
			if (item.cachingPolicy == InputProcessor.CachingPolicy.EvaluateOnEveryRead)
			{
				evaluateProcessorsEveryRead = true;
			}
		}
		base.FinishSetup();
	}
}
