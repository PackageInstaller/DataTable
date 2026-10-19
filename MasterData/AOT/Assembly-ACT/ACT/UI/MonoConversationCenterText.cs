using System.Collections.Generic;
using ACT.DialogueSystem;
using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoConversationCenterText : MonoBehaviour
{
	private class TextInfo
	{
		public bool Displayed;

		public bool Animating;

		public TextMeshProUGUI TMP;

		public LocalizeStringEvent LocalizeStringEvent;
	}

	public Transform ContentsGroup;

	public Transform TextPrefab;

	private List<TextInfo> m_TextInfos = new List<TextInfo>();

	public void Init()
	{
		ClearText();
	}

	public void UnInit()
	{
		ClearText();
	}

	private void PreInit(int contentCount)
	{
		for (int i = 0; i < ContentsGroup.childCount; i++)
		{
			ContentsGroup.GetChild(i).gameObject.SetActive(value: false);
		}
		for (int j = ContentsGroup.childCount; j < contentCount; j++)
		{
			Object.Instantiate(TextPrefab, ContentsGroup);
		}
	}

	public void SetText(List<CenterTextInfo> contents)
	{
		ClearText();
		PreInit(contents.Count);
		for (int i = 0; i < contents.Count; i++)
		{
			CenterTextInfo centerTextInfo = contents[i];
			GameObject gameObject = ContentsGroup.GetChild(i).gameObject;
			TextMeshProUGUI component = gameObject.GetComponent<TextMeshProUGUI>();
			LocalizeStringEvent component2 = gameObject.GetComponent<LocalizeStringEvent>();
			component2.StringReference.TableEntryReference = centerTextInfo.contentId;
			gameObject.SetActive(value: true);
			component.color = new Color(component.color.r, component.color.g, component.color.b, 0f);
			m_TextInfos.Add(new TextInfo
			{
				TMP = component,
				LocalizeStringEvent = component2
			});
		}
	}

	public void ClearText()
	{
		if (m_TextInfos != null)
		{
			foreach (TextInfo textInfo in m_TextInfos)
			{
				if ((bool)textInfo.LocalizeStringEvent)
				{
					textInfo.LocalizeStringEvent.StringReference.TableEntryReference = default;
				}
				if ((bool)textInfo.TMP)
				{
					textInfo.TMP.text = string.Empty;
					textInfo.TMP.gameObject.SetActive(value: false);
				}
			}
		}
		m_TextInfos?.Clear();
	}

	public void ShowText(int index, float speed)
	{
		if (index >= m_TextInfos.Count)
		{
			return;
		}
		TextInfo textInfo = m_TextInfos[index];
		if (!textInfo.Displayed)
		{
			textInfo.Displayed = true;
			textInfo.Animating = true;
			DOTween.Kill(textInfo.TMP, complete: true);
			textInfo.TMP.DOFade(1f, speed).OnComplete(() =>
			{
				textInfo.Animating = false;
			}).SetId(textInfo.TMP);
		}
	}

	public void ShowAllText(float speed)
	{
		for (int i = 0; i < m_TextInfos.Count; i++)
		{
			ShowText(i, speed);
		}
	}

	public void HideText(int index, float speed)
	{
		if (index >= m_TextInfos.Count)
		{
			return;
		}
		TextInfo textInfo = m_TextInfos[index];
		if (textInfo.Displayed)
		{
			textInfo.Displayed = false;
			textInfo.Animating = true;
			DOTween.Kill(textInfo.TMP, complete: true);
			textInfo.TMP.DOFade(0f, speed).OnComplete(() =>
			{
				textInfo.Animating = false;
			}).SetId(textInfo.TMP);
		}
	}

	public void HideAllText(float speed)
	{
		for (int i = 0; i < m_TextInfos.Count; i++)
		{
			HideText(i, speed);
		}
	}

	public bool IsAnimating(int index)
	{
		if (index >= m_TextInfos.Count)
		{
			return false;
		}
		return m_TextInfos[index].Animating;
	}

	public void FinishAnimating(int index)
	{
		if (index < m_TextInfos.Count)
		{
			m_TextInfos[index].TMP.DOComplete();
		}
	}
}
