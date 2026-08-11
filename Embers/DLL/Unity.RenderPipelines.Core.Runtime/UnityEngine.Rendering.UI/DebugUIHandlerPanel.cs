using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerPanel : MonoBehaviour
{
	public Text nameLabel;

	public ScrollRect scrollRect;

	public RectTransform viewport;

	public DebugUIHandlerCanvas Canvas;

	private RectTransform m_ScrollTransform;

	private RectTransform m_ContentTransform;

	private RectTransform m_MaskTransform;

	private DebugUIHandlerWidget m_ScrollTarget;

	protected internal DebugUI.Panel m_Panel;

	private void OnEnable()
	{
		m_ScrollTransform = scrollRect.GetComponent<RectTransform>();
		m_ContentTransform = GetComponent<DebugUIHandlerContainer>().contentHolder;
		m_MaskTransform = GetComponentInChildren<Mask>(includeInactive: true).rectTransform;
	}

	internal void SetPanel(DebugUI.Panel panel)
	{
		m_Panel = panel;
		nameLabel.text = panel.displayName;
	}

	internal DebugUI.Panel GetPanel()
	{
		return m_Panel;
	}

	public void SelectNextItem()
	{
		Canvas.SelectNextPanel();
	}

	public void SelectPreviousItem()
	{
		Canvas.SelectPreviousPanel();
	}

	public void OnScrollbarClicked()
	{
		DebugManager.instance.SetScrollTarget(null);
	}

	internal void SetScrollTarget(DebugUIHandlerWidget target)
	{
		m_ScrollTarget = target;
	}

	internal void UpdateScroll()
	{
		if (!(m_ScrollTarget == null))
		{
			RectTransform component = m_ScrollTarget.GetComponent<RectTransform>();
			float yPosInScroll = GetYPosInScroll(component);
			float num = (GetYPosInScroll(m_MaskTransform) - yPosInScroll) / (m_ContentTransform.rect.size.y - m_ScrollTransform.rect.size.y);
			float value = scrollRect.verticalNormalizedPosition - num;
			value = Mathf.Clamp01(value);
			scrollRect.verticalNormalizedPosition = Mathf.Lerp(scrollRect.verticalNormalizedPosition, value, Time.deltaTime * 10f);
		}
	}

	private float GetYPosInScroll(RectTransform target)
	{
		Vector3 vector = new Vector3((0.5f - target.pivot.x) * target.rect.size.x, (0.5f - target.pivot.y) * target.rect.size.y, 0f);
		Vector3 position = target.localPosition + vector;
		Vector3 position2 = target.parent.TransformPoint(position);
		return m_ScrollTransform.TransformPoint(position2).y;
	}

	internal DebugUIHandlerWidget GetFirstItem()
	{
		return GetComponent<DebugUIHandlerContainer>().GetFirstItem();
	}

	public void ResetDebugManager()
	{
		DebugManager.instance.Reset();
	}
}
