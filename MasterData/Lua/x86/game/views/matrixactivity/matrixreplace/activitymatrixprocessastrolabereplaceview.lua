local ActivityMatrixProcessAstrolabeReplaceView = class("ActivityMatrixProcessAstrolabeReplaceView", MatrixProcessAstrolabeReplaceView)

function ActivityMatrixProcessAstrolabeReplaceView:InitUI()
	self:BindCfgUI()

	self.item_ = ActivityMatrixProcessRewardItem.New(self.m_item)
	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, ActivityMatrixProcessAstrolabeRewardItem)
end

function ActivityMatrixProcessAstrolabeReplaceView:indexItem(arg_2_1, arg_2_2)
	arg_2_2:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessAstrolabeReplaceView.super.indexItem(self, arg_2_1, arg_2_2)
end

function ActivityMatrixProcessAstrolabeReplaceView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	self.item_:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessAstrolabeReplaceView.super.OnEnter(self)
end

function ActivityMatrixProcessAstrolabeReplaceView:GetHeroData(arg_4_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_4_1)
end

return ActivityMatrixProcessAstrolabeReplaceView
