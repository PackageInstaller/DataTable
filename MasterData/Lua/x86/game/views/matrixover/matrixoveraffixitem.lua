local MatrixOverAffixItem = class("MatrixOverAffixItem", ReduxView)

function MatrixOverAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MatrixOverAffixItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		manager.matrixPop:ShowMatrixAiffixPopItem(self.affixData, Vector3(-1, self.transform_.position.y + 0.1, self.transform_.position.z))
	end)
end

function MatrixOverAffixItem:Refresh(arg_4_1)
	self.affixData = arg_4_1
	self.m_icon.sprite = getAffixSprite(arg_4_1)
	self.m_name.text = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[arg_4_1[2]] or ""
end

return MatrixOverAffixItem
