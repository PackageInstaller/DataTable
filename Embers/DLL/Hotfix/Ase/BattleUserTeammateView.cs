using System;
using System.Linq.Expressions;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleUserTeammateView : BattleUserView
{
	[Header("自定义属性")]
	public Text nameText;

	public Text nameText2;

	public Image castingProgress;

	public Button heroBtn;

	[Header("队友死亡属性")]
	public Image touxiang;

	public CircleImage HeadIcon;

	public Color deathColor;

	public Image CDBg;

	public Image CDImage;

	public TextMeshProUGUI CDText;

	public TextMeshProUGUI CDText2;

	public TextMeshProUGUI SkillLayer;

	public TextMeshProUGUI XpSkillName;

	[SerializeField]
	private GameObject skill4ReleEffect;

	[SerializeField]
	private GameObject skill4ReleNameAni;

	public GameObject SkillLayerBg;

	public GameObject CanReleaseEffect;

	public GameObject stateCantRelSkill;

	public GameObject OffLineShow;

	public GameObject OffLineHide;

	public GameObject AutoFightGo;

	[SerializeField]
	private Image skinFrame;

	private int rebornTimes;

	private int curSkinId = -1;

	private GameObject canReleaseXpEffect;

	private bool teachAIXp;

	private bool showSkill4ReleEffect;

	public bool TeachAIXp
	{
		get
		{
			return teachAIXp;
		}
		set
		{
			if (value)
			{
				viewModel.OnObserverTeachAIXpGuide(heroBtn.transform);
			}
		}
	}

	public bool ShowSkill4ReleEffect
	{
		get
		{
			return showSkill4ReleEffect;
		}
		set
		{
			if (value)
			{
				ShowSkill4Effect();
			}
		}
	}

	protected override void LateUpdate()
	{
		base.LateUpdate();
		if (viewModel != null && castingProgress != null && viewModel.HeroData.Property.ContainsKey("XpEnergy"))
		{
			Ase.ECS.PropertyData propertyData = viewModel.HeroData.Property["XpEnergy"];
			castingProgress.fillAmount = Mathf.Clamp01((propertyData.MaxValue == 0f) ? 0.075f : (propertyData.CurValue / propertyData.MaxValue * 0.85f + 0.075f));
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleUserViewModel>(userData);
		BindingSet<BattleUserTeammateView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<CanvasGroup>(root).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((BattleUserViewModel vm) => vm.IsEmpty ? 0 : 1);
		if (nameText != null)
		{
			bindingSet.Bind(nameText).For((Text v) => v.text).ToExpression((BattleUserViewModel vm) => vm.HeroData.Name);
		}
		if (nameText2 != null)
		{
			bindingSet.Bind(nameText2).For((Text v) => v.text).ToExpression((BattleUserViewModel vm) => vm.HeroData.Name);
		}
		if (heroBtn != null)
		{
			bindingSet.Bind(heroBtn).For((Button v) => v.onClick).To((BattleUserViewModel vm) => vm.OnReleaseSkill4);
		}
		bindingSet.Bind(HeadIcon).For((CircleImage v) => v.sprite).ToExpression((BattleUserViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.BattleAvatar, vm.HeroData))
			.WithConversion("ItemIcon");
		bindingSet.Bind(HeadIcon).For((CircleImage v) => v.color).ToExpression((BattleUserViewModel vm) => vm.HeroData.IsDead ? deathColor : Color.white);
		if (CDBg != null)
		{
			bindingSet.Bind(CDBg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime > 0f);
		}
		if (CDImage != null)
		{
			bindingSet.Bind(CDImage).For((Image v) => v.fillAmount).ToExpression((BattleUserViewModel vm) => (vm.UItimateSkill.SkillCoolingData.CoolingTime == 0f) ? 1f : (1f - vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime / vm.UItimateSkill.SkillCoolingData.CoolingTime));
			bindingSet.Bind(CDImage.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime > 0f);
		}
		if ((UnityEngine.Object)(object)CDText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(CDText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleUserViewModel vm) => $"{vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime:F1}");
			bindingSet.Bind(((Component)(object)CDText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime > 0f);
		}
		if ((UnityEngine.Object)(object)CDText2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(CDText2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleUserViewModel vm) => $"{vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime:F1}");
			bindingSet.Bind(((Component)(object)CDText2).gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime > 0f);
		}
		if ((UnityEngine.Object)(object)SkillLayer != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(SkillLayer).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.CacheLayer);
		}
		if (SkillLayerBg != null)
		{
			bindingSet.Bind(SkillLayerBg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.SkillCoolingData.IsCacheLayerVisible);
		}
		if (stateCantRelSkill != null)
		{
			bindingSet.Bind(stateCantRelSkill.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => !vm.UItimateSkill.SkillCoolingData.AbnormalStateCanReleaseSkill);
		}
		if (CanReleaseEffect != null)
		{
			bindingSet.Bind(CanReleaseEffect.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => !vm.IsEmpty && vm.UItimateSkill.SkillCoolingData.ResourceAmpleReleaseSkill && vm.UItimateSkill.SkillCoolingData.CurrentCoolingTime <= 0f);
		}
		bindingSet.Bind(this).For((BattleUserTeammateView v) => v.TeachAIXp).ToExpression((BattleUserViewModel vm) => vm.UItimateSkill.SkillCoolingData.ResourceAmpleReleaseSkill);
		if (OffLineShow != null)
		{
			bindingSet.Bind(OffLineShow).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.IsOffLine);
		}
		if (OffLineHide != null)
		{
			bindingSet.Bind(OffLineHide).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => !vm.HeroData.IsOffLine);
		}
		if (AutoFightGo != null)
		{
			bindingSet.Bind(AutoFightGo).For((GameObject v) => v.activeSelf).To((BattleUserViewModel vm) => vm.HeroData.OpenAutoFight);
		}
		bindingSet.Bind(this).For((BattleUserTeammateView v) => v.ShowSkill4ReleEffect).To((BattleUserViewModel vm) => vm.HeroData.Skill4RleScucess);
		bindingSet.Build();
		XpSkillSet();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleUserViewModel>(userData);
		enableModifyEffect = false;
		base.UpdateHpSlider(viewModel);
		this.SetDataContext(viewModel);
		OnBuffListChanged(null, null);
		enableModifyEffect = true;
		XpSkillSet();
	}

	private void XpSkillSet()
	{
		if (viewModel.UItimateSkill != null && viewModel.UItimateSkill.SKillConfig != null)
		{
			((TMP_Text)XpSkillName).SetText(viewModel.UItimateSkill.SKillConfig.Name, true);
		}
		if (UseHeroSkinAsset())
		{
			LoadXpEffect(viewModel.HeroData.HeroModel.SkinConfigId);
			SetHearFrame();
			return;
		}
		LoadXpEffect(0);
		if (skinFrame != null)
		{
			skinFrame.gameObject.SetActive(value: false);
		}
	}

	private async void LoadXpEffect(int skinId)
	{
		if (CanReleaseEffect != null && curSkinId != skinId)
		{
			if (curSkinId != -1)
			{
				UnityEngine.Object.Destroy(canReleaseXpEffect);
				GameEntry.Resource.UnloadAsset(GetXpEffectPath(curSkinId));
			}
			curSkinId = skinId;
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(GetXpEffectPath(curSkinId));
			if (!(gameObject == null))
			{
				canReleaseXpEffect = UnityEngine.Object.Instantiate(gameObject, CanReleaseEffect.transform);
				canReleaseXpEffect.transform.localPosition = Vector3.zero;
			}
		}
	}

	private async UniTask SetHearFrame()
	{
		if (!(skinFrame == null))
		{
			int skinConfigId = viewModel.HeroData.HeroModel.SkinConfigId;
			Sprite sprite = await LoadSpriteAsync(SkinAssetUtility.GetSkinHeadFrame(skinConfigId));
			if (!(sprite == null))
			{
				skinFrame.sprite = sprite;
				skinFrame.gameObject.SetActive(value: true);
			}
		}
	}

	private bool UseHeroSkinAsset()
	{
		if (viewModel.HeroData == null)
		{
			return false;
		}
		if (viewModel.HeroData.HeroModel == null)
		{
			return false;
		}
		if (!viewModel.HeroData.HeroModel.IsSkin)
		{
			return false;
		}
		return GameEntry.DataTable.GetDataRow<DRHeroSkin>(viewModel.HeroData.HeroModel.SkinConfigId)?.SkinBattleFrame ?? false;
	}

	private string GetXpEffectPath(int skinId)
	{
		return Utility.Text.Format(SkinAssetUtility.GetSkinEffectPath(), skinId, "Effects_Battle_TeamRoot");
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		GameEntry.Resource.UnloadAsset(GetXpEffectPath(curSkinId));
	}

	private void ShowSkill4Effect()
	{
		skill4ReleEffect.gameObject.SetActive(value: false);
		skill4ReleNameAni.gameObject.SetActive(value: false);
		skill4ReleEffect.gameObject.SetActive(value: true);
		skill4ReleNameAni.gameObject.SetActive(value: true);
	}

	private void Update()
	{
		if (deadFillRoot.gameObject.activeSelf)
		{
			Vector3 heroPos = viewModel.HeroData.GetHeroPos();
			Vector2 vector = default(Vector2);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)base.transform, (Vector2)heroPos, UIUtilly.GetUICamera(), ref vector))
			{
				deadFillRoot.GetComponent<RectTransform>().localPosition = vector;
			}
		}
	}
}
