local HeroFileRoleTabItem = class("HeroFileRoleTabItem", ReduxView)

function HeroFileRoleTabItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onClick_ = arg_1_2
	self.onSwitchClick_ = arg_1_3

	self:Init()
end

function HeroFileRoleTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileRoleTabItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.roleControllerEx_:GetController("select")
	self.switchController_ = self.roleControllerEx_:GetController("canSwitch")
end

function HeroFileRoleTabItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, self.onClick_)
	self:AddBtnListener(self.switchBtn_, nil, self.onSwitchClick_)
end

function HeroFileRoleTabItem:Show(arg_5_1)
	local var_5_0 = HeroTools.HeroUsingSkinInfo(arg_5_1).id

	self.iconImg_.sprite = arg_5_1 == 1054 and getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/SwitchHead/" .. var_5_0) or getSpriteViaConfig("HeroLittleIcon", var_5_0)

	SetActive(self.gameObject_, true)
end

function HeroFileRoleTabItem:ShowWithSkinID(arg_6_1)
	self.iconImg_.sprite = HeroTools.GetHeroIDFromFormID(arg_6_1) == 1054 and getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/SwitchHead/" .. arg_6_1) or getSpriteViaConfig("HeroLittleIcon", arg_6_1)

	SetActive(self.gameObject_, true)
end

function HeroFileRoleTabItem:SetCanForm(arg_7_1)
	if arg_7_1 then
		self.switchController_:SetSelectedIndex(1)
	else
		self.switchController_:SetSelectedIndex(0)
	end
end

function HeroFileRoleTabItem:Hide()
	SetActive(self.gameObject_, false)
end

function HeroFileRoleTabItem:SetSelectState(arg_9_1)
	self.selectController_:SetSelectedState(arg_9_1 and "select" or "cancel")
end

function HeroFileRoleTabItem:Dispose()
	HeroFileRoleTabItem.super.Dispose(self)
end

return HeroFileRoleTabItem
