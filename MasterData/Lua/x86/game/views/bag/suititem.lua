local SuitItem = class("SuitItem", ReduxView)
local EquipConst = import("game.const.EquipConst")
local EquipTools = import("game.tools.EquipTools")

function SuitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SuitItem:RefreshData(arg_2_1, arg_2_2)
	self.data_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function SuitItem:InitUI()
	self.bg_ = self:FindGo("bg")
	self.icon_ = self:FindCom(typeof(Image), "icon")
	self.name_ = self:FindCom(typeof(Text), "name")
	self.num_ = self:FindCom(typeof(Text), "num")
	self.select_ = self:FindGo("select")
	self.maskGo_ = self:FindGo("mask")

	self:AddBtnListener(nil, nil, "OnClick")
end

function SuitItem:Init()
	self:RefreshUI(self.info_)
end

function SuitItem:Render()
	self:RefreshUI(self.info_)
end

function SuitItem:RefreshUI(arg_6_1)
	if arg_6_1 and arg_6_1.id ~= 0 then
		SetSpriteWithoutAtlasAsync(self.icon_, SpritePathCfg.EquipIcon_s.path .. EquipSuitCfg[arg_6_1.id].equip_skill_icon)

		self.name_.text = GetI18NText(EquipSuitCfg[arg_6_1.id].name)
	end
end

function SuitItem:RefreshPos(arg_7_1)
	self:SetBottomText(EquipTools.GetSuitEquipNum(self.info_.id, nil, arg_7_1))
end

function SuitItem:UpdateNum()
	self:SetBottomText(EquipTools.GetSuitEquipNum(self.info_.id))
end

function SuitItem:SetBottomText(arg_9_1)
	self.num_.text = arg_9_1

	if self.maskGo_ then
		SetActive(self.maskGo_, arg_9_1 == 0)
	end
end

function SuitItem:SetIndex(arg_10_1)
	self.transform_:SetSiblingIndex(arg_10_1)
end

function SuitItem:Dispose()
	self:RemoveAllListeners()

	self.info_ = nil
	self.clickFunc = nil

	SuitItem.super.Dispose(self)
end

function SuitItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_)
	end
end

function SuitItem:ShowSelect(arg_13_1)
	if self.select_ then
		SetActive(self.select_, arg_13_1)
	end
end

function SuitItem:RegistCallBack(arg_14_1)
	self.clickFunc = arg_14_1
end

function SuitItem:GetItemInfo()
	return self.info_
end

function SuitItem:Show(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)
end

return SuitItem
