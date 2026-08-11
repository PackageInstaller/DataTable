using System.Collections;
using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerToggleHistory : DebugUIHandlerToggle
{
	private Toggle[] historyToggles;

	private const float xDecal = 60f;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		int num = (widget as DebugUI.HistoryBoolField)?.historyDepth ?? 0;
		historyToggles = new Toggle[num];
		for (int i = 0; i < num; i++)
		{
			Toggle toggle = Object.Instantiate(valueToggle, base.transform);
			Vector3 position = toggle.transform.position;
			position.x += (float)(i + 1) * 60f;
			toggle.transform.position = position;
			Image component = toggle.transform.GetChild(0).GetComponent<Image>();
			component.sprite = Sprite.Create(Texture2D.whiteTexture, new Rect(-1f, -1f, 2f, 2f), Vector2.zero);
			component.color = new Color32(50, 50, 50, 120);
			component.transform.GetChild(0).GetComponent<Image>().color = new Color32(110, 110, 110, byte.MaxValue);
			historyToggles[i] = toggle.GetComponent<Toggle>();
		}
		base.SetWidget(widget);
	}

	protected internal override void UpdateValueLabel()
	{
		base.UpdateValueLabel();
		DebugUI.HistoryBoolField historyBoolField = m_Field as DebugUI.HistoryBoolField;
		int num = historyBoolField?.historyDepth ?? 0;
		for (int i = 0; i < num; i++)
		{
			if (i < historyToggles.Length && historyToggles[i] != null)
			{
				historyToggles[i].isOn = historyBoolField.GetHistoryValue(i);
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
		valueToggle.isOn = m_Field.getter();
	}
}
