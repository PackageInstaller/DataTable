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
	[InputControl(layout = "Button")]
	public int modifier;

	[InputControl]
	public int binding;

	public bool overrideModifiersNeedToBePressedFirst;

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
		if (flag && m_BindingIsButton && !overrideModifiersNeedToBePressedFirst)
		{
			double pressTime = context.GetPressTime(binding);
			return context.GetPressTime(modifier) <= pressTime;
		}
		return flag;
	}

	protected override void FinishSetup(ref InputBindingCompositeContext context)
	{
		DetermineValueTypeAndSize(ref context, binding, out m_ValueType, out m_ValueSizeInBytes, out m_BindingIsButton);
		if (!overrideModifiersNeedToBePressedFirst)
		{
			overrideModifiersNeedToBePressedFirst = !InputSystem.settings.shortcutKeysConsumeInput;
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
