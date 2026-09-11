local MatrixOverHeroAstrolabeItem = class("MatrixOverHeroAstrolabeItem", ReduxView)

function MatrixOverHeroAstrolabeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.astrolabeID and self.astrolabeID ~= 0 then
			manager.matrixPop:ShowMatrixPopItem(self.astrolabeID, Vector3(-0.45, self.transform_.position.y + 0.1, self.transform_.position.z), nil, self.heroId)
		end
	end)
end

function MatrixOverHeroAstrolabeItem:Refresh(arg_3_1, arg_3_2)
	self.heroId = arg_3_2
	self.astrolabeID = arg_3_1 or 0

	if arg_3_1 and arg_3_1 ~= 0 then
		self.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_3_1)

		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return MatrixOverHeroAstrolabeItem
