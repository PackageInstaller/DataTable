using System;
using System.Collections.Generic;
using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerBitField : DebugUIHandlerWidget
{
	public Text nameLabel;

	public UIFoldout valueToggle;

	public List<DebugUIHandlerIndirectToggle> toggles;

	private DebugUI.BitField m_Field;

	private DebugUIHandlerContainer m_Container;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.BitField>();
		m_Container = GetComponent<DebugUIHandlerContainer>();
		nameLabel.text = m_Field.displayName;
		int i = 0;
		GUIContent[] enumNames = m_Field.enumNames;
		foreach (GUIContent val in enumNames)
		{
			if (i < toggles.Count)
			{
				DebugUIHandlerIndirectToggle debugUIHandlerIndirectToggle = toggles[i];
				debugUIHandlerIndirectToggle.getter = GetValue;
				debugUIHandlerIndirectToggle.setter = SetValue;
				debugUIHandlerIndirectToggle.nextUIHandler = ((i < m_Field.enumNames.Length - 1) ? toggles[i + 1] : null);
				debugUIHandlerIndirectToggle.previousUIHandler = ((i > 0) ? toggles[i - 1] : null);
				debugUIHandlerIndirectToggle.parentUIHandler = this;
				debugUIHandlerIndirectToggle.index = i;
				debugUIHandlerIndirectToggle.nameLabel.text = val.text;
				debugUIHandlerIndirectToggle.Init();
				i++;
			}
		}
		for (; i < toggles.Count; i++)
		{
			CoreUtils.Destroy(toggles[i].gameObject);
			toggles[i] = null;
		}
	}

	private bool GetValue(int index)
	{
		if (index == 0)
		{
			return false;
		}
		index--;
		return (Convert.ToInt32(m_Field.GetValue()) & (1 << index)) != 0;
	}

	private void SetValue(int index, bool value)
	{
		if (index == 0)
		{
			m_Field.SetValue(Enum.ToObject(m_Field.enumType, 0));
			{
				foreach (DebugUIHandlerIndirectToggle toggle in toggles)
				{
					if ((object)toggle != null && toggle.getter != null)
					{
						toggle.UpdateValueLabel();
					}
				}
				return;
			}
		}
		int num = Convert.ToInt32(m_Field.GetValue());
		num = ((!value) ? (num & ~m_Field.enumValues[index]) : (num | m_Field.enumValues[index]));
		m_Field.SetValue(Enum.ToObject(m_Field.enumType, num));
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		if (fromNext || !valueToggle.isOn)
		{
			nameLabel.color = colorSelected;
		}
		else if (valueToggle.isOn)
		{
			if (m_Container.IsDirectChild(previous))
			{
				nameLabel.color = colorSelected;
			}
			else
			{
				DebugUIHandlerWidget lastItem = m_Container.GetLastItem();
				DebugManager.instance.ChangeSelection(lastItem, fromNext: false);
			}
		}
		return true;
	}

	public override void OnDeselection()
	{
		nameLabel.color = colorDefault;
	}

	public override void OnIncrement(bool fast)
	{
		valueToggle.isOn = true;
	}

	public override void OnDecrement(bool fast)
	{
		valueToggle.isOn = false;
	}

	public override void OnAction()
	{
		valueToggle.isOn = !valueToggle.isOn;
	}

	public override DebugUIHandlerWidget Next()
	{
		if (!valueToggle.isOn || m_Container == null)
		{
			return base.Next();
		}
		DebugUIHandlerWidget firstItem = m_Container.GetFirstItem();
		if (firstItem == null)
		{
			return base.Next();
		}
		return firstItem;
	}
}
