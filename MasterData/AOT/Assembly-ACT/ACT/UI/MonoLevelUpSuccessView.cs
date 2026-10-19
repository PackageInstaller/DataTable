using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoLevelUpSuccessView : BaseUIView
{
	private MonoLevelUpSuccessViewData m_PrivateData;

	[Header("关闭按钮")]
	public Button closeButton;

	[Header("升级文字")]
	public TextMeshProUGUI formText;

	public TextMeshProUGUI toText;

	[Header("VFX")]
	public SortingGroup vfxSortingGroup;

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

	private MonoLevelUpSuccessViewData m_Data
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

	private bool ShowSkillPointGet
	{
		get
		{
			if (m_Data == null)
			{
				return false;
			}
			return m_Data.fromSkillPoint < m_Data.toSkillPoint;
		}
	}

	protected override void Init()
	{
		base.Init();
		m_Data = uiViewData as MonoLevelUpSuccessViewData;
		BindCloseBtn();
		InitVfxSortingLayer();
		InitText();
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
		uiEffectAnimator.Play("LevelUpShow");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("LevelUpHide");
	}

	private void InitText()
	{
		formText.SetText("{0:0}", m_Data.fromLevel);
		toText.SetText("{0:0}", m_Data.toLevel);
	}

	private void InitAllPropertyCell()
	{
		ClearAllPropertyCell();
		foreach (var propertyDatum in m_Data.propertyData)
		{
			PropertyCell component = Object.Instantiate(propertyCellPrefab, propertyContent).GetComponent<PropertyCell>();
			PropertyData propertyData = RuntimeConfigs.data.propertyDatas[propertyDatum.Item1];
			component.Init(propertyData, propertyDatum.Item3, propertyData, propertyDatum.Item2);
			component.SetDark();
			propertyCellList.Add(component);
		}
		if (ShowSkillPointGet)
		{
			PropertyCell component2 = Object.Instantiate(propertyCellPrefab, propertyContent).GetComponent<PropertyCell>();
			component2.InitSkillPointGet(m_Data.fromSkillPoint, m_Data.toSkillPoint);
			component2.SetDark();
			propertyCellList.Add(component2);
		}
	}

	private void ClearAllPropertyCell()
	{
		for (int num = propertyCellList.Count - 1; num >= 0; num--)
		{
			Object.Destroy(propertyCellList[num].gameObject);
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
			num = GetTargetContentHeight(m_Data.propertyData.Count + (ShowSkillPointGet ? 1 : 0));
			propertyContent.pivot = new Vector2(0.5f, 0.5f);
		}
		else
		{
			num = GetTargetContentHeight(maxCellCount + (ShowSkillPointGet ? 1 : 0));
			propertyContent.pivot = new Vector2(0.5f, 1f);
		}
		propertyContent.sizeDelta = new Vector2(propertyContent.sizeDelta.x, num);
	}

	private void InitVfxSortingLayer()
	{
		vfxSortingGroup.sortingLayerName = ContentCanvas.sortingLayerName;
	}

	private void BindCloseBtn()
	{
		closeButton.onClick.RemoveAllListeners();
		closeButton.onClick.AddListener(() =>
		{
			Close();
		});
	}

	private float GetTargetContentHeight(int cellCount)
	{
		return propertyCellPrefab.GetComponent<RectTransform>().rect.height * (float)cellCount + contentGroup.spacing * (float)(cellCount - 1);
	}
}
