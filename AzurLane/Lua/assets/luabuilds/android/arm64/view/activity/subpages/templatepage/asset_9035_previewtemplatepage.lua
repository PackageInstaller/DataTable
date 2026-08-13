class = var_0_10000

local var_0_0 = "PreviewTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnList = var_1.Find(var_1_1, "btn_list")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0:initBtn()

	eachChild = var_1

	var_1(arg_2_0.btnList, function(arg_3_0)
		arg_2_0.btnFuncList[arg_3_0.name](arg_3_0)

		return
	end)

	return
end

function var_0_1.initBtn(arg_4_0)
	local function var_4_0(arg_5_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_5_0 = var_2_10001(var_2_10003)

		if not var_1.getActivityById(var_5_0, arg_5_0) or var_1 and var_1:isEnd() then
			return true
		else
			return false
		end

		return
	end

	local var_4_1 = arg_4_0.activity
	local var_4_2 = var_2.getConfig(var_4_1, "config_client")

	arg_4_0.btnFuncList = {
		task = function(arg_6_0)
			onButton = var_2_10001

			var_2_10001(arg_4_0, arg_6_0, function()
				if var_4_2.taskLinkActID and var_4_0(var_4_2.taskLinkActID) then
					pg = var_0

					local var_7_0 = var_0.TipsMgr.GetInstance()
					local var_7_1 = var_0.ShowTips

					i18n = var_3_10003

					var_7_1(var_7_0, var_3_10003("common_activity_end"))

					return
				end

				local var_7_2 = arg_4_0
				local var_7_3 = var_0.emit

				ActivityMediator = var_3_10003

				local var_7_4 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				var_7_3(var_7_2, var_7_4, var_3_10004.TASK, {
					page = "activity"
				})

				return
			end)

			return
		end,
		shop = function(arg_8_0)
			onButton = var_2_10001

			var_2_10001(arg_4_0, arg_8_0, function()
				if var_4_2.shopLinkActID then
					getProxy = var_9_0
					ActivityProxy = var_3_10002
					var_3_10002 = var_9_0(var_3_10002)

					local var_9_0

					if not var_9_0.getActivitiesById(var_3_10002, var_4_2.shopLinkActID) then
						underscore = var_9_0
						var_9_0 = var_9_0.detect
						getProxy = var_3_10002
						ActivityProxy = var_3_10004
						var_3_10004 = var_3_10002(var_3_10004)

						local var_9_1 = var_2.getActivitiesByType

						ActivityConst = var_3_10005
						var_9_0 = var_9_0(var_9_1(var_3_10004, var_3_10005.ACTIVITY_TYPE_SHOP), function(arg_10_0)
							return not arg_10_0:isEnd()
						end)
					end

					if not var_9_0 or var_9_0:isEnd() then
						pg = var_3_10001

						local var_9_2 = var_3_10001.TipsMgr.GetInstance()
						local var_9_3 = var_1.ShowTips

						i18n = var_3_10004

						var_9_3(var_9_2, var_3_10004("common_activity_end"))

						return
					end

					local var_9_4 = arg_4_0
					local var_9_5 = var_1.emit

					ActivityMediator = var_3_10004

					local var_9_6 = var_3_10004.GO_SHOPS_LAYER
					local var_9_7 = {}

					NewShopsScene = var_3_10006
					var_9_7.warp = var_3_10006.TYPE_ACTIVITY
					var_9_7.actId = var_9_0.id

					var_9_5(var_9_4, var_9_6, var_9_7)

					return
				end
			end)

			return
		end,
		build = function(arg_11_0)
			onButton = var_2_10001

			var_2_10001(arg_4_0, arg_11_0, function()
				if var_4_2.buildLinkActID and var_4_0(var_4_2.buildLinkActID) then
					pg = var_0

					local var_12_0 = var_0.TipsMgr.GetInstance()
					local var_12_1 = var_0.ShowTips

					i18n = var_3_10003

					var_12_1(var_12_0, var_3_10003("common_activity_end"))

					return
				end

				local var_12_2 = arg_4_0
				local var_12_3 = var_0.emit

				ActivityMediator = var_3_10003

				local var_12_4 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				local var_12_5 = var_3_10004.GETBOAT
				local var_12_6 = {}

				BuildShipScene = var_3_10006
				var_12_6.page = var_3_10006.PAGE_BUILD
				BuildShipScene = var_6
				var_12_6.projectName = var_6.PROJECTS.ACTIVITY

				var_12_3(var_12_2, var_12_4, var_12_5, var_12_6)

				return
			end)

			return
		end,
		fight = function(arg_13_0)
			onButton = var_2_10001

			var_2_10001(arg_4_0, arg_13_0, function()
				if var_4_2.fightLinkActID and var_4_0(var_0) then
					pg = var_1

					local var_14_0 = var_1.TipsMgr.GetInstance()
					local var_14_1 = var_1.ShowTips

					i18n = var_3_10004

					var_14_1(var_14_0, var_3_10004("common_activity_end"))

					return
				end

				if var_0 then
					local var_14_2 = arg_4_0
					local var_14_3 = var_1.emit

					ActivityMediator = var_3_10004

					var_14_3(var_14_2, var_3_10004.SKIP_ACTIVITY_MAP, var_0)
				else
					local var_14_4 = arg_4_0
					local var_14_5 = var_1.emit

					ActivityMediator = var_3_10004

					var_14_5(var_14_4, var_3_10004.BATTLE_OPERA)
				end

				return
			end)

			return
		end,
		lottery = function(arg_15_0)
			onButton = var_2_10001

			var_2_10001(arg_4_0, arg_15_0, function()
				if var_4_2.lotteryLinkActID and var_4_0(var_4_2.lotteryLinkActID) then
					pg = var_0

					local var_16_0 = var_0.TipsMgr.GetInstance()
					local var_16_1 = var_0.ShowTips

					i18n = var_3_10003

					var_16_1(var_16_0, var_3_10003("common_activity_end"))

					return
				end

				local var_16_2 = arg_4_0
				local var_16_3 = var_0.emit

				ActivityMediator = var_3_10003

				var_16_3(var_16_2, var_3_10003.GO_LOTTERY)

				return
			end)

			return
		end,
		memory = function(arg_17_0)
			return
		end,
		activity = function(arg_18_0)
			return
		end,
		mountain = function(arg_19_0)
			return
		end,
		skinshop = function(arg_20_0)
			onButton = var_2_10001

			var_2_10001(arg_4_0, arg_20_0, function()
				local var_21_0 = arg_4_0
				local var_21_1 = var_0.emit

				ActivityMediator = var_3_10003

				local var_21_2 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				var_21_1(var_21_0, var_21_2, var_3_10004.SKINSHOP)

				return
			end)

			return
		end
	}

	return
end

return var_0_1
