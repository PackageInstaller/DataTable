local var_0_0 = class("ShipMainScene", import("...base.BaseUI"))
local var_0_1 = 0
local var_0_2 = 0.2
local var_0_3 = 0.3
local var_0_4 = 3
local var_0_6 = 11

function var_0_0.getUIName(arg_1_0)
	return "ShipMainScene"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.preload(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(BayProxy):getShipById(arg_3_0.contextData.shipId)

	parallelAsync({
		function(arg_4_0)
			GetSpriteFromAtlasAsync("bg/star_level_bg_" .. var_3_0:rarity2bgPrintForGet(), "", arg_4_0)

			return
		end,
		function(arg_5_0)
			if arg_3_0.exited then
				return
			end

			PoolMgr.GetInstance():PreloadUI("ShipDetailView", arg_5_0)

			return
		end
	}, arg_3_1)

	return
end

function var_0_0.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	arg_6_0:GetShareData():SetPlayer(arg_6_1)

	return
end

function var_0_0.setShipList(arg_7_0, arg_7_1)
	arg_7_0.shipList = arg_7_1

	return
end

function var_0_0.setShip(arg_8_0, arg_8_1)
	arg_8_0:GetShareData():SetShipVO(arg_8_1)

	local var_8_0 = false

	if arg_8_0.shipVO and arg_8_0.shipVO.id ~= arg_8_1.id then
		arg_8_0:StopPreVoice()

		var_8_0 = true
	end

	arg_8_0.shipVO = arg_8_1

	setActive(arg_8_0.npcFlagTF, arg_8_1:isActivityNpc())
	arg_8_0:setToggleEnable()

	local var_8_1 = pg.ship_skin_template[arg_8_0.shipVO:getSkinId()]

	arg_8_0.isSpBg = var_8_1.rarity_bg and var_8_1.rarity_bg ~= ""

	arg_8_0:updatePreference(arg_8_1)
	arg_8_0.shipDetailView:ActionInvokeExclusive("UpdateUI")
	arg_8_0.shipFashionView:ActionInvokeExclusive("UpdateUI")
	arg_8_0.shipEquipView:ActionInvokeExclusive("UpdateUI")

	if var_8_0 and not arg_8_0:checkToggleActive(ShipViewConst.currentPage) then
		triggerToggle(arg_8_0.detailToggle, true)
	end

	return
end

function var_0_0.equipmentChange(arg_9_0)
	if arg_9_0.shipDetailView then
		arg_9_0.shipDetailView:ActionInvoke("UpdateUI")
	end

	return
end

function var_0_0.setToggleEnable(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.togglesList) do
		setActive(iter_10_1, arg_10_0:checkToggleActive(iter_10_0))
	end

	setActive(arg_10_0.technologyToggle, arg_10_0.shipVO:isBluePrintShip())
	SetActive(arg_10_0.metaToggle, arg_10_0.shipVO:isMetaShip())

	return
end

function var_0_0.checkToggleActive(arg_11_0, arg_11_1)
	if arg_11_1 == ShipViewConst.PAGE.DETAIL then
		return true
	elseif arg_11_1 == ShipViewConst.PAGE.EQUIPMENT then
		return true
	elseif arg_11_1 == ShipViewConst.PAGE.INTENSIFY then
		return not arg_11_0.shipVO:isTestShip() and not arg_11_0.shipVO:isBluePrintShip() and not arg_11_0.shipVO:isMetaShip()
	elseif arg_11_1 == ShipViewConst.PAGE.UPGRADE then
		return not arg_11_0.shipVO:isTestShip() and not arg_11_0.shipVO:isBluePrintShip() and not arg_11_0.shipVO:isMetaShip()
	elseif arg_11_1 == ShipViewConst.PAGE.REMOULD then
		local var_11_0 = not arg_11_0.shipVO:isTestShip() and not arg_11_0.shipVO:isBluePrintShip() and pg.ship_data_trans[arg_11_0.shipVO.groupId] and not arg_11_0.shipVO:isMetaShip() or false

		if false then
			var_11_0 = true
		end

		return var_11_0
	elseif arg_11_1 == ShipViewConst.PAGE.FASHION then
		if not arg_11_0:hasFashion() then
			return false
		else
			local var_11_2

			if not PaintingGroupConst.IsPaintingNeedCheck() then
				var_11_2 = false
			else
				var_11_2 = PaintingGroupConst.CalcPaintingListSize((PaintingGroupConst.GetPaintingNameListByShipVO(arg_11_0.shipVO))) > 0
			end

			return not var_11_2
		end
	else
		return false
	end

	return
end

function var_0_0.setSkinList(arg_12_0, arg_12_1)
	arg_12_0.shipFashionView:ActionInvoke("SetSkinList", arg_12_1)

	return
end

function var_0_0.updateLock(arg_13_0)
	arg_13_0.shipDetailView:ActionInvoke("UpdateLock")

	return
end

function var_0_0.updatePreferenceTag(arg_14_0)
	arg_14_0.shipDetailView:ActionInvoke("UpdatePreferenceTag")

	return
end

function var_0_0.updateFashionTag(arg_15_0)
	arg_15_0.shipDetailView:ActionInvoke("UpdateFashionTag")

	return
end

function var_0_0.closeRecordPanel(arg_16_0)
	arg_16_0.shipDetailView:ActionInvoke("CloseRecordPanel")

	return
end

function var_0_0.updateRecordEquipments(arg_17_0, arg_17_1)
	arg_17_0.shipDetailView:UpdateRecordEquipments(arg_17_1)
	arg_17_0.shipDetailView:UpdateRecordSpWeapons(arg_17_1)

	return
end

function var_0_0.setModPanel(arg_18_0, arg_18_1)
	arg_18_0.modPanel = arg_18_1

	return
end

function var_0_0.setMaxLevelHelpFlag(arg_19_0, arg_19_1)
	arg_19_0.maxLevelHelpFlag = arg_19_1

	return
end

function var_0_0.checkMaxLevelHelp(arg_20_0)
	if not arg_20_0.maxLevelHelpFlag and arg_20_0.shipVO and arg_20_0.shipVO:isReachNextMaxLevel() then
		arg_20_0:openHelpPage()

		arg_20_0.maxLevelHelpFlag = true

		getProxy(SettingsProxy):setMaxLevelHelp(true)
	end

	return
end

function var_0_0.GetShareData(arg_21_0)
	if not arg_21_0.shareData then
		arg_21_0.shareData = ShipViewShareData.New(arg_21_0.contextData)

		arg_21_0.shipDetailView:SetShareData(arg_21_0.shareData)
		arg_21_0.shipFashionView:SetShareData(arg_21_0.shareData)
		arg_21_0.shipEquipView:SetShareData(arg_21_0.shareData)
		arg_21_0.shipEquipView:ActionInvoke("InitEvent")
		arg_21_0.shipHuntingRangeView:SetShareData(arg_21_0.shareData)
		arg_21_0.shipCustomMsgBox:SetShareData(arg_21_0.shareData)
		arg_21_0.shipChangeNameView:SetShareData(arg_21_0.shareData)
	end

	return arg_21_0.shareData
end

function var_0_0.hasFashion(arg_22_0)
	return arg_22_0.shareData:HasFashion()
end

function var_0_0.DisplayRenamePanel(arg_23_0, arg_23_1)
	arg_23_0.shipChangeNameView:Load()
	arg_23_0.shipChangeNameView:ActionInvoke("DisplayRenamePanel", arg_23_1)

	return
end

function var_0_0.init(arg_24_0)
	arg_24_0:initShip()
	arg_24_0:initPages()
	arg_24_0:initEvents()

	arg_24_0.mainCanvasGroup = arg_24_0._tf:GetComponent(typeof(CanvasGroup))
	arg_24_0.commonCanvasGroup = arg_24_0._tf:Find("blur_panel/adapt"):GetComponent(typeof(CanvasGroup))
	Input.multiTouchEnabled = false

	return
end

function var_0_0.initShip(arg_25_0)
	arg_25_0.shipInfo = arg_25_0._tf:Find("main/character")

	setActive(arg_25_0.shipInfo, true)

	arg_25_0.tablePainting = {
		arg_25_0.shipInfo:Find("painting"),
		arg_25_0.shipInfo:Find("painting2")
	}
	arg_25_0.nowPainting = nil
	arg_25_0.isRight = true
	arg_25_0.blurPanel = arg_25_0._tf:Find("blur_panel")
	arg_25_0.common = arg_25_0.blurPanel:Find("adapt")
	arg_25_0.npcFlagTF = arg_25_0.common:Find("name/npc")
	arg_25_0.shipName = arg_25_0.common:Find("name")
	arg_25_0.shipInfoStarTpl = arg_25_0.shipName:Find("star_tpl")
	arg_25_0.nameEditFlag = arg_25_0.shipName:Find("nameRect/editFlag")

	setActive(arg_25_0.shipName, true)
	setActive(arg_25_0.shipInfoStarTpl, false)
	setActive(arg_25_0.nameEditFlag, false)

	arg_25_0.energyTF = arg_25_0.shipName:Find("energy")
	arg_25_0.energyDescTF = arg_25_0.energyTF:Find("desc")
	arg_25_0.energyText = arg_25_0.energyTF:Find("desc/desc")

	setActive(arg_25_0.energyDescTF, false)

	arg_25_0.character = arg_25_0._tf:Find("main/character")
	arg_25_0.chat = arg_25_0._tf:Find("main/character/chat")
	arg_25_0.chatBg = arg_25_0._tf:Find("main/character/chat/chatbgtop")
	arg_25_0.chatText = arg_25_0.chat:Find("Text")
	rtf(arg_25_0.chat).localScale = Vector3.New(0, 0, 1)
	arg_25_0.initChatBgH = arg_25_0.chatBg.sizeDelta.y
	arg_25_0.initChatTextH = arg_25_0.chatText.sizeDelta.y
	arg_25_0.initfontSize = arg_25_0.chatText:GetComponent(typeof(Text)).fontSize

	return
end

function var_0_0.initPages(arg_26_0)
	ShipViewConst.currentPage = nil
	arg_26_0.background = arg_26_0._tf:Find("background")

	setActive(arg_26_0.background, true)

	arg_26_0.main = arg_26_0._tf:Find("main")
	arg_26_0.mainMask = arg_26_0.main:GetComponent(typeof(RectMask2D))
	arg_26_0.toggles = arg_26_0.common:Find("left_length/frame/root")
	arg_26_0.detailToggle = arg_26_0.toggles:Find("detail_toggle")
	arg_26_0.equipmentToggle = arg_26_0.toggles:Find("equpiment_toggle")
	arg_26_0.intensifyToggle = arg_26_0.toggles:Find("intensify_toggle")
	arg_26_0.upgradeToggle = arg_26_0.toggles:Find("upgrade_toggle")
	arg_26_0.remouldToggle = arg_26_0.toggles:Find("remould_toggle")
	arg_26_0.technologyToggle = arg_26_0.toggles:Find("technology_toggle")
	arg_26_0.metaToggle = arg_26_0.toggles:Find("meta_toggle")
	arg_26_0.togglesList = {}
	arg_26_0.togglesList[ShipViewConst.PAGE.DETAIL] = arg_26_0.detailToggle
	arg_26_0.togglesList[ShipViewConst.PAGE.EQUIPMENT] = arg_26_0.equipmentToggle
	arg_26_0.togglesList[ShipViewConst.PAGE.INTENSIFY] = arg_26_0.intensifyToggle
	arg_26_0.togglesList[ShipViewConst.PAGE.UPGRADE] = arg_26_0.upgradeToggle
	arg_26_0.togglesList[ShipViewConst.PAGE.REMOULD] = arg_26_0.remouldToggle
	arg_26_0.detailContainer = arg_26_0.main:Find("detail_container")

	setAnchoredPosition(arg_26_0.detailContainer, {
		x = 1300
	})

	arg_26_0.fashionContainer = arg_26_0.main:Find("fashion_container")

	setAnchoredPosition(arg_26_0.fashionContainer, {
		x = 900
	})

	arg_26_0.equipContainer = arg_26_0.main:Find("equip_container")
	arg_26_0.equipLCon = arg_26_0.equipContainer:Find("equipment_l_container")
	arg_26_0.equipRCon = arg_26_0.equipContainer:Find("equipment_r_container")
	arg_26_0.equipBCon = arg_26_0.equipContainer:Find("equipment_b_container")

	setAnchoredPosition(arg_26_0.equipRCon, {
		x = 750
	})
	setAnchoredPosition(arg_26_0.equipLCon, {
		x = -700
	})
	setAnchoredPosition(arg_26_0.equipBCon, {
		y = -540
	})

	arg_26_0.shipDetailView = ShipDetailView.New(arg_26_0.detailContainer, arg_26_0.event, arg_26_0.contextData)
	arg_26_0.shipFashionView = ShipFashionView.New(arg_26_0.fashionContainer, arg_26_0.event, arg_26_0.contextData)
	arg_26_0.shipEquipView = ShipEquipView.New(arg_26_0.equipContainer, arg_26_0.event, arg_26_0.contextData)
	arg_26_0.shipHuntingRangeView = ShipHuntingRangeView.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	arg_26_0.shipCustomMsgBox = ShipCustomMsgBox.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	arg_26_0.shipChangeNameView = ShipChangeNameView.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)
	arg_26_0.expItemUsagePage = ShipExpItemUsagePage.New(arg_26_0._tf, arg_26_0.event, arg_26_0.contextData)

	for iter_26_0, iter_26_1 in ipairs({
		arg_26_0.shipDetailView,
		arg_26_0.shipFashionView,
		arg_26_0.shipEquipView,
		arg_26_0.shipHuntingRangeView,
		arg_26_0.shipCustomMsgBox,
		arg_26_0.shipChangeNameView,
		arg_26_0.expItemUsagePage
	}) do
		iter_26_1:RegisterView(arg_26_0)
	end

	arg_26_0.viewList = {}
	arg_26_0.viewList[ShipViewConst.PAGE.DETAIL] = arg_26_0.shipDetailView
	arg_26_0.viewList[ShipViewConst.PAGE.FASHION] = arg_26_0.shipFashionView
	arg_26_0.viewList[ShipViewConst.PAGE.EQUIPMENT] = arg_26_0.shipEquipView

	onButton(arg_26_0, arg_26_0.shipName, function()
		if arg_26_0.shipVO.propose and not arg_26_0.shipVO:IsXIdol() then
			if not pg.PushNotificationMgr.GetInstance():isEnableShipName() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_rename_switch_tip"))

				return
			end

			local var_27_0 = arg_26_0.shipVO.renameTime + 0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_27_0 > 0 then
				local var_27_1 = math.floor(var_27_0 / 60 / 60 / 24)

				if var_27_1 < 1 then
					var_27_1 = 1
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("word_rename_time_tip", var_27_1))
			else
				arg_26_0:DisplayRenamePanel(true)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initEvents(arg_28_0)
	arg_28_0:bind(ShipViewConst.SWITCH_TO_PAGE, function(arg_29_0, arg_29_1)
		arg_28_0:gotoPage(arg_29_1)

		return
	end)
	arg_28_0:bind(ShipViewConst.LOAD_PAINTING, function(arg_30_0, arg_30_1, arg_30_2)
		arg_28_0:loadPainting(arg_30_1, arg_30_2)

		return
	end)
	arg_28_0:bind(ShipViewConst.LOAD_PAINTING_BG, function(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		arg_28_0:loadSkinBg(arg_31_1, arg_31_2, arg_31_3, arg_28_0.isSpBg)

		return
	end)
	arg_28_0:bind(ShipViewConst.HIDE_SHIP_WORD, function(arg_32_0)
		arg_28_0:hideShipWord()

		return
	end)
	arg_28_0:bind(ShipViewConst.SET_CLICK_ENABLE, function(arg_33_0, arg_33_1)
		arg_28_0.mainCanvasGroup.blocksRaycasts = arg_33_1
		arg_28_0.commonCanvasGroup.blocksRaycasts = arg_33_1
		GetOrAddComponent(arg_28_0.detailContainer, "CanvasGroup").blocksRaycasts = arg_33_1

		return
	end)
	arg_28_0:bind(ShipViewConst.SHOW_CUSTOM_MSG, function(arg_34_0, arg_34_1)
		arg_28_0.shipCustomMsgBox:Load()
		arg_28_0.shipCustomMsgBox:ActionInvoke("showCustomMsgBox", arg_34_1)

		return
	end)
	arg_28_0:bind(ShipViewConst.HIDE_CUSTOM_MSG, function(arg_35_0)
		arg_28_0.shipCustomMsgBox:ActionInvoke("hideCustomMsgBox")

		return
	end)
	arg_28_0:bind(ShipViewConst.DISPLAY_HUNTING_RANGE, function(arg_36_0, arg_36_1)
		if arg_36_1 then
			arg_28_0.shipHuntingRangeView:Load()
			arg_28_0.shipHuntingRangeView:ActionInvoke("DisplayHuntingRange")
		else
			arg_28_0.shipHuntingRangeView:HideHuntingRange()
		end

		return
	end)
	arg_28_0:bind(ShipViewConst.PAINT_VIEW, function(arg_37_0, arg_37_1)
		if arg_37_1 then
			arg_28_0:paintView()
		else
			arg_28_0:hidePaintView(true)
		end

		return
	end)
	arg_28_0:bind(ShipViewConst.SHOW_EXP_ITEM_USAGE, function(arg_38_0, arg_38_1)
		arg_28_0.expItemUsagePage:ExecuteAction("Show", arg_38_1)

		return
	end)

	return
end

function var_0_0.didEnter(arg_39_0)
	arg_39_0:addRingDragListenter()
	onButton(arg_39_0, arg_39_0.common:Find("top/back_btn"), function()
		GetOrAddComponent(arg_39_0._tf, typeof(CanvasGroup)).interactable = false

		if not arg_39_0.everTriggerBack then
			LeanTween.delayedCall(0.3, System.Action(function()
				arg_39_0:closeView()

				return
			end))

			arg_39_0.everTriggerBack = true
		end

		return
	end, SFX_CANCEL)
	onButton(arg_39_0, arg_39_0.npcFlagTF, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_actnpc.tip
		})

		return
	end, SFX_PANEL)

	arg_39_0.helpBtn = arg_39_0.common:Find("help_btn")

	onButton(arg_39_0, arg_39_0.helpBtn, function()
		arg_39_0:openHelpPage(ShipViewConst.currentPage)

		return
	end, SFX_PANEL)

	for iter_39_0, iter_39_1 in pairs(arg_39_0.togglesList) do
		if iter_39_1 == arg_39_0.upgradeToggle or iter_39_1 == arg_39_0.remouldToggle or iter_39_1 == arg_39_0.equipmentToggle then
			onToggle(arg_39_0, iter_39_1, function(arg_44_0)
				if arg_44_0 then
					if LeanTween.isTweening(go(arg_39_0.chat)) then
						LeanTween.cancel(go(arg_39_0.chat))
					end

					rtf(arg_39_0.chat).localScale = Vector3.New(0, 0, 1)
					arg_39_0.chatFlag = false

					arg_39_0:switchToPage(iter_39_0)
				end

				return
			end, SFX_PANEL)
		else
			onToggle(arg_39_0, iter_39_1, function(arg_45_0)
				if arg_45_0 then
					arg_39_0:switchToPage(iter_39_0)
				end

				return
			end, SFX_PANEL)
		end
	end

	onButton(arg_39_0, arg_39_0.technologyToggle, function()
		arg_39_0:emit(ShipMainMediator.ON_TECHNOLOGY, arg_39_0.shipVO)

		return
	end, SFX_PANEL)
	onButton(arg_39_0, arg_39_0.metaToggle, function()
		arg_39_0:emit(ShipMainMediator.ON_META, arg_39_0.shipVO)

		return
	end, SFX_PANEL)
	onButton(arg_39_0, tf(arg_39_0.character), function()
		if ShipViewConst.currentPage ~= ShipViewConst.PAGE.FASHION then
			arg_39_0:displayShipWord("detail")
		end

		return
	end)
	onButton(arg_39_0, arg_39_0.energyTF, function()
		arg_39_0:showEnergyDesc()
		getProxy(CommanderManualProxy):TaskProgressAdd(2022, 1)

		return
	end)
	arg_39_0:OverlayPanel(arg_39_0.chat, {
		groupDelta = 1
	})
	arg_39_0:OverlayPanel(arg_39_0.blurPanel)

	if arg_39_0:checkToggleActive(arg_39_0.contextData.page) then
		local var_39_0 = arg_39_0.contextData.page or ShipViewConst.PAGE.DETAIL

		arg_39_0:gotoPage(var_39_0)

		if ShipViewConst.currentPage == ShipViewConst.PAGE.DETAIL or var_39_0 == ShipViewConst.PAGE.DETAIL then
			arg_39_0:displayShipWord(arg_39_0:getInitmacyWords())
			arg_39_0:checkMaxLevelHelp()
		end

		arg_39_0:changePaintingSortLayer(true)

		return
	end
end

function var_0_0.openHelpPage(arg_50_0, arg_50_1)
	if arg_50_1 == ShipViewConst.PAGE.EQUIPMENT then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_equip.tip
		})
	elseif arg_50_1 == ShipViewConst.PAGE.DETAIL then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_detail.tip
		})
	elseif arg_50_1 == ShipViewConst.PAGE.INTENSIFY then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_intensify.tip
		})
	elseif arg_50_1 == ShipViewConst.PAGE.UPGRADE then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_upgrate.tip
		})
	elseif arg_50_1 == ShipViewConst.PAGE.FASHION then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_fashion.tip
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_maxlevel.tip
		})
	end

	return
end

function var_0_0.showAwakenCompleteAni(arg_51_0, arg_51_1)
	local function var_51_0()
		arg_51_0.awakenAni:SetActive(true)

		arg_51_0.awakenPlay = true

		onButton(arg_51_0, arg_51_0.awakenAni, function()
			arg_51_0.awakenAni:GetComponent("Animator"):SetBool("endFlag", true)

			return
		end)

		local var_52_0 = tf(arg_51_0.awakenAni)

		pg.UIMgr.GetInstance():BlurPanel(var_52_0)
		setText(var_52_0:Find("window/desc"), arg_51_1)
		var_52_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_54_0)
			arg_51_0.awakenAni:GetComponent("Animator"):SetBool("endFlag", false)
			pg.UIMgr.GetInstance():UnOverlayPanel(var_52_0, arg_51_0.common)
			arg_51_0.awakenAni:SetActive(false)

			arg_51_0.awakenPlay = false

			return
		end)

		return
	end

	local var_51_1 = arg_51_0._tf:Find("AwakenCompleteWindows(Clone)")

	if var_51_1 then
		arg_51_0.awakenAni = go(var_51_1)
	end

	if not arg_51_0.awakenAni then
		PoolMgr.GetInstance():GetUI("AwakenCompleteWindows", true, function(arg_55_0)
			arg_55_0:SetActive(true)

			arg_51_0.awakenAni = arg_55_0

			var_51_0()

			return
		end)
	else
		(function()
			arg_51_0.awakenAni:SetActive(true)

			arg_51_0.awakenPlay = true

			onButton(arg_51_0, arg_51_0.awakenAni, function()
				arg_51_0.awakenAni:GetComponent("Animator"):SetBool("endFlag", true)

				return
			end)

			local var_52_0 = tf(arg_51_0.awakenAni)

			pg.UIMgr.GetInstance():BlurPanel(var_52_0)
			setText(var_52_0:Find("window/desc"), arg_51_1)
			var_52_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_54_0)
				arg_51_0.awakenAni:GetComponent("Animator"):SetBool("endFlag", false)
				pg.UIMgr.GetInstance():UnOverlayPanel(var_52_0, arg_51_0.common)
				arg_51_0.awakenAni:SetActive(false)

				arg_51_0.awakenPlay = false

				return
			end)

			return
		end)()
	end

	return
end

function var_0_0.updatePreference(arg_56_0, arg_56_1)
	setScrollText(arg_56_0.shipName:Find("nameRect/name_mask/Text"), (arg_56_0.shipVO:getName()))
	setText(arg_56_0.shipName:Find("english_name"), arg_56_1:getConfigTable().english_name)

	local var_56_0 = arg_56_1.propose and not arg_56_1:IsXIdol()

	setActive(arg_56_0.nameEditFlag, var_56_0)

	local var_56_1 = GetSpriteFromAtlas("energy", arg_56_1:getEnergyPrint())

	if not var_56_1 then
		warning("找不到疲劳")
	end

	setImageSprite(arg_56_0.energyTF, var_56_1, true)
	setActive(arg_56_0.energyTF, true)

	local var_56_2 = arg_56_0.shipName:Find("stars")

	removeAllChildren(var_56_2)

	local var_56_3 = arg_56_1:getStar()

	for iter_56_0 = 1, arg_56_1:getMaxStar() do
		local var_56_4 = cloneTplTo(arg_56_0.shipInfoStarTpl, var_56_2, "star_" .. iter_56_0)

		setActive(var_56_4:Find("star_tpl"), iter_56_0 <= var_56_3)
		setActive(var_56_4:Find("empty_star_tpl"), true)
	end

	if ShipViewConst.currentPage ~= ShipViewConst.PAGE.FASHION then
		arg_56_0:loadPainting(arg_56_0.shipVO:getPainting())
		arg_56_0:loadSkinBg(arg_56_0.shipVO:rarity2bgPrintForGet(), arg_56_0.shipVO:isBluePrintShip(), arg_56_0.shipVO:isMetaShip(), arg_56_0.isSpBg)
	end

	local var_56_5 = GetSpriteFromAtlas("shiptype", arg_56_1:getShipType())

	if not var_56_5 then
		warning("找不到船形, shipConfigId: " .. arg_56_1.configId)
	end

	setImageSprite(arg_56_0.shipName:Find("type"), var_56_5, true)

	return
end

function var_0_0.doUpgradeMaxLeveAnim(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	arg_57_0.inUpgradeAnim = true

	arg_57_0.shipDetailView:DoLeveUpAnim(arg_57_1, arg_57_2, function()
		if arg_57_3 then
			arg_57_3()
		end

		arg_57_0.inUpgradeAnim = nil

		return
	end)

	return
end

function var_0_0.addRingDragListenter(arg_59_0)
	local var_59_0 = GetOrAddComponent(arg_59_0._tf, "EventTriggerListener")
	local var_59_1
	local var_59_2 = 0

	var_59_0:AddBeginDragFunc(function()
		var_59_2 = 0
		var_59_1 = nil

		return
	end)
	var_59_0:AddDragFunc(function(arg_61_0, arg_61_1)
		if not arg_59_0.inPaintingView then
			var_59_1 = var_59_1 or arg_61_1.position
			var_59_2 = arg_61_1.position.x - var_59_1.x
		end

		return
	end)
	var_59_0:AddDragEndFunc(function(arg_62_0, arg_62_1)
		if not arg_59_0.inPaintingView then
			if var_59_2 < -50 then
				if not arg_59_0.isLoading then
					arg_59_0:emit(ShipMainMediator.NEXTSHIP, -1)
				end
			elseif var_59_2 > 50 and not arg_59_0.isLoading then
				arg_59_0:emit(ShipMainMediator.NEXTSHIP)
			end
		end

		return
	end)

	return
end

function var_0_0.showEnergyDesc(arg_63_0)
	if arg_63_0.energyTimer then
		return
	end

	setActive(arg_63_0.energyDescTF, true)

	local var_63_0, var_63_1 = arg_63_0.shipVO:getEnergyPrint()

	setText(arg_63_0.energyText, i18n(var_63_1))

	arg_63_0.energyTimer = Timer.New(function()
		setActive(arg_63_0.energyDescTF, false)
		arg_63_0.energyTimer:Stop()

		arg_63_0.energyTimer = nil

		return
	end, 2, 1)

	arg_63_0.energyTimer:Start()

	return
end

function var_0_0.displayShipWord(arg_65_0, arg_65_1, arg_65_2)
	if ShipViewConst.currentPage == ShipViewConst.PAGE.EQUIPMENT or ShipViewConst.currentPage == ShipViewConst.PAGE.UPGRADE then
		rtf(arg_65_0.chat).localScale = Vector3.New(0, 0, 1)

		return
	end

	if arg_65_2 or not arg_65_0.chatFlag then
		arg_65_0.chatFlag = true
		arg_65_0.chat.localScale = Vector3.zero

		setActive(arg_65_0.chat, true)

		arg_65_0.chat.localPosition = Vector3(arg_65_0.character.localPosition.x + 100, arg_65_0.chat.localPosition.y, 0)

		local var_65_0 = arg_65_0.shipVO:getCVIntimacy()

		if findTF(arg_65_0.nowPainting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(arg_65_0.nowPainting, "fitter"):GetChild(0), arg_65_0.paintingCode, arg_65_1, var_65_0)
		end

		local var_65_1, var_65_2, var_65_3 = ShipWordHelper.GetWordAndCV(arg_65_0.shipVO:getSkinId(), arg_65_1, nil, nil, var_65_0)
		local var_65_4 = arg_65_0.chatText:GetComponent(typeof(Text))

		if PLATFORM_CODE ~= PLATFORM_US then
			setText(arg_65_0.chatText, SwitchSpecialChar(var_65_3))
		else
			var_65_4.fontSize = arg_65_0.initfontSize

			setTextEN(arg_65_0.chatText, var_65_3)

			while var_65_4.preferredHeight > arg_65_0.initChatTextH do
				var_65_4.fontSize = var_65_4.fontSize - 2

				setTextEN(arg_65_0.chatText, var_65_3)

				if var_65_4.fontSize < 20 then
					break
				end
			end
		end

		var_65_4.alignment = #var_65_4.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		local var_65_5 = var_65_4.preferredHeight + 120

		arg_65_0.chatBg.sizeDelta = var_65_4.preferredHeight + 120 > arg_65_0.initChatBgH and Vector2.New(arg_65_0.chatBg.sizeDelta.x, var_65_5) or Vector2.New(arg_65_0.chatBg.sizeDelta.x, arg_65_0.initChatBgH)

		local var_65_6 = var_0_4

		local function var_65_7()
			if arg_65_0.chatFlag then
				if arg_65_0.chatani1Id then
					LeanTween.cancel(arg_65_0.chatani1Id)
				end

				if arg_65_0.chatani2Id then
					LeanTween.cancel(arg_65_0.chatani2Id)
				end
			end

			local var_66_0 = arg_65_0

			var_66_0.chatani1Id = LeanTween.scale(rtf(arg_65_0.chat.gameObject), Vector3.New(1, 1, 1), var_0_3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				arg_65_0.chatani2Id = LeanTween.scale(rtf(arg_65_0.chat.gameObject), Vector3.New(0, 0, 1), var_0_3):setEase(LeanTweenType.easeInBack):setDelay(var_0_3 + var_65_6):setOnComplete(System.Action(function()
					arg_65_0.chatFlag = nil

					return
				end)).uniqueId

				return
			end)).uniqueId

			return
		end

		if var_65_2 then
			arg_65_0:StopPreVoice()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_65_2, function(arg_69_0)
				if arg_69_0 then
					var_65_6 = arg_69_0:GetLength() * 0.001
				end

				var_65_7()

				return
			end)

			arg_65_0.preVoiceContent = var_65_2
		else
			(function()
				if arg_65_0.chatFlag then
					if arg_65_0.chatani1Id then
						LeanTween.cancel(arg_65_0.chatani1Id)
					end

					if arg_65_0.chatani2Id then
						LeanTween.cancel(arg_65_0.chatani2Id)
					end
				end

				local var_66_0 = arg_65_0

				var_66_0.chatani1Id = LeanTween.scale(rtf(arg_65_0.chat.gameObject), Vector3.New(1, 1, 1), var_0_3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
					arg_65_0.chatani2Id = LeanTween.scale(rtf(arg_65_0.chat.gameObject), Vector3.New(0, 0, 1), var_0_3):setEase(LeanTweenType.easeInBack):setDelay(var_0_3 + var_65_6):setOnComplete(System.Action(function()
						arg_65_0.chatFlag = nil

						return
					end)).uniqueId

					return
				end)).uniqueId

				return
			end)()
		end
	end

	return
end

function var_0_0.StopPreVoice(arg_70_0)
	if arg_70_0.preVoiceContent ~= nil then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_70_0.preVoiceContent)
	end

	return
end

function var_0_0.startChatTimer(arg_71_0)
	if arg_71_0.chatFlag then
		return
	end

	if arg_71_0.chatTimer then
		arg_71_0.chatTimer:Stop()

		arg_71_0.chatTimer = nil
	end

	arg_71_0.chatTimer = Timer.New(function()
		arg_71_0:displayShipWord(arg_71_0:getInitmacyWords())

		return
	end, var_0_6, 1)

	arg_71_0.chatTimer:Start()

	return
end

function var_0_0.hideShipWord(arg_73_0)
	if arg_73_0.chatFlag then
		if arg_73_0.chatani1Id then
			LeanTween.cancel(arg_73_0.chatani1Id)
		end

		if arg_73_0.chatani2Id then
			LeanTween.cancel(arg_73_0.chatani2Id)
		end

		LeanTween.scale(rtf(arg_73_0.chat.gameObject), Vector3.New(0, 0, 1), var_0_3):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(function()
			arg_73_0.chatFlag = nil

			return
		end))
	end

	arg_73_0:StopPreVoice()

	return
end

function var_0_0.gotoPage(arg_75_0, arg_75_1)
	if arg_75_1 == ShipViewConst.PAGE.FASHION then
		arg_75_0:checkPaintingRes(function()
			arg_75_0:switchToPage(arg_75_1)

			return
		end)
	else
		triggerToggle(arg_75_0.togglesList[arg_75_1], true)
	end

	return
end

function var_0_0.switchToPage(arg_77_0, arg_77_1, arg_77_2)
	local function var_77_0(arg_78_0, arg_78_1)
		setActive(arg_77_0.detailContainer, false)

		if arg_78_0 == ShipViewConst.PAGE.DETAIL then
			setActive(arg_77_0.detailContainer, arg_78_1)

			if arg_78_1 then
				local var_78_0 = {
					arg_77_0.detailContainer.rect.width + 200,
					0
				}

				if not {
					arg_77_0.detailContainer.rect.width + 200,
					0
				} then
					var_78_0 = {
						0,
						arg_77_0.detailContainer.rect.width + 200
					}
				end

				shiftPanel(arg_77_0.detailContainer, var_78_0[2], 0, var_0_2, 0):setFrom(var_78_0[1])

				goto label_78_0

				if arg_78_0 == ShipViewConst.PAGE.EQUIPMENT then
					local var_78_1 = {
						arg_77_0.equipRCon.rect.width,
						10
					}
					local var_78_2 = {
						-arg_77_0.equipBCon.rect.height,
						0
					}
					local var_78_3 = arg_78_1 and 1 or 2

					shiftPanel(arg_77_0.equipLCon, ({
						-(arg_77_0.equipLCon.rect.width + 190),
						190
					})[arg_78_1 and 2 or 1], 0, var_0_2, 0):setFrom(({
						-(arg_77_0.equipLCon.rect.width + 190),
						190
					})[arg_78_1 and 1 or 2])
					shiftPanel(arg_77_0.equipRCon, var_78_1[var_78_4], 0, var_0_2, 0):setFrom(var_78_1[var_78_3])
					shiftPanel(arg_77_0.equipBCon, 0, var_78_2[var_78_4], var_0_2, 0):setFrom(var_78_2[var_78_3])

					goto label_78_0
				end

				::label_78_0::

				if arg_78_0 == ShipViewConst.PAGE.FASHION then
					if arg_78_1 then
						do
							local var_78_5 = {
								arg_77_0.fashionContainer.rect.width + 22,
								0
							}

							if not {
								arg_77_0.fashionContainer.rect.width + 22,
								0
							} then
								var_78_5 = {
									0,
									arg_77_0.fashionContainer.rect.width + 22
								}
							end

							shiftPanel(arg_77_0.fashionContainer, var_78_5[2], 0, var_0_2, 0):setFrom(var_78_5[1])

							if arg_78_1 then
								arg_77_0.shipFashionView:ActionInvoke("UpdateFashion")
							end

							if false then
								if arg_78_0 == ShipViewConst.PAGE.INTENSIFY then
									if arg_78_1 then
										arg_77_0:emit(ShipMainMediator.OPEN_INTENSIFY)
									else
										arg_77_0:emit(ShipMainMediator.CLOSE_INTENSIFY)
									end
								elseif arg_78_0 == ShipViewConst.PAGE.UPGRADE then
									if arg_78_1 then
										arg_77_0:emit(ShipMainMediator.ON_UPGRADE)
									else
										arg_77_0:emit(ShipMainMediator.CLOSE_UPGRADE)
									end
								elseif arg_78_0 == ShipViewConst.PAGE.REMOULD then
									if arg_78_1 then
										arg_77_0:emit(ShipMainMediator.OPEN_REMOULD)
									else
										arg_77_0:emit(ShipMainMediator.CLOSE_REMOULD)
									end
								end
							end
						end

						arg_77_0:blurPage(arg_78_0, arg_78_1)

						if arg_78_0 ~= ShipViewConst.PAGE.FASHION then
							arg_77_0.fashionSkinId = arg_77_0.shipVO:getSkinId()

							arg_77_0:loadPainting(arg_77_0.shipVO:getPainting())
						end

						local var_78_6 = not ShipViewConst.IsSubLayerPage(arg_78_0)
						local var_78_7 = arg_77_0.bgEffect[arg_77_0.shipVO:getRarity()]

						if var_78_7 then
							local var_78_9 = var_78_7

							if arg_78_0 ~= ShipViewConst.PAGE.REMOULD then
								local var_78_10 = arg_77_0.shipVO.bluePrintFlag and arg_77_0.shipVO.bluePrintFlag == 0

								var_78_8(var_78_9, var_78_10)
								arg_77_0:changePaintingSortLayer(true)
								setActive(arg_77_0.helpBtn, var_78_6)

								return
							end
						end
					end
				end
			end
		end
	end

	function switchHandler()
		if arg_77_1 == ShipViewConst.currentPage and arg_77_2 then
			var_77_0(arg_77_1, true)
		elseif arg_77_1 ~= ShipViewConst.currentPage then
			if ShipViewConst.currentPage then
				var_77_0(ShipViewConst.currentPage, false)
			end

			ShipViewConst.currentPage = arg_77_1
			arg_77_0.contextData.page = arg_77_1

			var_77_0(arg_77_1, true)
			arg_77_0:switchPainting()
		end

		return
	end

	if arg_77_0.viewList[arg_77_1] ~= nil then
		if not arg_77_0.viewList[arg_77_1]:GetLoaded() then
			arg_77_0.viewList[arg_77_1]:Load()
			arg_77_0.viewList[arg_77_1]:CallbackInvoke(switchHandler)
		else
			switchHandler()
		end
	else
		switchHandler()
	end

	return
end

function var_0_0.blurPage(arg_80_0, arg_80_1, arg_80_2)
	if arg_80_1 == ShipViewConst.PAGE.DETAIL then
		arg_80_0.shipDetailView:ActionInvoke("OnSelected", arg_80_2)
	elseif arg_80_1 == ShipViewConst.PAGE.EQUIPMENT then
		arg_80_0.shipEquipView:ActionInvoke("OnSelected", arg_80_2)
	elseif arg_80_1 == ShipViewConst.PAGE.FASHION then
		arg_80_0.shipFashionView:ActionInvoke("OnSelected", arg_80_2)
	elseif arg_80_1 == ShipViewConst.PAGE.INTENSIFY then
		-- block empty
	elseif arg_80_1 == ShipViewConst.PAGE.UPGRADE then
		-- block empty
	elseif arg_80_1 == ShipViewConst.PAGE.REMOULD then
		-- block empty
	end

	return
end

function var_0_0.switchPainting(arg_81_0)
	setActive(arg_81_0.shipInfo, not ShipViewConst.IsSubLayerPage(ShipViewConst.currentPage))
	setActive(arg_81_0.shipName, not ShipViewConst.IsSubLayerPage(ShipViewConst.currentPage))

	if ShipViewConst.currentPage == ShipViewConst.PAGE.EQUIPMENT then
		shiftPanel(arg_81_0.shipInfo, -20, 0, var_0_2, 0)

		arg_81_0.paintingFrameName = "zhuangbei"
	else
		shiftPanel(arg_81_0.shipInfo, -460, 0, var_0_2, 0)

		arg_81_0.paintingFrameName = "chuanwu"
	end

	local var_81_0 = GetOrAddComponent(findTF(arg_81_0.nowPainting, "fitter"), "PaintingScaler")

	var_81_0:Snapshoot()

	var_81_0.FrameName = arg_81_0.paintingFrameName

	local var_81_1 = LeanTween.value(go(arg_81_0.nowPainting), 0, 1, var_0_2):setOnUpdate(System.Action_float(function(arg_82_0)
		var_81_0.Tween = arg_82_0
		arg_81_0.chat.localPosition = Vector3(arg_81_0.character.localPosition.x + 100, arg_81_0.chat.localPosition.y, 0)

		return
	end)):setEase(LeanTweenType.easeInOutSine)

	return
end

function var_0_0.setPreOrNext(arg_83_0, arg_83_1, arg_83_2)
	arg_83_0.isRight = not not arg_83_1

	if arg_83_0.shipVO:getGroupId() ~= arg_83_2:getGroupId() then
		local var_83_0 = arg_83_0.switchCnt or 0

		arg_83_0.switchCnt = var_83_0 + 1
	end

	if arg_83_0.switchCnt and arg_83_0.switchCnt >= 10 then
		gcAll()

		arg_83_0.switchCnt = 0
	end

	return
end

function var_0_0.loadPainting(arg_84_0, arg_84_1, arg_84_2)
	arg_84_1 = MainMeshImagePainting.StaticGetPaintingName(arg_84_1)

	if arg_84_0.isLoading == true then
		return
	end

	for iter_84_0, iter_84_1 in pairs(arg_84_0.tablePainting) do
		iter_84_1.localScale = Vector3(1, 1, 1)
	end

	if arg_84_0.LoadShipVOId and not arg_84_2 and arg_84_0.LoadShipVOId == arg_84_0.shipVO.id and arg_84_0.LoadPaintingCode == arg_84_1 and not arg_84_2 then
		return
	end

	local var_84_1 = arg_84_0.isRight and 1800 or -1800
	local var_84_2 = arg_84_0:getPaintingFromTable(false)

	arg_84_0.isLoading = true

	local var_84_3 = arg_84_0.paintingCode

	if var_84_2 then
		table.insert({}, function(arg_85_0)
			local var_85_0 = var_84_2:GetComponent(typeof(CanvasGroup))

			LeanTween.cancel(go(var_85_0))
			LeanTween.alphaCanvas(var_85_0, 0, 0.3):setFrom(1):setUseEstimatedTime(true)
			LeanTween.moveX(var_84_2:GetComponent(typeof(RectTransform)), -var_84_1, 0.3):setFrom(0):setOnComplete(System.Action(function()
				retPaintingPrefab(var_84_2, var_84_3)
				arg_85_0()

				return
			end))

			return
		end)
	end

	local var_84_4 = arg_84_0:getPaintingFromTable(true)

	arg_84_0.paintingCode = arg_84_1

	if arg_84_0.paintingCode and var_84_4 then
		local var_84_5 = var_84_4:GetComponent(typeof(RectTransform))

		table.insert({}, function(arg_87_0)
			arg_84_0.nowPainting = var_84_4

			local var_87_0 = arg_84_0.paintingFrameName or "chuanwu"

			LoadPaintingPrefabAsync(var_84_4, var_0, arg_84_0.paintingCode, var_87_0, function()
				ShipExpressionHelper.SetExpression(findTF(var_84_4, "fitter"):GetChild(0), arg_84_0.paintingCode, arg_84_0:getInitmacyWords(), (arg_84_0.shipVO:getCVIntimacy()))
				arg_87_0()

				return
			end)

			return
		end)
		table.insert({}, function(arg_89_0)
			LeanTween.cancel(go(var_84_5))
			LeanTween.moveX(var_84_5, 0, 0.3):setFrom(var_84_1):setOnComplete(System.Action(arg_89_0))
			LeanTween.alphaCanvas(var_84_4:GetComponent(typeof(CanvasGroup)), 1, 0.3):setFrom(0):setUseEstimatedTime(true)

			return
		end)
	end

	parallelAsync({}, function()
		arg_84_0.LoadShipVOId = arg_84_0.shipVO.id
		arg_84_0.LoadPaintingCode = arg_84_1
		arg_84_0.isLoading = false

		return
	end)

	return
end

function var_0_0.getPaintingFromTable(arg_91_0, arg_91_1)
	if arg_91_0.tablePainting == nil then
		print("self.tablePainting为空")

		return
	end

	for iter_91_0 = 1, #arg_91_0.tablePainting do
		if findTF(arg_91_0.tablePainting[iter_91_0], "fitter").childCount == 0 then
			if arg_91_1 == true and arg_91_0.tablePainting[iter_91_0] then
				return arg_91_0.tablePainting[iter_91_0]
			end
		elseif arg_91_1 == false and arg_91_0.tablePainting[iter_91_0] then
			return arg_91_0.tablePainting[iter_91_0]
		end
	end

	return
end

function var_0_0.loadSkinBg(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4)
	arg_92_0.bgEffect = arg_92_0.bgEffect or {}

	if arg_92_0.shipSkinBg ~= arg_92_1 or arg_92_0.isDesign ~= arg_92_2 or arg_92_0.isMeta ~= arg_92_3 then
		arg_92_0.shipSkinBg = arg_92_1
		arg_92_0.isDesign = arg_92_2
		arg_92_0.isMeta = arg_92_3

		if arg_92_0.isDesign then
			if arg_92_0.metaBg then
				setActive(arg_92_0.metaBg, false)
			end

			if arg_92_0.bgEffect then
				for iter_92_0, iter_92_1 in pairs(arg_92_0.bgEffect) do
					setActive(iter_92_1, false)
				end
			end

			if arg_92_0.designBg and arg_92_0.designName ~= "raritydesign" .. arg_92_0.shipVO:getRarity() then
				PoolMgr.GetInstance():ReturnUI(arg_92_0.designName, arg_92_0.designBg)

				arg_92_0.designBg = nil
			end

			if not arg_92_0.designBg then
				PoolMgr.GetInstance():GetUI("raritydesign" .. arg_92_0.shipVO:getRarity(), true, function(arg_93_0)
					arg_92_0.designBg = arg_93_0
					arg_92_0.designName = "raritydesign" .. arg_92_0.shipVO:getRarity()

					arg_93_0.transform:SetParent(arg_92_0._tf, false)

					arg_93_0.transform.localPosition = Vector3(1, 1, 1)
					arg_93_0.transform.localScale = Vector3(1, 1, 1)

					arg_93_0.transform:SetSiblingIndex(1)
					setActive(arg_93_0, true)

					return
				end)
			else
				setActive(arg_92_0.designBg, true)
			end
		elseif arg_92_0.isMeta then
			if arg_92_0.designBg then
				setActive(arg_92_0.designBg, false)
			end

			if arg_92_0.metaBg and arg_92_0.metaName ~= "raritymeta" .. arg_92_0.shipVO:getRarity() then
				PoolMgr.GetInstance():ReturnUI(arg_92_0.metaName, arg_92_0.metaBg)

				arg_92_0.metaBg = nil
			end

			if not arg_92_0.metaBg then
				PoolMgr.GetInstance():GetUI("raritymeta" .. arg_92_0.shipVO:getRarity(), true, function(arg_94_0)
					arg_92_0.metaBg = arg_94_0
					arg_92_0.metaName = "raritymeta" .. arg_92_0.shipVO:getRarity()

					arg_94_0.transform:SetParent(arg_92_0._tf, false)

					arg_94_0.transform.localPosition = Vector3(1, 1, 1)
					arg_94_0.transform.localScale = Vector3(1, 1, 1)

					arg_94_0.transform:SetSiblingIndex(1)
					setActive(arg_94_0, true)

					return
				end)
			else
				setActive(arg_92_0.metaBg, true)
			end
		else
			if arg_92_0.designBg then
				setActive(arg_92_0.designBg, false)
			end

			if arg_92_0.metaBg then
				setActive(arg_92_0.metaBg, false)
			end

			for iter_92_2 = 1, 5 do
				local var_92_0 = arg_92_0.shipVO:getRarity()

				if arg_92_0.bgEffect[iter_92_2] then
					setActive(arg_92_0.bgEffect[iter_92_2], iter_92_2 == var_92_0 and ShipViewConst.currentPage ~= ShipViewConst.PAGE.REMOULD and not arg_92_4)
				elseif var_92_0 > 2 and var_92_0 == iter_92_2 and not arg_92_4 then
					PoolMgr.GetInstance():GetUI("al_bg02_" .. var_92_0 - 1, true, function(arg_95_0)
						arg_92_0.bgEffect[iter_92_2] = arg_95_0

						arg_95_0.transform:SetParent(arg_92_0._tf, false)

						arg_95_0.transform.localPosition = Vector3(0, 0, 0)
						arg_95_0.transform.localScale = Vector3(1, 1, 1)

						arg_95_0.transform:SetSiblingIndex(1)
						setActive(arg_95_0, not ShipViewConst.IsSubLayerPage(ShipViewConst.currentPage))

						return
					end)
				end

				arg_92_0:changePaintingSortLayer(true)
			end
		end

		GetSpriteFromAtlasAsync("bg/star_level_bg_" .. arg_92_1, "", function(arg_96_0)
			if not arg_92_0.exited and arg_92_0.shipSkinBg == arg_92_1 then
				setImageSprite(arg_92_0.background, arg_96_0)
			end

			return
		end)
	end

	return
end

function var_0_0.changePaintingSortLayer(arg_97_0, arg_97_1)
	for iter_97_0, iter_97_1 in ipairs(arg_97_0.tablePainting) do
		GetComponent(iter_97_1, typeof(Canvas)).sortingOrder = var_97_0
	end

	if arg_97_1 then
		local var_97_2 = arg_97_0.shipVO:getRarity()

		if arg_97_0.isDesign and arg_97_0.designBg then
			setActive(arg_97_0.designBg, true)
		elseif arg_97_0.bgEffect and var_97_2 and arg_97_0.bgEffect[var_97_2] then
			setActive(arg_97_0.bgEffect[var_97_2], true)
		end
	else
		if arg_97_0.designBg then
			setActive(arg_97_0.designBg, false)
		end

		if arg_97_0.bgEffect then
			for iter_97_2, iter_97_3 in pairs(arg_97_0.bgEffect) do
				setActive(iter_97_3, false)
			end
		end
	end

	return
end

function var_0_0.getInitmacyWords(arg_98_0)
	return "feeling" .. Mathf.Clamp(arg_98_0.shipVO:getIntimacyLevel(), 1, 5)
end

function var_0_0.paintView(arg_99_0)
	if LeanTween.isTweening(arg_99_0.chat.gameObject) then
		LeanTween.cancel(arg_99_0.chat.gameObject)

		arg_99_0.chat.localScale = Vector3(0, 0, 0)
		arg_99_0.chatFlag = nil
	end

	arg_99_0.character:GetComponent("Image").enabled = false
	arg_99_0.inPaintingView = true

	local var_99_0 = {}
	local var_99_1 = 0

	while var_99_1 < arg_99_0._tf.childCount do
		local var_99_2 = arg_99_0._tf:GetChild(var_99_1)

		if var_99_2.gameObject.activeSelf and var_99_2 ~= arg_99_0.main and var_99_2 ~= arg_99_0.background then
			({})[#{} + 1] = var_99_2

			setActive(var_99_2, false)
		end

		var_99_1 = var_99_1 + 1
	end

	local var_99_3 = arg_99_0.main.childCount
	local var_99_4 = 0

	while var_99_4 < var_99_3 do
		local var_99_5 = arg_99_0.main:GetChild(var_99_4)

		if var_99_5.gameObject.activeSelf and var_99_5 ~= arg_99_0.shipInfo then
			({})[#{} + 1] = var_99_5

			setActive(var_99_5, false)
		end

		var_99_4 = var_99_4 + 1
	end

	arg_99_0.shipDetailView:Hide()
	setActive(arg_99_0.blurPanel, false)
	setActive(pg.playerResUI._go, false)

	;({})[#{} + 1] = arg_99_0.chat

	openPortrait()
	setActive(arg_99_0.common, false)

	arg_99_0.mainMask.enabled = false

	arg_99_0.mainMask:PerformClipping()

	local var_99_6 = arg_99_0.nowPainting.anchoredPosition.x
	local var_99_7 = arg_99_0.nowPainting.anchoredPosition.y
	local var_99_8 = arg_99_0._tf.rect.width / UnityEngine.Screen.width
	local var_99_9 = arg_99_0._tf.rect.height / UnityEngine.Screen.height
	local var_99_10 = arg_99_0.nowPainting.rect.width / 2
	local var_99_11 = arg_99_0.nowPainting.rect.height / 2
	local var_99_12
	local var_99_13
	local var_99_14 = GetOrAddComponent(arg_99_0.background, "PinchZoom")
	local var_99_15 = GetOrAddComponent(arg_99_0.background, "EventTriggerListener")
	local var_99_16 = true
	local var_99_17 = false

	var_99_15:AddPointDownFunc(function(arg_100_0)
		if Input.touchCount == 1 or IsUnityEditor then
			var_99_17 = true
			var_99_16 = true
		elseif Input.touchCount >= 2 then
			var_99_16 = false
			var_99_17 = false
		end

		return
	end)
	var_99_15:AddPointUpFunc(function(arg_101_0)
		if Input.touchCount <= 2 then
			var_99_16 = true
		end

		return
	end)
	var_99_15:AddBeginDragFunc(function(arg_102_0, arg_102_1)
		var_99_17 = false
		var_99_12 = arg_102_1.position.x * var_99_8 - var_99_10 - tf(arg_99_0.nowPainting).localPosition.x
		var_99_13 = arg_102_1.position.y * var_99_9 - var_99_11 - tf(arg_99_0.nowPainting).localPosition.y

		return
	end)
	var_99_15:AddDragFunc(function(arg_103_0, arg_103_1)
		if var_99_14.processing then
			return
		end

		if var_99_16 then
			local var_103_0 = tf(arg_99_0.nowPainting).localPosition

			tf(arg_99_0.nowPainting).localPosition = Vector3(arg_103_1.position.x * var_99_8 - var_99_10 - var_99_12, arg_103_1.position.y * var_99_9 - var_99_11 - var_99_13, -22)
		end

		return
	end)
	onButton(arg_99_0, arg_99_0.background, function()
		arg_99_0:hidePaintView()

		return
	end, SFX_CANCEL)

	function var_0_0.hidePaintView(arg_105_0, arg_105_1)
		if not arg_105_1 and not var_99_17 then
			return
		end

		arg_105_0.character:GetComponent("Image").enabled = true
		Input.multiTouchEnabled = false

		setActive(arg_105_0.common, true)
		SwitchPanel(arg_105_0.shipInfo, -460, nil, var_0_2 * 2)

		var_99_15.enabled = false
		var_99_14.enabled = false
		arg_105_0.character.localScale = Vector3.one

		arg_105_0.shipDetailView:Show()
		setActive(arg_105_0.blurPanel, true)
		setActive(pg.playerResUI._go, true)

		for iter_105_0, iter_105_1 in ipairs(var_99_0) do
			setActive(iter_105_1, true)
		end

		closePortrait()

		arg_105_0.nowPainting.localScale = Vector3(1, 1, 1)

		setAnchoredPosition(arg_105_0.nowPainting, {
			x = var_99_6,
			y = var_99_7
		})

		arg_105_0.background:GetComponent("Button").enabled = false
		arg_105_0.nowPainting:GetComponent("CanvasGroup").blocksRaycasts = true
		arg_105_0.mainMask.enabled = true

		arg_105_0.mainMask:PerformClipping()

		arg_105_0.inPaintingView = false

		return
	end

	SwitchPanel(arg_99_0.shipInfo, var_0_1, nil, var_0_2 * 2):setOnComplete(System.Action(function()
		var_99_14.enabled = true
		var_99_15.enabled = true
		arg_99_0.background:GetComponent("Button").enabled = true
		arg_99_0.nowPainting:GetComponent("CanvasGroup").blocksRaycasts = false

		return
	end))

	return
end

function var_0_0.onBackPressed(arg_107_0)
	if arg_107_0.inUpgradeAnim then
		return
	end

	if arg_107_0.awakenPlay then
		return
	end

	if arg_107_0.shipChangeNameView.isOpenRenamePanel then
		arg_107_0.shipChangeNameView:ActionInvoke("DisplayRenamePanel", false)

		return
	end

	if arg_107_0.shipCustomMsgBox.isShowCustomMsgBox then
		arg_107_0.shipCustomMsgBox:ActionInvoke("hideCustomMsgBox")

		return
	end

	if arg_107_0.shipHuntingRangeView.onSelected then
		arg_107_0.shipHuntingRangeView:ActionInvoke("HideHuntingRange")

		return
	end

	if arg_107_0.inPaintingView then
		arg_107_0:hidePaintView(true)

		return
	end

	if arg_107_0.expItemUsagePage and arg_107_0.expItemUsagePage:GetLoaded() and arg_107_0.expItemUsagePage:isShowing() then
		arg_107_0.expItemUsagePage:Hide()

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_107_0.common:Find("top/back_btn"))

	return
end

function var_0_0.willExit(arg_108_0)
	Input.multiTouchEnabled = true

	arg_108_0:UnOverlayPanel(arg_108_0.chat, arg_108_0.character)
	arg_108_0:blurPage(ShipViewConst.currentPage)
	setActive(arg_108_0.background, false)

	if arg_108_0.designBg then
		PoolMgr.GetInstance():ReturnUI(arg_108_0.designName, arg_108_0.designBg)
	end

	if arg_108_0.metaBg then
		PoolMgr.GetInstance():ReturnUI(arg_108_0.metaName, arg_108_0.metaBg)
	end

	arg_108_0.intensifyToggle:GetComponent("Toggle").onValueChanged:RemoveAllListeners()
	arg_108_0.upgradeToggle:GetComponent("Toggle").onValueChanged:RemoveAllListeners()
	LeanTween.cancel(arg_108_0.chat.gameObject)

	if arg_108_0.paintingCode then
		for iter_108_0 = 1, #arg_108_0.tablePainting do
			local var_108_0 = go(arg_108_0.tablePainting[iter_108_0])

			if LeanTween.isTweening(var_108_0) then
				LeanTween.cancel(go(var_108_0))
			end
		end

		retPaintingPrefab(arg_108_0.nowPainting, arg_108_0.paintingCode)
	end

	arg_108_0.shipDetailView:Destroy()
	arg_108_0.shipFashionView:Destroy()
	arg_108_0.shipEquipView:Destroy()
	arg_108_0.shipHuntingRangeView:Destroy()
	arg_108_0.shipCustomMsgBox:Destroy()
	arg_108_0.shipChangeNameView:Destroy()
	clearImageSprite(arg_108_0.background)

	if arg_108_0.energyTimer then
		arg_108_0.energyTimer:Stop()

		arg_108_0.energyTimer = nil
	end

	if arg_108_0.chatTimer then
		arg_108_0.chatTimer:Stop()

		arg_108_0.chatTimer = nil
	end

	arg_108_0:StopPreVoice()
	cameraPaintViewAdjust(false)

	if arg_108_0.tweens then
		cancelTweens(arg_108_0.tweens)
	end

	arg_108_0:UnOverlayPanel(arg_108_0.blurPanel, arg_108_0._tf)

	arg_108_0.shareData = nil

	return
end

function var_0_0.RefreshShipExpItemUsagePage(arg_109_0)
	if arg_109_0.expItemUsagePage and arg_109_0.expItemUsagePage:GetLoaded() and arg_109_0.expItemUsagePage:isShowing() then
		arg_109_0.expItemUsagePage:Flush(arg_109_0.shipVO)
	end

	return
end

function var_0_0.OnWillLogout(arg_110_0)
	if arg_110_0.inPaintingView then
		arg_110_0:hidePaintView(true)
	end

	return
end

function var_0_0.checkPaintingRes(arg_111_0, arg_111_1)
	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = PaintingGroupConst.GetPaintingNameListByShipVO(arg_111_0.shipVO),
		finishFunc = arg_111_1
	})

	return
end

return var_0_0
