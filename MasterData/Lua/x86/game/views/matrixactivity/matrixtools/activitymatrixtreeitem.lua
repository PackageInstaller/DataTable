local ActivityMatrixTreeItem = class("ActivityMatrixTreeItem", MatrixTreeItem)

function ActivityMatrixTreeItem:SetData(arg_1_1, arg_1_2, arg_1_3)
	self.id = arg_1_2
	self.tag = arg_1_1
	self.matrix_activity_id = arg_1_3

	self:UpdateView()
end

function ActivityMatrixTreeItem:UpdateView()
	local var_2_0 = ActivityMatrixData:GetHeroData(self.matrix_activity_id, self.id)

	self.m_name.text = GetI18NText(HeroCfg[self.id].name)
	self.m_icon.sprite = HeroTools.GetHeadSprite(ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, self.id))

	local var_2_1 = var_2_0:GetHeroHP()
	local var_2_2 = var_2_0:GetHeroMaxHP()

	self.m_filled.fillAmount = var_2_2 == 0 and 0 or var_2_1 / var_2_2
end

return ActivityMatrixTreeItem
