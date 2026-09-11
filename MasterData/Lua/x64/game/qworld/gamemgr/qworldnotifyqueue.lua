local var_0_0 = {}
local var_0_1 = false

function var_0_0:Init()
	self.rewardListQueue_ = {}
	self.criticalRewardListQueue_ = {}
	self.mainQuestIdFinishQueue_ = {}
	self.mainQuestIdNewQueue_ = {}
	self.mainQuestIdUpdateQueue_ = {}
	self.openFunctionIdQueue_ = {}
	self.nextNotifyTime_ = -1
	self.questUnlockView_ = QWorldQuestUnlockView.New()
	self.questFinishView_ = QWorldQuestFinishView.New()
	self.rewardView_ = QWorldRewardView.New()
	self.openFunctionView_ = QWorldFunctionOpenView.New()
	self.notShowRewardItemIds_ = {
		77
	}
	self.destroyHandle = handler(self, self.OnDisposeLua)

	manager.notify:RegistListener(ON_DESTROY_LUA, function()
		self:OnDisposeLua()
	end)

	var_0_1 = true
end

function var_0_0:OnDisposeLua()
	self:Dispose()
end

function var_0_0:Dispose()
	if var_0_1 then
		manager.notify:RemoveListener(ON_DESTROY_LUA, self.destroyHandle)
		self.questUnlockView_:Dispose()

		self.questUnlockView_ = nil

		self.questFinishView_:Dispose()

		self.questFinishView_ = nil

		self.rewardView_:Dispose()

		self.rewardView_ = nil

		self.openFunctionView_:Dispose()

		self.openFunctionView_ = nil
		self.notShowRewardItemIds_ = nil
	end

	var_0_1 = false
end

function var_0_0:HasNotifies()
	return self.isShowing_ or #self.rewardListQueue_ > 0 or #self.criticalRewardListQueue_ > 0 or #self.mainQuestIdFinishQueue_ > 0 or #self.mainQuestIdNewQueue_ > 0 or #self.openFunctionIdQueue_ > 0 or #self.mainQuestIdUpdateQueue_ > 0
end

function var_0_0:HasQuestFinishOrNew()
	return #self.mainQuestIdFinishQueue_ > 0 or #self.mainQuestIdNewQueue_ > 0
end

function var_0_0:UpdateNotifies()
	if self.nextNotifyTime_ > Time.time or manager.guide:IsPlaying() then
		return
	end

	if self.rewardView_.gameObject_ and self.rewardView_.gameObject_.activeSelf then
		return
	end

	if QWorldMgr:GetQWorldQuestMgr():IsSendingQuestParamUpdateOrFinish() then
		return
	end

	local var_7_0 = gameContext:GetOpenPageHandler("qworldMainHome")

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.questSideView_

	self.questUnlockView_:Hide()
	self.questFinishView_:Hide()
	self.rewardView_:Hide()
	self.openFunctionView_:Hide()

	self.isShowing_ = false

	if #self.criticalRewardListQueue_ > 0 then
		self.rewardView_:SetData(self.criticalRewardListQueue_)
		self.rewardView_:Show()

		self.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_reward.value[1] / 1000
		self.isShowing_ = true

		return
	end

	while #self.openFunctionIdQueue_ > 0 do
		local var_7_2 = SandPlayFunctionOpenCfg.get_id_list_by_task_id[self.openFunctionIdQueue_[1]] and SandPlayFunctionOpenCfg.get_id_list_by_task_id[self.openFunctionIdQueue_[1]][1]
		local var_7_3 = SandPlayFunctionOpenCfg.get_id_list_by_task_id[self.openFunctionIdQueue_[1]] and SandPlayFunctionOpenCfg.get_id_list_by_task_id[self.openFunctionIdQueue_[1]][1] and SandPlayFunctionOpenCfg[var_7_2]

		table.remove(self.openFunctionIdQueue_, 1)

		if var_7_3 and (var_7_3.map_id == 0 or var_7_3.map_id == QWorldData:GetCurMapId()) and IsConditionAchieved(var_7_3.condition_id) and not QWorldData:IsUnlockFunction(var_7_2) then
			self.openFunctionView_:SetData(var_7_3)
			self.openFunctionView_:Show()

			self.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_unlock.value[1] / 1000
			self.isShowing_ = true

			return
		end
	end

	if #self.rewardListQueue_ > 0 then
		var_7_0.rewardSideView_:InsertRewards(self.rewardListQueue_)

		self.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_reward.value[1] / 1000
		self.isShowing_ = true
	end

	while #self.mainQuestIdFinishQueue_ > 0 do
		table.remove(self.mainQuestIdFinishQueue_, 1)

		if SandplayTaskMainCfg[self.mainQuestIdFinishQueue_[1]].hide_task == 0 then
			if SandplayTaskMainCfg[self.mainQuestIdFinishQueue_[1]].chapter_task_id ~= 0 and SandplayTaskMainCfg.get_id_list_by_chapter_task_id[SandplayTaskMainCfg[self.mainQuestIdFinishQueue_[1]].chapter_task_id][#SandplayTaskMainCfg.get_id_list_by_chapter_task_id[SandplayTaskMainCfg[self.mainQuestIdFinishQueue_[1]].chapter_task_id]] == self.mainQuestIdFinishQueue_[1] then
				self.questFinishView_:SetData(self.mainQuestIdFinishQueue_[1])
				self.questFinishView_:Show()
			end

			var_7_1:ShowMainQuestsFinish(self.mainQuestIdFinishQueue_[1])

			self.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_task_complete.value[1] / 1000
			self.isShowing_ = true

			break
		end
	end

	if self.isShowing_ then
		return
	end

	if var_7_0.rewardSideView_:IsShowing() then
		return
	end

	while #self.mainQuestIdNewQueue_ > 0 do
		table.remove(self.mainQuestIdNewQueue_, 1)

		if SandplayTaskMainCfg[self.mainQuestIdNewQueue_[1]].hide_task == 0 then
			var_7_1:ShowMainQuestsNew(self.mainQuestIdNewQueue_[1])

			self.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_task_new.value[1] / 1000
			self.isShowing_ = true

			return
		end
	end

	while #self.mainQuestIdUpdateQueue_ > 0 do
		table.remove(self.mainQuestIdUpdateQueue_, 1)

		if self.mainQuestIdUpdateQueue_[1] == -1 or SandplayTaskMainCfg[self.mainQuestIdUpdateQueue_[1]].hide_task == 0 then
			var_7_1:OnQWorldMainQuestUpdate(self.mainQuestIdUpdateQueue_[1])

			self.isShowing_ = true

			return
		end
	end

	var_7_1:OnNotifyQueueEnd()
end

function var_0_0.ImmediatelyNextNotifies(arg_8_0)
	arg_8_0.nextNotifyTime_ = Time.time
end

function var_0_0:HideNotifies()
	if not self.isInit then
		return
	end

	if self.questUnlockView_ then
		self.questUnlockView_:Hide()
	end

	if self.questFinishView_ then
		self.questFinishView_:Hide()
	end

	if self.openFunctionView_ then
		self.openFunctionView_:Hide()
	end

	self.nextNotifyTime_ = -1
end

function var_0_0.OnQueueUpdate(arg_10_0)
	if var_0_1 then
		manager.notify:CallUpdateFunc("OnQWorldMainQueueUpdate")
	end
end

function var_0_0:GetRewards(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if not table.indexof(self.notShowRewardItemIds_, iter_11_1.id) then
			table.insert(self.rewardListQueue_, iter_11_1)
		end
	end

	self.rewardListQueue_ = mergeReward(self.rewardListQueue_)

	self:OnQueueUpdate()
end

function var_0_0:GetCriticalRewards(arg_12_1)
	table.insertto(self.criticalRewardListQueue_, arg_12_1)

	self.criticalRewardListQueue_ = mergeReward(self.criticalRewardListQueue_)

	self:OnQueueUpdate()
end

function var_0_0:MainQuestsFinish(arg_13_1)
	table.insertto(self.mainQuestIdFinishQueue_, arg_13_1)
	table.insertto(self.openFunctionIdQueue_, arg_13_1)
	self:OnQueueUpdate()
end

function var_0_0:MainQuestsNew(arg_14_1)
	table.insert(self.mainQuestIdNewQueue_, arg_14_1)
	table.sort(self.mainQuestIdNewQueue_, function(arg_15_0, arg_15_1)
		local var_15_0 = SandplayTaskMainCfg[arg_15_0]
		local var_15_1 = SandplayTaskMainCfg[arg_15_1]

		if SandplayTaskMainCfg[arg_15_0].main_task_type ~= SandplayTaskMainCfg[arg_15_1].main_task_type then
			return var_15_0.main_task_type < var_15_1.main_task_type
		end

		if var_15_0.chapter_task_id ~= var_15_1.chapter_task_id then
			return var_15_0.chapter_task_id ~= 0
		end

		if var_15_0.priority ~= var_15_1.priority then
			return var_15_0.priority < var_15_1.priority
		end

		return var_15_0.main_task_id < var_15_1.main_task_id
	end)
	self:OnQueueUpdate()
end

function var_0_0:MainQuestUpdate(arg_16_1)
	table.removebyvalue(self.mainQuestIdUpdateQueue_, arg_16_1)
	table.insert(self.mainQuestIdUpdateQueue_, arg_16_1)
	self:OnQueueUpdate()
end

function var_0_0.ClearQuestNewQueue(arg_17_0)
	arg_17_0.mainQuestIdNewQueue_ = {}
end

function var_0_0.ClearInsignificantQueue(arg_18_0)
	arg_18_0.mainQuestIdNewQueue_ = {}
	arg_18_0.mainQuestIdFinishQueue_ = {}
	arg_18_0.rewardListQueue_ = {}
end

function var_0_0.ResetNotifyTime(arg_19_0)
	arg_19_0.nextNotifyTime_ = Time.time
end

function var_0_0:SubQuestFinish(arg_20_1)
	table.insert(self.openFunctionIdQueue_, arg_20_1)
	self:OnQueueUpdate()
end

return var_0_0
