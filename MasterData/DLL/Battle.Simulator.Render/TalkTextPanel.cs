using UnityEngine;
using UnityEngine.UI;

public class TalkTextPanel : MonoBehaviour
{
	public RectTransform m_rectTransform;

	public Image m_image;

	public Text m_text;

	private float _time;

	public void Init()
	{
		HideText();
	}

	public void ShowText(string pContent, float pMilliTime)
	{
		m_text.text = pContent;
		_time = pMilliTime / 1000f;
		m_image.enabled = true;
		LayoutRebuilder.ForceRebuildLayoutImmediate(m_rectTransform);
	}

	public void HideText()
	{
		m_text.text = " ";
		m_image.enabled = false;
		_time = -1f;
	}

	private void Update()
	{
		if (!(_time <= 0f))
		{
			_time -= Time.deltaTime;
			if (_time <= 0f)
			{
				HideText();
			}
		}
	}
}
