local StrengthenBackPanel = class("StrengthenBackPanel", import(".MsgboxSubPanel"))

StrengthenBackPanel.ConfigData = {
	content = "equipment_info_change_strengthen",
	btnTxt = "text_forward",
	isOpen = true,
	icon = "equips/56000",
	equipID = 96000
}

function StrengthenBackPanel:getUIName()
	return "StrengthenBackBox"
end

function StrengthenBackPanel:UpdateView(arg_2_1)
	self:PreRefresh(arg_2_1)

	rtf(self.viewParent._window).sizeDelta = Vector2.New(1000, 638)

	setText(self._tf:Find("info_view/Viewport/Content/Text"), i18n(StrengthenBackPanel.ConfigData.content, Equipment.getConfigData(StrengthenBackPanel.ConfigData.equipID).name))
	setText(self._tf:Find("button_container/custom_button_1(Clone)/pic", self._tf.parent), i18n(StrengthenBackPanel.ConfigData.btnTxt))
	setImageSprite(self._tf:Find("icon_bg/icon"), LoadSprite(StrengthenBackPanel.ConfigData.icon))

	if arg_2_1.windowSize then
		self._tf.parent.sizeDelta = Vector2(arg_2_1.windowSize.x, arg_2_1.windowSize.y)
	end

	self:PostRefresh(arg_2_1)

	return
end

return StrengthenBackPanel
