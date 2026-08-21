using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class WeaponDetailViewModel : OptionBase
{
	private WeaponData _weaponData;

	private string _weaponEnumName;

	private string _leftBtnText;

	private string _rightBtnText;

	private List<AttributeItemData> _attributeItemData;

	private List<EntryItemData> _entryItemData;

	private InteractionRequest _refreshDatasRequest;

	private string _actionName;

	private bool _isShowChange;

	private int _heroId;

	private bool _showHero;

	private string heroImg;

	private string heroName;

	public bool isPreview;

	private bool isSelf;

	private SimpleCommand leftBtnCmd;

	private SimpleCommand rightBtnCmd;

	public WeaponData WeaponData
	{
		get
		{
			return _weaponData;
		}
		private set
		{
			Set(ref _weaponData, value, "WeaponData");
		}
	}

	public string WeaponEnumName
	{
		get
		{
			return _weaponEnumName;
		}
		set
		{
			Set(ref _weaponEnumName, value, "WeaponEnumName");
		}
	}

	public string LeftBtnText
	{
		get
		{
			return _leftBtnText;
		}
		set
		{
			Set(ref _leftBtnText, value, "LeftBtnText");
		}
	}

	public string RightBtnText
	{
		get
		{
			return _rightBtnText;
		}
		set
		{
			Set(ref _rightBtnText, value, "RightBtnText");
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

	public string ActionName
	{
		get
		{
			return _actionName;
		}
		set
		{
			Set(ref _actionName, value, "ActionName");
		}
	}

	public bool IsShowChange
	{
		get
		{
			return _isShowChange;
		}
		set
		{
			Set(ref _isShowChange, value, "IsShowChange");
		}
	}

	public int HeroId
	{
		get
		{
			return _heroId;
		}
		set
		{
			Set(ref _heroId, value, "HeroId");
		}
	}

	public bool ShowHero
	{
		get
		{
			return _showHero;
		}
		set
		{
			Set(ref _showHero, value, "ShowHero");
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

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public InteractionRequest RefreshDatasRequest => _refreshDatasRequest;

	public SimpleCommand LeftBtnCmd => leftBtnCmd;

	public SimpleCommand RightBtnCmd => rightBtnCmd;

	public WeaponDetailViewModel(OptionBase parent, WeaponData weaponData)
	{
		base.parent = parent;
		leftBtnCmd = new SimpleCommand(LeftBtnOnclick);
		rightBtnCmd = new SimpleCommand(RightBtnOnclick);
		_refreshDatasRequest = new InteractionRequest();
		_weaponData = weaponData;
		_weaponEnumName = UiConvert.Equip.WeaponEnum2Name[WeaponData.WeaponEnum];
		_attributeItemData = new List<AttributeItemData>();
		_entryItemData = new List<EntryItemData>();
		RefreshData(weaponData);
		_isShowChange = true;
		ShowHero = true;
		IsSelf = true;
		HeroId = 0;
		HeroImg = "1104_SmallIcon";
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && optionArg.OptionName.Equals("OnShowEntryPanel"))
		{
			parent.ItemOnClick(optionArg);
		}
	}

	public async void RefreshData(WeaponData data, bool isShowChange = true)
	{
		WeaponData = data;
		RefreshAttribute();
		IsShowChange = isShowChange;
		await UniTask.Delay(200);
		ResetLeftCmd();
		ResetRightCmd();
	}

	public void SetHeroImg(int id = 0)
	{
		HeroId = WeaponData.GetOwnerId();
		if (id == HeroId || HeroId == 0)
		{
			ShowHero = false;
			return;
		}
		ShowHero = true;
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(HeroId);
		if (heroById != null)
		{
			HeroImg = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, heroById);
		}
		else
		{
			HeroImg = string.Empty;
		}
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(HeroId);
		if (dataRow != null)
		{
			HeroName = dataRow.Name + "已装备";
		}
	}

	private void RefreshAttribute()
	{
		try
		{
			AttributeItemData.Clear();
			EntryItemData.Clear();
			if (WeaponData == null)
			{
				return;
			}
			foreach (EquipAttribute equipAttribute in WeaponData.EquipAttributeList)
			{
				float baseValue = equipAttribute.BaseValue;
				AttributeItemData.Add(new AttributeItemData(equipAttribute, baseValue));
			}
			foreach (EntryData entryData in WeaponData.EntryDataList)
			{
				EntryItemData.Add(new EntryItemData(this, entryData));
			}
			_refreshDatasRequest.Raise();
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	public async void Lock()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ChangeLock(5, WeaponData.Uid);
		loading.Dispose();
		if (num)
		{
			WeaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(WeaponData.Uid);
		}
	}

	private void LeftBtnOnclick()
	{
		leftBtnCmd.Enabled = false;
		ActionName = "ChangeWeapon";
		parent?.ItemOnClick(this);
	}

	private void RightBtnOnclick()
	{
		rightBtnCmd.Enabled = false;
		ActionName = "OpenCulture";
		parent?.ItemOnClick(this);
	}

	public void ResetLeftCmd()
	{
		leftBtnCmd.Enabled = true;
	}

	public void ResetRightCmd()
	{
		rightBtnCmd.Enabled = true;
	}
}
