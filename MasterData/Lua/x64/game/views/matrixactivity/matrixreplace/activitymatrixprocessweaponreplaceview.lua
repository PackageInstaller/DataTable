local ActivityMatrixProcessWeaponReplaceView = class("ActivityMatrixProcessWeaponReplaceView", MatrixProcessWeaponReplaceView)

function ActivityMatrixProcessWeaponReplaceView:InitUI()
	self:BindCfgUI()

	self.item_l = ActivityMatrixProcessRewardItem.New(self.m_item_l)
	self.item_r = ActivityMatrixProcessRewardItem.New(self.m_item_r)
end

function ActivityMatrixProcessWeaponReplaceView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	self.item_l:SetMatrixActivityId(self.matrix_activity_id)
	self.item_r:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessWeaponReplaceView.super.OnEnter(self)
end

function ActivityMatrixProcessWeaponReplaceView:GetHeroData(arg_3_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_3_1)
end

return ActivityMatrixProcessWeaponReplaceView
