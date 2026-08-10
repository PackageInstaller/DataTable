local var_0_0 = class("TetrisGameBlockSpaceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2
	arg_1_0.parent = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockStateController = arg_3_0.controller_:GetController("lock")
	arg_3_0.rotateStateController = arg_3_0.controller_:GetController("rotate")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.rotateBtn_, nil, function()
		TetrisGameRunTimeManager:RotateChip(arg_4_0.index)
	end)
	arg_4_0:AddBtnListener(arg_4_0.lockBtn_, nil, function()
		arg_4_0:OnClickLockBtn()
	end)
end

function var_0_0.OnClickLockBtn(arg_7_0)
	local var_7_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_7_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_7_0.isUseLock then
		return
	end

	if var_7_0.lockNowCDRound < var_7_1.lockCDRound or var_7_0.useLockTimes >= var_7_1.lockMaxTimes then
		-- block empty
	elseif not var_7_0.isUseLock then
		if var_7_0.selectLockIndex ~= arg_7_0.index then
			TetrisGameBridge.SetLockChip(arg_7_0.index)

			var_7_0.selectLockIndex = arg_7_0.index

			arg_7_0.parent:RefreshBlockSpaceList()
		else
			TetrisGameBridge.SetLockChip(-1)

			var_7_0.selectLockIndex = -1

			arg_7_0.parent:RefreshBlockSpaceList()
		end
	end
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshRotateUI()
	arg_8_0:RefreshLock()
end

function var_0_0.RefreshRotateUI(arg_9_0)
	local var_9_0 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	arg_9_0.rotateStateController:SetSelectedState("hide")
end

function var_0_0.RefreshLock(arg_10_0)
	local var_10_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_10_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_10_1.isTakeLock == false then
		arg_10_0.lockStateController:SetSelectedState("not")

		return
	end

	if var_10_0.lockNowCDRound < var_10_1.lockCDRound or var_10_0.useLockTimes >= var_10_1.lockMaxTimes then
		arg_10_0.lockStateController:SetSelectedState("Insufficient")
	elseif var_10_0.selectLockIndex == arg_10_0.index then
		arg_10_0.lockStateController:SetSelectedState("locked")
	else
		arg_10_0.lockStateController:SetSelectedState("canLocked")
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
