using System;
using System.ComponentModel;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayStringFormat("{modifier}+{binding}")]
[DisplayName("Binding With One Modifier")]
public class OneModifierComposite : InputBindingComposite
{
	public enum ModifiersOrder
	{
		Default,
		Ordered,
		Unordered
	}

	[InputControl(layout = "Button")]
	public int modifier;

	[InputControl]
	public int binding;

	[Tooltip("Obsolete please use modifiers Order. If enabled, this will override the Input Consumption setting, allowing the modifier keys to be pressed after the button and the composite will still trigger.")]
	[Obsolete("Use ModifiersOrder.Unordered with 'modifiersOrder' instead")]
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
		if (ModifierIsPressed(ref context))
		{
			return context.EvaluateMagnitude(binding);
		}
		return 0f;
	}

	public unsafe override void ReadValue(ref InputBindingCompositeContext context, void* buffer, int bufferSize)
	{
		if (ModifierIsPressed(ref context))
		{
			context.ReadValue(binding, buffer, bufferSize);
		}
		else
		{
			UnsafeUtility.MemClear(buffer, m_ValueSizeInBytes);
		}
	}

	private bool ModifierIsPressed(ref InputBindingCompositeContext context)
	{
		bool flag = context.ReadValueAsButton(modifier);
		if (flag && m_BindingIsButton && modifiersOrder == ModifiersOrder.Ordered)
		{
			double pressTime = context.GetPressTime(binding);
			return context.GetPressTime(modifier) <= pressTime;
		}
		return flag;
	}

	protected override void FinishSetup(ref InputBindingCompositeContext context)
	{
		DetermineValueTypeAndSize(ref context, binding, out m_ValueType, out m_ValueSizeInBytes, out m_BindingIsButton);
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
		if (context.ReadValueAsButton(modifier))
		{
			return context.ReadValueAsObject(binding);
		}
		return null;
	}

	internal static void DetermineValueTypeAndSize(ref InputBindingCompositeContext context, int part, out Type valueType, out int valueSizeInBytes, out bool isButton)
	{
		valueSizeInBytes = 0;
		isButton = true;
		Type type = null;
		foreach (InputBindingCompositeContext.PartBinding control in context.controls)
		{
			if (control.part == part)
			{
				Type type2 = control.control.valueType;
				if (type == null || type2.IsAssignableFrom(type))
				{
					type = type2;
				}
				else if (!type.IsAssignableFrom(type2))
				{
					type = typeof(Object);
				}
				valueSizeInBytes = Math.Max(control.control.valueSizeInBytes, valueSizeInBytes);
				isButton &= control.control.isButton;
			}
		}
		valueType = type;
	}
}
