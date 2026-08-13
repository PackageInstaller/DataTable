class = var_0_10000

local var_0_0 = "HolidayVillaIslandMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

function var_0_1.initBtn(arg_1_0)
	var_0_1.super.initBtn(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.Manual = var_1.Find(var_1_0, "Manual")

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

			local var_3_4

			if not var_3_0(var_3_2(var_3_1, var_3_10003.ACTIVITY_TYPE_SHOP), function(arg_4_0)
				return arg_4_0:getConfig("config_id") == 3
			end) or var_0:isEnd() then
				pg = var_3_4

				local var_3_3 = var_3_4.TipsMgr.GetInstance()

				var_3_4 = var_3_4.ShowTips
				i18n = var_3

				var_3_4(var_3_3, var_3("challenge_end_tip"))

				return
			end

			Context = var_3_4

			local var_3_5 = var_3_4.New
			local var_3_6 = {}

			HolidayVillaShopMediator = var_3
			var_3_6.mediator = var_3
			HolidayVillaShopLayer = var_3
			var_3_6.viewComponent = var_3

			local var_3_7 = var_3_5(var_3_6)
			local var_3_8 = arg_1_0
			local var_3_9 = var_2.emit

			ActivityMediator = var_3_10004

			var_3_9(var_3_8, var_3_10004.OPEN_LAYER, var_3_7)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_2_0, var_2_1, var_2_2, var_2_10005)

		return
	end

	local var_1_1 = arg_1_0.btnFuncList

	function var_1_1.activity(arg_5_0)
		onButton = var_2_10001

		local var_5_0 = arg_1_0
		local var_5_1 = arg_5_0

		local function var_5_2()
			getProxy = var_3_10000
			ActivityProxy = var_3_10001

			local var_6_0 = var_3_10000(var_3_10001)
			local var_6_1 = var_0.getActivityById

			ActivityConst = var_3_10002

			if var_6_1(var_6_0, var_3_10002.HOLIDAY_ACT_PRE_ID).data3 >= 5 then
				underscore = var_1

				local var_6_2 = var_1.flatten

				var_3_10003 = var_0

				local var_6_3 = var_6_2(var_0.getConfig(var_3_10003, "config_data"))

				getProxy = var_2
				TaskProxy = var_3_10003

				local var_6_4 = var_2(var_3_10003)

				var_3_10003 = var_6_3[var_0.data3]

				local var_6_5 = var_6_4:getTaskVO(var_3_10003)

				if var_3_10004.getTaskStatus(var_6_5) == 2 then
					local var_6_6 = arg_1_0
					local var_6_7 = var_5.emit

					ActivityMediator = var_3_10007
					var_3_10007 = var_3_10007.EVENT_GO_SCENE
					SCENE = var_3_10008

					var_6_7(var_6_6, var_3_10007, var_3_10008.HOLIDAY_VILLA_MAP)
				else
					local var_6_8 = arg_1_0
					local var_6_9 = var_5.emit

					ActivityMediator = var_3_10007

					local var_6_10 = var_3_10007.SELECT_ACTIVITY

					ActivityConst = var_3_10008

					var_6_9(var_6_8, var_6_10, var_3_10008.HOLIDAY_ACT_PRE_ID)
				end
			else
				local var_6_11 = arg_1_0
				local var_6_12 = var_1.emit

				ActivityMediator = var_3_10003

				local var_6_13 = var_3_10003.SELECT_ACTIVITY

				ActivityConst = var_3_10004

				var_6_12(var_6_11, var_6_13, var_3_10004.HOLIDAY_ACT_PRE_ID)
			end

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_5_0, var_5_1, var_5_2, var_2_10005)

		return
	end

	onButton = var_1_1

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.Manual

	local function var_1_4()
		Context = var_2_10000

		local var_7_0 = var_2_10000.New
		local var_7_1 = {}

		MedalAlbumTemplateMediator = var_2_10002
		var_7_1.mediator = var_2_10002
		HolidayVillaMedalAlbumView = var_2_10002
		var_7_1.viewComponent = var_2_10002

		local var_7_2 = var_7_0(var_7_1)
		local var_7_3 = arg_1_0
		local var_7_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_7_4(var_7_3, var_2_10003.ON_ADD_SUBLAYER, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_1(var_1_2, var_1_3, var_1_4, var_1_10005)

	return
end

return var_0_1
