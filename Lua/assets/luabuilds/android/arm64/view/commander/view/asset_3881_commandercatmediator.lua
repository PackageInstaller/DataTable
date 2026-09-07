local CommanderCatMediator = class("CommanderCatMediator", import("view.base.ContextMediator"))

CommanderCatMediator.RESERVE_BOX = "CommanderCatMediator:RESERVE_BOX"
CommanderCatMediator.OPEN_HOME = "CommanderCatMediator:OPEN_HOME"
CommanderCatMediator.ON_SELECT = "CommanderCatMediator:ON_SELECT"
CommanderCatMediator.UPGRADE = "CommanderCatMediator:UPGRADE"
CommanderCatMediator.LOCK = "CommanderCatMediator:LOCK"
CommanderCatMediator.SKILL_INFO = "CommanderCatMediator:SKILL_INFO"
CommanderCatMediator.RENAME = "CommanderCatMediator:RENAME"
CommanderCatMediator.FETCH_NOT_LEARNED_TALENT = "CommanderCatMediator:FETCH_NOT_LEARNED_TALENT"
CommanderCatMediator.LEARN_TALENT = "CommanderCatMediator:LEARN_TALENT"
CommanderCatMediator.RESET_TALENT = "CommanderCatMediator:RESET_TALENT"
CommanderCatMediator.BATCH_GET = "CommanderCatMediator:BATCH_GET"
CommanderCatMediator.ONE_KEY = "CommanderCatMediator:ONE_KEY"
CommanderCatMediator.BATCH_BUILD = "CommanderCatMediator:BATCH_BUILD"
CommanderCatMediator.BUILD = "CommanderCatMediator:BUILD"
CommanderCatMediator.GET = "CommanderCatMediator:GET"
CommanderCatMediator.USE_QUICKLY_TOOL = "CommanderCatMediator:USE_QUICKLY_TOOL"

function CommanderCatMediator:register()
	self:bind(CommanderCatMediator.USE_QUICKLY_TOOL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)
	self:bind(CommanderCatMediator.GET, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.COMMANDER_ON_OPEN_BOX, {
			id = arg_3_1,
			callback = arg_3_2
		})

		return
	end)
	self:bind(CommanderCatMediator.BUILD, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.COMMANDER_ON_BUILD, {
			tip = true,
			id = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	self:bind(CommanderCatMediator.BATCH_BUILD, function(arg_5_0, arg_5_1)
		local var_5_0 = {}

		for iter_5_0 = 1, #arg_5_1 do
			local var_5_1 = arg_5_1[iter_5_0]

			table.insert(var_5_0, function(arg_6_0)
				self:sendNotification(GAME.COMMANDER_ON_BUILD, {
					tip = false,
					id = var_5_1,
					callback = arg_6_0
				})

				return
			end)
		end

		seriesAsync(var_5_0, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_build_done"))

			return
		end)

		return
	end)
	self:bind(CommanderCatMediator.ONE_KEY, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		self:sendNotification(GAME.COMMANDER_QUICKLY_FINISH_BOXES, {
			itemCnt = arg_8_1,
			affectCnt = arg_8_2,
			finishCnt = arg_8_3
		})

		return
	end)
	self:bind(CommanderCatMediator.BATCH_GET, function(arg_9_0, arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			if iter_9_1:getState() == CommanderBox.STATE_FINISHED then
				table.insert(var_9_0, iter_9_1.id)
			end
		end

		self:sendNotification(GAME.COMMANDER_ON_BATCH, {
			boxIds = var_9_0
		})

		return
	end)
	self:bind(CommanderCatMediator.RESET_TALENT, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.COMMANDER_RESET_TALENTS, {
			id = arg_10_1
		})

		return
	end)
	self:bind(CommanderCatMediator.LEARN_TALENT, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		self:sendNotification(GAME.COMMANDER_LEARN_TALENTS, {
			id = arg_11_1,
			talentId = arg_11_2,
			replaceid = arg_11_3
		})

		return
	end)
	self:bind(CommanderCatMediator.FETCH_NOT_LEARNED_TALENT, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT, {
			id = arg_12_1
		})

		return
	end)
	self:bind(CommanderCatMediator.RENAME, function(arg_13_0, arg_13_1, arg_13_2)
		self:sendNotification(GAME.COMMANDER_RENAME, {
			commanderId = arg_13_1,
			name = arg_13_2
		})

		return
	end)
	self:bind(CommanderCatMediator.SKILL_INFO, function(arg_14_0, arg_14_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = NewCommanderSkillLayer,
			data = {
				skill = arg_14_1
			}
		}))

		return
	end)
	self:bind(CommanderCatMediator.LOCK, function(arg_15_0, arg_15_1, arg_15_2)
		self:sendNotification(GAME.COMMANDER_LOCK, {
			commanderId = arg_15_1,
			flag = arg_15_2
		})

		return
	end)
	self:bind(CommanderCatMediator.UPGRADE, function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		self:sendNotification(GAME.COMMANDER_UPGRADE, {
			id = arg_16_1,
			materialIds = arg_16_2,
			skillId = arg_16_3
		})

		return
	end)
	self:bind(CommanderCatMediator.ON_SELECT, function(arg_17_0, arg_17_1)
		self:addSubLayers(Context.New({
			mediator = ContextMediator,
			viewComponent = SelectCommanderCatForPlayScene,
			data = arg_17_1
		}))

		return
	end)
	self:bind(CommanderCatMediator.RESERVE_BOX, function(arg_18_0, arg_18_1)
		self:sendNotification(GAME.COMMANDER_RESERVE_BOX, {
			count = arg_18_1
		})

		return
	end)
	self:bind(CommanderCatMediator.OPEN_HOME, function(arg_19_0)
		self:addSubLayers(Context.New({
			viewComponent = CommanderHomeLayer,
			mediator = CommanderHomeMediator
		}))

		return
	end)

	return
end

function CommanderCatMediator:listNotificationInterests()
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

function CommanderCatMediator:handleNotification(arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == GAME.COMMANDER_RESERVE_BOX_DONE then
		self.viewComponent:emit(CommanderCatScene.MSG_RESERVE_BOX, var_21_1.awards)
	elseif var_21_0 == PlayerProxy.UPDATED then
		self.viewComponent:emit(CommanderCatScene.MSG_RES_UPDATE)
	elseif var_21_0 == GAME.COMMANDER_QUICKLY_FINISH_BOXES_ERROR then
		self.viewComponent:emit(CommanderCatScene.MSG_QUICKLY_FINISH_TOOL_ERROR)
	elseif var_21_0 == GAME.COMMANDER_UPGRADE_DONE then
		self.viewComponent:emit(CommanderCatScene.MSG_UPGRADE, var_21_1.oldCommander, var_21_1.commander)
	elseif var_21_0 == GAME.COMMANDER_LOCK_DONE then
		if var_21_1.flag == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_lock_done"))
		elseif var_21_1.flag == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_unlock_done"))
		end
	elseif var_21_0 == GAME.COMMANDER_RENAME_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_rename_success_tip"))
	elseif var_21_0 == GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE then
		self.viewComponent:emit(CommanderCatScene.MSG_FETCH_TALENT_LIST)
	elseif var_21_0 == GAME.COMMANDER_LEARN_TALENTS_DONE then
		self.viewComponent:emit(CommanderCatScene.MSG_LEARN_TALENT)
	elseif var_21_0 == CommanderProxy.COMMANDER_UPDATED or var_21_0 == CommanderProxy.COMMANDER_ADDED or var_21_0 == CommanderProxy.COMMANDER_DELETED then
		self.viewComponent:emit(CommanderCatScene.MSG_UPDATE)
	elseif var_21_0 == GAME.COMMANDER_CATTERY_OP_DONE or var_21_0 == GAME.ZERO_HOUR_OP_DONE or var_21_0 == GAME.PUT_COMMANDER_IN_CATTERY_DONE then
		self.viewComponent:emit(CommanderCatScene.MSG_HOME_TIP)
	elseif var_21_0 == GAME.COMMANDER_ON_BUILD_DONE or var_21_0 == GAME.REFRESH_COMMANDER_BOXES_DONE then
		self.viewComponent:emit(CommanderCatScene.MSG_BUILD)
	elseif var_21_0 == GAME.COMMANDER_ON_OPEN_BOX_DONE then
		pg.UIMgr.GetInstance():LoadingOn(false)
		seriesAsync({
			function(arg_22_0)
				self.viewComponent:emit(CommanderCatScene.MSG_OPEN_BOX, var_21_1.boxId, arg_22_0)

				return
			end,
			function(arg_23_0)
				pg.UIMgr.GetInstance():LoadingOff()
				self:DisplayNewCommander(var_21_1.commander, arg_23_0)

				return
			end,
			function()
				self.viewComponent:emit(CommanderCatScene.MSG_BUILD)

				return
			end
		}, var_21_1.callback)
	elseif var_21_0 == GAME.COMMANDER_ON_BATCH_DONE then
		self:BatchDisplayCommander(var_21_1.boxIds, var_21_1.commanders)
	end

	return
end

function CommanderCatMediator:BatchDisplayCommander(arg_25_1, arg_25_2)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		table.insert(var_25_0, function(arg_26_0)
			self.viewComponent:emit(CommanderCatScene.MSG_OPEN_BOX, iter_25_1, arg_26_0)

			return
		end)
	end

	getProxy(CommanderProxy).hasSkipFlag = false

	pg.UIMgr.GetInstance():LoadingOn(false)
	parallelAsync(var_25_0, function()
		pg.UIMgr.GetInstance():LoadingOff()

		local var_27_0 = {}

		for iter_27_0, iter_27_1 in ipairs(arg_25_2) do
			table.insert(var_27_0, function(arg_28_0)
				if getProxy(CommanderProxy).hasSkipFlag and not iter_27_1:ShouldTipLock() then
					arg_28_0()
				else
					self:DisplayNewCommander(iter_27_1, arg_28_0)
				end

				return
			end)
		end

		seriesAsync(var_27_0, function()
			self.viewComponent:emit(CommanderCatScene.MSG_BUILD)

			getProxy(CommanderProxy).hasSkipFlag = false

			self.viewComponent:emit(CommanderCatScene.MSG_BATCH_BUILD, arg_25_2)

			return
		end)

		return
	end)

	return
end

function CommanderCatMediator:DisplayNewCommander(arg_30_1, arg_30_2)
	self:addSubLayers(Context.New({
		viewComponent = NewCommanderScene,
		mediator = NewCommanderMediator,
		data = {
			commander = arg_30_1,
			onExit = arg_30_2
		}
	}))

	return
end

function CommanderCatMediator:remove()
	if pg.ConnectionMgr.GetInstance():isConnected() then
		self:sendNotification(GAME.OPEN_OR_CLOSE_CATTERY, {
			open = false
		})
	end

	return
end

return CommanderCatMediator
