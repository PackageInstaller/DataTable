local EquipRecDescItem = class("EquipRecDescItem", ReduxView)

function EquipRecDescItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipRecDescItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipRecDescItem:InitUI()
	self:BindCfgUI()
end

function EquipRecDescItem:SetData(arg_4_1, arg_4_2)
	self.nameText_.text = GetI18NText(arg_4_1) .. "："
	self.descText_.text = GetI18NText(arg_4_2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function EquipRecDescItem:AddUIListener()
	return
end

function EquipRecDescItem:OnEnter()
	return
end

function EquipRecDescItem:OnExit()
	return
end

function EquipRecDescItem:Dispose()
	EquipRecDescItem.super.Dispose(self)
end

return EquipRecDescItem
