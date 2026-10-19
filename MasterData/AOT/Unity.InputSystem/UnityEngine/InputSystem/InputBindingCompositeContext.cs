using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace UnityEngine.InputSystem;

public struct InputBindingCompositeContext
{
	public struct PartBinding
	{
		public int part { get; set; }

		public InputControl control { get; set; }
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct DefaultComparer<TValue> : IComparer<TValue> where TValue : IComparable<TValue>
	{
		public int Compare(TValue x, TValue y)
		{
			return x.CompareTo(y);
		}
	}

	internal InputActionState m_State;

	internal int m_BindingIndex;

	public IEnumerable<PartBinding> controls
	{
		get
		{
			if (m_State == null)
			{
				yield break;
			}
			int totalBindingCount = m_State.totalBindingCount;
			int bindingIndex = m_BindingIndex + 1;
			while (bindingIndex < totalBindingCount)
			{
				InputActionState.BindingState bindingState = m_State.GetBindingState(bindingIndex);
				if (bindingState.isPartOfComposite)
				{
					int controlStartIndex = bindingState.controlStartIndex;
					int num;
					for (int i = 0; i < bindingState.controlCount; i = num)
					{
						InputControl control = m_State.controls[controlStartIndex + i];
						yield return new PartBinding
						{
							part = bindingState.partIndex,
							control = control
						};
						num = i + 1;
					}
					num = bindingIndex + 1;
					bindingIndex = num;
					continue;
				}
				break;
			}
		}
	}

	public float EvaluateMagnitude(int partNumber)
	{
		return m_State.EvaluateCompositePartMagnitude(m_BindingIndex, partNumber);
	}

	public unsafe TValue ReadValue<TValue>(int partNumber) where TValue : struct, IComparable<TValue>
	{
		if (m_State == null)
		{
			return default;
		}
		int controlIndex;
		return m_State.ReadCompositePartValue<TValue, DefaultComparer<TValue>>(m_BindingIndex, partNumber, null, out controlIndex);
	}

	public unsafe TValue ReadValue<TValue>(int partNumber, out InputControl sourceControl) where TValue : struct, IComparable<TValue>
	{
		if (m_State == null)
		{
			sourceControl = null;
			return default;
		}
		TValue result = m_State.ReadCompositePartValue<TValue, DefaultComparer<TValue>>(m_BindingIndex, partNumber, null, out var controlIndex);
		if (controlIndex != -1)
		{
			sourceControl = m_State.controls[controlIndex];
			return result;
		}
		sourceControl = null;
		return result;
	}

	public unsafe TValue ReadValue<TValue, TComparer>(int partNumber, TComparer comparer = default(TComparer)) where TValue : struct where TComparer : IComparer<TValue>
	{
		if (m_State == null)
		{
			return default;
		}
		int controlIndex;
		return m_State.ReadCompositePartValue<TValue, TComparer>(m_BindingIndex, partNumber, null, out controlIndex, comparer);
	}

	public unsafe TValue ReadValue<TValue, TComparer>(int partNumber, out InputControl sourceControl, TComparer comparer = default(TComparer)) where TValue : struct where TComparer : IComparer<TValue>
	{
		if (m_State == null)
		{
			sourceControl = null;
			return default;
		}
		TValue result = m_State.ReadCompositePartValue<TValue, TComparer>(m_BindingIndex, partNumber, null, out var controlIndex, comparer);
		if (controlIndex != -1)
		{
			sourceControl = m_State.controls[controlIndex];
			return result;
		}
		sourceControl = null;
		return result;
	}

	public unsafe bool ReadValueAsButton(int partNumber)
	{
		if (m_State == null)
		{
			return false;
		}
		bool result = false;
		m_State.ReadCompositePartValue<float, DefaultComparer<float>>(m_BindingIndex, partNumber, &result, out var _);
		return result;
	}

	public unsafe void ReadValue(int partNumber, void* buffer, int bufferSize)
	{
		m_State?.ReadCompositePartValue(m_BindingIndex, partNumber, buffer, bufferSize);
	}

	public object ReadValueAsObject(int partNumber)
	{
		return m_State.ReadCompositePartValueAsObject(m_BindingIndex, partNumber);
	}

	public double GetPressTime(int partNumber)
	{
		return m_State.GetCompositePartPressTime(m_BindingIndex, partNumber);
	}
}
