#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using GameFramework.WebRequest;
using UnityEngine;

namespace Ase;

public class DrawCardService : IDrawCardService
{
	private List<DrawCardPoolInfo> drawCardPoolInfos;

	private List<DrawCardTabData> drawCardTabDataInfos;

	private List<DrawCardItemInfo> drawCardItemInfos;

	private List<int> idCacheList;

	private Dictionary<int, int> propIdCountDic;

	private List<DrawCardRecordInfo> drawCardRecordInfos;

	private readonly IMessenger messenger;

	private Action refreshPoolInfoAciton;

	private Action refreshPoolInfoAcitonImmediately;

	private ISubscription<LotteryPoolChangeNotify> subscription_poolChange;

	private Dictionary<int, bool> drawCardRedPoint;

	private string title = "_DrawCard_";

	private DrawCardMode drawCardMode;

	public DrawCardService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		drawCardPoolInfos = new List<DrawCardPoolInfo>();
		drawCardTabDataInfos = new List<DrawCardTabData>();
		drawCardItemInfos = new List<DrawCardItemInfo>();
		drawCardRedPoint = new Dictionary<int, bool>();
		idCacheList = new List<int>();
		propIdCountDic = new Dictionary<int, int>();
		drawCardRecordInfos = new List<DrawCardRecordInfo>();
		subscription_poolChange = Singleton<NetworkSystem>.Instance.Subscribe<LotteryPoolChangeNotify>(LotteryPoolChange);
	}

	public async UniTask<bool> GetLotteryPool()
	{
		C2H_GetLotteryPoolRequest c2HGetLotteryPoolRequest = new C2H_GetLotteryPoolRequest();
		H2C_GetLotteryPoolResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetLotteryPoolResponse>(c2HGetLotteryPoolRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "抽卡", "获取卡池失败"))
			{
				if (response.PoolInfo.Count <= 0)
				{
					return false;
				}
				LoadPool(response.PoolInfo.ToList());
				LoadLotteryResult(response.lastResult.ToList());
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.DrawCard));
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
			Log.Error("获取卡池失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			c2HGetLotteryPoolRequest.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async void LoadRedPoint()
	{
		C2H_GetLotteryPoolRequest c2HGetLotteryPoolRequest = new C2H_GetLotteryPoolRequest();
		H2C_GetLotteryPoolResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetLotteryPoolResponse>(c2HGetLotteryPoolRequest);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "抽卡", "获取卡池失败"))
			{
				return;
			}
			drawCardRedPoint.Clear();
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			foreach (PbLotteryPoolInfo item in response.PoolInfo)
			{
				bool value = PlayerPrefs.GetInt($"{uid}{title}{item.Id}", 0) == 0;
				drawCardRedPoint.Add(item.Id, value);
			}
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.DrawCard));
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取卡池失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			c2HGetLotteryPoolRequest.Dispose();
			response?.Dispose();
		}
	}

	public void SaveRedPoint(int id)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		PlayerPrefs.SetInt($"{uid}{title}{id}", 1);
		drawCardRedPoint[id] = false;
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.DrawCard));
	}

	public bool CheckRedPoint()
	{
		foreach (KeyValuePair<int, bool> item in drawCardRedPoint)
		{
			if (item.Value)
			{
				return true;
			}
		}
		return false;
	}

	private void LotteryPoolChange(LotteryPoolChangeNotify notify)
	{
		if (ClosePool(notify.PoolId))
		{
			Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new DrawCardMessage(this, DrawCardMsgEnum.Close));
		}
	}

	public List<DrawCardTabData> GetDrawCardTabInfos()
	{
		return drawCardTabDataInfos;
	}

	public List<DrawCardItemInfo> GetLotteryResultInfos()
	{
		return drawCardItemInfos;
	}

	public bool ClosePool(int id)
	{
		bool result = false;
		for (int i = 0; i < drawCardPoolInfos.Count; i++)
		{
			if (drawCardPoolInfos[i].Id == id)
			{
				drawCardPoolInfos.RemoveAt(i);
				result = true;
				break;
			}
		}
		for (int j = 0; j < drawCardTabDataInfos.Count; j++)
		{
			if (drawCardTabDataInfos[j].DrawCardPoolInfo.Id == id)
			{
				drawCardTabDataInfos.RemoveAt(j);
				result = true;
				break;
			}
		}
		return result;
	}

	private void LoadPool(List<PbLotteryPoolInfo> lotteryPoolInfos)
	{
		drawCardPoolInfos.Clear();
		drawCardTabDataInfos.Clear();
		try
		{
			foreach (PbLotteryPoolInfo lotteryPoolInfo in lotteryPoolInfos)
			{
				DRDrawCardInfo drawCardInfo = GameEntry.DataTable.GetDataRow<DRDrawCardInfo>(lotteryPoolInfo.Id);
				if (!UiConvert.TextConvert.DebugDataTable(drawCardInfo, "DRDrawCardInfo", lotteryPoolInfo.Id))
				{
					continue;
				}
				DrawCardPoolInfo drawCardPoolInfo = new DrawCardPoolInfo();
				drawCardPoolInfo.Name = drawCardInfo.CardName;
				drawCardPoolInfo.Desc = drawCardInfo.CardDesc.Replace("\\n", "\n");
				drawCardPoolInfo.HaveSingle = drawCardInfo.IsSingle;
				drawCardPoolInfo.Id = drawCardInfo.Id;
				drawCardPoolInfo.NormalIcon = drawCardInfo.NormalIcon;
				drawCardPoolInfo.SelectedIcon = drawCardInfo.SelectedIcon;
				drawCardPoolInfo.Tag = drawCardInfo.CardTag;
				drawCardPoolInfo.TagColor = drawCardInfo.TagColor;
				drawCardPoolInfo.Type = drawCardInfo.CardType;
				drawCardPoolInfo.DropType = drawCardInfo.DropType;
				drawCardPoolInfo.CostPropType = (RoleMoneyEnum)drawCardInfo.DrawPropId;
				drawCardPoolInfo.PerCost = drawCardInfo.DrawPropNum;
				drawCardPoolInfo.SaleNum = drawCardInfo.Sale;
				drawCardPoolInfo.SaleTime = drawCardInfo.SaleTime;
				drawCardPoolInfo.LotteryMax = drawCardInfo.DrawTime;
				drawCardPoolInfo.LotteryLeft = drawCardInfo.DrawTime - lotteryPoolInfo.DrawCount;
				drawCardPoolInfo.LotteryTotalTimes = lotteryPoolInfo.DrawCount;
				drawCardPoolInfo.DeadLineTime = ((lotteryPoolInfo.Countdown <= 0) ? (-1) : lotteryPoolInfo.Countdown);
				drawCardPoolInfo.SelectUpId = lotteryPoolInfo.SlectUpId;
				drawCardPoolInfo.Trigger = lotteryPoolInfo.UpTriggerCount;
				drawCardPoolInfo.OpenTimer();
				if (drawCardPoolInfo.DropType == 1)
				{
					DRChoose dataRow = GameEntry.DataTable.GetDataRow((DRChoose p) => p.CardId == drawCardInfo.Id);
					if (dataRow != null)
					{
						drawCardPoolInfo.MaxTrigger = dataRow.Trigger;
					}
				}
				DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(drawCardInfo.DrawPropId);
				if (UiConvert.TextConvert.DebugDataTable(dataRow2, "DrProp", drawCardInfo.DrawPropId))
				{
					drawCardPoolInfo.CostPropIcon = dataRow2.Icon;
				}
				drawCardPoolInfos.Add(drawCardPoolInfo);
				bool redPoint = false;
				if (drawCardRedPoint.TryGetValue(drawCardPoolInfo.Id, out var value))
				{
					redPoint = value;
				}
				DrawCardTabData drawCardTabData = new DrawCardTabData(null, drawCardPoolInfo);
				drawCardTabData.RedPoint = redPoint;
				drawCardTabDataInfos.Add(drawCardTabData);
			}
		}
		catch (Exception ex)
		{
			Log.Error("卡池表格数据获取失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void LoadLotteryResult(List<PbLotteryResult> lotteryResults, int poolId = 0, bool needRecordCount = false, int lotteryTotalCount = 0)
	{
		drawCardItemInfos = new List<DrawCardItemInfo>();
		idCacheList = new List<int>();
		int num = (needRecordCount ? lotteryTotalCount : 0);
		try
		{
			foreach (PbLotteryResult lotteryResult in lotteryResults)
			{
				DrawCardItemInfo item = default(DrawCardItemInfo);
				if (lotteryResult.DrawRusult.Count == 1)
				{
					item = DrawCardItemInfoConvert.Convert(lotteryResult.DrawRusult[0].ItemId, lotteryResult.DrawRusult[0].ItemType);
					item.IsChoose = false;
					item.poolId = poolId;
					item.IsNew = CheckIsNew(lotteryResult.DrawRusult[0].ItemId, lotteryResult.DrawRusult[0].ItemType);
					idCacheList.Add(lotteryResult.DrawRusult[0].ItemId);
					item.SetConvertImg();
					item.ConfigId = lotteryResult.ConfigId;
					item.ConfigIndex = lotteryResult.ConfigIndex;
					item.DrawCardRealResults = new List<DrawCardRealResult>();
					item.DrawCardProducts = new List<DrawCardProduct>();
					item.LotteryIndex = (needRecordCount ? num++ : num);
					foreach (PbItemBase item4 in lotteryResult.RealResult)
					{
						DrawCardRealResult item2 = new DrawCardRealResult
						{
							RealResultType = item4.ItemType,
							RealResultId = item4.ItemId,
							RealResultCount = (int)item4.ItemCount
						};
						item.DrawCardRealResults.Add(item2);
					}
					foreach (PbItemBase item5 in lotteryResult.ByProduct)
					{
						DrawCardProduct item3 = new DrawCardProduct
						{
							ProductType = item5.ItemType,
							ProductId = item5.ItemId,
							ProductCount = (int)item5.ItemCount
						};
						item.DrawCardProducts.Add(item3);
					}
				}
				else
				{
					item.IsChoose = true;
					item.ChooseIds = new List<int>();
					item.ChooseTypes = new List<int>();
					foreach (PbItemBase item6 in lotteryResult.DrawRusult)
					{
						item.ChooseIds.Add(item6.ItemId);
						item.ChooseTypes.Add(item6.ItemType);
						item.Rarity = 4;
						item.ConfigId = lotteryResult.ConfigId;
						item.ConfigIndex = lotteryResult.ConfigIndex;
					}
				}
				drawCardItemInfos.Add(item);
			}
		}
		catch (Exception ex)
		{
			Log.Error("抽卡结果转换失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public bool ChooseResultAddCheckIsNew(DrawCardItemInfo drawCardItemInfo)
	{
		drawCardItemInfo.IsNew = CheckIsNew(drawCardItemInfo.Id, drawCardItemInfo.Type);
		idCacheList.Add(drawCardItemInfo.Id);
		return drawCardItemInfo.IsNew;
	}

	public DrawCardMode GetDrawCardMode()
	{
		return drawCardMode;
	}

	private bool CheckIsNew(int id, int type)
	{
		if (type == 5)
		{
			if (Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CheckWeaponId(id))
			{
				return false;
			}
		}
		else if (Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().ContainsKey(id))
		{
			return false;
		}
		if (idCacheList.Contains(id))
		{
			return false;
		}
		return true;
	}

	public async UniTask<bool> ChooseLotteryResult(List<int> indexes)
	{
		C2H_ChooseLotteryResultRequest request = new C2H_ChooseLotteryResultRequest();
		H2C_ChooseLotteryResultResponse response = null;
		request.Indexes = indexes;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ChooseLotteryResultResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "抽卡", "抽卡选择失败"))
			{
				AddResult(response.dropThings);
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
			Log.Error("抽卡选择失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<int> Lottery(DrawCardMode drawCardMode, DrawCardPoolInfo drawCardPoolInfo)
	{
		C2H_LotteryDrawRequest request = new C2H_LotteryDrawRequest
		{
			Id = drawCardPoolInfo.Id,
			Times = (int)drawCardMode,
			ItemId = (int)drawCardPoolInfo.CostPropType
		};
		H2C_LotteryDrawResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_LotteryDrawResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "抽卡", "抽卡请求失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				if (response.Result.ToList().Count == 1 || response.Result.ToList().Count == 10)
				{
					this.drawCardMode = (DrawCardMode)response.Result.ToList().Count;
				}
				else
				{
					this.drawCardMode = DrawCardMode.Null;
				}
				LoadLotteryResult(response.Result.ToList(), drawCardPoolInfo.Id, needRecordCount: true, drawCardPoolInfo.LotteryTotalTimes);
				propIdCountDic.Clear();
				AddResult(response.dropThings);
				drawCardPoolInfo.LotteryLeft = drawCardPoolInfo.LotteryMax - response.TotalLotteryCount;
				drawCardPoolInfo.LotteryTotalTimes = response.TotalLotteryCount;
				drawCardPoolInfo.Trigger = response.UpTriggerCount;
				if (drawCardPoolInfo.LotteryMax >= 1 && response.TotalLotteryCount >= drawCardPoolInfo.LotteryMax && ClosePool(drawCardPoolInfo.Id))
				{
					Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new DrawCardMessage(this, DrawCardMsgEnum.Close));
				}
				Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new DrawCardMessage(this, DrawCardMsgEnum.DrawCard));
				return 0;
			}
			return response.Error;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return -1;
		}
		catch (Exception ex2)
		{
			Log.Error("抽卡请求失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return -1;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public async UniTask<bool> LotteryTest(int lotteryCount, int poolId, int costPropId)
	{
		C2H_LotteryDrawRequest request = new C2H_LotteryDrawRequest
		{
			Id = poolId,
			Times = lotteryCount,
			ItemId = costPropId
		};
		H2C_LotteryDrawResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_LotteryDrawResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "抽卡", "抽卡请求失败"))
			{
				LoadLotteryResult(response.Result.ToList(), poolId);
				propIdCountDic.Clear();
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
			Log.Error("抽卡请求失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public Dictionary<int, int> GetPropIdCountDic()
	{
		return propIdCountDic;
	}

	public async UniTask<bool> ExchangeTickets(int ticketsId, int num)
	{
		CurrencyExchangeRequest request = new CurrencyExchangeRequest
		{
			SourceId = 9002,
			TargetId = ticketsId,
			TargetNum = num
		};
		CurrencyExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CurrencyExchangeResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "道具兑换", "道具兑换失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
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
			Log.Error("道具兑换失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<List<DrawCardRecordInfo>> RequestServerDrawCardResult()
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		string webRequestUri = $"{GameEntry.BuiltinData.GameVersion.lottery_url}/{uid}.txt";
		WebRequestResponse webRequestResponse = await GameEntry.WebRequest.AddWebRequest(webRequestUri);
		if (webRequestResponse.IsError)
		{
			Log.Error("请求服务器抽卡记录失败 = " + webRequestResponse.ErrorMessage);
			return drawCardRecordInfos;
		}
		drawCardRecordInfos.Clear();
		string data = GameFramework.Utility.Converter.GetString(webRequestResponse.GetWebResponseBytes());
		drawCardRecordInfos = HandleInfo(data);
		return drawCardRecordInfos;
	}

	private List<DrawCardRecordInfo> HandleInfo(string data)
	{
		List<DrawCardRecordInfo> list = new List<DrawCardRecordInfo>();
		string[] array = data.Split('\n');
		long num = 15552000L;
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		string[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			string[] array3 = array2[i].Split(',');
			if (array3.Length == 4)
			{
				DrawCardRecordInfo drawCardRecordInfo = new DrawCardRecordInfo();
				long.TryParse(array3[3], out var result);
				if (curServerTime - result <= num)
				{
					drawCardRecordInfo.callTime = result;
					drawCardRecordInfo.itemType = int.Parse(array3[0]);
					drawCardRecordInfo.itemId = int.Parse(array3[1]);
					drawCardRecordInfo.poolId = int.Parse(array3[2]);
					list.Add(drawCardRecordInfo);
				}
			}
		}
		list.Reverse();
		return list;
	}

	private async void AddResult(PbLotteryDropThing pbLotteryDropThing)
	{
		if (pbLotteryDropThing == null)
		{
			return;
		}
		await PropHelper.AnalyzeRewardFromServer(pbLotteryDropThing);
		foreach (PbItemBase item in pbLotteryDropThing.items)
		{
			if (propIdCountDic.ContainsKey(item.ItemId))
			{
				propIdCountDic[item.ItemId] += (int)item.ItemCount;
			}
			else
			{
				propIdCountDic.Add(item.ItemId, (int)item.ItemCount);
			}
		}
	}

	public async UniTask<bool> ChooseOptionalHero(int poolId, int upId)
	{
		SelectDrawUpIdRequest request = new SelectDrawUpIdRequest
		{
			PoolId = poolId,
			SelectId = upId
		};
		SelectDrawUpIdResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SelectDrawUpIdResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "抽卡", "自选失败"))
			{
				for (int i = 0; i < drawCardPoolInfos.Count; i++)
				{
					if (drawCardPoolInfos[i].Id == poolId)
					{
						drawCardPoolInfos[i].SelectUpId = upId;
						break;
					}
				}
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
			Log.Error("自选失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}
}
