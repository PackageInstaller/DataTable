using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoHorizontalReadView : BaseUIView
{
	public class HorizontalReadViewData
	{
		public List<HorizontalInfo> infos;

		public Action onClose;
	}

	[Header("文字")]
	public LocalizeStringEvent title;

	public LocalizeStringEvent content;

	public LayoutGroup layout;

	public Image image;

	public Sprite normal;

	public Sprite select;

	[Header("预制")]
	public GameObject buttonPre;

	[Header("根")]
	public GameObject root;

	[Header("翻页")]
	public GameObject last;

	public GameObject next;

	private HorizontalReadViewData _data;

	private int m_curPage = -1;

	private int m_totalCount;

	private List<Image> m_imgs = new List<Image>();

	private TextMeshProUGUI m_Title;

	private TextMeshProUGUI m_Content;

	private Vector3 m_oriPos;

	protected override void Init()
	{
		base.Init();
		m_Title = title.GetComponent<TextMeshProUGUI>();
		m_Content = content.GetComponent<TextMeshProUGUI>();
		if (uiViewData != null)
		{
			_data = uiViewData as HorizontalReadViewData;
			SetInfo();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		for (int num = m_imgs.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(m_imgs[num].gameObject);
		}
		_data.onClose?.Invoke();
		m_imgs.Clear();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("CommonWinShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("CommonWinHide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void SetInfo()
	{
		m_oriPos = layout.GetComponent<RectTransform>().localPosition;
		m_totalCount = _data.infos.Count;
		m_curPage = 0;
		for (int i = 0; i < m_totalCount; i++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(buttonPre, root.transform);
			m_imgs.Add(gameObject.GetComponent<Image>());
		}
		RefreashInfo();
	}

	public void Next()
	{
		if (m_curPage < m_totalCount - 1)
		{
			m_imgs[m_curPage++].sprite = normal;
			RefreashInfo();
		}
	}

	public void Last()
	{
		if (m_curPage > 0)
		{
			m_imgs[m_curPage--].sprite = normal;
			RefreashInfo();
		}
	}

	public async void RefreashInfo()
	{
		HorizontalInfo horizontalInfo = _data.infos[m_curPage];
		if (horizontalInfo.content != content.StringReference.TableEntryReference)
		{
			m_Content.text = "";
		}
		layout.GetComponent<RectTransform>().localPosition = m_oriPos;
		layout.enabled = false;
		title.StringReference.TableEntryReference = horizontalInfo.titleId;
		content.StringReference.TableEntryReference = horizontalInfo.content;
		image.sprite = horizontalInfo.sprite;
		image.gameObject.SetActive(horizontalInfo.sprite != null);
		m_imgs[m_curPage].sprite = select;
		await UniTask.WaitUntil(() => !string.IsNullOrEmpty(m_Content.text));
		LayoutRebuilder.ForceRebuildLayoutImmediate(content.GetComponent<RectTransform>());
		LayoutRebuilder.ForceRebuildLayoutImmediate(root.GetComponent<RectTransform>());
		layout.enabled = true;
		next.SetActive(m_curPage != m_totalCount - 1);
		last.SetActive(m_curPage != 0);
	}
}
