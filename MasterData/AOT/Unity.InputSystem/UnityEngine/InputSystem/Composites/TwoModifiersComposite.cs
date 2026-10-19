using System;
using System.ComponentModel;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayName("Binding With Two Modifiers")]
[DisplayStringFormat("{modifier1}+{modifier2}+{binding}")]
public class TwoModifiersComposite : InputBindingComposite
{
	public enum ModifiersOrder
	{
		Default,
		Ordered,
		Unordered
	}

	[InputControl(layout = "Button")]
	public int modifier1;

	[InputControl(layout = "Button")]
	public int modifier2;

	[InputControl]
	public int binding;

	[Obsolete("Use ModifiersOrder.Unordered with 'modifiersOrder' instead")]
	[Tooltip("Obsolete please use modifiers Order. If enabled, this will override the Input Consumption setting, allowing the modifier keys to be pressed after the button and the composite will still trigger.")]
	public bool overrideModifiersNeedToBePressedFirst;

	[Tooltip("By default it follows the Input Consumption setting to determine if the modifers keys need to be pressed first.")]
	public ModifiersOrder modifiersOrder;

	private int m_ValueSizeInBytes;

	private Type m_ValueType;

	private bool m_BindingIsButton;

	public override Type valueType => m_ValueType;

	public override int valueSizeInBytes => m_ValueSizeInBytes;

	public override float EvaluateMagnitude(ref InputBindingCompositeContext context)
	{
		if (ModifiersArePressed(ref context))
		{
			return context.EvaluateMagnitude(binding);
		}
		return 0f;
	}

	public unsafe override void ReadValue(ref InputBindingCompositeContext context, void* buffer, int bufferSize)
	{
		if (ModifiersArePressed(ref context))
		{
			context.ReadValue(binding, buffer, bufferSize);
		}
		else
		{
			UnsafeUtility.MemClear(buffer, m_ValueSizeInBytes);
		}
	}

	private bool ModifiersArePressed(ref InputBindingCompositeContext context)
	{
		bool flag = context.ReadValueAsButton(modifier1) && context.ReadValueAsButton(modifier2);
		if (flag && m_BindingIsButton && modifiersOrder == ModifiersOrder.Ordered)
		{
			double pressTime = context.GetPressTime(binding);
			double pressTime2 = context.GetPressTime(modifier1);
			double pressTime3 = context.GetPressTime(modifier2);
			if (pressTime2 <= pressTime)
			{
				return pressTime3 <= pressTime;
			}
			return false;
		}
		return flag;
	}

	protected override void FinishSetup(ref InputBindingCompositeContext context)
	{
		OneModifierComposite.DetermineValueTypeAndSize(ref context, binding, out m_ValueType, out m_ValueSizeInBytes, out m_BindingIsButton);
		if (modifiersOrder == ModifiersOrder.Default)
		{
			if (overrideModifiersNeedToBePressedFirst)
			{
				modifiersOrder = ModifiersOrder.Unordered;
			}
			else
			{
				modifiersOrder = (InputSystem.settings.shortcutKeysConsumeInput ? ModifiersOrder.Ordered : ModifiersOrder.Unordered);
			}
		}
	}

	public override object ReadValueAsObject(ref InputBindingCompositeContext context)
	{
		if (context.ReadValueAsButton(modifier1) && context.ReadValueAsButton(modifier2))
		{
			return context.ReadValueAsObject(binding);
		}
		return null;
	}
}
