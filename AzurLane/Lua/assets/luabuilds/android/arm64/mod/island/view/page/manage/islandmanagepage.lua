class = var_0_10000

local var_0_0 = "IslandManagePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandManageUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "top/title/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_manage_title"))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "window/view/content")
	local var_2_4 = var_1.Find(var_2_3, "tpl")

	setText = var_2_2

	local var_2_5 = var_2_4:Find("bg/event/Text")

	i18n = var_6

	var_2_2(var_2_5, var_6("island_manage_sp_event"))

	setText = var_2_2

	local var_2_6 = var_2_4:Find("bg/status/prepare/Text")

	i18n = var_6

	var_2_2(var_2_6, var_6("island_manage_no_work"))

	setText = var_2_2

	local var_2_7 = var_2_4:Find("bg/status/end/Text")

	i18n = var_6

	var_2_2(var_2_7, var_6("island_manage_end_work"))

	setText = var_2_2

	local var_2_8 = var_2_4:Find("btns/opening/Text")

	i18n = var_6

	var_2_2(var_2_8, var_6("island_manage_view"))

	setText = var_2_2

	local var_2_9 = var_2_4:Find("btns/close/Text")

	i18n = var_6

	var_2_2(var_2_9, var_6("island_manage_result"))

	UIItemList = var_2_2
	arg_2_0.uiList = var_2_2.New(var_1, var_2_4)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	local var_3_4 = arg_3_0.uiList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			onButton = var_3

			local var_5_0 = arg_3_0
			local var_5_1 = arg_5_2
			local var_5_2 = arg_5_2.Find(var_5_1, "btns/prepare")

			local function var_5_3()
				local var_6_0 = arg_3_0
				local var_6_1 = var_0.OpenPage

				IslandRestaurantPage = var_3_10003

				var_6_1(var_6_0, var_3_10003, arg_3_0.restIds[arg_5_1 + 1])

				return
			end

			SFX_PANEL = var_5_1

			var_3(var_5_0, var_5_2, var_5_3, var_5_1)

			onButton = var_3

			local var_5_4 = arg_3_0
			local var_5_5 = arg_5_2
			local var_5_6 = arg_5_2.Find(var_5_5, "btns/opening")

			local function var_5_7()
				local var_7_0 = arg_3_0
				local var_7_1 = var_0.OpenPage

				IslandRestaurantPage = var_3_10003

				var_7_1(var_7_0, var_3_10003, arg_3_0.restIds[arg_5_1 + 1])

				return
			end

			SFX_PANEL = var_5_5

			var_3(var_5_4, var_5_6, var_5_7, var_5_5)

			onButton = var_3

			local var_5_8 = arg_3_0
			local var_5_9 = arg_5_2
			local var_5_10 = arg_5_2.Find(var_5_9, "btns/close")

			local function var_5_11()
				local var_8_0 = arg_3_0
				local var_8_1 = var_0.OpenPage

				IslandRestaurantPage = var_3_10003

				var_8_1(var_8_0, var_3_10003, arg_3_0.restIds[arg_5_1 + 1])

				return
			end

			SFX_PANEL = var_5_9

			var_3(var_5_8, var_5_10, var_5_11, var_5_9)
		else
			UIItemList = var_3

			if arg_5_0 == var_3.EventUpdate then
				local var_5_12 = arg_3_0

				var_3.UpdataRest(var_5_12, arg_5_1, arg_5_2)
			end
		end

		return
	end)

	pg = var_1
	arg_3_0.restIds = var_1.island_manage_restaurant.all

	return
end

function var_0_1.AddListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.AddListener

	IslandManageAgecny = var_1_10004

	var_9_1(var_9_0, var_1_10004.UPDATE_RESTAURANT, arg_9_0.Flush)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.AddListener

	IslandManageAgecny = var_4

	var_9_3(var_9_2, var_4.ADD_RESTAURANT, arg_9_0.Flush)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.AddListener

	IslandManageAgecny = var_4

	var_9_5(var_9_4, var_4.ON_DAILY_REFRESH, arg_9_0.Flush)

	return
end

function var_0_1.RemoveListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.RemoveListener

	IslandManageAgecny = var_1_10004

	var_10_1(var_10_0, var_1_10004.UPDATE_RESTAURANT, arg_10_0.Flush)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.RemoveListener

	IslandManageAgecny = var_4

	var_10_3(var_10_2, var_4.ADD_RESTAURANT, arg_10_0.Flush)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.RemoveListener

	IslandManageAgecny = var_4

	var_10_5(var_10_4, var_4.ON_DAILY_REFRESH, arg_10_0.Flush)

	return
end

function var_0_1.OnShow(arg_11_0)
	arg_11_0:BlurPanel()
	arg_11_0:Flush()

	local var_11_0 = {}
	local var_11_1 = arg_11_0.uiList

	var_2.eachActive(var_11_1, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1
		local var_12_1 = arg_12_1.GetComponent

		typeof = var_2_10005
		CanvasGroup = var_2_10007

		local var_12_2 = var_12_1(var_12_0, var_2_10005(var_2_10007))

		var_12_2.alpha = 0
		table = var_12_2

		var_12_2.insert(var_11_0, function(arg_13_0)
			local var_13_0 = arg_12_1
			local var_13_1 = var_1.GetComponent

			typeof = var_3_10004
			Animation = var_3_10006

			local var_13_2 = var_13_1(var_13_0, var_3_10004(var_3_10006))

			var_1.Play(var_13_2)

			local var_13_3 = arg_11_0
			local var_13_4 = var_1.managedTween

			LeanTween = var_4

			var_13_4(var_13_3, var_4.delayedCall, function()
				arg_13_0()

				return
			end, 0.05, nil)

			return
		end)

		return
	end)

	seriesAsync = var_2

	var_2(var_11_0)

	return
end

function var_0_1.OnEnable(arg_15_0)
	arg_15_0:Flush()

	return
end

function var_0_1.Flush(arg_16_0)
	local var_16_0 = arg_16_0

	arg_16_0.StopTimer(var_16_0)

	getProxy = var_1
	IslandProxy = var_16_0

	local var_16_1 = var_1(var_16_0)
	local var_16_2 = var_1.GetIsland(var_16_1)
	local var_16_3 = var_1.GetManageAgency(var_16_2)

	arg_16_0.rests = var_1.GetRestaurants(var_16_3)
	table = var_1

	local var_16_4 = var_1.sort
	local var_16_5 = arg_16_0.restIds

	CompareFuncs = var_1_10004

	var_16_4(var_16_5, var_1_10004({
		function(arg_17_0)
			return arg_16_0.rests[arg_17_0] and 0 or 1
		end,
		function(arg_18_0)
			return arg_18_0
		end
	}))

	local var_16_6 = arg_16_0.uiList

	var_1.align(var_16_6, #arg_16_0.restIds)
	arg_16_0:StartTimer()
	arg_16_0:UpdateTime()

	return
end

function var_0_1.UpdataRest(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.restIds[arg_19_1 + 1]

	pg = var_4

	local var_19_1 = var_4.island_manage_restaurant[var_19_0]

	arg_19_2.name = var_19_0
	LoadImageSpriteAsync = var_1_10005

	var_1_10005("island/islandrestaurant/" .. var_19_1.icon, arg_19_2:Find("bg"))

	setText = var_1_10005

	var_1_10005(arg_19_2:Find("bg/name/Text"), var_19_1.name)

	setText = var_1_10005

	var_1_10005(arg_19_2:Find("bg/name_en/Text"), var_19_1.name_en)

	local var_19_2 = not arg_19_0.rests[var_19_0]

	setActive = var_7

	var_7(arg_19_2:Find("bg/rank"), not var_19_2)

	setActive = var_7

	var_7(arg_19_2:Find("bg/lock"), var_19_2)

	setActive = var_7

	var_7(arg_19_2:Find("bg/event"), not var_19_2)

	setActive = var_7

	var_7(arg_19_2:Find("bg/status"), not var_19_2)

	setActive = var_7

	var_7(arg_19_2:Find("btns"), not var_19_2)

	if var_5 then
		local var_19_3 = var_5
		local var_19_4 = var_5.getConfig(var_19_3, "opening_number")
		local var_19_5 = var_5
		local var_19_6 = var_5.GetRemainCnt(var_19_5)

		setText = var_19_3

		local var_19_7 = arg_19_2:Find("btns/prepare/Text")

		string = var_12

		local var_19_8 = var_12.format
		local var_19_9 = "%s(%d/%d)"

		i18n = var_1_10015

		var_19_3(var_19_7, var_19_8(var_19_9, var_1_10015("island_manage_prepare"), var_19_6, var_19_4))

		setText = var_19_3

		local var_19_10 = arg_19_2:Find("btns/end/Text")

		string = var_12

		local var_19_11 = var_12.format
		local var_19_12 = "%s(%d/%d)"

		i18n = var_15

		var_19_3(var_19_10, var_19_11(var_19_12, var_15("island_manage_daily_cnt_tip"), var_19_6, var_19_4))

		LoadImageSpriteAsync = var_19_3

		var_19_3("island/islandrestaurant/" .. var_5:GetRankIcon(), arg_19_2:Find("bg/rank"))

		local var_19_13 = var_5:GetEventInfo()

		setActive = var_19_5

		var_19_5(arg_19_2:Find("bg/event"), var_19_13 ~= 0)
		arg_19_0:UpdataStatusInfo(arg_19_2, var_5)
	end

	return
end

function var_0_1.UpdataStatusInfo(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2
	local var_20_1 = arg_20_2.GetStatus(var_20_0)

	IslandRestaurant = var_1_10004

	local var_20_2

	if var_20_1 ~= var_1_10004.STATUS.OPENING then
		IslandRestaurant = var_4

		if var_20_1 ~= var_4.STATUS.CLOSE then
			var_20_2 = false

			goto label_20_0
		end
	end

	var_20_2 = true

	::label_20_0::

	setActive = var_20_0

	local var_20_3 = arg_20_1:Find("bg/status/prepare")

	IslandRestaurant = var_1_10008

	var_20_0(var_20_3, var_20_1 == var_1_10008.STATUS.PREPARE)

	setActive = var_20_0

	var_20_0(arg_20_1:Find("bg/status/opening"), var_20_2)

	setActive = var_20_0

	local var_20_4 = arg_20_1:Find("bg/status/end")

	IslandRestaurant = var_8

	var_20_0(var_20_4, var_20_1 == var_8.STATUS.END)

	IslandRestaurant = var_20_0

	local var_20_5

	if var_20_1 == var_20_0.STATUS.OPENING then
		pg = var_20_5
		var_20_5 = var_20_5.TimeMgr.GetInstance()

		local var_20_6 = arg_20_2:GetEndTime() - var_20_5:GetServerTime()

		setText = var_7

		var_7(arg_20_1:Find("bg/status/opening/Text"), var_20_5:DescCDTime(var_20_6))
	else
		IslandRestaurant = var_20_5

		if var_20_1 == var_20_5.STATUS.CLOSE then
			setText = var_20_5

			var_20_5(arg_20_1:Find("bg/status/opening/Text"), "00:00:00")
		end
	end

	eachChild = var_20_5

	var_20_5(arg_20_1:Find("btns"), function(arg_21_0)
		setActive = var_2_10001

		var_2_10001(arg_21_0, arg_21_0.name == var_20_1)

		return
	end)

	return
end

function var_0_1.UpdateTime(arg_22_0)
	local var_22_0 = arg_22_0.uiList

	var_1.eachActive(var_22_0, function(arg_23_0, arg_23_1)
		if arg_22_0.rests[arg_22_0.restIds[arg_23_0 + 1]] then
			local var_23_0 = arg_22_0

			var_3.UpdataStatusInfo(var_23_0, arg_23_1, var_2)
		end

		return
	end)

	return
end

function var_0_1.StartTimer(arg_24_0)
	Timer = var_1_10001
	arg_24_0.timer = var_1_10001.New(function()
		local var_25_0 = arg_24_0

		var_0.UpdateTime(var_25_0)

		return
	end, 1, -1)

	local var_24_0 = arg_24_0.timer

	var_1.Start(var_24_0)

	return
end

function var_0_1.StopTimer(arg_26_0)
	if arg_26_0.timer ~= nil then
		local var_26_0 = arg_26_0.timer

		var_1.Stop(var_26_0)

		arg_26_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_27_0)
	arg_27_0:StopTimer()
	arg_27_0:UnBlurPanel()

	return
end

function var_0_1.OnDisable(arg_28_0)
	arg_28_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:OnHide()

	return
end

return var_0_1
