local EquipArchiveView = class("EquipArchiveView", ReduxView)

function EquipArchiveView:UIName()
	return "Widget/System/IllustratedHandbook/IlluEquipDetailUI"
end

function EquipArchiveView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipArchiveView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipArchiveView:InitUI()
	self:BindCfgUI()

	self.imageImg_.immediate = true
	self.controllers_ = {}

	for iter_4_0 = 1, 6 do
		self.controllers_[iter_4_0] = self:GetController(self["item" .. iter_4_0 .. "Go_"], "conName")
	end
end

function EquipArchiveView:AddUIListener()
	self:AddBtnListener(self.gainBtn_, nil, function()
		ShowPopItemSource(0, 0, self.id_)
	end)
end

function EquipArchiveView:GetController(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetComponent("ControllerExCollection")

	if var_7_0 then
		return var_7_0:GetController(arg_7_2)
	end
end

function EquipArchiveView:OnEnter()
	self:ShowDefaultBar()

	self.id_ = self.params_.equipID

	local var_8_0 = IllustratedData:GetEquipInfo()[self.id_]

	self.nameText_.text = GetI18NText(EquipSuitCfg[self.id_].name)
	self.descText_.text = GetI18NText(EquipTools.GetEffectDesc(EquipSuitCfg[self.id_].suit_effect[1]))
	self.imageImg_.spriteSync = "TextureConfig/Equip/icon_l/" .. EquipSuitCfg[self.id_].icon
	self.backgroundText_.text = GetI18NText(EquipSuitCfg[self.id_].desc)

	if var_8_0 then
		for iter_8_0 = 1, 6 do
			if var_8_0.pos_list[iter_8_0] == 1 then
				self.controllers_[iter_8_0]:SetSelectedState("0")
			else
				self.controllers_[iter_8_0]:SetSelectedState("1")
			end
		end
	else
		for iter_8_1 = 1, 6 do
			self.controllers_[iter_8_1]:SetSelectedState("1")
		end
	end
end

function EquipArchiveView:OnExit()
	manager.windowBar:HideBar()
end

function EquipArchiveView:Dispose()
	EquipArchiveView.super.Dispose(self)
end

return EquipArchiveView
