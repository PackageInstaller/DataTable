local var_0_0 = class("NewMainScene", import("..base.BaseUI"))

var_0_0.THEME_CLASSIC = 1
var_0_0.THEME_MELLOW = 2
var_0_0.OPEN_LIVEAREA = "NewMainScene.OPEN_LIVEAREA"
var_0_0.UPDATE_COVER = "NewMainScene.UPDATE_COVER"
var_0_0.FOLD = "NewMainScene.FOLD"
var_0_0.HIDE = "NewMainScene.HIDE"
var_0_0.CHAT_STATE_CHANGE = "NewMainScene.CHAT_STATE_CHANGE"
var_0_0.ON_CHANGE_SKIN = "NewMainScene.ON_CHANGE_SKIN"
var_0_0.ON_BUFF_DESC = "NewMainScene.ON_BUFF_DESC"
var_0_0.ON_SKIN_FREEUSAGE_DESC = "NewMainScene.ON_SKIN_FREEUSAGE_DESC"
var_0_0.ENABLE_PAITING_MOVE = "NewMainScene.ENABLE_PAITING_MOVE"
var_0_0.ENABLE_PAITING_SCALE = "NewMainScene.ENABLE_PAITING_SCALE"
var_0_0.SAVE_PART_SCALE = "NewMainScene.SAVE_PART_SCALE"
var_0_0.RESET_PAITING_SCALE = "NewMainScene.RESET_PAITING_SCALE"
var_0_0.SET_SCALE_PART_CONTENT = "NewMainScene.SET_SCALE_PART_CONTENT"
var_0_0.ON_ENTER_DONE = "NewMainScene.ON_ENTER_DONE"
var_0_0.ENTER_SILENT_VIEW = "NewMainScene.ENTER_SILENT_VIEW"
var_0_0.EXIT_SILENT_VIEW = "NewMainScene.EXIT_SILENT_VIEW"
var_0_0.L2D_BOUND_CHANGE = "NewMainScene.L2D_BOUND_CHANGE"
var_0_0.RESET_L2D = "NewMainScene.RESET_L2D"

function var_0_0.getUIName(arg_1_0)
	return "NewMainUI"
end

function var_0_0.getResource(arg_2_0)
	return ResPathSupport.MergeLuaArr({
		"ui/newmainui",
		"commonbg/bg_main_night",
		"commonbg/bg_main_twilight",
		"commonbg/bg_main_day",
		"ui/mainbgview",
		"ui/lihui_qiehuan01",
		"ui/lihui_qiehuan02",
		"spinematerials",
		"effect/jiehuntexiao",
		"ui/mainuibuffdescwindow",
		"ui/maincalibrationui",
		"clutter/mainui_calibration",
		"clutter/mainui_calibration_mellow",
		"ui/mainsilentviewui",
		"ui/mainui_atlas",
		"ui/exskinlistui",
		"ui/mainliveareaoldui",
		"ui/mainliveareaui",
		"ui/livingareacoverui",
		"ui/newmainclassictheme",
		"clutter/mainui_calibration",
		"ui/mainui_atlas",
		"ui/newmainmellowtheme",
		"clutter/mainui_calibration_mellow",
		"ui/respanel",
		"ui/goldexchangewindow"
	}, (function()
		local var_3_0, var_3_1 = MainBGView.GetBgAndBgm()

		return (ResPathSupport.MergeLuaArr({}, ResPathSupport.GetSoundResList(var_3_1), (ResPathSupport.GetSoundResList((var_0_0.super.getBGM(arg_2_0))))))
	end)(), (function()
		local var_4_0, var_4_1 = MainBGView.GetBgAndBgm()

		return (ResPathSupport.MergeLuaArr({}, {
			ResPathSupport.CombinePath(ResPathSupport.ConstPath.BG.CommonBG, var_4_0)
		}))
	end)(), (function()
		local var_5_0 = {}
		local var_5_1 = getProxy(LivingAreaCoverProxy)
		local var_5_2 = ResPathSupport.ConstPath.UI.LivingAreaCover

		_.each(var_5_1:GetUnlockList(), function(arg_6_0)
			table.insert(var_5_0, ResPathSupport.CombinePath(var_5_2, (arg_6_0:GetIcon())))

			return
		end)
		_.each(var_5_1:GetLockList(), function(arg_7_0)
			table.insert(var_5_0, ResPathSupport.CombinePath(var_5_2, (arg_7_0:GetIcon())))

			return
		end)

		return {}
	end)(), (function()
		local var_8_0 = {}

		_.each(getProxy(ActivityProxy):getBannerDisplays(), function(arg_9_0)
			table.insert(var_8_0, ResPathSupport.CombinePath(var_0_0.ConstPath.UI.ActivityBanner, arg_9_0.pic))

			return
		end)

		return {}
	end)(), (function()
		local var_10_0 = {}

		_.each(MainActivityBtnView.GetActivityBtnList(), function(arg_11_0)
			local var_11_0 = arg_11_0.New()
			local var_11_1 = var_11_0:ResPath()
			local var_11_2 = var_11_0:GetLinkConfig()

			if var_11_2 then
				if var_11_2.pic and #var_11_2.pic > 0 then
					table.insert(var_10_0, (string.lower((ResPathSupport.CombinePath(var_11_1, var_11_2.pic)))))
				end

				local var_11_3 = var_11_2.text_pic

				if var_11_2.text_pic and #var_11_3 > 0 then
					table.insert(var_10_0, (string.lower((ResPathSupport.CombinePath(var_11_1, var_11_3)))))
				end
			end

			local var_11_4 = ResPathSupport.ConstPath.UI.LinkButton
			local var_11_5 = var_11_0:GetTipImage()

			if var_11_5 and #var_11_5 > 0 then
				table.insert(var_10_0, (string.lower((ResPathSupport.CombinePath(var_11_4, var_11_5)))))
			end

			return
		end)
		_.each(MainActivityBtnView.GetSpecailBtns(), function(arg_12_0)
			local var_12_0 = arg_12_0.New():GetUIName()

			if var_12_0 and #var_12_0 > 0 then
				local var_12_1 = string.lower((ResPathSupport.CombinePath(ResPathSupport.ConstPath.UI.Base, var_12_0)))

				table.insert(var_10_0, var_12_1)
				table.insert(var_10_0, var_12_1 .. "4mellow")
			end

			return
		end)

		return {}
	end)(), (function()
		local var_13_0 = {}

		_.each(MainBuffView.CollectBuffs(), function(arg_14_0)
			table.insert(var_13_0, (string.lower(arg_14_0:getConfig("icon"))))

			return
		end)

		return {}
	end)(), ((function()
		local var_15_0 = getProxy(PlayerProxy):getData()

		for iter_15_0 = 1, PlayerVitaeShipsPage.GetAllUnlockSlotCnt() do
			table.insert({}, (ResPathSupport.GetShipAllRes((var_15_0:GetFlagShip()))))
		end

		return _.flatten({})
	end)()))
end

function var_0_0.needCache(arg_16_0)
	return true
end

function var_0_0.forceGC(arg_17_0)
	return true
end

function var_0_0.GetThemeStyle(arg_18_0)
	return getProxy(SettingsProxy):GetMainSceneThemeStyle()
end

function var_0_0.PlayBGM(arg_19_0)
	return
end

function var_0_0.GetFlagShip(arg_20_0)
	return (getProxy(PlayerProxy):getRawData():GetFlagShip())
end

function var_0_0.RevertAsmrShip(arg_21_0)
	getProxy(BayProxy):ClearChangeSkinAsmr()

	return
end

function var_0_0.PlayBgm(arg_22_0, arg_22_1)
	local var_22_0
	local var_22_1

	if underscore.any({
		function()
			if arg_22_1:IsBgmSkin() then
				if getProxy(SettingsProxy):IsBGMEnable() then
					var_22_0 = arg_22_1:GetSkinBgm()
				end
			end

			return tobool(var_22_0)
		end,
		function()
			if getProxy(SettingsProxy):IsEnableMainMusicPlayer() then
				if getProxy(AppreciateProxy):CanPlayMainMusicPlayer() then
					var_22_0 = "MainMusicPlayer"
					;({}).loopType = getProxy(AppreciateProxy):getMusicPlayerLoopType()
					;({}).albumName = getProxy(AppreciateProxy):getMainPlayerAlbumName()
					var_22_1 = {}
				end
			end

			return tobool(var_22_0)
		end,
		function()
			local var_25_0, var_25_1 = MainBGView.GetBgAndBgm()

			var_22_0 = var_25_1

			return tobool(var_22_0)
		end,
		function()
			var_22_0 = var_0_0.super.getBGM(arg_22_0)

			return tobool(var_22_0)
		end
	}, function(arg_27_0)
		return arg_27_0()
	end) then
		pg.BgmMgr.GetInstance():Push(arg_22_0.__cname, nil, nil)
	end

	return
end

function var_0_0.ResUISettings(arg_28_0)
	return {
		showType = PlayerResUI.TYPE_ALL,
		anim = not arg_28_0.resAnimFlag
	}
end

function var_0_0.ShowOrHideResUI(arg_29_0, arg_29_1)
	if not arg_29_0.isInit then
		return
	end

	var_0_0.super.ShowOrHideResUI(arg_29_0, arg_29_1)

	return
end

function var_0_0.init(arg_30_0)
	arg_30_0.mainCG = GetOrAddComponent(arg_30_0._tf, typeof(CanvasGroup))
	arg_30_0.bgView = MainBGView.New(arg_30_0._tf:Find("Sea/bg"))
	arg_30_0.paintingView = MainPaintingView.New(arg_30_0._tf:Find("paint"), arg_30_0._tf:Find("paintBg"), arg_30_0.event)
	arg_30_0.effectView = MainEffectView.New(arg_30_0._tf:Find("paint/effect"))
	arg_30_0.buffDescPage = MainBuffDescPage.New(arg_30_0._tf, arg_30_0.event)
	arg_30_0.calibrationPage = MainCalibrationPage.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	arg_30_0.silentView = MainSilentView.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	arg_30_0.silentChecker = MainSilentChecker.New(arg_30_0.event)
	arg_30_0.skinExperienceDisplayPage = SkinExperienceDiplayPage.New(arg_30_0._tf, arg_30_0.event)
	arg_30_0.liveAreaPage = USE_OLD_MAIN_LIVE_AREA_UI and MainLiveAreaOldPage.New(arg_30_0._tf, arg_30_0.event) or MainLiveAreaPage.New(arg_30_0._tf, arg_30_0.event)
	arg_30_0.subMediator = MainReddotMediator.New()

	pg.m02:registerMediator(arg_30_0.subMediator)

	arg_30_0.sequenceView = MainSequenceView.New()
	arg_30_0.awakeSequenceView = MainAwakeSequenceView.New()
	arg_30_0.themes = {
		[NewMainScene.THEME_CLASSIC] = NewMainClassicTheme.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData),
		[NewMainScene.THEME_MELLOW] = NewMainMellowTheme.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	}

	for iter_30_0, iter_30_1 in pairs(arg_30_0.themes) do
		iter_30_1:RegisterView(arg_30_0)
	end

	arg_30_0:RevertAsmrShip()

	return
end

function var_0_0.didEnter(arg_31_0)
	arg_31_0:bind(NewMainScene.FOLD, function(arg_32_0, arg_32_1)
		arg_31_0:FoldPanels(arg_32_1)

		if not arg_31_0.paintingView.ship then
			return
		end

		arg_31_0.calibrationPage:ExecuteAction("ShowOrHide", arg_32_1, arg_31_0.bgView.ship, arg_31_0.theme:GetPaintingOffset(arg_31_0.paintingView.ship), arg_31_0.theme:GetCalibrationBG())

		return
	end)
	arg_31_0:bind(NewMainScene.HIDE, function(arg_33_0, arg_33_1)
		arg_31_0:HidePanel(arg_33_1)

		if not arg_31_0.paintingView.ship then
			return
		end

		arg_31_0.calibrationPage:ExecuteAction("ShowOrHide", arg_33_1, arg_31_0.bgView.ship, arg_31_0.theme:GetPaintingOffset(arg_31_0.paintingView.ship), arg_31_0.theme:GetCalibrationBG())

		return
	end)
	arg_31_0:bind(NewMainScene.ON_CHANGE_SKIN, function(arg_34_0)
		arg_31_0:SwitchToNextShip()

		return
	end)
	arg_31_0:bind(NewMainScene.ENTER_SILENT_VIEW, function()
		arg_31_0:ExitCalibrationView()
		arg_31_0:FoldPanels(true)
		arg_31_0.silentView:ExecuteAction("Show")

		return
	end)
	arg_31_0:bind(GAME.WILL_LOGOUT, function()
		arg_31_0:GameLogout()

		return
	end)
	arg_31_0:bind(NewMainScene.EXIT_SILENT_VIEW, function()
		arg_31_0:ExitSilentView()
		arg_31_0:SetUpSilentChecker()

		return
	end)
	arg_31_0:bind(NewMainScene.ON_SKIN_FREEUSAGE_DESC, function(arg_38_0, arg_38_1)
		arg_31_0.skinExperienceDisplayPage:ExecuteAction("Show", arg_38_1)

		return
	end)
	arg_31_0:bind(NewMainScene.OPEN_LIVEAREA, function(arg_39_0)
		arg_31_0.liveAreaPage:ExecuteAction("Show")

		return
	end)
	arg_31_0:bind(NewMainScene.L2D_BOUND_CHANGE, function(arg_40_0)
		arg_31_0.paintingView:OnBoundChange()

		return
	end)
	arg_31_0:SetUp(false, true)

	return
end

function var_0_0.SetUp(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.mainCG.blocksRaycasts = false
	arg_41_0.isInit = false
	arg_41_0.resAnimFlag = false

	local var_41_0

	seriesAsync({
		function(arg_42_0)
			if arg_41_0:CheckDebugBattleLoop() then
				return
			else
				arg_42_0()
			end

			return
		end,
		function(arg_43_0)
			arg_41_0.awakeSequenceView:Execute(arg_43_0)

			return
		end,
		function(arg_44_0)
			var_41_0 = arg_41_0:GetFlagShip()

			arg_41_0.bgView:Init(var_41_0)
			onNextTick(arg_44_0)

			return
		end,
		function(arg_45_0)
			arg_41_0.theme = arg_41_0.themes[arg_41_0:GetThemeStyle()]

			arg_41_0.theme:ExecuteAction("Show", arg_45_0)

			return
		end,
		function(arg_46_0)
			onNextTick(arg_46_0)

			return
		end,
		function(arg_47_0)
			arg_41_0.isInit = true

			arg_41_0.theme:PlayEnterAnimation(var_41_0, arg_47_0)
			arg_41_0.paintingView:Init(var_41_0, arg_41_0.theme:GetPaintingOffset(var_41_0), arg_41_1)

			arg_41_0.resAnimFlag = true

			return
		end,
		function(arg_48_0)
			arg_41_0:PlayBgm(var_41_0)
			arg_41_0.effectView:Init(var_41_0)
			arg_41_0.theme:init(var_41_0)
			onNextTick(arg_48_0)

			return
		end,
		function(arg_49_0)
			arg_41_0:ShowOrHideResUI(arg_41_0.theme:ApplyDefaultResUI())
			arg_41_0.sequenceView:Execute(arg_49_0)

			return
		end
	}, function()
		arg_41_0:SetUpSilentChecker()
		arg_41_0:emit(NewMainScene.ON_ENTER_DONE)

		arg_41_0.mainCG.blocksRaycasts = true

		if arg_41_2 then
			gcAll()
		end

		return
	end)

	return
end

function var_0_0.SetUpSilentChecker(arg_51_0)
	arg_51_0.defaultSleepTimeout = Screen.sleepTimeout
	Screen.sleepTimeout = getProxy(SettingsProxy):GetMainSceneScreenSleepTime()

	if SettingsMainScenePanel.IsEnableStandbyMode() then
		arg_51_0.silentChecker:SetUp()
	end

	return
end

function var_0_0.RevertSleepTimeout(arg_52_0)
	if arg_52_0.defaultSleepTimeout and Screen.sleepTimeout ~= arg_52_0.defaultSleepTimeout then
		Screen.sleepTimeout = arg_52_0.defaultSleepTimeout
	end

	arg_52_0.defaultSleepTimeout = nil

	return
end

function var_0_0.FoldPanels(arg_53_0, arg_53_1)
	if not arg_53_0.theme then
		return
	end

	arg_53_0.foldFlag = arg_53_1

	arg_53_0.theme:OnFoldPanels(arg_53_1)
	arg_53_0.paintingView:Fold(arg_53_1, 0.5)
	pg.playerResUI:Fold(arg_53_1, 0.5)
	arg_53_0:SetEffectPanelVisible(not arg_53_1)

	return
end

function var_0_0.HidePanel(arg_54_0, arg_54_1)
	if not arg_54_0.theme then
		return
	end

	if arg_54_0.foldFlag == arg_54_1 then
		return
	end

	arg_54_0.foldFlag = arg_54_1

	arg_54_0.theme:OnFoldPanels(arg_54_1)

	if arg_54_0._asmrTurnning then
		if arg_54_0.foldFlag == true then
			pg.playerResUI:Fold(arg_54_1, 0.5)
		end
	else
		pg.playerResUI:Fold(arg_54_1, 0.5)
	end

	if not arg_54_1 and arg_54_0._asmrTurnning then
		arg_54_0:SetEffectPanelVisible(false)
	else
		arg_54_0:SetEffectPanelVisible(not arg_54_1)
	end

	return
end

function var_0_0.AsmrTurning(arg_55_0, arg_55_1)
	arg_55_0._asmrTurnning = arg_55_1

	arg_55_0.paintingView:OnAsmrTurnning(arg_55_1)
	arg_55_0.theme:OnAsmrTurnning(arg_55_1)
	arg_55_0.silentChecker:SetSilentRun(not arg_55_1)

	if not arg_55_0._asmrTurnning then
		arg_55_0:SetUpSilentChecker()
		pg.BgmMgr.GetInstance():ContinuePlay()
	else
		pg.BgmMgr.GetInstance():StopPlay()
	end

	return
end

function var_0_0.SwitchToNextShip(arg_56_0)
	if arg_56_0.paintingView:IsLoading() or arg_56_0.bgView:IsLoading() or not arg_56_0.theme then
		return
	end

	local var_56_0 = getProxy(PlayerProxy):getRawData():GetNextFlagShip()

	if arg_56_0.bgView.ship:getSkinId() ~= var_56_0:getSkinId() or arg_56_0.bgView.ship.id ~= var_56_0.id then
		arg_56_0.bgView:Refresh(var_56_0)
		arg_56_0:PlayBgm(var_56_0)
		arg_56_0.paintingView:Refresh(var_56_0, arg_56_0.theme:GetPaintingOffset(var_56_0))
		arg_56_0.effectView:Refresh(var_56_0)
		arg_56_0.theme:OnSwitchToNextShip(var_56_0)
	end

	return
end

function var_0_0.UpdateFlagShip(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0.paintingView:IsLoading() or arg_57_0.bgView:IsLoading() or not arg_57_0.theme then
		return
	end

	local var_57_0 = arg_57_2.callback

	arg_57_0.bgView:Refresh(arg_57_1)
	arg_57_0:PlayBgm(arg_57_1)
	arg_57_0.paintingView:SetOnceLoadedCall(var_57_0)
	arg_57_0.paintingView:Refresh(arg_57_1, arg_57_0.theme:GetPaintingOffset(arg_57_1))
	arg_57_0.effectView:Refresh(arg_57_1)
	arg_57_0.theme:OnSwitchToNextShip(arg_57_1)

	return
end

function var_0_0.CheckDebugBattleLoop(arg_58_0)
	if not InDebugBattleLoop then
		return false
	end

	local var_58_0 = InDebugBattleLoop

	if #InDebugBattleLoop.tempList == 0 then
		if #var_58_0.loopStages > 0 then
			local var_58_1 = table.remove(var_58_0.loopStages, 1)

			for iter_58_0 = 1, var_58_0.loopCount do
				table.insert(var_58_0.tempList, var_58_1)
			end
		else
			InDebugBattleLoop = nil

			pg.TipsMgr.GetInstance():ShowTips("finish")

			return false
		end
	end

	local var_58_2 = table.remove(var_58_0.tempList, 1)

	print(string.format("【正在执行关卡%s的第%d次战斗循环】", var_58_2, var_58_0.loopCount - #var_58_0.tempList))
	arg_58_0:emit(NewMainMediator.DEBUG_BATTLE_LOOP, var_58_2)

	return true
end

function var_0_0.PlayChangeSkinActionOut(arg_59_0, arg_59_1)
	arg_59_0.paintingView:PlayChangeSkinActionOut(arg_59_1)

	return
end

function var_0_0.PlayChangeSkinActionIn(arg_60_0, arg_60_1)
	arg_60_0.paintingView:PlayChangeSkinActionIn(arg_60_1)

	return
end

function var_0_0.CheckAndReplayBgm(arg_61_0)
	local var_61_0 = arg_61_0:GetFlagShip()

	arg_61_0.theme:Refresh(var_61_0)
	arg_61_0:PlayBgm(var_61_0)

	return
end

function var_0_0.SetEffectPanelVisible(arg_62_0, arg_62_1)
	if arg_62_0.theme then
		arg_62_0.theme:SetEffectPanelVisible(arg_62_1)
	end

	return
end

function var_0_0.OnVisible(arg_63_0)
	arg_63_0:RevertAsmrShip()

	local var_63_0 = arg_63_0.themes[arg_63_0:GetThemeStyle()]

	if not (not arg_63_0.theme or var_63_0 ~= arg_63_0.theme) then
		arg_63_0:Refresh()
	else
		arg_63_0:UnloadTheme()
		arg_63_0:SetUp(true)
	end

	return
end

function var_0_0.Refresh(arg_64_0)
	arg_64_0.mainCG.blocksRaycasts = false

	seriesAsync({
		function(arg_65_0)
			if arg_64_0:CheckDebugBattleLoop() then
				return
			else
				arg_65_0()
			end

			return
		end,
		function(arg_66_0)
			arg_64_0.awakeSequenceView:Execute(arg_66_0)

			return
		end,
		function(arg_67_0)
			arg_64_0.isInit = true

			arg_64_0:ShowOrHideResUI(arg_64_0.theme:ApplyDefaultResUI())

			local var_67_0 = arg_64_0:GetFlagShip()

			arg_64_0.bgView:Refresh(var_67_0)
			arg_64_0.paintingView:Refresh(var_67_0, arg_64_0.theme:GetPaintingOffset(var_67_0))
			arg_64_0.effectView:Refresh(var_67_0)
			arg_64_0.theme:Refresh(var_67_0)
			arg_64_0:PlayBgm(var_67_0)
			arg_67_0()

			return
		end,
		function(arg_68_0)
			arg_64_0.sequenceView:Execute(arg_68_0)

			return
		end
	}, function()
		arg_64_0:SetUpSilentChecker()
		arg_64_0:emit(NewMainScene.ON_ENTER_DONE)

		arg_64_0.mainCG.blocksRaycasts = true

		return
	end)

	return
end

function var_0_0.OnDisVisible(arg_70_0)
	arg_70_0:FoldPanels(false)
	arg_70_0.paintingView:Disable()
	arg_70_0.bgView:Disable()
	arg_70_0.sequenceView:Disable()
	arg_70_0.awakeSequenceView:Disable()

	if arg_70_0.theme then
		arg_70_0.theme:Disable()
	end

	arg_70_0.buffDescPage:Disable()
	arg_70_0.silentChecker:Disable()

	if arg_70_0.silentView and arg_70_0.silentView:isShowing() then
		arg_70_0:ExitSilentView()
	end

	arg_70_0.calibrationPage:Destroy()
	arg_70_0.calibrationPage:Reset()
	arg_70_0.skinExperienceDisplayPage:Destroy()
	arg_70_0.skinExperienceDisplayPage:Reset()
	arg_70_0.liveAreaPage:Destroy()
	arg_70_0.liveAreaPage:Reset()

	arg_70_0.isInit = false

	arg_70_0:RevertSleepTimeout()
	arg_70_0:RevertAsmrShip()

	return
end

function var_0_0.UnloadTheme(arg_71_0)
	if arg_71_0.theme then
		arg_71_0.theme:Destroy()
		arg_71_0.theme:Reset()

		arg_71_0.theme = nil
	end

	return
end

function var_0_0.ExitCalibrationView(arg_72_0)
	if arg_72_0.calibrationPage and arg_72_0.calibrationPage:GetLoaded() and arg_72_0.calibrationPage:isShowing() then
		triggerButton(arg_72_0.calibrationPage.backBtn)
	end

	return
end

function var_0_0.ExitSilentView(arg_73_0)
	if arg_73_0.silentView and arg_73_0.silentView:isShowing() then
		arg_73_0:FoldPanels(false)
		arg_73_0.silentView:Destroy()
		arg_73_0.silentView:Reset()
	end

	return
end

function var_0_0.GameLogout(arg_74_0)
	arg_74_0:ExitCalibrationView()
	arg_74_0:ExitSilentView()

	return
end

function var_0_0.OnPlayerUpdated(arg_75_0)
	if arg_75_0.theme and arg_75_0.theme:GetLoaded() then
		arg_75_0.theme:OnPlayerUpdated()
	end

	return
end

function var_0_0.onBackPressed(arg_76_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_76_0.silentView and arg_76_0.silentView:isShowing() then
		arg_76_0:ExitSilentView()

		return
	end

	if arg_76_0.liveAreaPage and arg_76_0.liveAreaPage:GetLoaded() and arg_76_0.liveAreaPage:isShowing() then
		arg_76_0.liveAreaPage:Hide()

		return
	end

	if arg_76_0.calibrationPage and arg_76_0.calibrationPage:GetLoaded() and arg_76_0.calibrationPage:isShowing() then
		triggerButton(arg_76_0.calibrationPage._parentTf)

		return
	end

	pg.SdkMgr.GetInstance():OnAndoridBackPress()
	pg.PushNotificationMgr.GetInstance():PushAll()

	return
end

function var_0_0.willExit(arg_77_0)
	arg_77_0.bgView:Dispose()

	arg_77_0.bgView = nil

	arg_77_0:UnloadTheme()

	if arg_77_0.calibrationPage then
		arg_77_0.calibrationPage:Destroy()

		arg_77_0.calibrationPage = nil
	end

	if arg_77_0.silentView then
		arg_77_0.silentView:Destroy()

		arg_77_0.silentView = nil
	end

	arg_77_0.paintingView:Dispose()

	arg_77_0.paintingView = nil

	arg_77_0.liveAreaPage:Destroy()

	arg_77_0.liveAreaPage = nil

	arg_77_0.sequenceView:Dispose()

	arg_77_0.sequenceView = nil

	arg_77_0.awakeSequenceView:Dispose()

	arg_77_0.awakeSequenceView = nil

	arg_77_0.effectView:Dispose()

	arg_77_0.effectView = nil

	pg.m02:removeMediator(arg_77_0.subMediator.__cname)

	arg_77_0.subMediator = nil

	arg_77_0.buffDescPage:Destroy()

	arg_77_0.buffDescPage = nil

	arg_77_0.silentChecker:Dispose()

	arg_77_0.silentChecker = nil

	arg_77_0.skinExperienceDisplayPage:Destroy()

	arg_77_0.skinExperienceDisplayPage = nil

	arg_77_0:RevertSleepTimeout()

	return
end

return var_0_0
