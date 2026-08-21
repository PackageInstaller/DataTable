using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Ase;

public class RacingModeWindow : UGuiWindow
{
	[Serializable]
	private class SelectDropdown
	{
		[SerializeField]
		private TMP_Dropdown dropdown;

		private int selectValue;

		private int minIndex;

		private Func<int, int> onSelected;

		public void InitDropdown(List<OptionData> heroOption, Func<int, int> onSelected, int defaultIndex = 0, int minIndex = 0)
		{
			this.minIndex = minIndex;
			dropdown.options = heroOption;
			this.onSelected = onSelected;
			((UnityEvent<int>)(object)dropdown.onValueChanged).AddListener((UnityAction<int>)OnSelected);
			SetValue(defaultIndex);
		}

		public void SetValue(int value)
		{
			dropdown.value = value;
			OnSelected(value);
		}

		internal int GetValue()
		{
			return dropdown.value;
		}

		public void OnSelected(int index)
		{
			if (minIndex > index)
			{
				index = minIndex;
				dropdown.value = index;
			}
			if (onSelected != null)
			{
				selectValue = onSelected(index);
			}
		}

		internal int GetSelectValue()
		{
			return selectValue;
		}
	}

	public static bool init;

	public bool lockCopy = true;

	public bool invertConditionCopy;

	public List<int> lockCopyList = new List<int> { 20025 };

	public bool lockHero = true;

	public bool invertConditionHero;

	public List<int> lockHeroList = new List<int>
	{
		1001, 1002, 1005, 1007, 1103, 1104, 1201, 1205, 1206, 1602,
		1604, 1606, 1608, 1708
	};

	public int costomCultivateLevel = 2;

	public bool lockBattleProp = true;

	public bool invertConditionBattleProp;

	public List<int> lockBattlePropList = new List<int>
	{
		50110016, 50110026, 50120013, 50120023, 50130013, 50210016, 50210026, 50220013, 50220023, 50230013,
		50310016, 50310026, 50320013, 50320023, 50330013
	};

	[SerializeField]
	private Button enterBattleButton;

	[SerializeField]
	private SelectDropdown copyDropdown = new SelectDropdown();

	[SerializeField]
	private SelectDropdown heroDropdown_1 = new SelectDropdown();

	[SerializeField]
	private SelectDropdown heroDropdown_2 = new SelectDropdown();

	[SerializeField]
	private SelectDropdown heroDropdown_3 = new SelectDropdown();

	[SerializeField]
	private SelectDropdown battlePropDropdown_1 = new SelectDropdown();

	[SerializeField]
	private TextMeshProUGUI battlePropDropdownDesc_1;

	[SerializeField]
	private SelectDropdown battlePropDropdown_2 = new SelectDropdown();

	[SerializeField]
	private TextMeshProUGUI battlePropDropdownDesc_2;

	private List<OptionData> heroOption;

	private List<OptionData> copyListOption;

	private List<OptionData> battlePropOption;

	private DRHeroInfo[] drHeroInfoes;

	private DRCopy[] copys;

	private DRBattlePropInfo[] drBattleProps;

	private RacingModeViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		//IL_0214: Unknown result type (might be due to invalid IL or missing references)
		//IL_021e: Expected O, but got Unknown
		//IL_024b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0255: Expected O, but got Unknown
		//IL_032a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0334: Expected O, but got Unknown
		//IL_03a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_03ad: Expected O, but got Unknown
		//IL_03dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_03e6: Expected O, but got Unknown
		base.OnCreate(bundle);
		viewModel = GetData<RacingModeViewModel>();
		BindingSet<RacingModeWindow, RacingModeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((RacingModeWindow v) => v.OnDismissRequest).To((RacingModeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((RacingModeWindow v) => v.OpenUguiWindow).To((RacingModeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		if (lockHero)
		{
			drHeroInfoes = GameEntry.DataTable.GetDataRows((DRHeroInfo p) => invertConditionHero ? (!lockHeroList.Contains(p.Id)) : lockHeroList.Contains(p.Id));
		}
		else
		{
			drHeroInfoes = GameEntry.DataTable.GetAllDataRow<DRHeroInfo>();
		}
		heroOption = new List<OptionData>
		{
			new OptionData("None")
		};
		DRHeroInfo[] array = drHeroInfoes;
		foreach (DRHeroInfo dRHeroInfo in array)
		{
			heroOption.Add(new OptionData(dRHeroInfo.Name ?? ""));
		}
		heroDropdown_1.InitDropdown(heroOption, OnHeroSelected, 0, 1);
		heroDropdown_2.InitDropdown(heroOption, OnHeroSelected, 1);
		heroDropdown_3.InitDropdown(heroOption, OnHeroSelected, 2);
		if (lockCopy)
		{
			copys = GameEntry.DataTable.GetDataRows((DRCopy p) => invertConditionCopy ? (!lockCopyList.Contains(p.Id)) : lockCopyList.Contains(p.Id));
		}
		else
		{
			copys = GameEntry.DataTable.GetAllDataRow<DRCopy>();
		}
		copyListOption = new List<OptionData>();
		DRCopy[] array2 = copys;
		foreach (DRCopy dRCopy in array2)
		{
			copyListOption.Add(new OptionData(dRCopy.Name ?? ""));
		}
		copyDropdown.InitDropdown(copyListOption, OnCopySelected);
		if (lockBattleProp)
		{
			drBattleProps = GameEntry.DataTable.GetDataRows((DRBattlePropInfo p) => invertConditionBattleProp ? (!lockBattlePropList.Contains(p.Id)) : lockBattlePropList.Contains(p.Id));
		}
		else
		{
			drBattleProps = GameEntry.DataTable.GetAllDataRow<DRBattlePropInfo>();
		}
		battlePropOption = new List<OptionData>
		{
			new OptionData("None")
		};
		DRBattlePropInfo[] array3 = drBattleProps;
		foreach (DRBattlePropInfo dRBattlePropInfo in array3)
		{
			battlePropOption.Add(new OptionData(dRBattlePropInfo.Name ?? ""));
		}
		battlePropDropdown_1.InitDropdown(battlePropOption, delegate(int index)
		{
			if (index == 0)
			{
				enterBattleButton.gameObject.SetActive(value: true);
				((TMP_Text)battlePropDropdownDesc_1).text = string.Empty;
				return drBattleProps[index].Id;
			}
			enterBattleButton.gameObject.SetActive(battlePropDropdown_1.GetValue() != battlePropDropdown_2.GetValue());
			((TMP_Text)battlePropDropdownDesc_1).text = drBattleProps[index - 1].Function;
			return drBattleProps[index - 1].Id;
		});
		((TMP_Text)battlePropDropdownDesc_1).text = drBattleProps[0].Function;
		battlePropDropdown_2.InitDropdown(battlePropOption, delegate(int index)
		{
			if (index == 0)
			{
				enterBattleButton.gameObject.SetActive(value: true);
				((TMP_Text)battlePropDropdownDesc_2).text = string.Empty;
				return drBattleProps[index].Id;
			}
			enterBattleButton.gameObject.SetActive(battlePropDropdown_1.GetValue() != battlePropDropdown_2.GetValue());
			((TMP_Text)battlePropDropdownDesc_2).text = drBattleProps[index - 1].Function;
			return drBattleProps[index - 1].Id;
		});
		((TMP_Text)battlePropDropdownDesc_2).text = drBattleProps[1].Function;
		enterBattleButton.onClick.AddListener(OnBtnEnterClick);
		string[] array4 = PlayerPrefs.GetString("RacingModeEnterData", "0-1-2-0-0-0").Split('-');
		if (array4.Length == 6)
		{
			int num2 = int.Parse(array4[0]);
			if (num2 < 0 || num2 > drHeroInfoes.Length)
			{
				num2 = 0;
			}
			heroDropdown_1.SetValue(num2);
			num2 = int.Parse(array4[1]);
			if (num2 < 0 || num2 > drHeroInfoes.Length)
			{
				num2 = 0;
			}
			heroDropdown_2.SetValue(num2);
			num2 = int.Parse(array4[2]);
			if (num2 < 0 || num2 > drHeroInfoes.Length)
			{
				num2 = 0;
			}
			heroDropdown_3.SetValue(num2);
			num2 = int.Parse(array4[3]);
			if (num2 < 0 || num2 >= copys.Length)
			{
				num2 = 0;
			}
			copyDropdown.SetValue(num2);
			num2 = int.Parse(array4[4]);
			if (num2 < 0 || num2 > drBattleProps.Length)
			{
				num2 = 0;
			}
			battlePropDropdown_1.SetValue(num2);
			num2 = int.Parse(array4[5]);
			if (num2 < 0 || num2 > drBattleProps.Length)
			{
				num2 = 0;
			}
			battlePropDropdown_2.SetValue(num2);
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
		if (!init)
		{
			init = true;
			Context.GetApplicationContext();
			Singleton<ServiceSystem>.Instance.RegisterGlobalService();
			Singleton<ServiceSystem>.Instance.RegisterSystemService();
		}
	}

	private int OnCopySelected(int index)
	{
		return copys[index].Id;
	}

	private int OnHeroSelected(int index)
	{
		if (index == 0)
		{
			return drHeroInfoes[index].Id;
		}
		return drHeroInfoes[index - 1].Id;
	}

	protected override void OnShow()
	{
	}

	private void OnBtnEnterClick()
	{
		Game.AddSingleton<OuterSystem>();
		PlayerPrefs.SetString("RacingModeEnterData", $"{heroDropdown_1.GetValue()}-{heroDropdown_2.GetValue()}-{heroDropdown_3.GetValue()}-{copyDropdown.GetValue()}-{battlePropDropdown_1.GetValue()}-{battlePropDropdown_2.GetValue()}");
		List<TeamMember> list = new List<TeamMember>();
		if (GameEntry.DataTable.GetDataRow<DRHero>(heroDropdown_1.GetSelectValue()) == null)
		{
			return;
		}
		Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
		DRBattlePropInfo dRBattlePropInfo = null;
		if (battlePropDropdown_1.GetValue() > 0)
		{
			dRBattlePropInfo = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.Id == battlePropDropdown_1.GetSelectValue());
		}
		DRBattlePropInfo dRBattlePropInfo2 = null;
		if (battlePropDropdown_2.GetValue() > 0)
		{
			dRBattlePropInfo2 = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.Id == battlePropDropdown_2.GetSelectValue());
		}
		dictionary.Add(1, (dRBattlePropInfo == null) ? null : BPData.Create(dRBattlePropInfo, isLock: false, dRBattlePropInfo.TakeLimit));
		dictionary.Add(2, (dRBattlePropInfo2 == null) ? null : BPData.Create(dRBattlePropInfo2, isLock: false, dRBattlePropInfo2.TakeLimit));
		DRCostomCultivate dataRow = GameEntry.DataTable.GetDataRow<DRCostomCultivate>(costomCultivateLevel);
		Dictionary<int, HCTalentData> talentData = null;
		if (dataRow != null && dataRow.HeroskillLv == 1)
		{
			talentData = GetTalentData(heroDropdown_1.GetSelectValue());
		}
		List<int> seatLevel = new List<int>();
		if (dataRow != null && dataRow.HerosoulLv == 1)
		{
			seatLevel = new List<int> { 1, 2, 3, 4, 5, 6, 7 };
		}
		HeroModel heroModel = new HeroModel(heroDropdown_1.GetSelectValue(), 0, dataRow?.HeroLv ?? 1, talentData, seatLevel, dictionary);
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroData(heroModel.Id, heroModel, cover: true);
		list.Add(new TeamMember(1, isCaptain: true, heroModel));
		if (heroDropdown_2.GetValue() != 0)
		{
			DRCostomCultivate dataRow2 = GameEntry.DataTable.GetDataRow<DRCostomCultivate>(costomCultivateLevel);
			Dictionary<int, HCTalentData> talentData2 = null;
			if (dataRow2 != null && dataRow2.HeroskillLv == 1)
			{
				talentData2 = GetTalentData(heroDropdown_2.GetSelectValue());
			}
			List<int> seatLevel2 = new List<int>();
			if (dataRow2 != null && dataRow2.HerosoulLv == 1)
			{
				seatLevel2 = new List<int> { 1, 2, 3, 4, 5, 6, 7 };
			}
			HeroModel heroModel2 = new HeroModel(heroDropdown_2.GetSelectValue(), 0, dataRow2?.HeroLv ?? 1, talentData2, seatLevel2, null);
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroData(heroModel2.Id, heroModel2, cover: true);
			list.Add(new TeamMember(2, isCaptain: false, heroModel2, isSelf: false, isAi: true));
		}
		if (heroDropdown_3.GetValue() != 0)
		{
			DRCostomCultivate dataRow3 = GameEntry.DataTable.GetDataRow<DRCostomCultivate>(costomCultivateLevel);
			Dictionary<int, HCTalentData> talentData3 = null;
			if (dataRow3 != null && dataRow3.HeroskillLv == 1)
			{
				talentData3 = GetTalentData(heroDropdown_3.GetSelectValue());
			}
			List<int> seatLevel3 = new List<int>();
			if (dataRow3 != null && dataRow3.HerosoulLv == 1)
			{
				seatLevel3 = new List<int> { 1, 2, 3, 4, 5, 6, 7 };
			}
			HeroModel heroModel3 = new HeroModel(heroDropdown_3.GetSelectValue(), 0, dataRow3?.HeroLv ?? 1, talentData3, seatLevel3, null);
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroData(heroModel3.Id, heroModel3, cover: true);
			list.Add(new TeamMember(3, isCaptain: false, heroModel3, isSelf: false, isAi: true));
		}
		CopyData copyData = null;
		if (copyDropdown.GetSelectValue() != 0)
		{
			DRCopy dataRow4 = GameEntry.DataTable.GetDataRow<DRCopy>(copyDropdown.GetSelectValue());
			if (dataRow4 != null)
			{
				copyData = CopyData.CreateTemp(dataRow4);
			}
		}
		List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
		for (int num = 0; num < list.Count; num++)
		{
			list2.Add(list[num].GetPeripheryHeroData());
		}
		WorldData worldData = BattleWorldData.CreateBattleWorldData(0u, copyData.SceneName, copyData?.Id ?? 0, copyData?.GetBossId(0) ?? 0, (copyData == null) ? "Battle" : copyData.MapData, copyData?.NavMeshId ?? 1, list2, list, null, null);
		viewModel.OnBtnEnterClick(worldData);
	}

	private Dictionary<int, HCTalentData> GetTalentData(int heroId)
	{
		Dictionary<int, HCTalentData> dictionary = new Dictionary<int, HCTalentData>();
		DRHeroTalentBig[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentBig p) => p.HeroId == heroId && p.Level == 1);
		if (dataRows != null && dataRows.Length != 0)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				dictionary.Add(dataRows[num].SkillId, HCTalentData.Create(dataRows[num].SkillId, 12, 503));
			}
		}
		return dictionary;
	}

	private List<AchievementMedal> InitBattleAchievement()
	{
		Dictionary<int, AchievementMedal> dictionary = new Dictionary<int, AchievementMedal>();
		try
		{
			DRAchievementMedal[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetAllDataRows();
			foreach (DRAchievementMedal dRAchievementMedal in allDataRows)
			{
				if (!dictionary.ContainsKey(dRAchievementMedal.MedalId))
				{
					dictionary.Add(value: new AchievementMedal
					{
						MedalId = dRAchievementMedal.MedalId,
						MedalNum = 0,
						MedalRank = 0,
						MedalName = dRAchievementMedal.Name,
						MedalDesc = dRAchievementMedal.Desc,
						MedalRarity = dRAchievementMedal.Rarity,
						ConditionList = dRAchievementMedal.Condition,
						BattleTarget = dRAchievementMedal.BattleTarget,
						MedalIcon = dRAchievementMedal.MedalIcon,
						AchievementType = dRAchievementMedal.AchievementType,
						BattleObserverEventEnum = dRAchievementMedal.BattleObserverEventEnum
					}, key: dRAchievementMedal.MedalId);
				}
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
		List<AchievementMedal> list = new List<AchievementMedal>();
		foreach (KeyValuePair<int, AchievementMedal> item in dictionary)
		{
			if (item.Value.AchievementType == 1 && item.Value.BattleObserverEventEnum != BattleObserverEventEnum.None)
			{
				list.Add(item.Value);
			}
		}
		return list;
	}
}
