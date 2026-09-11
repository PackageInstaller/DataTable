local ActivityMatrixOverHeroItem = class("ActivityMatrixOverHeroItem", (import("game.views.matrixOver.MatrixOverHeroItem")))

function ActivityMatrixOverHeroItem:InitUI()
	self:BindCfgUI()

	self.servantView_ = ActivityMatrixOverHeroServantItem.New(self.servantItem_)
	self.equipItemView_ = {}

	for iter_1_0 = 1, 5 do
		table.insert(self.equipItemView_, MatrixOverHeroEquipItem.New(self[string.format("equipGo%s_", iter_1_0)]))
	end

	self.astrolabeItemView_ = {}

	for iter_1_1 = 1, 6 do
		table.insert(self.astrolabeItemView_, ActivityMatrixOverHeroAstrolabeItem.New(self[string.format("astrolabeGo%s_", iter_1_1)]))
	end
end

function ActivityMatrixOverHeroItem:SetMatrixActivityId(arg_2_1)
	self.servantView_:SetMatrixActivityId(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(self.astrolabeItemView_) do
		iter_2_1:SetMatrixActivityId(arg_2_1)
	end

	self.matrix_activity_id = arg_2_1
end

function ActivityMatrixOverHeroItem:GetHeroData(arg_3_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_3_1)
end

function ActivityMatrixOverHeroItem:GetHeroSkin(arg_4_1)
	return ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, arg_4_1)
end

return ActivityMatrixOverHeroItem
