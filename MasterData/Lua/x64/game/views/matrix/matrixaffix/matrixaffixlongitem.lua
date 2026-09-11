local MatrixAffixLongItem = class("MatrixAffixLongItem", ReduxView)

function MatrixAffixLongItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function MatrixAffixLongItem:initUI()
	self:BindCfgUI()
end

function MatrixAffixLongItem:Refresh(arg_3_1)
	self.m_icon.sprite = getAffixSprite(arg_3_1)
	self.m_name.text = GetI18NText((getAffixName(arg_3_1))) .. (({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[arg_3_1[2]] or "")
	self.m_des.text = GetI18NText((getAffixDesc(arg_3_1)))
end

return MatrixAffixLongItem
