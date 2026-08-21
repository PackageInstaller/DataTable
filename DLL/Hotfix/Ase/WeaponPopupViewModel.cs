using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WeaponPopupViewModel : OptionBase
{
	private WeaponData _weaponData;

	private string _type;

	private string weaponIconName;

	private List<AttributeItemData> _attributeItemData;

	private List<EntryItemData> _entryItemData;

	private InteractionRequest _refreshDataRequest;

	private Vector2 _showPos;

	private bool _showMask1;

	private bool _showMask2;

	private bool _showLockBtn = true;

	private float mask2Width;

	private bool _showHeroInfo;

	private string heroImg;

	private string heroName;

	public WeaponData WeaponData
	{
		get
		{
			return _weaponData ?? (_weaponData = WeaponData.CreateEmpty());
		}
		private set
		{
			Set(ref _weaponData, value, "WeaponData");
		}
	}

	public string Type
	{
		get
		{
			return _type;
		}
		private set
		{
			Set(ref _type, value, "Type");
		}
	}

	public List<AttributeItemData> AttributeItemData
	{
		get
		{
			return _attributeItemData;
		}
		set
		{
			Set(ref _attributeItemData, value, "AttributeItemData");
		}
	}

	public List<EntryItemData> EntryItemData
	{
		get
		{
			return _entryItemData;
		}
		set
		{
			Set(ref _entryItemData, value, "EntryItemData");
		}
	}

	public Vector2 ShowPos
	{
		get
		{
			return _showPos;
		}
		set
		{
			Set(ref _showPos, value, "ShowPos");
		}
	}

	public bool ShowMask1
	{
		get
		{
			return _showMask1;
		}
		set
		{
			Set(ref _showMask1, value, "ShowMask1");
		}
	}

	public bool ShowMask2
	{
		get
		{
			return _showMask2;
		}
		set
		{
			Set(ref _showMask2, value, "ShowMask2");
		}
	}

	public bool ShowLockBtn
	{
		get
		{
			return _showLockBtn;
		}
		set
		{
			Set(ref _showLockBtn, value, "ShowLockBtn");
		}
	}

	public bool ShowHeroInfo
	{
		get
		{
			return _showHeroInfo;
		}
		set
		{
			Set(ref _showHeroInfo, value, "ShowHeroInfo");
		}
	}

	public string WeaponIconName
	{
		get
		{
			return weaponIconName;
		}
		set
		{
			Set(ref weaponIconName, value, "WeaponIconName");
		}
	}

	public float Mask2Width
	{
		get
		{
			return mask2Width;
		}
		set
		{
			Set(ref mask2Width, value, "Mask2Width");
		}
	}

	public string HeroImg
	{
		get
		{
			return heroImg;
		}
		set
		{
			Set(ref heroImg, value, "HeroImg");
		}
	}

	public string HeroName
	{
		get
		{
			return heroName;
		}
		set
		{
			Set(ref heroName, value, "HeroName");
		}
	}

	public InteractionRequest RefreshDataRequest => _refreshDataRequest;

	public WeaponPopupViewModel()
	{
	}

	public WeaponPopupViewModel(OptionBase parent, bool showHeroInfo = false, float posX = 0f, float posY = 0f, bool showMask1 = false, bool showMask2 = true)
	{
		base.parent = parent;
		_showHeroInfo = showHeroInfo;
		_attributeItemData = new List<AttributeItemData>();
		_entryItemData = new List<EntryItemData>();
		_refreshDataRequest = new InteractionRequest();
		ShowPos = new Vector2(posX, posY);
		ShowMask1 = showMask1;
		ShowMask2 = showMask2;
		mask2Width = 740f;
		FindHeroId();
	}

	public WeaponPopupViewModel(OptionBase parent, WeaponData weaponData, bool showHeroInfo = false, float posX = 0f, float posY = 0f, bool showMask1 = false, bool showMask2 = true)
	{
		base.parent = parent;
		_showHeroInfo = showHeroInfo;
		_attributeItemData = new List<AttributeItemData>();
		_entryItemData = new List<EntryItemData>();
		_refreshDataRequest = new InteractionRequest();
		ShowPos = new Vector2(posX, posY);
		ShowMask1 = showMask1;
		ShowMask2 = showMask2;
		RefreshData(weaponData);
		mask2Width = 740f;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && optionArg.OptionName.Equals("OnShowEntryPanel"))
		{
			parent.ItemOnClick(optionArg);
		}
	}

	private void FindHeroId()
	{
		int equipmentOwnerById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetEquipmentOwnerById(WeaponData.Uid);
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(equipmentOwnerById);
		HeroName = ((dataRow == null) ? "" : (dataRow.Name + "已装备"));
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(equipmentOwnerById);
		if (heroById != null)
		{
			HeroImg = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, heroById);
		}
		else
		{
			HeroImg = string.Empty;
		}
	}

	public void RefreshData(WeaponData data)
	{
		if (data == null)
		{
			base.IsVisible = false;
			return;
		}
		WeaponData = data;
		WeaponIconName = data.OriginalIcon;
		Type = UiConvert.Equip.WeaponEnum2Name[data.WeaponEnum];
		FindHeroId();
		RefreshAttribute();
	}

	private void RefreshAttribute()
	{
		AttributeItemData.Clear();
		EntryItemData.Clear();
		for (int i = 0; i < WeaponData.EquipAttributeList.Count; i++)
		{
			float baseValue = WeaponData.EquipAttributeList[i].BaseValue;
			AttributeItemData.Add(new AttributeItemData(WeaponData.EquipAttributeList[i], baseValue));
		}
		for (int j = 0; j < WeaponData.EntryDataList.Count; j++)
		{
			EntryItemData.Add(new EntryItemData(this, WeaponData.EntryDataList[j]));
		}
		_refreshDataRequest.Raise();
	}

	public async void Lock()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ChangeLock(5, WeaponData.Uid);
		loading.Dispose();
		if (num)
		{
			parent?.ItemOnClick(this);
			parent?.ItemOnClick(new OptionArg(this, "ChangeLock"));
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}

	public void Hide()
	{
		visibleRequest.Raise(context: false);
	}
}
