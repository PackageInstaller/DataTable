using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoVerticalReadView : BaseUIView
{
	public class VerticalInfos
	{
		public int titleId;

		public List<VerticalInfo> infos;

		public Action onClose;
	}

	[Header("文字")]
	public LocalizeStringEvent title;

	[Header("预制")]
	public GameObject textPre;

	public GameObject imagePre;

	[Header("根")]
	public GameObject root;

	public LayoutGroup layout;

	private VerticalInfos m_infos;

	private List<GameObject> m_objects;

	private TextMeshProUGUI m_Title;

	private bool titleReady;

	protected override void Init()
	{
		base.Init();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_objects = ListPool<GameObject>.Get();
		m_Title = title.GetComponent<TextMeshProUGUI>();
		if (uiViewData != null)
		{
			m_infos = uiViewData as VerticalInfos;
			await SetInfo(m_infos.titleId, m_infos.infos);
		}
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("Show");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("Hide");
	}

	private async UniTask SetInfo(int titleId, List<VerticalInfo> infos)
	{
		title.StringReference.TableEntryReference = titleId;
		for (int i = 0; i < infos.Count; i++)
		{
			GameObject gameObject = null;
			VerticalInfo verticalInfo = infos[i];
			switch (verticalInfo.type)
			{
			case VerticalInfo.Type.Text:
				gameObject = UnityEngine.Object.Instantiate(textPre, root.transform);
				gameObject.GetComponent<LocalizeStringEvent>().StringReference.TableEntryReference = verticalInfo.content;
				break;
			case VerticalInfo.Type.Image:
				gameObject = UnityEngine.Object.Instantiate(imagePre, root.transform);
				gameObject.GetComponent<Image>().sprite = verticalInfo.sprite;
				break;
			}
			m_objects.Add(gameObject);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		for (int num = m_objects.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(m_objects[num]);
		}
		m_objects.Clear();
		m_infos.onClose?.Invoke();
		titleReady = false;
	}
}
