using ACT.Core;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Rendering;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoRefineSuccessView : BaseUIView
{
	private MonoRefineSuccessViewData m_PrivateData;

	[Header("关闭按钮")]
	public Button closeButton;

	[Header("VFX")]
	public SortingGroup vfxSortingGroup;

	[Header("ItemUIComponent")]
	public ItemUIComponent refineItemUIComponent;

	[Header("物品图标")]
	public BImage itemBImage;

	[Header("文字")]
	public TextMeshProUGUI toLevelText;

	public LocalizeStringEvent toLevelLocalize;

	public TextMeshProUGUI abilityNameText;

	public LocalizeStringEvent abilityNameLocalize;

	public TextMeshProUGUI abilityDetailText;

	public LocalizeStringEvent abilityDetailLocalize;

	[Header("技能名称")]
	public RectTransform abilityNameTransform;

	public RectTransform abilityNameLineLeftTransform;

	public RectTransform abilityNameLineRightTransform;

	public float oneSideTotalLength;

	public float lineTextGapWidth;

	public bool abilityNameUpdateFinished;

	private MonoRefineSuccessViewData m_Data
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

	protected override async void Init()
	{
		base.Init();
		m_Data = uiViewData as MonoRefineSuccessViewData;
		BindCloseBtn();
		InitVfxSortingLayer();
		InitImageAndText();
		await UniTask.WaitUntil(() => abilityNameUpdateFinished);
		InitAbilityNameLine();
	}

	protected override void UnInit()
	{
		base.UnInit();
		abilityNameUpdateFinished = false;
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("RefineSuccessShow");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("RefineSuccessHide");
	}

	private void InitImageAndText()
	{
		Station.LoadSprite(GameLoader.meta.itemAtlasNameAssetID, m_Data.weapon.WeaponId, itemBImage);
		ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get(m_Data.weapon);
		refineItemUIComponent.SetData(item, long.MinValue, ItemUIComponentBase.InitType.BagWeapon);
		refineItemUIComponent.UpdatePerformance();
		toLevelLocalize.StringReference.GetVariable<int>(0.ToString()).Value = m_Data.weapon.Refine;
		abilityNameLocalize.StringReference.TableEntryReference = m_Data.weapon.SkillNameTextId;
		abilityDetailText.richText = true;
		string localizeString = LocalizationUtility.GetLocalizeString("longcommon", RuntimeConfigs.data.skillDetailDatas[m_Data.weapon.SkillTotalIds[0]].briefDescLocal);
		localizeString = CustomTagParser.ReplaceText(m_Data.weapon.SkillTotalIds[0], localizeString, m_Data.weapon.Refine);
		abilityDetailText.text = localizeString;
	}

	private void InitAbilityNameLine()
	{
		float num = abilityNameTransform.sizeDelta.x * 0.5f;
		float x = oneSideTotalLength - num - lineTextGapWidth;
		float y = abilityNameLineLeftTransform.sizeDelta.y;
		abilityNameLineLeftTransform.anchoredPosition = new Vector2(0f - oneSideTotalLength, 0f);
		abilityNameLineLeftTransform.sizeDelta = new Vector2(x, y);
		abilityNameLineRightTransform.anchoredPosition = new Vector2(oneSideTotalLength, 0f);
		abilityNameLineRightTransform.sizeDelta = new Vector2(x, y);
	}

	public void AbilityNameUpdateFinish()
	{
		abilityNameUpdateFinished = true;
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
}
