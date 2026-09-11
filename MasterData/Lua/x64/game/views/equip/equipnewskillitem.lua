local EquipNewSkillItem = class("EquipNewSkillItem", ReduxView)
local EquipTools = import("game.tools.EquipTools")

function EquipNewSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:Init()
end

function EquipNewSkillItem:SetIsEnchant(arg_2_1, arg_2_2)
	self.isEnchant_ = true
	self.index_ = arg_2_1
end

function EquipNewSkillItem:SetLockStatus(arg_3_1)
	return
end

function EquipNewSkillItem:RefreshData(arg_4_1, arg_4_2)
	self.info_ = arg_4_1
	self.isShowMax_ = arg_4_2

	self:Render()
end

function EquipNewSkillItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(nil, nil, "OnClick")

	self.selectController_ = self.skillCon_:GetController("select")
	self.lockController_ = self.skillCon_:GetController("lock")
end

function EquipNewSkillItem:Render()
	self:RefreshUI()
end

function EquipNewSkillItem:RefreshUI()
	if self.info_ then
		local var_7_0 = EquipSkillCfg[self.info_.id]

		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[self.info_.id].icon)
		self.name_.text = GetI18NText(var_7_0.name)
		self.lv_.text = self.isShowMax_ and string.format("%s/%s", self.info_.num > var_7_0.lvmax and string.format("<color=#FF000B>%s</color>", self.info_.num) or self.info_.num, var_7_0.lvmax) or GetTips("LEVEL") .. ((self.info_.num > var_7_0.lvmax or nil) and (var_7_0.lvmax or self.info_.num))

		if self.info_.level and (self.info_.unlockLevel or 0) > self.info_.level then
			self.unlockLv_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), self.info_.unlockLevel)

			self.lockController_:SetSelectedState("lock")
		else
			self.lockController_:SetSelectedState("unlock")
		end
	end
end

function EquipNewSkillItem:ShowSelect(arg_8_1)
	self.selectController_:SetSelectedState(arg_8_1 and "select" or "unSelect")
end

function EquipNewSkillItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_)
	end
end

function EquipNewSkillItem:RegistCallBack(arg_10_1)
	self.clickFunc = arg_10_1
end

function EquipNewSkillItem:GetItemInfo()
	return self.info_
end

function EquipNewSkillItem:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function EquipNewSkillItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	EquipNewSkillItem.super.Dispose(self)
end

return EquipNewSkillItem
