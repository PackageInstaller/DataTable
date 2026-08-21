local var_0_0 = class("Island3dTaskTrackPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "Island3dTaskTrackPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uiAnim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.uiAnimEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.uiAnimEvent:SetEndEvent(function()
		arg_2_0:Hide()

		return
	end)

	arg_2_0.mainTrackCard = IslandTaskTrackCard.New(arg_2_0._tf:Find("content"), arg_2_0.event, IslandTaskTrackCard.TYPES.MAIN)
	arg_2_0.otherTrackCard = IslandTaskTrackCard.New(arg_2_0._tf:Find("other_content"), arg_2_0.event, IslandTaskTrackCard.TYPES.OTHER)

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0.mainTrackCard._tf, function()
		if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.MOVE_TASK_ID) then
			return
		end

		arg_4_0:emit(IslandMediator.OPEN_PAGE, "Island3dTaskPage", {
			0,
			arg_4_0.mainTask.id
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.otherTrackCard._tf, function()
		if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.MOVE_TASK_ID) then
			return
		end

		arg_4_0:emit(IslandMediator.OPEN_PAGE, "Island3dTaskPage", {
			0,
			arg_4_0.otherTask.id
		})

		return
	end, SFX_PANEL)

	arg_4_0.unlock = getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[2])

	return
end

function var_0_0.Show(arg_7_0)
	setActive(arg_7_0._tf, arg_7_0.unlock)
	arg_7_0:ShowOrHideResUI(true)
	arg_7_0:PlayBGM()
	arg_7_0:UpdataAllTask()

	return
end

function var_0_0.UpdataAllTask(arg_8_0)
	arg_8_0.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()

	if not arg_8_0.mainTask then
		arg_8_0.mainTrackCard:UnTrackUI()
	end

	arg_8_0.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

	if not arg_8_0.otherTask then
		arg_8_0.otherTrackCard:UnTrackUI()
	end

	if not arg_8_0.mainTask and not arg_8_0.otherTask then
		return
	end

	if arg_8_0.unlock then
		arg_8_0.uiAnim:Play("Island3dTaskTrackPanel_in")
	end

	arg_8_0:UpdateTask(IslandTaskTrackCard.TYPES.MAIN)
	arg_8_0:UpdateTask(IslandTaskTrackCard.TYPES.OTHER)

	return
end

function var_0_0.UpdateTask(arg_9_0, arg_9_1)
	if arg_9_1 == IslandTaskTrackCard.TYPES.MAIN then
		arg_9_0.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()

		arg_9_0.mainTrackCard:Update(arg_9_0.mainTask, arg_9_0.unlock)
	elseif arg_9_1 == IslandTaskTrackCard.TYPES.OTHER then
		arg_9_0.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

		arg_9_0.otherTrackCard:Update(arg_9_0.otherTask, arg_9_0.unlock)
	end

	return
end

function var_0_0.UpdateProgress(arg_10_0, arg_10_1)
	if arg_10_1 == IslandTaskTrackCard.TYPES.MAIN then
		arg_10_0.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()

		if arg_10_0.mainTask then
			arg_10_0.mainTrackCard:UpdateProgress(arg_10_0.mainTask)
		end
	elseif arg_10_1 == IslandTaskTrackCard.TYPES.OTHER then
		arg_10_0.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

		if arg_10_0.otherTask then
			arg_10_0.otherTrackCard:UpdateProgress(arg_10_0.otherTask)
		end
	end

	return
end

function var_0_0.RemoveTask(arg_11_0, arg_11_1)
	if arg_11_1 == IslandTaskTrackCard.TYPES.MAIN then
		arg_11_0.mainTrackCard:RemoveTask()
	elseif arg_11_1 == IslandTaskTrackCard.TYPES.OTHER then
		arg_11_0.otherTrackCard:RemoveTask()
	end

	arg_11_0:emit(IslandMediator.ON_SET_TRACE_ID, 0, arg_11_1)

	arg_11_0.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()
	arg_11_0.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

	if not arg_11_0.mainTask and not arg_11_0.otherTask then
		arg_11_0:Hide()
	end

	return
end

function var_0_0.SetUnlock(arg_12_0)
	arg_12_0.unlock = true

	if arg_12_0.mainTask then
		arg_12_0.mainTrackCard:Update(arg_12_0.mainTask, arg_12_0.unlock)
	end

	if arg_12_0.otherTask then
		arg_12_0.otherTrackCard:Update(arg_12_0.otherTask, arg_12_0.unlock)
	end

	return
end

function var_0_0.Hide(arg_13_0)
	var_0_0.super.Hide(arg_13_0)
	arg_13_0.mainTrackCard:UnTrackUI()
	arg_13_0.otherTrackCard:UnTrackUI()

	return
end

function var_0_0.OnDestroy(arg_14_0)
	arg_14_0.uiAnimEvent:SetEndEvent(nil)
	arg_14_0.mainTrackCard:Dispose()

	arg_14_0.mainTrackCard = nil

	arg_14_0.otherTrackCard:Dispose()

	arg_14_0.otherTrackCard = nil

	return
end

return var_0_0
