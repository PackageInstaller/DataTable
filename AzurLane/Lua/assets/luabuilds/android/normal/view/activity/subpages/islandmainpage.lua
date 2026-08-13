class = var_0_10000

local var_0_0 = "IslandMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

function var_0_1.initBtn(arg_1_0)
	var_0_1.super.initBtn(arg_1_0)

	function arg_1_0.btnFuncList.shop(arg_2_0)
		onButton = var_2_10001

		local var_2_0 = arg_1_0
		local var_2_1 = arg_2_0

		local function var_2_2()
			underscore = var_3_10000

			local var_3_0 = var_3_10000.detect

			getProxy = var_3_10001
			ActivityProxy = var_3_10002

			local var_3_1 = var_3_10001(var_3_10002)
			local var_3_2 = var_1.getActivitiesByType

			ActivityConst = var_3_10003

			if var_3_0(var_3_2(var_3_1, var_3_10003.ACTIVITY_TYPE_SHOP), function(arg_4_0)
				return arg_4_0:getConfig("config_id") == 3
			end) then
				local var_3_3 = var_0
				local var_3_4

				if var_0.isEnd(var_3_3) then
					pg = var_3_4
					var_3_3 = var_3_4.TipsMgr.GetInstance()
					var_3_4 = var_3_4.ShowTips
					i18n = var_3

					var_3_4(var_3_3, var_3("challenge_end_tip"))

					return
				end

				getProxy = var_3_4
				ActivityProxy = var_3_3

				local var_3_5 = var_3_4(var_3_3)
				local var_3_6 = var_1.getActivityByType

				ActivityConst = var_3

				if var_3_6(var_3_5, var_3.ACTIVITY_TYPE_ISLAND) and not var_1:isEnd() then
					local var_3_7 = arg_1_0
					local var_3_8 = var_2.emit

					ActivityMediator = var_3_10004
					var_3_10004 = var_3_10004.EVENT_GO_SCENE
					SCENE = var_3_10005
					var_3_10005 = var_3_10005.ANNIVERSARY_ISLAND_SEA

					local var_3_9 = {}

					SixthAnniversaryIslandScene = var_3_10007
					var_3_9.wraps = var_3_10007.SHOP

					var_3_8(var_3_7, var_3_10004, var_3_10005, var_3_9)
				else
					local var_3_10 = arg_1_0
					local var_3_11 = var_2.emit

					ActivityMediator = var_3_10004

					local var_3_12 = var_3_10004.OPEN_LAYER

					Context = var_3_10005

					local var_3_13 = var_3_10005.New
					local var_3_14 = {}

					SixthAnniversaryIslandShopMediator = var_3_10007
					var_3_14.mediator = var_3_10007
					SixthAnniversaryIslandShopLayer = var_3_10007
					var_3_14.viewComponent = var_3_10007

					var_3_11(var_3_10, var_3_12, var_3_13(var_3_14))
				end

				return
			end
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_2_0, var_2_1, var_2_2, var_2_10005)

		return
	end

	function arg_1_0.btnFuncList.activity(arg_5_0)
		onButton = var_2_10001

		local var_5_0 = arg_1_0
		local var_5_1 = arg_5_0

		local function var_5_2()
			getProxy = var_3_10000
			ActivityProxy = var_3_10001

			local var_6_0 = var_3_10000(var_3_10001)
			local var_6_1 = var_0.getActivityByType

			ActivityConst = var_3_10002

			if not var_6_1(var_6_0, var_3_10002.ACTIVITY_TYPE_ISLAND) or var_0:isEnd() then
				pg = var_6_0

				local var_6_2 = var_6_0.TipsMgr.GetInstance()
				local var_6_3 = var_1.ShowTips

				i18n = var_3_10003

				var_6_3(var_6_2, var_3_10003("challenge_end_tip"))

				return
			end

			local var_6_4 = arg_1_0
			local var_6_5 = var_1.emit

			ActivityMediator = var_3_10003

			local var_6_6 = var_3_10003.EVENT_GO_SCENE

			SCENE = var_3_10004

			var_6_5(var_6_4, var_6_6, var_3_10004.ANNIVERSARY_ISLAND_SEA)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_5_0, var_5_1, var_5_2, var_2_10005)

		return
	end

	function arg_1_0.btnFuncList.mountain(arg_7_0)
		onButton = var_2_10001

		local var_7_0 = arg_1_0
		local var_7_1 = arg_7_0

		local function var_7_2()
			getProxy = var_3_10000
			ActivityProxy = var_3_10001

			local var_8_0 = var_3_10000(var_3_10001)
			local var_8_1 = var_0.getActivityByType

			ActivityConst = var_3_10002

			if not var_8_1(var_8_0, var_3_10002.ACTIVITY_TYPE_BUILDING_BUFF_2) or var_0:isEnd() then
				pg = var_8_0

				local var_8_2 = var_8_0.TipsMgr.GetInstance()
				local var_8_3 = var_1.ShowTips

				i18n = var_3_10003

				var_8_3(var_8_2, var_3_10003("challenge_end_tip"))

				return
			end

			local var_8_4 = arg_1_0
			local var_8_5 = var_1.emit

			ActivityMediator = var_3_10003

			local var_8_6 = var_3_10003.EVENT_GO_SCENE

			SCENE = var_3_10004

			var_8_5(var_8_4, var_8_6, var_3_10004.ANNIVERSARY_ISLAND_BACKHILL_2023)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_7_0, var_7_1, var_7_2, var_2_10005)

		return
	end

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	local var_9_0 = {
		shop = function()
			underscore = var_2_10000

			local var_10_0 = var_2_10000.detect

			getProxy = var_2_10001
			ActivityProxy = var_2_10002

			local var_10_1 = var_2_10001(var_2_10002)
			local var_10_2 = var_1.getActivitiesByType

			ActivityConst = var_2_10003

			return var_10_0(var_10_2(var_10_1, var_2_10003.ACTIVITY_TYPE_SHOP), function(arg_11_0)
				return arg_11_0:getConfig("config_id") == 3
			end)
		end,
		activity = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10001

			local var_12_0 = var_2_10000(var_2_10001)
			local var_12_1 = var_0.getActivityByType

			ActivityConst = var_2_10002

			return var_12_1(var_12_0, var_2_10002.ACTIVITY_TYPE_ISLAND)
		end,
		mountain = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10001

			local var_13_0 = var_2_10000(var_2_10001)
			local var_13_1 = var_0.getActivityByType

			ActivityConst = var_2_10002

			return var_13_1(var_13_0, var_2_10002.ACTIVITY_TYPE_BUILDING_BUFF_2)
		end
	}

	pairs = var_2

	for iter_9_0, iter_9_1 in var_2(var_9_0) do
		local var_9_1 = iter_9_1()

		setButtonEnabled = var_1_10008

		local var_9_2 = arg_9_0.btnList
		local var_9_3 = var_9.Find(var_9_2, iter_9_0)

		tobool = var_9_2

		var_1_10008(var_9_3, var_9_2(var_9_1 and not var_9_1:isEnd()))
	end

	return
end

return var_0_1
