local StrategyMatrixProcessWeaponReplaceView = class("StrategyMatrixProcessWeaponReplaceView", MatrixProcessWeaponReplaceView)

function StrategyMatrixProcessWeaponReplaceView:InitUI()
	self:BindCfgUI()

	self.item_l = StrategyMatrixProcessRewardItem.New(self.m_item_l)
	self.item_r = StrategyMatrixProcessRewardItem.New(self.m_item_r)
end

function StrategyMatrixProcessWeaponReplaceView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	self.item_l:SetMatrixActivityId(self.matrix_activity_id)
	self.item_r:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessWeaponReplaceView.super.OnEnter(self)
end

function StrategyMatrixProcessWeaponReplaceView:GetHeroData(arg_3_1)
	return StrategyMatrixData:GetHeroDataNew(arg_3_1)
end

return StrategyMatrixProcessWeaponReplaceView
