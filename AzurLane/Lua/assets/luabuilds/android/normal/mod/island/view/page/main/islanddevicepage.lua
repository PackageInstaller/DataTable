class = var_0_10000

local var_0_0 = "IslandDevicePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.SPECIAL_BTN = {
	ship_order = "IslandDeviceShipOrderBtn",
	order = "IslandDeviceOrderBtn"
}

function var_0_1.getUIName(arg_1_0)
	return "IslandDeviceUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.exitBtn = var_1.Find(var_2_0, "panel/exit")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "panel/top/time")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.timeTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.electricTF = var_1.Find(var_2_4, "panel/top/battery/electric")

	local var_2_5 = arg_2_0._tf

	arg_2_0.bannerTF = var_1.Find(var_2_5, "panel/banner")

	local var_2_6 = arg_2_0._tf

	arg_2_0.bannerEmptyTF = var_1.Find(var_2_6, "panel/banner_empty")
	IslandBannerScrollRect = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0.bannerTF
	local var_2_9 = var_2.Find(var_2_8, "mask/content")
	local var_2_10 = arg_2_0.bannerTF

	arg_2_0.scrollSnap = var_2_7(var_2_9, var_3.Find(var_2_10, "dots"))

	local var_2_11 = arg_2_0._tf

	arg_2_0.btnContainer = var_1.Find(var_2_11, "panel/btn_container")
	LocalSystemTimeUtil = var_1
	arg_2_0.systemTimeUtil = var_1.New()

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "close")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.exitBtn

	local function var_3_6()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		IslandMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.PLAY_ROOM_MATCH_STOP)

		local var_5_2 = arg_3_0
		local var_5_3 = var_0.emit

		BaseUI = var_2

		var_5_3(var_5_2, var_2.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_5, var_3_6, var_5)

	setActive = var_1_10001

	local var_3_7 = arg_3_0.exitBtn

	ISLAND_PLAYER_TESTING = var_3_5

	var_1_10001(var_3_7, not var_3_5)
	arg_3_0:InitBtns()
	arg_3_0:InitBanner()

	return
end

function var_0_1.InitBtns(arg_6_0)
	arg_6_0.btns = {}
	pg = var_1

	local var_6_0 = var_1.island_main_btns.get_id_list_by_main_type[2]
	local var_6_1 = {}

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_0) do
		pg = var_1_10008
		var_6_1[var_1_10008.island_main_btns[iter_6_1].btn_name] = iter_6_1
	end

	eachChild = var_3

	var_3(arg_6_0.btnContainer, function(arg_7_0)
		local var_7_0 = arg_7_0.name

		if var_6_1[var_7_0] then
			if var_0_1.SPECIAL_BTN[var_7_0] then
				local var_7_1 = var_0_1.SPECIAL_BTN[var_7_0]

				var_2_10004 = arg_6_0.btns
				_G = var_2_10005
				var_2_10004[var_7_0] = var_2_10005[var_7_1].New(arg_7_0, arg_6_0.event, var_2)
			else
				local var_7_2 = arg_6_0.btns

				IslandDeviceBaseBtn = var_2_10004
				var_7_2[var_7_0] = var_2_10004.New(arg_7_0, arg_6_0.event, var_2)
			end
		end

		return
	end)

	return
end

function var_0_1.InitBanner(arg_8_0)
	arg_8_0.banners = arg_8_0:GetBannerDisplays()

	for iter_8_0 = 0, #var_1 - 1 do
		local var_8_0 = var_1[iter_8_0 + 1]
		local var_8_1 = arg_8_0.scrollSnap
		local var_8_2 = var_7.AddChild(var_8_1)

		if var_8_0.id == 3 then
			LoadImageSpriteAsync = var_8

			var_8("activitybanner/island_temp4", var_8_2)
		else
			LoadImageSpriteAsync = var_8

			var_8("island/islandbanner/" .. var_8_0.pic, var_8_2)
		end

		onButton = var_8

		local var_8_3 = arg_8_0
		local var_8_4 = var_8_2

		local function var_8_5()
			local var_9_0 = arg_8_0

			var_0.BannerSkip(var_9_0, var_8_0)

			return
		end

		SFX_MAIN = var_1_10012

		var_8(var_8_3, var_8_4, var_8_5, var_1_10012)
	end

	local var_8_6 = arg_8_0.scrollSnap

	var_2.SetUp(var_8_6)

	return
end

function var_0_1.OnShow(arg_10_0)
	arg_10_0:AddTimer()
	arg_10_0:Flush()
	arg_10_0:FlushBattery()
	arg_10_0:FlushTime()

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emitCore

	ISLAND_EVT = var_1_10003

	var_10_1(var_10_0, var_1_10003.DEVIEE_STATE_CHANGE, true)

	IslandCameraMgr = var_10_1

	if var_10_1.instance then
		IslandCameraMgr = var_1

		local var_10_2 = var_1.instance
		local var_10_3 = var_1.ActiveVirtualCamera

		IslandConst = var_3

		var_10_3(var_10_2, var_3.FOCUS_CAMERA_NAME)
	end

	return
end

function var_0_1.Flush(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.btns) do
		iter_11_1:Flush()
	end

	local var_11_0 = #arg_11_0:GetBannerDisplays() ~= 0

	setActive = var_3

	var_3(arg_11_0.bannerEmptyTF, not var_11_0)

	setActive = var_3

	var_3(arg_11_0.bannerTF, var_11_0)

	if var_11_0 then
		if #arg_11_0.banners ~= #var_1 then
			local var_11_1 = arg_11_0.scrollSnap

			var_3.Reset(var_11_1)
			arg_11_0:InitBanner()
		else
			local var_11_2 = arg_11_0.scrollSnap

			var_3.Resume(var_11_2)
		end
	end

	return
end

function var_0_1.FlushBattery(arg_12_0)
	SystemInfo = var_1_10001

	local var_12_0

	if var_1_10001.batteryLevel < 0 then
		var_12_0 = 1
	end

	setFillAmount = var_2

	var_2(arg_12_0.electricTF, var_12_0)

	return
end

function var_0_1.FlushTime(arg_13_0)
	local var_13_0 = arg_13_0.systemTimeUtil

	var_1.SetUp(var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		arg_13_0.timeTxt.text = arg_14_0 .. ":" .. arg_14_1

		return
	end)

	return
end

function var_0_1.AddTimer(arg_15_0)
	arg_15_0:RemoveTimer()

	Timer = var_1
	arg_15_0.timer = var_1.New(function()
		local var_16_0 = arg_15_0

		var_0.FlushBattery(var_16_0)

		local var_16_1 = arg_15_0

		var_0.FlushTime(var_16_1)

		return
	end, 60, -1)

	local var_15_0 = arg_15_0.timer

	var_1.Start(var_15_0)

	return
end

function var_0_1.RemoveTimer(arg_17_0)
	if arg_17_0.timer then
		local var_17_0 = arg_17_0.timer

		var_1.Stop(var_17_0)

		arg_17_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_18_0)
	arg_18_0:RemoveTimer()

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.emitCore

	ISLAND_EVT = var_1_10003

	var_18_1(var_18_0, var_1_10003.DEVIEE_STATE_CHANGE, false)

	IslandCameraMgr = var_18_1

	if var_18_1.instance then
		IslandCameraMgr = var_1

		local var_18_2 = var_1.instance
		local var_18_3 = var_1.ActiveVirtualCamera

		IslandConst = var_3

		var_18_3(var_18_2, var_3.FOLLOW_CAMERA_NAME)
	end

	return
end

function var_0_1.OnEnable(arg_19_0)
	arg_19_0:OnShow()

	return
end

function var_0_1.OnDisable(arg_20_0)
	arg_20_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_21_0)
	arg_21_0:OnHide()
	arg_21_0:RemoveTimer()

	local var_21_0 = arg_21_0.systemTimeUtil

	var_1.Dispose(var_21_0)

	arg_21_0.systemTimeUtil = nil

	local var_21_1 = arg_21_0.scrollSnap

	var_1.Dispose(var_21_1)

	arg_21_0.scrollSnap = nil
	pairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.btns) do
		iter_21_1:Dispose()
	end

	arg_21_0.btns = nil

	return
end

function var_0_1.GetBannerDisplays(arg_22_0)
	underscore = var_1_10001
	pg = var_1_10002

	local var_22_0 = var_1_10001(var_1_10002.island_banner.all)
	local var_22_1 = var_1.chain(var_22_0)
	local var_22_2 = var_1.map(var_22_1, function(arg_23_0)
		pg = var_2_10001

		return var_2_10001.island_banner[arg_23_0]
	end)
	local var_22_3 = var_1.select(var_22_2, function(arg_24_0)
		PLATFORM = var_2_10001
		PLATFORM_OPENHARMONY = var_2_10002

		local var_24_0 = var_2_10001 == var_2_10002
		local var_24_1 = arg_24_0.type

		IslandConst = var_2_10003

		local var_24_2 = var_24_1 == var_2_10003.BANNER_TYPE_SURVEY

		if var_24_0 and var_24_2 then
			return false
		end

		pg = var_3

		local var_24_3 = var_3.TimeMgr.GetInstance()

		return var_3.inTime(var_24_3, arg_24_0.time)
	end)

	return var_1.value(var_22_3)
end

function var_0_1.BannerSkip(arg_25_0, arg_25_1)
	pg = var_1_10002

	local var_25_0 = var_1_10002.GameTrackerMgr.GetInstance()
	local var_25_1 = var_2.Record

	GameTrackerBuilder = var_1_10004

	var_25_1(var_25_0, var_1_10004.BuildIslandDeviceBanner(arg_25_1.id))

	local var_25_2 = arg_25_1.type

	IslandConst = var_25_0

	if var_25_2 == var_25_0.BANNER_TYPE_OPEN_URL then
		Application = var_25_2

		var_25_2.OpenURL(arg_25_1.param)
	else
		local var_25_3 = arg_25_1.type

		IslandConst = var_3

		local var_25_4, var_25_6

		if var_25_3 == var_3.BANNER_TYPE_SWITCH_MAP then
			var_25_4 = arg_25_0

			arg_25_0.Hide(var_25_4)

			var_25_4 = arg_25_0

			local var_25_5 = arg_25_0.emit

			IslandBaseMediator = var_25_6
			var_25_6 = var_25_6.SWITCH_MAP
			unpack = var_5

			var_25_5(var_25_4, var_25_6, var_5(arg_25_1.param))
		else
			local var_25_7 = arg_25_1.type

			IslandConst = var_25_4

			local var_25_8

			if var_25_7 == var_25_4.BANNER_TYPE_OPEN_PAGE then
				var_25_8 = arg_25_0

				arg_25_0.Hide(var_25_8)

				var_25_8 = arg_25_0

				local var_25_9 = arg_25_0.emit

				IslandMediator = var_25_6

				var_25_9(var_25_8, var_25_6.OPEN_PAGE, arg_25_1.param[1], arg_25_1.param[2])
			else
				local var_25_10 = arg_25_1.type

				IslandConst = var_25_8

				if var_25_10 == var_25_8.BANNER_TYPE_SURVEY then
					getProxy = var_25_10
					ActivityProxy = var_3

					local var_25_11 = var_25_10(var_3)
					local var_25_12, var_25_13 = var_2.isSurveyOpen(var_25_11)

					getProxy = var_25_6
					ActivityProxy = var_5

					local var_25_14 = var_25_6(var_5)
					local var_25_15 = var_4.isSurveyDone(var_25_14)

					if var_25_12 then
						isFinish = var_25_14

						if not var_25_14 then
							arg_25_0:Hide()

							local var_25_16 = arg_25_0

							var_25_14 = arg_25_0.emit
							IslandMediator = var_1_10007

							var_25_14(var_25_16, var_1_10007.OPEN_PAGE, arg_25_1.param[1], arg_25_1.param[2])

							goto label_25_0
						end
					end

					pg = var_25_14

					local var_25_17 = var_25_14.TipsMgr.GetInstance()
					local var_25_18 = var_5.ShowTips

					i18n = var_1_10007

					var_25_18(var_25_17, var_1_10007("common_activity_not_start"))
				end
			end
		end
	end

	::label_25_0::

	return
end

return var_0_1
