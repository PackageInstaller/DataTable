#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;

namespace Ase;

public class UIJumpHelper
{
	public async Task<OpenViewArg> CreateViewJumpData(JumpWindowParams pars, OptionBase parent, string entrance = "", Action callback = null)
	{
		string windowName = pars.WindowName;
		List<int> args = new List<int>();
		if (pars.Args != null)
		{
			foreach (object arg in pars.Args)
			{
				args.Add((int)arg);
			}
		}
		switch (windowName)
		{
		case "HeroSkillSkinWindow":
		{
			HeroSkillSkinOpenArg heroSkillSkinOpenArg = HeroSkillSkinOpenArg.CreateByPropId((args.Count > 0) ? args[0] : 0);
			if (heroSkillSkinOpenArg == null || heroSkillSkinOpenArg.HeroId <= 0 || heroSkillSkinOpenArg.SkillId <= 0)
			{
				Toast.ShowInfo("技能皮肤跳转配置异常");
				return null;
			}
			HeroSkillSkinViewModel userData4 = new HeroSkillSkinViewModel(parent, heroSkillSkinOpenArg);
			return new OpenViewArg(typeof(HeroSkillSkinWindow), userData4, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "ActivityVersion1Window":
			return await CreateActivityVersionWindowArg(1302, parent, entrance, callback, args);
		case "ActivityVersion3Window":
			return await CreateActivityVersionWindowArg(1301, parent, entrance, callback, args);
		case "ActivityVersion4Window":
			return await CreateActivityVersionWindowArg(1550, parent, entrance, callback, args);
		case "DrawCardWindow":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70006))
			{
				Toast.ShowInfo("誓约未开启");
				return null;
			}
			MoneyData moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
			bool success = await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetLotteryPool();
			List<DrawCardTabData> drawCardTabInfos = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetDrawCardTabInfos();
			List<DrawCardItemInfo> lotteryResultInfos = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetLotteryResultInfos();
			int defaultPoolId = ((args.Count > 0) ? args[0] : 0);
			DrawCardViewModel drawCardViewModel = new DrawCardViewModel(parent, moneyData, drawCardTabInfos, lotteryResultInfos, defaultPoolId);
			await drawCardViewModel.InitAllCardsInfo();
			if (success)
			{
				return new OpenViewArg(typeof(DrawCardWindow), drawCardViewModel, entrance, isOpenWindow: true, "DEFAULT", callback);
			}
			return null;
		}
		case "GameActivityWindow":
		{
			await Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().SendGetGameActivityInfoRequest();
			GameActivityViewModel gameActivityViewModel = Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().GetGameActivityViewModel();
			gameActivityViewModel.SetParent(parent);
			return new OpenViewArg(typeof(GameActivityWindow), gameActivityViewModel, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "CopySecondType5Window":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018))
			{
				Toast.ShowInfo("肃清裂隙未开启");
				return null;
			}
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018))
			{
				Toast.ShowInfo("肃清裂隙未开启");
				return null;
			}
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpdateRealisticTime();
			await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRaceCopyInfo();
			int t5Zone = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().T5Zone;
			if (t5Zone == 0)
			{
				Toast.ShowInfo("当前暂无副本开放");
				return null;
			}
			CopySecondType5ViewModel userData7 = new CopySecondType5ViewModel(parent, t5Zone);
			return new OpenViewArg(typeof(CopySecondType5Window), userData7, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "HomeLandPlantWindow":
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70014))
			{
				Toast.ShowInfo("余温熔炉未开启");
				return null;
			}
			if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestFarmInfo())
			{
				FarmInfo farmInfo = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetFarmInfo();
				HLPlantViewModel userData11 = new HLPlantViewModel(parent, farmInfo.Level, farmInfo.FarmDataList);
				return new OpenViewArg(typeof(HLPlantWindow), userData11, entrance, isOpenWindow: true, "DEFAULT", callback);
			}
			Toast.ShowInfo("打开余温熔炉失败");
			return null;
		case "SailLightDispatchWindow":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70014))
			{
				Toast.ShowInfo("远航灯未开启");
				return null;
			}
			SailInfo sailInfo = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetSailLightEventList();
			int level = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetVm().BuildingDatas[2].Level;
			SailLightDispatchViewModel userData2 = new SailLightDispatchViewModel(parent, sailInfo, level);
			return new OpenViewArg(typeof(SailLightDispatchWindow), userData2, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "HomeShopWindow":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70014))
			{
				Toast.ShowInfo("余火商的灯码未开启");
				return null;
			}
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			HomeShopWindowViewModel homeShopWindowViewModel = new HomeShopWindowViewModel(parent, uid);
			if (await homeShopWindowViewModel.OnOpenBefore())
			{
				return new OpenViewArg(typeof(HomeShopWindow), homeShopWindowViewModel, entrance, isOpenWindow: true, "DEFAULT", callback);
			}
			return null;
		}
		case "GuildApplicationWindow":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70015))
			{
				Toast.ShowInfo("公会未开启");
				return null;
			}
			if (await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestMyGuildBaseInfo() != null)
			{
				GuildViewModel guildViewModel = new GuildViewModel(parent);
				await guildViewModel.RequestData();
				return new OpenViewArg(typeof(GuildWindow), guildViewModel, entrance, isOpenWindow: true, "DEFAULT", callback);
			}
			GuildApplicationViewModel userData6 = new GuildApplicationViewModel(parent);
			return new OpenViewArg(typeof(GuildApplicationWindow), userData6, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "HeroWarehouseWindow":
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70008))
			{
				Toast.ShowInfo("角色仓库未开启");
				return null;
			}
			return new OpenViewArg(typeof(HeroWarehouseWindow), new HeroWarehouseViewModel(parent), entrance, isOpenWindow: true, "DEFAULT", callback);
		case "WorldMapWindow":
		{
			int num = ((args.Count > 0) ? args[0] : 0);
			if (num > 0)
			{
				return new OpenViewArg(typeof(WorldMapWindow), new WorldMapViewModel(parent, num), entrance, isOpenWindow: true, "DEFAULT", callback);
			}
			return null;
		}
		case "LevelMapWindow":
		{
			int num3 = ((args.Count > 0) ? args[0] : 0);
			if (num3 > 0)
			{
				return new OpenViewArg(typeof(MapWindow), new MapViewModel(parent, MapMode.Outer, num3), entrance, isOpenWindow: true, "DEFAULT", callback);
			}
			return null;
		}
		case "PropOperationWindow":
		{
			KnapsackDefinition.PropOperationMode mode = KnapsackDefinition.PropOperationMode.Compose;
			int propId = 0;
			if (args.Count > 0 && Enum.IsDefined(typeof(KnapsackDefinition.PropOperationMode), args[0]))
			{
				mode = (KnapsackDefinition.PropOperationMode)args[0];
			}
			if (args.Count > 1)
			{
				propId = args[1];
			}
			return new OpenViewArg(typeof(PropOperationWindow), new PropOperationViewModel(parent, mode, propId), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "ShopWindow":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70005))
			{
				Toast.ShowInfo("采购未开启");
				return null;
			}
			int tabIndex = ((args.Count > 0) ? args[0] : 0);
			int subTabIndex = ((args.Count > 1) ? args[1] : 0);
			return new OpenViewArg(typeof(ShopWindow), new ShopWindowViewModel(parent, tabIndex, subTabIndex), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "CopySecondType1Window":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70019))
			{
				Toast.ShowInfo("碎烬裂隙未开启");
				return null;
			}
			int copyTypeId = ((args.Count > 0) ? args[0] : 0);
			int materialTypeId = ((args.Count > 1) ? args[1] : (-1));
			return new OpenViewArg(typeof(CopySecondType1Window), new CopySecondType1ViewModel(parent, copyTypeId, materialTypeId), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "CopyFirstWindow":
		{
			int num4 = ((args.Count > 0) ? args[0] : 0);
			string text = ((num4 == 1) ? "碎烬裂隙" : "回廊裂隙");
			int serviceId = ((num4 == 1) ? 70019 : 70010);
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(serviceId))
			{
				Toast.ShowInfo(text + "未开启");
				return null;
			}
			return new OpenViewArg(typeof(CopyFirstWindow), new CopyFirstViewModel(parent, num4), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "CopySecondType3Window":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70016))
			{
				Toast.ShowInfo("暗箱裂隙未开启");
				return null;
			}
			if (!Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().HasType3OpenCopy())
			{
				Toast.ShowInfo("暂无副本开放");
				return null;
			}
			int para = ((args.Count > 0) ? args[0] : 0);
			return new OpenViewArg(typeof(CopySecondType3Window), new CopySecondType3ViewModel(parent, para), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "CopySecondType4Window":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70017))
			{
				Toast.ShowInfo("极黯裂隙未开启");
				return null;
			}
			List<CopyTypeData> type4OpenCopy = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetType4OpenCopy();
			if (type4OpenCopy == null)
			{
				Toast.ShowInfo("极黯裂隙未开启！");
				return null;
			}
			return new OpenViewArg(typeof(CopySecondType4Window), new CopySecondType4ViewModel(parent, type4OpenCopy), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "HomelandMainWindow":
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70014))
			{
				Toast.ShowInfo("原初之灯未开启");
				return null;
			}
			return new OpenViewArg(typeof(HomelandMainWindow), new HomelandMainViewModel(), entrance, isOpenWindow: true, "DEFAULT", callback);
		case "OperatingActivityWindow":
		{
			JumpWindowParams jumpParams = new JumpWindowParams
			{
				WindowName = "OperatingActivityWindow",
				Args = args.ConvertAll((Converter<int, object>)((int p) => p))
			};
			if (parent is PhasedActivityViewModel phasedActivityViewModel)
			{
				parent = phasedActivityViewModel.Parent;
			}
			if (parent != null && !parent.CheckOpen(parent, jumpParams))
			{
				return null;
			}
			int autoSelectActivityId2 = ((args.Count > 0) ? args[0] : 0);
			return new OpenViewArg(typeof(OperatingActivityWindow), new OperatingActivityViewModel(parent, autoSelectActivityId2), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "OpActivityWindow":
		{
			int autoSelectActivityId = ((args.Count > 0) ? args[0] : 0);
			return new OpenViewArg(typeof(OperatingActivityWindow), new OperatingActivityViewModel(parent, autoSelectActivityId), entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "ActivityEquipView":
			return CreateActivityViewJumpArg("OperatingActivity/Equip/ActivityEquipView", parent, entrance, callback, args);
		case "AnnouncementWindow":
		{
			int defaultType = ((args.Count > 0) ? args[0] : 0);
			int defaultId = ((args.Count > 1) ? args[1] : 0);
			AnnouncementViewModel userData10 = new AnnouncementViewModel(parent, defaultType, defaultId);
			return new OpenViewArg(typeof(AnnouncementWindow), userData10, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "BuyPassportWindow":
		{
			PassportInfo passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
			BuyPassportViewModel userData9 = new BuyPassportViewModel(parent, passportInfo);
			return new OpenViewArg(typeof(BuyPassportWindow), userData9, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "BattlePropMakeWindow":
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70013))
			{
				Toast.ShowInfo("具现熔炉未开启");
				return null;
			}
			BattlePropMakeViewModel userData8 = new BattlePropMakeViewModel(parent);
			return new OpenViewArg(typeof(BattlePropMakeWindow), userData8, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "TaskMainWindow":
		{
			List<TaskDataViewModel> allTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask();
			TaskRedPointData redPoint = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetRedPoint();
			int num2 = ((args.Count > 0) ? args[0] : 0);
			if (num2 == 1 && !Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70011))
			{
				Toast.ShowInfo("悬赏任务未开启");
				return null;
			}
			TaskMainViewModel userData5 = new TaskMainViewModel(parent, redPoint, allTask, num2);
			return new OpenViewArg(typeof(TaskMainWindow), userData5, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "HeroCultivateWindow":
		{
			int heroId = ((args.Count > 1) ? args[1] : 0);
			int enterType = ((args.Count > 0) ? args[0] : 0);
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId, emptyCreateNew: false, saveNew: false);
			if (heroById.Empty)
			{
				return null;
			}
			HeroCultivateViewModel userData3 = new HeroCultivateViewModel(parent, heroById, enterType, changeHeroEnable: false);
			return new OpenViewArg(typeof(HeroCultivateWindow), userData3, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		case "WarehouseWindow":
		{
			KnapsackDefinition.WarehouseTabEnum defaultTab = KnapsackDefinition.WarehouseTabEnum.Weapon;
			if (args.Count > 0 && Enum.IsDefined(typeof(KnapsackDefinition.WarehouseTabEnum), args[0]))
			{
				defaultTab = (KnapsackDefinition.WarehouseTabEnum)args[0];
			}
			WarehouseViewModel userData = new WarehouseViewModel(parent, inBattle: false, defaultTab);
			return new OpenViewArg(typeof(WarehouseWindow), userData, entrance, isOpenWindow: true, "DEFAULT", callback);
		}
		default:
			return null;
		}
	}

	private static OpenViewArg CreateActivityViewJumpArg(string activityViewPath, OptionBase parent, string entrance, Action callback, List<int> args)
	{
		int num = ((args.Count > 0) ? args[0] : 0);
		if (num <= 0)
		{
			num = GetFirstUnderWayActivityTypeIdByViewPath(activityViewPath);
		}
		if (num <= 0)
		{
			Toast.ShowInfo("目标活动未开启");
			return null;
		}
		JumpWindowParams jumpParams = new JumpWindowParams
		{
			WindowName = "OperatingActivityWindow",
			Args = new List<object> { num }
		};
		if (parent is PhasedActivityViewModel phasedActivityViewModel)
		{
			parent = phasedActivityViewModel.Parent;
		}
		if (parent != null && !parent.CheckOpen(parent, jumpParams))
		{
			return null;
		}
		return new OpenViewArg(typeof(OperatingActivityWindow), new OperatingActivityViewModel(parent, num), entrance, isOpenWindow: true, "DEFAULT", callback);
	}

	private static int GetFirstUnderWayActivityTypeIdByViewPath(string activityViewPath)
	{
		Dictionary<int, ActivityViewModelBase> dictionary = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.ActivityViewModels;
		if (dictionary == null)
		{
			return 0;
		}
		foreach (ActivityViewModelBase value in dictionary.Values)
		{
			if (value != null && value.IsUnderWay() && string.Equals(value.UiViewName, activityViewPath, StringComparison.Ordinal))
			{
				return value.ActivityTypeId;
			}
		}
		return 0;
	}

	private static async Task<OpenViewArg> CreateActivityVersionWindowArg(int activityTypeId, OptionBase parent, string entrance, Action callback, List<int> args = null)
	{
		ActivityViewModelBase activityVm = (Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm())?.GetActivityViewModel(activityTypeId);
		if (activityVm == null)
		{
			Toast.ShowInfo("活动未开启");
			return null;
		}
		OptionBase oldParent = activityVm.Parent;
		activityVm.SetViewParent(parent);
		activityVm.RefreshActivityTime();
		activityVm.StartTimer();
		await activityVm.RequestDataBeforeShow();
		if (activityVm is ActivityVersion1ViewModel activityVersion1ViewModel)
		{
			activityVersion1ViewModel.SetOpenTag();
			if (args != null && args.Count > 0 && args[0] == 2)
			{
				activityVersion1ViewModel.SetInitPanel2();
			}
		}
		string configWindowPath = ActivityVersionConfig.GetConfigWindowPath(activityTypeId);
		if (string.IsNullOrEmpty(configWindowPath))
		{
			Log.Error($"找不到版本活动界面配置：{activityTypeId}");
			return null;
		}
		return new OpenViewArg(configWindowPath, activityVm, entrance, isOpenWindow: true, "DEFAULT", delegate
		{
			activityVm.SetViewParent(oldParent);
			callback?.Invoke();
		});
	}
}
