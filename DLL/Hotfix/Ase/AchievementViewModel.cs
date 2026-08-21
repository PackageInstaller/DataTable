using System.Collections.Generic;
using GameFramework.Runtime;
using Lockstep.Core;

namespace Ase;

public class AchievementViewModel : OptionBase
{
	private List<AchievementItemData> achievementItemDataList;

	private bool canOpenAchievement;

	private SimpleCommand openAllAchiRewardCmd;

	private bool redPoint;

	public List<AchievementItemData> AchievementItemDataList
	{
		get
		{
			return achievementItemDataList;
		}
		set
		{
			Set(ref achievementItemDataList, value, "AchievementItemDataList");
		}
	}

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public SimpleCommand OpenAllAchiRewardCmd => openAllAchiRewardCmd;

	public AchievementViewModel()
	{
	}

	public AchievementViewModel(OptionBase parent)
	{
		base.parent = parent;
		canOpenAchievement = true;
		achievementItemDataList = new List<AchievementItemData>();
		openAllAchiRewardCmd = new SimpleCommand(OpenAllAchievementWindow);
		DRAchievementType[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementType>().GetAllDataRows();
		if (allDataRows != null)
		{
			DRAchievementType[] array = allDataRows;
			foreach (DRAchievementType drAchievement in array)
			{
				int[] finishAchievementByType = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetFinishAchievementByType(drAchievement.Id);
				DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRows((DRAchievementMedal p) => p.AchievementType == drAchievement.Id);
				int rate = 0;
				if (dataRows.Length != 0)
				{
					rate = finishAchievementByType[0].ToInt() * 100 / dataRows.Length;
				}
				AchievementItemData item = new AchievementItemData(this, drAchievement.Name, drAchievement.EnglishName, rate, drAchievement.Icon, drAchievement.Id, finishAchievementByType[1] > 0);
				achievementItemDataList.Add(item);
			}
		}
		CheckRedPoint();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is AchievementItemData achievementItemData && optionArg.OptionName.Equals("OpenAchieve") && canOpenAchievement)
			{
				OpenAchieve(achievementItemData.Type);
			}
			return;
		}
		if (obj is AchievementMedalViewModel)
		{
			CheckRedPoint();
			{
				foreach (AchievementItemData achievementItemData2 in achievementItemDataList)
				{
					int[] finishAchievementByType = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetFinishAchievementByType(achievementItemData2.Type);
					achievementItemData2.ShowRedPoint = finishAchievementByType[1] > 0;
				}
				return;
			}
		}
		if (obj is AchievementPropViewModel)
		{
			CheckRedPoint();
		}
	}

	private async void OpenAllAchievementWindow()
	{
		openAllAchiRewardCmd.Enabled = false;
		if (await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupInfo())
		{
			AchievementPropViewModel userData = new AchievementPropViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(AchievementPropWindow), userData), delegate
			{
				openAllAchiRewardCmd.Enabled = true;
			});
		}
		else
		{
			openAllAchiRewardCmd.Enabled = true;
		}
	}

	private void OpenAchieve(int type)
	{
		canOpenAchievement = false;
		AchievementMedalViewModel userData = new AchievementMedalViewModel(this, type);
		openWindowRequest.Raise(new OpenViewArg(typeof(AchievementMedalWindow), userData), delegate
		{
			canOpenAchievement = true;
		});
	}

	private async void CheckRedPoint()
	{
		RedPoint = false;
		if (!(await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupInfo()))
		{
			return;
		}
		Dictionary<int, int> achievementGroupStateDic = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupStateDic();
		DRAchievementRewards[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementRewards>().GetAllDataRows();
		foreach (DRAchievementRewards dRAchievementRewards in allDataRows)
		{
			int medalId = dRAchievementRewards.Id * -1;
			achievementGroupStateDic.TryGetValue(dRAchievementRewards.Id, out var value);
			if (Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementMedalById(medalId).MedalRank < 1 && value >= dRAchievementRewards.Num)
			{
				RedPoint = true;
				break;
			}
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
