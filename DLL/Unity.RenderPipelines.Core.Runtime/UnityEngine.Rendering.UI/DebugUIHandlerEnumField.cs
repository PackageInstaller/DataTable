using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerEnumField : DebugUIHandlerWidget
{
	public Text nextButtonText;

	public Text previousButtonText;

	public Text nameLabel;

	public Text valueLabel;

	protected internal DebugUI.EnumField m_Field;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.EnumField>();
		nameLabel.text = m_Field.displayName;
		UpdateValueLabel();
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		if (nextButtonText != null)
		{
			nextButtonText.color = colorSelected;
		}
		if (previousButtonText != null)
		{
			previousButtonText.color = colorSelected;
		}
		nameLabel.color = colorSelected;
		valueLabel.color = colorSelected;
		return true;
	}

	public override void OnDeselection()
	{
		if (nextButtonText != null)
		{
			nextButtonText.color = colorDefault;
		}
		if (previousButtonText != null)
		{
			previousButtonText.color = colorDefault;
		}
		nameLabel.color = colorDefault;
		valueLabel.color = colorDefault;
	}

	public override void OnAction()
	{
		OnIncrement(fast: false);
	}

	public override void OnIncrement(bool fast)
	{
		if (m_Field.enumValues.Length == 0)
		{
			return;
		}
		int[] enumValues = m_Field.enumValues;
		int currentIndex = m_Field.currentIndex;
		if (currentIndex == enumValues.Length - 1)
		{
			currentIndex = 0;
		}
		else if (fast)
		{
			int[] quickSeparators = m_Field.quickSeparators;
			if (quickSeparators == null)
			{
				m_Field.InitQuickSeparators();
				quickSeparators = m_Field.quickSeparators;
			}
			int i;
			for (i = 0; i < quickSeparators.Length && currentIndex + 1 > quickSeparators[i]; i++)
			{
			}
			currentIndex = ((i != quickSeparators.Length) ? quickSeparators[i] : 0);
		}
		else
		{
			currentIndex++;
		}
		m_Field.SetValue(enumValues[currentIndex]);
		m_Field.currentIndex = currentIndex;
		UpdateValueLabel();
	}

	public override void OnDecrement(bool fast)
	{
		if (m_Field.enumValues.Length == 0)
		{
			return;
		}
		int[] enumValues = m_Field.enumValues;
		int currentIndex = m_Field.currentIndex;
		if (currentIndex == 0)
		{
			if (fast)
			{
				int[] quickSeparators = m_Field.quickSeparators;
				if (quickSeparators == null)
				{
					m_Field.InitQuickSeparators();
					quickSeparators = m_Field.quickSeparators;
				}
				currentIndex = quickSeparators[quickSeparators.Length - 1];
			}
			else
			{
				currentIndex = enumValues.Length - 1;
			}
		}
		else if (fast)
		{
			int[] quickSeparators2 = m_Field.quickSeparators;
			if (quickSeparators2 == null)
			{
				m_Field.InitQuickSeparators();
				quickSeparators2 = m_Field.quickSeparators;
			}
			int num = quickSeparators2.Length - 1;
			while (num > 0 && currentIndex <= quickSeparators2[num])
			{
				num--;
			}
			currentIndex = quickSeparators2[num];
		}
		else
		{
			currentIndex--;
		}
		m_Field.SetValue(enumValues[currentIndex]);
		m_Field.currentIndex = currentIndex;
		UpdateValueLabel();
	}

	protected virtual void UpdateValueLabel()
	{
		int num = m_Field.currentIndex;
		if (num < 0)
		{
			num = 0;
		}
		string text = m_Field.enumNames[num].text;
		if (text.Length > 26)
		{
			text = text.Substring(0, 23) + "...";
		}
		valueLabel.text = text;
	}
}
