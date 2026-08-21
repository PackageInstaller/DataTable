local var_0_0 = class("NewEducateMainMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.OPEN_COLLECT_LAYER = "NewEducateMainMediator.OPEN_COLLECT_LAYER"
var_0_0.ON_SELECT_MIND = "NewEducateMainMediator.ON_SELECT_MIND"
var_0_0.ON_UPGRADE_FAVOR = "NewEducateMainMediator.ON_UPGRADE_FAVOR"
var_0_0.ON_TRIGGER_MAIN_EVENT = "NewEducateMainMediator.ON_TRIGGER_MAIN_EVENT"
var_0_0.ON_REQ_TALENTS = "NewEducateMainMediator.ON_REQ_TALENTS"
var_0_0.ON_REQ_CHOOSE = "NewEducateMainMediator.ON_REQ_CHOOSE"
var_0_0.ON_REQ_TOPICS = "NewEducateMainMediator.ON_REQ_TOPICS"
var_0_0.ON_SELECT_TOPIC = "NewEducateMainMediator.ON_SELECT_TOPIC"
var_0_0.ON_ENTER_ASSESS = "NewEducateMainMediator.ON_ENTER_ASSESS"
var_0_0.ON_SET_ASSESS_RANK = "NewEducateMainMediator.ON_SET_ASSESS_RANK"
var_0_0.ON_STAGE_CHANGE = "NewEducateMainMediator.ON_STAGE_CHANGE"
var_0_0.ON_NEXT_PLAN = "NewEducateMainMediator.ON_NEXT_PLAN"
var_0_0.ON_REQ_MAP = "NewEducateMainMediator.ON_REQ_MAP"
var_0_0.ON_REQ_ENDINGS = "NewEducateMainMediator.ON_REQ_ENDINGS"
var_0_0.ON_RESET = "NewEducateMainMediator.ON_RESET"
var_0_0.ON_SELECT_ENDING = "NewEducateMainMediator.ON_SELECT_ENDING"
var_0_0.ON_START_ENDLESS = "NewEducateMainMediator.ON_START_ENDLESS"
var_0_0.ON_CLEAR_NODE_CHAIN = "NewEducateMainMediator.ON_CLEAR_NODE_CHAIN"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_COLLECT_LAYER, function(arg_2_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewEducateCollectEntranceMediator,
			viewComponent = NewEducateCollectEntranceLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_MIND, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_MIND, {
			id = arg_1_0.contextData.char.id,
			callback = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPGRADE_FAVOR, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_UPGRADE_FAVOR, {
			id = arg_1_0.contextData.char.id,
			callback = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TRIGGER_MAIN_EVENT, function(arg_5_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_MAIN_EVENT, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REQ_TALENTS, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_TALENTS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REQ_CHOOSE, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_CHOOSE, {
			id = arg_1_0.contextData.char.id,
			callback = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REQ_TOPICS, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_TOPICS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_TOPIC, function(arg_9_0, arg_9_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_TOPIC, {
			id = arg_1_0.contextData.char.id,
			topicId = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_NEXT_PLAN, function(arg_10_0, arg_10_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_NEXT_PLAN, {
			rePlay = true,
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ENTER_ASSESS, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_ENTER_ASSESS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SET_ASSESS_RANK, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_ASSESS, {
			id = arg_1_0.contextData.char.id,
			rank = arg_12_1,
			endlessFail = arg_12_2,
			callback = arg_12_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_STAGE_CHANGE, function(arg_13_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_CHANGE_PHASE, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REQ_MAP, function(arg_14_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_MAP, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REQ_ENDINGS, function(arg_15_0, arg_15_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_ENDINGS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_15_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_RESET, function(arg_16_0, arg_16_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_RESET, {
			id = arg_1_0.contextData.char.id,
			difficulty = arg_1_0.contextData.char.difficulty,
			callback = arg_16_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_ENDING, function(arg_17_0, arg_17_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_ENDING, {
			isMain = true,
			id = arg_1_0.contextData.char.id,
			endingId = arg_17_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_START_ENDLESS, function(arg_18_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_CHANGE_PHASE, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLEAR_NODE_CHAIN, function(arg_19_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_CLEAR_NODE_CHAIN, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_20_0)
	return {
		NewEducateProxy.RESOURCE_UPDATED,
		NewEducateProxy.ATTR_UPDATED,
		NewEducateProxy.PERSONALITY_UPDATED,
		NewEducateProxy.TALENT_UPDATED,
		NewEducateProxy.STATUS_UPDATED,
		NewEducateProxy.TAROT_UPDATED,
		NewEducateProxy.NEXT_ROUND,
		GAME.NEW_EDUCATE_SEL_TOPIC_DONE,
		GAME.NEW_EDUCATE_NODE_START,
		GAME.NEW_EDUCATE_NEXT_NODE,
		GAME.NEW_EDUCATE_CHECK_FSM,
		GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM,
		GAME.NEW_EDUCATE_GET_EXTRA_DROP_DONE,
		GAME.NEW_EDUCATE_UPGRADE_FAVOR_DONE,
		GAME.NEW_EDUCATE_REFRESH_DONE,
		GAME.NEW_EDUCATE_ENTER_ASSESS_DONE,
		GAME.NEW_EDUCATE_ASSESS_DONE,
		GAME.NEW_EDUCATE_CHANGE_PHASE_DONE,
		GAME.NEW_EDUCATE_NEXT_PLAN_DONE,
		GAME.NEW_EDUCATE_GET_MAP_DONE,
		GAME.NEW_EDUCATE_SEL_MIND_DONE,
		GAME.NEW_EDUCATE_SEL_ENDING_DONE,
		GAME.NEW_EDUCATE_SET_CALL_DONE
	}
end

function var_0_0.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == NewEducateProxy.RESOURCE_UPDATED then
		arg_21_0.viewComponent:OnResUpdate()
	elseif var_21_0 == NewEducateProxy.ATTR_UPDATED then
		arg_21_0.viewComponent:OnAttrUpdate()
	elseif var_21_0 == NewEducateProxy.PERSONALITY_UPDATED then
		arg_21_0.viewComponent:OnPersonalityUpdate(var_21_1.number, var_21_1.oldTag)
	elseif var_21_0 == NewEducateProxy.TALENT_UPDATED then
		arg_21_0.viewComponent:OnTalentUpdate()
	elseif var_21_0 == NewEducateProxy.STATUS_UPDATED then
		arg_21_0.viewComponent:OnStatusUpdate()
	elseif var_21_0 == NewEducateProxy.TAROT_UPDATED then
		arg_21_0.viewComponent:OnTarotUpdate()
	elseif var_21_0 == NewEducateProxy.NEXT_ROUND then
		arg_21_0.viewComponent:OnNextRound()
	elseif var_21_0 == GAME.NEW_EDUCATE_NODE_START then
		arg_21_0.viewComponent:OnNodeStart(var_21_1.node)
	elseif var_21_0 == GAME.NEW_EDUCATE_NEXT_NODE then
		arg_21_0.viewComponent:OnNextNode(var_21_1)
	elseif var_21_0 == GAME.NEW_EDUCATE_CHECK_FSM then
		arg_21_0.viewComponent:CheckFSM()
	elseif var_21_0 == GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM then
		arg_21_0:CheckPriorityState()
	elseif var_21_0 == GAME.NEW_EDUCATE_GET_EXTRA_DROP_DONE then
		if #var_21_1.drops == 0 then
			arg_21_0:AddResultLayer(var_21_1)
		else
			arg_21_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
				items = var_21_1.drops,
				removeFunc = function()
					arg_21_0:AddResultLayer(var_21_1)

					return
				end
			})
		end
	elseif var_21_0 == GAME.NEW_EDUCATE_UPGRADE_FAVOR_DONE then
		arg_21_0.viewComponent:UpdateFavorInfo()
		arg_21_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
			isFavor = true,
			items = var_21_1.drops,
			removeFunc = function()
				arg_21_0.viewComponent:CheckFavorUpgrade(var_21_1.callback)

				return
			end
		})
	elseif var_21_0 == GAME.NEW_EDUCATE_REFRESH_DONE then
		arg_21_0.viewComponent:OnReset()
	elseif var_21_0 == GAME.NEW_EDUCATE_SEL_TOPIC_DONE then
		arg_21_0:StartNodeWithCheckDrops(var_21_1)
	elseif var_21_0 == GAME.NEW_EDUCATE_ENTER_ASSESS_DONE then
		if #var_21_1.drops == 0 then
			existCall(var_21_1.callback)
		else
			arg_21_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
				items = var_21_1.drops,
				removeFunc = var_21_1.callback
			})
		end
	elseif var_21_0 == GAME.NEW_EDUCATE_ASSESS_DONE then
		seriesAsync({
			function(arg_24_0)
				if #var_21_1.drops == 0 then
					arg_24_0()
				else
					arg_21_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
						items = var_21_1.drops,
						removeFunc = arg_24_0
					})
				end

				return
			end
		}, function(arg_25_0)
			if var_21_1.node ~= 0 then
				arg_21_0.viewComponent:OnNodeStart(var_21_1.node)
			else
				arg_21_0.viewComponent:SeriesCheck()
			end

			return
		end)
	elseif var_21_0 == GAME.NEW_EDUCATE_CHANGE_PHASE_DONE then
		arg_21_0.viewComponent:AddNewRoundDrops(var_21_1.drops)
		arg_21_0:CheckFirstNodeExist(var_21_1.node)
	elseif var_21_0 == GAME.NEW_EDUCATE_NEXT_PLAN_DONE then
		if #var_21_1.drops == 0 then
			(function()
				if var_21_1.isFristNode then
					arg_21_0.viewComponent:OnNodeStart(var_21_1.node)
				else
					arg_21_0.viewComponent:OnNextNode(var_21_1)
				end

				return
			end)()
		else
			arg_21_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
				items = var_21_1.drops,
				removeFunc = function()
					if var_21_1.isFristNode then
						arg_21_0.viewComponent:OnNodeStart(var_21_1.node)
					else
						arg_21_0.viewComponent:OnNextNode(var_21_1)
					end

					return
				end
			})
		end
	elseif var_21_0 == GAME.NEW_EDUCATE_GET_MAP_DONE then
		if #var_21_1.drops == 0 then
			arg_21_0.viewComponent:CheckFSM()
		else
			arg_21_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
				items = var_21_1.drops,
				removeFunc = function()
					arg_21_0.viewComponent:CheckFSM()

					return
				end
			})
		end
	elseif var_21_0 == GAME.NEW_EDUCATE_SEL_MIND_DONE then
		arg_21_0:StartNodeWithCheckDrops(var_21_1)
	elseif var_21_0 == GAME.NEW_EDUCATE_SEL_ENDING_DONE then
		if var_21_1.isMain then
			arg_21_0.viewComponent:OnSelDone(var_21_1.id)
		end
	elseif var_21_0 == GAME.NEW_EDUCATE_SET_CALL_DONE then
		arg_21_0.viewComponent:UpdateCallName()
	end

	return
end

function var_0_0.CheckFirstNodeExist(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		arg_28_0.viewComponent:SeriesCheck()
	else
		arg_28_0.viewComponent:OnNodeStart(arg_28_1)
	end

	return
end

function var_0_0.StartNodeWithCheckDrops(arg_29_0, arg_29_1)
	if #arg_29_1.drops == 0 then
		arg_29_0.viewComponent:OnNodeStart(arg_29_1.node)
	else
		arg_29_0.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
			items = arg_29_1.drops,
			removeFunc = function()
				arg_29_0.viewComponent:OnNodeStart(arg_29_1.node)

				return
			end
		})
	end

	return
end

function var_0_0.AddResultLayer(arg_31_0, arg_31_1)
	if #arg_31_1.scheduleDrops > 0 then
		arg_31_0:addSubLayers(Context.New({
			viewComponent = NewEducateScheduleResultLayer,
			mediator = NewEducateScheduleResultMediator,
			data = {
				drops = arg_31_1.scheduleDrops,
				onExit = function()
					arg_31_0.viewComponent:CheckFSM()

					return
				end
			}
		}))
	else
		arg_31_0.viewComponent:CheckFSM()
	end

	return
end

return var_0_0
