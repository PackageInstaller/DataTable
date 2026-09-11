local ChipManagerItem = class("ChipManagerItem", ReduxView)

function ChipManagerItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.adminCatImg_.immediate = true

	self:AddListeners()

	self.handler_ = handler(self, self.RefreshEnabledUI)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, self.handler_)

	self.stateControl = self.mimirControllerexcollection_:GetController("state")
	self.selectControl = self.mimirControllerexcollection_:GetController("select")
end

function ChipManagerItem:AddListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		self:Go("/chipManager", {
			chipManagerID = self.chipManagerID_
		})
	end)
end

function ChipManagerItem:SetChipManagerID(arg_4_1)
	self.chipManagerID_ = arg_4_1
end

function ChipManagerItem:RefreshUI(arg_5_1)
	self.gameObject_.name = self.chipManagerID_
	self.adminCatImg_.spriteSync = ChipTools.GetChipManagerIconPath(self.chipManagerID_)

	local var_5_0 = table.keyof(self:GetUnlockChipManagerList(), self.chipManagerID_) == nil

	if arg_5_1 then
		self.selectControl:SetSelectedState("selected")
	else
		self.selectControl:SetSelectedState("unselected")
	end

	if var_5_0 then
		self.stateControl:SetSelectedState("locked")
	elseif self.chipManagerDataTemplate_:GetISUseChipmanager(self.chipManagerID_) then
		self.stateControl:SetSelectedState("equiped")
	else
		self.stateControl:SetSelectedState("unequiped")
	end

	if self.chipManagerDataTemplate_ and not self.chipManagerDataTemplate_.isNoRed then
		self:BindRedPoint()
	end
end

function ChipManagerItem:SetTemplateData(arg_6_1)
	self.chipManagerDataTemplate_ = arg_6_1
end

function ChipManagerItem:Dispose()
	self:UnbindRedPoint()
	ChipManagerItem.super.Dispose(self)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, self.handler_)

	self.handler_ = nil
end

function ChipManagerItem:GetUnlockChipManagerList()
	return self.chipManagerDataTemplate_.unlockChipManagerIDList_
end

function ChipManagerItem:GetEnabledChipManagerID()
	return ChipData:GetEnabledChipManagerID()
end

function ChipManagerItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.notice_, string.format("%s_%s", RedPointConst.CHIP_MANAGER, self.chipManagerID_), {
		x = 0,
		y = 0
	})
end

function ChipManagerItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.notice_)
end

return ChipManagerItem
