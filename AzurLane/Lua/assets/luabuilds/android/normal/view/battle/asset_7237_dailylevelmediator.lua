class = var_0_10000

local var_0_0 = "DailyLevelMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_STAGE = "DailyLevelMediator:ON_STAGE"
var_0_1.ON_CHALLENGE = "DailyLevelMediator:ON_CHALLENGE"
var_0_1.ON_RESET_CHALLENGE = "DailyLevelMediator:ON_RESET_CHALLENGE"
var_0_1.ON_CONTINUE_CHALLENGE = "DailyLevelMediator:ON_CONTINUE_CHALLENGE"
var_0_1.ON_CHALLENGE_EDIT_FLEET = "DailyLevelMediator:ON_CHALLENGE_EDIT_FLEET"
var_0_1.ON_REQUEST_CHALLENGE = "DailyLevelMediator:ON_REQUEST_CHALLENGE"
var_0_1.ON_CHALLENGE_FLEET_CLEAR = "DailyLevelMediator.ON_CHALLENGE_FLEET_CLEAR"
var_0_1.ON_CHALLENGE_FLEET_RECOMMEND = "DailyLevelMediator.ON_CHALLENGE_FLEET_RECOMMEND"
var_0_1.ON_QUICK_BATTLE = "DailyLevelMediator:ON_QUICK_BATTLE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	DailyLevelProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = arg_1_0.viewComponent

	var_2.setDailyCounts(var_1_1, var_1_0:getRawData())

	getProxy = var_2
	BayProxy = var_1_1

	local var_1_2 = var_2(var_1_1)

	arg_1_0.ships = var_2.getRawData(var_1_2)

	local var_1_3 = arg_1_0.viewComponent

	var_3.setShips(var_1_3, arg_1_0.ships)

	getProxy = var_3
	PlayerProxy = var_1_3

	local var_1_4 = var_3(var_1_3)
	local var_1_5 = var_3.getData(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_5.updateRes(var_1_6, var_1_5)

	local var_1_7 = arg_1_0.viewComponent
	local var_1_8 = var_5.setActivity

	getProxy = var_7
	ActivityProxy = var_1_10008

	local var_1_9 = var_7(var_1_10008)
	local var_1_10 = var_7.getActivityByType

	ActivityConst = var_1_10009

	var_1_8(var_1_7, var_1_10(var_1_9, var_1_10009.ACTIVITY_TYPE_DAILY_STAGE_BONUS))
	arg_1_0:bind(var_0_1.ON_QUICK_BATTLE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0

		var_4.CheckShipExpItemOverflow(var_2_0, arg_2_2, function()
			local var_3_0 = arg_1_0
			local var_3_1 = var_0.sendNotification

			GAME = var_3_10002

			var_3_1(var_3_0, var_3_10002.DAILY_LEVEL_QUICK_BATTLE, {
				dailyLevelId = arg_2_1,
				stageId = arg_2_2,
				cnt = arg_2_3
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.ON_STAGE, function(arg_4_0, arg_4_1)
		local var_4_0 = var_1_0

		var_4_0.dailyLevelId = arg_1_0.contextData.dailyLevelId
		PreCombatLayer = var_4_0
		SYSTEM_ROUTINE = var_3
		pg = var_2_10004

		local var_4_1 = var_2_10004.expedition_data_template[arg_4_1.id].type

		Stage = var_2_10006

		if var_4_1 == var_2_10006.SubmarinStage then
			PreCombatLayerSubmarine = var_4_0
			SYSTEM_SUB_ROUTINE = var_3
		end

		local var_4_2 = arg_1_0
		local var_4_3 = var_5.addSubLayers

		Context = var_2_10007

		local var_4_4 = var_2_10007.New
		local var_4_5 = {}

		PreCombatMediator = var_2_10009
		var_4_5.mediator = var_2_10009
		var_4_5.viewComponent = var_4_0
		var_4_5.data = {
			stageId = arg_4_1.id,
			system = var_3,
			OnConfirm = function(arg_5_0)
				local var_5_0 = arg_1_0

				var_1.CheckShipExpItemOverflow(var_5_0, arg_4_1.id, arg_5_0)

				return
			end
		}

		var_4_3(var_4_2, var_4_4(var_4_5))

		return
	end)

	return
end

function var_0_1.CheckShipExpItemOverflow(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.expedition_data_template[arg_6_1].award_display

	_ = var_1_10004

	if var_1_10004.any(var_6_0, function(arg_7_0)
		getProxy = var_2_10001
		BagProxy = var_2_10002

		local var_7_0 = var_2_10001(var_2_10002)
		local var_7_1 = var_1.getItemCountById(var_7_0, arg_7_0[2])

		Item = var_7_0

		local var_7_2 = var_7_0.getConfigData(arg_7_0[2])
		local var_7_3 = arg_7_0[1]

		DROP_TYPE_ITEM = var_2_10004

		if var_7_3 == var_2_10004 then
			local var_7_4 = var_7_2.type

			Item = var_2_10004

			local var_7_5

			if var_7_4 ~= var_2_10004.EXP_BOOK_TYPE or not (var_7_1 >= var_7_2.max_num) then
				var_7_5 = false
			else
				var_7_5 = true
			end

			return var_7_5
		end
	end) then
		pg = var_4

		local var_6_1 = var_4.MsgboxMgr.GetInstance()
		local var_6_2 = var_4.ShowMsgBox
		local var_6_3 = {}

		i18n = var_1_10007
		var_6_3.content = var_1_10007("player_expResource_mail_fullBag")
		var_6_3.onYes = arg_6_2

		var_6_2(var_6_1, var_6_3)
	else
		arg_6_2()
	end

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	PlayerProxy = var_1_10002
	var_8_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_8_0[2] = var_2.DAILY_LEVEL_QUICK_BATTLE_DONE
	GAME = var_2
	var_8_0[3] = var_2.REMOVE_LAYERS

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	PlayerProxy = var_9_1

	if var_9_0 == var_9_1.UPDATED then
		local var_9_3 = arg_9_0.viewComponent

		var_4.updateRes(var_9_3, var_9_2)
	else
		GAME = var_4

		if var_9_0 == var_4.DAILY_LEVEL_QUICK_BATTLE_DONE then
			local var_9_4 = #var_9_2.awards
			local var_9_5

			if 0 < var_9_4 then
				var_9_5 = arg_9_0.viewComponent
				var_9_4 = var_9_4.emit
				BaseUI = var_1_10007

				var_9_4(var_9_5, var_1_10007.ON_ACHIEVE, var_4)
			end

			getProxy = var_9_4
			DailyLevelProxy = var_9_5

			local var_9_6 = var_9_4(var_9_5)
			local var_9_7 = arg_9_0.viewComponent

			var_6.setDailyCounts(var_9_7, var_9_6:getRawData())

			local var_9_8 = arg_9_0.viewComponent

			var_6.UpdateBattleBtn(var_9_8, {
				id = var_9_2.stageId
			})

			local var_9_9 = arg_9_0.viewComponent

			var_6.UpdateDailyLevelCnt(var_9_9, var_9_2.dailyLevelId)

			local var_9_10 = arg_9_0.viewComponent

			var_6.UpdateDailyLevelCntForDescPanel(var_9_10, var_9_2.dailyLevelId)
		else
			GAME = var_4

			if var_9_0 == var_4.REMOVE_LAYERS and var_9_2.context.mediator.__cname == "PreCombatMediator" then
				setActive = var_4

				var_4(arg_9_0.viewComponent.blurPanel, true)
			end
		end
	end

	return
end

return var_0_1
