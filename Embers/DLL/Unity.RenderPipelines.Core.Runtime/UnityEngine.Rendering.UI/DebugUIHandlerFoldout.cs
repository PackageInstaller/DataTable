using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerFoldout : DebugUIHandlerWidget
{
	public Text nameLabel;

	public UIFoldout valueToggle;

	private DebugUI.Foldout m_Field;

	private DebugUIHandlerContainer m_Container;

	private const float xDecal = 60f;

	private const float xDecalInit = 230f;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.Foldout>();
		m_Container = GetComponent<DebugUIHandlerContainer>();
		nameLabel.text = m_Field.displayName;
		string[] columnLabels = m_Field.columnLabels;
		int num = ((columnLabels != null) ? columnLabels.Length : 0);
		for (int i = 0; i < num; i++)
		{
			GameObject obj = Object.Instantiate(nameLabel.gameObject, GetComponent<DebugUIHandlerContainer>().contentHolder);
			obj.AddComponent<LayoutElement>().ignoreLayout = true;
			RectTransform obj2 = obj.transform as RectTransform;
			RectTransform rectTransform = nameLabel.transform as RectTransform;
			Vector2 anchorMax = (obj2.anchorMin = new Vector2(0f, 1f));
			obj2.anchorMax = anchorMax;
			obj2.sizeDelta = new Vector2(100f, 26f);
			Vector3 vector2 = rectTransform.anchoredPosition;
			vector2.x += (float)(i + 1) * 60f + 230f;
			obj2.anchoredPosition = vector2;
			obj2.pivot = new Vector2(0f, 0.5f);
			obj2.eulerAngles = new Vector3(0f, 0f, 13f);
			Text component = obj.GetComponent<Text>();
			component.fontSize = 15;
			component.text = m_Field.columnLabels[i];
		}
		UpdateValue();
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
		m_Field.SetValue(value: true);
		UpdateValue();
	}

	public override void OnDecrement(bool fast)
	{
		m_Field.SetValue(value: false);
		UpdateValue();
	}

	public override void OnAction()
	{
		bool value = !m_Field.GetValue();
		m_Field.SetValue(value);
		UpdateValue();
	}

	private void UpdateValue()
	{
		valueToggle.isOn = m_Field.GetValue();
	}

	public override DebugUIHandlerWidget Next()
	{
		if (!m_Field.GetValue() || m_Container == null)
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
