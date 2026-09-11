local DrawAllHeroTapItem = class("DrawAllHeroTapItem", ReduxView)

function DrawAllHeroTapItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function DrawAllHeroTapItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawAllHeroTapItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
end

function DrawAllHeroTapItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.clickCallback_(self.tapID_)
	end)
end

function DrawAllHeroTapItem:SetData(arg_6_1)
	self.tapID_ = arg_6_1

	self:RefreshUI()
end

function DrawAllHeroTapItem:RefreshUI()
	local var_7_0 = self.tapID_ ~= -1 and HeroTools.GetSkillAttributeIcon(self.tapID_) or getSprite("Atlas/BagAtlas", "com_equip_icon_all")

	self.icon_1.sprite = var_7_0

	self.icon_1:SetNativeSize()

	self.icon_2.sprite = var_7_0

	self.icon_2:SetNativeSize()
end

function DrawAllHeroTapItem:SetSelect(arg_8_1)
	self.selectController_:SetSelectedState(arg_8_1 and "on" or "off")
end

function DrawAllHeroTapItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function DrawAllHeroTapItem:SetClickCallback(arg_10_1)
	self.clickCallback_ = arg_10_1
end

function DrawAllHeroTapItem:GetTapID()
	return self.tapID_
end

return DrawAllHeroTapItem
