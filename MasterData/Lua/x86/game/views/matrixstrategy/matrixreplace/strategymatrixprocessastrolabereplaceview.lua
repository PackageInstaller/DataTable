local StrategyMatrixProcessAstrolabeReplaceView = class("StrategyMatrixProcessAstrolabeReplaceView", MatrixProcessAstrolabeReplaceView)

function StrategyMatrixProcessAstrolabeReplaceView:InitUI()
	self:BindCfgUI()

	self.item_ = StrategyMatrixProcessRewardItem.New(self.m_item)
	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, StrategyMatrixProcessAstrolabeRewardItem)
end

function StrategyMatrixProcessAstrolabeReplaceView:indexItem(arg_2_1, arg_2_2)
	arg_2_2:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessAstrolabeReplaceView.super.indexItem(self, arg_2_1, arg_2_2)
end

function StrategyMatrixProcessAstrolabeReplaceView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	self.item_:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessAstrolabeReplaceView.super.OnEnter(self)
end

function StrategyMatrixProcessAstrolabeReplaceView:GetHeroData(arg_4_1)
	return StrategyMatrixData:GetHeroDataNew(arg_4_1)
end

return StrategyMatrixProcessAstrolabeReplaceView
