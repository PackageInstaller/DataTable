using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class KnapsackItemNew : UGuiView
{
	[SerializeField]
	private GameObject newTag;

	[SerializeField]
	private GameObject customTag;

	[SerializeField]
	protected Button btn;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject iconObj;

	[SerializeField]
	private Image weaponIcon;

	[SerializeField]
	private GameObject weaponObj;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private GameObject propSelected;

	[SerializeField]
	private GameObject toggleOn;

	[SerializeField]
	private GameObject activeMask;

	[SerializeField]
	private List<GameObject> activeMasks;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private bool useBar = true;

	[SerializeField]
	private Image bar;

	[SerializeField]
	private TextMeshProUGUI countOrLevel;

	[SerializeField]
	private GameObject barObj;

	[SerializeField]
	private GameObject haveTimeLimit;

	[SerializeField]
	private GameObject ownerRoot;

	[SerializeField]
	private Image ownerImg;

	[SerializeField]
	private GameObject armourRank;

	[SerializeField]
	private Image rankColor;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private Image armourType;

	[SerializeField]
	private GameObject suitBoxIconObj;

	[SerializeField]
	private Image suitBoxIcon;

	[SerializeField]
	private TextMeshProUGUI exText;

	[SerializeField]
	private bool qualityEffectEnable;

	[SerializeField]
	private float bgEffectScale = 1f;

	[SerializeField]
	private float iconEffectScale = 1f;

	private int quality;

	private bool qualityEffectInitialized;

	private int qualityEffectLoadVersion;

	private readonly Dictionary<int, GameObject> qualityEffectPrefabCache = new Dictionary<int, GameObject>();

	private readonly Dictionary<int, KnapsackItemQualityEffect> qualityEffectScriptCache = new Dictionary<int, KnapsackItemQualityEffect>();

	public string itemSizeType = "Large";

	private KnapsackItemViewModel _viewModel;

	public static string[] ItemSizeEnum = new string[3] { "Small", "Middle", "Large" };

	public KnapsackItemViewModel ViewModel => _viewModel;

	public int Quality
	{
		get
		{
			return quality;
		}
		set
		{
			if (quality != value || !qualityEffectInitialized)
			{
				quality = value;
				qualityEffectInitialized = true;
				if (!qualityEffectEnable)
				{
					HideAllQualityEffects();
				}
				else
				{
					LoadQualityEffectAsync(quality).Forget();
				}
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		if (userData is KnapsackItemViewModel viewModel)
		{
			Init(viewModel);
		}
	}

	public void Init(KnapsackItemViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<KnapsackItemNew, KnapsackItemViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((KnapsackItemNew v) => v.Dismiss).To((KnapsackItemViewModel vm) => vm.DismissRequest);
		if (newTag != null)
		{
			bindingSet.Bind(newTag).For((GameObject v) => v.activeSelf).To((KnapsackItemViewModel vm) => vm.New);
		}
		if (customTag != null)
		{
			bindingSet.Bind(customTag).For((GameObject v) => v.activeSelf).To((KnapsackItemViewModel vm) => vm.CustomTag);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => vm.PropDataBase.Icon)
				.WithConversion("ItemIcon");
		}
		if (iconObj != null)
		{
			bindingSet.Bind(iconObj).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => (int)vm.PropDataBase.PropTypeEnum != 5);
		}
		if (weaponIcon != null)
		{
			bindingSet.Bind(weaponIcon).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => vm.PropDataBase.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(weaponObj).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => (int)vm.PropDataBase.PropTypeEnum == 5);
		}
		if (bg != null)
		{
			bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => $"RarityBG_{itemSizeType}_{vm.Quality}")
				.WithConversion("ItemIcon");
		}
		if (frame != null)
		{
			bindingSet.Bind(frame).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => $"Rarity_{itemSizeType}_{vm.Quality}")
				.WithConversion("ItemIcon");
		}
		if (qualityEffectEnable)
		{
			bindingSet.Bind(this).For((KnapsackItemNew v) => v.Quality).ToExpression((KnapsackItemViewModel vm) => vm.Quality);
		}
		if ((UnityEngine.Object)(object)name != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((KnapsackItemViewModel vm) => vm.PropDataBase.Name);
		}
		if (useBar && bar != null)
		{
			bindingSet.Bind(bar).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => $"Bar_{itemSizeType}_{vm.Quality}")
				.WithConversion("ItemIcon");
		}
		if (useBar && bar != null && (UnityEngine.Object)(object)countOrLevel != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(countOrLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((KnapsackItemViewModel vm) => GetCountOrLevelText(vm.PropDataBase.Amount));
		}
		if (barObj != null)
		{
			bindingSet.Bind(barObj).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => (int)vm.PropDataBase.PropTypeEnum != 16 && (int)vm.PropDataBase.PropTypeEnum != 4);
		}
		if (!useBar && (UnityEngine.Object)(object)countOrLevel != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(countOrLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((KnapsackItemViewModel vm) => vm.PropDataBase.Amount);
		}
		if (haveTimeLimit != null)
		{
			bindingSet.Bind(haveTimeLimit).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => (int)vm.PropDataBase.PropTimeLimitEnum != 0);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((KnapsackItemViewModel vm) => vm.OnClick);
		}
		if (ownerRoot != null)
		{
			bindingSet.Bind(ownerRoot).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => vm.OwnerId > 0 && vm.ShowOwner);
			bindingSet.Bind(ownerImg).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => vm.OwnerIcon)
				.WithConversion("ItemIcon");
		}
		if (activeMask != null)
		{
			bindingSet.Bind(activeMask).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => !vm.IsActive);
		}
		if (activeMasks != null)
		{
			foreach (GameObject activeMask in activeMasks)
			{
				if (activeMask != null)
				{
					bindingSet.Bind(activeMask).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => !vm.IsActive);
				}
			}
		}
		if (propSelected != null)
		{
			bindingSet.Bind(propSelected).For((GameObject v) => v.activeSelf).To((KnapsackItemViewModel vm) => vm.IsSelected);
		}
		if (toggleOn != null)
		{
			bindingSet.Bind(toggleOn).For((GameObject v) => v.activeSelf).To((KnapsackItemViewModel vm) => vm.IsToggleOn);
		}
		if (armourRank != null)
		{
			bindingSet.Bind(armourRank).For((GameObject v) => v.activeSelf).To((KnapsackItemViewModel vm) => vm.ShowArmourRank);
		}
		if (rankColor != null)
		{
			bindingSet.Bind(rankColor).For((Image v) => v.color).To((KnapsackItemViewModel vm) => vm.ArmourRankColor);
		}
		if ((UnityEngine.Object)(object)rank != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((KnapsackItemViewModel vm) => vm.ArmourRankText);
		}
		if (armourType != null)
		{
			bindingSet.Bind(armourType.gameObject).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => !string.IsNullOrEmpty(vm.ArmourTypeIcon));
			bindingSet.Bind(armourType).For((Image v) => v.sprite).To((KnapsackItemViewModel vm) => vm.ArmourTypeIcon)
				.WithConversion("ItemIcon");
		}
		if (suitBoxIconObj != null)
		{
			bindingSet.Bind(suitBoxIconObj).For((GameObject v) => v.activeSelf).ToExpression((KnapsackItemViewModel vm) => (int)vm.PropDataBase.PropTypeEnum == 16);
		}
		if (suitBoxIcon != null)
		{
			bindingSet.Bind(suitBoxIcon).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => vm.EntryIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)exText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(exText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((KnapsackItemViewModel vm) => vm.ExValueText);
		}
		bindingSet.Build();
		if (!qualityEffectEnable)
		{
			qualityEffectInitialized = false;
			HideAllQualityEffects();
		}
	}

	private async UniTaskVoid LoadQualityEffectAsync(int qualityValue)
	{
		int version = ++qualityEffectLoadVersion;
		HideAllQualityEffects();
		if (qualityValue < 0)
		{
			return;
		}
		try
		{
			Transform bgParent = ((bg != null && bg.transform.parent != null) ? bg.transform.parent : base.transform);
			Transform iconParent = ((icon != null) ? icon.transform : base.transform);
			if (TryGetCachedQualityEffect(qualityValue, out var effectObj, out var effectScript))
			{
				effectObj.SetActive(value: true);
				await effectScript.MountAsync(bgParent, iconParent, bgEffectScale, iconEffectScale);
				return;
			}
			string text = $"Quality{qualityValue}EffectItem";
			string uIItemAsset = AssetUtility.GetUIItemAsset("KnapsackQualityEffect/" + text);
			GameObject gameObject = await InstantiateAsync(uIItemAsset, base.transform);
			if (version != qualityEffectLoadVersion)
			{
				if (gameObject != null)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
				return;
			}
			KnapsackItemQualityEffect component = gameObject.GetComponent<KnapsackItemQualityEffect>();
			if (component == null)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			qualityEffectPrefabCache[qualityValue] = gameObject;
			qualityEffectScriptCache[qualityValue] = component;
			await component.MountAsync(bgParent, iconParent, bgEffectScale, iconEffectScale);
		}
		catch (Exception)
		{
		}
	}

	private bool TryGetCachedQualityEffect(int qualityValue, out GameObject effectObj, out KnapsackItemQualityEffect effectScript)
	{
		if (qualityEffectPrefabCache.TryGetValue(qualityValue, out effectObj) && qualityEffectScriptCache.TryGetValue(qualityValue, out effectScript) && effectObj != null && effectScript != null)
		{
			return true;
		}
		qualityEffectPrefabCache.Remove(qualityValue);
		qualityEffectScriptCache.Remove(qualityValue);
		effectObj = null;
		effectScript = null;
		return false;
	}

	private void HideAllQualityEffects()
	{
		foreach (KeyValuePair<int, KnapsackItemQualityEffect> item in qualityEffectScriptCache)
		{
			item.Value?.HideEffects();
		}
		foreach (KeyValuePair<int, GameObject> item2 in qualityEffectPrefabCache)
		{
			if (item2.Value != null)
			{
				item2.Value.SetActive(value: false);
			}
		}
	}

	private void DestroyAllQualityEffects()
	{
		foreach (KeyValuePair<int, KnapsackItemQualityEffect> item in qualityEffectScriptCache)
		{
			item.Value?.DestroyEffects();
		}
		foreach (KeyValuePair<int, GameObject> item2 in qualityEffectPrefabCache)
		{
			if (item2.Value != null)
			{
				UnityEngine.Object.Destroy(item2.Value);
			}
		}
		qualityEffectScriptCache.Clear();
		qualityEffectPrefabCache.Clear();
	}

	protected virtual void Dismiss(object sender, InteractionEventArgs e)
	{
		qualityEffectLoadVersion++;
		DestroyAllQualityEffects();
		qualityEffectInitialized = false;
		this.ClearAllBindings();
		_viewModel?.Dispose();
	}

	protected override void OnDestroy()
	{
		qualityEffectLoadVersion++;
		DestroyAllQualityEffects();
		qualityEffectInitialized = false;
		base.OnDestroy();
	}

	private string GetCountOrLevelText(int value)
	{
		if (_viewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Weapon)
		{
			return $"Lv.{value}";
		}
		if (_viewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment && _viewModel.PropDataBase is ArmourData armourData)
		{
			if (armourData.ArmourEnum != ArmourEnum.Rock)
			{
				return $"+{value}";
			}
			return "";
		}
		if (_viewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Prop)
		{
			if (_viewModel.ShowOwnedAndRequiredCount)
			{
				int num = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(_viewModel.PropDataBase.Id)?.Amount ?? 0;
				string arg = ((num >= _viewModel.PropDataBase.Amount) ? "#9dde8e" : "#ea6250");
				return $"<color={arg}>{num}</color>/{_viewModel.PropDataBase.Amount}";
			}
			if (_viewModel.ShowShortageState)
			{
				string arg2 = (((long)(Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(_viewModel.PropDataBase.Id)?.Amount ?? 0) >= (long)_viewModel.PropDataBase.Amount) ? "#baffd6" : "#ff7171");
				return $"<color={arg2}>{_viewModel.PropDataBase.Amount}</color>";
			}
			return _viewModel.PropDataBase.Amount.ToString();
		}
		return _viewModel.PropDataBase.Amount.ToString();
	}

	public virtual void RefreshData(KnapsackItemViewModel viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void IconSetNativeSize()
	{
		icon.SetNativeSize();
	}

	public void SetItemSize(string size)
	{
		itemSizeType = size;
	}
}
