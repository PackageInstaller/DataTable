using System.Collections;
using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerEnumHistory : DebugUIHandlerEnumField
{
	private Text[] historyValues;

	private const float xDecal = 60f;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		int num = (widget as DebugUI.HistoryEnumField)?.historyDepth ?? 0;
		historyValues = new Text[num];
		for (int i = 0; i < num; i++)
		{
			Text text = Object.Instantiate(valueLabel, base.transform);
			Vector3 position = text.transform.position;
			position.x += (float)(i + 1) * 60f;
			text.transform.position = position;
			Text component = text.GetComponent<Text>();
			component.color = new Color32(110, 110, 110, byte.MaxValue);
			historyValues[i] = component;
		}
		base.SetWidget(widget);
	}

	protected override void UpdateValueLabel()
	{
		int num = m_Field.currentIndex;
		if (num < 0)
		{
			num = 0;
		}
		valueLabel.text = m_Field.enumNames[num].text;
		DebugUI.HistoryEnumField historyEnumField = m_Field as DebugUI.HistoryEnumField;
		int num2 = historyEnumField?.historyDepth ?? 0;
		for (int i = 0; i < num2; i++)
		{
			if (i < historyValues.Length && historyValues[i] != null)
			{
				historyValues[i].text = historyEnumField.enumNames[historyEnumField.GetHistoryValue(i)].text;
			}
		}
		if (base.isActiveAndEnabled)
		{
			StartCoroutine(RefreshAfterSanitization());
		}
	}

	private IEnumerator RefreshAfterSanitization()
	{
		yield return null;
		m_Field.currentIndex = m_Field.getIndex();
		valueLabel.text = m_Field.enumNames[m_Field.currentIndex].text;
	}
}
