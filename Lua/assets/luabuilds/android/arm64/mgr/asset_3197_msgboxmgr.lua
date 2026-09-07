pg = pg or {}

local var_0_0 = pg
local var_0_1 = singletonClass("MsgboxMgr")

pg.MsgboxMgr = var_0_1
var_0_1.BUTTON_BLUE = 1
var_0_1.BUTTON_GRAY = 2
var_0_1.BUTTON_RED = 3
var_0_1.BUTTON_MEDAL = 4
var_0_1.BUTTON_RETREAT = 5
var_0_1.BUTTON_PREPAGE = 6
var_0_1.BUTTON_NEXTPAGE = 7
var_0_1.BUTTON_BLUE_WITH_ICON = 8
var_0_1.BUTTON_YELLOW = 9
var_0_1.TITLE_INFORMATION = "infomation"
var_0_1.TITLE_SETTING = "setting"
var_0_1.TITLE_WARNING = "warning"
var_0_1.TITLE_OBTAIN = "obtain"
var_0_1.TITLE_CADPA = "cadpa"
var_0_1.TEXT_CANCEL = "text_cancel"
var_0_1.TEXT_CONFIRM = "text_confirm"
MSGBOX_TYPE_NORMAL = 1
MSGBOX_TYPE_INPUT = 2
MSGBOX_TYPE_SINGLE_ITEM = 3
MSGBOX_TYPE_EXCHANGE = 4
MSGBOX_TYPE_DROP_ITEM = 5
MSGBOX_TYPE_ITEM_BOX = 6
MSGBOX_TYPE_HELP = 7
MSGBOX_TYPE_SECONDPWD = 8
MSGBOX_TYPE_OBTAIN = 9
MSGBOX_TYPE_ITEMTIP = 10
MSGBOX_TYPE_JUST_FOR_SHOW = 11
MSGBOX_TYPE_MONTH_CARD_TIP = 12
MSGBOX_TYPE_WORLD_RESET = 13
MSGBOX_TYPE_WORLD_STAMINA_EXCHANGE = 14
MSGBOX_TYPE_STORY_CANCEL_TIP = 15
MSGBOX_TYPE_META_SKILL_UNLOCK = 16
MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON = 17
MSGBOX_TYPE_ACCOUNTDELETE = 18
MSGBOX_TYPE_STRENGTHEN_BACK = 19
MSGBOX_TYPE_CONTENT_ITEMS = 20
MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM = 21
MSGBOX_TYPE_CONFIRM_DELETE = 22
MSGBOX_TYPE_SUBPATTERN = 23
MSGBOX_TYPE_FILE_DOWNLOAD = 24
MSGBOX_TYPE_LIKN_COLLECT_GUIDE = 25
MSGBOX_TYPE_DROP_ITEM_ESKIN = 26
var_0_1.enable = false

local MsgboxBtnNameMap = require("Mgr.const.MsgboxBtnNameMap")

function var_0_1.Init(arg_1_0, arg_1_1)
	print("initializing msgbox manager...")
	LoadAndInstantiateAsync("ui", "MsgBox", function(arg_2_0)
		arg_1_0._go = arg_2_0

		arg_1_0._go:SetActive(false)

		arg_1_0._tf = arg_1_0._go.transform

		arg_1_0._tf:SetParent(var_0_0.UIMgr.GetInstance().OverlayMain, false)

		arg_1_0._window = arg_1_0._tf:Find("window")

		setActive(arg_1_0._window, true)

		arg_1_0._top = arg_1_0._window:Find("top")
		arg_1_0._titleList = arg_1_0._top:Find("bg")
		arg_1_0._closeBtn = arg_1_0._top:Find("btnBack")

		setText(arg_1_0._titleList:Find("infomation/title"), i18n("words_information"))
		setText(arg_1_0._titleList:Find("cadpa/title"), i18n("cadpa_tip1"))

		arg_1_0._res = arg_1_0._tf:Find("res")
		arg_1_0._msgPanel = arg_1_0._window:Find("msg_panel")
		arg_1_0.contentText = arg_1_0._msgPanel:Find("content"):GetComponent("RichText")

		arg_1_0.contentText:AddSprite("diamond", arg_1_0._res:Find("diamond"):GetComponent(typeof(Image)).sprite)
		arg_1_0.contentText:AddSprite("gold", arg_1_0._res:Find("gold"):GetComponent(typeof(Image)).sprite)
		arg_1_0.contentText:AddSprite("oil", arg_1_0._res:Find("oil"):GetComponent(typeof(Image)).sprite)
		arg_1_0.contentText:AddSprite("world_money", arg_1_0._res:Find("world_money"):GetComponent(typeof(Image)).sprite)
		arg_1_0.contentText:AddSprite("port_money", arg_1_0._res:Find("port_money"):GetComponent(typeof(Image)).sprite)
		arg_1_0.contentText:AddSprite("guildicon", arg_1_0._res:Find("guildicon"):GetComponent(typeof(Image)).sprite)

		arg_1_0._exchangeShipPanel = arg_1_0._window:Find("exchange_ship_panel")
		arg_1_0._itemPanel = arg_1_0._window:Find("item_panel")
		arg_1_0._itemText = arg_1_0._itemPanel:Find("Text"):GetComponent(typeof(Text))
		arg_1_0._itemListItemContainer = arg_1_0._itemPanel:Find("scrollview/list")
		arg_1_0._itemListItemTpl = arg_1_0._itemListItemContainer:Find("item")
		arg_1_0._eskinPanel = arg_1_0._window:Find("eskin_panel")
		arg_1_0._eskinText = arg_1_0._eskinPanel:Find("Text"):GetComponent(typeof(Text))
		arg_1_0._eskinListItemContainer = arg_1_0._eskinPanel:Find("scrollview/list")
		arg_1_0._eskinListItemTpl = arg_1_0._eskinListItemContainer:Find("item")
		arg_1_0._sigleItemPanel = arg_1_0._window:Find("single_item_panel")
		arg_1_0._singleItemshipTypeTF = arg_1_0._sigleItemPanel:Find("display_panel/name_container/shiptype")
		arg_1_0.singleItemIntro = arg_1_0._sigleItemPanel:Find("display_panel/desc/Text")

		local var_2_0 = arg_1_0.singleItemIntro:GetComponent("RichText")

		var_2_0:AddSprite("diamond", arg_1_0._res:Find("diamond"):GetComponent(typeof(Image)).sprite)
		var_2_0:AddSprite("gold", arg_1_0._res:Find("gold"):GetComponent(typeof(Image)).sprite)
		var_2_0:AddSprite("oil", arg_1_0._res:Find("oil"):GetComponent(typeof(Image)).sprite)
		var_2_0:AddSprite("world_money", arg_1_0._res:Find("world_money"):GetComponent(typeof(Image)).sprite)
		var_2_0:AddSprite("port_money", arg_1_0._res:Find("port_money"):GetComponent(typeof(Image)).sprite)
		var_2_0:AddSprite("world_boss", arg_1_0._res:Find("world_boss"):GetComponent(typeof(Image)).sprite)

		arg_1_0._singleItemSubIntroTF = arg_1_0._sigleItemPanel:Find("sub_intro")

		setText(arg_1_0._sigleItemPanel:Find("ship_group/locked/Text"), i18n("tag_ship_locked"))
		setText(arg_1_0._sigleItemPanel:Find("ship_group/unlocked/Text"), i18n("tag_ship_unlocked"))

		arg_1_0._inputPanel = arg_1_0._window:Find("input_panel")
		arg_1_0._inputTitle = arg_1_0._inputPanel:Find("label"):GetComponent(typeof(Text))
		arg_1_0._inputTF = arg_1_0._inputPanel:Find("InputField")
		arg_1_0._inputField = arg_1_0._inputTF:GetComponent(typeof(InputField))
		arg_1_0._placeholderTF = arg_1_0._inputTF:Find("Placeholder"):GetComponent(typeof(Text))
		arg_1_0._inputConfirmBtn = arg_1_0._inputPanel:Find("btns/confirm_btn")
		arg_1_0._inputCancelBtn = arg_1_0._inputPanel:Find("btns/cancel_btn")
		arg_1_0._helpPanel = arg_1_0._window:Find("help_panel")
		arg_1_0._helpBgTF = arg_1_0._tf:Find("bg_help")
		arg_1_0._helpList = arg_1_0._helpPanel:Find("list")
		arg_1_0._helpTpl = arg_1_0._helpPanel:Find("list/help_tpl")
		arg_1_0._worldResetPanel = arg_1_0._window:Find("world_reset_panel")
		arg_1_0._worldShopBtn = arg_1_0._window:Find("world_shop_btn")
		arg_1_0._remasterPanel = arg_1_0._window:Find("remaster_info")
		arg_1_0._obtainPanel = arg_1_0._window:Find("obtain_panel")
		arg_1_0._otherPanel = arg_1_0._window:Find("other_panel")
		arg_1_0._countSelect = arg_1_0._window:Find("count_select")
		arg_1_0._pageUtil = PageUtil.New(arg_1_0._countSelect:Find("value_bg/left"), arg_1_0._countSelect:Find("value_bg/right"), arg_1_0._countSelect:Find("max"), arg_1_0._countSelect:Find("value_bg/value"))
		arg_1_0._countDescTxt = arg_1_0._countSelect:Find("desc_txt")
		arg_1_0._sliders = arg_1_0._window:Find("sliders")
		arg_1_0._discountInfo = arg_1_0._sliders:Find("discountInfo")
		arg_1_0._discountDate = arg_1_0._sliders:Find("discountDate")
		arg_1_0._discount = arg_1_0._sliders:Find("discountInfo/discount")
		arg_1_0._strike = arg_1_0._sliders:Find("strike")
		arg_1_0.stopRemindToggle = arg_1_0._window:Find("stopRemind"):GetComponent(typeof(Toggle))
		arg_1_0.stopRemindText = tf(arg_1_0.stopRemindToggle.gameObject):Find("Label"):GetComponent(typeof(Text))
		arg_1_0._btnContainer = arg_1_0._window:Find("button_container")
		arg_1_0._defaultSize = Vector2(930, 620)
		arg_1_0._defaultHelpSize = Vector2(870, 480)
		arg_1_0._defaultHelpPos = Vector2(0, -40)
		arg_1_0.pools = {}
		arg_1_0.panelDict = {}
		arg_1_0.timers = {}

		arg_1_1()

		return
	end, true, true)

	return
end

function var_0_1:getMsgBoxOb()
	return self._go
end

local function var_0_3(arg_4_0, arg_4_1)
	arg_4_0:commonSetting(arg_4_1)
	SetActive(arg_4_0._msgPanel, true)

	arg_4_0.contentText.alignment = arg_4_0.settings.alignment or TextAnchor.MiddleCenter
	arg_4_0.contentText.fontSize = arg_4_0.settings.fontSize or 36
	arg_4_0.contentText.text = arg_4_0.settings.content or ""

	arg_4_0:Loaded(arg_4_1)

	return
end

local function var_0_4(arg_5_0, arg_5_1)
	arg_5_0:commonSetting(arg_5_1)
	setActive(arg_5_0._inputPanel, true)
	setActive(arg_5_0._btnContainer, false)

	arg_5_0._inputTitle.text = arg_5_1.title or ""
	arg_5_0._placeholderTF.text = arg_5_1.placeholder or ""
	arg_5_0._inputField.characterLimit = arg_5_1.limit or 0

	setActive(arg_5_0._inputCancelBtn, not arg_5_1.hideNo)
	arg_5_0:updateButton(arg_5_0._inputCancelBtn, arg_5_1.noText or var_0_1.TEXT_CANCEL)
	arg_5_0:updateButton(arg_5_0._inputConfirmBtn, arg_5_1.yesText or var_0_1.TEXT_CONFIRM)
	onButton(arg_5_0, arg_5_0._inputCancelBtn, function()
		arg_5_0:hide()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0._inputConfirmBtn, function()
		if arg_5_1.onYes then
			arg_5_1.onYes(arg_5_0._inputField.text)
		end

		arg_5_0:hide()

		return
	end, SFX_CONFIRM)
	arg_5_0:Loaded(arg_5_1)

	return
end

local function var_0_5(arg_8_0, arg_8_1)
	arg_8_0:commonSetting(arg_8_1)
	SetActive(arg_8_0._exchangeShipPanel, true)
	setActive(findTF(arg_8_0._exchangeShipPanel, "icon_bg/own"), false)
	updateDrop(arg_8_0._exchangeShipPanel, arg_8_1.drop)

	local var_8_0 = arg_8_0._exchangeShipPanel:Find("intro_view/Viewport/intro")

	SetActive(var_8_0, arg_8_1.drop.type == DROP_TYPE_SHIP or arg_8_1.drop.type == DROP_TYPE_RESOURCE or arg_8_1.drop.type == DROP_TYPE_ITEM or arg_8_1.drop.type == DROP_TYPE_FURNITURE or arg_8_1.drop.type == DROP_TYPE_STRATEGY or arg_8_1.drop.type == DROP_TYPE_SKIN or arg_8_1.drop.type == DROP_TYPE_SKIN_TIMELIMIT)

	local var_8_1 = arg_8_0.settings.numUpdate

	setActive(arg_8_0.singleItemIntro, arg_8_0.settings.numUpdate == nil)
	setActive(arg_8_0._countDescTxt, var_8_1 ~= nil)

	local var_8_2 = arg_8_1.name

	if not arg_8_1.name then
		var_8_2 = arg_8_1.drop:getConfig("name")
		var_8_2 = var_8_2 or ""
	end

	setText(arg_8_0._exchangeShipPanel:Find("name_mode/name"), var_8_2)
	setText(arg_8_0._exchangeShipPanel:Find("name_mode/name/name"), getText(arg_8_0._exchangeShipPanel:Find("name_mode/name")))

	local var_8_3, var_8_4, var_8_5 = ShipWordHelper.GetWordAndCV(var_0_0.ship_data_statistics[arg_8_1.drop.id].skin_id, ShipWordHelper.WORD_TYPE_DROP, nil, PLATFORM_CODE ~= PLATFORM_US)

	setText(var_8_0, var_8_5 or i18n("ship_drop_desc_default"))

	if arg_8_1.intro then
		setText(var_8_0, arg_8_1.intro)
	end

	if arg_8_1.enabelYesBtn ~= nil then
		local var_8_6 = arg_8_0._btnContainer:GetChild(1)

		setButtonEnabled(var_8_6, arg_8_1.enabelYesBtn)
		eachChild(var_8_6, function(arg_9_0)
			GetOrAddComponent(arg_9_0, typeof(CanvasGroup)).alpha = arg_8_1.enabelYesBtn and 1 or 0.3

			return
		end)
	end

	if arg_8_1.show_medal then
		arg_8_0:createBtn({
			sibling = 0,
			hideEvent = true,
			text = arg_8_1.show_medal.desc,
			btnType = var_0_1.BUTTON_MEDAL,
			sound = SFX_UI_BUILDING_EXCHANGE
		})
	end

	arg_8_0:Loaded(arg_8_1)

	return
end

local function var_0_6(arg_10_0, arg_10_1)
	arg_10_0:commonSetting(arg_10_1)
	SetActive(arg_10_0._itemPanel, true)
	setActive(arg_10_0._itemText, arg_10_1.content)

	arg_10_0._itemText.text = arg_10_1.content or ""

	local var_10_0 = arg_10_1.items
	local var_10_1 = arg_10_1.itemFunc

	UIItemList.StaticAlign(arg_10_0._itemListItemContainer, arg_10_0._itemListItemTpl, #arg_10_1.items, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1

		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_10_0[arg_11_1]

			updateDrop(arg_11_2:Find("IconTpl"), var_10_0[arg_11_1], {
				anonymous = var_10_0[arg_11_1].anonymous,
				hideName = var_10_0[arg_11_1].hideName
			})

			local var_11_1 = arg_11_2:Find("IconTpl/name")

			setText(var_11_1, shortenString(getText(var_11_1), 6))
			onButton(arg_10_0, arg_11_2, function()
				if var_11_0.anonymous then
					return
				elseif var_10_1 then
					var_10_1(var_11_0)
				end

				return
			end, SFX_UI_CLICK)
		end

		return
	end)
	arg_10_0:Loaded(arg_10_1)

	return
end

local function var_0_7(arg_13_0, arg_13_1)
	arg_13_0:commonSetting(arg_13_1)
	SetActive(arg_13_0._eskinPanel, true)
	setActive(arg_13_0._eskinText, arg_13_1.content)

	arg_13_0._eskinText.text = arg_13_1.content or ""

	local var_13_0 = arg_13_1.items
	local var_13_1 = arg_13_1.itemFunc

	UIItemList.StaticAlign(arg_13_0._eskinListItemContainer, arg_13_0._eskinListItemTpl, #arg_13_1.items, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = var_13_0[arg_14_1]

			updateDrop(arg_14_2:Find("IconTpl"), var_13_0[arg_14_1], {
				anonymous = var_13_0[arg_14_1].anonymous,
				hideName = var_13_0[arg_14_1].hideName
			})
			setText(arg_14_2:Find("own/Text"), i18n("equip_skin_detail_count") .. var_13_0[arg_14_1]:getOwnedCount())
			onButton(arg_13_0, arg_14_2, function()
				if var_14_0.anonymous then
					return
				elseif var_13_1 then
					var_13_1(var_14_0)
				end

				return
			end, SFX_UI_CLICK)
		end

		return
	end)
	arg_13_0:Loaded(arg_13_1)

	return
end

local function var_0_8(arg_16_0, arg_16_1)
	arg_16_0:commonSetting(arg_16_1)
	SetActive(arg_16_0._sigleItemPanel, true)
	SetActive(arg_16_0._sigleItemPanel:Find("ship_group"), false)
	SetActive(arg_16_0._singleItemshipTypeTF, false)
	SetActive(arg_16_0._sigleItemPanel:Find("left/detail"), false)
	setActive(arg_16_0._sigleItemPanel:Find("combat_skin"), false)
	setActive(arg_16_0._sigleItemPanel:Find("source_panel"), false)

	local var_16_0 = arg_16_0._sigleItemPanel:Find("display_panel"):GetComponent(typeof(RectTransform))

	var_16_0.sizeDelta = Vector2(var_16_0.sizeDelta.x, -114.5)

	SetActive(arg_16_0.singleItemIntro, true)
	setText(arg_16_0.singleItemIntro, arg_16_1.content or "")

	local var_16_1 = arg_16_0._sigleItemPanel:Find("left/IconTpl")

	setText(var_16_1:Find("icon_bg/count"), "")
	SetActive(var_16_1:Find("icon_bg/startpl"), false)
	SetCompomentEnabled(var_16_1:Find("icon_bg"), typeof(Image), not arg_16_1.hideIconBG)
	SetCompomentEnabled(var_16_1:Find("icon_bg/frame"), typeof(Image), not arg_16_1.hideIconBG)
	setFrame(var_16_1:Find("icon_bg/frame"), arg_16_1.frame or 1)
	GetImageSpriteFromAtlasAsync("weaponframes", "bg" .. (arg_16_1.frame or 1), var_16_1:Find("icon_bg"))
	GetImageSpriteFromAtlasAsync(arg_16_1.iconPath[1], arg_16_1.iconPath[2] or "", var_16_1:Find("icon_bg/icon"))
	setText(arg_16_0._sigleItemPanel:Find("display_panel/name_container/name/Text"), arg_16_1.name or "")
	arg_16_0:Loaded(arg_16_1)

	return
end

local function var_0_9(arg_17_0, arg_17_1)
	arg_17_0:commonSetting(arg_17_1)
	SetActive(arg_17_0._sigleItemPanel, true)

	local var_17_0 = arg_17_1.drop
	local var_17_1 = arg_17_0._sigleItemPanel:Find("left/IconTpl")

	setActive(var_17_1:Find("timelimit"), arg_17_1.drop.type == DROP_TYPE_SKIN_TIMELIMIT)
	updateDrop(var_17_1, var_17_0)
	setActive(arg_17_0._singleItemshipTypeTF, var_17_0.type == DROP_TYPE_SHIP)
	setActive(arg_17_0._sigleItemPanel:Find("combat_skin"), false)
	setActive(arg_17_0._sigleItemPanel:Find("source_panel"), false)

	local var_17_2 = arg_17_0._sigleItemPanel:Find("display_panel"):GetComponent(typeof(RectTransform))

	var_17_2.sizeDelta = Vector2(var_17_2.sizeDelta.x, -114.5)

	if var_17_0.type == DROP_TYPE_SHIP then
		GetImageSpriteFromAtlasAsync("shiptype", shipType2print(var_17_0:getConfig("type")), arg_17_0._singleItemshipTypeTF, false)
	elseif var_17_0.type == DROP_TYPE_ITEM then
		local var_17_3 = ItemTipPanel.GetDropLackConfig(var_17_0)

		if var_17_3 then
			local var_17_4 = var_17_3.description or {}

			if #var_17_4 > 0 then
				var_17_2.sizeDelta = Vector2(var_17_2.sizeDelta.x, -170.5)

				UIItemList.StaticAlign(arg_17_0._sigleItemPanel:Find("source_panel/Viewport/Content"), arg_17_0._sigleItemPanel:Find("source_panel/Viewport/Content/sourceItem"), #var_17_4, function(arg_18_0, arg_18_1, arg_18_2)
					if arg_18_0 == UIItemList.EventUpdate then
						local var_18_0, var_18_1, var_18_2 = unpack(var_17_4[arg_18_1 + 1])

						setText(arg_18_2:Find("desc"), var_18_0)
						setText(arg_18_2:Find("btn/Text"), i18n("feast_res_window_go_label"))

						local var_18_3, var_18_4 = unpack(var_18_1)
						local var_18_5 = #var_18_3 > 0

						if var_18_2 and var_18_2 ~= 0 then
							var_18_5 = var_18_5 and getProxy(ActivityProxy):IsActivityNotEnd(var_18_2)
						end

						setActive(arg_18_2:Find("btn"), var_18_5)
						onButton(arg_17_0, arg_18_2:Find("btn"), function()
							ItemTipPanel.ConfigGoScene(var_18_3, var_18_4, function()
								arg_17_0:hide()

								return
							end)

							return
						end, SFX_PANEL)
					end

					return
				end)
				setActive(arg_17_0._sigleItemPanel:Find("source_panel"), true)

				goto label_17_0
			end
		end

		setActive(arg_17_0._sigleItemPanel:Find("source_panel"), false)

		::label_17_0::
	elseif var_17_0.type == DROP_TYPE_COMBAT_UI_STYLE then
		var_17_2.sizeDelta = Vector2(var_17_2.sizeDelta.x, -170.5)

		local var_17_5 = var_0_0.item_data_battleui[var_17_0.id].rare_display
		local var_17_6 = UIItemList.New(arg_17_0._sigleItemPanel:Find("combat_skin/elementList"), arg_17_0._sigleItemPanel:Find("combat_skin/elementList/main"))

		var_17_6:make(function(arg_21_0, arg_21_1, arg_21_2)
			if arg_21_0 == UIItemList.EventUpdate then
				GetImageSpriteFromAtlasAsync("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_17_5[arg_21_1 + 1]], arg_21_2:Find("icon"), true)
				setScrollText(arg_21_2:Find("TextMask/Text"), i18n("battleui_display" .. var_17_5[arg_21_1 + 1]))
			end

			return
		end)
		var_17_6:align(#var_0_0.item_data_battleui[var_17_0.id].rare_display)
		setActive(arg_17_0._sigleItemPanel:Find("combat_skin"), true)
	end

	local var_17_7 = var_17_0.type == DROP_TYPE_SHIP
	local var_17_8 = arg_17_0._sigleItemPanel:Find("ship_group")

	SetActive(var_17_8, var_17_0.type == DROP_TYPE_SHIP)

	if var_17_7 then
		local var_17_9 = tobool(getProxy(CollectionProxy):getShipGroup(var_0_0.ship_data_template[var_17_0.id].group_type))

		SetActive(var_17_8:Find("unlocked"), var_17_9)
		SetActive(var_17_8:Find("locked"), not var_17_9)
	end

	if arg_17_1.windowSize then
		arg_17_0._window.sizeDelta = Vector2(arg_17_1.windowSize.x or arg_17_0._defaultSize.x, arg_17_1.windowSize.y or arg_17_0._defaultSize.y)
	end

	local var_17_11 = arg_17_0.singleItemIntro
	local var_17_12 = arg_17_0._singleItemSubIntroTF
	local var_17_13 = arg_17_0.settings.numUpdate

	setActive(arg_17_0._countDescTxt, arg_17_0.settings.numUpdate ~= nil)
	SetActive(var_17_11, var_17_13 == nil)

	local var_17_14 = arg_17_1.name

	if not arg_17_1.name then
		var_17_14 = var_17_0:getConfig("name")
		var_17_14 = var_17_14 or ""
	end

	setText(arg_17_0._sigleItemPanel:Find("display_panel/name_container/name/Text"), var_17_14)
	UpdateOwnDisplay(arg_17_0._sigleItemPanel:Find("left/own"), var_17_0)
	RegisterDetailButton(arg_17_0, arg_17_0._sigleItemPanel:Find("left/detail"), var_17_0)

	if arg_17_1.content and arg_17_1.content ~= "" then
		setText(var_17_11, arg_17_1.content)
	elseif var_17_0.type == DROP_TYPE_WORLD_COLLECTION then
		var_17_0:MsgboxIntroSet(arg_17_1, var_17_11, arg_17_0._sigleItemPanel:Find("name_mode/name_mask/name"))
	else
		var_17_0:MsgboxIntroSet(arg_17_1, var_17_11)
	end

	if arg_17_1.intro then
		setText(var_17_11, arg_17_1.intro)
	end

	setText(var_17_12, arg_17_1.subIntro or arg_17_1.extendDesc or "")

	if arg_17_1.enabelYesBtn ~= nil then
		local var_17_15 = arg_17_0._btnContainer:GetChild(1)

		setButtonEnabled(var_17_15, arg_17_1.enabelYesBtn)
		eachChild(var_17_15, function(arg_22_0)
			GetOrAddComponent(arg_22_0, typeof(CanvasGroup)).alpha = arg_17_1.enabelYesBtn and 1 or 0.3

			return
		end)
	end

	if arg_17_1.show_medal then
		arg_17_0:createBtn({
			sibling = 0,
			hideEvent = true,
			text = arg_17_1.show_medal.desc,
			btnType = var_0_1.BUTTON_MEDAL,
			sound = SFX_UI_BUILDING_EXCHANGE
		})
	end

	arg_17_0:Loaded(arg_17_1)

	return
end

local function var_0_10(arg_23_0, arg_23_1)
	arg_23_0:commonSetting(arg_23_1)
	setActive(findTF(arg_23_0._helpPanel, "bg"), not arg_23_1.helps.pageMode)
	setActive(arg_23_0._helpBgTF, arg_23_1.helps.pageMode)
	setActive(arg_23_0._helpPanel:Find("btn_blueprint"), arg_23_1.show_blueprint)

	if arg_23_1.show_blueprint then
		onButton(arg_23_0, arg_23_0._helpPanel:Find("btn_blueprint"), function()
			arg_23_0:hide()
			var_0_0.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT, {
				shipGroupId = arg_23_1.show_blueprint
			})

			return
		end, SFX_PANEL)
	end

	if arg_23_1.helps.helpSize then
		arg_23_0._helpPanel.sizeDelta = Vector2(arg_23_1.helps.helpSize.x or arg_23_0._defaultHelpSize.x, arg_23_1.helps.helpSize.y or arg_23_0._defaultHelpSize.y)
	end

	if arg_23_1.helps.helpPos then
		local var_23_1 = {}

		var_23_1.x = arg_23_1.helps.helpPos.x or arg_23_0._defaultHelpPos.x
		var_23_1.y = arg_23_1.helps.helpPos.y or arg_23_0._defaultHelpPos.y

		setAnchoredPosition(arg_23_0._helpPanel, var_23_1)
	end

	if arg_23_1.helps.windowSize then
		arg_23_0._window.sizeDelta = Vector2(arg_23_1.helps.windowSize.x or arg_23_0._defaultSize.x, arg_23_1.helps.windowSize.y or arg_23_0._defaultSize.y)
	end

	if arg_23_1.helps.windowPos then
		arg_23_0._window.sizeDelta = Vector2(arg_23_1.helps.windowSize.x or arg_23_0._defaultSize.x, arg_23_1.helps.windowSize.y or arg_23_0._defaultSize.y)

		local var_23_4 = {}

		var_23_4.x = arg_23_1.helps.windowPos.x or 0
		var_23_4.y = arg_23_1.helps.windowPos.y or 0

		setAnchoredPosition(arg_23_0._window, var_23_4)
	else
		setAnchoredPosition(arg_23_0._window, {
			x = 0,
			y = 0
		})
	end

	if arg_23_1.helps.buttonsHeight then
		setAnchoredPosition(arg_23_0._btnContainer, {
			y = arg_23_1.helps.buttonsHeight
		})
	end

	if arg_23_1.helps.disableScroll then
		SetCompomentEnabled(arg_23_0._helpPanel:Find("list"), typeof(ScrollRect), not arg_23_1.helps.disableScroll)
		setAnchoredPosition(arg_23_0._helpPanel:Find("list"), Vector2.zero)
		setActive(findTF(arg_23_0._helpPanel, "Scrollbar"), false)
	end

	if arg_23_1.helps.ImageMode then
		setActive(arg_23_0._top, false)
		setActive(findTF(arg_23_0._window, "bg"), false)
	else
		setActive(arg_23_0._top, true)
		setActive(findTF(arg_23_0._window, "bg"), true)
	end

	local var_23_5 = arg_23_0.settings.helps

	for iter_23_0 = #arg_23_0.settings.helps, arg_23_0._helpList.childCount - 1 do
		Destroy(arg_23_0._helpList:GetChild(iter_23_0))
	end

	for iter_23_1 = arg_23_0._helpList.childCount, #var_23_5 - 1 do
		cloneTplTo(arg_23_0._helpTpl, arg_23_0._helpList)
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_5) do
		local var_23_6 = arg_23_0._helpList:GetChild(iter_23_2 - 1)

		setActive(var_23_6, true)

		local var_23_7 = var_23_6:Find("icon")

		setActive(var_23_7, iter_23_3.icon)
		setActive(findTF(var_23_6, "line"), iter_23_3.line)

		if iter_23_3.icon then
			local var_23_8 = 1

			if arg_23_1.helps.ImageMode then
				var_23_8 = 1.5
			end

			var_23_7.transform.localScale = Vector2(iter_23_3.icon.scale or var_23_8, iter_23_3.icon.scale or var_23_8)

			local var_23_10

			if iter_23_3.icon.posX then
				var_23_10 = iter_23_3.icon.posX or -20

				local var_23_11

				if iter_23_3.icon.posY then
					var_23_11 = iter_23_3.icon.posY

					local var_23_12

					if not iter_23_3.icon.posY then
						var_23_11 = 0
						var_23_12 = var_23_7:GetComponent(typeof(Image))
					end
				end
			end

			setImageSprite(var_23_12, LoadSprite(iter_23_3.icon.atlas, iter_23_3.icon.path), true)
			setAnchoredPosition(var_23_7, {
				x = var_23_10,
				y = var_23_11
			})
			setActive(var_23_7:Find("corner"), arg_23_1.helps.pageMode)
		end

		local var_23_13 = var_23_6:Find("richText"):GetComponent("RichText")

		if iter_23_3.rawIcon then
			var_23_13:AddSprite(iter_23_3.rawIcon.name, GetSpriteFromAtlas(iter_23_3.rawIcon.atlas, iter_23_3.rawIcon.name))

			local var_23_14 = HXSet.hxLan(iter_23_3.info or "")

			setText(var_23_6, "")

			var_23_13.text = string.format("<icon name=%s w=0.7 h=0.7/>%s", iter_23_3.rawIcon.name, var_23_14)
		else
			setText(var_23_6, HXSet.hxLan(iter_23_3.info and SwitchSpecialChar(iter_23_3.info, true) or ""))
		end

		setActive(var_23_13.gameObject, iter_23_3.rawIcon)
	end

	arg_23_0.helpPage = arg_23_1.helps.defaultpage or 1

	if arg_23_1.helps.pageMode then
		arg_23_0:switchHelpPage(arg_23_0.helpPage)
	end

	arg_23_0:Loaded(arg_23_1)

	return
end

local function var_0_11(arg_25_0, arg_25_1)
	arg_25_0:commonSetting(arg_25_1)
	setActive(arg_25_0._otherPanel, true)

	local var_25_0 = tf(arg_25_1.secondaryUI)

	arg_25_0._window.sizeDelta = Vector2(960, arg_25_0._defaultSize.y)

	setActive(var_25_0, true)

	local var_25_1 = getProxy(SecondaryPWDProxy):getRawData()
	local var_25_2 = var_25_0:Find("showresttime")
	local var_25_3 = var_25_0:Find("settips")

	if arg_25_1.mode == "showresttime" then
		setActive(var_25_2, true)
		setActive(var_25_3, false)

		local var_25_4 = var_25_2:Find("desc"):GetComponent(typeof(Text))

		if arg_25_0.timers.secondaryUItimer then
			arg_25_0.timers.secondaryUItimer:Stop()
		end

		local function var_25_5()
			local var_26_0

			if var_25_1.fail_cd then
				var_26_0 = var_25_1.fail_cd - var_0_0.TimeMgr.GetInstance():GetServerTime() or 0
			end

			var_26_0 = var_26_0 < 0 and 0 or var_26_0

			local var_26_1 = math.floor(var_26_0 / 0)

			if var_26_1 > 0 then
				var_25_4.text = string.format(i18n("tips_fail_secondarypwd_much_times"), var_26_1 .. i18n("word_date"))
			else
				local var_26_2 = math.floor(var_26_0 / 16)

				if var_26_2 > 0 then
					var_25_4.text = string.format(i18n("tips_fail_secondarypwd_much_times"), var_26_2 .. i18n("word_hour"))
				else
					local var_26_3 = ""
					local var_26_4 = math.floor(var_26_0 / 60)

					if var_26_4 > 0 then
						var_26_3 = var_26_3 .. var_26_4 .. i18n("word_minute")
					end

					var_25_4.text = string.format(i18n("tips_fail_secondarypwd_much_times"), var_26_3 .. math.max(var_26_0 - var_26_4 * 60, 0) .. i18n("word_second"))
				end
			end

			return
		end

		var_25_5()

		local var_25_6 = Timer.New(var_25_5, 1, -1)

		var_25_6:Start()

		arg_25_0.timers.secondaryUItimer = var_25_6
	elseif arg_25_1.mode == "settips" then
		setActive(var_25_2, false)
		setActive(var_25_3, true)

		local var_25_7 = var_25_3:Find("InputField"):GetComponent(typeof(InputField))

		arg_25_1.references.inputfield = var_25_7
		var_25_7.text = arg_25_1.references.lasttext or ""

		local var_25_8 = 20

		var_25_7.onValueChanged:AddListener(function()
			local var_27_0, var_27_1 = utf8_to_unicode(var_25_7.text)

			if var_27_1 > var_25_8 then
				var_25_7.text = SecondaryPasswordMediator.ClipUnicodeStr(var_25_7.text, var_25_8)
			end

			return
		end)
		arg_25_0:createBtn({
			text = var_0_1.TEXT_CONFIRM,
			btnType = var_0_1.BUTTON_BLUE,
			onCallback = arg_25_0.settings.onYes,
			sound = SFX_CONFIRM,
			noQuit = function()
				if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
					return false
				end

				local var_28_0 = var_25_7.text
				local var_28_1, var_28_2 = wordVer(var_25_7.text, {
					isReplace = true
				})

				if var_28_1 > 0 or var_28_2 ~= var_28_0 then
					var_0_0.TipsMgr.GetInstance():ShowTips(i18n("secondarypassword_illegal_tip"))

					var_25_7.text = var_28_2

					return true
				else
					return false
				end

				return
			end
		})
	end

	arg_25_0:Loaded(arg_25_1)

	return
end

local function var_0_12(arg_29_0, arg_29_1)
	arg_29_0:commonSetting(arg_29_1)
	setActive(arg_29_0._worldResetPanel, true)
	setActive(arg_29_0._worldShopBtn, false)
	setText(arg_29_0._worldResetPanel:Find("content/Text"), arg_29_1.tipWord)

	local var_29_0 = arg_29_0._worldResetPanel:Find("IconTpl")

	setActive(var_29_0, false)

	local var_29_1 = arg_29_0._worldResetPanel:Find("content/item_list")

	removeAllChildren(var_29_1)

	for iter_29_0, iter_29_1 in ipairs(arg_29_1.drops) do
		local var_29_2 = cloneTplTo(var_29_0, var_29_1)

		updateDrop(var_29_2, iter_29_1)

		local var_29_3 = findTF(var_29_2, "name")

		changeToScrollText(var_29_3, getText(var_29_3))

		if arg_29_1.itemFunc then
			onButton(arg_29_0, var_29_2, function()
				arg_29_1.itemFunc(iter_29_1)

				return
			end, SFX_PANEL)
		end
	end

	onButton(arg_29_0, arg_29_0._worldShopBtn, function()
		arg_29_0:hide()

		return existCall(arg_29_1.goShop)
	end, SFX_MAIN)
	arg_29_0:Loaded(arg_29_1)

	return
end

local function var_0_13(arg_32_0)
	if not arg_32_0 then
		return false
	end

	for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
		if iter_32_1[2] and iter_32_1[2][1] == "SHOP" and (iter_32_1[2][2] or nil) and iter_32_1[2][2].warp == "meta" then
			return true
		end
	end

	return false
end

local function var_0_14(arg_33_0)
	if not arg_33_0 then
		return false
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0) do
		if iter_33_1[2] and iter_33_1[2][1] == "GETBOAT" then
			return true
		end
	end

	return false
end

local function var_0_15(arg_34_0)
	if Ship.isMetaShipByConfigID(arg_34_0.shipId) then
		local var_34_0 = getProxy(MetaCharacterProxy):getMetaProgressVOByID((MetaCharacterConst.GetMetaShipGroupIDByConfigID(arg_34_0.shipId)))

		return var_34_0 and (var_34_0:isInAct() or var_34_0:isInArchive()) or var_0_13(arg_34_0.list) or var_0_14(arg_34_0.list)
	end

	return true
end

local function var_0_16(arg_35_0, arg_35_1)
	arg_35_0:commonSetting(arg_35_1)

	arg_35_0._window.sizeDelta = Vector2(arg_35_0._defaultSize.x, 520)

	setActive(arg_35_0._obtainPanel, true)
	setActive(arg_35_0._btnContainer, false)
	updateDrop(arg_35_0._obtainPanel, {
		type = DROP_TYPE_SHIP,
		id = arg_35_1.shipId
	}, arg_35_1)

	local var_35_0 = var_0_15(arg_35_1)

	arg_35_0.obtainSkipList = arg_35_0.obtainSkipList or UIItemList.New(arg_35_0._obtainPanel:Find("skipable_list"), arg_35_0._obtainPanel:Find("skipable_list/tpl"))

	arg_35_0.obtainSkipList:make(function(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_0 == UIItemList.EventUpdate then
			local var_36_0 = arg_35_1.list[arg_36_1 + 1][2]
			local var_36_1 = arg_35_1.list[arg_36_1 + 1][3]

			arg_36_2:Find("mask/title"):GetComponent("ScrollText"):SetText((HXSet.hxLan(arg_35_1.list[arg_36_1 + 1][1])))
			setActive(arg_36_2:Find("skip_btn"), var_35_0 and arg_35_1.list[arg_36_1 + 1][2][1] ~= "" and arg_35_1.list[arg_36_1 + 1][2][1] ~= "COLLECTSHIP")

			if arg_35_1.list[arg_36_1 + 1][2][1] ~= "" then
				onButton(arg_35_0, arg_36_2:Find("skip_btn"), function()
					if var_36_1 and var_36_1 ~= 0 then
						local var_37_0 = getProxy(ActivityProxy):getActivityById(var_36_1)

						if not var_37_0 or var_37_0:isEnd() then
							var_0_0.TipsMgr.GetInstance():ShowTips(i18n("collection_way_is_unopen"))

							return
						end
					else
						if var_36_0[1] == "SHOP" and var_36_0[2].warp == NewShopsScene.TYPE_MILITARY_SHOP then
							if not var_0_0.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "MilitaryExerciseMediator") then
								var_0_0.TipsMgr.GetInstance():ShowTips(i18n("military_shop_no_open_tip"))

								do return end

								goto label_37_0
							end
						end

						if var_36_0[1] == "LEVEL" and var_36_0[2] then
							local var_37_1 = getProxy(ChapterProxy)
							local var_37_2 = var_37_1:getChapterById(var_36_0[2].chapterid)

							if var_37_2:isUnlock() then
								local var_37_3 = var_37_1:getActiveChapter()

								if var_37_3 and var_37_3.id ~= var_36_0[2].chapterid then
									arg_35_0:ShowMsgBox({
										content = i18n("collect_chapter_is_activation"),
										onYes = function()
											var_0_0.m02:sendNotification(GAME.CHAPTER_OP, {
												type = ChapterConst.OpRetreat
											})

											return
										end
									})

									return
								else
									local var_37_4 = {
										mapIdx = var_37_2:getConfig("map")
									}

									if var_37_2.active then
										var_37_4.chapterId = var_37_2.id
									else
										var_37_4.openChapterId = var_36_0[2].chapterid
									end

									var_0_0.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_37_4)
								end
							else
								var_0_0.TipsMgr.GetInstance():ShowTips(i18n("acquisitionmode_is_not_open"))

								return
							end
						elseif var_36_0[1] == "COLLECTSHIP" then
							if arg_35_1.mediatorName == CollectionMediator.__cname then
								var_0_0.m02:sendNotification(CollectionMediator.EVENT_OBTAIN_SKIP, {
									toggle = 2,
									displayGroupId = var_36_0[2].shipGroupId
								})
							else
								var_0_0.m02:sendNotification(GAME.GO_SCENE, SCENE.COLLECTSHIP, {
									toggle = 2,
									displayGroupId = var_36_0[2].shipGroupId
								})
							end
						elseif var_36_0[1] == "SHOP" then
							var_0_0.m02:sendNotification(GAME.GO_SCENE, SCENE[var_36_0[1]], var_36_0[2])
						else
							var_0_0.m02:sendNotification(GAME.GO_SCENE, SCENE[var_36_0[1]], var_36_0[2])
						end
					end

					::label_37_0::

					arg_35_0:hide()

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_35_0.obtainSkipList:align(#arg_35_1.list)
	arg_35_0:Loaded(arg_35_1)

	return
end

function var_0_1:nextPage()
	self.helpPage = self.helpPage + 1

	if self.helpPage < 1 then
		self.helpPage = 1
	end

	if self.helpPage > self._helpList.childCount then
		self.helpPage = 1
	end

	self:switchHelpPage(self.helpPage)

	return
end

function var_0_1:prePage()
	self.helpPage = self.helpPage - 1

	if self.helpPage < 1 then
		self.helpPage = self._helpList.childCount
	end

	if self.helpPage > self._helpList.childCount then
		self.helpPage = self._helpList.childCount
	end

	self:switchHelpPage(self.helpPage)

	return
end

function var_0_1:switchHelpPage(arg_41_1)
	for iter_41_0 = 1, self._helpList.childCount do
		local var_41_0 = self._helpList:GetChild(iter_41_0 - 1)

		setActive(var_41_0, arg_41_1 == iter_41_0)
		setText(var_41_0:Find("icon/corner/Text"), iter_41_0)
	end

	return
end

function var_0_1:commonSetting(arg_42_1)
	rtf(self._window).sizeDelta = self._defaultSize
	rtf(self._helpPanel).sizeDelta = self._defaultHelpSize
	self.enable = true

	var_0_0.DelegateInfo.New(self)
	setActive(self._msgPanel, false)
	setActive(self._exchangeShipPanel, false)
	setActive(self._itemPanel, false)
	setActive(self._eskinPanel, false)
	setActive(self._sigleItemPanel, false)
	setActive(self._inputPanel, false)
	setActive(self._obtainPanel, false)
	setActive(self._otherPanel, false)
	setActive(self._worldResetPanel, false)
	setActive(self._worldShopBtn, false)
	setActive(self._helpBgTF, false)
	setActive(self._helpPanel, arg_42_1.helps)

	for iter_42_0, iter_42_1 in pairs(self.panelDict) do
		iter_42_1.buffer:Hide()
	end

	setActive(self._btnContainer, true)

	self.stopRemindToggle.isOn = arg_42_1.toggleStatus or false

	setActive(go(self.stopRemindToggle), arg_42_1.showStopRemind)

	self.stopRemindText.text = arg_42_1.stopRamindContent or i18n("dont_remind_today")

	removeAllChildren(self._btnContainer)

	self.settings = arg_42_1

	SetActive(self._go, true)
	setActive(self._countSelect, self.settings.needCounter or false)

	local var_42_0 = self.settings.numUpdate
	local var_42_1 = self.settings.addNum or 1
	local var_42_2 = self.settings.maxNum or -1
	local var_42_3 = self.settings.defaultNum or 1

	self._pageUtil:setNumUpdate(function(arg_43_0)
		if var_42_0 ~= nil then
			var_42_0(self._countDescTxt, arg_43_0)
		end

		return
	end)
	self._pageUtil:setAddNum(var_42_1)
	self._pageUtil:setMaxNum(var_42_2)
	self._pageUtil:setDefaultNum(var_42_3)
	setActive(self._sliders, self.settings.discount)

	if self.settings.discount then
		self._discount:GetComponent(typeof(Text)).text = self.settings.discount.discount .. "%OFF"
		self._discountDate:GetComponent(typeof(Text)).text = self.settings.discount.date
	end

	setActive(self._remasterPanel, self.settings.remaster)

	if self.settings.remaster then
		local var_42_4 = self.settings.remaster

		setText(self._remasterPanel:Find("content/Text"), self.settings.remaster.word)
		setText(self._remasterPanel:Find("content/count"), self.settings.remaster.number or "")
		setText(self._remasterPanel:Find("btn/pic"), self.settings.remaster.btn_text)
		onButton(self, self._remasterPanel:Find("btn"), function()
			if var_42_4.btn_call then
				var_42_4.btn_call()
			end

			self:hide()

			return
		end)
	end

	local var_42_5 = self.settings.hideNo or false
	local var_42_6 = self.settings.hideYes or false
	local var_42_7 = self.settings.modal or false
	local var_42_8 = self.settings.onYes or function()
		return
	end
	local var_42_9 = self.settings.onNo or function()
		return
	end

	onButton(self, tf(self._go):Find("bg"), function()
		if self.settings.onClose then
			self.settings.onClose()
		else
			var_42_9()
		end

		self:hide()

		return
	end, SFX_CANCEL)
	SetCompomentEnabled(tf(self._go):Find("bg"), typeof(Button), not var_42_7)

	local var_42_11

	if not var_42_5 then
		local var_42_12 = {}

		var_42_12.text = self.settings.noText or var_0_1.TEXT_CANCEL
		var_42_12.btnType = self.settings.noBtnType or var_0_1.BUTTON_GRAY
		var_42_12.onCallback = var_42_9
		var_42_12.sound = arg_42_1.noSound or SFX_CANCEL

		local var_42_13 = self:createBtn(var_42_12)
	end

	if not var_42_6 then
		local var_42_14 = {}

		var_42_14.text = self.settings.yesText or var_0_1.TEXT_CONFIRM
		var_42_14.btnType = self.settings.yesBtnType or var_0_1.BUTTON_BLUE
		var_42_14.onCallback = var_42_8
		var_42_14.sound = arg_42_1.yesSound or SFX_CONFIRM
		var_42_14.alignment = self.settings.yesSize and TextAnchor.MiddleCenter
		var_42_14.gray = self.settings.yesGray
		var_42_14.delayButton = self.settings.delayConfirm
		var_42_11 = self:createBtn(var_42_14)

		if self.settings.yesSize then
			var_42_11.sizeDelta = self.settings.yesSize
		end
	end

	if self.settings.yseBtnLetf then
		var_42_11:SetAsFirstSibling()
	end

	local var_42_15

	if self.settings.type == MSGBOX_TYPE_HELP and self.settings.helps.pageMode and #self.settings.helps > 1 then
		self:createBtn({
			noQuit = true,
			btnType = var_0_1.BUTTON_PREPAGE,
			onCallback = function()
				self:prePage()

				return
			end,
			sound = SFX_CANCEL
		})

		var_42_15 = #self.settings.helps
	end

	if self.settings.custom ~= nil then
		for iter_42_2, iter_42_3 in ipairs(self.settings.custom) do
			self:createBtn(iter_42_3)
		end
	end

	if not var_42_15 then
		-- block empty
	elseif var_42_15 > 1 then
		self:createBtn({
			noQuit = true,
			btnType = var_0_1.BUTTON_NEXTPAGE,
			onCallback = function()
				self:nextPage()

				return
			end,
			sound = SFX_CONFIRM
		})
	end

	setActive(self._closeBtn, not arg_42_1.hideClose)
	onButton(self, self._closeBtn, function()
		if self.settings and self.settings.hideClose and not self.settings.onClose and self.settings.onYes then
			self.settings.onYes()
		end

		self:hide()

		if self.settings.onClose then
			self.settings.onClose()
		else
			var_42_9()
		end

		return
	end, SFX_CANCEL)

	local var_42_16 = self.settings.title or var_0_1.TITLE_INFORMATION
	local var_42_17 = 0

	while var_42_17 < self._titleList.transform.childCount do
		local var_42_18 = self._titleList.transform:GetChild(var_42_17)

		SetActive(var_42_18, var_42_18.name == var_42_16)

		var_42_17 = var_42_17 + 1
	end

	self._go.transform.localPosition = Vector3(self._go.transform.localPosition.x, self._go.transform.localPosition.y, self.settings.zIndex or 0)
	self.locked = self.settings.locked or false

	return
end

function var_0_1:createBtn(arg_51_1)
	local var_51_0 = arg_51_1.btnType or var_0_1.BUTTON_BLUE
	local var_51_1 = arg_51_1.noQuit
	local var_51_2 = cloneTplTo(self._go.transform:Find("custom_btn_list/custom_button_" .. var_51_0), self._btnContainer)

	if arg_51_1.label then
		go(var_51_2).name = arg_51_1.label
	end

	SetActive(var_51_2, true)

	if arg_51_1.scale then
		var_51_2.localScale = Vector2(arg_51_1.scale.x or 1, arg_51_1.scale.y or 1)
	end

	local var_51_4

	if var_51_0 == var_0_1.BUTTON_MEDAL then
		setText(var_51_2:Find("text"), arg_51_1.text)

		var_51_4 = var_51_2:Find("text")
	elseif var_51_0 ~= var_0_1.BUTTON_RETREAT and var_51_0 ~= var_0_1.BUTTON_PREPAGE and var_51_0 ~= var_0_1.BUTTON_NEXTPAGE then
		self:updateButton(var_51_2, arg_51_1.text, arg_51_1.alignment)

		var_51_4 = var_51_2:Find("pic")
	end

	if var_51_0 == var_0_1.BUTTON_BLUE_WITH_ICON and arg_51_1.iconName then
		setImageSprite(var_51_2:Find("ticket/icon"), LoadSprite(arg_51_1.iconName[1], arg_51_1.iconName[2]))
	end

	local var_51_5

	if arg_51_1.delayButton then
		local var_51_6 = arg_51_1.delayButton
		local var_51_7 = getText(var_51_4)

		var_51_5 = Timer.New(function()
			var_51_6 = var_51_6 - 1

			if var_51_6 > 0 then
				setText(var_51_4, var_51_7 .. string.format("(%d)", var_51_6))
			else
				setText(var_51_4, var_51_7)
				setGray(var_51_2, arg_51_1.gray, true)

				var_51_5 = nil
			end

			return
		end, 1, arg_51_1.delayButton)
		self.timers[var_51_2] = var_51_5

		var_51_5:Start()
		setText(var_51_4, var_51_7 .. string.format("(%d)", arg_51_1.delayButton))
		setGray(var_51_2, true, true)
	else
		setGray(var_51_2, arg_51_1.gray, true)
	end

	if not arg_51_1.hideEvent then
		onButton(self, var_51_2, function()
			if var_51_5 then
				return
			end

			if type(var_51_1) == "function" then
				if var_51_1() then
					return
				else
					self:hide()
				end
			elseif not var_51_1 then
				self:hide()
			end

			return existCall(arg_51_1.onCallback)
		end, arg_51_1.sound or SFX_CONFIRM)
	end

	if arg_51_1.sibling then
		var_51_2:SetSiblingIndex(arg_51_1.sibling)
	end

	return var_51_2
end

function var_0_1.updateButton(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_1:Find("pic")

	if IsNil(var_54_0) then
		return
	end

	if MsgboxBtnNameMap[arg_54_2] then
		setText(var_54_0, i18n(MsgboxBtnNameMap[arg_54_2]))
	else
		if string.len(arg_54_2) > 12 then
			GetComponent(var_54_0, typeof(Text)).resizeTextForBestFit = true
		end

		setText(var_54_0, arg_54_2)
	end

	if arg_54_3 then
		var_54_0:GetComponent(typeof(Text)).alignment = arg_54_3
	end

	return
end

function var_0_1:Loaded(arg_55_1)
	var_0_0.UIMgr.GetInstance():BlurPanel(self._tf, {
		groupName = arg_55_1.groupName,
		parent = arg_55_1.parent
	})
	var_0_0.m02:sendNotification(GAME.OPEN_MSGBOX_DONE)

	return
end

function var_0_1:Clear()
	for iter_56_0, iter_56_1 in pairs(self.panelDict) do
		iter_56_1:Destroy()
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

	local var_56_0 = self._sigleItemPanel:Find("left/IconTpl")

	SetCompomentEnabled(var_56_0:Find("icon_bg"), typeof(Image), true)
	SetCompomentEnabled(var_56_0:Find("icon_bg/frame"), typeof(Image), true)
	setActive(var_56_0:Find("icon_bg/slv"), false)
	setActive(self.singleItemIntro, false)
	setText(self._singleItemSubIntroTF, "")

	for iter_56_2 = 0, self._helpList.childCount - 1 do
		self._helpList:GetChild(iter_56_2):Find("icon"):GetComponent(typeof(Image)).sprite = nil
	end

	for iter_56_3, iter_56_4 in pairs(self.pools) do
		if iter_56_4 then
			PoolMgr.GetInstance():ReturnUI(iter_56_4.name, iter_56_4)
		end
	end

	self.pools = {}

	for iter_56_5, iter_56_6 in pairs(self.timers) do
		iter_56_6:Stop()
	end

	self.timers = {}

	var_0_0.DelegateInfo.Dispose(self)
	removeAllChildren(self._btnContainer)
	var_0_0.UIMgr.GetInstance():UnOverlayPanel(self._tf, var_0_0.UIMgr.GetInstance().OverlayMain)
	self.contentText:RemoveAllListeners()

	self.settings = nil
	self.enable = false
	self.locked = nil

	return
end

function var_0_1:ShowMsgBox(arg_57_1)
	if self.locked then
		return
	end

	switch(arg_57_1.type or MSGBOX_TYPE_NORMAL, {
		[MSGBOX_TYPE_NORMAL] = function()
			var_0_3(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_INPUT] = function()
			var_0_4(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_SINGLE_ITEM] = function()
			var_0_9(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_EXCHANGE] = function()
			var_0_5(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_DROP_ITEM] = function()
			var_0_8(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_ITEM_BOX] = function()
			var_0_6(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_DROP_ITEM_ESKIN] = function()
			var_0_7(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_HELP] = function()
			arg_57_1.hideNo = defaultValue(arg_57_1.hideNo, true)
			arg_57_1.hideYes = defaultValue(arg_57_1.hideYes, true)

			var_0_10(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_SECONDPWD] = function()
			PoolMgr.GetInstance():GetUI("Msgbox4SECPWD", true, function(arg_67_0)
				self.pools.SedondaryUI = arg_67_0

				if arg_57_1.onPreShow then
					arg_57_1.onPreShow()
				end

				arg_57_1.secondaryUI = arg_67_0

				SetParent(arg_67_0, self._otherPanel, false)
				var_0_11(self, arg_57_1)

				return
			end)

			return
		end,
		[MSGBOX_TYPE_WORLD_RESET] = function()
			var_0_12(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_OBTAIN] = function()
			arg_57_1.title = arg_57_1.title or var_0_1.TITLE_OBTAIN

			var_0_16(self, arg_57_1)

			return
		end,
		[MSGBOX_TYPE_ITEMTIP] = function()
			self:GetPanel(ItemTipPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_JUST_FOR_SHOW] = function()
			self:GetPanel(ItemShowPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_MONTH_CARD_TIP] = function()
			self:GetPanel(MonthCardOutDateTipPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_STORY_CANCEL_TIP] = function()
			self:GetPanel(StoryCancelTipPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_META_SKILL_UNLOCK] = function()
			self:GetPanel(MetaSkillUnlockPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_ACCOUNTDELETE] = function()
			self:GetPanel(AccountDeletePanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_STRENGTHEN_BACK] = function()
			self:GetPanel(StrengthenBackPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_CONTENT_ITEMS] = function()
			self:GetPanel(Msgbox4ContentItems).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM] = function()
			self:GetPanel(Msgbox4BlueprintUnlockItem).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_CONFIRM_DELETE] = function()
			self:GetPanel(ConfirmEquipmentDeletePanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON] = function()
			self:GetPanel(Msgbox4SpweaponConfirm).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_SUBPATTERN] = function()
			self:GetPanel(arg_57_1.patternClass).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_FILE_DOWNLOAD] = function()
			self:GetPanel(FileDownloadPanel).buffer:UpdateView(arg_57_1)

			return
		end,
		[MSGBOX_TYPE_LIKN_COLLECT_GUIDE] = function()
			self:GetPanel(Msgbox4LinkCollectGuide).buffer:UpdateView(arg_57_1)

			return
		end
	})

	return
end

function var_0_1:GetPanel(arg_84_1)
	if not self.panelDict[arg_84_1] then
		self.panelDict[arg_84_1] = arg_84_1.New(self)

		self.panelDict[arg_84_1]:Load()
		self.panelDict[arg_84_1].buffer:SetParent(self._window)
	end

	return self.panelDict[arg_84_1]
end

function var_0_1:CloseAndHide()
	if not self.enable then
		return
	end

	local var_85_0 = self.settings
	local var_85_1 = self.settings.onClose

	if not self.settings.onClose then
		if not var_85_0.hideNo then
			var_85_1 = var_85_0.onNo or nil
		end
	end

	existCall(var_85_1)
	self:hide()

	return
end

function var_0_1:hide()
	if not self.enable then
		return
	end

	self._go:SetActive(false)
	self:Clear()
	var_0_0.m02:sendNotification(GAME.CLOSE_MSGBOX_DONE)

	return
end

function var_0_1:emit(arg_87_1, ...)
	self.analogyMediator = self.analogyMediator or {
		addSubLayers = function(arg_88_0, arg_88_1)
			local var_88_0 = {}

			var_88_0.parentContext = getProxy(ContextProxy):getCurrentContext()
			var_88_0.context = arg_88_1

			var_0_0.m02:sendNotification(GAME.LOAD_LAYERS, var_88_0)

			return
		end,
		sendNotification = function(arg_89_0, ...)
			var_0_0.m02:sendNotification(...)

			return
		end,
		viewComponent = self
	}

	return ContextMediator.CommonBindDic[arg_87_1](self.analogyMediator, arg_87_1, ...)
end

function var_0_1:closeView()
	self:hide()

	return
end

return var_0_1
