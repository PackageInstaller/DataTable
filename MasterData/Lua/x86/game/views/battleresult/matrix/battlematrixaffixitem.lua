local BattleMatrixAffixItem = class("BattleMatrixAffixItem", ReduxView)

function BattleMatrixAffixItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function BattleMatrixAffixItem:initUI()
	self:BindCfgUI()

	self.nullController = ControllerUtil.GetController(self.transform_, "null")
end

function BattleMatrixAffixItem:SetData(arg_3_1)
	if arg_3_1 then
		self.nullController:SetSelectedIndex(0)

		self.m_lab.text = GetI18NText(getAffixName(arg_3_1))
		self.m_icon.sprite = getAffixSprite(arg_3_1)
	else
		self.nullController:SetSelectedIndex(1)

		self.m_lab.text = ""
	end
end

return BattleMatrixAffixItem
