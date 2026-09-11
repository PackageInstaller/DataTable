local StrategyMatrixOverHeroAstrolabeItem = class("StrategyMatrixOverHeroAstrolabeItem", (import("game.views.matrixOver.MatrixOverHeroAstrolabeItem")))

function StrategyMatrixOverHeroAstrolabeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.astrolabeID and self.astrolabeID ~= 0 then
			manager.matrixPop:ShowMatrixPopItem(self.astrolabeID, Vector3(-0.45, self.transform_.position.y + 0.1, self.transform_.position.z), nil, self.heroId, self.matrix_activity_id)
		end
	end)
end

function StrategyMatrixOverHeroAstrolabeItem:SetMatrixActivityId(arg_3_1)
	self.matrix_activity_id = arg_3_1
end

return StrategyMatrixOverHeroAstrolabeItem
