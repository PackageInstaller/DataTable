#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Sirenix.Utilities;
using UnityEngine.Rendering;

namespace Ase;

public class HeroService : IHeroService
{
	private Dictionary<int, HeroModel> allHeroViewModes = new Dictionary<int, HeroModel>();

	private readonly IMessenger heroMessenger;

	private Dictionary<long, int> heroHeldEquipment = new Dictionary<long, int>();

	private Dictionary<int, List<int>> allHeroSkins = new Dictionary<int, List<int>>();

	private int maxFeelingLevel;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private bool refetchCultureData;

	private List<int> _readTimelineList = new List<int>();

	public IMessenger GetMessager()
	{
		return heroMessenger;
	}

	public HeroService()
	{
		heroMessenger = Context.GetApplicationContext().GetService<IMessenger>();
		int maxFeelLev = 0;
		GameEntry.DataTable.GetAllDataRow<DRTrust>()?.ForEach(delegate(DRTrust p)
		{
			maxFeelLev = Math.Max(maxFeelLev, p.Id);
		});
		maxFeelingLevel = maxFeelLev;
		subscription_SONotify = heroMessenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
	}

	private async void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.state && 70008 == messager.serviceId)
		{
			await RequestServiceData();
		}
	}

	public int GetMaxFeelingLevel()
	{
		return maxFeelingLevel;
	}

	public async UniTask<bool> RequestServiceData()
	{
		return await RequestHeroData() & await RequestHeroSkinData();
	}

	public async UniTask<bool> RequestHeroData()
	{
		heroHeldEquipment.Clear();
		C2H_GetRoleListRequest rst = C2H_GetRoleListRequest.Create();
		H2C_GetRoleListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetRoleListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求烬天使数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求烬天使数据失败"))
			{
				foreach (PbNormalRoleInfo item in response.Roles.ToList())
				{
					HeroModel heroModel = HeroModel.CreateByPbData(item);
					if (!heroModel.IsNullOrEmpty())
					{
						AddHeroData(item.RoleId, heroModel, cover: false, requestSkin: false);
					}
				}
				refetchCultureData = false;
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
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> AddHero(PbNormalRoleInfo data, bool addNewWeapon = false)
	{
		if (data == null)
		{
			return false;
		}
		try
		{
			PbEquipBase weaponS = data.Weapon;
			if (weaponS == null)
			{
				Toast.ShowError($"{data.RoleId}烬天使未佩戴武魂,请检查！");
				return false;
			}
			WeaponData weaponData = ((!addNewWeapon) ? Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateWeapon(weaponS) : (await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().AddWeapon(weaponS)));
			if (weaponData == null)
			{
				Toast.ShowError($"{data.RoleId}烬天使未佩戴武魂,请检查！");
				return false;
			}
			if (data.RoleId != 0 && !heroHeldEquipment.ContainsKey(weaponS.Uuid))
			{
				heroHeldEquipment.Add(weaponS.Uuid, data.RoleId);
			}
			Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
			List<PbEquipBase> list = data.Armours.ToList();
			for (int i = 0; i < list.Count; i++)
			{
				PbEquipBase pbEquipBase = list[i];
				DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(pbEquipBase.EquipId);
				if (dataRow != null && dataRow.ArmourEnum != ArmourEnum.Rock)
				{
					dictionary.Add((int)dataRow.ArmourEnum, Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(pbEquipBase));
					if (data.RoleId != 0 && !heroHeldEquipment.ContainsKey(pbEquipBase.Uuid))
					{
						heroHeldEquipment.Add(pbEquipBase.Uuid, data.RoleId);
					}
				}
			}
			PbEquipBase suitbox = data.Suitbox;
			if (suitbox != null && GameEntry.DataTable.GetDataRow<DRSuitbox>(suitbox.EquipId) != null)
			{
				dictionary.Add(5, Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(suitbox));
				if (data.RoleId != 0 && !heroHeldEquipment.ContainsKey(suitbox.Uuid))
				{
					heroHeldEquipment.Add(suitbox.Uuid, data.RoleId);
				}
			}
			Dictionary<int, HCTalentData> dictionary2 = new Dictionary<int, HCTalentData>();
			for (int j = 0; j < data.Talents.Count; j++)
			{
				dictionary2.Add(data.Talents[j].SkillId, HCTalentData.Create(data.Talents[j].SkillId, data.Talents[j].SkillLevel, data.Talents[j].MaxOrderId));
			}
			Dictionary<int, int> dictionary3 = new Dictionary<int, int>();
			for (int k = 0; k < data.SkillSkinIds.Count; k++)
			{
				dictionary3.Add(data.SkillSkinIds[k].Id, data.SkillSkinIds[k].Value);
			}
			AddHeroData(data.RoleId, new HeroModel(data.RoleId, data.SkinID, data.Star, data.Level, data.Exp, data.TrustLevel, data.Feeling, dictionary3, weaponData, dictionary, dictionary2, data.SeatLevel));
			return true;
		}
		catch (Exception ex)
		{
			Log.Error($"添加角色发生异常！{data.RoleId} {ex.Message} / {ex.StackTrace}");
		}
		return false;
	}

	public async UniTask<bool> RequestHeroSkinData()
	{
		allHeroSkins.Clear();
		GetSkinListRequest rst = GetSkinListRequest.Create();
		GetSkinListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetSkinListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求烬天使皮肤数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求烬天使皮肤数据失败"))
			{
				if (response.ExtraItemInfos != null)
				{
					foreach (PbExtraItemInfo extraItemInfo in response.ExtraItemInfos)
					{
						AddHeroSkin(extraItemInfo.Id);
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
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public Dictionary<int, HeroModel> GetAllHeroData()
	{
		return allHeroViewModes;
	}

	public HeroModel GetHeroById(int heroId, bool emptyCreateNew = false, bool saveNew = true)
	{
		allHeroViewModes.TryGetValue(heroId, out var value);
		if (value == null)
		{
			if (!emptyCreateNew)
			{
				return new HeroModel();
			}
			value = HeroModel.CreateByConfig(heroId);
			if (saveNew)
			{
				AddHeroData(heroId, value);
			}
		}
		return value;
	}

	public PeripheryHeroData GetCreateHeroDataById(int heroId)
	{
		return PeripheryHeroData.CreateByConfig(heroId);
	}

	public HeroModel GetHeroCutById(int heroId)
	{
		allHeroViewModes.TryGetValue(heroId, out var value);
		if (value == null)
		{
			Log.Error($"不存在角色【{heroId}】");
			return null;
		}
		WeaponData weaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CopyWeapon(value.HeldWeapon);
		Dictionary<int, ArmourData> armourDatas = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CopyAllArmourAndSuitbox(value.Armours);
		return HeroModel.CreateCopy(value, weaponData, armourDatas);
	}

	public bool HasHero(int heroId)
	{
		if (allHeroViewModes != null && allHeroViewModes.ContainsKey(heroId))
		{
			return true;
		}
		return false;
	}

	public async void AddHeroData(int heroId, HeroModel vm, bool cover = false, bool requestSkin = true)
	{
		if (allHeroViewModes.ContainsKey(heroId))
		{
			if (!cover)
			{
				allHeroViewModes[heroId].Replace(vm);
				RefreshHeroHeldEquipment(allHeroViewModes[heroId]);
				return;
			}
			allHeroViewModes[heroId] = vm;
			RefreshHeroHeldEquipment(allHeroViewModes[heroId]);
		}
		else
		{
			allHeroViewModes.Add(heroId, vm);
			RefreshHeroHeldEquipment(vm);
			if (requestSkin)
			{
				await RequestHeroSkinData();
			}
		}
		heroMessenger.Publish(new HeroMessage(this, HeroMessageEnum.AddHero, allHeroViewModes[heroId]));
	}

	public void RefreshHeroHeldEquipment(HeroModel heroModel)
	{
		if (heroModel == null || heroModel.Id == 0)
		{
			return;
		}
		List<long> list = new List<long>();
		foreach (KeyValuePair<long, int> item in heroHeldEquipment)
		{
			if (item.Value == heroModel.Id)
			{
				list.Add(item.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			heroHeldEquipment.Remove(list[i]);
		}
		if (heroModel.HeldWeapon != null)
		{
			heroHeldEquipment[heroModel.HeldWeapon.Uid] = heroModel.Id;
		}
		if (heroModel.Armours == null)
		{
			return;
		}
		foreach (KeyValuePair<int, ArmourData> armour in heroModel.Armours)
		{
			if (armour.Value != null)
			{
				heroHeldEquipment[armour.Value.Uid] = heroModel.Id;
			}
		}
	}

	public bool RemoveHeroData(int heroId)
	{
		bool num = allHeroViewModes.Remove(heroId);
		if (num)
		{
			heroMessenger.Publish(new HeroMessage(this, HeroMessageEnum.RemoveHero, heroId));
		}
		return num;
	}

	public Dictionary<long, int> GetHeroHeldEquip()
	{
		return heroHeldEquipment;
	}

	public int GetEquipmentOwnerById(long uid)
	{
		if (heroHeldEquipment.ContainsKey(uid))
		{
			return heroHeldEquipment[uid];
		}
		return 0;
	}

	public bool AddHeroSkin(int heroSkinConfigId)
	{
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(heroSkinConfigId);
		if (dataRow == null)
		{
			return false;
		}
		if (!allHeroSkins.ContainsKey(dataRow.HeroID))
		{
			allHeroSkins.Add(dataRow.HeroID, new List<int>());
		}
		if (allHeroSkins[dataRow.HeroID].Contains(heroSkinConfigId))
		{
			return false;
		}
		allHeroSkins[dataRow.HeroID].Add(heroSkinConfigId);
		return true;
	}

	public List<int> GetHeroSkins(int heroId)
	{
		if (allHeroSkins.TryGetValue(heroId, out var value))
		{
			return value;
		}
		return new List<int>();
	}

	public List<int> GetAllHeroSkins()
	{
		List<int> list = new List<int>();
		foreach (List<int> value in allHeroSkins.Values)
		{
			list.AddRange(value);
		}
		return list;
	}

	public bool GetHeroSkinOwnerShopSituation(int heroSkinId)
	{
		if (allHeroSkins == null)
		{
			return false;
		}
		foreach (List<int> value in allHeroSkins.Values)
		{
			if (value.Contains(heroSkinId))
			{
				return true;
			}
		}
		return false;
	}

	public async void SetHeroSkin(int heroId, int skinId)
	{
		if (allHeroViewModes != null && allHeroViewModes.ContainsKey(heroId))
		{
			allHeroViewModes[heroId].SetSkin(skinId);
			await SetHeroSkinChangeRequest(skinId);
			heroMessenger.Publish(new HeroMessage(this, HeroMessageEnum.HeroSkinChanged, heroId));
		}
	}

	public async UniTask<bool> HeroChangeEquip(int heroId, EquipmentDataBase itemData, long curEquipUid = 0L, ArmourEnum armourEnum = ArmourEnum.Heart)
	{
		C2H_EquipEquipmentRequest request;
		H2C_EquipEquipmentResponse response;
		if (curEquipUid == itemData.Uid)
		{
			request = C2H_EquipEquipmentRequest.Create();
			request.OptType = 2;
			request.EquipUuid = itemData.Uid;
			request.RoleId = heroId;
			request.Typ = (int)itemData.EquipmentEnum;
			response = null;
			try
			{
				response = await Singleton<NetworkSystem>.Instance.Call<H2C_EquipEquipmentResponse>(request);
				if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "卸下装备", "卸下装备失败", showToast: false))
				{
					if (heroHeldEquipment.ContainsKey(itemData.Uid))
					{
						heroHeldEquipment.Remove(itemData.Uid);
					}
					allHeroViewModes[heroId].SetEquipment(null, itemData.EquipmentEnum, armourEnum);
					return true;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "请重试"));
				return false;
			}
			catch (TimeoutException)
			{
				Toast.ShowInfo("网络信号弱，请稍后再试");
				return false;
			}
			catch (Exception ex2)
			{
				Log.Error("卸下装备，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
				return false;
			}
			finally
			{
				request.Dispose();
				response?.Dispose();
			}
		}
		if (heroHeldEquipment.ContainsKey(itemData.Uid))
		{
			C2H_ExchangeEquipmentRequest request2 = C2H_ExchangeEquipmentRequest.Create();
			request2.Typ = (int)itemData.EquipmentEnum;
			request2.SelectRoleId = heroId;
			request2.SelectEquipUuid = itemData.Uid;
			H2C_ExchangeEquipmentResponse response2 = null;
			try
			{
				response2 = await Singleton<NetworkSystem>.Instance.Call<H2C_ExchangeEquipmentResponse>(request2);
				if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response2, "更换装备", "更换装备失败", showToast: false))
				{
					int num = heroHeldEquipment[itemData.Uid];
					heroHeldEquipment[itemData.Uid] = heroId;
					heroHeldEquipment[curEquipUid] = num;
					EquipmentDataBase newEquipModel;
					EquipmentDataBase newEquipModel2;
					if (itemData.EquipmentEnum == EquipmentEnum.Weapon)
					{
						newEquipModel = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(itemData.Uid);
						newEquipModel2 = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(curEquipUid);
					}
					else
					{
						newEquipModel = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(itemData.Uid);
						newEquipModel2 = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(curEquipUid);
					}
					allHeroViewModes[heroId].SetEquipment(newEquipModel, itemData.EquipmentEnum, armourEnum);
					allHeroViewModes[num].SetEquipment(newEquipModel2, itemData.EquipmentEnum, armourEnum);
					return true;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response2.Error, "请重试"));
				return false;
			}
			catch (TimeoutException)
			{
				Toast.ShowInfo("网络信号弱，请稍后再试");
				return false;
			}
			catch (Exception ex4)
			{
				Log.Error("更换装备，发生异常！" + ex4.Message + " / " + ex4.StackTrace);
				return false;
			}
			finally
			{
				request2.Dispose();
				response2?.Dispose();
			}
		}
		request = C2H_EquipEquipmentRequest.Create();
		request.OptType = 1;
		request.EquipUuid = itemData.Uid;
		request.RoleId = heroId;
		request.Typ = (int)itemData.EquipmentEnum;
		response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_EquipEquipmentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "穿戴装备", "穿戴装备失败", showToast: false))
			{
				heroHeldEquipment[itemData.Uid] = heroId;
				if (heroHeldEquipment.ContainsKey(curEquipUid))
				{
					heroHeldEquipment.Remove(curEquipUid);
				}
				EquipmentDataBase newEquipModel = ((itemData.EquipmentEnum != EquipmentEnum.Weapon) ? ((EquipmentDataBase)Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(itemData.Uid)) : ((EquipmentDataBase)Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(itemData.Uid)));
				allHeroViewModes[heroId].SetEquipment(newEquipModel, itemData.EquipmentEnum, armourEnum);
				return true;
			}
			Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "请重试"));
			return false;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex6)
		{
			Log.Error("更换装备，发生异常！" + ex6.Message + " / " + ex6.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public void UpdateHeroEquip(long equipUid)
	{
		heroHeldEquipment.TryGetValue(equipUid, out var value);
		allHeroViewModes.TryGetValue(value, out var value2);
		if (value2 != null)
		{
			if (equipUid == value2.HeldWeapon.Uid)
			{
				WeaponData weaponById = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(value2.HeldWeapon.Uid);
				value2.SetEquipment(weaponById, EquipmentEnum.Weapon, ArmourEnum.Heart);
			}
			else
			{
				ArmourData armourById = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(equipUid);
				value2.SetEquipment(armourById, EquipmentEnum.Armour, armourById.ArmourEnum);
			}
		}
	}

	public async UniTask<RequestResult> LightUpHeroTalentPoint(int heroId, int skillId, int talentOrder)
	{
		LightUpHeroTalentRequest rst = LightUpHeroTalentRequest.Create();
		rst.HeroId = heroId;
		rst.SkillId = skillId;
		rst.TalentOrder = talentOrder;
		LightUpHeroTalentResponse response = null;
		RequestResult result = new RequestResult
		{
			success = false
		};
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<LightUpHeroTalentResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "天赋-点亮火种"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "点亮火种失败"))
				{
					GetHeroById(heroId).SetTalentPointLight(skillId, talentOrder, HCSPointType.Small);
					PropHelper.AnalyzeRewardFromServer(response.ItemChange);
					result.success = true;
					return result;
				}
				result.obj = "RefetchHeroData";
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			result.obj = "RefetchHeroData";
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error("点亮火种失败 " + ex2.Message + " / " + ex2.StackTrace);
			Toast.ShowInfo("点亮火种失败！请重试！");
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<RequestResult> UpgradeHeroTalentPoint(int heroId, int skillId, int talentOrder)
	{
		UpgradeHeroTalentRequest rst = UpgradeHeroTalentRequest.Create();
		rst.HeroId = heroId;
		rst.SkillId = skillId;
		rst.TalentOrder = talentOrder;
		UpgradeHeroTalentResponse response = null;
		RequestResult result = new RequestResult
		{
			success = false
		};
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<UpgradeHeroTalentResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "天赋-升级燃点"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "升级燃点失败"))
				{
					GetHeroById(heroId).SetTalentPointLight(skillId, talentOrder, HCSPointType.Big);
					PropHelper.AnalyzeRewardFromServer(response.ItemChange);
					result.success = true;
					return result;
				}
				result.success = false;
				result.obj = "RefetchHeroData";
			}
			refetchCultureData = true;
		}
		catch (TimeoutException)
		{
			refetchCultureData = true;
			Toast.ShowInfo("网络信号弱，请稍后再试");
			result.obj = "RefetchHeroData";
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error("升级燃点失败 " + ex2.Message + " / " + ex2.StackTrace);
			Toast.ShowInfo("升级燃点失败！请重试！");
			refetchCultureData = true;
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<RequestResult> LightUpHeroDestiny(int heroId, int optType, int point = 0)
	{
		HeroLifeSeatUpgradeRequest rst = HeroLifeSeatUpgradeRequest.Create();
		rst.RoleId = heroId;
		rst.optType = optType;
		if (optType == 1)
		{
			rst.point = point;
		}
		HeroLifeSeatUpgradeResponse response = null;
		RequestResult result = new RequestResult();
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HeroLifeSeatUpgradeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "点亮命座"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "点亮命座失败"))
				{
					HeroModel heroById = GetHeroById(heroId);
					heroById.UpdateDestinyData(response.SeatLevel);
					PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.ItemLeft });
					heroMessenger.Publish(new HeroMessage(this, HeroMessageEnum.DestinyLevelChanged, heroById));
					result.success = true;
				}
				else if (response.Error == 200105 || response.Error == 200104)
				{
					await ServiceHelper.RequestDataInPropTable();
					await RequestServiceData();
					result.success = false;
					result.obj = "SyncWithServerData";
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<RequestResult> HeroUpgradeNew(List<PbItemBase> props, HeroModel heroModel)
	{
		C2H_HeroUpgradeRequest rst = C2H_HeroUpgradeRequest.Create();
		rst.RoleId = heroModel.Id;
		rst.ItemCost = props;
		H2C_HeroUpgradeResponse response = null;
		RequestResult result = new RequestResult
		{
			success = false
		};
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_HeroUpgradeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "烬天使升级"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "烬天使升级失败"))
				{
					allHeroViewModes[heroModel.Id].Level = response.HeroLevel;
					allHeroViewModes[heroModel.Id].Exp = response.HeroExp;
					Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
						.AddMoney(MoneyEnum.Coin, -(int)response.GoldCost);
					List<KnapsackPropData> list = new List<KnapsackPropData>();
					foreach (PbItemChange item in response.ItemLeft)
					{
						KnapsackPropData knapsackPropData = KnapsackPropData.Create(item.ItemId, (int)item.ItemDelta);
						if (item.ItemDelta > 0)
						{
							list.Add(knapsackPropData);
						}
						Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(knapsackPropData);
					}
					result.obj = list;
					heroMessenger.Publish(new HeroMessage(this, HeroMessageEnum.LevelChanged, allHeroViewModes[heroModel.Id]));
					result.success = true;
					return result;
				}
				result.success = false;
				result.obj = "RefetchHeroData";
			}
			refetchCultureData = true;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			refetchCultureData = true;
			result.obj = "RefetchHeroData";
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error("烬天使升级发生异常 " + ex2.Message + " / " + ex2.StackTrace);
			refetchCultureData = true;
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public void HeroUpgradeByBattle(int heroId, int level, long exp)
	{
		if (allHeroViewModes[heroId].Level != level)
		{
			allHeroViewModes[heroId].Level = level;
		}
		allHeroViewModes[heroId].Exp = exp;
	}

	public async UniTask<RequestResult> HeroBreakoutRequest(int uid)
	{
		HeroBreakRequest rst = HeroBreakRequest.Create();
		rst.RoleId = uid;
		HeroBreakResponse response = null;
		RequestResult result = new RequestResult();
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HeroBreakResponse>(rst);
			result = new RequestResult
			{
				errorCode = response.Error,
				message = response.Message,
				success = false
			};
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "烬天使突破"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "烬天使突破失败"))
				{
					allHeroViewModes[uid].StarLevel++;
					PropHelper.AnalyzeRewardFromServer(response.ItemLeft);
					List<KnapsackPropData> list = new List<KnapsackPropData>();
					foreach (PbItemChange item2 in response.ItemLeft)
					{
						if (item2.ItemDelta > 0)
						{
							KnapsackPropData item = KnapsackPropData.Create(item2.ItemId, (int)item2.ItemDelta);
							list.Add(item);
						}
					}
					result.success = true;
					result.obj = list;
					heroMessenger.Publish(new HeroMessage(this, HeroMessageEnum.StarLevelChanged, allHeroViewModes[uid]));
				}
				else if (response.Error == 200052)
				{
					await ServiceHelper.RequestDataInPropTable();
					await RequestServiceData();
					result.success = false;
					result.obj = "SyncWithServerData";
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public void ClearHeroAdditionalDatas()
	{
		foreach (HeroModel value in allHeroViewModes.Values)
		{
			value.ClearBPData();
			value.ResetOuterBuff();
		}
	}

	public async UniTask<bool> SendHeroGiftRequest(int heroId, int giftId, int count)
	{
		SendRoleGiftRequest rst = SendRoleGiftRequest.Create();
		rst.RoleId = heroId;
		rst.GiftId = giftId;
		rst.GiftCount = count;
		SendRoleGiftResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SendRoleGiftResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "角色赠礼") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "角色赠礼失败"))
			{
				HeroModel heroById = GetHeroById(heroId);
				if (heroById.IsNullOrEmpty())
				{
					return false;
				}
				heroById.SetFeelingData(response.TrustLevel, response.FinalFeeling);
				PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.Gift });
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
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SetHeroSkinChangeRequest(int heroSkinId)
	{
		DRUIHeroSkin drConfig = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(heroSkinId);
		if (drConfig == null)
		{
			return false;
		}
		C2H_ChangeRoleSkinRequest rst = C2H_ChangeRoleSkinRequest.Create();
		rst.RoleId = drConfig.HeroID;
		rst.SkinId = heroSkinId;
		H2C_ChangeRoleSkinResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ChangeRoleSkinResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "烬天使皮肤切换") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "烬天使皮肤切换失败"))
			{
				HeroModel heroById = GetHeroById(drConfig.HeroID);
				if (!heroById.IsNullOrEmpty())
				{
					heroById.SetSkin(heroSkinId);
				}
				heroMessenger?.Publish(new HeroMessage(this, HeroMessageEnum.HeroSkinChanged, drConfig.HeroID));
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
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public List<Dictionary<string, object>> GetHeroDetails(List<int> heroIds)
	{
		List<TeamMember> list = new List<TeamMember>();
		if (heroIds != null)
		{
			for (int i = 0; i < heroIds.Count; i++)
			{
				list.Add(new TeamMember(0, isCaptain: false, GetHeroById(heroIds[i])));
			}
		}
		return GetHeroDetails(list);
	}

	public Dictionary<string, object> GetHeroDetailsNew(List<int> heroIds, Dictionary<string, object> baseDic = null)
	{
		List<TeamMember> list = new List<TeamMember>();
		if (heroIds != null)
		{
			for (int i = 0; i < heroIds.Count; i++)
			{
				list.Add(new TeamMember(0, isCaptain: false, GetHeroById(heroIds[i])));
			}
		}
		return GetHeroDetailsNew(list, baseDic);
	}

	public Dictionary<string, object> GetHeroDetailsNew(List<TeamMember> teamMembers, Dictionary<string, object> baseDic = null)
	{
		Dictionary<string, object> dictionary = DictionaryPool<string, object>.Get();
		dictionary.Clear();
		try
		{
			List<Dictionary<string, object>> list = ListPool<Dictionary<string, object>>.Get();
			list.Clear();
			dictionary.Add("character_detail", list);
			List<Dictionary<string, object>> list2 = ListPool<Dictionary<string, object>>.Get();
			list2.Clear();
			dictionary.Add("weapon_detail", list2);
			List<Dictionary<string, object>> list3 = ListPool<Dictionary<string, object>>.Get();
			list3.Clear();
			dictionary.Add("armor_detail", list3);
			List<Dictionary<string, object>> list4 = ListPool<Dictionary<string, object>>.Get();
			list4.Clear();
			dictionary.Add("suitcase_detail", list4);
			List<Dictionary<string, object>> list5 = ListPool<Dictionary<string, object>>.Get();
			list5.Clear();
			dictionary.Add("Combat_props_detail", list5);
			if (baseDic != null)
			{
				foreach (KeyValuePair<string, object> item in dictionary)
				{
					if (!baseDic.ContainsKey(item.Key))
					{
						baseDic.Add(item.Key, item.Value);
					}
				}
			}
			for (int i = 0; i < teamMembers.Count; i++)
			{
				if (teamMembers[i].uid == 0L)
				{
					teamMembers[i].uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
				}
				Dictionary<string, object> dictionary2 = DictionaryPool<string, object>.Get();
				dictionary2.Clear();
				HeroModel heroModel = teamMembers[i].HeroModel;
				dictionary2.Add("player_id", teamMembers[i].uid);
				dictionary2.Add("id", heroModel.Id);
				dictionary2.Add("ai", teamMembers[i].IsAI);
				dictionary2.Add("level", heroModel.Level);
				dictionary2.Add("crown", heroModel.DestinyLevel);
				if (heroModel.TalentDatas != null)
				{
					List<Dictionary<string, object>> list6 = ListPool<Dictionary<string, object>>.Get();
					dictionary2.Add("talent", list6);
					foreach (KeyValuePair<int, HCTalentData> talentData in heroModel.TalentDatas)
					{
						Dictionary<string, object> dictionary3 = DictionaryPool<string, object>.Get();
						dictionary3.Clear();
						list6.Add(dictionary3);
						dictionary3.Add("id", talentData.Value.SkillId);
						dictionary3.Add("level", talentData.Value.BigLevel);
						dictionary3.Add("fire", talentData.Value.SmallOrder);
					}
				}
				List<Dictionary<string, object>> list7 = ListPool<Dictionary<string, object>>.Get();
				list7.Clear();
				dictionary2.Add("attri", list7);
				foreach (KeyValuePair<string, float> numerical in heroModel.TotalProperty.Numericals)
				{
					Dictionary<string, object> dictionary4 = DictionaryPool<string, object>.Get();
					dictionary4.Clear();
					list7.Add(dictionary4);
					dictionary4.Add("id", numerical.Key);
					dictionary4.Add("value", numerical.Value);
				}
				list.Add(dictionary2);
				if (heroModel.HeldWeapon != null)
				{
					Dictionary<string, object> dictionary5 = DictionaryPool<string, object>.Get();
					dictionary5.Clear();
					dictionary5.Add("player_id", teamMembers[i].uid);
					dictionary5.Add("hero", heroModel.Id);
					dictionary5.Add("id", heroModel.HeldWeapon.Id);
					dictionary5.Add("star", heroModel.HeldWeapon.Star);
					dictionary5.Add("level", heroModel.HeldWeapon.Level);
					list2.Add(dictionary5);
				}
				if (heroModel.Armours != null && heroModel.Armours.Count > 0)
				{
					Dictionary<string, object> dictionary6 = DictionaryPool<string, object>.Get();
					dictionary6.Clear();
					dictionary6.Add("player_id", teamMembers[i].uid);
					dictionary6.Add("hero", heroModel.Id);
					List<int> list8 = ListPool<int>.Get();
					list8.Clear();
					List<int> list9 = ListPool<int>.Get();
					list9.Clear();
					List<int> list10 = ListPool<int>.Get();
					list10.Clear();
					List<int> list11 = ListPool<int>.Get();
					list11.Clear();
					List<List<object>> list12 = ListPool<List<object>>.Get();
					list12.Clear();
					List<List<object>> list13 = ListPool<List<object>>.Get();
					list13.Clear();
					dictionary6.Add("id", list8);
					dictionary6.Add("level", list9);
					dictionary6.Add("grade", list10);
					dictionary6.Add("rank", list11);
					dictionary6.Add("attri", list12);
					dictionary6.Add("skill", list13);
					foreach (KeyValuePair<int, ArmourData> armour in heroModel.Armours)
					{
						if (armour.Value == null)
						{
							continue;
						}
						list8.Add(armour.Value.Id);
						list9.Add(armour.Value.Level);
						list10.Add(armour.Value.Rarity);
						list11.Add(armour.Value.Rank);
						List<object> list14 = ListPool<object>.Get();
						list14.Clear();
						Dictionary<string, object> dictionary7 = DictionaryPool<string, object>.Get();
						dictionary7.Clear();
						list14.Add(dictionary7);
						dictionary7.Add("id", armour.Value.GetMainAttribute()?.Id ?? 0);
						dictionary7.Add("level", armour.Value.GetMainAttribute()?.BaseValue ?? 0f);
						foreach (EquipAttribute item2 in armour.Value.GetSubAttribute())
						{
							Dictionary<string, object> dictionary8 = DictionaryPool<string, object>.Get();
							dictionary8.Clear();
							list14.Add(dictionary8);
							dictionary8.Add("id", item2.Id);
							dictionary8.Add("level", item2.BaseValue);
						}
						list12.Add(list14);
						List<EntryData> allEntry = armour.Value.GetAllEntry();
						List<object> list15 = ListPool<object>.Get();
						list15.Clear();
						foreach (EntryData item3 in allEntry)
						{
							Dictionary<string, object> dictionary9 = DictionaryPool<string, object>.Get();
							dictionary9.Clear();
							list15.Add(dictionary9);
							dictionary9.Add("id", item3.DrEntry.EntryId);
							dictionary9.Add("level", item3.CurLevel);
						}
						list13.Add(list15);
					}
					list3.Add(dictionary6);
				}
				if (heroModel.Armours != null)
				{
					heroModel.Armours.TryGetValue(5, out var value);
					if (value != null)
					{
						Dictionary<string, object> dictionary10 = DictionaryPool<string, object>.Get();
						dictionary10.Clear();
						dictionary10.Add("player_id", teamMembers[i].uid);
						dictionary10.Add("hero", heroModel.Id);
						dictionary10.Add("grade", value.Rarity);
						dictionary10.Add("rank", value.Rank);
						if (value.EntryDataList != null && value.EntryDataList.Count > 0)
						{
							Dictionary<string, object> dictionary11 = DictionaryPool<string, object>.Get();
							dictionary11.Clear();
							dictionary10.Add("effect", dictionary11);
							dictionary11.Add("id", value.EntryDataList[0].DrEntry.Id);
							dictionary11.Add("level", value.EntryDataList[0].DrEntry.EntryValue);
						}
						List<Dictionary<string, object>> list16 = ListPool<Dictionary<string, object>>.Get();
						list16.Clear();
						dictionary10.Add("skill", list16);
						List<EntryData> additionalEntryList = value.AdditionalEntryList;
						if (additionalEntryList != null)
						{
							foreach (EntryData item4 in additionalEntryList)
							{
								Dictionary<string, object> dictionary12 = DictionaryPool<string, object>.Get();
								dictionary12.Clear();
								list16.Add(dictionary12);
								dictionary12.Add("id", item4.DrEntry.EntryId);
								dictionary12.Add("level", item4.CurLevel);
							}
						}
						list4.Add(dictionary10);
					}
				}
				if (heroModel.BpDatas == null)
				{
					continue;
				}
				foreach (KeyValuePair<int, BPData> bpData in heroModel.BpDatas)
				{
					if (bpData.Value != null && bpData.Value.Id > 0)
					{
						Dictionary<string, object> dictionary13 = DictionaryPool<string, object>.Get();
						dictionary13.Clear();
						dictionary13.Add("player_id", teamMembers[i].uid);
						dictionary13.Add("hero", heroModel.Id);
						dictionary13.Add("id", bpData.Value.Id);
						dictionary13.Add("name", bpData.Value.Name);
						dictionary13.Add("num", bpData.Value.GetCarryPropNumber());
						list5.Add(dictionary13);
					}
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取角色埋点数据发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		return dictionary;
	}

	public List<Dictionary<string, object>> GetHeroDetails(List<TeamMember> teamMembers)
	{
		List<Dictionary<string, object>> list = ListPool<Dictionary<string, object>>.Get();
		list.Clear();
		for (int i = 0; i < teamMembers.Count; i++)
		{
			Dictionary<string, object> dictionary = DictionaryPool<string, object>.Get();
			dictionary.Clear();
			list.Add(dictionary);
			dictionary.Add("player_id", teamMembers[i].uid);
			Dictionary<string, object> dictionary2 = DictionaryPool<string, object>.Get();
			dictionary2.Clear();
			dictionary.Add("character_detail", dictionary2);
			HeroModel heroModel = teamMembers[i].HeroModel;
			dictionary2.Add("id", heroModel.Id);
			dictionary2.Add("ai", teamMembers[i].IsAI);
			dictionary2.Add("level", heroModel.Level);
			dictionary2.Add("crown", heroModel.DestinyLevel);
			if (heroModel.TalentDatas != null)
			{
				List<Dictionary<string, object>> list2 = ListPool<Dictionary<string, object>>.Get();
				dictionary2.Add("talent", list2);
				foreach (KeyValuePair<int, HCTalentData> talentData in heroModel.TalentDatas)
				{
					Dictionary<string, object> dictionary3 = DictionaryPool<string, object>.Get();
					dictionary3.Clear();
					list2.Add(dictionary3);
					dictionary3.Add("id", talentData.Value.SkillId);
					dictionary3.Add("level", talentData.Value.BigLevel);
					dictionary3.Add("fire", talentData.Value.SmallOrder);
				}
			}
			List<Dictionary<string, object>> list3 = ListPool<Dictionary<string, object>>.Get();
			list3.Clear();
			dictionary2.Add("attri", list3);
			foreach (KeyValuePair<string, float> numerical in heroModel.TotalProperty.Numericals)
			{
				Dictionary<string, object> dictionary4 = DictionaryPool<string, object>.Get();
				dictionary4.Clear();
				list3.Add(dictionary4);
				dictionary4.Add("id", numerical.Key);
				dictionary4.Add("value", numerical.Value);
			}
			List<Dictionary<string, object>> list4 = ListPool<Dictionary<string, object>>.Get();
			list4.Clear();
			dictionary2.Add("skill", list4);
			foreach (EntryData item in heroModel.GetAllEntry())
			{
				Dictionary<string, object> dictionary5 = DictionaryPool<string, object>.Get();
				dictionary5.Clear();
				list4.Add(dictionary5);
				dictionary5.Add("id", item.DrEntry.Id);
				dictionary5.Add("level", item.CurLevel);
			}
			if (heroModel.HeldWeapon != null)
			{
				Dictionary<string, object> dictionary6 = DictionaryPool<string, object>.Get();
				dictionary6.Clear();
				dictionary.Add("weapon_detail", dictionary6);
				dictionary6.Add("id", heroModel.HeldWeapon.Id);
				dictionary6.Add("level", heroModel.HeldWeapon.Level);
			}
			if (heroModel.Armours != null)
			{
				List<Dictionary<string, object>> list5 = ListPool<Dictionary<string, object>>.Get();
				list5.Clear();
				dictionary.Add("armor_detail", list5);
				foreach (KeyValuePair<int, ArmourData> armour in heroModel.Armours)
				{
					if (armour.Key == 5 || armour.Value == null)
					{
						continue;
					}
					Dictionary<string, object> dictionary7 = DictionaryPool<string, object>.Get();
					dictionary7.Clear();
					list5.Add(dictionary7);
					dictionary7.Add("id", armour.Value.Id);
					dictionary7.Add("level", armour.Value.Level);
					dictionary7.Add("grade", armour.Value.Rarity);
					dictionary7.Add("rank", armour.Value.Rank);
					List<Dictionary<string, object>> list6 = ListPool<Dictionary<string, object>>.Get();
					list6.Clear();
					dictionary7.Add("main_attri", list6);
					Dictionary<string, object> dictionary8 = DictionaryPool<string, object>.Get();
					dictionary8.Clear();
					list6.Add(dictionary8);
					dictionary8.Add("id", armour.Value.GetMainAttribute()?.Id ?? 0);
					dictionary8.Add("level", armour.Value.GetMainAttribute()?.BaseValue ?? 0f);
					List<EquipAttribute> subAttribute = armour.Value.GetSubAttribute();
					List<Dictionary<string, object>> list7 = ListPool<Dictionary<string, object>>.Get();
					list7.Clear();
					dictionary7.Add("sub_attri", list7);
					foreach (EquipAttribute item2 in subAttribute)
					{
						Dictionary<string, object> dictionary9 = DictionaryPool<string, object>.Get();
						dictionary9.Clear();
						list7.Add(dictionary9);
						dictionary9.Add("id", item2.Id);
						dictionary9.Add("level", item2.BaseValue);
					}
					List<EntryData> allEntry = armour.Value.GetAllEntry();
					List<Dictionary<string, object>> list8 = ListPool<Dictionary<string, object>>.Get();
					list8.Clear();
					dictionary7.Add("sub_skill", list8);
					foreach (EntryData item3 in allEntry)
					{
						Dictionary<string, object> dictionary10 = DictionaryPool<string, object>.Get();
						dictionary10.Clear();
						list8.Add(dictionary10);
						dictionary10.Add("id", item3.DrEntry.EntryId);
						dictionary10.Add("level", item3.CurLevel);
					}
				}
				List<Dictionary<string, object>> list9 = ListPool<Dictionary<string, object>>.Get();
				list9.Clear();
				dictionary.Add("suitcase_detail", list9);
				heroModel.Armours.TryGetValue(5, out var value);
				if (value != null)
				{
					Dictionary<string, object> dictionary11 = DictionaryPool<string, object>.Get();
					dictionary11.Clear();
					list9.Add(dictionary11);
					dictionary11.Add("id", value.Id);
					dictionary11.Add("grade", value.Rarity);
					dictionary11.Add("rank", value.Rank);
					if (value.EntryDataList.Count > 0)
					{
						dictionary11.Add("effect", value.EntryDataList[0]);
					}
					List<EntryData> additionalEntryList = value.AdditionalEntryList;
					List<Dictionary<string, object>> list10 = ListPool<Dictionary<string, object>>.Get();
					list10.Clear();
					dictionary11.Add("sub_attri", list10);
					foreach (EntryData item4 in additionalEntryList)
					{
						Dictionary<string, object> dictionary12 = DictionaryPool<string, object>.Get();
						dictionary12.Clear();
						list10.Add(dictionary12);
						dictionary12.Add("id", item4.DrEntry.EntryId);
						dictionary12.Add("level", item4.CurLevel);
					}
				}
			}
			List<Dictionary<string, object>> list11 = ListPool<Dictionary<string, object>>.Get();
			list11.Clear();
			dictionary.Add("Combat_props_detail", list11);
			if (heroModel.BpDatas == null)
			{
				continue;
			}
			foreach (KeyValuePair<int, BPData> bpData in heroModel.BpDatas)
			{
				if (bpData.Value != null && bpData.Value.Id > 0)
				{
					Dictionary<string, object> dictionary13 = DictionaryPool<string, object>.Get();
					dictionary13.Clear();
					list11.Add(dictionary13);
					dictionary13.Add("Combat_props_detail.id", bpData.Value.Id);
					dictionary13.Add("Combat_props_detail.name", bpData.Value.Name);
					dictionary13.Add("Combat_props_detail.num", bpData.Value.GetCarryPropNumber());
				}
			}
		}
		return list;
	}

	public async Task CheckRefetch()
	{
		if (refetchCultureData)
		{
			Loading loading = await Loading.Show();
			await RequestServiceData();
			await ServiceHelper.RequestDataInPropTable();
			loading.Dispose();
		}
	}

	public async UniTask<List<int>> GetSkinTimelineCollect()
	{
		C2S_GetSkinTimelineCollect rst = C2S_GetSkinTimelineCollect.Create();
		rst.Type = 1;
		S2C_GetSkinTimelineCollect response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_GetSkinTimelineCollect>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取 烬天使皮肤Timeline 收藏数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取 烬天使皮肤Timeline 收藏数据 失败"))
			{
				return response.CollectIds;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> SetSkinTimelineCollect(List<int> savedList)
	{
		C2S_SetSkinTimelineCollect rst = C2S_SetSkinTimelineCollect.Create();
		rst.CollectIds = savedList;
		rst.Type = 1;
		S2C_SetSkinTimelineCollect response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_SetSkinTimelineCollect>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "烬天使皮肤Timeline 收藏") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "烬天使皮肤Timeline 收藏 失败"))
			{
				if (!string.IsNullOrEmpty(response.Message))
				{
					Toast.ShowInfo(response.Message);
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
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<List<int>> GetSkinTimelineReadList()
	{
		C2S_GetSkinTimelineCollect rst = C2S_GetSkinTimelineCollect.Create();
		rst.Type = 2;
		S2C_GetSkinTimelineCollect response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_GetSkinTimelineCollect>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取 烬天使皮肤Timeline 已观看数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取 烬天使皮肤Timeline 已观看数据 失败"))
			{
				_readTimelineList = response.CollectIds ?? new List<int>();
				return _readTimelineList;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> SetSkinTimelineRead(List<int> savedList)
	{
		C2S_SetSkinTimelineCollect rst = C2S_SetSkinTimelineCollect.Create();
		rst.CollectIds = savedList;
		rst.Type = 2;
		S2C_SetSkinTimelineCollect response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_SetSkinTimelineCollect>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "保存 烬天使皮肤Timeline 已观看数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "保存 烬天使皮肤Timeline 已观看数据 失败"))
			{
				if (!string.IsNullOrEmpty(response.Message))
				{
					Toast.ShowInfo(response.Message);
				}
				_readTimelineList = savedList ?? new List<int>();
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
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public bool GetSkinTlUnlockState(DRHeroSkinTimeLine config, out string msg)
	{
		msg = "";
		if (config == null)
		{
			return false;
		}
		switch (config.TLLock)
		{
		case 1:
			msg = "需要先观看" + GameEntry.DataTable.GetDataRow<DRHeroSkinTimeLine>(config.LockParams)?.Title;
			return _readTimelineList.Contains(config.LockParams);
		case 2:
		{
			DRUIHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(config.Id);
			if (dataRow2 == null)
			{
				return false;
			}
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(dataRow2.HeroID);
			int num3 = heroById?.FeelingLevel ?? 0;
			msg = $"需要{heroById?.Name}好感度达到{num3}级";
			return num3 >= config.LockParams;
		}
		case 3:
		{
			DRHeroSkinTimeLine[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSkinTimeLine p) => p.ListID == config.LockParams);
			if (dataRows == null)
			{
				return true;
			}
			DRSkinMessage dataRow = GameEntry.DataTable.GetDataRow((DRSkinMessage p) => p.ListID.Contains(config.LockParams));
			if (dataRow != null)
			{
				int num = dataRow.ListID.FindIndex((int p) => p.Equals(config.LockParams));
				string text = ((num >= 0 && dataRow.ListName.Count > num) ? dataRow.ListName[num] : "");
				msg = "需要先观看完" + text + "内的所有剧情";
			}
			DRHeroSkinTimeLine[] array = dataRows;
			foreach (DRHeroSkinTimeLine dRHeroSkinTimeLine in array)
			{
				if (!_readTimelineList.Contains(dRHeroSkinTimeLine.Id))
				{
					return false;
				}
			}
			return true;
		}
		default:
			return true;
		}
	}

	public List<int> GetSkinTlReadList()
	{
		return _readTimelineList;
	}
}
