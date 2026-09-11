local MatrixHeroHeadItem = class("MatrixHeroHeadItem", ReduxView)

function MatrixHeroHeadItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = 0

	self:initUI()
end

function MatrixHeroHeadItem:initUI()
	self:BindCfgUI()

	self.floorController = ControllerUtil.GetController(self.m_floorController, "floor")
end

function MatrixHeroHeadItem:Refresh(arg_3_1)
	if not HeroStandardSystemCfg[arg_3_1] then
		self.floorController:SetSelectedIndex(0)

		return
	end

	self.floorController:SetSelectedIndex(1)

	self.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", (MatrixData:GetHeroSkin(HeroStandardSystemCfg[arg_3_1].hero_id)))
end

return MatrixHeroHeadItem
