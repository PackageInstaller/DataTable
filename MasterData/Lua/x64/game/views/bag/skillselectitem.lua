local SkillSelectItem = class("SkillSelectItem", ReduxView)
local EquipConst = import("game.const.EquipConst")
local EquipTools = import("game.tools.EquipTools")

function SkillSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SkillSelectItem:RefreshData(arg_2_1, arg_2_2)
	self.data_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function SkillSelectItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.clickBtn_, nil, "OnClick")

	self.selectController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function SkillSelectItem:Init()
	self:RefreshUI(self.info_)
end

function SkillSelectItem:Render()
	self:RefreshUI(self.info_)
end

function SkillSelectItem:RefreshUI(arg_6_1)
	if arg_6_1 and arg_6_1.id ~= 0 then
		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[arg_6_1.id].icon)
		self.name_.text = GetI18NText(EquipSkillCfg[arg_6_1.id].name)
	end
end

function SkillSelectItem:SetIndex(arg_7_1)
	self.transform_:SetSiblingIndex(arg_7_1)
end

function SkillSelectItem:SetBottomText(arg_8_1)
	if self.num_ then
		self.numText_.text = arg_8_1
	end
end

function SkillSelectItem:RefreshPos(arg_9_1, arg_9_2)
	self.num_ = EquipTools.GetEquipSkillNum(self.info_.id, nil, arg_9_1, arg_9_2)

	self:SetBottomText(self.num_)
end

function SkillSelectItem:Dispose()
	self:RemoveAllListeners()

	self.info_ = nil
	self.clickFunc = nil

	SkillSelectItem.super.Dispose(self)
end

function SkillSelectItem:OnClick()
	if self.clickFunc and self.num_ ~= 0 then
		self.clickFunc(self.info_.id)
	end
end

function SkillSelectItem:SetSelect(arg_12_1)
	if self.num_ == 0 then
		self.selectController_:SetSelectedIndex(2)
	elseif arg_12_1 then
		self.selectController_:SetSelectedIndex(1)
	else
		self.selectController_:SetSelectedIndex(0)
	end
end

function SkillSelectItem:RegistCallBack(arg_13_1)
	self.clickFunc = arg_13_1
end

function SkillSelectItem:GetItemInfo()
	return self.info_
end

function SkillSelectItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

return SkillSelectItem
