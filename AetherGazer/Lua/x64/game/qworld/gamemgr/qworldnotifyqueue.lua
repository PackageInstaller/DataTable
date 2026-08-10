local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init(arg_1_0)
	arg_1_0.rewardListQueue_ = {}
	arg_1_0.criticalRewardListQueue_ = {}
	arg_1_0.mainQuestIdFinishQueue_ = {}
	arg_1_0.mainQuestIdNewQueue_ = {}
	arg_1_0.mainQuestIdUpdateQueue_ = {}
	arg_1_0.openFunctionIdQueue_ = {}
	arg_1_0.nextNotifyTime_ = -1
	arg_1_0.questUnlockView_ = QWorldQuestUnlockView.New()
	arg_1_0.questFinishView_ = QWorldQuestFinishView.New()
	arg_1_0.rewardView_ = QWorldRewardView.New()
	arg_1_0.openFunctionView_ = QWorldFunctionOpenView.New()
	arg_1_0.notShowRewardItemIds_ = {
		77
	}
	arg_1_0.destroyHandle = handler(arg_1_0, arg_1_0.OnDisposeLua)

	manager.notify:RegistListener(ON_DESTROY_LUA, function()
		arg_1_0:OnDisposeLua()
	end)

	var_0_1 = true
end

function var_0_0.OnDisposeLua(arg_3_0)
	arg_3_0:Dispose()
end

function var_0_0.Dispose(arg_4_0)
	if var_0_1 then
		manager.notify:RemoveListener(ON_DESTROY_LUA, arg_4_0.destroyHandle)
		arg_4_0.questUnlockView_:Dispose()

		arg_4_0.questUnlockView_ = nil

		arg_4_0.questFinishView_:Dispose()

		arg_4_0.questFinishView_ = nil

		arg_4_0.rewardView_:Dispose()

		arg_4_0.rewardView_ = nil

		arg_4_0.openFunctionView_:Dispose()

		arg_4_0.openFunctionView_ = nil
		arg_4_0.notShowRewardItemIds_ = nil
	end

	var_0_1 = false
end

function var_0_0.HasNotifies(arg_5_0)
	return arg_5_0.isShowing_ or #arg_5_0.rewardListQueue_ > 0 or #arg_5_0.criticalRewardListQueue_ > 0 or #arg_5_0.mainQuestIdFinishQueue_ > 0 or #arg_5_0.mainQuestIdNewQueue_ > 0 or #arg_5_0.openFunctionIdQueue_ > 0 or #arg_5_0.mainQuestIdUpdateQueue_ > 0
end

function var_0_0.HasQuestFinishOrNew(arg_6_0)
	return #arg_6_0.mainQuestIdFinishQueue_ > 0 or #arg_6_0.mainQuestIdNewQueue_ > 0
end

function var_0_0.UpdateNotifies(arg_7_0)
	if arg_7_0.nextNotifyTime_ > Time.time or manager.guide:IsPlaying() then
		return
	end

	if arg_7_0.rewardView_.gameObject_ and arg_7_0.rewardView_.gameObject_.activeSelf then
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
	local var_7_2 = var_7_0.rewardSideView_

	arg_7_0.questUnlockView_:Hide()
	arg_7_0.questFinishView_:Hide()
	arg_7_0.rewardView_:Hide()
	arg_7_0.openFunctionView_:Hide()

	arg_7_0.isShowing_ = false

	if #arg_7_0.criticalRewardListQueue_ > 0 then
		arg_7_0.rewardView_:SetData(arg_7_0.criticalRewardListQueue_)
		arg_7_0.rewardView_:Show()

		arg_7_0.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_reward.value[1] / 1000
		arg_7_0.isShowing_ = true

		return
	end

	while #arg_7_0.openFunctionIdQueue_ > 0 do
		local var_7_3 = SandPlayFunctionOpenCfg.get_id_list_by_task_id[arg_7_0.openFunctionIdQueue_[1]]
		local var_7_4 = var_7_3 and var_7_3[1]
		local var_7_5 = var_7_4 and SandPlayFunctionOpenCfg[var_7_4]

		table.remove(arg_7_0.openFunctionIdQueue_, 1)

		if var_7_5 and (var_7_5.map_id == 0 or var_7_5.map_id == QWorldData:GetCurMapId()) and IsConditionAchieved(var_7_5.condition_id) and not QWorldData:IsUnlockFunction(var_7_4) then
			arg_7_0.openFunctionView_:SetData(var_7_5)
			arg_7_0.openFunctionView_:Show()

			arg_7_0.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_unlock.value[1] / 1000
			arg_7_0.isShowing_ = true

			return
		end
	end

	if #arg_7_0.rewardListQueue_ > 0 then
		var_7_2:InsertRewards(arg_7_0.rewardListQueue_)

		arg_7_0.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_reward.value[1] / 1000
		arg_7_0.isShowing_ = true
	end

	while #arg_7_0.mainQuestIdFinishQueue_ > 0 do
		local var_7_6 = arg_7_0.mainQuestIdFinishQueue_[1]

		table.remove(arg_7_0.mainQuestIdFinishQueue_, 1)

		local var_7_7 = SandplayTaskMainCfg[var_7_6]

		if var_7_7.hide_task == 0 then
			if var_7_7.chapter_task_id ~= 0 then
				local var_7_8 = SandplayTaskMainCfg.get_id_list_by_chapter_task_id[var_7_7.chapter_task_id]

				if var_7_8[#var_7_8] == var_7_6 then
					arg_7_0.questFinishView_:SetData(var_7_6)
					arg_7_0.questFinishView_:Show()
				end
			end

			var_7_1:ShowMainQuestsFinish(var_7_6)

			arg_7_0.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_task_complete.value[1] / 1000
			arg_7_0.isShowing_ = true

			break
		end
	end

	if arg_7_0.isShowing_ then
		return
	end

	if var_7_2:IsShowing() then
		return
	end

	while #arg_7_0.mainQuestIdNewQueue_ > 0 do
		local var_7_9 = arg_7_0.mainQuestIdNewQueue_[1]

		table.remove(arg_7_0.mainQuestIdNewQueue_, 1)

		if SandplayTaskMainCfg[var_7_9].hide_task == 0 then
			var_7_1:ShowMainQuestsNew(var_7_9)

			arg_7_0.nextNotifyTime_ = Time.time + SandplaySettingCfg.pop_task_new.value[1] / 1000
			arg_7_0.isShowing_ = true

			return
		end
	end

	while #arg_7_0.mainQuestIdUpdateQueue_ > 0 do
		local var_7_10 = arg_7_0.mainQuestIdUpdateQueue_[1]

		table.remove(arg_7_0.mainQuestIdUpdateQueue_, 1)

		local var_7_11 = SandplayTaskMainCfg[var_7_10]

		if var_7_10 == -1 or var_7_11.hide_task == 0 then
			var_7_1:OnQWorldMainQuestUpdate(var_7_10)

			arg_7_0.isShowing_ = true

			return
		end
	end

	var_7_1:OnNotifyQueueEnd()
end

function var_0_0.ImmediatelyNextNotifies(arg_8_0)
	arg_8_0.nextNotifyTime_ = Time.time
end

function var_0_0.HideNotifies(arg_9_0)
	if not arg_9_0.isInit then
		return
	end

	if arg_9_0.questUnlockView_ then
		arg_9_0.questUnlockView_:Hide()
	end

	if arg_9_0.questFinishView_ then
		arg_9_0.questFinishView_:Hide()
	end

	if arg_9_0.openFunctionView_ then
		arg_9_0.openFunctionView_:Hide()
	end

	arg_9_0.nextNotifyTime_ = -1
end

function var_0_0.OnQueueUpdate(arg_10_0)
	if var_0_1 then
		manager.notify:CallUpdateFunc("OnQWorldMainQueueUpdate")
	end
end

function var_0_0.GetRewards(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if not table.indexof(arg_11_0.notShowRewardItemIds_, iter_11_1.id) then
			table.insert(arg_11_0.rewardListQueue_, iter_11_1)
		end
	end

	arg_11_0.rewardListQueue_ = mergeReward(arg_11_0.rewardListQueue_)

	arg_11_0:OnQueueUpdate()
end

function var_0_0.GetCriticalRewards(arg_12_0, arg_12_1)
	table.insertto(arg_12_0.criticalRewardListQueue_, arg_12_1)

	arg_12_0.criticalRewardListQueue_ = mergeReward(arg_12_0.criticalRewardListQueue_)

	arg_12_0:OnQueueUpdate()
end

function var_0_0.MainQuestsFinish(arg_13_0, arg_13_1)
	table.insertto(arg_13_0.mainQuestIdFinishQueue_, arg_13_1)
	table.insertto(arg_13_0.openFunctionIdQueue_, arg_13_1)
	arg_13_0:OnQueueUpdate()
end

function var_0_0.MainQuestsNew(arg_14_0, arg_14_1)
	table.insert(arg_14_0.mainQuestIdNewQueue_, arg_14_1)
	table.sort(arg_14_0.mainQuestIdNewQueue_, function(arg_15_0, arg_15_1)
		local var_15_0 = SandplayTaskMainCfg[arg_15_0]
		local var_15_1 = SandplayTaskMainCfg[arg_15_1]

		if var_15_0.main_task_type ~= var_15_1.main_task_type then
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
	arg_14_0:OnQueueUpdate()
end

function var_0_0.MainQuestUpdate(arg_16_0, arg_16_1)
	table.removebyvalue(arg_16_0.mainQuestIdUpdateQueue_, arg_16_1)
	table.insert(arg_16_0.mainQuestIdUpdateQueue_, arg_16_1)
	arg_16_0:OnQueueUpdate()
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

function var_0_0.SubQuestFinish(arg_20_0, arg_20_1)
	table.insert(arg_20_0.openFunctionIdQueue_, arg_20_1)
	arg_20_0:OnQueueUpdate()
end

return var_0_0
