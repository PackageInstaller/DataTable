local MatrixOverHeroEquipItem = class("MatrixOverHeroEquipItem", ReduxView)

function MatrixOverHeroEquipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.equipID = 0

	self:AddBtnListener(self.btn_, nil, function()
		if self.equipID and self.equipID ~= 0 then
			manager.matrixPop:ShowMatrixPopItem(self.equipID, Vector3(-0.45, self.transform_.position.y + 0.1, self.transform_.position.z))
		end
	end)
end

function MatrixOverHeroEquipItem:Refresh(arg_3_1)
	self.equipID = arg_3_1 or 0

	if arg_3_1 and arg_3_1 ~= 0 then
		self.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_3_1)

		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return MatrixOverHeroEquipItem
