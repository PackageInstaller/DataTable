local IslandMsgBoxSingleItemWindow = class("IslandMsgBoxSingleItemWindow", import(".IslandCommonMsgboxWindow"))

function IslandMsgBoxSingleItemWindow:getUIName()
	return "IslandCommonMsgBoxWithSingleItem"
end

function IslandMsgBoxSingleItemWindow:OnLoaded()
	IslandMsgBoxSingleItemWindow.super.OnLoaded(self)

	self.itemTr = self._tf:Find("IslandItemTpl")
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.ownTxt = self._tf:Find("own"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("way/Viewport/list"), self._tf:Find("way/Viewport/list/tpl"))
	self.contentTF = self._tf:Find("way/Viewport/list")

	setText(self._tf:Find("label/Text"), i18n("island_get_way"))

	return
end

function IslandMsgBoxSingleItemWindow:OnShow()
	IslandMsgBoxSingleItemWindow.super.OnShow(self)
	self:FlushMain(self.settings.itemId)
	self:FlushAcquiringWay(self.settings.itemId)

	return
end

function IslandMsgBoxSingleItemWindow:FlushMain(arg_4_1)
	self.nameTxt.text = pg.island_item_data_template[arg_4_1].name
	self.contentTxt.text = pg.island_item_data_template[arg_4_1].desc
	self.ownTxt.text = i18n("island_own_cnt") .. setColorStr(getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(arg_4_1), "#39beff")

	updateCustomDrop(self.itemTr, (Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_4_1
	})))

	return
end

function IslandMsgBoxSingleItemWindow:FlushAcquiringWay(arg_5_1)
	local var_5_0 = IslandItem.New({
		num = 0,
		id = arg_5_1
	}):GetAcquiringWay()
	local var_5_1 = #var_5_0 > 0

	setActive(self._tf:Find("line"), #var_5_0 > 0)
	setActive(self._tf:Find("label"), var_5_1)
	setActive(self._tf:Find("way"), var_5_1)
	self.uiItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]

			setText(arg_6_2:Find("Text"), var_5_0[arg_6_1 + 1][1])
			setText(arg_6_2:Find("go/Text"), i18n("island_word_go"))
			onButton(self, arg_6_2:Find("go"), function()
				local var_7_0 = Clone(var_6_0[2])

				table.remove(var_7_0, 1)
				self:GetMsgBoxMgr():emit(IslandMediator.OPEN_PAGE, var_7_0[1], var_7_0)
				self:Hide()

				return
			end, SFX_PANEL)
			setActive(arg_6_2:Find("go"), var_5_0[arg_6_1 + 1][2] and #var_5_0[arg_6_1 + 1][2] > 0)
		end

		return
	end)
	self.uiItemList:align(#var_5_0)

	if not IsNil(self.contentTF) then
		setAnchoredPosition(self.contentTF, {
			x = 0,
			y = 0
		})
	end

	return
end

function IslandMsgBoxSingleItemWindow:FlushBtn(arg_8_1)
	setActive(self.cancelBtn, false)

	return
end

return IslandMsgBoxSingleItemWindow
