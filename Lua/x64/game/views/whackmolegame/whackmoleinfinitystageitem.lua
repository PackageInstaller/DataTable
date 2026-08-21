local var_0_0 = import("game.views.whackMoleGame.WhackMoleStageItem")
local var_0_1 = class("WhackMoleInfinityStageItem", var_0_0)

function var_0_1.RefreshState(arg_1_0)
	local var_1_0 = WhackMoleData:GetStageScore(arg_1_0.whackMoleID_)

	if WhackMoleTools.GetStageIsLock(arg_1_0.whackMoleID_) then
		arg_1_0.state_ = WhackMoleConst.STAGE_STATE.LOCK
	elseif var_1_0 > 0 then
		arg_1_0.state_ = WhackMoleConst.STAGE_STATE.UNLOCK
		arg_1_0.score_.text = var_1_0
	else
		arg_1_0.state_ = WhackMoleConst.STAGE_STATE.UNLOCK
		arg_1_0.score_.text = GetTips("ACTIVITY_ZUMA_NO_DATA")
	end

	arg_1_0.stateController_:SetSelectedState(arg_1_0.state_)
end

return var_0_1
