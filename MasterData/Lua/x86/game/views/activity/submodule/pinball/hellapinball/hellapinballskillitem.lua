local HellaPinballSkillItem = class("HellaPinballSkillItem", BaseView)

function HellaPinballSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaPinballSkillItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.statusController_ = self.controllerEx_:GetController("status")
end

function HellaPinballSkillItem:AddUIListener()
	return
end

function HellaPinballSkillItem:SetData(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.id_ = arg_4_2

	self:RefreshUI()
end

function HellaPinballSkillItem:RefreshUI()
	if PinballSkillCfg[self.id_] then
		self.icon_.sprite = pureGetSpriteWithoutAtlas(PinballSkillCfg[self.id_].icon)

		self.statusController_:SetSelectedState("normal")
	else
		self.statusController_:SetSelectedState("empty")
	end
end

function HellaPinballSkillItem:SetSelect(arg_6_1)
	return
end

function HellaPinballSkillItem:SetClickCallBack(arg_7_1)
	return
end

return HellaPinballSkillItem
