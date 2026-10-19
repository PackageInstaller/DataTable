using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model.EquipSuit;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ViewComponent.InventoryView;

public class InventoryEquipSuitItem : LoopScrollBaseItem
{
	public BImage icon;

	public LocalizeStringEvent suitName;

	public GameObject hasSuitStyle;

	public GameObject noSuitStyle;

	public GameObject[] qualityStyles;

	public TMP_Text suitCountText;

	public ActToggle toggle;

	[Header("文字颜色")]
	[SerializeField]
	private TMP_Text text_SuitName;

	[SerializeField]
	private Color text_GrayColor;

	[SerializeField]
	private Color text_WhiteColor;

	[SerializeField]
	private Color text_BlackColor;

	[Header("数量颜色")]
	[SerializeField]
	private TMP_Text text_Count;

	[SerializeField]
	private Color count_LightColor;

	[SerializeField]
	private Color count_DarkColor;

	private EquipSuitData _suitData;

	private UnityAction<bool> _onToggleValueChanged;

	private int _suitCount;

	public EquipSuitData SuitData
	{
		get
		{
			return _suitData;
		}
		set
		{
			_suitData = value;
			UpdateSuitCount();
			UpdateStyle();
			UpdateTextColor(toggle.IsOn);
		}
	}

	public UnityAction<bool> OnToggleValueChanged
	{
		get
		{
			return _onToggleValueChanged;
		}
		set
		{
			if (_onToggleValueChanged != null)
			{
				toggle.onValueChanged.RemoveListener(_onToggleValueChanged);
			}
			_onToggleValueChanged = value;
			if (_onToggleValueChanged != null)
			{
				toggle.onValueChanged.AddListener(_onToggleValueChanged);
			}
		}
	}

	public new ImageAssetStation Station { get; set; }

	private void Awake()
	{
		toggle.onToggleClick.AddListener(OnClick);
		toggle.onValueChanged.AddListener(UpdateTextColor);
	}

	private void OnDestroy()
	{
		toggle.onToggleClick.RemoveListener(OnClick);
		toggle.onValueChanged.RemoveListener(OnToggleValueChanged);
		toggle.onValueChanged.RemoveListener(UpdateTextColor);
	}

	private void UpdateStyle()
	{
		suitCountText.gameObject.SetActive(value: true);
		suitCountText.SetText(_suitCount.FastToString());
		if (_suitData == null)
		{
			return;
		}
		ItemData data = CoreUtils.GetData(_suitData.id, RuntimeConfigs.data.itemDatas);
		suitName.StringReference.TableEntryReference = EquipSuit.GetLocalizationName(_suitData.id);
		if (data != null)
		{
			Station.LoadImageAsync(238, _suitData.id, icon).Forget();
			hasSuitStyle.SetActive(_suitCount > 0);
			noSuitStyle.SetActive(_suitCount == 0);
			for (int i = 0; i < qualityStyles.Length; i++)
			{
				qualityStyles[i].SetActive(i == data.quality - 4);
			}
		}
	}

	private void UpdateTextColor(bool isOn)
	{
		if (isOn)
		{
			text_SuitName.color = ((_suitCount > 0) ? text_BlackColor : text_GrayColor);
			text_Count.color = count_DarkColor;
		}
		else
		{
			text_SuitName.color = ((_suitCount > 0) ? text_WhiteColor : text_GrayColor);
			text_Count.color = count_LightColor;
		}
	}

	private void UpdateSuitCount()
	{
		if (_suitData == null)
		{
			return;
		}
		_suitCount = 0;
		foreach (Equip item in CharacterDependHelper.GetCurWorldAllEquip())
		{
			if (_suitData.equipList.Contains(item.Id))
			{
				_suitCount++;
			}
		}
	}

	private void OnClick()
	{
		toggle.SetIsOn(!toggle.IsOn);
	}
}
