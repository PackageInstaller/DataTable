local IslandAgoraUpgradeMsgboxWindow = class("IslandAgoraUpgradeMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandAgoraUpgradeMsgboxWindow:getUIName()
	return "IslandAgoraUpgradeMsgBox"
end

function IslandAgoraUpgradeMsgboxWindow:OnLoaded()
	IslandAgoraUpgradeMsgboxWindow.super.OnLoaded(self)
	setText(self._tf:Find("confirm/Text"), i18n("island_agora_extend"))
	setText(self._tf:Find("condition/title/Text"), i18n("island_agora_extend_consume"))
	setText(self._tf:Find("capacity/Text"), i18n("island_agora_extend_capacity"))

	self.dropTpl = self._tf:Find("condition/tpl")
	self.dropCntTxt = self._tf:Find("condition/tpl/icon_bg/count_bg/count"):GetComponent(typeof(Text))
	self.oldCapacityTxt = self._tf:Find("capacity/Text_1"):GetComponent(typeof(Text))
	self.newCapacityTxt = self._tf:Find("capacity/Text_2"):GetComponent(typeof(Text))

	return
end

function IslandAgoraUpgradeMsgboxWindow:OnShow()
	IslandAgoraUpgradeMsgboxWindow.super.OnShow(self)

	local var_3_0 = self.settings.island:GetAgoraAgency()

	self:UpdateCapacity(var_3_0)
	self:UpdateConsume(var_3_0, (self.settings.island:GetInventoryAgency()))

	return
end

function IslandAgoraUpgradeMsgboxWindow:FlushBtn(arg_4_1)
	return
end

function IslandAgoraUpgradeMsgboxWindow:UpdateCapacity(arg_5_1)
	self.oldCapacityTxt.text = arg_5_1:GetCapacity()
	self.newCapacityTxt.text = arg_5_1:GetNextCapacity()

	return
end

function IslandAgoraUpgradeMsgboxWindow:UpdateConsume(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetUpgradeConsume()

	updateCustomDrop(self.dropTpl, var_6_0)

	local var_6_1 = arg_6_2:GetOwnCount(var_6_0.id)

	self.dropCntTxt.text = setColorStr(var_6_1, var_6_1 >= var_6_0.count and "#FFFFFF" or "#EB5F5F") .. "/" .. var_6_0.count

	return
end

return IslandAgoraUpgradeMsgboxWindow
