local BossRushVerSardiniaSPMediator = class("BossRushVerSardiniaSPMediator", import("view.base.ContextMediator"))

BossRushVerSardiniaSPMediator.ON_FLEET_SELECT = "BossRushVerSardiniaSPMediator.ON_FLEET_SELECT"
BossRushVerSardiniaSPMediator.ON_EXTRA_RANK = "BossRushVerSardiniaSPMediator.ON_EXTRA_RANK"
BossRushVerSardiniaSPMediator.ON_TASK_SUBMIT = "BossRushVerSardiniaSPMediator.ON_TASK_SUBMIT"
BossRushVerSardiniaSPMediator.ON_PERFORM_COMBAT = "BossRushVerSardiniaSPMediator.ON_PERFORM_COMBAT"
BossRushVerSardiniaSPMediator.ON_ACTIVITY_UNLOCKSTOIRY = "BossRushVerSardiniaSPMediator.ON_ACTIVITY_UNLOCKSTOIRY"
BossRushVerSardiniaSPMediator.GO_SUBLAYER = "BossRushVerSardiniaSPMediator.GO_SUBLAYER"
BossRushVerSardiniaSPMediator.GO_SCENE = "BossRushVerSardiniaSPMediator.GO_SCENE"

function BossRushVerSardiniaSPMediator:register()
	self:bind(BossRushVerSardiniaSPMediator.ON_ACTIVITY_UNLOCKSTOIRY, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.ACTIVITY_UNLOCKSTORY, {
			cmd = 1,
			activity_id = arg_2_1,
			arg1 = arg_2_2
		})

		return
	end)
	self:bind(BossRushVerSardiniaSPMediator.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	self:bind(BossRushVerSardiniaSPMediator.GO_SCENE, function(arg_4_0, arg_4_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_4_1, ...)

		return
	end)
	self:bind(BossRushVerSardiniaSPMediator.ON_FLEET_SELECT, function(arg_5_0, arg_5_1)
		BossRushVerZenkerPassedLayer.seriesId = arg_5_1.configId

		self:addSubLayers(Context.New({
			mediator = BossRushFleetSelectMediator,
			viewComponent = BossRushSardiniaFleetSelectView,
			data = {
				seriesData = arg_5_1
			}
		}))

		return
	end)
	self:bind(BossRushVerSardiniaSPMediator.ON_EXTRA_RANK, function(arg_6_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)
	self:bind(BossRushVerSardiniaSPMediator.ON_PERFORM_COMBAT, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_7_1,
			exitCallback = arg_7_2
		})

		return
	end)
	self:bind(BossRushVerSardiniaSPMediator.ON_TASK_SUBMIT, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_8_1.id)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)
	local var_1_1 = var_1_0:getActivityById(self.contextData.activityID)

	self.viewComponent:SetActivity(var_1_1)

	local var_1_2 = var_1_1:GetConfigClientSetting("activity_ids")

	self.contextData.activityStoryID = var_1_2.story

	self.viewComponent:SetStoryActivity((var_1_0:getActivityById(self.contextData.activityStoryID)))

	self.contextData.activityPTID = var_1_2.pt

	self.viewComponent:SetPtActivity((var_1_0:getActivityById(self.contextData.activityPTID)))

	self.contextData.activityTaskID = var_1_2.tasks

	self.viewComponent:SetTasksActivity((var_1_0:getActivityById(self.contextData.activityTaskID)))
	self.viewComponent:addbubbleMsgBox(function(arg_9_0)
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushTotalRewardPanelMediator) then
			return
		end

		arg_9_0()

		return
	end)
	self.viewComponent:addbubbleMsgBox(function(arg_10_0)
		pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_10_0)

		return
	end)

	return
end

function BossRushVerSardiniaSPMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_STORYUNLOCKED_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_AWARD_DOWN,
		GAME.BEGIN_STAGE_DONE,
		BossRushTotalRewardPanelMediator.ON_WILL_EXIT
	}
end

function BossRushVerSardiniaSPMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()
	local var_12_2 = arg_12_1:getType()

	if var_12_0 == GAME.ACTIVITY_STORYUNLOCKED_DONE then
		self.viewComponent:UpdataStoryState(var_12_1.storyId)
	elseif var_12_0 == GAME.BEGIN_STAGE_DONE then
		if not getProxy(ContextProxy):getContextByMediator(BossRushPreCombatMediator) then
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_12_1)
		end
	elseif var_12_0 == ActivityProxy.ACTIVITY_UPDATED then
		local var_12_3 = var_12_1

		switch(var_12_1.id, {
			[self.contextData.activityID] = function()
				self.viewComponent:SetActivity(var_12_3)
				self.viewComponent:UpdateView()

				return
			end,
			[self.contextData.activityPTID] = function()
				self.viewComponent:SetPtActivity(var_12_3)
				self.viewComponent:UpdateView()

				return
			end,
			[self.contextData.activityStoryID] = function()
				self.viewComponent:SetStoryActivity(var_12_3)

				return
			end
		})
	elseif var_12_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		local var_12_4 = {}

		if #var_12_1.awards > 0 then
			table.insert(var_12_4, function(arg_16_0)
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_12_1.awards, arg_16_0)

				return
			end)
		end

		seriesAsync(var_12_4, function()
			self.viewComponent:UpdateView()

			return
		end)
	elseif var_12_0 == BossRushTotalRewardPanelMediator.ON_WILL_EXIT then
		self.contextData.showFlash = true

		self.viewComponent:resumeBubble()
		self.viewComponent:UpdateView()
	end

	return
end

function BossRushVerSardiniaSPMediator:remove()
	return
end

return BossRushVerSardiniaSPMediator
