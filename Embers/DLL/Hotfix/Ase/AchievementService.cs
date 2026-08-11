#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class AchievementService : IAchievementService
{
	private ISubscription<AchievementAttachNotify> subscription_AddMedal;

	private Dictionary<int, AchievementMedal> achievementMedalsDic;

	private Action<bool> redPointAction;

	private List<int> openAchiCacheList;

	private Dictionary<int, int> achievementGroupStateDic = new Dictionary<int, int>();

	public AchievementService()
	{
		achievementMedalsDic = new Dictionary<int, AchievementMedal>();
		subscription_AddMedal = Singleton<NetworkSystem>.Instance.Subscribe<AchievementAttachNotify>(AddMedal);
		openAchiCacheList = new List<int>();
		try
		{
			DRAchievementMedal[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetAllDataRows();
			foreach (DRAchievementMedal dRAchievementMedal in allDataRows)
			{
				if (!achievementMedalsDic.ContainsKey(dRAchievementMedal.MedalId))
				{
					AchievementMedal value = default(AchievementMedal);
					value.MedalId = dRAchievementMedal.MedalId;
					value.MedalNum = 0;
					value.MedalRank = 0;
					value.AchievementType = dRAchievementMedal.AchievementType;
					value.BattleObserverEventEnum = dRAchievementMedal.BattleObserverEventEnum;
					value.SetAchievementInfo(dRAchievementMedal);
					achievementMedalsDic.Add(dRAchievementMedal.MedalId, value);
				}
			}
			DRAchievementRewards[] allDataRows2 = GameEntry.DataTable.GetDataTable<DRAchievementRewards>().GetAllDataRows();
			foreach (DRAchievementRewards dRAchievementRewards in allDataRows2)
			{
				int num = dRAchievementRewards.Id * -1;
				if (!achievementMedalsDic.ContainsKey(num))
				{
					AchievementMedal value2 = new AchievementMedal
					{
						MedalId = num,
						MedalNum = 0,
						MedalRank = 0,
						AchievementType = dRAchievementRewards.AchievementType,
						BattleObserverEventEnum = BattleObserverEventEnum.None
					};
					achievementMedalsDic.Add(num, value2);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("添加表格成就数据，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public async UniTask<bool> RequestAchievementData()
	{
		GetAllAchieventmentRequest request = GetAllAchieventmentRequest.Create();
		GetAllAchieventmentResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetAllAchieventmentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "成就", "请求成就数据失败", showToast: false))
			{
				foreach (PbAchievementInfo achievement in response.Achievements)
				{
					if (achievementMedalsDic.ContainsKey(achievement.MedalId))
					{
						AchievementMedal value = achievementMedalsDic[achievement.MedalId];
						value.SetNum(achievement.Value);
						value.SetRank(achievement.RewardRank);
						achievementMedalsDic[achievement.MedalId] = value;
					}
				}
				CheckAchievementReward();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("请求成就数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public List<AchievementMedal> GetBattleAchievementMedals(bool isPractice = false)
	{
		List<AchievementMedal> list = new List<AchievementMedal>();
		if (isPractice)
		{
			return list;
		}
		foreach (KeyValuePair<int, AchievementMedal> item in achievementMedalsDic)
		{
			if (item.Value.AchievementType == 1 && item.Value.BattleObserverEventEnum != BattleObserverEventEnum.None)
			{
				list.Add(item.Value);
			}
		}
		return list;
	}

	public List<AchievementMedal> GetAllAchievementMedalsList()
	{
		CheckAchievementReward();
		return achievementMedalsDic.Values.ToList();
	}

	public async UniTask<PropGetViewModel> SendAchievementReward(int medalId, int rank)
	{
		GetAchievementRewardRequest request = GetAchievementRewardRequest.Create();
		request.MedalId = medalId;
		request.Rank = rank;
		GetAchievementRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetAchievementRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "成就", "获取成就奖励失败", showToast: false))
			{
				if (medalId == -1)
				{
					List<int> list = CollectionPool<List<int>, int>.Get();
					foreach (KeyValuePair<int, AchievementMedal> item in achievementMedalsDic)
					{
						list.Add(item.Key);
					}
					foreach (int item2 in list)
					{
						AchievementMedal value = achievementMedalsDic[item2];
						int medalId2 = value.MedalId;
						if (item2 >= 0)
						{
							value.SetRank(value.CurRank);
						}
						else
						{
							value.SetRank(value.MedalRank);
						}
						achievementMedalsDic[medalId2] = value;
					}
					CollectionPool<List<int>, int>.Release(list);
				}
				else
				{
					AchievementMedal value2 = achievementMedalsDic[medalId];
					value2.SetRank(rank);
					achievementMedalsDic[medalId] = value2;
				}
				PropGetViewModel result = new PropGetViewModel(null, (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).PropList);
				CheckAchievementReward();
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error("获取成就奖励失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<PropGetViewModel> SendAchievementGroupReward(int type)
	{
		GetAchievementTypeGroupRewardRequest request = GetAchievementTypeGroupRewardRequest.Create();
		request.Type = type;
		GetAchievementTypeGroupRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetAchievementTypeGroupRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "", "", showToast: false))
			{
				int key = type * -1;
				AchievementMedal value = achievementMedalsDic[key];
				value.SetRank(1);
				achievementMedalsDic[key] = value;
				PropGetViewModel result = new PropGetViewModel(null, (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).PropList);
				CheckAchievementReward();
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error("获取成就组奖励失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	private void AddMedal(AchievementAttachNotify notify)
	{
		if (notify.Info.MedalId == 35)
		{
			DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataRows((DRAchievementMedal p) => p.MedalId == 35);
			foreach (DRAchievementMedal dRAchievementMedal in dataRows)
			{
				if (notify.Info.Value == dRAchievementMedal.Value)
				{
					openAchiCacheList.Add(dRAchievementMedal.Id);
					break;
				}
			}
			return;
		}
		bool flag = false;
		if (achievementMedalsDic.ContainsKey(notify.Info.MedalId))
		{
			AchievementMedal value = achievementMedalsDic[notify.Info.MedalId];
			int curRank = value.CurRank;
			value.SetNum(notify.Info.Value);
			flag = curRank < value.CurRank;
			value.SetRank(notify.Info.RewardRank);
			achievementMedalsDic[notify.Info.MedalId] = value;
		}
		if (flag)
		{
			OpenNewMedalWindow(notify.Info.MedalId, notify.Info.Value);
		}
		CheckAchievementReward();
	}

	public List<int> GetAchiCacheList()
	{
		return openAchiCacheList;
	}

	public void ClearAchiCache()
	{
		openAchiCacheList.Clear();
	}

	private async void OpenNewMedalWindow(int medalId, int value)
	{
		DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataRows((DRAchievementMedal p) => p.MedalId == medalId);
		if (dataRows != null)
		{
			string text = "";
			string title = "";
			int rarity = 0;
			DRAchievementMedal[] array = dataRows;
			foreach (DRAchievementMedal dRAchievementMedal in array)
			{
				if (value < dRAchievementMedal.Value)
				{
					break;
				}
				text = dRAchievementMedal.MedalIcon;
				title = dRAchievementMedal.Name;
				rarity = dRAchievementMedal.Rarity;
			}
			if (!text.Equals(""))
			{
				AchievementGetPropViewModel userData = new AchievementGetPropViewModel(text, title, rarity);
				await GameEntry.UI.OpenWindow<AchievementGetPropWindow>("Achievement/AchievementGetPropWindow", "POPUP", userData);
			}
		}
		else
		{
			Toast.ShowError($"未找到勋章ID:{medalId}的表格数据");
		}
	}

	public int[] GetFinishAchievementByType(int type)
	{
		int num = 0;
		int num2 = 0;
		foreach (KeyValuePair<int, AchievementMedal> item in achievementMedalsDic)
		{
			if (item.Value.AchievementType == type)
			{
				num += item.Value.CurRank;
				if (item.Value.CurRank > item.Value.MedalRank)
				{
					num2++;
				}
			}
		}
		return new int[2] { num, num2 };
	}

	public Dictionary<int, int> GetAchievementGroupStateDic()
	{
		return achievementGroupStateDic;
	}

	public async UniTask<bool> GetAchievementGroupInfo()
	{
		achievementGroupStateDic.Clear();
		GetAchievementTypeGroupListRequest request = GetAchievementTypeGroupListRequest.Create();
		GetAchievementTypeGroupListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetAchievementTypeGroupListResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "成就", "获取成就组"))
			{
				foreach (PbAchievementGroupValueInfo info in response.Infos)
				{
					achievementGroupStateDic[info.Id] = info.Value;
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			return false;
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public AchievementMedal GetAchievementMedalById(int medalId)
	{
		return achievementMedalsDic[medalId];
	}

	public bool CheckAchievementReward()
	{
		foreach (KeyValuePair<int, AchievementMedal> item in achievementMedalsDic)
		{
			AchievementMedal value = item.Value;
			if (value.MedalRank < value.CurRank)
			{
				redPointAction?.Invoke(obj: true);
				return true;
			}
		}
		redPointAction?.Invoke(obj: false);
		return false;
	}

	public bool CheckByAchiTypeRedPoint(int type)
	{
		foreach (KeyValuePair<int, AchievementMedal> item in achievementMedalsDic)
		{
			AchievementMedal value = item.Value;
			if (value.AchievementType == type && value.MedalRank < value.CurRank)
			{
				redPointAction?.Invoke(obj: true);
				return true;
			}
		}
		return false;
	}

	public void AddAchievementRedPoint(Action<bool> action)
	{
		redPointAction = action;
	}

	public async UniTask<bool> SendBattleAchievement(List<Achievement> achievementList)
	{
		BattleAchievementAttachClientMessage battleAchievementAttachClientMessage = BattleAchievementAttachClientMessage.Create();
		if (achievementList == null)
		{
			return true;
		}
		battleAchievementAttachClientMessage.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().Uid;
		for (int i = 0; i < achievementList.Count; i++)
		{
			Achievement achievement = achievementList[i];
			PbBattleAchievementAttachInfo pbBattleAchievementAttachInfo = PbBattleAchievementAttachInfo.Create();
			pbBattleAchievementAttachInfo.MedalId = achievement.MedalId;
			pbBattleAchievementAttachInfo.Value = achievement.TargetSuccessValue;
			battleAchievementAttachClientMessage.AttachInfos.Add(pbBattleAchievementAttachInfo);
		}
		try
		{
			Singleton<NetworkSystem>.Instance.Call(battleAchievementAttachClientMessage);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return true;
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			return true;
		}
		finally
		{
			battleAchievementAttachClientMessage.Dispose();
		}
		return true;
	}

	public bool SendBoardHeroClick()
	{
		BoardHeroChatClientMessage boardHeroChatClientMessage = BoardHeroChatClientMessage.Create();
		boardHeroChatClientMessage.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().Uid;
		Singleton<NetworkSystem>.Instance.Call(boardHeroChatClientMessage);
		return true;
	}
}
