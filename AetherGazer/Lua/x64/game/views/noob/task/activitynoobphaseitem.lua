local var_0_0 = class("ActivityNoobPhaseItem", ReduxView)
local var_0_1 = {
	"normal",
	"lock",
	"finish"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateCon_ = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.clickHandler_ = nil

	arg_2_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.isLock_ == true then
			ShowTips(string.format(GetTips("ACTIVITY_FIRST_UNLOCK_PROMPT"), arg_3_0.unLockDay_))
		end

		if arg_3_0.clickHandler_ then
			arg_3_0.clickHandler_(arg_3_0.phase_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:BindRedPoint(arg_5_2)

	arg_5_0.taskType_ = arg_5_1
	arg_5_0.phase_ = arg_5_2
	arg_5_0.titleText_.text = "0" .. arg_5_2
	arg_5_0.titleText2_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), arg_5_2)

	arg_5_0:RefreshState()
end

function var_0_0.BindRedPoint(arg_6_0, arg_6_1)
	if arg_6_0.phase_ == nil then
		manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_6_1))
	elseif arg_6_0.phase_ ~= arg_6_1 then
		manager.redPoint:unbindUIandKey(arg_6_0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_6_0.phase_))
		manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_6_1))
	end
end

function var_0_0.UnbindRedPoint(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_7_0.phase_))
end

function var_0_0.RefreshState(arg_8_0)
	local var_8_0 = arg_8_0:GetItemState()

	arg_8_0.stateCon_:SetSelectedState(var_8_0)
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController_:SetSelectedIndex(arg_9_0.phase_ == arg_9_1 and 1 or 0)
end

function var_0_0.GetItemState(arg_10_0)
	local var_10_0 = TaskTools:GetNoobTaskSortList(arg_10_0.taskType_, arg_10_0.phase_)
	local var_10_1 = ActivityNoobData:GetUnlockPhase()

	arg_10_0.isLock_ = false

	if var_10_1 < arg_10_0.phase_ then
		arg_10_0.unLockDay_ = arg_10_0.phase_ - var_10_1
		arg_10_0.isLock_ = true

		return var_0_1[2]
	else
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_2 = AssignmentCfg[iter_10_1.id]

			if iter_10_1.complete_flag < 1 then
				return var_0_1[1]
			end
		end
	end

	return var_0_1[3]
end

function var_0_0.SetClickHandler(arg_11_0, arg_11_1)
	arg_11_0.clickHandler_ = arg_11_1
end

return var_0_0
