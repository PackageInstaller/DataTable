using UnityEngine;
using UnityEngine.UI;

public class MonoConversationCG : MonoBehaviour
{
	public Image img;

	private static MonoConversationCG s_Instance;

	private int m_CurrentCgId;

	private Color m_ImageColor = Color.white;

	public static MonoConversationCG Instance => s_Instance;

	private void Awake()
	{
		s_Instance = this;
		ConfigureImageLayout();
		ClearImage();
	}

	private void OnDestroy()
	{
		if (s_Instance == this)
		{
			s_Instance = null;
		}
		if ((bool)img)
		{
			ClearImage();
		}
	}

	public void SetImage(int cgId, Sprite sprite)
	{
		if (cgId <= 0 || !sprite)
		{
			ClearImage();
		}
		else if (m_CurrentCgId != cgId || img.sprite != sprite)
		{
			m_CurrentCgId = cgId;
			img.sprite = sprite;
			ConfigureImageLayout();
		}
	}

	public void SetAlpha(float alpha)
	{
		m_ImageColor = img.color;
		m_ImageColor.a = Mathf.Clamp01(alpha);
		img.color = m_ImageColor;
		img.enabled = alpha > 0f && img.sprite != null;
	}

	public void ClearImage(int expectedCgId = 0)
	{
		if (expectedCgId <= 0 || m_CurrentCgId == expectedCgId)
		{
			m_CurrentCgId = 0;
			img.sprite = null;
			img.color = new Color(m_ImageColor.r, m_ImageColor.g, m_ImageColor.b, 0f);
			img.enabled = false;
		}
	}

	private void ConfigureImageLayout()
	{
		img.preserveAspect = true;
		img.raycastTarget = false;
		RectTransform rectTransform = img.rectTransform;
		rectTransform.anchorMin = Vector2.zero;
		rectTransform.anchorMax = Vector2.one;
		rectTransform.offsetMin = Vector2.zero;
		rectTransform.offsetMax = Vector2.zero;
		img.transform.SetAsFirstSibling();
	}
}
