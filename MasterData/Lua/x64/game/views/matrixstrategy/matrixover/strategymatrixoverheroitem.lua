local StrategyMatrixOverHeroItem = class("StrategyMatrixOverHeroItem", (import("game.views.matrixOver.MatrixOverHeroItem")))

function StrategyMatrixOverHeroItem:InitUI()
	self:BindCfgUI()

	self.servantView_ = StrategyMatrixOverHeroServantItem.New(self.servantItem_)
	self.equipItemView_ = {}

	for iter_1_0 = 1, 5 do
		table.insert(self.equipItemView_, MatrixOverHeroEquipItem.New(self[string.format("equipGo%s_", iter_1_0)]))
	end

	self.astrolabeItemView_ = {}

	for iter_1_1 = 1, 6 do
		table.insert(self.astrolabeItemView_, StrategyMatrixOverHeroAstrolabeItem.New(self[string.format("astrolabeGo%s_", iter_1_1)]))
	end
end

function StrategyMatrixOverHeroItem:SetMatrixActivityId(arg_2_1)
	self.servantView_:SetMatrixActivityId(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(self.astrolabeItemView_) do
		iter_2_1:SetMatrixActivityId(arg_2_1)
	end

	self.matrix_activity_id = arg_2_1
end

function StrategyMatrixOverHeroItem:GetHeroData(arg_3_1)
	return StrategyMatrixData:GetHeroDataNew(arg_3_1)
end

function StrategyMatrixOverHeroItem:GetHeroSkin(arg_4_1)
	return StrategyMatrixData:GetHeroSkin(self.matrix_activity_id, arg_4_1)
end

return StrategyMatrixOverHeroItem
