using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class WeaponRefineViewModel : OptionBase
{
	private WeaponData weaponData;

	private int refine;

	private int nextRefine;

	private int realRefine;

	private string effectName;

	private string curEffectDescText = "";

	private string nextEffectDescText = "";

	private bool isMax;

	private SimpleCommand confirmCmd;

	private List<WeaponMaterialItemData> costMaterialList;

	private int realCostCount;

	private List<WeaponMaterialItemData> materialList;

	private bool isOpenMaterialView;

	private WeaponPopupViewModel weaponPopupViewModel;

	private InteractionRequest refreshMaterialList;

	public int Refine
	{
		get
		{
			return refine;
		}
		set
		{
			Set(ref refine, value, "Refine");
		}
	}

	public int NextRefine
	{
		get
		{
			return nextRefine;
		}
		set
		{
			Set(ref nextRefine, value, "NextRefine");
		}
	}

	public string EffectName
	{
		get
		{
			return effectName;
		}
		set
		{
			Set(ref effectName, value, "EffectName");
		}
	}

	public string CurEffectDescText
	{
		get
		{
			return curEffectDescText;
		}
		set
		{
			Set(ref curEffectDescText, value, "CurEffectDescText");
		}
	}

	public string NextEffectDescText
	{
		get
		{
			return nextEffectDescText;
		}
		set
		{
			Set(ref nextEffectDescText, value, "NextEffectDescText");
		}
	}

	public bool IsMax
	{
		get
		{
			return isMax;
		}
		set
		{
			Set(ref isMax, value, "IsMax");
		}
	}

	public List<WeaponMaterialItemData> MaterialList
	{
		get
		{
			return materialList;
		}
		set
		{
			Set(ref materialList, value, "MaterialList");
		}
	}

	public List<WeaponMaterialItemData> CostMaterialList
	{
		get
		{
			return costMaterialList;
		}
		set
		{
			Set(ref costMaterialList, value, "CostMaterialList");
		}
	}

	public bool IsOpenMaterialView
	{
		get
		{
			return isOpenMaterialView;
		}
		set
		{
			Set(ref isOpenMaterialView, value, "IsOpenMaterialView");
		}
	}

	public SimpleCommand ConfirmCmd => confirmCmd;

	public InteractionRequest RefreshMaterialList => refreshMaterialList;

	public WeaponRefineViewModel(OptionBase parent, WeaponData weaponData)
	{
		base.parent = parent;
		this.weaponData = weaponData;
		confirmCmd = new SimpleCommand(UpRefine);
		costMaterialList = new List<WeaponMaterialItemData>();
		for (int i = 0; i < 4; i++)
		{
			CostMaterialList.Add(new WeaponMaterialItemData(this));
		}
		materialList = new List<WeaponMaterialItemData>();
		refreshMaterialList = new InteractionRequest();
		refine = weaponData.WeaponRefine;
		effectName = weaponData.EffectName;
		nextRefine = Refine + 1;
		IsMax = Refine == 5;
		ClearCostMaterialList();
		LoadMaterialList();
		SetRefineText();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is WeaponMaterialItemData weaponMaterialItemData && "OnClick".Equals(optionArg.OptionName) && IsOpenMaterialView)
			{
				OpenProp(weaponMaterialItemData);
				if (weaponMaterialItemData.WeaponData.IsLock)
				{
					Toast.ShowInfo("该武魂已上锁,需先解锁");
				}
				else if (weaponMaterialItemData.IsSelected)
				{
					RemoveCostMaterial(weaponMaterialItemData);
				}
				else if (realCostCount > 0 && nextRefine >= 5)
				{
					Toast.ShowInfo("已达到武魂精炼最大等级");
				}
				else if (realCostCount == 4)
				{
					Toast.ShowInfo("已达到武魂选择最大数量");
				}
				else
				{
					AddCostMaterial(weaponMaterialItemData);
				}
			}
		}
		else
		{
			if (!(obj is WeaponPopupViewModel weaponPopupViewModel))
			{
				return;
			}
			foreach (WeaponMaterialItemData material in MaterialList)
			{
				if (material.WeaponData.Uid == weaponPopupViewModel.WeaponData.Uid)
				{
					if (material.IsSelected)
					{
						RemoveCostMaterial(material);
					}
					material.IsLock = weaponPopupViewModel.WeaponData.IsLock;
				}
			}
		}
	}

	private void RemoveCostMaterial(WeaponMaterialItemData weaponMaterialItemData)
	{
		weaponMaterialItemData.IsSelected = false;
		for (int i = 0; i < CostMaterialList.Count; i++)
		{
			if (CostMaterialList[i].WeaponData.Uid == weaponMaterialItemData.WeaponData.Uid)
			{
				CostMaterialList[i].SetEmpty();
				realCostCount--;
				break;
			}
		}
		if (realCostCount == 0)
		{
			NextRefine = Refine + 1;
			realRefine = refine;
		}
		else
		{
			NextRefine = ((realRefine - weaponMaterialItemData.WeaponData.WeaponRefine > 5) ? 5 : (realRefine - weaponMaterialItemData.WeaponData.WeaponRefine));
			realRefine -= weaponMaterialItemData.WeaponData.WeaponRefine;
		}
		SetRefineText();
	}

	private void AddCostMaterial(WeaponMaterialItemData weaponMaterialItemData)
	{
		weaponMaterialItemData.IsSelected = true;
		for (int i = 0; i < CostMaterialList.Count; i++)
		{
			if (CostMaterialList[i].IsEmpty)
			{
				CostMaterialList[i].RefreshData(weaponMaterialItemData.WeaponData);
				realCostCount++;
				break;
			}
		}
		realRefine += weaponMaterialItemData.WeaponData.WeaponRefine;
		if (realCostCount == 1)
		{
			NextRefine = weaponMaterialItemData.WeaponData.WeaponRefine + Refine;
		}
		else
		{
			NextRefine = ((weaponMaterialItemData.WeaponData.WeaponRefine + NextRefine > 5) ? 5 : (weaponMaterialItemData.WeaponData.WeaponRefine + NextRefine));
		}
		SetRefineText();
	}

	private void SetRefineText()
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(weaponData.Id);
		if (dataRow.WeaponEffectId.Count == 0)
		{
			return;
		}
		CurEffectDescText = weaponData.EffectDesc;
		if (IsMax)
		{
			return;
		}
		List<List<float>> list = new List<List<float>>();
		foreach (List<float> item in dataRow.EffectValue)
		{
			list.Add(item);
		}
		switch (dataRow.EffectValue.Count)
		{
		case 1:
			NextEffectDescText = string.Format(dataRow.WeaponEffectDesc, list[0][NextRefine - 1]);
			break;
		case 2:
			NextEffectDescText = string.Format(dataRow.WeaponEffectDesc, list[0][NextRefine - 1], list[1][NextRefine - 1]);
			break;
		case 3:
			NextEffectDescText = string.Format(dataRow.WeaponEffectDesc, list[0][NextRefine - 1], list[1][NextRefine - 1], list[2][NextRefine - 1]);
			break;
		case 4:
			NextEffectDescText = string.Format(dataRow.WeaponEffectDesc, list[0][NextRefine - 1], list[1][NextRefine - 1], list[2][NextRefine - 1], list[3][NextRefine - 1]);
			break;
		}
	}

	public void CloseProp()
	{
		if (weaponPopupViewModel != null)
		{
			weaponPopupViewModel.Close();
		}
	}

	private async void OpenProp(WeaponMaterialItemData itemData)
	{
		weaponPopupViewModel = new WeaponPopupViewModel(this, itemData.WeaponData, showHeroInfo: false, -92f, 1f);
		weaponPopupViewModel.Mask2Width = 1560f;
		await GameEntry.UI.OpenWindow<WeaponPopupWindow>("PopupView/WeaponPopupWindow", "DEFAULT", weaponPopupViewModel);
	}

	public void OpenMaterialView()
	{
		IsOpenMaterialView = true;
		refreshMaterialList.Raise();
	}

	public void CloseMaterialView()
	{
		IsOpenMaterialView = false;
	}

	public void ReSetMaterial()
	{
		LoadMaterialList();
		refreshMaterialList.Raise();
		CloseMaterialView();
		ClearCostMaterialList();
	}

	private void ClearCostMaterialList()
	{
		foreach (WeaponMaterialItemData costMaterial in CostMaterialList)
		{
			costMaterial.SetEmpty();
		}
		foreach (WeaponMaterialItemData material in MaterialList)
		{
			material.IsSelected = false;
		}
		realCostCount = 0;
		NextRefine = Refine + 1;
		realRefine = Refine;
		SetRefineText();
	}

	private void LoadMaterialList()
	{
		MaterialList.Clear();
		Dictionary<long, WeaponData> allWeaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllWeaponData();
		Dictionary<long, int> heroHeldEquip = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroHeldEquip();
		foreach (KeyValuePair<long, WeaponData> item in allWeaponData)
		{
			if (!heroHeldEquip.ContainsKey(item.Key) && item.Value.Id == weaponData.Id && item.Value.WeaponRefine + weaponData.WeaponRefine <= 5 && item.Key != weaponData.Uid)
			{
				MaterialList.Add(new WeaponMaterialItemData(this, item.Value));
			}
		}
		MaterialList.Sort(new WeaponMaterialSort());
	}

	private async void UpRefine()
	{
		if (realCostCount <= 0)
		{
			Toast.ShowInfo("请先选择材料");
			return;
		}
		confirmCmd.Enabled = false;
		string text = "";
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		int num = weaponData.WeaponRefine;
		foreach (WeaponMaterialItemData costMaterial in CostMaterialList)
		{
			if (!costMaterial.IsEmpty)
			{
				if (costMaterial.WeaponData.WeaponRefine > 1)
				{
					flag = true;
				}
				if (costMaterial.WeaponData.Level > 1)
				{
					flag2 = true;
				}
				if (costMaterial.WeaponData.Rarity >= 3)
				{
					flag3 = true;
				}
				num += costMaterial.WeaponData.WeaponRefine;
			}
		}
		if (flag3)
		{
			text += "稀有度较高,";
		}
		if (flag)
		{
			text += "已精炼,";
		}
		if (flag2)
		{
			text += "已强化,";
		}
		if (num > 5)
		{
			text += "将超过精炼等级上限,";
		}
		string message = "消耗武魂<color=#b55b52>" + text + "</color>是否继续？";
		IAsyncResult<int> result = AlertDialog.Show("提示", message, "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				Send();
				confirmCmd.Enabled = true;
			}
			else
			{
				confirmCmd.Enabled = true;
			}
		});
	}

	private async void Send()
	{
		List<long> costWeaponList = new List<long>();
		foreach (WeaponMaterialItemData costMaterial in CostMaterialList)
		{
			if (!costMaterial.IsEmpty)
			{
				costWeaponList.Add(costMaterial.WeaponData.Uid);
			}
		}
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().WeaponUpRefine(weaponData.Id, weaponData.Uid, costWeaponList);
		loading.Dispose();
		if (num)
		{
			weaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(weaponData.Uid);
			LoadMaterialList();
			refreshMaterialList.Raise();
			ClearCostMaterialList();
			Refine = weaponData.WeaponRefine;
			NextRefine = Refine + 1;
			IsMax = Refine == 5;
			realRefine = Refine;
			SetRefineText();
			WeaponSuccessViewModel userData = new WeaponSuccessViewModel(weaponData, WeaponUpMode.UpRefine);
			openWindowRequest.Raise(new OpenViewArg(typeof(WeaponSuccessView), userData));
			parent.ItemOnClick(this);
		}
		else
		{
			await UIHelper.AccountDisconnect();
		}
	}
}
