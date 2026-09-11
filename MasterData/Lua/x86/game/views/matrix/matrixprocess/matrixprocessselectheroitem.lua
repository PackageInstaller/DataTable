local MatrixProcessSelectHeroItem = class("MatrixProcessSelectHeroItem", ReduxView)

function MatrixProcessSelectHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixProcessSelectHeroItem:initUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function MatrixProcessSelectHeroItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.heroId)
		end
	end)
end

function MatrixProcessSelectHeroItem:GetHeroId()
	return self.heroId
end

function MatrixProcessSelectHeroItem:Refresh(arg_6_1, arg_6_2)
	self.heroId = arg_6_1
	self.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", (self:GetHeroSkin(arg_6_1)))

	self.stateController_:SetSelectedIndex(arg_6_2 and 0 or 1)
end

function MatrixProcessSelectHeroItem:SetSelected(arg_7_1)
	self.selectController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function MatrixProcessSelectHeroItem:RegistCallBack(arg_8_1)
	self.clickFunc = arg_8_1
end

function MatrixProcessSelectHeroItem:Dispose()
	MatrixProcessSelectHeroItem.super.Dispose(self)
end

function MatrixProcessSelectHeroItem:GetHeroSkin(arg_10_1)
	return MatrixData:GetHeroSkin(arg_10_1)
end

return MatrixProcessSelectHeroItem
