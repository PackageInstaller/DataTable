local ShadowCityCollectPage = class("ShadowCityCollectPage", import("view.activity.CorePage.DOA.DOACoreActivityCollectPage"))

function ShadowCityCollectPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")
	self.itemPanel = self.bg:Find("item_panel")
	self.togglesTF = self.itemPanel:Find("toggles")
	self.content = self.itemPanel:Find("item_list/content")
	self.itemList = UIItemList.New(self.content, self.content:Find("tpl"))
	self.msgBox = ShadowCityCollectMsgBox.New(self._tf, self.event)

	setText(self.btnList:Find("medal/title"), i18n("shadowcitycollectpage_title_1"))
	setText(self.btnList:Find("furniture_theme/title"), i18n("shadowcitycollectpage_title_2"))
	setText(self.btnList:Find("equip_skin_box/title"), i18n("shadowcitycollectpage_title_3"))
	setText(self.btnList:Find("medal/btn_go/text"), i18n("task_go"))
	setText(self.btnList:Find("furniture_theme/btn_go/text"), i18n("task_go"))
	setText(self.btnList:Find("equip_skin_box/btn_go/text"), i18n("task_go"))
	setText(self.itemPanel:Find("title"), i18n("shadowcitycollectpage_title_4"))
	setText(self.togglesTF:Find("ship/name"), i18n("shadowcitycollectpage_toggle_1"))
	setText(self.togglesTF:Find("furniture/name"), i18n("shadowcitycollectpage_toggle_2"))
	setText(self.togglesTF:Find("equip_skin/name"), i18n("shadowcitycollectpage_toggle_3"))

	return
end

function ShadowCityCollectPage:GetTogglesDropTypes()
	return {
		DROP_TYPE_SHIP,
		{
			DROP_TYPE_FURNITURE,
			DROP_TYPE_RESOURCE,
			DROP_TYPE_ICON_FRAME
		},
		DROP_TYPE_EQUIPMENT_SKIN
	}
end

function ShadowCityCollectPage:UpdatePage(arg_3_1)
	ShadowCityCollectPage.super.UpdatePage(self, arg_3_1)
	setActive(self.itemPanel:Find("full_scroll_bar"), not self.bg:Find("Scrollbar").gameObject.activeSelf)

	return
end

function ShadowCityCollectPage:OnUpdateItem(arg_4_1, arg_4_2)
	local var_4_0 = self.showDataList[arg_4_1 + 1]
	local var_4_1 = arg_4_2:Find("icon_mask/icon")
	local var_4_2 = {
		type = self.showDataList[arg_4_1 + 1].config.type,
		id = self.showDataList[arg_4_1 + 1].config.drop_id
	}

	updateDrop(var_4_1, var_4_2)
	onButton(self, var_4_1, function()
		self:OnClickItem(var_4_0)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_4_2:Find("name_mask/name"), Drop.New({
		type = var_4_0.config.type,
		id = var_4_0.config.drop_id
	}):getName())

	if var_4_2.type == 4 then
		var_4_0.count = #getProxy(BayProxy):findShipsByGroup((Ship.getGroupIdByConfigId(var_4_0.config.drop_id)))

		setActive(arg_4_2:Find("got"), var_4_0.count >= 1)
	else
		setActive(arg_4_2:Find("got"), var_4_0.count == var_4_0.config.count)
	end

	self:RefreshCountText(var_4_0, arg_4_2)

	GetOrAddComponent(arg_4_2:Find("owner"), typeof(CanvasGroup)).alpha = var_4_0.count == var_4_0.config.count and 0.5 or 1

	setActive(arg_4_2:Find("new"), var_4_0.config.is_new == "1")

	return
end

function ShadowCityCollectPage:IsShowingPopWindow()
	return self.msgBox and self.msgBox:isShowing() or false
end

function ShadowCityCollectPage:ClosePopWindow()
	if self.msgBox and self.msgBox:isShowing() then
		self.msgBox:Hide()
	end

	return
end

return ShadowCityCollectPage
