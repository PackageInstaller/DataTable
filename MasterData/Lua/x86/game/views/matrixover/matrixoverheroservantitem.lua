local MatrixOverHeroServantItem = class("MatrixOverHeroServantItem", ReduxView)

function MatrixOverHeroServantItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.matrixServantID and self.matrixServantID ~= 0 then
			manager.matrixPop:ShowMatrixPopItem(self.matrixServantID, Vector3(-0.45, self.transform_.position.y + 0.1, self.transform_.position.z))
		end
	end)
end

function MatrixOverHeroServantItem:Refresh(arg_3_1)
	self.matrixServantID = arg_3_1

	if arg_3_1 ~= 0 then
		self.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_3_1)

		SetActive(self.mask_, true)
	else
		SetActive(self.mask_, false)
	end
end

return MatrixOverHeroServantItem
