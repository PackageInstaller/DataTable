local TetrisGameBlockSpaceItem = class("TetrisGameBlockSpaceItem", ReduxView)

function TetrisGameBlockSpaceItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2
	self.parent = arg_1_3

	self:Init()
end

function TetrisGameBlockSpaceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameBlockSpaceItem:InitUI()
	self:BindCfgUI()

	self.lockStateController = self.controller_:GetController("lock")
	self.rotateStateController = self.controller_:GetController("rotate")
end

function TetrisGameBlockSpaceItem:AddUIListener()
	self:AddBtnListener(self.rotateBtn_, nil, function()
		TetrisGameRunTimeManager:RotateChip(self.index)
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		self:OnClickLockBtn()
	end)
end

function TetrisGameBlockSpaceItem:OnClickLockBtn()
	local var_7_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_7_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_7_0.isUseLock then
		return
	end

	if var_7_0.lockNowCDRound < var_7_1.lockCDRound or var_7_0.useLockTimes >= var_7_1.lockMaxTimes then
		-- block empty
	elseif not var_7_0.isUseLock then
		if var_7_0.selectLockIndex ~= self.index then
			TetrisGameBridge.SetLockChip(self.index)

			var_7_0.selectLockIndex = self.index

			self.parent:RefreshBlockSpaceList()
		else
			TetrisGameBridge.SetLockChip(-1)

			var_7_0.selectLockIndex = -1

			self.parent:RefreshBlockSpaceList()
		end
	end
end

function TetrisGameBlockSpaceItem:RefreshUI()
	self:RefreshRotateUI()
	self:RefreshLock()
end

function TetrisGameBlockSpaceItem:RefreshRotateUI()
	local var_9_0 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	self.rotateStateController:SetSelectedState("hide")
end

function TetrisGameBlockSpaceItem:RefreshLock()
	local var_10_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_10_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_10_1.isTakeLock == false then
		self.lockStateController:SetSelectedState("not")

		return
	end

	if var_10_0.lockNowCDRound < var_10_1.lockCDRound or var_10_0.useLockTimes >= var_10_1.lockMaxTimes then
		self.lockStateController:SetSelectedState("Insufficient")
	elseif var_10_0.selectLockIndex == self.index then
		self.lockStateController:SetSelectedState("locked")
	else
		self.lockStateController:SetSelectedState("canLocked")
	end
end

function TetrisGameBlockSpaceItem:Dispose()
	TetrisGameBlockSpaceItem.super.Dispose(self)
end

return TetrisGameBlockSpaceItem
