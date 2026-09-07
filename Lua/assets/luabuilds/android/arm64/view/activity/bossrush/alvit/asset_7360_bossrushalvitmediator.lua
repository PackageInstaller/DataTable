local BossRushAlvitMediator = class("BossRushAlvitMediator", import("view.base.ContextMediator"))

BossRushAlvitMediator.ON_FLEET_SELECT = "BossRushAlvitMediator:ON_FLEET_SELECT"
BossRushAlvitMediator.ON_EXTRA_RANK = "BossRushAlvitMediator:ON_EXTRA_RANK"
BossRushAlvitMediator.ON_TASK_SUBMIT = "BossRushAlvitMediator:ON_TASK_SUBMIT"
BossRushAlvitMediator.ON_PERFORM_COMBAT = "BossRushAlvitMediator:ON_PERFORM_COMBAT"
BossRushAlvitMediator.GO_SUBLAYER = "BossRushAlvitMediator:GO_SUBLAYER"
BossRushAlvitMediator.GO_SCENE = "BossRushAlvitMediator:GO_SCENE"

function BossRushAlvitMediator:register()
	self:bind(BossRushAlvitMediator.GO_SUBLAYER, function(arg_2_0, arg_2_1, arg_2_2)
		self:addSubLayers(arg_2_1, nil, arg_2_2)

		return
	end)
	self:bind(BossRushAlvitMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(BossRushAlvitMediator.ON_FLEET_SELECT, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushAlvitFleetSelectView,
			data = {
				seriesData = arg_4_1
			}
		}))

		return
	end)
	self:bind(BossRushAlvitMediator.ON_EXTRA_RANK, function(arg_5_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)
	self:bind(BossRushAlvitMediator.ON_PERFORM_COMBAT, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_6_1,
			exitCallback = arg_6_2
		})

		return
	end)
	self:bind(BossRushAlvitMediator.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_7_1.id)

		return
	end)
	assert(self.contextData.activityID, "activityID is required by BossRushVerZenkerMediator")

	local var_1_0 = getProxy(ActivityProxy):getActivityById(self.contextData.activityID)

	self.viewComponent:SetActivity(var_1_0)
	self.viewComponent:SetActivity(var_1_0)

	local var_1_1 = var_1_0:GetConfigClientSetting("PTID")

	for iter_1_0, iter_1_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF))) do
		if iter_1_1:getDataConfig("pt") == var_1_1 then
			self.viewComponent:SetPtActivity(iter_1_1)

			break
		end
	end

	self.viewComponent:addbubbleMsgBox(function(arg_8_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_8_0()

		return
	end)
	self.viewComponent:addbubbleMsgBox(function(arg_9_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_9_0)

		return
	end)

	return
end

function BossRushAlvitMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT
	}
end

function BossRushAlvitMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()
	local var_11_2 = arg_11_1:getType()

	if var_11_0 == nil then
		-- block empty
	elseif var_11_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_11_1)
		end
	elseif var_11_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_11_1 then
			if var_11_1.id == self.contextData.activityID then
				self.viewComponent:SetActivity(var_11_1)
				self.viewComponent:UpdateView()
			elseif var_11_1.id == ActivityConst.ALVIT_PT_ACT_ID then
				self.viewComponent:SetPtActivity(var_11_1)
				self.viewComponent:UpdateView()
			end
		end
	elseif var_11_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ChildishnessSchoolTaskMediator) then
			self.viewComponent:UpdateTaskTip()
		else
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards, function()
				self.viewComponent:UpdateStoryTask()
				self.viewComponent:UpdateView()

				return
			end)
		end
	elseif var_11_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		self.viewComponent:resumeBubble()
		self.viewComponent:UpdateView()
	end

	return
end

function BossRushAlvitMediator:remove()
	return
end

return BossRushAlvitMediator
