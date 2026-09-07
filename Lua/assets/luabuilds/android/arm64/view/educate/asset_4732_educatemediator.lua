local EducateMediator = class("EducateMediator", import(".base.EducateContextMediator"))

EducateMediator.ON_DEFAULT_TARGET_SET = "EducateMediator:ON_DEFAULT_TARGET_SET"
EducateMediator.ON_UPGRADE_FAVOR = "EducateMediator:ON_UPGRADE_FAVOR"
EducateMediator.ON_SPECIAL_EVENT_TRIGGER = "EducateMediator:ON_SPECIAL_EVENT_TRIGGER"
EducateMediator.ON_EVENT_TRIGGER = "EducateMediator:ON_EVENT_TRIGGER"
EducateMediator.ON_GET_EVENT = "EducateMediator:ON_GET_EVENT"
EducateMediator.ON_EXECTUE_PLANS = "EducateMediator:ON_EXECTUE_PLANS"
EducateMediator.ON_ENDING_TRIGGER = "EducateMediator:ON_ENDING_TRIGGER"
EducateMediator.ON_GAME_RESET = "EducateMediator:ON_GAME_RESET"
EducateMediator.ENTER_VIRTUAL_STAGE = "EducateMediator.ENTER_VIRTUAL_STAGE"

function EducateMediator:register()
	self:bind(EducateMediator.ON_DEFAULT_TARGET_SET, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_SET_TARGET, {
			id = arg_2_1.id,
			callback = arg_2_1.callback
		})

		return
	end)
	self:bind(EducateMediator.ON_UPGRADE_FAVOR, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.EDUCATE_UPGRADE_FAVOR, {
			callback = arg_3_1
		})

		return
	end)
	self:bind(EducateMediator.ON_SPECIAL_EVENT_TRIGGER, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.EDUCATE_TRIGGER_SPEC_EVENT, {
			eventId = arg_4_1.id,
			callback = arg_4_1.callback
		})

		return
	end)
	self:bind(EducateMediator.ON_EVENT_TRIGGER, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.EDUCATE_TRIGGER_EVENT, {
			eventId = arg_5_1.id,
			callback = arg_5_1.callback
		})

		return
	end)
	self:bind(EducateMediator.ON_GET_EVENT, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.EDUCATE_GET_EVENTS, {
			callback = arg_6_1
		})

		return
	end)
	self:bind(EducateMediator.ON_EXECTUE_PLANS, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.EDUCATE_EXECUTE_PLANS, {
			callback = arg_7_1
		})

		return
	end)
	self:bind(EducateMediator.ON_ENDING_TRIGGER, function(arg_8_0, arg_8_1)
		self:addSubLayers(Context.New({
			mediator = EducateSelEndingMediator,
			viewComponent = EducateSelEndingLayer
		}))

		return
	end)
	self:bind(EducateMediator.ON_GAME_RESET, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.EDUCATE_RESET)

		return
	end)
	self:bind(EducateMediator.ENTER_VIRTUAL_STAGE, function(arg_10_0, arg_10_1)
		self.viewComponent:updateResPanel()
		self.viewComponent:updatePaintingUI()
		self.viewComponent:updateArchivePanel()
		self.viewComponent:PlayBGM()

		return
	end)

	return
end

function EducateMediator:listNotificationInterests()
	return {
		EducateProxy.RESOURCE_UPDATED,
		EducateProxy.ATTR_UPDATED,
		EducateProxy.TIEM_UPDATED,
		EducateProxy.TIME_WEEKDAY_UPDATED,
		EducateProxy.BUFF_ADDED,
		EducateTaskProxy.TASK_UPDATED,
		GAME.EDUCATE_UPGRADE_FAVOR_DONE,
		GAME.EDUCATE_TRIGGER_SPEC_EVENT_DONE,
		GAME.EDUCATE_TRIGGER_EVENT_DONE,
		GAME.EDUCATE_SET_TARGET_DONE,
		GAME.EDUCATE_TRIGGER_END_DONE,
		GAME.EDUCATE_RESET_DONE,
		GAME.EDUCATE_REFRESH_DONE,
		GAME.EDUCATE_EXECUTE_PLANS_DONE,
		GAME.EDUCATE_SUBMIT_TASK_DONE,
		GAME.EDUCATE_GET_TARGET_AWARD_DONE,
		EducateProxy.GUIDE_CHECK,
		EducateProxy.MAIN_SCENE_ADD_LAYER,
		EducateProxy.POLAROID_ADDED,
		EducateProxy.MEMORY_ADDED,
		EducateTaskProxy.TASK_ADDED,
		EducateTaskProxy.TASK_REMOVED,
		EducateProxy.CLEAR_NEW_TIP
	}
end

function EducateMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()

	if var_12_0 == EducateProxy.RESOURCE_UPDATED then
		self.viewComponent:updateResPanel()
		self.viewComponent:updateTargetPanel()
	elseif var_12_0 == EducateProxy.ATTR_UPDATED then
		self.viewComponent:updateArchivePanel()
		self.viewComponent:updateTargetPanel()
	elseif var_12_0 == EducateProxy.TIEM_UPDATED then
		self.viewComponent:updateDatePanel()
		self.viewComponent:updateTargetPanel()
		self.viewComponent:updatePaintingData()
	elseif var_12_0 == EducateProxy.TIME_WEEKDAY_UPDATED then
		self.viewComponent:updateWeekDay(var_12_1.weekDay)
	elseif var_12_0 == EducateProxy.BUFF_ADDED then
		self.viewComponent:updateArchivePanel()

		if not pg.NewStoryMgr.GetInstance():IsPlayed("tb_10") then
			self.viewComponent:showArchivePanel()
		end

		self.viewComponent:OnCheckGuide()
	elseif var_12_0 == EducateTaskProxy.TASK_UPDATED then
		self.viewComponent:updateTargetPanel()
	elseif var_12_0 == GAME.EDUCATE_UPGRADE_FAVOR_DONE then
		self.viewComponent:ShowFavorUpgrade(var_12_1.drops, var_12_1.performs, var_12_1.cb)
	elseif var_12_0 == GAME.EDUCATE_TRIGGER_SPEC_EVENT_DONE then
		if var_12_1.type == EducateSpecialEvent.TYPE_BUBBLE_MIND or var_12_1.type == EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT then
			self.viewComponent:ShowSpecialEvent(var_12_1.id, var_12_1.drops, var_12_1.cb)
		end
	elseif var_12_0 == GAME.EDUCATE_TRIGGER_EVENT_DONE then
		if pg.child_event[var_12_1.id].type == EducateEvent.TYPE_BUBBLE then
			self.viewComponent:ShowEvent(var_12_1.id, var_12_1.drops, var_12_1.cb)
		end
	elseif var_12_0 == GAME.EDUCATE_SET_TARGET_DONE then
		self:addSubLayers(Context.New({
			mediator = EducateTargetMediator,
			viewComponent = EducateTargetLayer
		}))
		self.viewComponent:updateBottomPanel()
		self.viewComponent:updateDatePanel()
		self.viewComponent:updateTargetPanel()
		self.viewComponent:updateMindTip()
		self.viewComponent:OnCheckGuide()
	elseif var_12_0 == GAME.EDUCATE_TRIGGER_END_DONE then
		self.viewComponent:updateBottomPanel()
		self.viewComponent:updateDatePanel()
		self.viewComponent:updateTargetPanel()
		self.viewComponent:updateMindTip()
		self.viewComponent:OnCheckGuide()
	elseif var_12_0 == GAME.EDUCATE_RESET_DONE or var_12_0 == GAME.EDUCATE_REFRESH_DONE then
		self.viewComponent:emit(EducateBaseUI.EDUCATE_CHANGE_SCENE, SCENE.EDUCATE)
	elseif var_12_0 == GAME.EDUCATE_EXECUTE_PLANS_DONE then
		self:playPlansPerform(var_12_1.isSkip, var_12_1.isSkipEvent, var_12_1)
	elseif var_12_0 == GAME.EDUCATE_SUBMIT_TASK_DONE then
		self.viewComponent:updateTargetPanel()
		self.viewComponent:updateMindTip()
	elseif var_12_0 == GAME.EDUCATE_GET_TARGET_AWARD_DONE then
		self.viewComponent:updateTargetPanel()
	elseif var_12_0 == EducateProxy.GUIDE_CHECK then
		if var_12_1.view == self.viewComponent.__cname then
			self.viewComponent:OnCheckGuide(function()
				if var_12_1.popActivityWindow == true then
					if getProxy(EducateProxy):IsFirstGame() == 1 then
						local var_13_0 = {
							mediator = CultivatingPlantMediator,
							viewComponent = CultivatingPlantScene
						}
						local var_13_1 = {}

						var_13_1.id = getProxy(EducateProxy):GetCharData().id
						var_13_0.data = var_13_1

						self:addSubLayers(Context.New(var_13_0))
					end
				end

				return
			end)
		end
	elseif var_12_0 == EducateProxy.MAIN_SCENE_ADD_LAYER then
		self:addSubLayers(var_12_1)
	elseif var_12_0 == EducateProxy.POLAROID_ADDED or var_12_0 == EducateProxy.MEMORY_ADDED then
		self.viewComponent:updateBookNewTip()
	elseif var_12_0 == EducateTaskProxy.TASK_ADDED or var_12_0 == EducateTaskProxy.TASK_REMOVED then
		self.viewComponent:updateMindNewTip()
		self.viewComponent:updateTargetPanel()
	elseif var_12_0 == EducateProxy.CLEAR_NEW_TIP then
		if var_12_1.index == EducateTipHelper.NEW_MEMORY or var_12_1.index == EducateTipHelper.NEW_POLAROID then
			self.viewComponent:updateBookNewTip()
		elseif var_12_1.index == EducateTipHelper.NEW_MIND_TASK then
			self.viewComponent:updateMindNewTip()
		end
	end

	return
end

function EducateMediator:playPlansPerform(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	table.insert(var_14_0, function(arg_15_0)
		self:addSubLayers(Context.New({
			viewComponent = EducateCalendarLayer,
			mediator = EducateCalendarMediator,
			data = {
				onExit = arg_15_0
			}
		}))

		return
	end)

	if not arg_14_1 or not arg_14_2 then
		table.insert(var_14_0, function(arg_16_0)
			self:addSubLayers(Context.New({
				viewComponent = EducateSchedulePerformLayer,
				mediator = EducateSchedulePerformMediator,
				data = {
					gridData = arg_14_3.gridData,
					plan_results = arg_14_3.plan_results,
					events = arg_14_3.events,
					skip = arg_14_1,
					skipEvent = arg_14_2,
					onExit = arg_16_0
				}
			}))

			return
		end)
	end

	table.insert(var_14_0, function(arg_17_0)
		self:addSubLayers(Context.New({
			viewComponent = EducateScheduleResultLayer,
			mediator = EducateScheduleResultMediator,
			data = {
				plan_results = arg_14_3.plan_results,
				onExit = arg_17_0
			}
		}))

		return
	end)
	seriesAsync(var_14_0, function()
		self.viewComponent:FlushView()

		return
	end)

	return
end

return EducateMediator
