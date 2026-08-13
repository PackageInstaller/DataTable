class = var_0_10000

local var_0_0 = "NewMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.THEME_CLASSIC = 1
var_0_1.THEME_MELLOW = 2
var_0_1.OPEN_LIVEAREA = "NewMainScene.OPEN_LIVEAREA"
var_0_1.UPDATE_COVER = "NewMainScene.UPDATE_COVER"
var_0_1.FOLD = "NewMainScene.FOLD"
var_0_1.HIDE = "NewMainScene.HIDE"
var_0_1.CHAT_STATE_CHANGE = "NewMainScene.CHAT_STATE_CHANGE"
var_0_1.ON_CHANGE_SKIN = "NewMainScene.ON_CHANGE_SKIN"
var_0_1.ON_BUFF_DESC = "NewMainScene.ON_BUFF_DESC"
var_0_1.ON_SKIN_FREEUSAGE_DESC = "NewMainScene.ON_SKIN_FREEUSAGE_DESC"
var_0_1.ENABLE_PAITING_MOVE = "NewMainScene.ENABLE_PAITING_MOVE"
var_0_1.ENABLE_PAITING_SCALE = "NewMainScene.ENABLE_PAITING_SCALE"
var_0_1.SAVE_PART_SCALE = "NewMainScene.SAVE_PART_SCALE"
var_0_1.RESET_PAITING_SCALE = "NewMainScene.RESET_PAITING_SCALE"
var_0_1.SET_SCALE_PART_CONTENT = "NewMainScene.SET_SCALE_PART_CONTENT"
var_0_1.ON_ENTER_DONE = "NewMainScene.ON_ENTER_DONE"
var_0_1.ENTER_SILENT_VIEW = "NewMainScene.ENTER_SILENT_VIEW"
var_0_1.EXIT_SILENT_VIEW = "NewMainScene.EXIT_SILENT_VIEW"
var_0_1.L2D_BOUND_CHANGE = "NewMainScene.L2D_BOUND_CHANGE"
var_0_1.RESET_L2D = "NewMainScene.RESET_L2D"

function var_0_1.getUIName(arg_1_0)
	return "NewMainUI"
end

function var_0_1.getResource(arg_2_0)
	local var_2_0 = {
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
	}
	local var_2_1 = (function()
		local var_3_0 = {}

		MainBGView = var_2_10001

		local var_3_1, var_3_2 = var_2_10001.GetBgAndBgm()

		ResPathSupport = var_2_10003

		local var_3_3 = var_2_10003.GetSoundResList(var_3_2)
		local var_3_4 = var_0_1.super.getBGM(arg_2_0)

		ResPathSupport = var_5

		local var_3_5 = var_5.GetSoundResList(var_3_4)

		ResPathSupport = var_6

		return (var_6.MergeLuaArr(var_3_0, var_3_3, var_3_5))
	end)()
	local var_2_2 = (function()
		local var_4_0 = {}

		MainBGView = var_2_10001

		local var_4_1, var_4_2 = var_2_10001.GetBgAndBgm()

		ResPathSupport = var_2_10003

		local var_4_3 = var_2_10003.ConstPath.BG.CommonBG
		local var_4_4 = {}

		ResPathSupport = var_2_10005
		var_4_4[1] = var_2_10005.CombinePath(var_4_3, var_4_1)
		ResPathSupport = var_5

		return (var_5.MergeLuaArr(var_4_0, var_4_4))
	end)()
	local var_2_3 = (function()
		local var_5_0 = {}

		getProxy = var_2_10001
		LivingAreaCoverProxy = var_2_10003

		local var_5_1 = var_2_10001(var_2_10003)
		local var_5_2 = var_1.GetUnlockList(var_5_1)
		local var_5_3 = var_1
		local var_5_4 = var_1.GetLockList(var_5_3)

		ResPathSupport = var_5_1

		local var_5_5 = var_5_1.ConstPath.UI.LivingAreaCover

		_ = var_5_3

		var_5_3.each(var_5_2, function(arg_6_0)
			local var_6_0 = arg_6_0:GetIcon()

			table = var_3_10002

			local var_6_1 = var_3_10002.insert
			local var_6_2 = var_5_0

			ResPathSupport = var_3_10005

			var_6_1(var_6_2, var_3_10005.CombinePath(var_5_5, var_6_0))

			return
		end)

		_ = var_5

		var_5.each(var_5_4, function(arg_7_0)
			local var_7_0 = arg_7_0:GetIcon()

			table = var_3_10002

			local var_7_1 = var_3_10002.insert
			local var_7_2 = var_5_0

			ResPathSupport = var_3_10005

			var_7_1(var_7_2, var_3_10005.CombinePath(var_5_5, var_7_0))

			return
		end)

		return var_5_0
	end)()
	local var_2_4 = (function()
		local var_8_0 = {}

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_8_1 = var_2_10001(var_2_10003)
		local var_8_2 = var_1.getBannerDisplays(var_8_1)

		_ = var_2_10002

		var_2_10002.each(var_8_2, function(arg_9_0)
			local var_9_0 = var_0_1.ConstPath.UI.ActivityBanner
			local var_9_1 = arg_9_0.pic

			table = var_3_10003

			local var_9_2 = var_3_10003.insert
			local var_9_3 = var_8_0

			ResPathSupport = var_3_10006

			var_9_2(var_9_3, var_3_10006.CombinePath(var_9_0, var_9_1))

			return
		end)

		return var_8_0
	end)()
	local var_2_5 = (function()
		local var_10_0 = {}

		MainActivityBtnView = var_2_10001

		local var_10_1 = var_2_10001.GetActivityBtnList()

		_ = var_2_10002

		var_2_10002.each(var_10_1, function(arg_11_0)
			local var_11_0 = arg_11_0.New()
			local var_11_1 = var_1.ResPath(var_11_0)

			if var_1:GetLinkConfig() then
				if var_3.pic then
					local var_11_2 = #var_11_0

					if 0 < var_11_2 then
						ResPathSupport = var_11_2

						local var_11_3 = var_11_2.CombinePath(var_11_1, var_11_0)

						string = var_6

						local var_11_4 = var_6.lower(var_11_3)

						table = var_6

						var_6.insert(var_10_0, var_11_4)
					end
				end

				if var_3.text_pic then
					local var_11_5 = #var_11_0

					if 0 < var_11_5 then
						ResPathSupport = var_11_5

						local var_11_6 = var_11_5.CombinePath(var_11_1, var_11_0)

						string = var_6

						local var_11_7 = var_6.lower(var_11_6)

						table = var_6

						var_6.insert(var_10_0, var_11_7)
					end
				end
			end

			ResPathSupport = var_11_0

			local var_11_8 = var_11_0.ConstPath.UI.LinkButton

			if var_1:GetTipImage() then
				local var_11_9 = #var_5

				if 0 < var_11_9 then
					ResPathSupport = var_11_9

					local var_11_10 = var_11_9.CombinePath(var_11_8, var_5)

					string = var_7

					local var_11_11 = var_7.lower(var_11_10)

					table = var_7

					var_7.insert(var_10_0, var_11_11)
				end
			end

			return
		end)

		MainActivityBtnView = var_2

		local var_10_2 = var_2.GetSpecailBtns()

		_ = var_2_10003

		var_2_10003.each(var_10_2, function(arg_12_0)
			local var_12_0 = arg_12_0.New()

			ResPathSupport = var_3_10002

			local var_12_1 = var_3_10002.ConstPath.UI.Base

			if var_12_0:GetUIName() then
				local var_12_2 = #var_3

				if 0 < var_12_2 then
					ResPathSupport = var_12_2

					local var_12_3 = var_12_2.CombinePath(var_12_1, var_3)

					string = var_5

					local var_12_4 = var_5.lower(var_12_3)

					table = var_5

					var_5.insert(var_10_0, var_12_4)

					local var_12_5 = var_12_4 .. "4mellow"

					table = var_5

					var_5.insert(var_10_0, var_12_5)
				end
			end

			return
		end)

		return var_10_0
	end)()
	local var_2_6 = (function()
		local var_13_0 = {}

		MainBuffView = var_2_10001

		local var_13_1 = var_2_10001.CollectBuffs()

		_ = var_2_10002

		var_2_10002.each(var_13_1, function(arg_14_0)
			string = var_3_10001

			local var_14_0 = var_3_10001.lower(arg_14_0:getConfig("icon"))

			table = var_3_10002

			var_3_10002.insert(var_13_0, var_14_0)

			return
		end)

		return var_13_0
	end)()
	local var_2_7 = (function()
		local var_15_0 = {}

		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_15_1 = var_2_10001(var_2_10003)
		local var_15_2 = var_1.getData(var_15_1)

		PlayerVitaeShipsPage = var_2_10002

		local var_15_3 = var_2_10002.GetAllUnlockSlotCnt()

		for iter_15_0 = 1, var_15_3 do
			local var_15_4 = var_15_2
			local var_15_5 = var_15_2.GetFlagShip(var_15_4)

			ResPathSupport = var_2_10008
			var_2_10008 = var_2_10008.GetShipAllRes(var_15_5)
			table = var_15_4

			var_15_4.insert(var_15_0, var_2_10008)
		end

		_ = var_3

		return var_3.flatten(var_15_0)
	end)()

	ResPathSupport = var_1_10016

	return var_1_10016.MergeLuaArr(var_2_0, var_2_1, var_2_2, var_2_3, var_2_4, var_2_5, var_2_6, var_2_7)
end

function var_0_1.needCache(arg_16_0)
	return true
end

function var_0_1.forceGC(arg_17_0)
	return true
end

function var_0_1.GetThemeStyle(arg_18_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)

	return var_1.GetMainSceneThemeStyle(var_18_0)
end

function var_0_1.PlayBGM(arg_19_0)
	return
end

function var_0_1.GetFlagShip(arg_20_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)
	local var_20_1 = var_1.getRawData(var_20_0)

	return (var_1.GetFlagShip(var_20_1))
end

function var_0_1.RevertAsmrShip(arg_21_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)

	var_1.ClearChangeSkinAsmr(var_21_0)

	return
end

function var_0_1.PlayBgm(arg_22_0, arg_22_1)
	local var_22_0
	local var_22_1

	underscore = var_1_10004

	if var_1_10004.any({
		function()
			local var_23_0 = arg_22_1

			if var_0.IsBgmSkin(var_23_0) then
				getProxy = var_0
				SettingsProxy = var_23_0

				local var_23_1 = var_0(var_23_0)

				if var_0.IsBGMEnable(var_23_1) then
					local var_23_2 = arg_22_1

					var_22_0 = var_0.GetSkinBgm(var_23_2)
				end
			end

			tobool = var_0

			return var_0(var_22_0)
		end,
		function()
			getProxy = var_2_10000
			SettingsProxy = var_2_10002

			local var_24_0 = var_2_10000(var_2_10002)
			local var_24_2

			if var_0.IsEnableMainMusicPlayer(var_24_0) then
				getProxy = var_24_2
				AppreciateProxy = var_24_0

				local var_24_1 = var_24_2(var_24_0)

				if var_24_2.CanPlayMainMusicPlayer(var_24_1) then
					var_22_0 = "MainMusicPlayer"
					var_24_2 = {}
					getProxy = var_2_10001
					AppreciateProxy = var_2_10003

					local var_24_3 = var_2_10001(var_2_10003)

					var_24_2.loopType = var_1.getMusicPlayerLoopType(var_24_3)
					getProxy = var_1
					AppreciateProxy = var_24_3

					local var_24_4 = var_1(var_24_3)

					var_24_2.albumName = var_1.getMainPlayerAlbumName(var_24_4)
					var_22_1 = var_24_2
				end
			end

			tobool = var_24_2

			return var_24_2(var_22_0)
		end,
		function()
			MainBGView = var_2_10000

			local var_25_0, var_25_1 = var_2_10000.GetBgAndBgm()

			var_22_0 = var_25_1
			tobool = var_2_10002

			return var_2_10002(var_22_0)
		end,
		function()
			var_22_0 = var_0_1.super.getBGM(arg_22_0)
			tobool = var_0

			return var_0(var_22_0)
		end
	}, function(arg_27_0)
		return arg_27_0()
	end) then
		pg = var_4

		local var_22_2 = var_4.BgmMgr.GetInstance()

		var_4.Push(var_22_2, arg_22_0.__cname, var_22_0, var_22_1)
	end

	return
end

function var_0_1.ResUISettings(arg_28_0)
	local var_28_0 = {}

	PlayerResUI = var_1_10002
	var_28_0.showType = var_1_10002.TYPE_ALL
	var_28_0.anim = not arg_28_0.resAnimFlag

	return var_28_0
end

function var_0_1.ShowOrHideResUI(arg_29_0, arg_29_1)
	if not arg_29_0.isInit then
		return
	end

	var_0_1.super.ShowOrHideResUI(arg_29_0, arg_29_1)

	return
end

function var_0_1.init(arg_30_0)
	GetOrAddComponent = var_1_10001

	local var_30_0 = arg_30_0._tf

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_30_0.mainCG = var_1_10001(var_30_0, var_1_10004(var_1_10006))
	MainBGView = var_1

	local var_30_1 = var_1.New
	local var_30_2 = arg_30_0._tf

	arg_30_0.bgView = var_30_1(var_3.Find(var_30_2, "Sea/bg"))
	MainPaintingView = var_1

	local var_30_3 = var_1.New
	local var_30_4 = arg_30_0._tf
	local var_30_5 = var_3.Find(var_30_4, "paint")
	local var_30_6 = arg_30_0._tf

	arg_30_0.paintingView = var_30_3(var_30_5, var_4.Find(var_30_6, "paintBg"), arg_30_0.event)
	MainEffectView = var_1

	local var_30_7 = var_1.New
	local var_30_8 = arg_30_0._tf

	arg_30_0.effectView = var_30_7(var_3.Find(var_30_8, "paint/effect"))
	MainBuffDescPage = var_1
	arg_30_0.buffDescPage = var_1.New(arg_30_0._tf, arg_30_0.event)
	MainCalibrationPage = var_1
	arg_30_0.calibrationPage = var_1.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	MainSilentView = var_1
	arg_30_0.silentView = var_1.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	MainSilentChecker = var_1
	arg_30_0.silentChecker = var_1.New(arg_30_0.event)
	SkinExperienceDiplayPage = var_1
	arg_30_0.skinExperienceDisplayPage = var_1.New(arg_30_0._tf, arg_30_0.event)
	USE_OLD_MAIN_LIVE_AREA_UI = var_1

	if var_1 then
		MainLiveAreaOldPage = var_1
		arg_30_0.liveAreaPage = var_1.New(arg_30_0._tf, arg_30_0.event)
	else
		MainLiveAreaPage = var_1
		arg_30_0.liveAreaPage = var_1.New(arg_30_0._tf, arg_30_0.event)
	end

	MainReddotMediator = var_1
	arg_30_0.subMediator = var_1.New()
	pg = var_1

	local var_30_9 = var_1.m02

	var_1.registerMediator(var_30_9, arg_30_0.subMediator)

	MainSequenceView = var_1
	arg_30_0.sequenceView = var_1.New()
	MainAwakeSequenceView = var_1
	arg_30_0.awakeSequenceView = var_1.New()

	local var_30_10 = {}

	NewMainScene = var_1_10002

	local var_30_11 = var_1_10002.THEME_CLASSIC

	NewMainClassicTheme = var_30_9
	var_30_10[var_30_11] = var_30_9.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	NewMainScene = var_30_11

	local var_30_12 = var_30_11.THEME_MELLOW

	NewMainMellowTheme = var_3
	var_30_10[var_30_12] = var_3.New(arg_30_0._tf, arg_30_0.event, arg_30_0.contextData)
	arg_30_0.themes = var_30_10
	pairs = var_30_10

	for iter_30_0, iter_30_1 in var_30_10(arg_30_0.themes) do
		iter_30_1:RegisterView(arg_30_0)
	end

	arg_30_0:RevertAsmrShip()

	return
end

function var_0_1.didEnter(arg_31_0)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.bind

	NewMainScene = var_1_10004

	var_31_1(var_31_0, var_1_10004.FOLD, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_31_0

		var_2.FoldPanels(var_32_0, arg_32_1)

		if not arg_31_0.paintingView.ship then
			return
		end

		local var_32_1 = arg_31_0.calibrationPage
		local var_32_2 = var_3.ExecuteAction
		local var_32_3 = "ShowOrHide"
		local var_32_4 = arg_32_1
		local var_32_5 = arg_31_0.bgView.ship
		local var_32_6 = arg_31_0.theme
		local var_32_7 = var_9.GetPaintingOffset(var_32_6, var_2)
		local var_32_8 = arg_31_0.theme

		var_32_2(var_32_1, var_32_3, var_32_4, var_32_5, var_32_7, var_10.GetCalibrationBG(var_32_8))

		return
	end)

	local var_31_2 = arg_31_0
	local var_31_3 = arg_31_0.bind

	NewMainScene = var_4

	var_31_3(var_31_2, var_4.HIDE, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_31_0

		var_2.HidePanel(var_33_0, arg_33_1)

		if not arg_31_0.paintingView.ship then
			return
		end

		local var_33_1 = arg_31_0.calibrationPage
		local var_33_2 = var_3.ExecuteAction
		local var_33_3 = "ShowOrHide"
		local var_33_4 = arg_33_1
		local var_33_5 = arg_31_0.bgView.ship
		local var_33_6 = arg_31_0.theme
		local var_33_7 = var_9.GetPaintingOffset(var_33_6, var_2)
		local var_33_8 = arg_31_0.theme

		var_33_2(var_33_1, var_33_3, var_33_4, var_33_5, var_33_7, var_10.GetCalibrationBG(var_33_8))

		return
	end)

	local var_31_4 = arg_31_0
	local var_31_5 = arg_31_0.bind

	NewMainScene = var_4

	var_31_5(var_31_4, var_4.ON_CHANGE_SKIN, function(arg_34_0)
		local var_34_0 = arg_31_0

		var_1.SwitchToNextShip(var_34_0)

		return
	end)

	local var_31_6 = arg_31_0
	local var_31_7 = arg_31_0.bind

	NewMainScene = var_4

	var_31_7(var_31_6, var_4.ENTER_SILENT_VIEW, function()
		local var_35_0 = arg_31_0

		var_0.ExitCalibrationView(var_35_0)

		local var_35_1 = arg_31_0

		var_0.FoldPanels(var_35_1, true)

		local var_35_2 = arg_31_0.silentView

		var_0.ExecuteAction(var_35_2, "Show")

		return
	end)

	local var_31_8 = arg_31_0
	local var_31_9 = arg_31_0.bind

	GAME = var_4

	var_31_9(var_31_8, var_4.WILL_LOGOUT, function()
		local var_36_0 = arg_31_0

		var_0.GameLogout(var_36_0)

		return
	end)

	local var_31_10 = arg_31_0
	local var_31_11 = arg_31_0.bind

	NewMainScene = var_4

	var_31_11(var_31_10, var_4.EXIT_SILENT_VIEW, function()
		local var_37_0 = arg_31_0

		var_0.ExitSilentView(var_37_0)

		local var_37_1 = arg_31_0

		var_0.SetUpSilentChecker(var_37_1)

		return
	end)

	local var_31_12 = arg_31_0
	local var_31_13 = arg_31_0.bind

	NewMainScene = var_4

	var_31_13(var_31_12, var_4.ON_SKIN_FREEUSAGE_DESC, function(arg_38_0, arg_38_1)
		local var_38_0 = arg_31_0.skinExperienceDisplayPage

		var_2.ExecuteAction(var_38_0, "Show", arg_38_1)

		return
	end)

	local var_31_14 = arg_31_0
	local var_31_15 = arg_31_0.bind

	NewMainScene = var_4

	var_31_15(var_31_14, var_4.OPEN_LIVEAREA, function(arg_39_0)
		local var_39_0 = arg_31_0.liveAreaPage

		var_1.ExecuteAction(var_39_0, "Show")

		return
	end)

	local var_31_16 = arg_31_0
	local var_31_17 = arg_31_0.bind

	NewMainScene = var_4

	var_31_17(var_31_16, var_4.L2D_BOUND_CHANGE, function(arg_40_0)
		local var_40_0 = arg_31_0.paintingView

		var_1.OnBoundChange(var_40_0)

		return
	end)
	arg_31_0:SetUp(false, true)

	return
end

function var_0_1.SetUp(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.mainCG.blocksRaycasts = false
	arg_41_0.isInit = false
	arg_41_0.resAnimFlag = false

	local var_41_0

	seriesAsync = var_4

	var_4({
		function(arg_42_0)
			local var_42_0 = arg_41_0

			if var_1.CheckDebugBattleLoop(var_42_0) then
				return
			else
				arg_42_0()
			end

			return
		end,
		function(arg_43_0)
			local var_43_0 = arg_41_0.awakeSequenceView

			var_1.Execute(var_43_0, arg_43_0)

			return
		end,
		function(arg_44_0)
			local var_44_0 = arg_41_0

			var_41_0 = var_1.GetFlagShip(var_44_0)

			local var_44_1 = arg_41_0.bgView

			var_1.Init(var_44_1, var_41_0)

			onNextTick = var_1

			var_1(arg_44_0)

			return
		end,
		function(arg_45_0)
			local var_45_0 = arg_41_0
			local var_45_1 = arg_41_0.themes
			local var_45_2 = arg_41_0

			var_45_0.theme = var_45_1[var_3.GetThemeStyle(var_45_2)]

			local var_45_3 = arg_41_0.theme

			var_1.ExecuteAction(var_45_3, "Show", arg_45_0)

			return
		end,
		function(arg_46_0)
			onNextTick = var_2_10001

			var_2_10001(arg_46_0)

			return
		end,
		function(arg_47_0)
			arg_41_0.isInit = true

			local var_47_0 = arg_41_0.theme

			var_1.PlayEnterAnimation(var_47_0, var_41_0, arg_47_0)

			local var_47_1 = arg_41_0.theme
			local var_47_2 = var_1.GetPaintingOffset(var_47_1, var_41_0)
			local var_47_3 = arg_41_0.paintingView

			var_2.Init(var_47_3, var_41_0, var_47_2, arg_41_1)

			arg_41_0.resAnimFlag = true

			return
		end,
		function(arg_48_0)
			local var_48_0 = arg_41_0

			var_1.PlayBgm(var_48_0, var_41_0)

			local var_48_1 = arg_41_0.effectView

			var_1.Init(var_48_1, var_41_0)

			local var_48_2 = arg_41_0.theme

			var_1.init(var_48_2, var_41_0)

			onNextTick = var_1

			var_1(arg_48_0)

			return
		end,
		function(arg_49_0)
			local var_49_0 = arg_41_0
			local var_49_1 = var_1.ShowOrHideResUI
			local var_49_2 = arg_41_0.theme

			var_49_1(var_49_0, var_4.ApplyDefaultResUI(var_49_2))

			local var_49_3 = arg_41_0.sequenceView

			var_1.Execute(var_49_3, arg_49_0)

			return
		end
	}, function()
		local var_50_0 = arg_41_0

		var_0.SetUpSilentChecker(var_50_0)

		local var_50_1 = arg_41_0
		local var_50_2 = var_0.emit

		NewMainScene = var_2_10003

		var_50_2(var_50_1, var_2_10003.ON_ENTER_DONE)

		arg_41_0.mainCG.blocksRaycasts = true

		if arg_41_2 then
			gcAll = var_0

			var_0()
		end

		return
	end)

	return
end

function var_0_1.SetUpSilentChecker(arg_51_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_51_0 = var_1_10001(var_1_10003)
	local var_51_1 = var_1.GetMainSceneScreenSleepTime(var_51_0)

	Screen = var_1_10002
	arg_51_0.defaultSleepTimeout = var_1_10002.sleepTimeout
	Screen = var_2
	var_2.sleepTimeout = var_51_1
	SettingsMainScenePanel = var_2

	if var_2.IsEnableStandbyMode() then
		local var_51_2 = arg_51_0.silentChecker

		var_2.SetUp(var_51_2)
	end

	return
end

function var_0_1.RevertSleepTimeout(arg_52_0)
	if arg_52_0.defaultSleepTimeout then
		Screen = var_1

		if var_1.sleepTimeout ~= arg_52_0.defaultSleepTimeout then
			Screen = var_1
			var_1.sleepTimeout = arg_52_0.defaultSleepTimeout
		end
	end

	arg_52_0.defaultSleepTimeout = nil

	return
end

function var_0_1.FoldPanels(arg_53_0, arg_53_1)
	if not arg_53_0.theme then
		return
	end

	arg_53_0.foldFlag = arg_53_1

	local var_53_0 = arg_53_0.theme

	var_2.OnFoldPanels(var_53_0, arg_53_1)

	local var_53_1 = arg_53_0.paintingView

	var_2.Fold(var_53_1, arg_53_1, 0.5)

	pg = var_2

	local var_53_2 = var_2.playerResUI

	var_2.Fold(var_53_2, arg_53_1, 0.5)
	arg_53_0:SetEffectPanelVisible(not arg_53_1)

	return
end

function var_0_1.HidePanel(arg_54_0, arg_54_1)
	if not arg_54_0.theme then
		return
	end

	if arg_54_0.foldFlag == arg_54_1 then
		return
	end

	arg_54_0.foldFlag = arg_54_1

	local var_54_0 = arg_54_0.theme

	var_2.OnFoldPanels(var_54_0, arg_54_1)

	if arg_54_0._asmrTurnning then
		if arg_54_0.foldFlag == true then
			pg = var_2

			local var_54_1 = var_2.playerResUI

			var_2.Fold(var_54_1, arg_54_1, 0.5)
		end
	else
		pg = var_2

		local var_54_2 = var_2.playerResUI

		var_2.Fold(var_54_2, arg_54_1, 0.5)
	end

	if not arg_54_1 and arg_54_0._asmrTurnning then
		arg_54_0:SetEffectPanelVisible(false)
	else
		arg_54_0:SetEffectPanelVisible(not arg_54_1)
	end

	return
end

function var_0_1.AsmrTurning(arg_55_0, arg_55_1)
	arg_55_0._asmrTurnning = arg_55_1

	local var_55_0 = arg_55_0.paintingView

	var_2.OnAsmrTurnning(var_55_0, arg_55_1)

	local var_55_1 = arg_55_0.theme

	var_2.OnAsmrTurnning(var_55_1, arg_55_1)

	local var_55_2 = arg_55_0.silentChecker

	var_2.SetSilentRun(var_55_2, not arg_55_1)

	if not arg_55_0._asmrTurnning then
		arg_55_0:SetUpSilentChecker()

		pg = var_2

		local var_55_3 = var_2.BgmMgr.GetInstance()

		var_2.ContinuePlay(var_55_3)
	else
		pg = var_2

		local var_55_4 = var_2.BgmMgr.GetInstance()

		var_2.StopPlay(var_55_4)
	end

	return
end

function var_0_1.SwitchToNextShip(arg_56_0)
	local var_56_0 = arg_56_0.paintingView

	if not var_1.IsLoading(var_56_0) then
		var_56_0 = arg_56_0.bgView

		if var_1.IsLoading(var_56_0) or not arg_56_0.theme then
			return
		end

		getProxy = var_1
		PlayerProxy = var_56_0

		local var_56_1 = var_1(var_56_0)
		local var_56_2 = var_1.getRawData(var_56_1)
		local var_56_3 = var_1.GetNextFlagShip(var_56_2)
		local var_56_4 = arg_56_0.bgView.ship

		if var_2.getSkinId(var_56_4) ~= var_56_3:getSkinId() or arg_56_0.bgView.ship.id ~= var_56_3.id then
			local var_56_5 = arg_56_0.bgView

			var_2.Refresh(var_56_5, var_56_3)
			arg_56_0:PlayBgm(var_56_3)

			local var_56_6 = arg_56_0.paintingView
			local var_56_7 = var_2.Refresh
			local var_56_8 = var_56_3
			local var_56_9 = arg_56_0.theme

			var_56_7(var_56_6, var_56_8, var_6.GetPaintingOffset(var_56_9, var_56_3))

			local var_56_10 = arg_56_0.effectView

			var_2.Refresh(var_56_10, var_56_3)

			local var_56_11 = arg_56_0.theme

			var_2.OnSwitchToNextShip(var_56_11, var_56_3)
		end

		return
	end
end

function var_0_1.UpdateFlagShip(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_0.paintingView

	if not var_3.IsLoading(var_57_0) then
		local var_57_1 = arg_57_0.bgView

		if var_3.IsLoading(var_57_1) or not arg_57_0.theme then
			return
		end

		local var_57_2 = arg_57_2.callback
		local var_57_3 = arg_57_0.bgView

		var_4.Refresh(var_57_3, arg_57_1)
		arg_57_0:PlayBgm(arg_57_1)

		local var_57_4 = arg_57_0.paintingView

		var_4.SetOnceLoadedCall(var_57_4, var_57_2)

		local var_57_5 = arg_57_0.paintingView
		local var_57_6 = var_4.Refresh
		local var_57_7 = arg_57_1
		local var_57_8 = arg_57_0.theme

		var_57_6(var_57_5, var_57_7, var_8.GetPaintingOffset(var_57_8, arg_57_1))

		local var_57_9 = arg_57_0.effectView

		var_4.Refresh(var_57_9, arg_57_1)

		local var_57_10 = arg_57_0.theme

		var_4.OnSwitchToNextShip(var_57_10, arg_57_1)

		return
	end
end

function var_0_1.CheckDebugBattleLoop(arg_58_0)
	InDebugBattleLoop = var_1_10001

	if not var_1_10001 then
		return false
	end

	InDebugBattleLoop = var_1_10001

	local var_58_0

	if #var_1_10001.tempList == 0 then
		var_58_0 = #var_1_10001.loopStages

		if 0 < var_58_0 then
			table = var_58_0
			var_58_0 = var_58_0.remove(var_1_10001.loopStages, 1)

			for iter_58_0 = 1, var_1_10001.loopCount do
				table = var_1_10007

				var_1_10007.insert(var_1_10001.tempList, var_58_0)
			end
		else
			var_58_0 = nil
			pg = InDebugBattleLoop

			local var_58_1 = var_58_0.TipsMgr.GetInstance()

			var_58_0.ShowTips(var_58_1, "finish")

			return false
		end
	end

	table = var_58_0

	local var_58_2 = var_58_0.remove(var_1_10001.tempList, 1)

	print = var_1_10003
	string = var_5

	var_1_10003(var_5.format("【正在执行关卡%s的第%d次战斗循环】", var_58_2, var_1_10001.loopCount - #var_1_10001.tempList))

	local var_58_3 = arg_58_0
	local var_58_4 = arg_58_0.emit

	NewMainMediator = iter_58_0

	var_58_4(var_58_3, iter_58_0.DEBUG_BATTLE_LOOP, var_58_2)

	return true
end

function var_0_1.PlayChangeSkinActionOut(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.paintingView

	var_2.PlayChangeSkinActionOut(var_59_0, arg_59_1)

	return
end

function var_0_1.PlayChangeSkinActionIn(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.paintingView

	var_2.PlayChangeSkinActionIn(var_60_0, arg_60_1)

	return
end

function var_0_1.CheckAndReplayBgm(arg_61_0)
	local var_61_0 = arg_61_0:GetFlagShip()
	local var_61_1 = arg_61_0.theme

	var_2.Refresh(var_61_1, var_61_0)
	arg_61_0:PlayBgm(var_61_0)

	return
end

function var_0_1.SetEffectPanelVisible(arg_62_0, arg_62_1)
	if arg_62_0.theme then
		local var_62_0 = arg_62_0.theme

		var_2.SetEffectPanelVisible(var_62_0, arg_62_1)
	end

	return
end

function var_0_1.OnVisible(arg_63_0)
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

function var_0_1.Refresh(arg_64_0)
	local var_64_0 = arg_64_0.mainCG

	var_64_0.blocksRaycasts = false
	seriesAsync = var_64_0

	var_64_0({
		function(arg_65_0)
			local var_65_0 = arg_64_0

			if var_1.CheckDebugBattleLoop(var_65_0) then
				return
			else
				arg_65_0()
			end

			return
		end,
		function(arg_66_0)
			local var_66_0 = arg_64_0.awakeSequenceView

			var_1.Execute(var_66_0, arg_66_0)

			return
		end,
		function(arg_67_0)
			arg_64_0.isInit = true

			local var_67_0 = arg_64_0
			local var_67_1 = var_1.ShowOrHideResUI
			local var_67_2 = arg_64_0.theme

			var_67_1(var_67_0, var_4.ApplyDefaultResUI(var_67_2))

			local var_67_3 = arg_64_0
			local var_67_4 = var_1.GetFlagShip(var_67_3)
			local var_67_5 = arg_64_0.bgView

			var_2.Refresh(var_67_5, var_67_4)

			local var_67_6 = arg_64_0.paintingView
			local var_67_7 = var_2.Refresh
			local var_67_8 = var_67_4
			local var_67_9 = arg_64_0.theme

			var_67_7(var_67_6, var_67_8, var_6.GetPaintingOffset(var_67_9, var_67_4))

			local var_67_10 = arg_64_0.effectView

			var_2.Refresh(var_67_10, var_67_4)

			local var_67_11 = arg_64_0.theme

			var_2.Refresh(var_67_11, var_67_4)

			local var_67_12 = arg_64_0

			var_2.PlayBgm(var_67_12, var_67_4)
			arg_67_0()

			return
		end,
		function(arg_68_0)
			local var_68_0 = arg_64_0.sequenceView

			var_1.Execute(var_68_0, arg_68_0)

			return
		end
	}, function()
		local var_69_0 = arg_64_0

		var_0.SetUpSilentChecker(var_69_0)

		local var_69_1 = arg_64_0
		local var_69_2 = var_0.emit

		NewMainScene = var_2_10003

		var_69_2(var_69_1, var_2_10003.ON_ENTER_DONE)

		arg_64_0.mainCG.blocksRaycasts = true

		return
	end)

	return
end

function var_0_1.OnDisVisible(arg_70_0)
	arg_70_0:FoldPanels(false)

	local var_70_0 = arg_70_0.paintingView

	var_1.Disable(var_70_0)

	local var_70_1 = arg_70_0.bgView

	var_1.Disable(var_70_1)

	local var_70_2 = arg_70_0.sequenceView

	var_1.Disable(var_70_2)

	local var_70_3 = arg_70_0.awakeSequenceView

	var_1.Disable(var_70_3)

	if arg_70_0.theme then
		local var_70_4 = arg_70_0.theme

		var_1.Disable(var_70_4)
	end

	local var_70_5 = arg_70_0.buffDescPage

	var_1.Disable(var_70_5)

	local var_70_6 = arg_70_0.silentChecker

	var_1.Disable(var_70_6)

	if arg_70_0.silentView then
		local var_70_7 = arg_70_0.silentView

		if var_1.isShowing(var_70_7) then
			arg_70_0:ExitSilentView()
		end
	end

	local var_70_8 = arg_70_0.calibrationPage

	var_1.Destroy(var_70_8)

	local var_70_9 = arg_70_0.calibrationPage

	var_1.Reset(var_70_9)

	local var_70_10 = arg_70_0.skinExperienceDisplayPage

	var_1.Destroy(var_70_10)

	local var_70_11 = arg_70_0.skinExperienceDisplayPage

	var_1.Reset(var_70_11)

	local var_70_12 = arg_70_0.liveAreaPage

	var_1.Destroy(var_70_12)

	local var_70_13 = arg_70_0.liveAreaPage

	var_1.Reset(var_70_13)

	arg_70_0.isInit = false

	arg_70_0:RevertSleepTimeout()
	arg_70_0:RevertAsmrShip()

	return
end

function var_0_1.UnloadTheme(arg_71_0)
	if arg_71_0.theme then
		local var_71_0 = arg_71_0.theme

		var_1.Destroy(var_71_0)

		local var_71_1 = arg_71_0.theme

		var_1.Reset(var_71_1)

		arg_71_0.theme = nil
	end

	return
end

function var_0_1.ExitCalibrationView(arg_72_0)
	if arg_72_0.calibrationPage then
		local var_72_0 = arg_72_0.calibrationPage

		if var_1.GetLoaded(var_72_0) then
			local var_72_1 = arg_72_0.calibrationPage

			if var_1.isShowing(var_72_1) then
				triggerButton = var_1

				var_1(arg_72_0.calibrationPage.backBtn)
			end
		end
	end

	return
end

function var_0_1.ExitSilentView(arg_73_0)
	if arg_73_0.silentView then
		local var_73_0 = arg_73_0.silentView

		if var_1.isShowing(var_73_0) then
			arg_73_0:FoldPanels(false)

			local var_73_1 = arg_73_0.silentView

			var_1.Destroy(var_73_1)

			local var_73_2 = arg_73_0.silentView

			var_1.Reset(var_73_2)
		end
	end

	return
end

function var_0_1.GameLogout(arg_74_0)
	arg_74_0:ExitCalibrationView()
	arg_74_0:ExitSilentView()

	return
end

function var_0_1.OnPlayerUpdated(arg_75_0)
	if arg_75_0.theme then
		local var_75_0 = arg_75_0.theme

		if var_1.GetLoaded(var_75_0) then
			local var_75_1 = arg_75_0.theme

			var_1.OnPlayerUpdated(var_75_1)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_76_0)
	pg = var_1_10001

	local var_76_0 = var_1_10001.CriMgr.GetInstance()
	local var_76_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_76_1(var_76_0, var_1_10004)

	if arg_76_0.silentView then
		local var_76_2 = arg_76_0.silentView

		if var_1.isShowing(var_76_2) then
			arg_76_0:ExitSilentView()

			return
		end
	end

	if arg_76_0.liveAreaPage then
		local var_76_3 = arg_76_0.liveAreaPage

		if var_1.GetLoaded(var_76_3) then
			local var_76_4 = arg_76_0.liveAreaPage

			if var_1.isShowing(var_76_4) then
				local var_76_5 = arg_76_0.liveAreaPage

				var_1.Hide(var_76_5)

				return
			end
		end
	end

	if arg_76_0.calibrationPage then
		local var_76_6 = arg_76_0.calibrationPage

		if var_1.GetLoaded(var_76_6) then
			local var_76_7 = arg_76_0.calibrationPage

			if var_1.isShowing(var_76_7) then
				triggerButton = var_1

				var_1(arg_76_0.calibrationPage._parentTf)

				return
			end
		end
	end

	pg = var_1

	local var_76_8 = var_1.SdkMgr.GetInstance()

	var_1.OnAndoridBackPress(var_76_8)

	pg = var_1

	local var_76_9 = var_1.PushNotificationMgr.GetInstance()

	var_1.PushAll(var_76_9)

	return
end

function var_0_1.willExit(arg_77_0)
	local var_77_0 = arg_77_0.bgView

	var_1.Dispose(var_77_0)

	arg_77_0.bgView = nil

	arg_77_0:UnloadTheme()

	if arg_77_0.calibrationPage then
		local var_77_1 = arg_77_0.calibrationPage

		var_1.Destroy(var_77_1)

		arg_77_0.calibrationPage = nil
	end

	if arg_77_0.silentView then
		local var_77_2 = arg_77_0.silentView

		var_1.Destroy(var_77_2)

		arg_77_0.silentView = nil
	end

	local var_77_3 = arg_77_0.paintingView

	var_1.Dispose(var_77_3)

	arg_77_0.paintingView = nil

	local var_77_4 = arg_77_0.liveAreaPage

	var_1.Destroy(var_77_4)

	arg_77_0.liveAreaPage = nil

	local var_77_5 = arg_77_0.sequenceView

	var_1.Dispose(var_77_5)

	arg_77_0.sequenceView = nil

	local var_77_6 = arg_77_0.awakeSequenceView

	var_1.Dispose(var_77_6)

	arg_77_0.awakeSequenceView = nil

	local var_77_7 = arg_77_0.effectView

	var_1.Dispose(var_77_7)

	arg_77_0.effectView = nil
	pg = var_1

	local var_77_8 = var_1.m02

	var_1.removeMediator(var_77_8, arg_77_0.subMediator.__cname)

	arg_77_0.subMediator = nil

	local var_77_9 = arg_77_0.buffDescPage

	var_1.Destroy(var_77_9)

	arg_77_0.buffDescPage = nil

	local var_77_10 = arg_77_0.silentChecker

	var_1.Dispose(var_77_10)

	arg_77_0.silentChecker = nil

	local var_77_11 = arg_77_0.skinExperienceDisplayPage

	var_1.Destroy(var_77_11)

	arg_77_0.skinExperienceDisplayPage = nil

	arg_77_0:RevertSleepTimeout()

	return
end

return var_0_1
