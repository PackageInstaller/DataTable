using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoBreakSuccessView : BaseUIView
{
	private MonoBreakSuccessViewData m_PrivateData;

	[Header("关闭按钮")]
	public Button closeButton;

	[Header("星星")]
	public List<Star> startList;

	[Header("属性滚动列表")]
	public ScrollRect propertyScrollRect;

	public VerticalLayoutGroup contentGroup;

	[Header("属性条 prefab")]
	public GameObject propertyCellPrefab;

	[Header("每一个属性条间隔时间 单位：秒")]
	public float propertyCellInterval;

	[Header("新的属性条出现的滚动时间 单位：秒")]
	public float propertyCellScrollTime;

	private List<PropertyCell> propertyCellList = new List<PropertyCell>();

	private readonly int maxCellCount = 4;

	private MonoBreakSuccessViewData m_Data
	{
		get
		{
			return m_PrivateData;
		}
		set
		{
			m_PrivateData = value;
		}
	}

	private RectTransform propertyContent => propertyScrollRect.content;

	protected override void Init()
	{
		base.Init();
		m_Data = uiViewData as MonoBreakSuccessViewData;
		BindCloseBtn();
		InitStar();
		InitAllPropertyCell();
		InitScrollView();
	}

	protected override void UnInit()
	{
		base.UnInit();
		ClearAllPropertyCell();
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("BreakSuccessShow");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("BreakSuccessHide");
	}

	private void InitStar()
	{
		for (int i = 0; i < startList.Count; i++)
		{
			startList[i].SetDark();
		}
		for (int j = 0; j < m_Data.fromLevel; j++)
		{
			startList[j].SetLight();
		}
		for (int k = m_Data.fromLevel; k < m_Data.toLevel; k++)
		{
			startList[k].FadeIn();
		}
	}

	private void ShowPreStar(int preStarCount)
	{
	}

	private void ShowDeltaStar(int curStarCount)
	{
	}

	private void InitAllPropertyCell()
	{
		ClearAllPropertyCell();
		foreach (var propertyDatum in m_Data.propertyData)
		{
			PropertyCell component = UnityEngine.Object.Instantiate(propertyCellPrefab, propertyContent).GetComponent<PropertyCell>();
			PropertyData propertyData = RuntimeConfigs.data.propertyDatas[propertyDatum.Item1];
			component.Init(propertyData, propertyDatum.Item3, propertyData, propertyDatum.Item2);
			component.SetDark();
			propertyCellList.Add(component);
		}
	}

	private void ClearAllPropertyCell()
	{
		for (int num = propertyCellList.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(propertyCellList[num].gameObject);
		}
		propertyCellList.Clear();
	}

	public void ShowAllPropertyCell()
	{
		ShowAllPropertyCellAsync().Forget();
	}

	public async UniTask ShowAllPropertyCellAsync()
	{
		propertyScrollRect.verticalNormalizedPosition = 1f;
		propertyScrollRect.vertical = false;
		if (m_Data.propertyData.Count <= maxCellCount)
		{
			propertyCellList[0].animation.Play("PropertyPromote");
			await UniTask.Delay((int)(propertyCellInterval * 1000f));
			for (int i = 1; i < propertyCellList.Count; i++)
			{
				propertyCellList[i].animation.Play("PropertyPromote");
				await UniTask.Delay((int)(propertyCellInterval * 1000f));
			}
		}
		else
		{
			propertyCellList[0].animation.Play("PropertyPromote");
			await UniTask.Delay((int)(propertyCellInterval * 1000f));
			for (int i = 1; i < maxCellCount; i++)
			{
				propertyCellList[i].animation.Play("PropertyPromote");
				await UniTask.Delay((int)(propertyCellInterval * 1000f));
			}
			for (int i = maxCellCount; i < m_Data.propertyData.Count; i++)
			{
				propertyContent.sizeDelta = new Vector2(propertyContent.sizeDelta.x, GetTargetContentHeight(i + 1));
				propertyScrollRect.DOVerticalNormalizedPos(0f, propertyCellScrollTime);
				await UniTask.Delay((int)(propertyCellScrollTime * 1000f));
				propertyCellList[i].animation.Play("PropertyPromote");
				await UniTask.Delay((int)(propertyCellInterval * 1000f));
			}
		}
		propertyScrollRect.vertical = true;
	}

	private void InitScrollView()
	{
		float num = 0f;
		_ = propertyCellPrefab.GetComponent<RectTransform>().rect.height;
		if (m_Data.propertyData.Count <= maxCellCount)
		{
			num = GetTargetContentHeight(m_Data.propertyData.Count);
			propertyContent.pivot = new Vector2(0.5f, 0.5f);
		}
		else
		{
			num = GetTargetContentHeight(maxCellCount);
			propertyContent.pivot = new Vector2(0.5f, 1f);
		}
		propertyContent.sizeDelta = new Vector2(propertyContent.sizeDelta.x, num);
	}

	private void BindCloseBtn()
	{
		closeButton.onClick.RemoveAllListeners();
		closeButton.onClick.AddListener(() =>
		{
			Close();
		});
		Action callback = m_Data.callback;
		if (callback != null)
		{
			closeButton.onClick.AddListener(callback.Invoke);
		}
	}

	private float GetTargetContentHeight(int cellCount)
	{
		return propertyCellPrefab.GetComponent<RectTransform>().rect.height * (float)cellCount + contentGroup.spacing * (float)(cellCount - 1);
	}
}
