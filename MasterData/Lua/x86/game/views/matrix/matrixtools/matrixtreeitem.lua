local MatrixTreeItem = class("MatrixTreeItem", ReduxView)

function MatrixTreeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function MatrixTreeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixTreeItem:InitUI()
	self:BindCfgUI()
end

function MatrixTreeItem:AddUIListener()
	return
end

function MatrixTreeItem:SetData(arg_5_1, arg_5_2)
	self.id = arg_5_2
	self.tag = arg_5_1

	self:UpdateView()
end

function MatrixTreeItem:UpdateView()
	local var_6_0 = MatrixData:GetHeroData(self.id)

	self.m_name.text = GetI18NText(HeroCfg[self.id].name)
	self.m_icon.sprite = HeroTools.GetHeadSprite(MatrixData:GetHeroSkin(self.id))

	local var_6_1 = var_6_0:GetHeroHP()
	local var_6_2 = var_6_0:GetHeroMaxHP()

	self.m_filled.fillAmount = var_6_2 == 0 and 0 or var_6_1 / var_6_2
end

function MatrixTreeItem:GetToggle()
	return self.m_toggle
end

function MatrixTreeItem:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	MatrixTreeItem.super.Dispose(self)
end

return MatrixTreeItem
