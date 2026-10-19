using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssHistoryRecordView : BaseUIView
{
	[SerializeField]
	[Header("顶部返回")]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("左侧列表")]
	private LoopVerticalScrollRect _leftScrollRect;

	[SerializeField]
	[Header("战斗数据统计")]
	private LocalizeStringEvent _highestLevel;

	[SerializeField]
	private LocalizeStringEvent _shorestTime;

	[SerializeField]
	private TextMeshProUGUI _stars;

	[SerializeField]
	[Header("右侧上部")]
	private TextMeshProUGUI _date;

	[SerializeField]
	private List<GameObject> _emptyCharacters;

	[SerializeField]
	private List<GameObject> _mostDeployCharacters;

	[SerializeField]
	private List<AbyssBagCharacterItemUIComponent> _characters;

	[SerializeField]
	private List<TextMeshProUGUI> _mostDeployCount;

	[SerializeField]
	private LoopVerticalScrollRect _dataStatisticsScrollRect;

	private int _currentTabIndex = -1;

	private List<Abyss> _abysses = new List<Abyss>();

	protected override void AddEventListener()
	{
		base.AddEventListener();
		_closeBtn.SetBtnClick(Close);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		PlayTabAnimation();
		PlayItemAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Abyss/BattleReport_Open");
	}

	private async void PlayTabAnimation()
	{
		for (int i = 0; i < _leftScrollRect.content.childCount; i++)
		{
			AbyssHistoryRecordTab component = _leftScrollRect.content.GetChild(i).GetComponent<AbyssHistoryRecordTab>();
			if (!(component == null))
			{
				component.CanvasGroup.alpha = 0f;
			}
		}
		for (int j = 0; j < _leftScrollRect.content.childCount; j++)
		{
			AbyssHistoryRecordTab component2 = _leftScrollRect.content.GetChild(j).GetComponent<AbyssHistoryRecordTab>();
			if (component2 != null)
			{
				component2.CanvasGroup.alpha = 1f;
				component2.PlayAnimation();
			}
			await UniTask.Delay(30);
		}
	}

	private async void PlayItemAnimation()
	{
		for (int i = 0; i < _dataStatisticsScrollRect.content.childCount; i++)
		{
			AbyssHistoryRecordItem component = _dataStatisticsScrollRect.content.GetChild(i).GetComponent<AbyssHistoryRecordItem>();
			if (!(component == null))
			{
				component.CanvasGroup.alpha = 0f;
			}
		}
		for (int j = 0; j < _dataStatisticsScrollRect.content.childCount; j++)
		{
			AbyssHistoryRecordItem component2 = _dataStatisticsScrollRect.content.GetChild(j).GetComponent<AbyssHistoryRecordItem>();
			if (component2 != null)
			{
				component2.CanvasGroup.alpha = 1f;
				component2.PlayAnimation();
			}
			await UniTask.Delay(30);
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void Init()
	{
		base.Init();
		_abysses = Model<AbyssModel>.Interface.GetHistoryRecords();
		_abysses.Reverse();
		RefreshLeftTab();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_abysses.Clear();
	}

	private async void RefreshLeftTab()
	{
		_leftScrollRect.ClearCells();
		_leftScrollRect.OnItemShow.RemoveAllListeners();
		_leftScrollRect.OnItemShow.AddListener(OnLeftTabShow);
		_leftScrollRect.totalCount = _abysses.Count;
		await UniTask.DelayFrame(1);
		_leftScrollRect.RefillCells();
		OnClickTabHandle(0, _abysses[0]);
	}

	private void OnLeftTabShow(ILoopScrollDataSource loopScrollDataSource)
	{
		if (loopScrollDataSource is AbyssHistoryRecordTab abyssHistoryRecordTab)
		{
			abyssHistoryRecordTab.RefreshUI((int tabIndex, Abyss abyss) =>
			{
				OnClickTabHandle(tabIndex, abyss, playAnimation: true);
			}, _abysses[abyssHistoryRecordTab.index]);
		}
	}

	private void OnClickTabHandle(int tabIndex, Abyss abyss, bool playAnimation = false)
	{
		if (_currentTabIndex >= 0)
		{
			(_leftScrollRect.GetItem(_currentTabIndex) as AbyssHistoryRecordTab)?.SetSelect(value: false);
		}
		_currentTabIndex = tabIndex;
		(_leftScrollRect.GetItem(_currentTabIndex) as AbyssHistoryRecordTab)?.SetSelect(value: true);
		if (playAnimation)
		{
			betterAnimation.StopAnimation();
			betterAnimation.GetSequence("TabHide").OnComplete((AnimationBuilder _) =>
			{
				RefreshDataStatistics(abyss);
				betterAnimation.GetSequence("TabShow").Play();
				PlayItemAnimation();
			}).Play();
		}
		else
		{
			RefreshDataStatistics(abyss);
		}
	}

	private void RefreshDataStatistics(Abyss abyss)
	{
		int highestLevel = GetHighestLevel(abyss);
		_highestLevel.StringReference.TableReference = LocalizationUtility.localizeTableName_Common;
		_highestLevel.StringReference.TableEntryReference = ((highestLevel <= 0) ? 2917 : 614);
		_highestLevel.StringReference.GetVariable<string>("0").Value = highestLevel.ToString();
		int shorestTime = GetShorestTime(abyss);
		_shorestTime.StringReference.TableReference = LocalizationUtility.localizeTableName_Common;
		_shorestTime.StringReference.TableEntryReference = ((shorestTime <= 0) ? 2917 : 1728);
		TimeSpan timeSpan = TimeSpan.FromSeconds(shorestTime);
		_shorestTime.StringReference.GetVariable<string>("0").Value = ((int)timeSpan.TotalHours).ToString();
		_shorestTime.StringReference.GetVariable<string>("1").Value = timeSpan.Minutes.ToString();
		_shorestTime.StringReference.GetVariable<string>("2").Value = timeSpan.Seconds.ToString();
		_stars.SetText("{0:0}", GetQualityCount(abyss));
		if (RuntimeConfigs.data.abyssGroupDatas.TryGetValue(abyss.Id, out var value))
		{
			System.DateTime localDateTime = DateTimeOffset.FromUnixTimeMilliseconds(value.abyssGroupEndTs).LocalDateTime;
			_date.text = localDateTime.ToString("yyyy-MM-dd");
		}
		ItemKv[] mostDeployCharacters = GetMostDeployCharacters(abyss);
		for (int i = 0; i < _mostDeployCharacters.Count; i++)
		{
			if (mostDeployCharacters[i].id > 0)
			{
				Character bagCharacter = G.localPlayer.GetBagCharacter(mostDeployCharacters[i].id);
				if (bagCharacter != null)
				{
					_emptyCharacters[i].SetActive(value: false);
					_mostDeployCharacters[i].SetActive(value: true);
					_characters[i].Station = Station;
					_characters[i].SetData(bagCharacter, 0L, ItemUIComponentBase.InitType.CharacterViewBagCharacter, ItemUIComponentBase.ItemCountShowType.OneSide);
					_characters[i].UpdatePerformance();
					_mostDeployCount[i].SetText("{0:0}", mostDeployCharacters[i].count);
				}
			}
			else
			{
				_emptyCharacters[i].SetActive(value: true);
				_mostDeployCharacters[i].SetActive(value: false);
			}
		}
		List<AbyssReportData> abyssReportDatas = GetReportRecord(abyss);
		_dataStatisticsScrollRect.ClearCells();
		_dataStatisticsScrollRect.totalCount = abyssReportDatas.Count;
		_dataStatisticsScrollRect.OnItemShow.RemoveAllListeners();
		_dataStatisticsScrollRect.OnItemShow.AddListener((ILoopScrollDataSource loopScrollDataSource) =>
		{
			if (loopScrollDataSource is AbyssHistoryRecordItem abyssHistoryRecordItem)
			{
				abyssHistoryRecordItem.RefreshUI(abyssReportDatas[abyssHistoryRecordItem.index]);
			}
		});
		_dataStatisticsScrollRect.RefreshCells();
	}

	private int GetHighestLevel(Abyss abyss)
	{
		int result = 0;
		for (int i = 0; i < abyss.Stages.Count; i++)
		{
			AbyssStage abyssStage = abyss.Stages[i];
			if (!abyssStage.IsUnlock || abyssStage.CompletedNum == 0)
			{
				break;
			}
			result = abyssStage.Index;
		}
		return result;
	}

	private int GetShorestTime(Abyss abyss)
	{
		int num = 0;
		for (int i = 0; i < abyss.Stages.Count; i++)
		{
			AbyssStage abyssStage = abyss.Stages[i];
			if (num <= 0)
			{
				num = abyssStage.StageMinimumSecs;
			}
			else if (abyssStage.StageMinimumSecs != 0 && abyssStage.StageMinimumSecs < num)
			{
				num = abyssStage.StageMinimumSecs;
			}
		}
		return num;
	}

	private int GetQualityCount(Abyss abyss)
	{
		int num = 0;
		for (int i = 0; i < abyss.Stages.Count; i++)
		{
			AbyssStage abyssStage = abyss.Stages[i];
			if (abyssStage == null || abyssStage.Target == null || abyssStage.Target.TargetReward == null)
			{
				continue;
			}
			foreach (KeyValuePair<int, bool> item in abyssStage.Target.TargetReward)
			{
				if (item.Value)
				{
					num++;
				}
			}
		}
		return num;
	}

	private ItemKv[] GetMostDeployCharacters(Abyss abyss)
	{
		ItemKv[] array = new ItemKv[3];
		Dictionary<int, int> characterDeployCount = new Dictionary<int, int>();
		for (int i = 0; i < abyss.Stages.Count; i++)
		{
			AbyssStage abyssStage = abyss.Stages[i];
			if (abyssStage.StageBattleReport == null || abyssStage.StageBattleReport.CharacterBattleCount == null)
			{
				continue;
			}
			foreach (KeyValuePair<int, int> item in abyssStage.StageBattleReport.CharacterBattleCount)
			{
				if (characterDeployCount.ContainsKey(item.Key))
				{
					characterDeployCount[item.Key] += item.Value;
				}
				else
				{
					characterDeployCount.Add(item.Key, item.Value);
				}
			}
		}
		List<int> list = new List<int>(characterDeployCount.Keys);
		list.AddRange(characterDeployCount.Keys);
		list.Sort((int l, int r) =>
		{
			int value = characterDeployCount[l];
			return characterDeployCount[r].CompareTo(value);
		});
		for (int num = 0; num < array.Length; num++)
		{
			if (num < list.Count)
			{
				array[num] = new ItemKv(list[num], characterDeployCount[list[num]]);
			}
			else
			{
				array[num] = new ItemKv(0, 0);
			}
		}
		return array;
	}

	private List<AbyssReportData> GetReportRecord(Abyss abyss)
	{
		List<AbyssReportData> list = new List<AbyssReportData>();
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		Dictionary<int, int> dictionary2 = new Dictionary<int, int>();
		Dictionary<int, int> dictionary3 = new Dictionary<int, int>();
		Dictionary<int, int> dictionary4 = new Dictionary<int, int>();
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		for (int i = 0; i < abyss.Stages.Count; i++)
		{
			AbyssStage abyssStage = abyss.Stages[i];
			if (abyssStage.StageBattleReport != null)
			{
				num = GetMaxChacterId(abyssStage.StageBattleReport.CharacterUsePotionMaximumCount, dictionary);
				num2 = GetMaxChacterId(abyssStage.StageBattleReport.CharacterMaximumExSkillCount, dictionary2);
				num3 = GetMaxChacterId(abyssStage.StageBattleReport.CharacterMaximumDodgeCount, dictionary3);
				num4 = GetMaxChacterId(abyssStage.StageBattleReport.CharacterMaximumDamage, dictionary4);
			}
		}
		list.Add(new AbyssReportData
		{
			Type = AbyssReportType.BloodBottle,
			CharacterId = num,
			Count = (dictionary.TryGetValue(num, out var value) ? value : 0)
		});
		list.Add(new AbyssReportData
		{
			Type = AbyssReportType.Ultimate,
			CharacterId = num2,
			Count = (dictionary2.TryGetValue(num2, out var value2) ? value2 : 0)
		});
		list.Add(new AbyssReportData
		{
			Type = AbyssReportType.Dodge,
			CharacterId = num3,
			Count = (dictionary3.TryGetValue(num3, out var value3) ? value3 : 0)
		});
		list.Add(new AbyssReportData
		{
			Type = AbyssReportType.Damage,
			CharacterId = num4,
			Count = (dictionary4.TryGetValue(num4, out var value4) ? value4 : 0)
		});
		return list;
	}

	private int GetMaxChacterId(MapField<int, int> map, Dictionary<int, int> values)
	{
		int num = 0;
		foreach (KeyValuePair<int, int> item in map)
		{
			if (values.ContainsKey(item.Key))
			{
				values[item.Key] += item.Value;
			}
			else
			{
				values.Add(item.Key, item.Value);
			}
			if (num != 0)
			{
				num = ((values[item.Key] > values[num]) ? item.Key : num);
			}
			else
			{
				num = item.Key;
			}
		}
		return num;
	}
}
