local StrategyMatrixProcessEquipReplaceView = class("StrategyMatrixProcessEquipReplaceView", MatrixProcessEquipReplaceView)

function StrategyMatrixProcessEquipReplaceView:InitUI()
	self:BindCfgUI()

	self.item_ = StrategyMatrixProcessRewardItem.New(self.m_item)
	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, StrategyMatrixProcessRewardItem)
end

function StrategyMatrixProcessEquipReplaceView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	self.item_:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessEquipReplaceView.super.OnEnter(self)
end

function StrategyMatrixProcessEquipReplaceView:indexItem(arg_3_1, arg_3_2)
	arg_3_2:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessEquipReplaceView.super.indexItem(self, arg_3_1, arg_3_2)
end

function StrategyMatrixProcessEquipReplaceView:GetHeroData(arg_4_1)
	return StrategyMatrixData:GetHeroDataNew(arg_4_1)
end

return StrategyMatrixProcessEquipReplaceView
