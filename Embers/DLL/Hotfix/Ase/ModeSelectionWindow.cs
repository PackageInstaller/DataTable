#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ModeSelectionWindow : UGuiWindow
{
	public static bool init;

	[SerializeField]
	private Button BtnDesginer;

	[SerializeField]
	private Dropdown copyDropdown;

	[SerializeField]
	private Dropdown heroDropdown;

	[SerializeField]
	private Dropdown hero2Dropdown;

	[SerializeField]
	private Dropdown hero3Dropdown;

	[SerializeField]
	private Dropdown battlePropDropdown1;

	[SerializeField]
	private Dropdown battlePropDropdown2;

	[SerializeField]
	private Slider dpiSlider;

	[SerializeField]
	private Text dpiText;

	[SerializeField]
	private Button changeDpi;

	[SerializeField]
	private Toggle openScene;

	[SerializeField]
	private Toggle spiltScene;

	[SerializeField]
	private Toggle useCurScene;

	[SerializeField]
	private Toggle useGM;

	[SerializeField]
	private Toggle isBoss;

	[SerializeField]
	private Dropdown accountInitialDropdown1;

	[SerializeField]
	private Dropdown accountInitialDropdown2;

	[SerializeField]
	private Dropdown accountInitialDropdown3;

	[SerializeField]
	private int DefaultBossType;

	[SerializeField]
	private TMP_InputField skinID;

	[SerializeField]
	private TMP_InputField hero2SkinId;

	[SerializeField]
	private TMP_InputField hero3SkinId;

	[SerializeField]
	private Toggle isOnLine;

	[SerializeField]
	private Button onGetSeedClick;

	[SerializeField]
	private TMP_InputField randomSeed;

	private int selectCopy;

	private int selectHero;

	private int selectHero2;

	private int selectHero3;

	private int _selectBattleProp1;

	private int _selectBattleProp2;

	private int _customCultivate1;

	private int _customCultivate2;

	private int _customCultivate3;

	private ModeSelectionViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ModeSelectionViewModel>();
		BindingSet<ModeSelectionWindow, ModeSelectionViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ModeSelectionWindow v) => v.OnDismissRequest).To((ModeSelectionViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ModeSelectionWindow v) => v.OpenUguiWindow).To((ModeSelectionViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		BtnDesginer.onClick.AddListener(OnBtnEnterClick);
		onGetSeedClick.onClick.AddListener(SetRandomSeed);
		DRHeroInfo[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRHeroInfo>();
		List<Dropdown.OptionData> heroOption = new List<Dropdown.OptionData>();
		List<Dropdown.OptionData> heroNpcOption = new List<Dropdown.OptionData>();
		DRHeroInfo[] array = allDataRow;
		foreach (DRHeroInfo dRHeroInfo in array)
		{
			heroOption.Add(new Dropdown.OptionData($"{dRHeroInfo.Id} {dRHeroInfo.Name}"));
		}
		selectHero = allDataRow[0].Id;
		heroNpcOption.Add(new Dropdown.OptionData("None"));
		heroNpcOption.AddRange(heroOption);
		heroDropdown.options = heroOption;
		hero2Dropdown.options = heroNpcOption;
		hero3Dropdown.options = heroNpcOption;
		DRCostomCultivate[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRCostomCultivate>();
		List<Dropdown.OptionData> testOption1 = new List<Dropdown.OptionData>();
		List<Dropdown.OptionData> testOption2 = new List<Dropdown.OptionData>();
		List<Dropdown.OptionData> testOption3 = new List<Dropdown.OptionData>();
		DRCostomCultivate[] array2 = allDataRow2;
		foreach (DRCostomCultivate dRCostomCultivate in array2)
		{
			testOption1.Add(new Dropdown.OptionData($"{dRCostomCultivate.Id}"));
			testOption2.Add(new Dropdown.OptionData($"{dRCostomCultivate.Id}"));
			testOption3.Add(new Dropdown.OptionData($"{dRCostomCultivate.Id}"));
		}
		accountInitialDropdown1.options = testOption1;
		accountInitialDropdown2.options = testOption2;
		accountInitialDropdown3.options = testOption3;
		accountInitialDropdown1.onValueChanged.AddListener(delegate(int index)
		{
			_customCultivate1 = int.Parse(testOption1[index].text);
		});
		accountInitialDropdown2.onValueChanged.AddListener(delegate(int index)
		{
			_customCultivate2 = int.Parse(testOption2[index].text);
		});
		accountInitialDropdown3.onValueChanged.AddListener(delegate(int index)
		{
			_customCultivate3 = int.Parse(testOption3[index].text);
		});
		List<Dropdown.OptionData> battlePropOption = new List<Dropdown.OptionData>();
		DRBattlePropInfo[] allDataRow3 = GameEntry.DataTable.GetAllDataRow<DRBattlePropInfo>();
		foreach (DRBattlePropInfo dRBattlePropInfo in allDataRow3)
		{
			battlePropOption.Add(new Dropdown.OptionData($"{dRBattlePropInfo.Id}"));
		}
		battlePropDropdown1.options = battlePropOption;
		battlePropDropdown1.onValueChanged.AddListener(delegate(int index)
		{
			_selectBattleProp1 = int.Parse(battlePropOption[index].text);
		});
		battlePropDropdown2.options = battlePropOption;
		battlePropDropdown2.onValueChanged.AddListener(delegate(int index)
		{
			_selectBattleProp2 = int.Parse(battlePropOption[index].text);
		});
		heroDropdown.onValueChanged.AddListener(delegate(int index)
		{
			selectHero = int.Parse(heroOption[index].text.Split(' ')[0]);
		});
		hero2Dropdown.onValueChanged.AddListener(delegate(int index)
		{
			try
			{
				if (heroNpcOption[index].text.Equals("None"))
				{
					selectHero2 = 0;
				}
				else
				{
					selectHero2 = int.Parse(heroNpcOption[index].text.Split(' ')[0]);
				}
			}
			catch (Exception)
			{
				selectHero2 = 0;
			}
		});
		hero3Dropdown.onValueChanged.AddListener(delegate(int index)
		{
			try
			{
				if (heroNpcOption[index].text.Equals("None"))
				{
					selectHero3 = 0;
				}
				else
				{
					selectHero3 = int.Parse(heroNpcOption[index].text.Split(' ')[0]);
				}
			}
			catch (Exception)
			{
				selectHero3 = 0;
			}
		});
		dpiSlider.onValueChanged.AddListener(delegate(float value)
		{
			float num2 = (float)Math.Round(value, 2);
			dpiText.text = num2.ToString("F2");
		});
		changeDpi.onClick.AddListener(delegate
		{
			QualitySettings.resolutionScalingFixedDPIFactor = dpiSlider.value;
		});
		spiltScene.onValueChanged.AddListener(delegate(bool b)
		{
			openScene.isOn = b;
		});
		useCurScene.onValueChanged.AddListener(delegate(bool b)
		{
			if (b)
			{
				openScene.isOn = false;
			}
		});
		dpiSlider.value = QualitySettings.resolutionScalingFixedDPIFactor;
		DRCopy[] allDataRow4 = GameEntry.DataTable.GetAllDataRow<DRCopy>();
		List<Dropdown.OptionData> copyListOption = new List<Dropdown.OptionData>();
		copyListOption.Add(new Dropdown.OptionData("0-默认场景"));
		DRCopy[] array3 = allDataRow4;
		foreach (DRCopy dRCopy in array3)
		{
			copyListOption.Add(new Dropdown.OptionData($"{dRCopy.Id}-{dRCopy.Name}"));
		}
		copyDropdown.options = copyListOption;
		copyDropdown.onValueChanged.AddListener(delegate(int index)
		{
			selectCopy = int.Parse(copyListOption[index].text.Split('-')[0]);
		});
		string[] array4 = PlayerPrefs.GetString("BattleEntryData", "0-0-0-0-0-0-0-0-0-False-0").Split('-');
		if (array4.Length == 11)
		{
			heroDropdown.value = int.Parse(array4[0]);
			hero2Dropdown.value = int.Parse(array4[1]);
			hero3Dropdown.value = int.Parse(array4[2]);
			copyDropdown.value = int.Parse(array4[3]);
			battlePropDropdown1.value = int.Parse(array4[4]);
			battlePropDropdown2.value = int.Parse(array4[5]);
			accountInitialDropdown1.value = int.Parse(array4[6]);
			accountInitialDropdown2.value = int.Parse(array4[7]);
			accountInitialDropdown3.value = int.Parse(array4[8]);
			isOnLine.isOn = bool.Parse(array4[9]);
			randomSeed.text = array4[10];
		}
		else
		{
			Log.Error("策划入口本地缓存数据有误！");
			heroDropdown.value = ((!heroOption[0].text.Equals("None")) ? int.Parse(heroOption[0].text.Split(' ')[0]) : 0);
			hero2Dropdown.value = ((!heroNpcOption[0].text.Equals("None")) ? int.Parse(heroNpcOption[0].text.Split(' ')[0]) : 0);
			hero3Dropdown.value = ((!heroNpcOption[0].text.Equals("None")) ? int.Parse(heroNpcOption[0].text.Split(' ')[0]) : 0);
			copyDropdown.value = int.Parse(copyListOption[0].text.Split('-')[0]);
			battlePropDropdown1.value = int.Parse(battlePropOption[0].text);
			battlePropDropdown2.value = int.Parse(battlePropOption[0].text);
		}
	}

	private void SetRandomSeed()
	{
		randomSeed.text = UnityEngine.Random.Range(-50000, 50000).ToString();
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

	private void OnBtnEnterClick()
	{
		Game.AddSingleton<OuterSystem>();
		PlayerPrefs.SetString("BattleEntryData", $"{heroDropdown.value}-{hero2Dropdown.value}-{hero3Dropdown.value}-" + $"{copyDropdown.value}-{battlePropDropdown1.value}-{battlePropDropdown2.value}-" + $"{accountInitialDropdown1.value}-{accountInitialDropdown2.value}-" + $"{accountInitialDropdown3.value}-" + $"{isOnLine.isOn}-" + randomSeed.text);
		List<TeamMember> list = new List<TeamMember>();
		selectHero = ((selectHero == 0) ? 1104 : selectHero);
		if (GameEntry.DataTable.GetDataRow<DRHero>(selectHero) == null)
		{
			Log.Error("<color=red>角色不存在</color>");
			return;
		}
		Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
		DRBattlePropInfo dataRow = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.Id == _selectBattleProp1);
		DRBattlePropInfo dataRow2 = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.Id == _selectBattleProp2);
		dictionary.Add(1, (dataRow == null) ? null : BPData.Create(dataRow, isLock: false, dataRow.TakeLimit));
		dictionary.Add(2, (dataRow2 == null) ? null : BPData.Create(dataRow2, isLock: false, dataRow2.TakeLimit));
		DRCostomCultivate dataRow3 = GameEntry.DataTable.GetDataRow<DRCostomCultivate>(_customCultivate1);
		Dictionary<int, HCTalentData> talentData = null;
		if (dataRow3 != null && dataRow3.HeroskillLv == 1)
		{
			talentData = GetTalentData(selectHero);
		}
		List<int> seatLevel = new List<int>();
		if (dataRow3 != null && dataRow3.HerosoulLv == 1)
		{
			seatLevel = new List<int> { 1, 2, 3, 4, 5, 6, 7 };
		}
		int skinConfigId = 0;
		if (!string.IsNullOrEmpty(skinID.text))
		{
			skinConfigId = int.Parse(skinID.text);
		}
		list.Add(new TeamMember(1, isCaptain: true, new HeroModel(selectHero, skinConfigId, dataRow3?.HeroLv ?? 1, talentData, seatLevel, dictionary)));
		if (selectHero2 != 0)
		{
			DRCostomCultivate dataRow4 = GameEntry.DataTable.GetDataRow<DRCostomCultivate>(_customCultivate2);
			Dictionary<int, HCTalentData> talentData2 = null;
			if (dataRow4 != null && dataRow4.HeroskillLv == 1)
			{
				talentData2 = GetTalentData(selectHero2);
			}
			List<int> seatLevel2 = new List<int>();
			if (dataRow4 != null && dataRow4.HerosoulLv == 1)
			{
				seatLevel2 = new List<int> { 1, 2, 3, 4, 5, 6, 7 };
			}
			list.Add(new TeamMember(2, isCaptain: false, new HeroModel(skinConfigId: (!string.IsNullOrEmpty(hero2SkinId.text)) ? int.Parse(hero2SkinId.text) : 0, id: selectHero2, level: dataRow4?.HeroLv ?? 1, talentData: talentData2, seatLevel: seatLevel2, carringBPs: null), isSelf: false, isAi: true));
		}
		if (selectHero3 != 0)
		{
			DRCostomCultivate dataRow5 = GameEntry.DataTable.GetDataRow<DRCostomCultivate>(_customCultivate3);
			Dictionary<int, HCTalentData> talentData3 = null;
			if (dataRow5 != null && dataRow5.HeroskillLv == 1)
			{
				talentData3 = GetTalentData(selectHero3);
			}
			List<int> seatLevel3 = new List<int>();
			if (dataRow5 != null && dataRow5.HerosoulLv == 1)
			{
				seatLevel3 = new List<int> { 1, 2, 3, 4, 5, 6, 7 };
			}
			list.Add(new TeamMember(3, isCaptain: false, new HeroModel(skinConfigId: (!string.IsNullOrEmpty(hero3SkinId.text)) ? int.Parse(hero3SkinId.text) : 0, id: selectHero3, level: dataRow5?.HeroLv ?? 1, talentData: talentData3, seatLevel: seatLevel3, carringBPs: null), isSelf: false, isAi: true));
		}
		CopyData copyData = null;
		if (selectCopy != 0)
		{
			DRCopy dataRow6 = GameEntry.DataTable.GetDataRow<DRCopy>(selectCopy);
			if (dataRow6 != null)
			{
				copyData = CopyData.CreateTemp(dataRow6);
			}
		}
		List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
		for (int num = 0; num < list.Count; num++)
		{
			list2.Add(list[num].GetPeripheryHeroData());
		}
		List<AchievementMedal> battleAchievementMedalList = InitBattleAchievement();
		uint serialId = 0u;
		string sceneName = copyData.SceneName;
		int copyId = copyData?.Id ?? 0;
		int bossId = copyData?.GetBossId(0) ?? 0;
		string mapDataName = copyData?.MapData ?? "Battle";
		int navMeshId = copyData?.NavMeshId ?? 1;
		if (isOnLine.isOn)
		{
			WorldData worldData = BattleWorldData.CreateMutilBattleWorldData(serialId, sceneName, copyId, bossId, mapDataName, navMeshId, list2, list, null, battleAchievementMedalList, int.Parse(randomSeed.text), useGM.isOn);
			viewModel.OnBtnEnterClick(worldData);
		}
		else
		{
			WorldData worldData2 = BattleWorldData.CreateBattleWorldData(serialId, sceneName, copyId, bossId, mapDataName, navMeshId, list2, list, null, battleAchievementMedalList, useGM.isOn);
			viewModel.OnBtnEnterClick(worldData2);
		}
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
