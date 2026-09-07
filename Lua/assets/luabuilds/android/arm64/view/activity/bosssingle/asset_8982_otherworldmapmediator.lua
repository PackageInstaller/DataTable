local OtherworldMapMediator = class("OtherworldMapMediator", import("view.activity.BossSingle.BossSingleMediatorTemplate"))

OtherworldMapMediator.ON_EVENT_TRIGGER = "OtherworldMapMediator.ON_EVENT_TRIGGER"

function OtherworldMapMediator:register()
	self:BindBattleEvents()
	self:bind(OtherworldMapMediator.ON_EVENT_TRIGGER, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SINGLE_EVENT_TRIGGER, {
			actId = arg_2_1.actId,
			eventId = arg_2_1.eventId
		})

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)
	local var_1_1 = var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_EVENT_SINGLE)

	if var_1_1 and not var_1_1:isEnd() then
		self.viewComponent:SetEventAct(var_1_1)
	else
		self.viewComponent:SetEventAct(nil)
	end

	local var_1_2 = var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

	if not var_1_2 then
		assert(nil, "not exist lottery act")

		return
	end

	self.contextData.resId = pg.activity_random_award_template[var_1_2:getConfig("config_data")[1]].resource_type

	return
end

function OtherworldMapMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.BEGIN_STAGE_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.contextData.editFleet = nil

			if not getProxy(ContextProxy):getContextByMediator(PreCombatMediator) then
				arg_4_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, (arg_4_1:getBody()))
			end

			return
		end,
		[GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE] = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_1:getBody()
			local var_5_1 = getProxy(FleetProxy):getActivityFleets()[var_5_0.actId]

			arg_5_0.contextData.actFleets = var_5_1

			arg_5_0.viewComponent:updateEditPanel()
			arg_5_0.viewComponent:updateCommanderFleet(var_5_1[var_5_0.fleetId])

			return
		end,
		[CommanderProxy.PREFAB_FLEET_UPDATE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getBody()

			arg_6_0.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
			arg_6_0.viewComponent:updateCommanderPrefab()

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:UpdateRes()
			arg_7_0.viewComponent:UpdateWangduBtn()

			return
		end,
		[ActivityProxy.ACTIVITY_UPDATED] = function(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_1:getBody()

			if not var_8_0 or var_8_0:isEnd() then
				return
			end

			if var_8_0.id == ActivityConst.OTHER_WORLD_TERMINAL_PT_ID then
				arg_8_0.viewComponent:UpdateTerminalTip()
			end

			return
		end,
		[GAME.SINGLE_EVENT_TRIGGER_DONE] = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1:getBody()
			local var_9_1 = {}

			if #var_9_0.awards > 0 then
				table.insert(var_9_1, function(arg_10_0)
					arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_0.awards, arg_10_0)

					return
				end)
			end

			seriesAsync(var_9_1, function()
				arg_9_0.viewComponent:SetEventAct(var_9_0.activity)
				arg_9_0.viewComponent:UpdateEvents(var_9_0.eventId)

				return
			end)

			return
		end,
		[GAME.SINGLE_EVENT_REFRESH_DONE] = function(arg_12_0, arg_12_1)
			arg_12_0.viewComponent:SetEventAct(arg_12_1:getBody().activity)
			arg_12_0.viewComponent:UpdateEvents()

			return
		end,
		[GAME.ACT_NEW_PT_DONE] = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1:getBody()

			arg_13_0.viewComponent:UpdateTerminalTip()

			return
		end,
		[AvatarFrameProxy.FRAME_TASK_UPDATED] = function(arg_14_0, arg_14_1)
			arg_14_0.viewComponent:UpdateWangduBtn()

			return
		end,
		[AvatarFrameProxy.FRAME_TASK_TIME_OUT] = function(arg_15_0, arg_15_1)
			arg_15_0.viewComponent:UpdateWangduBtn()

			return
		end
	}

	return
end

function OtherworldMapMediator:remove()
	return
end

return OtherworldMapMediator
