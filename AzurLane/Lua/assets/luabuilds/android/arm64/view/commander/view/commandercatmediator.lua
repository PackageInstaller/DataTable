local var_0_0 = class("CommanderCatMediator", import("view.base.ContextMediator"))

var_0_0.RESERVE_BOX = "CommanderCatMediator:RESERVE_BOX"
var_0_0.OPEN_HOME = "CommanderCatMediator:OPEN_HOME"
var_0_0.ON_SELECT = "CommanderCatMediator:ON_SELECT"
var_0_0.UPGRADE = "CommanderCatMediator:UPGRADE"
var_0_0.LOCK = "CommanderCatMediator:LOCK"
var_0_0.SKILL_INFO = "CommanderCatMediator:SKILL_INFO"
var_0_0.RENAME = "CommanderCatMediator:RENAME"
var_0_0.FETCH_NOT_LEARNED_TALENT = "CommanderCatMediator:FETCH_NOT_LEARNED_TALENT"
var_0_0.LEARN_TALENT = "CommanderCatMediator:LEARN_TALENT"
var_0_0.RESET_TALENT = "CommanderCatMediator:RESET_TALENT"
var_0_0.BATCH_GET = "CommanderCatMediator:BATCH_GET"
var_0_0.ONE_KEY = "CommanderCatMediator:ONE_KEY"
var_0_0.BATCH_BUILD = "CommanderCatMediator:BATCH_BUILD"
var_0_0.BUILD = "CommanderCatMediator:BUILD"
var_0_0.GET = "CommanderCatMediator:GET"
var_0_0.USE_QUICKLY_TOOL = "CommanderCatMediator:USE_QUICKLY_TOOL"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.USE_QUICKLY_TOOL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.COMMANDER_ON_OPEN_BOX, {
			id = arg_3_1,
			callback = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.BUILD, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.COMMANDER_ON_BUILD, {
			tip = true,
			id = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.BATCH_BUILD, function(arg_5_0, arg_5_1)
		for iter_5_0 = 1, #arg_5_1 do
			local var_5_0 = arg_5_1[iter_5_0]

			table.insert({}, function(arg_6_0)
				arg_1_0:sendNotification(GAME.COMMANDER_ON_BUILD, {
					tip = false,
					id = var_5_0,
					callback = arg_6_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_build_done"))

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.ONE_KEY, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0:sendNotification(GAME.COMMANDER_QUICKLY_FINISH_BOXES, {
			itemCnt = arg_8_1,
			affectCnt = arg_8_2,
			finishCnt = arg_8_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.BATCH_GET, function(arg_9_0, arg_9_1)
		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			if iter_9_1:getState() == CommanderBox.STATE_FINISHED then
				table.insert({}, iter_9_1.id)
			end
		end

		arg_1_0:sendNotification(GAME.COMMANDER_ON_BATCH, {
			boxIds = {}
		})

		return
	end)
	arg_1_0:bind(var_0_0.RESET_TALENT, function(arg_10_0, arg_10_1)
		arg_1_0:sendNotification(GAME.COMMANDER_RESET_TALENTS, {
			id = arg_10_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.LEARN_TALENT, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		arg_1_0:sendNotification(GAME.COMMANDER_LEARN_TALENTS, {
			id = arg_11_1,
			talentId = arg_11_2,
			replaceid = arg_11_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.FETCH_NOT_LEARNED_TALENT, function(arg_12_0, arg_12_1)
		arg_1_0:sendNotification(GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT, {
			id = arg_12_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.RENAME, function(arg_13_0, arg_13_1, arg_13_2)
		arg_1_0:sendNotification(GAME.COMMANDER_RENAME, {
			commanderId = arg_13_1,
			name = arg_13_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.SKILL_INFO, function(arg_14_0, arg_14_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = NewCommanderSkillLayer,
			data = {
				skill = arg_14_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.LOCK, function(arg_15_0, arg_15_1, arg_15_2)
		arg_1_0:sendNotification(GAME.COMMANDER_LOCK, {
			commanderId = arg_15_1,
			flag = arg_15_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.UPGRADE, function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		arg_1_0:sendNotification(GAME.COMMANDER_UPGRADE, {
			id = arg_16_1,
			materialIds = arg_16_2,
			skillId = arg_16_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT, function(arg_17_0, arg_17_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ContextMediator,
			viewComponent = SelectCommanderCatForPlayScene,
			data = arg_17_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.RESERVE_BOX, function(arg_18_0, arg_18_1)
		arg_1_0:sendNotification(GAME.COMMANDER_RESERVE_BOX, {
			count = arg_18_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_HOME, function(arg_19_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CommanderHomeLayer,
			mediator = CommanderHomeMediator
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_20_0)
	return {
		GAME.COMMANDER_RESERVE_BOX_DONE,
		GAME.COMMANDER_QUICKLY_FINISH_BOXES_ERROR,
		GAME.COMMANDER_UPGRADE_DONE,
		GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE,
		GAME.COMMANDER_LEARN_TALENTS_DONE,
		GAME.COMMANDER_LOCK_DONE,
		CommanderProxy.COMMANDER_UPDATED,
		CommanderProxy.COMMANDER_ADDED,
		CommanderProxy.COMMANDER_DELETED,
		GAME.COMMANDER_CATTERY_OP_DONE,
		GAME.ZERO_HOUR_OP_DONE,
		GAME.PUT_COMMANDER_IN_CATTERY_DONE,
		GAME.COMMANDER_ON_BUILD_DONE,
		GAME.REFRESH_COMMANDER_BOXES_DONE,
		GAME.COMMANDER_ON_OPEN_BOX_DONE,
		GAME.COMMANDER_ON_BATCH_DONE,
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == GAME.COMMANDER_RESERVE_BOX_DONE then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_RESERVE_BOX, var_21_1.awards)
	elseif var_21_0 == PlayerProxy.UPDATED then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_RES_UPDATE)
	elseif var_21_0 == GAME.COMMANDER_QUICKLY_FINISH_BOXES_ERROR then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_QUICKLY_FINISH_TOOL_ERROR)
	elseif var_21_0 == GAME.COMMANDER_UPGRADE_DONE then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_UPGRADE, var_21_1.oldCommander, var_21_1.commander)
	elseif var_21_0 == GAME.COMMANDER_LOCK_DONE then
		if var_21_1.flag == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_lock_done"))
		elseif var_21_1.flag == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_unlock_done"))
		end
	elseif var_21_0 == GAME.COMMANDER_RENAME_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_rename_success_tip"))
	elseif var_21_0 == GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_FETCH_TALENT_LIST)
	elseif var_21_0 == GAME.COMMANDER_LEARN_TALENTS_DONE then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_LEARN_TALENT)
	elseif var_21_0 == CommanderProxy.COMMANDER_UPDATED or var_21_0 == CommanderProxy.COMMANDER_ADDED or var_21_0 == CommanderProxy.COMMANDER_DELETED then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_UPDATE)
	elseif var_21_0 == GAME.COMMANDER_CATTERY_OP_DONE or var_21_0 == GAME.ZERO_HOUR_OP_DONE or var_21_0 == GAME.PUT_COMMANDER_IN_CATTERY_DONE then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_HOME_TIP)
	elseif var_21_0 == GAME.COMMANDER_ON_BUILD_DONE or var_21_0 == GAME.REFRESH_COMMANDER_BOXES_DONE then
		arg_21_0.viewComponent:emit(CommanderCatScene.MSG_BUILD)
	elseif var_21_0 == GAME.COMMANDER_ON_OPEN_BOX_DONE then
		pg.UIMgr.GetInstance():LoadingOn(false)
		seriesAsync({
			function(arg_22_0)
				arg_21_0.viewComponent:emit(CommanderCatScene.MSG_OPEN_BOX, var_21_1.boxId, arg_22_0)

				return
			end,
			function(arg_23_0)
				pg.UIMgr.GetInstance():LoadingOff()
				arg_21_0:DisplayNewCommander(var_21_1.commander, arg_23_0)

				return
			end,
			function()
				arg_21_0.viewComponent:emit(CommanderCatScene.MSG_BUILD)

				return
			end
		}, var_21_1.callback)
	elseif var_21_0 == GAME.COMMANDER_ON_BATCH_DONE then
		arg_21_0:BatchDisplayCommander(var_21_1.boxIds, var_21_1.commanders)
	end

	return
end

function var_0_0.BatchDisplayCommander(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		table.insert({}, function(arg_26_0)
			arg_25_0.viewComponent:emit(CommanderCatScene.MSG_OPEN_BOX, iter_25_1, arg_26_0)

			return
		end)
	end

	getProxy(CommanderProxy).hasSkipFlag = false

	pg.UIMgr.GetInstance():LoadingOn(false)
	parallelAsync({}, function()
		pg.UIMgr.GetInstance():LoadingOff()

		for iter_27_0, iter_27_1 in ipairs(arg_25_2) do
			table.insert({}, function(arg_28_0)
				if getProxy(CommanderProxy).hasSkipFlag and not iter_27_1:ShouldTipLock() then
					arg_28_0()
				else
					arg_25_0:DisplayNewCommander(iter_27_1, arg_28_0)
				end

				return
			end)
		end

		seriesAsync({}, function()
			arg_25_0.viewComponent:emit(CommanderCatScene.MSG_BUILD)

			getProxy(CommanderProxy).hasSkipFlag = false

			arg_25_0.viewComponent:emit(CommanderCatScene.MSG_BATCH_BUILD, arg_25_2)

			return
		end)

		return
	end)

	return
end

function var_0_0.DisplayNewCommander(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:addSubLayers(Context.New({
		viewComponent = NewCommanderScene,
		mediator = NewCommanderMediator,
		data = {
			commander = arg_30_1,
			onExit = arg_30_2
		}
	}))

	return
end

function var_0_0.remove(arg_31_0)
	if pg.ConnectionMgr.GetInstance():isConnected() then
		arg_31_0:sendNotification(GAME.OPEN_OR_CLOSE_CATTERY, {
			open = false
		})
	end

	return
end

return var_0_0
