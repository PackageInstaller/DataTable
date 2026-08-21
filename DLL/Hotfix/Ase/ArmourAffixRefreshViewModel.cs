using System.Collections.Generic;
using System.Text;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class ArmourAffixRefreshViewModel : OptionBase
{
	private ArmourData _armourData;

	private KnapsackItemViewModel _costPropItemData;

	private SimpleCommand _refreshAffixCmd;

	private InteractionRequest _refreshAnimateRst = new InteractionRequest();

	private InteractionRequest _armourRefreshRst = new InteractionRequest();

	private SimpleCommand<string> _openWindowRst;

	private bool _btnRefreshMask;

	private string _btnRefreshText;

	private string _costPropCount;

	private bool _costEnough;

	private ISubscription<PropChangeMessage> sub_knapsackChanged;

	public List<string> PreferenceOptions = new List<string>
	{
		"FixHp", "HpRadio", "FixDefence", "DefenceRadio", "FixAttack", "AttackRadio", "Crit", "CritRadio", "CureAddition", "CureExtraScale",
		"TenacityAddition"
	};

	private List<(DRAffix, bool)> _preferenceList = new List<(DRAffix, bool)>();

	public ArmourData ArmourData
	{
		get
		{
			return _armourData;
		}
		private set
		{
			Set(ref _armourData, value, "ArmourData");
		}
	}

	public KnapsackItemViewModel CostPropItemData => _costPropItemData;

	public List<(DRAffix, bool)> PreferenceList => _preferenceList;

	public SimpleCommand RefreshAffixCmd => _refreshAffixCmd;

	public InteractionRequest RefreshAnimateRst => _refreshAnimateRst;

	public InteractionRequest ArmourRefreshRst => _armourRefreshRst;

	public SimpleCommand<string> OpenWindowRst => _openWindowRst;

	public bool BtnRefreshMask
	{
		get
		{
			return _btnRefreshMask;
		}
		set
		{
			Set(ref _btnRefreshMask, value, "BtnRefreshMask");
		}
	}

	public string BtnRefreshText
	{
		get
		{
			return _btnRefreshText;
		}
		set
		{
			Set(ref _btnRefreshText, value, "BtnRefreshText");
		}
	}

	public string CostPropCount
	{
		get
		{
			return _costPropCount;
		}
		set
		{
			Set(ref _costPropCount, value, "CostPropCount");
		}
	}

	public bool CostEnough
	{
		get
		{
			return _costEnough;
		}
		set
		{
			Set(ref _costEnough, value, "CostEnough");
		}
	}

	public ArmourAffixRefreshViewModel(OptionBase parent, ArmourData armourData)
	{
		base.parent = parent;
		sub_knapsackChanged = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetMessager().Subscribe<PropChangeMessage>(OnKnapsackChanged);
		_refreshAffixCmd = new SimpleCommand(TryRefreshAffix);
		_openWindowRst = new SimpleCommand<string>(OpenWindow);
		LoadLocalPreference();
		RefreshArmour(armourData);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				parent?.ItemOnClick(openViewArg);
			}
		}
		base.ItemOnClick(obj);
	}

	public void SetVisible(bool visible)
	{
		visibleRequest.Raise(visible);
	}

	public void RefreshArmour(ArmourData armourData)
	{
		ArmourData = armourData;
		RefreshCostPropData();
		_armourRefreshRst.Raise();
	}

	private void RefreshCostPropData()
	{
		if (ArmourData == null || ArmourData.Empty)
		{
			return;
		}
		DREquipGrade dataRow = GameEntry.DataTable.GetDataRow((DREquipGrade p) => p.TargetLevel == ArmourData.Level && p.Rank == ArmourData.Rank && p.Quality == ArmourData.GetRarity());
		if (dataRow == null)
		{
			return;
		}
		if (_costPropItemData == null)
		{
			int id = (int)(GameEntry.DataTable.GetDataRow<DRConstantConfig>(1037)?.Value ?? 0f);
			DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(id);
			if (dataRow2 == null)
			{
				return;
			}
			_costPropItemData = new KnapsackItemViewModel(this, new PropDataBase(dataRow2, dataRow.RerollCost));
		}
		else
		{
			_costPropItemData.PropDataBase.Amount = dataRow.RerollCost;
		}
		RefreshBtnRefreshState();
	}

	private void RefreshBtnRefreshState()
	{
		if (_costPropItemData?.PropDataBase == null || _costPropItemData.PropDataBase.Empty)
		{
			CostEnough = false;
			return;
		}
		CostEnough = PropHelper.CheckPropEnough(_costPropItemData.PropDataBase.Id, _costPropItemData.PropDataBase.Amount);
		CostPropCount = $"{_costPropItemData.PropDataBase.Amount}";
		BtnRefreshText = "雕琢";
	}

	private void TryRefreshAffix()
	{
		if (!CostEnough)
		{
			OpenWindow("OpenPropExc");
			return;
		}
		(bool, string) tuple = CheckPreference();
		if (tuple.Item1)
		{
			IAsyncResult<int> result = AlertDialog.Show("提示", "当前明饰副属性含有偏好副属性<color=#9a2100>" + tuple.Item2 + "</color>,确定要进行雕琢吗?", "确定", "取消");
			result.Callbackable().OnCallback(delegate
			{
				if (result.Result == -1)
				{
					RequestRefreshAffix();
				}
			});
		}
		else
		{
			RequestRefreshAffix();
		}
	}

	private async void RequestRefreshAffix()
	{
		_refreshAffixCmd.Enabled = false;
		if (await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RefreshArmourAffixRst(ArmourData.Uid))
		{
			_refreshAnimateRst.Raise();
			RefreshCostPropData();
		}
		_refreshAffixCmd.Enabled = true;
	}

	private (bool, string) CheckPreference()
	{
		if (ArmourData == null || ArmourData.Empty)
		{
			return (false, string.Empty);
		}
		List<(DRAffix, bool)> curPrefList = _preferenceList.FindAll(((DRAffix, bool) p) => p.Item2);
		if (curPrefList.Count <= 0)
		{
			return (false, string.Empty);
		}
		List<EquipAttribute> subAttribute = ArmourData.GetSubAttribute();
		if (subAttribute == null)
		{
			return (false, string.Empty);
		}
		bool flag = false;
		StringBuilder stringBuilder = new StringBuilder();
		if (curPrefList.Count == 1)
		{
			EquipAttribute equipAttribute = subAttribute.Find((EquipAttribute p) => p.Id == curPrefList[0].Item1.Id);
			if (equipAttribute != null)
			{
				flag = true;
				stringBuilder.Append(equipAttribute.AttributeName);
			}
		}
		else
		{
			foreach (EquipAttribute subAffix in subAttribute)
			{
				if (curPrefList.Exists(((DRAffix, bool) p) => p.Item1.Id == subAffix.Id))
				{
					if (!flag)
					{
						flag = true;
						stringBuilder.Append(subAffix.AttributeName);
					}
					else
					{
						stringBuilder.Append("、" + subAffix.AttributeName);
					}
					continue;
				}
				flag = false;
				stringBuilder.Clear();
				break;
			}
		}
		return (flag, stringBuilder.ToString());
	}

	private void OnKnapsackChanged(PropChangeMessage message)
	{
		RefreshBtnRefreshState();
	}

	public void SetWindowMaskTime(float maskDuration)
	{
		parent?.ItemOnClick(new OptionArg(maskDuration, "UpdateWindowMaskTime"));
	}

	private void OpenWindow(string str)
	{
		_openWindowRst.Enabled = false;
		if (str.Equals("OpenRule"))
		{
			parent?.ItemOnClick(new OpenViewArg(typeof(GamePlayTipsWindow), new GamePlayTipsViewModel(parent, 2003), "ArmourAffixRefresh", isOpenWindow: true, "DEFAULT", delegate
			{
				_openWindowRst.Enabled = true;
			}));
		}
		else if (str.Equals("OpenArmourFilterWindow"))
		{
			parent?.ItemOnClick(new OptionArg(this, str));
		}
		else if (str.Equals("OpenPropExc"))
		{
			OpenArmourAffixRefreshExc();
		}
		else
		{
			_openWindowRst.Enabled = true;
		}
	}

	private void OpenArmourAffixRefreshExc()
	{
		int num = (int)(GameEntry.DataTable.GetDataRow<DRConstantConfig>(1037)?.Value ?? 0f);
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(num);
		if (dataRow == null)
		{
			_openWindowRst.Enabled = true;
			return;
		}
		(int, int) target = (num, dataRow.EX1);
		List<(int, int)> list = new List<(int, int)>();
		DRProp[] dataRows = GameEntry.DataTable.GetDataRows((DRProp p) => p.UseType.Contains(2));
		foreach (DRProp dRProp in dataRows)
		{
			list.Add((dRProp.Id, dRProp.EX1));
		}
		PropExcUseExpViewModel propExcUseExpViewModel = new PropExcUseExpViewModel(parent, target, list);
		propExcUseExpViewModel.SetTips1("兑换所需明饰经验道具");
		parent?.ItemOnClick(new OpenViewArg(typeof(PropExcUseExpWindow), propExcUseExpViewModel, "ArmourAffixRefresh", isOpenWindow: true, "DEFAULT", delegate
		{
			_openWindowRst.Enabled = true;
		}));
	}

	protected override void Dispose(bool disposing)
	{
		sub_knapsackChanged?.Dispose();
		sub_knapsackChanged = null;
		base.Dispose(disposing);
	}

	public void SetPreference(DRAffix config, bool isOn)
	{
		string preferenceString = GetPreferenceString();
		int num = _preferenceList.FindIndex(((DRAffix, bool) p) => p.Item1.Id == config.Id);
		if (num >= 0)
		{
			_preferenceList[num] = (config, isOn);
			SaveLocalPreference();
			SendPreferenceTDA(preferenceString);
		}
	}

	private string GetLocalPreferenceKey()
	{
		return $"Armour_AffixRefreshPreference_{(Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.Uid).GetValueOrDefault()}";
	}

	private void LoadLocalPreference()
	{
		string value = PlayerPrefs.GetString(GetLocalPreferenceKey(), "");
		List<int> list = new List<int>();
		if (!string.IsNullOrEmpty(value))
		{
			list = JsonConvert.DeserializeObject<List<int>>(value) ?? new List<int>();
		}
		_preferenceList.Clear();
		foreach (string affixKey in PreferenceOptions)
		{
			DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
			if (dataRow != null)
			{
				_preferenceList.Add((dataRow, list.Contains(dataRow.Id)));
			}
		}
	}

	private void SaveLocalPreference()
	{
		List<int> selectAffixIds = new List<int>();
		_preferenceList.ForEach(delegate((DRAffix, bool) p)
		{
			if (p.Item2)
			{
				selectAffixIds.Add(p.Item1.Id);
			}
		});
		string value = JsonConvert.SerializeObject(selectAffixIds);
		PlayerPrefs.SetString(GetLocalPreferenceKey(), value);
	}

	private string GetPreferenceString()
	{
		if (_preferenceList == null || _preferenceList.Count <= 0)
		{
			return "";
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (var preference in _preferenceList)
		{
			if (preference.Item2)
			{
				stringBuilder.Append(preference.Item1?.Desc + " ");
			}
		}
		return stringBuilder.ToString();
	}

	private void SendPreferenceTDA(string beforePreference)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("preference_before", beforePreference);
		dictionary.Add("preference_after", GetPreferenceString());
		TDAHandler.Instance.SendUserEvent("armor_carve_preference", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}
}
