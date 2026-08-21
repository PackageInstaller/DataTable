local var_0_0 = class("MsgboxLayer", import("view.base.BaseUI"))
local var_0_1 = require("Mgr.const.MsgboxBtnNameMap")

var_0_0.BUTTON_BLUE = 1
var_0_0.BUTTON_GRAY = 2
var_0_0.BUTTON_RED = 3
var_0_0.BUTTON_MEDAL = 4
var_0_0.BUTTON_RETREAT = 5
var_0_0.BUTTON_PREPAGE = 6
var_0_0.BUTTON_NEXTPAGE = 7
var_0_0.BUTTON_BLUE_WITH_ICON = 8
var_0_0.TITLE_INFORMATION = "infomation"
var_0_0.TITLE_SETTING = "setting"
var_0_0.TITLE_WARNING = "warning"
var_0_0.TITLE_OBTAIN = "obtain"
var_0_0.TITLE_CADPA = "cadpa"
var_0_0.TEXT_CANCEL = "text_cancel"
var_0_0.TEXT_CONFIRM = "text_confirm"

function var_0_0.getUIName(arg_1_0)
	return "MsgBoxUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0._window = arg_2_0._tf:Find("window")

	setActive(arg_2_0._window, true)

	arg_2_0._top = arg_2_0._window:Find("top")
	arg_2_0._titleList = arg_2_0._top:Find("bg")
	arg_2_0._closeBtn = arg_2_0._top:Find("btnBack")

	setText(arg_2_0._titleList:Find("infomation/title"), i18n("words_information"))
	setText(arg_2_0._titleList:Find("cadpa/title"), i18n("cadpa_tip1"))

	arg_2_0._res = arg_2_0._tf:Find("res")
	arg_2_0._msgPanel = arg_2_0._window:Find("msg_panel")
	arg_2_0.contentText = arg_2_0._msgPanel:Find("content"):GetComponent("RichText")

	arg_2_0.contentText:AddSprite("diamond", arg_2_0._res:Find("diamond"):GetComponent(typeof(Image)).sprite)
	arg_2_0.contentText:AddSprite("gold", arg_2_0._res:Find("gold"):GetComponent(typeof(Image)).sprite)
	arg_2_0.contentText:AddSprite("oil", arg_2_0._res:Find("oil"):GetComponent(typeof(Image)).sprite)
	arg_2_0.contentText:AddSprite("world_money", arg_2_0._res:Find("world_money"):GetComponent(typeof(Image)).sprite)
	arg_2_0.contentText:AddSprite("port_money", arg_2_0._res:Find("port_money"):GetComponent(typeof(Image)).sprite)
	arg_2_0.contentText:AddSprite("guildicon", arg_2_0._res:Find("guildicon"):GetComponent(typeof(Image)).sprite)

	arg_2_0._exchangeShipPanel = arg_2_0._window:Find("exchange_ship_panel")
	arg_2_0._itemPanel = arg_2_0._window:Find("item_panel")
	arg_2_0._itemText = arg_2_0._itemPanel:Find("Text"):GetComponent(typeof(Text))
	arg_2_0._itemListItemContainer = arg_2_0._itemPanel:Find("scrollview/list")
	arg_2_0._itemListItemTpl = arg_2_0._itemListItemContainer:Find("item")
	arg_2_0._eskinPanel = arg_2_0._window:Find("eskin_panel")
	arg_2_0._eskinText = arg_2_0._eskinPanel:Find("Text"):GetComponent(typeof(Text))
	arg_2_0._eskinListItemContainer = arg_2_0._eskinPanel:Find("scrollview/list")
	arg_2_0._eskinListItemTpl = arg_2_0._eskinListItemContainer:Find("item")
	arg_2_0._sigleItemPanel = arg_2_0._window:Find("single_item_panel")
	arg_2_0._singleItemshipTypeTF = arg_2_0._sigleItemPanel:Find("display_panel/name_container/shiptype")
	arg_2_0.singleItemIntro = arg_2_0._sigleItemPanel:Find("display_panel/desc/Text")

	local var_2_0 = arg_2_0.singleItemIntro:GetComponent("RichText")

	var_2_0:AddSprite("diamond", arg_2_0._res:Find("diamond"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("gold", arg_2_0._res:Find("gold"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("oil", arg_2_0._res:Find("oil"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("world_money", arg_2_0._res:Find("world_money"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("port_money", arg_2_0._res:Find("port_money"):GetComponent(typeof(Image)).sprite)
	var_2_0:AddSprite("world_boss", arg_2_0._res:Find("world_boss"):GetComponent(typeof(Image)).sprite)

	arg_2_0._singleItemSubIntroTF = arg_2_0._sigleItemPanel:Find("sub_intro")

	setText(arg_2_0._sigleItemPanel:Find("ship_group/locked/Text"), i18n("tag_ship_locked"))
	setText(arg_2_0._sigleItemPanel:Find("ship_group/unlocked/Text"), i18n("tag_ship_unlocked"))

	arg_2_0._inputPanel = arg_2_0._window:Find("input_panel")
	arg_2_0._inputTitle = arg_2_0._inputPanel:Find("label"):GetComponent(typeof(Text))
	arg_2_0._inputTF = arg_2_0._inputPanel:Find("InputField")
	arg_2_0._inputField = arg_2_0._inputTF:GetComponent(typeof(InputField))
	arg_2_0._placeholderTF = arg_2_0._inputTF:Find("Placeholder"):GetComponent(typeof(Text))
	arg_2_0._inputConfirmBtn = arg_2_0._inputPanel:Find("btns/confirm_btn")
	arg_2_0._inputCancelBtn = arg_2_0._inputPanel:Find("btns/cancel_btn")
	arg_2_0._helpPanel = arg_2_0._window:Find("help_panel")
	arg_2_0._helpBgTF = arg_2_0._tf:Find("bg_help")
	arg_2_0._helpList = arg_2_0._helpPanel:Find("list")
	arg_2_0._helpTpl = arg_2_0._helpPanel:Find("list/help_tpl")
	arg_2_0._worldResetPanel = arg_2_0._window:Find("world_reset_panel")
	arg_2_0._worldShopBtn = arg_2_0._window:Find("world_shop_btn")
	arg_2_0._remasterPanel = arg_2_0._window:Find("remaster_info")
	arg_2_0._obtainPanel = arg_2_0._window:Find("obtain_panel")
	arg_2_0._otherPanel = arg_2_0._window:Find("other_panel")
	arg_2_0._countSelect = arg_2_0._window:Find("count_select")
	arg_2_0._pageUtil = PageUtil.New(arg_2_0._countSelect:Find("value_bg/left"), arg_2_0._countSelect:Find("value_bg/right"), arg_2_0._countSelect:Find("max"), arg_2_0._countSelect:Find("value_bg/value"))
	arg_2_0._countDescTxt = arg_2_0._countSelect:Find("desc_txt")
	arg_2_0._sliders = arg_2_0._window:Find("sliders")
	arg_2_0._discountInfo = arg_2_0._sliders:Find("discountInfo")
	arg_2_0._discountDate = arg_2_0._sliders:Find("discountDate")
	arg_2_0._discount = arg_2_0._sliders:Find("discountInfo/discount")
	arg_2_0._strike = arg_2_0._sliders:Find("strike")
	arg_2_0.stopRemindToggle = arg_2_0._window:Find("stopRemind"):GetComponent(typeof(Toggle))
	arg_2_0.stopRemindText = tf(arg_2_0.stopRemindToggle.gameObject):Find("Label"):GetComponent(typeof(Text))
	arg_2_0._btnContainer = arg_2_0._window:Find("button_container")
	arg_2_0._defaultSize = Vector2(930, 620)
	arg_2_0._defaultHelpSize = Vector2(870, 480)
	arg_2_0._defaultHelpPos = Vector2(0, -40)
	arg_2_0.pools = {}
	arg_2_0.panelDict = {}
	arg_2_0.timers = {}

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:showMsgBox(arg_3_0.contextData)

	return
end

function var_0_0.showMsgBox(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.type or MSGBOX_TYPE_NORMAL

	switch(var_4_0, {
		[MSGBOX_TYPE_NORMAL] = function()
			arg_4_0:showNormalMsgBox(arg_4_1)

			return
		end,
		[MSGBOX_TYPE_HELP] = function()
			arg_4_1.hideNo = defaultValue(arg_4_1.hideNo, true)
			arg_4_1.hideYes = defaultValue(arg_4_1.hideYes, true)

			arg_4_0:showHelpWindow(arg_4_1)

			return
		end
	})

	return
end

function var_0_0.showNormalMsgBox(arg_7_0, arg_7_1)
	arg_7_0:commonSetting(arg_7_1)
	SetActive(arg_7_0._msgPanel, true)

	arg_7_0.contentText.alignment = arg_7_0.settings.alignment or TextAnchor.MiddleCenter
	arg_7_0.contentText.fontSize = arg_7_0.settings.fontSize or 36
	arg_7_0.contentText.text = arg_7_0.settings.content or ""

	arg_7_0:Loaded(arg_7_1)

	return
end

function var_0_0.showHelpWindow(arg_8_0, arg_8_1)
	arg_8_0:commonSetting(arg_8_1)
	setActive(findTF(arg_8_0._helpPanel, "bg"), not arg_8_1.helps.pageMode)
	setActive(arg_8_0._helpBgTF, arg_8_1.helps.pageMode)
	setActive(arg_8_0._helpPanel:Find("btn_blueprint"), arg_8_1.show_blueprint)

	if arg_8_1.show_blueprint then
		onButton(arg_8_0, arg_8_0._helpPanel:Find("btn_blueprint"), function()
			arg_8_0:hide()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT, {
				shipGroupId = arg_8_1.show_blueprint
			})

			return
		end, SFX_PANEL)
	end

	if arg_8_1.helps.helpSize then
		local var_8_0 = arg_8_1.helps.helpSize.x or arg_8_0._defaultHelpSize.x
		local var_8_1 = arg_8_1.helps.helpSize.y or arg_8_0._defaultHelpSize.y

		arg_8_0._helpPanel.sizeDelta = Vector2(var_8_0, var_8_1)
	end

	if arg_8_1.helps.helpPos then
		({}).x = arg_8_1.helps.helpPos.x or arg_8_0._defaultHelpPos.x
		;({}).y = arg_8_1.helps.helpPos.y or arg_8_0._defaultHelpPos.y

		setAnchoredPosition(arg_8_0._helpPanel, {})
	end

	if arg_8_1.helps.windowSize then
		local var_8_2 = arg_8_1.helps.windowSize.x or arg_8_0._defaultSize.x
		local var_8_3 = arg_8_1.helps.windowSize.y or arg_8_0._defaultSize.y

		arg_8_0._window.sizeDelta = Vector2(var_8_2, var_8_3)
	end

	if arg_8_1.helps.windowPos then
		local var_8_4 = arg_8_1.helps.windowSize.x or arg_8_0._defaultSize.x
		local var_8_5 = arg_8_1.helps.windowSize.y or arg_8_0._defaultSize.y

		arg_8_0._window.sizeDelta = Vector2(var_8_4, var_8_5)
		;({}).x = arg_8_1.helps.windowPos.x or 0
		;({}).y = arg_8_1.helps.windowPos.y or 0

		setAnchoredPosition(arg_8_0._window, {})
	else
		setAnchoredPosition(arg_8_0._window, {
			x = 0,
			y = 0
		})
	end

	if arg_8_1.helps.buttonsHeight then
		setAnchoredPosition(arg_8_0._btnContainer, {
			y = arg_8_1.helps.buttonsHeight
		})
	end

	if arg_8_1.helps.disableScroll then
		SetCompomentEnabled(arg_8_0._helpPanel:Find("list"), typeof(ScrollRect), not arg_8_1.helps.disableScroll)
		setAnchoredPosition(arg_8_0._helpPanel:Find("list"), Vector2.zero)
		setActive(findTF(arg_8_0._helpPanel, "Scrollbar"), false)
	end

	if arg_8_1.helps.ImageMode then
		setActive(arg_8_0._top, false)
		setActive(findTF(arg_8_0._window, "bg"), false)
	end

	local var_8_6 = arg_8_0.settings.helps

	for iter_8_0 = #arg_8_0.settings.helps, arg_8_0._helpList.childCount - 1 do
		Destroy(arg_8_0._helpList:GetChild(iter_8_0))
	end

	for iter_8_1 = arg_8_0._helpList.childCount, #var_8_6 - 1 do
		cloneTplTo(arg_8_0._helpTpl, arg_8_0._helpList)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_6) do
		local var_8_7 = arg_8_0._helpList:GetChild(iter_8_2 - 1)

		setActive(var_8_7, true)

		local var_8_8 = var_8_7:Find("icon")

		setActive(var_8_8, iter_8_3.icon)
		setActive(findTF(var_8_7, "line"), iter_8_3.line)

		if iter_8_3.icon then
			local var_8_9 = 1

			if arg_8_1.helps.ImageMode then
				var_8_9 = 1.5
			end

			local var_8_10 = var_8_8.transform
			local var_8_11 = iter_8_3.icon.scale or var_8_9
			local var_8_12 = iter_8_3.icon.scale or var_8_9

			var_8_10.localScale = Vector2(var_8_11, var_8_12)

			if iter_8_3.icon.posX then
				local var_8_14 = iter_8_3.icon.posX or -20

				if iter_8_3.icon.posY then
					local var_8_15 = iter_8_3.icon.posY
					local var_8_16

					if not iter_8_3.icon.posY then
						var_8_15 = 0
						var_8_16 = var_8_8:GetComponent(typeof(Image))
					end

					setImageSprite(var_8_16, LoadSprite(iter_8_3.icon.atlas, iter_8_3.icon.path), true)
					setAnchoredPosition(var_8_8, {
						x = var_8_14,
						y = var_8_15
					})
					setActive(var_8_8:Find("corner"), arg_8_1.helps.pageMode)

					local var_8_17 = var_8_7:Find("richText"):GetComponent("RichText")
					local var_8_20

					if iter_8_3.rawIcon then
						var_8_17:AddSprite(iter_8_3.rawIcon.name, GetSpriteFromAtlas(iter_8_3.rawIcon.atlas, iter_8_3.rawIcon.name))

						local var_8_18 = iter_8_3.info or ""
						local var_8_19 = HXSet.hxLan(var_8_18)

						setText(var_8_7, "")

						var_8_17.text = string.format("<icon name=%s w=0.7 h=0.7/>%s", iter_8_3.rawIcon.name, var_8_19)

						goto label_8_0

						var_8_20 = iter_8_3.info and SwitchSpecialChar(iter_8_3.info, true) or ""
					end

					setText(var_8_7, HXSet.hxLan(var_8_20))

					::label_8_0::

					setActive(var_8_17.gameObject, iter_8_3.rawIcon)
				end
			end
		end
	end

	arg_8_0.helpPage = arg_8_1.helps.defaultpage or 1

	if arg_8_1.helps.pageMode then
		arg_8_0:switchHelpPage(arg_8_0.helpPage)
	end

	arg_8_0:Loaded(arg_8_1)

	return
end

function var_0_0.switchHelpPage(arg_10_0, arg_10_1)
	for iter_10_0 = 1, arg_10_0._helpList.childCount do
		local var_10_0 = arg_10_0._helpList:GetChild(iter_10_0 - 1)

		setActive(var_10_0, arg_10_1 == iter_10_0)
		setText(var_10_0:Find("icon/corner/Text"), iter_10_0)
	end

	return
end

function var_0_0.commonSetting(arg_11_0, arg_11_1)
	rtf(arg_11_0._window).sizeDelta = arg_11_0._defaultSize
	rtf(arg_11_0._helpPanel).sizeDelta = arg_11_0._defaultHelpSize
	arg_11_0.enable = true

	setActive(arg_11_0._msgPanel, false)
	setActive(arg_11_0._exchangeShipPanel, false)
	setActive(arg_11_0._itemPanel, false)
	setActive(arg_11_0._sigleItemPanel, false)
	setActive(arg_11_0._inputPanel, false)
	setActive(arg_11_0._obtainPanel, false)
	setActive(arg_11_0._otherPanel, false)
	setActive(arg_11_0._worldResetPanel, false)
	setActive(arg_11_0._worldShopBtn, false)
	setActive(arg_11_0._helpBgTF, false)
	setActive(arg_11_0._helpPanel, arg_11_1.helps)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.panelDict) do
		iter_11_1.buffer:Hide()
	end

	setActive(arg_11_0._btnContainer, true)

	arg_11_0.stopRemindToggle.isOn = arg_11_1.toggleStatus or false

	setActive(go(arg_11_0.stopRemindToggle), arg_11_1.showStopRemind)

	arg_11_0.stopRemindText.text = arg_11_1.stopRamindContent or i18n("dont_remind_today")

	removeAllChildren(arg_11_0._btnContainer)

	arg_11_0.settings = arg_11_1

	SetActive(arg_11_0._go, true)

	local var_11_0 = arg_11_0.settings.needCounter or false

	setActive(arg_11_0._countSelect, var_11_0)

	local var_11_1 = arg_11_0.settings.numUpdate
	local var_11_2 = arg_11_0.settings.addNum or 1
	local var_11_3 = arg_11_0.settings.maxNum or -1
	local var_11_4 = arg_11_0.settings.defaultNum or 1

	arg_11_0._pageUtil:setNumUpdate(function(arg_12_0)
		if var_11_1 ~= nil then
			var_11_1(arg_11_0._countDescTxt, arg_12_0)
		end

		return
	end)
	arg_11_0._pageUtil:setAddNum(var_11_2)
	arg_11_0._pageUtil:setMaxNum(var_11_3)
	arg_11_0._pageUtil:setDefaultNum(var_11_4)
	setActive(arg_11_0._sliders, arg_11_0.settings.discount)

	if arg_11_0.settings.discount then
		arg_11_0._discount:GetComponent(typeof(Text)).text = arg_11_0.settings.discount.discount .. "%OFF"
		arg_11_0._discountDate:GetComponent(typeof(Text)).text = arg_11_0.settings.discount.date
	end

	setActive(arg_11_0._remasterPanel, arg_11_0.settings.remaster)

	if arg_11_0.settings.remaster then
		local var_11_5 = arg_11_0.settings.remaster

		setText(arg_11_0._remasterPanel:Find("content/Text"), arg_11_0.settings.remaster.word)

		local var_11_6 = arg_11_0.settings.remaster.number or ""

		setText(arg_11_0._remasterPanel:Find("content/count"), var_11_6)
		setText(arg_11_0._remasterPanel:Find("btn/pic"), arg_11_0.settings.remaster.btn_text)
		onButton(arg_11_0, arg_11_0._remasterPanel:Find("btn"), function()
			if var_11_5.btn_call then
				var_11_5.btn_call()
			end

			arg_11_0:hide()

			return
		end)
	end

	local var_11_7 = arg_11_0.settings.hideNo or false
	local var_11_8 = arg_11_0.settings.hideYes or false
	local var_11_9 = arg_11_0.settings.modal or false
	local var_11_10 = arg_11_0.settings.onYes or function()
		return
	end
	local var_11_11 = arg_11_0.settings.onNo or function()
		return
	end

	onButton(arg_11_0, tf(arg_11_0._go):Find("bg"), function()
		if arg_11_0.settings.onClose then
			arg_11_0.settings.onClose()
		else
			var_11_11()
		end

		arg_11_0:hide()

		return
	end, SFX_CANCEL)
	SetCompomentEnabled(tf(arg_11_0._go):Find("bg"), typeof(Button), not var_11_9)

	local var_11_13

	if not var_11_7 then
		({}).text = arg_11_0.settings.noText or var_0_0.TEXT_CANCEL
		;({}).btnType = arg_11_0.settings.noBtnType or var_0_0.BUTTON_GRAY
		;({}).onCallback = var_11_11
		;({}).sound = arg_11_1.noSound or SFX_CANCEL

		local var_11_14 = arg_11_0:createBtn({})
	end

	if not var_11_8 then
		({}).text = arg_11_0.settings.yesText or var_0_0.TEXT_CONFIRM
		;({}).btnType = arg_11_0.settings.yesBtnType or var_0_0.BUTTON_BLUE
		;({}).onCallback = var_11_10
		;({}).sound = arg_11_1.yesSound or SFX_CONFIRM
		;({}).alignment = arg_11_0.settings.yesSize and TextAnchor.MiddleCenter
		var_11_13 = arg_11_0:createBtn({})

		if arg_11_0.settings.yesSize then
			var_11_13.sizeDelta = arg_11_0.settings.yesSize
		end

		setGray(var_11_13, arg_11_0.settings.yesGray, true)
	end

	if arg_11_0.settings.yseBtnLetf then
		var_11_13:SetAsFirstSibling()
	end

	if arg_11_0.settings.custom ~= nil then
		for iter_11_2, iter_11_3 in ipairs(arg_11_0.settings.custom) do
			arg_11_0:createBtn(iter_11_3)
		end
	end

	setActive(arg_11_0._closeBtn, not arg_11_1.hideClose)
	onButton(arg_11_0, arg_11_0._closeBtn, function()
		if arg_11_0.settings and arg_11_0.settings.hideClose and not arg_11_0.settings.onClose and arg_11_0.settings.onYes then
			arg_11_0.settings.onYes()
		end

		arg_11_0:hide()

		if arg_11_0.settings.onClose then
			arg_11_0.settings.onClose()
		else
			var_11_11()
		end

		return
	end, SFX_CANCEL)

	local var_11_15 = arg_11_0.settings.title or var_0_0.TITLE_INFORMATION
	local var_11_16 = 0

	while var_11_16 < arg_11_0._titleList.transform.childCount do
		local var_11_17 = arg_11_0._titleList.transform:GetChild(var_11_16)

		SetActive(var_11_17, var_11_17.name == var_11_15)

		var_11_16 = var_11_16 + 1
	end

	local var_11_18 = arg_11_0._go.transform.localPosition.y
	local var_11_19 = arg_11_0.settings.zIndex or 0

	arg_11_0._go.transform.localPosition = Vector3(arg_11_0._go.transform.localPosition.x, var_11_18, var_11_19)
	arg_11_0.locked = arg_11_0.settings.locked or false

	arg_11_0:AddSprites()

	return
end

function var_0_0.AddSprites(arg_18_0)
	local var_18_0 = arg_18_0.contextData.contextSprites or {}

	table.Foreach(var_18_0, function(arg_19_0, arg_19_1)
		arg_18_0.contentText:AddSprite(arg_19_1.name, LoadSprite(arg_19_1.path, arg_19_1.name))

		return
	end)

	return
end

function var_0_0.createBtn(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.btnType or var_0_0.BUTTON_BLUE
	local var_20_1 = arg_20_1.noQuit
	local var_20_2 = cloneTplTo(arg_20_0._go.transform:Find("custom_btn_list/custom_button_" .. var_20_0), arg_20_0._btnContainer)

	if arg_20_1.label then
		go(var_20_2).name = arg_20_1.label
	end

	SetActive(var_20_2, true)

	if arg_20_1.scale then
		local var_20_3 = arg_20_1.scale.x or 1
		local var_20_4 = arg_20_1.scale.y or 1

		var_20_2.localScale = Vector2(var_20_3, var_20_4)
	end

	if var_20_0 == var_0_0.BUTTON_MEDAL then
		setText(var_20_2:Find("text"), arg_20_1.text)
	elseif var_20_0 ~= var_0_0.BUTTON_RETREAT and var_20_0 ~= var_0_0.BUTTON_PREPAGE and var_20_0 ~= var_0_0.BUTTON_NEXTPAGE then
		arg_20_0:updateButton(var_20_2, arg_20_1.text, arg_20_1.alignment)
	end

	if var_20_0 == var_0_0.BUTTON_BLUE_WITH_ICON and arg_20_1.iconName then
		setImageSprite(var_20_2:Find("ticket/icon"), LoadSprite(arg_20_1.iconName[1], arg_20_1.iconName[2]))
	end

	if not arg_20_1.hideEvent then
		local var_20_5 = arg_20_1.sound or SFX_CONFIRM

		onButton(arg_20_0, var_20_2, function()
			if type(var_20_1) == "function" then
				if var_20_1() then
					return
				else
					arg_20_0:hide()
				end
			elseif not var_20_1 then
				arg_20_0:hide()
			end

			return existCall(arg_20_1.onCallback)
		end, var_20_5)
	end

	if arg_20_1.sibling then
		var_20_2:SetSiblingIndex(arg_20_1.sibling)
	end

	return var_20_2
end

function var_0_0.updateButton(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_1:Find("pic")

	if IsNil(var_22_0) then
		return
	end

	if var_0_1[arg_22_2] then
		setText(var_22_0, i18n(var_0_1[arg_22_2]))
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

function var_0_0.Loaded(arg_23_0, arg_23_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_23_0._tf, {
		groupName = arg_23_1.groupName,
		parent = arg_23_1.parent
	})
	pg.m02:sendNotification(GAME.OPEN_MSGBOX_DONE)

	return
end

function var_0_0.Clear(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.panelDict) do
		iter_24_1:Destroy()
	end

	table.clear(arg_24_0.panelDict)

	rtf(arg_24_0._window).sizeDelta = arg_24_0._defaultSize
	rtf(arg_24_0._helpPanel).sizeDelta = arg_24_0._defaultHelpSize

	setAnchoredPosition(arg_24_0._window, {
		x = 0,
		y = 0
	})
	setAnchoredPosition(arg_24_0._btnContainer, {
		y = 15
	})
	setAnchoredPosition(arg_24_0._helpPanel, {
		x = arg_24_0._defaultHelpPos.x,
		y = arg_24_0._defaultHelpPos.y
	})
	SetCompomentEnabled(arg_24_0._helpPanel:Find("list"), typeof(ScrollRect), true)
	setActive(arg_24_0._top, true)
	setActive(findTF(arg_24_0._window, "bg"), true)
	setActive(arg_24_0._sigleItemPanel:Find("left/own"), false)

	local var_24_0 = arg_24_0._sigleItemPanel:Find("left/IconTpl")

	SetCompomentEnabled(var_24_0:Find("icon_bg"), typeof(Image), true)
	SetCompomentEnabled(var_24_0:Find("icon_bg/frame"), typeof(Image), true)
	setActive(var_24_0:Find("icon_bg/slv"), false)

	local var_24_1 = findTF(var_24_0, "icon_bg/icon")

	var_24_1.pivot = Vector2(0.5, 0.5)
	var_24_1.sizeDelta = Vector2(-4, -4)
	var_24_1.anchoredPosition = Vector2(0, 0)

	setActive(arg_24_0.singleItemIntro, false)
	setText(arg_24_0._singleItemSubIntroTF, "")

	for iter_24_2 = 0, arg_24_0._helpList.childCount - 1 do
		local var_24_2 = arg_24_0._helpList:GetChild(iter_24_2):Find("icon")

		var_24_2:GetComponent(typeof(Image)).sprite = nil
	end

	for iter_24_3, iter_24_4 in pairs(arg_24_0.pools) do
		if iter_24_4 then
			PoolMgr.GetInstance():ReturnUI(iter_24_4.name, iter_24_4)
		end
	end

	arg_24_0.pools = {}

	for iter_24_5, iter_24_6 in pairs(arg_24_0.timers) do
		iter_24_6:Stop()
	end

	arg_24_0.timers = {}

	removeAllChildren(arg_24_0._btnContainer)
	arg_24_0.contentText:RemoveAllListeners()

	arg_24_0.settings = nil
	arg_24_0.enable = false
	arg_24_0.locked = nil

	return
end

function var_0_0.willExit(arg_25_0)
	arg_25_0._pageUtil:Dispose()

	return
end

function var_0_0.hide(arg_26_0)
	if not arg_26_0.enable then
		return
	end

	arg_26_0:Clear()
	arg_26_0:closeView()
	pg.m02:sendNotification(GAME.CLOSE_MSGBOX_DONE)

	return
end

return var_0_0
