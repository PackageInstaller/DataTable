local MatrixAffixItem = class("MatrixAffixItem", ReduxView)

function MatrixAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function MatrixAffixItem:initUI()
	self:BindCfgUI()
end

function MatrixAffixItem:Refresh(arg_3_1, arg_3_2)
	self.m_icon.sprite = getAffixSprite(arg_3_1)

	local var_3_0 = getAffixName(arg_3_1)
	local var_3_1 = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[arg_3_1[2]] or ""

	self.m_text.text = arg_3_2 == 2 and GetI18NText(var_3_0) .. var_3_1 .. "\n" .. GetI18NText((getAffixDesc(arg_3_1))) or GetI18NText(var_3_0) .. var_3_1
end

function MatrixAffixItem:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

return MatrixAffixItem
