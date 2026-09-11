local ActivityMatrixProcessEquipReplaceView = class("ActivityMatrixProcessEquipReplaceView", MatrixProcessEquipReplaceView)

function ActivityMatrixProcessEquipReplaceView:InitUI()
	self:BindCfgUI()

	self.item_ = ActivityMatrixProcessRewardItem.New(self.m_item)
	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, ActivityMatrixProcessRewardItem)
end

function ActivityMatrixProcessEquipReplaceView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	self.item_:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessEquipReplaceView.super.OnEnter(self)
end

function ActivityMatrixProcessEquipReplaceView:indexItem(arg_3_1, arg_3_2)
	arg_3_2:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessEquipReplaceView.super.indexItem(self, arg_3_1, arg_3_2)
end

function ActivityMatrixProcessEquipReplaceView:GetHeroData(arg_4_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_4_1)
end

return ActivityMatrixProcessEquipReplaceView
