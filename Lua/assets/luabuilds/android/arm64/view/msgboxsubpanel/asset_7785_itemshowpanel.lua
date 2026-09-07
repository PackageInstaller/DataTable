local ItemShowPanel = class("ItemShowPanel", import(".MsgboxSubPanel"))

function ItemShowPanel:getUIName()
	return "ItemChangeNoticeBox"
end

function ItemShowPanel:UpdateView(arg_2_1)
	self:PreRefresh(arg_2_1)

	rtf(self.viewParent._window).sizeDelta = Vector2.New(1000, 638)

	setText(self._tf:Find("title"), i18n(arg_2_1.configData.title))
	setText(self._tf:Find("name_origin"), i18n(arg_2_1.configData.name_old))
	setText(self._tf:Find("name_now"), i18n(arg_2_1.configData.name_new))
	setText(self._tf:Find("before/Text"), i18n(arg_2_1.configData.tip_old))
	setText(self._tf:Find("after/Text"), i18n(arg_2_1.configData.tip_new))
	setImageSprite(self._tf:Find("icon_origin"), LoadSprite(arg_2_1.configData.icon_old))
	setImageSprite(self._tf:Find("icon_now"), LoadSprite(arg_2_1.configData.icon_new))
	self:PostRefresh(arg_2_1)

	return
end

return ItemShowPanel
