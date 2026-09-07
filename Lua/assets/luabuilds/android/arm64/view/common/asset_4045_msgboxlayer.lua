local MsgboxLayer = class("MsgboxLayer", import("view.base.BaseUI"))
local MsgboxBtnNameMap = require("Mgr.const.MsgboxBtnNameMap")

MsgboxLayer.BUTTON_BLUE = 1
MsgboxLayer.BUTTON_GRAY = 2
MsgboxLayer.BUTTON_RED = 3
MsgboxLayer.BUTTON_MEDAL = 4
MsgboxLayer.BUTTON_RETREAT = 5
MsgboxLayer.BUTTON_PREPAGE = 6
MsgboxLayer.BUTTON_NEXTPAGE = 7
MsgboxLayer.BUTTON_BLUE_WITH_ICON = 8
MsgboxLayer.TITLE_INFORMATION = "infomation"
MsgboxLayer.TITLE_SETTING = "setting"
MsgboxLayer.TITLE_WARNING = "warning"
MsgboxLayer.TITLE_OBTAIN = "obtain"
MsgboxLayer.TITLE_CADPA = "cadpa"
MsgboxLayer.TEXT_CANCEL = "text_cancel"
MsgboxLayer.TEXT_CONFIRM = "text_confirm"

function MsgboxLayer:getUIName()
	return "MsgBoxUI"
end

function MsgboxLayer:init()
	self._window = self._tf:Find("window")

	setActive(self._window, true)

	self._top = self._window:Find("top")
	self._titleList = self._top:Find("bg")
	self._closeBtn = self._top:Find("btnBack")

	setText(self._titleList:Find("infomation/title"), i18n("words_information"))
	setText(self._titleList:Find("cadpa/title"), i18n("cadpa_tip1"))

	self._res = self._tf:Find("res")
	self._msgPanel = self._window:Find("msg_panel")
	self.contentText = self._msgPanel:Find("content"):GetComponent("RichText")

	self.contentText:AddSprite("diamond", self._res:Find("diamond"):GetComponent(typeof(Image)).sprite)
	self.contentText:AddSprite("gold", self._res:Find("gold"):GetComponent(typeof(Image)).sprite)
	self.contentText:AddSprite("oil", self._res:Find("oil"):GetComponent(typeof(Image)).sprite)
	self.contentText:AddSprite("world_money", self._res:Find("world_money"):GetComponent(typeof(Image)).sprite)
	self.contentText:AddSprite("port_money", self._res:Find("port_money"):GetComponent(typeof(Image)).sprite)
	self.contentText:AddSprite("guildicon", self._res:Find("guildicon"):GetComponent(typeof(Image)).sprite)

	self._exchangeShipPanel = self._window:Find("exchange_ship_panel")
	self._itemPanel = self._window:Find("item_panel")
	self._itemText = self._itemPanel:Find("Text"):GetComponent(typeof(Text))
	self._itemListItemContainer = self._itemPanel:Find("scrollview/list")
	self._itemListItemTpl = self._itemListItemContainer:Find("item")
	self._eskinPanel = self._window:Find("eskin_panel")
	self._eskinText = self._eskinPanel:Find("Text"):GetComponent(typeof(Text))
	self._eskinListItemContainer = self._eskinPanel:Find("scrollview/list")
	self._eskinListItemTpl = self._eskinListItemContainer:Find("item")
	self._sigleItemPanel = self._window:Find("single_item_panel")
	self._singleItemshipTypeTF = self._sigleItemPanel:Find("display_panel/name_container/shiptype")
	self.singleItemIntro = self._sigleItemPanel:Find("display_panel/desc/Text")

	local var_2_0 = self.singleItemIntro:GetComponent("RichText")

	var_2_0:AddSprite("diamond", self._res:Find("diamond"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("gold", self._res:Find("gold"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("oil", self._res:Find("oil"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("world_money", self._res:Find("world_money"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("port_money", self._res:Find("port_money"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("world_boss", self._res:Find("world_boss"):GetComponent(typeof(Image)).sprite)

	self._singleItemSubIntroTF = self._sigleItemPanel:Find("sub_intro")

	setText(self._sigleItemPanel:Find("ship_group/locked/Text"), i18n("tag_ship_locked"))
	setText(self._sigleItemPanel:Find("ship_group/unlocked/Text"), i18n("tag_ship_unlocked"))

	self._inputPanel = self._window:Find("input_panel")
	self._inputTitle = self._inputPanel:Find("label"):GetComponent(typeof(Text))
	self._inputTF = self._inputPanel:Find("InputField")
	self._inputField = self._inputTF:GetComponent(typeof(InputField))
	self._placeholderTF = self._inputTF:Find("Placeholder"):GetComponent(typeof(Text))
	self._inputConfirmBtn = self._inputPanel:Find("btns/confirm_btn")
	self._inputCancelBtn = self._inputPanel:Find("btns/cancel_btn")
	self._helpPanel = self._window:Find("help_panel")
	self._helpBgTF = self._tf:Find("bg_help")
	self._helpList = self._helpPanel:Find("list")
	self._helpTpl = self._helpPanel:Find("list/help_tpl")
	self._worldResetPanel = self._window:Find("world_reset_panel")
	self._worldShopBtn = self._window:Find("world_shop_btn")
	self._remasterPanel = self._window:Find("remaster_info")
	self._obtainPanel = self._window:Find("obtain_panel")
	self._otherPanel = self._window:Find("other_panel")
	self._countSelect = self._window:Find("count_select")
	self._pageUtil = PageUtil.New(self._countSelect:Find("value_bg/left"), self._countSelect:Find("value_bg/right"), self._countSelect:Find("max"), self._countSelect:Find("value_bg/value"))
	self._countDescTxt = self._countSelect:Find("desc_txt")
	self._sliders = self._window:Find("sliders")
	self._discountInfo = self._sliders:Find("discountInfo")
	self._discountDate = self._sliders:Find("discountDate")
	self._discount = self._sliders:Find("discountInfo/discount")
	self._strike = self._sliders:Find("strike")
	self.stopRemindToggle = self._window:Find("stopRemind"):GetComponent(typeof(Toggle))
	self.stopRemindText = tf(self.stopRemindToggle.gameObject):Find("Label"):GetComponent(typeof(Text))
	self._btnContainer = self._window:Find("button_container")
	self._defaultSize = Vector2(930, 620)
	self._defaultHelpSize = Vector2(870, 480)
	self._defaultHelpPos = Vector2(0, -40)
	self.pools = {}
	self.panelDict = {}
	self.timers = {}

	return
end

function MsgboxLayer:didEnter()
	self:showMsgBox(self.contextData)

	return
end

function MsgboxLayer:showMsgBox(arg_4_1)
	switch(arg_4_1.type or MSGBOX_TYPE_NORMAL, {
		[MSGBOX_TYPE_NORMAL] = function()
			self:showNormalMsgBox(arg_4_1)

			return
		end,
		[MSGBOX_TYPE_HELP] = function()
			arg_4_1.hideNo = defaultValue(arg_4_1.hideNo, true)
			arg_4_1.hideYes = defaultValue(arg_4_1.hideYes, true)

			self:showHelpWindow(arg_4_1)

			return
		end
	})

	return
end

function MsgboxLayer:showNormalMsgBox(arg_7_1)
	self:commonSetting(arg_7_1)
	SetActive(self._msgPanel, true)

	self.contentText.alignment = self.settings.alignment or TextAnchor.MiddleCenter
	self.contentText.fontSize = self.settings.fontSize or 36
	self.contentText.text = self.settings.content or ""

	self:Loaded(arg_7_1)

	return
end

function MsgboxLayer:showHelpWindow(arg_8_1)
	self:commonSetting(arg_8_1)
	setActive(findTF(self._helpPanel, "bg"), not arg_8_1.helps.pageMode)
	setActive(self._helpBgTF, arg_8_1.helps.pageMode)
	setActive(self._helpPanel:Find("btn_blueprint"), arg_8_1.show_blueprint)

	if arg_8_1.show_blueprint then
		onButton(self, self._helpPanel:Find("btn_blueprint"), function()
			self:hide()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT, {
				shipGroupId = arg_8_1.show_blueprint
			})

			return
		end, SFX_PANEL)
	end

	if arg_8_1.helps.helpSize then
		self._helpPanel.sizeDelta = Vector2(arg_8_1.helps.helpSize.x or self._defaultHelpSize.x, arg_8_1.helps.helpSize.y or self._defaultHelpSize.y)
	end

	if arg_8_1.helps.helpPos then
		local var_8_1 = {}

		var_8_1.x = arg_8_1.helps.helpPos.x or self._defaultHelpPos.x
		var_8_1.y = arg_8_1.helps.helpPos.y or self._defaultHelpPos.y

		setAnchoredPosition(self._helpPanel, var_8_1)
	end

	if arg_8_1.helps.windowSize then
		self._window.sizeDelta = Vector2(arg_8_1.helps.windowSize.x or self._defaultSize.x, arg_8_1.helps.windowSize.y or self._defaultSize.y)
	end

	if arg_8_1.helps.windowPos then
		self._window.sizeDelta = Vector2(arg_8_1.helps.windowSize.x or self._defaultSize.x, arg_8_1.helps.windowSize.y or self._defaultSize.y)

		local var_8_4 = {}

		var_8_4.x = arg_8_1.helps.windowPos.x or 0
		var_8_4.y = arg_8_1.helps.windowPos.y or 0

		setAnchoredPosition(self._window, var_8_4)
	else
		setAnchoredPosition(self._window, {
			x = 0,
			y = 0
		})
	end

	if arg_8_1.helps.buttonsHeight then
		setAnchoredPosition(self._btnContainer, {
			y = arg_8_1.helps.buttonsHeight
		})
	end

	if arg_8_1.helps.disableScroll then
		SetCompomentEnabled(self._helpPanel:Find("list"), typeof(ScrollRect), not arg_8_1.helps.disableScroll)
		setAnchoredPosition(self._helpPanel:Find("list"), Vector2.zero)
		setActive(findTF(self._helpPanel, "Scrollbar"), false)
	end

	if arg_8_1.helps.ImageMode then
		setActive(self._top, false)
		setActive(findTF(self._window, "bg"), false)
	end

	local var_8_5 = self.settings.helps

	for iter_8_0 = #self.settings.helps, self._helpList.childCount - 1 do
		Destroy(self._helpList:GetChild(iter_8_0))
	end

	for iter_8_1 = self._helpList.childCount, #var_8_5 - 1 do
		cloneTplTo(self._helpTpl, self._helpList)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_5) do
		local var_8_6 = self._helpList:GetChild(iter_8_2 - 1)

		setActive(var_8_6, true)

		local var_8_7 = var_8_6:Find("icon")

		setActive(var_8_7, iter_8_3.icon)
		setActive(findTF(var_8_6, "line"), iter_8_3.line)

		if iter_8_3.icon then
			local var_8_8 = 1

			if arg_8_1.helps.ImageMode then
				var_8_8 = 1.5
			end

			var_8_7.transform.localScale = Vector2(iter_8_3.icon.scale or var_8_8, iter_8_3.icon.scale or var_8_8)

			local var_8_10

			if iter_8_3.icon.posX then
				var_8_10 = iter_8_3.icon.posX or -20

				local var_8_11

				if iter_8_3.icon.posY then
					var_8_11 = iter_8_3.icon.posY

					local var_8_12

					if not iter_8_3.icon.posY then
						var_8_11 = 0
						var_8_12 = var_8_7:GetComponent(typeof(Image))
					end
				end
			end

			setImageSprite(var_8_12, LoadSprite(iter_8_3.icon.atlas, iter_8_3.icon.path), true)
			setAnchoredPosition(var_8_7, {
				x = var_8_10,
				y = var_8_11
			})
			setActive(var_8_7:Find("corner"), arg_8_1.helps.pageMode)
		end

		local var_8_13 = var_8_6:Find("richText"):GetComponent("RichText")

		if iter_8_3.rawIcon then
			var_8_13:AddSprite(iter_8_3.rawIcon.name, GetSpriteFromAtlas(iter_8_3.rawIcon.atlas, iter_8_3.rawIcon.name))

			local var_8_14 = HXSet.hxLan(iter_8_3.info or "")

			setText(var_8_6, "")

			var_8_13.text = string.format("<icon name=%s w=0.7 h=0.7/>%s", iter_8_3.rawIcon.name, var_8_14)
		else
			setText(var_8_6, HXSet.hxLan(iter_8_3.info and SwitchSpecialChar(iter_8_3.info, true) or ""))
		end

		setActive(var_8_13.gameObject, iter_8_3.rawIcon)
	end

	self.helpPage = arg_8_1.helps.defaultpage or 1

	if arg_8_1.helps.pageMode then
		self:switchHelpPage(self.helpPage)
	end

	self:Loaded(arg_8_1)

	return
end

function MsgboxLayer:switchHelpPage(arg_10_1)
	for iter_10_0 = 1, self._helpList.childCount do
		local var_10_0 = self._helpList:GetChild(iter_10_0 - 1)

		setActive(var_10_0, arg_10_1 == iter_10_0)
		setText(var_10_0:Find("icon/corner/Text"), iter_10_0)
	end

	return
end

function MsgboxLayer:commonSetting(arg_11_1)
	rtf(self._window).sizeDelta = self._defaultSize
	rtf(self._helpPanel).sizeDelta = self._defaultHelpSize
	self.enable = true

	setActive(self._msgPanel, false)
	setActive(self._exchangeShipPanel, false)
	setActive(self._itemPanel, false)
	setActive(self._sigleItemPanel, false)
	setActive(self._inputPanel, false)
	setActive(self._obtainPanel, false)
	setActive(self._otherPanel, false)
	setActive(self._worldResetPanel, false)
	setActive(self._worldShopBtn, false)
	setActive(self._helpBgTF, false)
	setActive(self._helpPanel, arg_11_1.helps)

	for iter_11_0, iter_11_1 in pairs(self.panelDict) do
		iter_11_1.buffer:Hide()
	end

	setActive(self._btnContainer, true)

	self.stopRemindToggle.isOn = arg_11_1.toggleStatus or false

	setActive(go(self.stopRemindToggle), arg_11_1.showStopRemind)

	self.stopRemindText.text = arg_11_1.stopRamindContent or i18n("dont_remind_today")

	removeAllChildren(self._btnContainer)

	self.settings = arg_11_1

	SetActive(self._go, true)
	setActive(self._countSelect, self.settings.needCounter or false)

	local var_11_0 = self.settings.numUpdate
	local var_11_1 = self.settings.addNum or 1
	local var_11_2 = self.settings.maxNum or -1
	local var_11_3 = self.settings.defaultNum or 1

	self._pageUtil:setNumUpdate(function(arg_12_0)
		if var_11_0 ~= nil then
			var_11_0(self._countDescTxt, arg_12_0)
		end

		return
	end)
	self._pageUtil:setAddNum(var_11_1)
	self._pageUtil:setMaxNum(var_11_2)
	self._pageUtil:setDefaultNum(var_11_3)
	setActive(self._sliders, self.settings.discount)

	if self.settings.discount then
		self._discount:GetComponent(typeof(Text)).text = self.settings.discount.discount .. "%OFF"
		self._discountDate:GetComponent(typeof(Text)).text = self.settings.discount.date
	end

	setActive(self._remasterPanel, self.settings.remaster)

	if self.settings.remaster then
		local var_11_4 = self.settings.remaster

		setText(self._remasterPanel:Find("content/Text"), self.settings.remaster.word)
		setText(self._remasterPanel:Find("content/count"), self.settings.remaster.number or "")
		setText(self._remasterPanel:Find("btn/pic"), self.settings.remaster.btn_text)
		onButton(self, self._remasterPanel:Find("btn"), function()
			if var_11_4.btn_call then
				var_11_4.btn_call()
			end

			self:hide()

			return
		end)
	end

	local var_11_5 = self.settings.hideNo or false
	local var_11_6 = self.settings.hideYes or false
	local var_11_7 = self.settings.modal or false
	local var_11_8 = self.settings.onYes or function()
		return
	end
	local var_11_9 = self.settings.onNo or function()
		return
	end

	onButton(self, tf(self._go):Find("bg"), function()
		if self.settings.onClose then
			self.settings.onClose()
		else
			var_11_9()
		end

		self:hide()

		return
	end, SFX_CANCEL)
	SetCompomentEnabled(tf(self._go):Find("bg"), typeof(Button), not var_11_7)

	local var_11_11

	if not var_11_5 then
		local var_11_12 = {}

		var_11_12.text = self.settings.noText or MsgboxLayer.TEXT_CANCEL
		var_11_12.btnType = self.settings.noBtnType or MsgboxLayer.BUTTON_GRAY
		var_11_12.onCallback = var_11_9
		var_11_12.sound = arg_11_1.noSound or SFX_CANCEL

		local var_11_13 = self:createBtn(var_11_12)
	end

	if not var_11_6 then
		local var_11_14 = {}

		var_11_14.text = self.settings.yesText or MsgboxLayer.TEXT_CONFIRM
		var_11_14.btnType = self.settings.yesBtnType or MsgboxLayer.BUTTON_BLUE
		var_11_14.onCallback = var_11_8
		var_11_14.sound = arg_11_1.yesSound or SFX_CONFIRM
		var_11_14.alignment = self.settings.yesSize and TextAnchor.MiddleCenter
		var_11_11 = self:createBtn(var_11_14)

		if self.settings.yesSize then
			var_11_11.sizeDelta = self.settings.yesSize
		end

		setGray(var_11_11, self.settings.yesGray, true)
	end

	if self.settings.yseBtnLetf then
		var_11_11:SetAsFirstSibling()
	end

	if self.settings.custom ~= nil then
		for iter_11_2, iter_11_3 in ipairs(self.settings.custom) do
			self:createBtn(iter_11_3)
		end
	end

	setActive(self._closeBtn, not arg_11_1.hideClose)
	onButton(self, self._closeBtn, function()
		if self.settings and self.settings.hideClose and not self.settings.onClose and self.settings.onYes then
			self.settings.onYes()
		end

		self:hide()

		if self.settings.onClose then
			self.settings.onClose()
		else
			var_11_9()
		end

		return
	end, SFX_CANCEL)

	local var_11_15 = self.settings.title or MsgboxLayer.TITLE_INFORMATION
	local var_11_16 = 0

	while var_11_16 < self._titleList.transform.childCount do
		local var_11_17 = self._titleList.transform:GetChild(var_11_16)

		SetActive(var_11_17, var_11_17.name == var_11_15)

		var_11_16 = var_11_16 + 1
	end

	self._go.transform.localPosition = Vector3(self._go.transform.localPosition.x, self._go.transform.localPosition.y, self.settings.zIndex or 0)
	self.locked = self.settings.locked or false

	self:AddSprites()

	return
end

function MsgboxLayer:AddSprites()
	table.Foreach(self.contextData.contextSprites or {}, function(arg_19_0, arg_19_1)
		self.contentText:AddSprite(arg_19_1.name, LoadSprite(arg_19_1.path, arg_19_1.name))

		return
	end)

	return
end

function MsgboxLayer:createBtn(arg_20_1)
	local var_20_0 = arg_20_1.btnType or MsgboxLayer.BUTTON_BLUE
	local var_20_1 = arg_20_1.noQuit
	local var_20_2 = cloneTplTo(self._go.transform:Find("custom_btn_list/custom_button_" .. var_20_0), self._btnContainer)

	if arg_20_1.label then
		go(var_20_2).name = arg_20_1.label
	end

	SetActive(var_20_2, true)

	if arg_20_1.scale then
		var_20_2.localScale = Vector2(arg_20_1.scale.x or 1, arg_20_1.scale.y or 1)
	end

	if var_20_0 == MsgboxLayer.BUTTON_MEDAL then
		setText(var_20_2:Find("text"), arg_20_1.text)
	elseif var_20_0 ~= MsgboxLayer.BUTTON_RETREAT and var_20_0 ~= MsgboxLayer.BUTTON_PREPAGE and var_20_0 ~= MsgboxLayer.BUTTON_NEXTPAGE then
		self:updateButton(var_20_2, arg_20_1.text, arg_20_1.alignment)
	end

	if var_20_0 == MsgboxLayer.BUTTON_BLUE_WITH_ICON and arg_20_1.iconName then
		setImageSprite(var_20_2:Find("ticket/icon"), LoadSprite(arg_20_1.iconName[1], arg_20_1.iconName[2]))
	end

	if not arg_20_1.hideEvent then
		onButton(self, var_20_2, function()
			if type(var_20_1) == "function" then
				if var_20_1() then
					return
				else
					self:hide()
				end
			elseif not var_20_1 then
				self:hide()
			end

			return existCall(arg_20_1.onCallback)
		end, arg_20_1.sound or SFX_CONFIRM)
	end

	if arg_20_1.sibling then
		var_20_2:SetSiblingIndex(arg_20_1.sibling)
	end

	return var_20_2
end

function MsgboxLayer:updateButton(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_1:Find("pic")

	if IsNil(var_22_0) then
		return
	end

	if MsgboxBtnNameMap[arg_22_2] then
		setText(var_22_0, i18n(MsgboxBtnNameMap[arg_22_2]))
	else
		if string.len(arg_22_2) > 12 then
			GetComponent(var_22_0, typeof(Text)).resizeTextForBestFit = true
		end

		setText(var_22_0, arg_22_2)
	end

	if arg_22_3 then
		var_22_0:GetComponent(typeof(Text)).alignment = arg_22_3
	end

	return
end

function MsgboxLayer:Loaded(arg_23_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		groupName = arg_23_1.groupName,
		parent = arg_23_1.parent
	})
	pg.m02:sendNotification(GAME.OPEN_MSGBOX_DONE)

	return
end

function MsgboxLayer:Clear()
	for iter_24_0, iter_24_1 in pairs(self.panelDict) do
		iter_24_1:Destroy()
	end

	table.clear(self.panelDict)

	rtf(self._window).sizeDelta = self._defaultSize
	rtf(self._helpPanel).sizeDelta = self._defaultHelpSize

	setAnchoredPosition(self._window, {
		x = 0,
		y = 0
	})
	setAnchoredPosition(self._btnContainer, {
		y = 15
	})
	setAnchoredPosition(self._helpPanel, {
		x = self._defaultHelpPos.x,
		y = self._defaultHelpPos.y
	})
	SetCompomentEnabled(self._helpPanel:Find("list"), typeof(ScrollRect), true)
	setActive(self._top, true)
	setActive(findTF(self._window, "bg"), true)
	setActive(self._sigleItemPanel:Find("left/own"), false)

	local var_24_0 = self._sigleItemPanel:Find("left/IconTpl")

	SetCompomentEnabled(var_24_0:Find("icon_bg"), typeof(Image), true)
	SetCompomentEnabled(var_24_0:Find("icon_bg/frame"), typeof(Image), true)
	setActive(var_24_0:Find("icon_bg/slv"), false)

	local var_24_1 = findTF(var_24_0, "icon_bg/icon")

	var_24_1.pivot = Vector2(0.5, 0.5)
	var_24_1.sizeDelta = Vector2(-4, -4)
	var_24_1.anchoredPosition = Vector2(0, 0)

	setActive(self.singleItemIntro, false)
	setText(self._singleItemSubIntroTF, "")

	for iter_24_2 = 0, self._helpList.childCount - 1 do
		self._helpList:GetChild(iter_24_2):Find("icon"):GetComponent(typeof(Image)).sprite = nil
	end

	for iter_24_3, iter_24_4 in pairs(self.pools) do
		if iter_24_4 then
			PoolMgr.GetInstance():ReturnUI(iter_24_4.name, iter_24_4)
		end
	end

	self.pools = {}

	for iter_24_5, iter_24_6 in pairs(self.timers) do
		iter_24_6:Stop()
	end

	self.timers = {}

	removeAllChildren(self._btnContainer)
	self.contentText:RemoveAllListeners()

	self.settings = nil
	self.enable = false
	self.locked = nil

	return
end

function MsgboxLayer:willExit()
	self._pageUtil:Dispose()

	return
end

function MsgboxLayer:hide()
	if not self.enable then
		return
	end

	self:Clear()
	self:closeView()
	pg.m02:sendNotification(GAME.CLOSE_MSGBOX_DONE)

	return
end

return MsgboxLayer
