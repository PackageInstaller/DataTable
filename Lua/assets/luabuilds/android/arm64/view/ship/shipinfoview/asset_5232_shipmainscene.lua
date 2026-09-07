local ShipMainScene = class("ShipMainScene", import("...base.BaseUI"))
local var_0_1 = 0
local var_0_2 = 0.2
local var_0_3 = 0.3
local var_0_4 = 3
local var_0_6 = 11

function ShipMainScene:getUIName()
	return "ShipMainScene"
end

function ShipMainScene:ResUISettings()
	return true
end

function ShipMainScene:preload(arg_3_1)
	local var_3_0 = getProxy(BayProxy):getShipById(self.contextData.shipId)

	parallelAsync({
		function(arg_4_0)
			GetSpriteFromAtlasAsync("bg/star_level_bg_" .. var_3_0:rarity2bgPrintForGet(), "", arg_4_0)

			return
		end,
		function(arg_5_0)
			if self.exited then
				return
			end

			PoolMgr.GetInstance():PreloadUI("ShipDetailView", arg_5_0)

			return
		end
	}, arg_3_1)

	return
end

function ShipMainScene:setPlayer(arg_6_1)
	self.player = arg_6_1

	self:GetShareData():SetPlayer(arg_6_1)

	return
end

function ShipMainScene:setShipList(arg_7_1)
	self.shipList = arg_7_1

	return
end

function ShipMainScene:setShip(arg_8_1)
	self:GetShareData():SetShipVO(arg_8_1)

	local var_8_0 = false

	if self.shipVO and self.shipVO.id ~= arg_8_1.id then
		self:StopPreVoice()

		var_8_0 = true
	end

	self.shipVO = arg_8_1

	setActive(self.npcFlagTF, arg_8_1:isActivityNpc())
	self:setToggleEnable()

	local var_8_1 = pg.ship_skin_template[self.shipVO:getSkinId()]

	self.isSpBg = var_8_1.rarity_bg and var_8_1.rarity_bg ~= ""

	self:updatePreference(arg_8_1)
	self.shipDetailView:ActionInvokeExclusive("UpdateUI")
	self.shipFashionView:ActionInvokeExclusive("UpdateUI")
	self.shipEquipView:ActionInvokeExclusive("UpdateUI")

	if var_8_0 and not self:checkToggleActive(ShipViewConst.currentPage) then
		triggerToggle(self.detailToggle, true)
	end

	return
end

function ShipMainScene:equipmentChange()
	if self.shipDetailView then
		self.shipDetailView:ActionInvoke("UpdateUI")
	end

	return
end

function ShipMainScene:setToggleEnable()
	for iter_10_0, iter_10_1 in pairs(self.togglesList) do
		setActive(iter_10_1, self:checkToggleActive(iter_10_0))
	end

	setActive(self.technologyToggle, self.shipVO:isBluePrintShip())
	SetActive(self.metaToggle, self.shipVO:isMetaShip())

	return
end

function ShipMainScene:checkToggleActive(arg_11_1)
	if arg_11_1 == ShipViewConst.PAGE.DETAIL then
		return true
	elseif arg_11_1 == ShipViewConst.PAGE.EQUIPMENT then
		return true
	elseif arg_11_1 == ShipViewConst.PAGE.INTENSIFY then
		return not self.shipVO:isTestShip() and not self.shipVO:isBluePrintShip() and not self.shipVO:isMetaShip()
	elseif arg_11_1 == ShipViewConst.PAGE.UPGRADE then
		return not self.shipVO:isTestShip() and not self.shipVO:isBluePrintShip() and not self.shipVO:isMetaShip()
	elseif arg_11_1 == ShipViewConst.PAGE.REMOULD then
		local var_11_0 = not self.shipVO:isTestShip() and not self.shipVO:isBluePrintShip() and pg.ship_data_trans[self.shipVO.groupId] and not self.shipVO:isMetaShip() or false

		return (false or nil) and true
	elseif arg_11_1 == ShipViewConst.PAGE.FASHION then
		if not self:hasFashion() then
			return false
		else
			return not ((PaintingGroupConst.IsPaintingNeedCheck() or false) and PaintingGroupConst.CalcPaintingListSize((PaintingGroupConst.GetPaintingNameListByShipVO(self.shipVO))) > 0)
		end
	else
		return false
	end

	return
end

function ShipMainScene:setSkinList(arg_12_1)
	self.shipFashionView:ActionInvoke("SetSkinList", arg_12_1)

	return
end

function ShipMainScene:updateLock()
	self.shipDetailView:ActionInvoke("UpdateLock")

	return
end

function ShipMainScene:updatePreferenceTag()
	self.shipDetailView:ActionInvoke("UpdatePreferenceTag")

	return
end

function ShipMainScene:updateFashionTag()
	self.shipDetailView:ActionInvoke("UpdateFashionTag")

	return
end

function ShipMainScene:closeRecordPanel()
	self.shipDetailView:ActionInvoke("CloseRecordPanel")

	return
end

function ShipMainScene:updateRecordEquipments(arg_17_1)
	self.shipDetailView:UpdateRecordEquipments(arg_17_1)
	self.shipDetailView:UpdateRecordSpWeapons(arg_17_1)

	return
end

function ShipMainScene:setModPanel(arg_18_1)
	self.modPanel = arg_18_1

	return
end

function ShipMainScene:setMaxLevelHelpFlag(arg_19_1)
	self.maxLevelHelpFlag = arg_19_1

	return
end

function ShipMainScene:checkMaxLevelHelp()
	if not self.maxLevelHelpFlag and self.shipVO and self.shipVO:isReachNextMaxLevel() then
		self:openHelpPage()

		self.maxLevelHelpFlag = true

		getProxy(SettingsProxy):setMaxLevelHelp(true)
	end

	return
end

function ShipMainScene:GetShareData()
	if not self.shareData then
		self.shareData = ShipViewShareData.New(self.contextData)

		self.shipDetailView:SetShareData(self.shareData)
		self.shipFashionView:SetShareData(self.shareData)
		self.shipEquipView:SetShareData(self.shareData)
		self.shipEquipView:ActionInvoke("InitEvent")
		self.shipHuntingRangeView:SetShareData(self.shareData)
		self.shipCustomMsgBox:SetShareData(self.shareData)
		self.shipChangeNameView:SetShareData(self.shareData)
	end

	return self.shareData
end

function ShipMainScene:hasFashion()
	return self.shareData:HasFashion()
end

function ShipMainScene:DisplayRenamePanel(arg_23_1)
	self.shipChangeNameView:Load()
	self.shipChangeNameView:ActionInvoke("DisplayRenamePanel", arg_23_1)

	return
end

function ShipMainScene:init()
	self:initShip()
	self:initPages()
	self:initEvents()

	self.mainCanvasGroup = self._tf:GetComponent(typeof(CanvasGroup))
	self.commonCanvasGroup = self._tf:Find("blur_panel/adapt"):GetComponent(typeof(CanvasGroup))
	Input.multiTouchEnabled = false

	return
end

function ShipMainScene:initShip()
	self.shipInfo = self._tf:Find("main/character")

	setActive(self.shipInfo, true)

	self.tablePainting = {
		self.shipInfo:Find("painting"),
		self.shipInfo:Find("painting2")
	}
	self.nowPainting = nil
	self.isRight = true
	self.blurPanel = self._tf:Find("blur_panel")
	self.common = self.blurPanel:Find("adapt")
	self.npcFlagTF = self.common:Find("name/npc")
	self.shipName = self.common:Find("name")
	self.shipInfoStarTpl = self.shipName:Find("star_tpl")
	self.nameEditFlag = self.shipName:Find("nameRect/editFlag")

	setActive(self.shipName, true)
	setActive(self.shipInfoStarTpl, false)
	setActive(self.nameEditFlag, false)

	self.energyTF = self.shipName:Find("energy")
	self.energyDescTF = self.energyTF:Find("desc")
	self.energyText = self.energyTF:Find("desc/desc")

	setActive(self.energyDescTF, false)

	self.character = self._tf:Find("main/character")
	self.chat = self._tf:Find("main/character/chat")
	self.chatBg = self._tf:Find("main/character/chat/chatbgtop")
	self.chatText = self.chat:Find("Text")
	rtf(self.chat).localScale = Vector3.New(0, 0, 1)
	self.initChatBgH = self.chatBg.sizeDelta.y
	self.initChatTextH = self.chatText.sizeDelta.y
	self.initfontSize = self.chatText:GetComponent(typeof(Text)).fontSize

	return
end

function ShipMainScene:initPages()
	ShipViewConst.currentPage = nil
	self.background = self._tf:Find("background")

	setActive(self.background, true)

	self.main = self._tf:Find("main")
	self.mainMask = self.main:GetComponent(typeof(RectMask2D))
	self.toggles = self.common:Find("left_length/frame/root")
	self.detailToggle = self.toggles:Find("detail_toggle")
	self.equipmentToggle = self.toggles:Find("equpiment_toggle")
	self.intensifyToggle = self.toggles:Find("intensify_toggle")
	self.upgradeToggle = self.toggles:Find("upgrade_toggle")
	self.remouldToggle = self.toggles:Find("remould_toggle")
	self.technologyToggle = self.toggles:Find("technology_toggle")
	self.metaToggle = self.toggles:Find("meta_toggle")
	self.togglesList = {}
	self.togglesList[ShipViewConst.PAGE.DETAIL] = self.detailToggle
	self.togglesList[ShipViewConst.PAGE.EQUIPMENT] = self.equipmentToggle
	self.togglesList[ShipViewConst.PAGE.INTENSIFY] = self.intensifyToggle
	self.togglesList[ShipViewConst.PAGE.UPGRADE] = self.upgradeToggle
	self.togglesList[ShipViewConst.PAGE.REMOULD] = self.remouldToggle
	self.detailContainer = self.main:Find("detail_container")

	setAnchoredPosition(self.detailContainer, {
		x = 1300
	})

	self.fashionContainer = self.main:Find("fashion_container")

	setAnchoredPosition(self.fashionContainer, {
		x = 900
	})

	self.equipContainer = self.main:Find("equip_container")
	self.equipLCon = self.equipContainer:Find("equipment_l_container")
	self.equipRCon = self.equipContainer:Find("equipment_r_container")
	self.equipBCon = self.equipContainer:Find("equipment_b_container")

	setAnchoredPosition(self.equipRCon, {
		x = 750
	})
	setAnchoredPosition(self.equipLCon, {
		x = -700
	})
	setAnchoredPosition(self.equipBCon, {
		y = -540
	})

	self.shipDetailView = ShipDetailView.New(self.detailContainer, self.event, self.contextData)
	self.shipFashionView = ShipFashionView.New(self.fashionContainer, self.event, self.contextData)
	self.shipEquipView = ShipEquipView.New(self.equipContainer, self.event, self.contextData)
	self.shipHuntingRangeView = ShipHuntingRangeView.New(self._tf, self.event, self.contextData)
	self.shipCustomMsgBox = ShipCustomMsgBox.New(self._tf, self.event, self.contextData)
	self.shipChangeNameView = ShipChangeNameView.New(self._tf, self.event, self.contextData)
	self.expItemUsagePage = ShipExpItemUsagePage.New(self._tf, self.event, self.contextData)

	for iter_26_0, iter_26_1 in ipairs({
		self.shipDetailView,
		self.shipFashionView,
		self.shipEquipView,
		self.shipHuntingRangeView,
		self.shipCustomMsgBox,
		self.shipChangeNameView,
		self.expItemUsagePage
	}) do
		iter_26_1:RegisterView(self)
	end

	self.viewList = {}
	self.viewList[ShipViewConst.PAGE.DETAIL] = self.shipDetailView
	self.viewList[ShipViewConst.PAGE.FASHION] = self.shipFashionView
	self.viewList[ShipViewConst.PAGE.EQUIPMENT] = self.shipEquipView

	onButton(self, self.shipName, function()
		if self.shipVO.propose and not self.shipVO:IsXIdol() then
			if not pg.PushNotificationMgr.GetInstance():isEnableShipName() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_rename_switch_tip"))

				return
			end

			local var_27_0 = self.shipVO.renameTime + 0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_27_0 > 0 then
				local var_27_1 = math.floor(var_27_0 / 60 / 60 / 24)

				if var_27_1 < 1 then
					var_27_1 = 1
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("word_rename_time_tip", var_27_1))
			else
				self:DisplayRenamePanel(true)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function ShipMainScene:initEvents()
	self:bind(ShipViewConst.SWITCH_TO_PAGE, function(arg_29_0, arg_29_1)
		self:gotoPage(arg_29_1)

		return
	end)
	self:bind(ShipViewConst.LOAD_PAINTING, function(arg_30_0, arg_30_1, arg_30_2)
		self:loadPainting(arg_30_1, arg_30_2)

		return
	end)
	self:bind(ShipViewConst.LOAD_PAINTING_BG, function(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		self:loadSkinBg(arg_31_1, arg_31_2, arg_31_3, self.isSpBg)

		return
	end)
	self:bind(ShipViewConst.HIDE_SHIP_WORD, function(arg_32_0)
		self:hideShipWord()

		return
	end)
	self:bind(ShipViewConst.SET_CLICK_ENABLE, function(arg_33_0, arg_33_1)
		self.mainCanvasGroup.blocksRaycasts = arg_33_1
		self.commonCanvasGroup.blocksRaycasts = arg_33_1
		GetOrAddComponent(self.detailContainer, "CanvasGroup").blocksRaycasts = arg_33_1

		return
	end)
	self:bind(ShipViewConst.SHOW_CUSTOM_MSG, function(arg_34_0, arg_34_1)
		self.shipCustomMsgBox:Load()
		self.shipCustomMsgBox:ActionInvoke("showCustomMsgBox", arg_34_1)

		return
	end)
	self:bind(ShipViewConst.HIDE_CUSTOM_MSG, function(arg_35_0)
		self.shipCustomMsgBox:ActionInvoke("hideCustomMsgBox")

		return
	end)
	self:bind(ShipViewConst.DISPLAY_HUNTING_RANGE, function(arg_36_0, arg_36_1)
		if arg_36_1 then
			self.shipHuntingRangeView:Load()
			self.shipHuntingRangeView:ActionInvoke("DisplayHuntingRange")
		else
			self.shipHuntingRangeView:HideHuntingRange()
		end

		return
	end)
	self:bind(ShipViewConst.PAINT_VIEW, function(arg_37_0, arg_37_1)
		if arg_37_1 then
			self:paintView()
		else
			self:hidePaintView(true)
		end

		return
	end)
	self:bind(ShipViewConst.SHOW_EXP_ITEM_USAGE, function(arg_38_0, arg_38_1)
		self.expItemUsagePage:ExecuteAction("Show", arg_38_1)

		return
	end)

	return
end

function ShipMainScene:didEnter()
	self:addRingDragListenter()
	onButton(self, self.common:Find("top/back_btn"), function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		if not self.everTriggerBack then
			LeanTween.delayedCall(0.3, System.Action(function()
				self:closeView()

				return
			end))

			self.everTriggerBack = true
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.npcFlagTF, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_shipinfo_actnpc.tip
		})

		return
	end, SFX_PANEL)

	self.helpBtn = self.common:Find("help_btn")

	onButton(self, self.helpBtn, function()
		self:openHelpPage(ShipViewConst.currentPage)

		return
	end, SFX_PANEL)

	for iter_39_0, iter_39_1 in pairs(self.togglesList) do
		if iter_39_1 == self.upgradeToggle or iter_39_1 == self.remouldToggle or iter_39_1 == self.equipmentToggle then
			onToggle(self, iter_39_1, function(arg_44_0)
				if arg_44_0 then
					if LeanTween.isTweening(go(self.chat)) then
						LeanTween.cancel(go(self.chat))
					end

					rtf(self.chat).localScale = Vector3.New(0, 0, 1)
					self.chatFlag = false

					self:switchToPage(iter_39_0)
				end

				return
			end, SFX_PANEL)
		else
			onToggle(self, iter_39_1, function(arg_45_0)
				if arg_45_0 then
					self:switchToPage(iter_39_0)
				end

				return
			end, SFX_PANEL)
		end
	end

	onButton(self, self.technologyToggle, function()
		self:emit(ShipMainMediator.ON_TECHNOLOGY, self.shipVO)

		return
	end, SFX_PANEL)
	onButton(self, self.metaToggle, function()
		self:emit(ShipMainMediator.ON_META, self.shipVO)

		return
	end, SFX_PANEL)
	onButton(self, tf(self.character), function()
		if ShipViewConst.currentPage ~= ShipViewConst.PAGE.FASHION then
			self:displayShipWord("detail")
		end

		return
	end)
	onButton(self, self.energyTF, function()
		self:showEnergyDesc()
		getProxy(CommanderManualProxy):TaskProgressAdd(2022, 1)

		return
	end)
	self:OverlayPanel(self.chat, {
		groupDelta = 1
	})
	self:OverlayPanel(self.blurPanel)

	local var_39_0

	if self:checkToggleActive(self.contextData.page) then
		var_39_0 = self.contextData.page or ShipViewConst.PAGE.DETAIL
	end

	self:gotoPage(var_39_0)

	if ShipViewConst.currentPage == ShipViewConst.PAGE.DETAIL or var_39_0 == ShipViewConst.PAGE.DETAIL then
		self:displayShipWord(self:getInitmacyWords())
		self:checkMaxLevelHelp()
	end

	self:changePaintingSortLayer(true)

	return
end

function ShipMainScene:openHelpPage(arg_50_1)
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

function ShipMainScene:showAwakenCompleteAni(arg_51_1)
	local function var_51_0()
		self.awakenAni:SetActive(true)

		self.awakenPlay = true

		onButton(self, self.awakenAni, function()
			self.awakenAni:GetComponent("Animator"):SetBool("endFlag", true)

			return
		end)

		local var_52_0 = tf(self.awakenAni)

		pg.UIMgr.GetInstance():BlurPanel(var_52_0)
		setText(var_52_0:Find("window/desc"), arg_51_1)
		var_52_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_54_0)
			self.awakenAni:GetComponent("Animator"):SetBool("endFlag", false)
			pg.UIMgr.GetInstance():UnOverlayPanel(var_52_0, self.common)
			self.awakenAni:SetActive(false)

			self.awakenPlay = false

			return
		end)

		return
	end

	local var_51_1 = self._tf:Find("AwakenCompleteWindows(Clone)")

	if var_51_1 then
		self.awakenAni = go(var_51_1)
	end

	if not self.awakenAni then
		PoolMgr.GetInstance():GetUI("AwakenCompleteWindows", true, function(arg_55_0)
			arg_55_0:SetActive(true)

			self.awakenAni = arg_55_0

			var_51_0()

			return
		end)
	else
		var_51_0()
	end

	return
end

function ShipMainScene:updatePreference(arg_56_1)
	setScrollText(self.shipName:Find("nameRect/name_mask/Text"), (self.shipVO:getName()))
	setText(self.shipName:Find("english_name"), arg_56_1:getConfigTable().english_name)
	setActive(self.nameEditFlag, arg_56_1.propose and not arg_56_1:IsXIdol())

	local var_56_0 = GetSpriteFromAtlas("energy", arg_56_1:getEnergyPrint())

	if not var_56_0 then
		warning("找不到疲劳")
	end

	setImageSprite(self.energyTF, var_56_0, true)
	setActive(self.energyTF, true)

	local var_56_1 = self.shipName:Find("stars")

	removeAllChildren(var_56_1)

	local var_56_2 = arg_56_1:getStar()

	for iter_56_0 = 1, arg_56_1:getMaxStar() do
		local var_56_3 = cloneTplTo(self.shipInfoStarTpl, var_56_1, "star_" .. iter_56_0)

		setActive(var_56_3:Find("star_tpl"), iter_56_0 <= var_56_2)
		setActive(var_56_3:Find("empty_star_tpl"), true)
	end

	if ShipViewConst.currentPage ~= ShipViewConst.PAGE.FASHION then
		self:loadPainting(self.shipVO:getPainting())
		self:loadSkinBg(self.shipVO:rarity2bgPrintForGet(), self.shipVO:isBluePrintShip(), self.shipVO:isMetaShip(), self.isSpBg)
	end

	local var_56_4 = GetSpriteFromAtlas("shiptype", arg_56_1:getShipType())

	if not var_56_4 then
		warning("找不到船形, shipConfigId: " .. arg_56_1.configId)
	end

	setImageSprite(self.shipName:Find("type"), var_56_4, true)

	return
end

function ShipMainScene:doUpgradeMaxLeveAnim(arg_57_1, arg_57_2, arg_57_3)
	self.inUpgradeAnim = true

	self.shipDetailView:DoLeveUpAnim(arg_57_1, arg_57_2, function()
		if arg_57_3 then
			arg_57_3()
		end

		self.inUpgradeAnim = nil

		return
	end)

	return
end

function ShipMainScene:addRingDragListenter()
	local var_59_0 = GetOrAddComponent(self._tf, "EventTriggerListener")
	local var_59_1
	local var_59_2 = 0

	var_59_0:AddBeginDragFunc(function()
		var_59_2 = 0
		var_59_1 = nil

		return
	end)
	var_59_0:AddDragFunc(function(arg_61_0, arg_61_1)
		if not self.inPaintingView then
			var_59_1 = var_59_1 or arg_61_1.position
			var_59_2 = arg_61_1.position.x - var_59_1.x
		end

		return
	end)
	var_59_0:AddDragEndFunc(function(arg_62_0, arg_62_1)
		if not self.inPaintingView then
			if var_59_2 < -50 then
				if not self.isLoading then
					self:emit(ShipMainMediator.NEXTSHIP, -1)
				end
			elseif var_59_2 > 50 and not self.isLoading then
				self:emit(ShipMainMediator.NEXTSHIP)
			end
		end

		return
	end)

	return
end

function ShipMainScene:showEnergyDesc()
	if self.energyTimer then
		return
	end

	setActive(self.energyDescTF, true)

	local var_63_0, var_63_1 = self.shipVO:getEnergyPrint()

	setText(self.energyText, i18n(var_63_1))

	self.energyTimer = Timer.New(function()
		setActive(self.energyDescTF, false)
		self.energyTimer:Stop()

		self.energyTimer = nil

		return
	end, 2, 1)

	self.energyTimer:Start()

	return
end

function ShipMainScene:displayShipWord(arg_65_1, arg_65_2)
	if ShipViewConst.currentPage == ShipViewConst.PAGE.EQUIPMENT or ShipViewConst.currentPage == ShipViewConst.PAGE.UPGRADE then
		rtf(self.chat).localScale = Vector3.New(0, 0, 1)

		return
	end

	if arg_65_2 or not self.chatFlag then
		self.chatFlag = true
		self.chat.localScale = Vector3.zero

		setActive(self.chat, true)

		self.chat.localPosition = Vector3(self.character.localPosition.x + 100, self.chat.localPosition.y, 0)

		local var_65_0 = self.shipVO:getCVIntimacy()

		if findTF(self.nowPainting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(self.nowPainting, "fitter"):GetChild(0), self.paintingCode, arg_65_1, var_65_0)
		end

		local var_65_1, var_65_2, var_65_3 = ShipWordHelper.GetWordAndCV(self.shipVO:getSkinId(), arg_65_1, nil, nil, var_65_0)
		local var_65_4 = self.chatText:GetComponent(typeof(Text))

		if PLATFORM_CODE ~= PLATFORM_US then
			setText(self.chatText, SwitchSpecialChar(var_65_3))
		else
			var_65_4.fontSize = self.initfontSize

			setTextEN(self.chatText, var_65_3)

			while var_65_4.preferredHeight > self.initChatTextH do
				var_65_4.fontSize = var_65_4.fontSize - 2

				setTextEN(self.chatText, var_65_3)

				if var_65_4.fontSize < 20 then
					break
				end
			end
		end

		var_65_4.alignment = #var_65_4.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
		self.chatBg.sizeDelta = var_65_4.preferredHeight + 120 > self.initChatBgH and Vector2.New(self.chatBg.sizeDelta.x, var_65_4.preferredHeight + 120) or Vector2.New(self.chatBg.sizeDelta.x, self.initChatBgH)

		local var_65_5 = var_0_4

		local function var_65_6()
			if self.chatFlag then
				if self.chatani1Id then
					LeanTween.cancel(self.chatani1Id)
				end

				if self.chatani2Id then
					LeanTween.cancel(self.chatani2Id)
				end
			end

			self.chatani1Id = LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(1, 1, 1), var_0_3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				self.chatani2Id = LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(0, 0, 1), var_0_3):setEase(LeanTweenType.easeInBack):setDelay(var_0_3 + var_65_5):setOnComplete(System.Action(function()
					self.chatFlag = nil

					return
				end)).uniqueId

				return
			end)).uniqueId

			return
		end

		if var_65_2 then
			self:StopPreVoice()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_65_2, function(arg_69_0)
				if arg_69_0 then
					var_65_5 = arg_69_0:GetLength() * 0.001
				end

				var_65_6()

				return
			end)

			self.preVoiceContent = var_65_2
		else
			var_65_6()
		end
	end

	return
end

function ShipMainScene:StopPreVoice()
	if self.preVoiceContent ~= nil then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self.preVoiceContent)
	end

	return
end

function ShipMainScene:startChatTimer()
	if self.chatFlag then
		return
	end

	if self.chatTimer then
		self.chatTimer:Stop()

		self.chatTimer = nil
	end

	self.chatTimer = Timer.New(function()
		self:displayShipWord(self:getInitmacyWords())

		return
	end, var_0_6, 1)

	self.chatTimer:Start()

	return
end

function ShipMainScene:hideShipWord()
	if self.chatFlag then
		if self.chatani1Id then
			LeanTween.cancel(self.chatani1Id)
		end

		if self.chatani2Id then
			LeanTween.cancel(self.chatani2Id)
		end

		LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(0, 0, 1), var_0_3):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(function()
			self.chatFlag = nil

			return
		end))
	end

	self:StopPreVoice()

	return
end

function ShipMainScene:gotoPage(arg_75_1)
	if arg_75_1 == ShipViewConst.PAGE.FASHION then
		self:checkPaintingRes(function()
			self:switchToPage(arg_75_1)

			return
		end)
	else
		triggerToggle(self.togglesList[arg_75_1], true)
	end

	return
end

function ShipMainScene:switchToPage(arg_77_1, arg_77_2)
	local function var_77_0(arg_78_0, arg_78_1)
		setActive(self.detailContainer, false)

		if arg_78_0 == ShipViewConst.PAGE.DETAIL then
			setActive(self.detailContainer, arg_78_1)

			local var_78_0 = arg_78_1 and {
				self.detailContainer.rect.width + 200,
				0
			} or {
				0,
				self.detailContainer.rect.width + 200
			}

			shiftPanel(self.detailContainer, var_78_0[2], 0, var_0_2, 0):setFrom(var_78_0[1])
		elseif arg_78_0 == ShipViewConst.PAGE.EQUIPMENT then
			local var_78_1 = {
				-(self.equipLCon.rect.width + 190),
				190
			}
			local var_78_2 = {
				self.equipRCon.rect.width,
				10
			}
			local var_78_3 = {
				-self.equipBCon.rect.height,
				0
			}
			local var_78_4 = arg_78_1 and 1 or 2
			local var_78_5 = arg_78_1 and 2 or 1

			shiftPanel(self.equipLCon, var_78_1[arg_78_1 and 2 or 1], 0, var_0_2, 0):setFrom(var_78_1[arg_78_1 and 1 or 2])
			shiftPanel(self.equipRCon, var_78_2[var_78_5], 0, var_0_2, 0):setFrom(var_78_2[var_78_4])
			shiftPanel(self.equipBCon, 0, var_78_3[var_78_5], var_0_2, 0):setFrom(var_78_3[var_78_4])
		elseif arg_78_0 == ShipViewConst.PAGE.FASHION then
			local var_78_6 = arg_78_1 and {
				self.fashionContainer.rect.width + 22,
				0
			} or {
				0,
				self.fashionContainer.rect.width + 22
			}

			shiftPanel(self.fashionContainer, var_78_6[2], 0, var_0_2, 0):setFrom(var_78_6[1])

			if arg_78_1 then
				self.shipFashionView:ActionInvoke("UpdateFashion")
			end
		elseif arg_78_0 == ShipViewConst.PAGE.INTENSIFY then
			if arg_78_1 then
				self:emit(ShipMainMediator.OPEN_INTENSIFY)
			else
				self:emit(ShipMainMediator.CLOSE_INTENSIFY)
			end
		elseif arg_78_0 == ShipViewConst.PAGE.UPGRADE then
			if arg_78_1 then
				self:emit(ShipMainMediator.ON_UPGRADE)
			else
				self:emit(ShipMainMediator.CLOSE_UPGRADE)
			end
		elseif arg_78_0 == ShipViewConst.PAGE.REMOULD then
			if arg_78_1 then
				self:emit(ShipMainMediator.OPEN_REMOULD)
			else
				self:emit(ShipMainMediator.CLOSE_REMOULD)
			end
		end

		self:blurPage(arg_78_0, arg_78_1)

		if arg_78_0 ~= ShipViewConst.PAGE.FASHION then
			self.fashionSkinId = self.shipVO:getSkinId()

			self:loadPainting(self.shipVO:getPainting())
		end

		local var_78_7 = not ShipViewConst.IsSubLayerPage(arg_78_0)
		local var_78_8 = self.bgEffect[self.shipVO:getRarity()]

		if var_78_8 then
			setActive(var_78_8, (arg_78_0 ~= ShipViewConst.PAGE.REMOULD or nil) and self.shipVO.bluePrintFlag and self.shipVO.bluePrintFlag == 0)
			self:changePaintingSortLayer(true)
		end

		setActive(self.helpBtn, var_78_7)

		return
	end

	function switchHandler()
		if arg_77_1 == ShipViewConst.currentPage and arg_77_2 then
			var_77_0(arg_77_1, true)
		elseif arg_77_1 ~= ShipViewConst.currentPage then
			if ShipViewConst.currentPage then
				var_77_0(ShipViewConst.currentPage, false)
			end

			ShipViewConst.currentPage = arg_77_1
			self.contextData.page = arg_77_1

			var_77_0(arg_77_1, true)
			self:switchPainting()
		end

		return
	end

	if self.viewList[arg_77_1] ~= nil then
		if not self.viewList[arg_77_1]:GetLoaded() then
			self.viewList[arg_77_1]:Load()
			self.viewList[arg_77_1]:CallbackInvoke(switchHandler)
		else
			switchHandler()
		end
	else
		switchHandler()
	end

	return
end

function ShipMainScene:blurPage(arg_80_1, arg_80_2)
	if arg_80_1 == ShipViewConst.PAGE.DETAIL then
		self.shipDetailView:ActionInvoke("OnSelected", arg_80_2)
	elseif arg_80_1 == ShipViewConst.PAGE.EQUIPMENT then
		self.shipEquipView:ActionInvoke("OnSelected", arg_80_2)
	elseif arg_80_1 == ShipViewConst.PAGE.FASHION then
		self.shipFashionView:ActionInvoke("OnSelected", arg_80_2)
	elseif arg_80_1 == ShipViewConst.PAGE.INTENSIFY then
		-- block empty
	elseif arg_80_1 == ShipViewConst.PAGE.UPGRADE then
		-- block empty
	elseif arg_80_1 == ShipViewConst.PAGE.REMOULD then
		-- block empty
	end

	return
end

function ShipMainScene:switchPainting()
	setActive(self.shipInfo, not ShipViewConst.IsSubLayerPage(ShipViewConst.currentPage))
	setActive(self.shipName, not ShipViewConst.IsSubLayerPage(ShipViewConst.currentPage))

	if ShipViewConst.currentPage == ShipViewConst.PAGE.EQUIPMENT then
		shiftPanel(self.shipInfo, -20, 0, var_0_2, 0)

		self.paintingFrameName = "zhuangbei"
	else
		shiftPanel(self.shipInfo, -460, 0, var_0_2, 0)

		self.paintingFrameName = "chuanwu"
	end

	local var_81_0 = GetOrAddComponent(findTF(self.nowPainting, "fitter"), "PaintingScaler")

	var_81_0:Snapshoot()

	var_81_0.FrameName = self.paintingFrameName

	local var_81_1 = LeanTween.value(go(self.nowPainting), 0, 1, var_0_2):setOnUpdate(System.Action_float(function(arg_82_0)
		var_81_0.Tween = arg_82_0
		self.chat.localPosition = Vector3(self.character.localPosition.x + 100, self.chat.localPosition.y, 0)

		return
	end)):setEase(LeanTweenType.easeInOutSine)

	return
end

function ShipMainScene:setPreOrNext(arg_83_1, arg_83_2)
	self.isRight = not not arg_83_1

	if self.shipVO:getGroupId() ~= arg_83_2:getGroupId() then
		self.switchCnt = (self.switchCnt or 0) + 1
	end

	if self.switchCnt and self.switchCnt >= 10 then
		gcAll()

		self.switchCnt = 0
	end

	return
end

function ShipMainScene:loadPainting(arg_84_1, arg_84_2)
	local var_84_0 = arg_84_1

	arg_84_1 = MainMeshImagePainting.StaticGetPaintingName(arg_84_1)

	if self.isLoading == true then
		return
	end

	for iter_84_0, iter_84_1 in pairs(self.tablePainting) do
		iter_84_1.localScale = Vector3(1, 1, 1)
	end

	if self.LoadShipVOId and not arg_84_2 and self.LoadShipVOId == self.shipVO.id and self.LoadPaintingCode == arg_84_1 and not arg_84_2 then
		return
	end

	local var_84_2 = self.isRight and 1800 or -1800
	local var_84_3 = self:getPaintingFromTable(false)

	self.isLoading = true

	local var_84_4 = self.paintingCode
	local var_84_5 = {}

	if var_84_3 then
		table.insert(var_84_5, function(arg_85_0)
			local var_85_0 = var_84_3:GetComponent(typeof(CanvasGroup))

			LeanTween.cancel(go(var_85_0))
			LeanTween.alphaCanvas(var_85_0, 0, 0.3):setFrom(1):setUseEstimatedTime(true)
			LeanTween.moveX(var_84_3:GetComponent(typeof(RectTransform)), -var_84_2, 0.3):setFrom(0):setOnComplete(System.Action(function()
				retPaintingPrefab(var_84_3, var_84_4)
				arg_85_0()

				return
			end))

			return
		end)
	end

	local var_84_6 = self:getPaintingFromTable(true)

	self.paintingCode = arg_84_1

	if self.paintingCode and var_84_6 then
		local var_84_7 = var_84_6:GetComponent(typeof(RectTransform))

		table.insert(var_84_5, function(arg_87_0)
			self.nowPainting = var_84_6

			LoadPaintingPrefabAsync(var_84_6, var_84_0, self.paintingCode, self.paintingFrameName or "chuanwu", function()
				ShipExpressionHelper.SetExpression(findTF(var_84_6, "fitter"):GetChild(0), self.paintingCode, self:getInitmacyWords(), (self.shipVO:getCVIntimacy()))
				arg_87_0()

				return
			end)

			return
		end)
		table.insert(var_84_5, function(arg_89_0)
			LeanTween.cancel(go(var_84_7))
			LeanTween.moveX(var_84_7, 0, 0.3):setFrom(var_84_2):setOnComplete(System.Action(arg_89_0))
			LeanTween.alphaCanvas(var_84_6:GetComponent(typeof(CanvasGroup)), 1, 0.3):setFrom(0):setUseEstimatedTime(true)

			return
		end)
	end

	parallelAsync(var_84_5, function()
		self.LoadShipVOId = self.shipVO.id
		self.LoadPaintingCode = arg_84_1
		self.isLoading = false

		return
	end)

	return
end

function ShipMainScene:getPaintingFromTable(arg_91_1)
	if self.tablePainting == nil then
		print("self.tablePainting为空")

		return
	end

	for iter_91_0 = 1, #self.tablePainting do
		if findTF(self.tablePainting[iter_91_0], "fitter").childCount == 0 then
			if arg_91_1 == true and self.tablePainting[iter_91_0] then
				return self.tablePainting[iter_91_0]
			end
		elseif arg_91_1 == false and self.tablePainting[iter_91_0] then
			return self.tablePainting[iter_91_0]
		end
	end

	return
end

function ShipMainScene:loadSkinBg(arg_92_1, arg_92_2, arg_92_3, arg_92_4)
	self.bgEffect = self.bgEffect or {}

	if self.shipSkinBg ~= arg_92_1 or self.isDesign ~= arg_92_2 or self.isMeta ~= arg_92_3 then
		self.shipSkinBg = arg_92_1
		self.isDesign = arg_92_2
		self.isMeta = arg_92_3

		if self.isDesign then
			if self.metaBg then
				setActive(self.metaBg, false)
			end

			if self.bgEffect then
				for iter_92_0, iter_92_1 in pairs(self.bgEffect) do
					setActive(iter_92_1, false)
				end
			end

			if self.designBg and self.designName ~= "raritydesign" .. self.shipVO:getRarity() then
				PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)

				self.designBg = nil
			end

			if not self.designBg then
				PoolMgr.GetInstance():GetUI("raritydesign" .. self.shipVO:getRarity(), true, function(arg_93_0)
					self.designBg = arg_93_0
					self.designName = "raritydesign" .. self.shipVO:getRarity()

					arg_93_0.transform:SetParent(self._tf, false)

					arg_93_0.transform.localPosition = Vector3(1, 1, 1)
					arg_93_0.transform.localScale = Vector3(1, 1, 1)

					arg_93_0.transform:SetSiblingIndex(1)
					setActive(arg_93_0, true)

					return
				end)
			else
				setActive(self.designBg, true)
			end
		elseif self.isMeta then
			if self.designBg then
				setActive(self.designBg, false)
			end

			if self.metaBg and self.metaName ~= "raritymeta" .. self.shipVO:getRarity() then
				PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)

				self.metaBg = nil
			end

			if not self.metaBg then
				PoolMgr.GetInstance():GetUI("raritymeta" .. self.shipVO:getRarity(), true, function(arg_94_0)
					self.metaBg = arg_94_0
					self.metaName = "raritymeta" .. self.shipVO:getRarity()

					arg_94_0.transform:SetParent(self._tf, false)

					arg_94_0.transform.localPosition = Vector3(1, 1, 1)
					arg_94_0.transform.localScale = Vector3(1, 1, 1)

					arg_94_0.transform:SetSiblingIndex(1)
					setActive(arg_94_0, true)

					return
				end)
			else
				setActive(self.metaBg, true)
			end
		else
			if self.designBg then
				setActive(self.designBg, false)
			end

			if self.metaBg then
				setActive(self.metaBg, false)
			end

			for iter_92_2 = 1, 5 do
				local var_92_0 = self.shipVO:getRarity()

				if self.bgEffect[iter_92_2] then
					setActive(self.bgEffect[iter_92_2], iter_92_2 == var_92_0 and ShipViewConst.currentPage ~= ShipViewConst.PAGE.REMOULD and not arg_92_4)
				elseif var_92_0 > 2 and var_92_0 == iter_92_2 and not arg_92_4 then
					PoolMgr.GetInstance():GetUI("al_bg02_" .. var_92_0 - 1, true, function(arg_95_0)
						self.bgEffect[iter_92_2] = arg_95_0

						arg_95_0.transform:SetParent(self._tf, false)

						arg_95_0.transform.localPosition = Vector3(0, 0, 0)
						arg_95_0.transform.localScale = Vector3(1, 1, 1)

						arg_95_0.transform:SetSiblingIndex(1)
						setActive(arg_95_0, not ShipViewConst.IsSubLayerPage(ShipViewConst.currentPage))

						return
					end)
				end

				self:changePaintingSortLayer(true)
			end
		end

		GetSpriteFromAtlasAsync("bg/star_level_bg_" .. arg_92_1, "", function(arg_96_0)
			if not self.exited and self.shipSkinBg == arg_92_1 then
				setImageSprite(self.background, arg_96_0)
			end

			return
		end)
	end

	return
end

function ShipMainScene:changePaintingSortLayer(arg_97_1)
	for iter_97_0, iter_97_1 in ipairs(self.tablePainting) do
		GetComponent(iter_97_1, typeof(Canvas)).sortingOrder = var_97_0
	end

	if arg_97_1 then
		local var_97_2 = self.shipVO:getRarity()

		if self.isDesign and self.designBg then
			setActive(self.designBg, true)
		elseif self.bgEffect and var_97_2 and self.bgEffect[var_97_2] then
			setActive(self.bgEffect[var_97_2], true)
		end
	else
		if self.designBg then
			setActive(self.designBg, false)
		end

		if self.bgEffect then
			for iter_97_2, iter_97_3 in pairs(self.bgEffect) do
				setActive(iter_97_3, false)
			end
		end
	end

	return
end

function ShipMainScene:getInitmacyWords()
	return "feeling" .. Mathf.Clamp(self.shipVO:getIntimacyLevel(), 1, 5)
end

function ShipMainScene:paintView()
	if LeanTween.isTweening(self.chat.gameObject) then
		LeanTween.cancel(self.chat.gameObject)

		self.chat.localScale = Vector3(0, 0, 0)
		self.chatFlag = nil
	end

	self.character:GetComponent("Image").enabled = false
	self.inPaintingView = true

	local var_99_0 = {}
	local var_99_1 = 0

	while var_99_1 < self._tf.childCount do
		local var_99_2 = self._tf:GetChild(var_99_1)

		if var_99_2.gameObject.activeSelf and var_99_2 ~= self.main and var_99_2 ~= self.background then
			var_99_0[#var_99_0 + 1] = var_99_2

			setActive(var_99_2, false)
		end

		var_99_1 = var_99_1 + 1
	end

	local var_99_3 = 0

	while var_99_3 < self.main.childCount do
		local var_99_4 = self.main:GetChild(var_99_3)

		if var_99_4.gameObject.activeSelf and var_99_4 ~= self.shipInfo then
			var_99_0[#var_99_0 + 1] = var_99_4

			setActive(var_99_4, false)
		end

		var_99_3 = var_99_3 + 1
	end

	self.shipDetailView:Hide()
	setActive(self.blurPanel, false)
	setActive(pg.playerResUI._go, false)

	var_99_0[#var_99_0 + 1] = self.chat

	openPortrait()
	setActive(self.common, false)

	self.mainMask.enabled = false

	self.mainMask:PerformClipping()

	local var_99_5 = self.nowPainting.anchoredPosition.x
	local var_99_6 = self.nowPainting.anchoredPosition.y
	local var_99_7 = self._tf.rect.width / UnityEngine.Screen.width
	local var_99_8 = self._tf.rect.height / UnityEngine.Screen.height
	local var_99_9 = self.nowPainting.rect.width / 2
	local var_99_10 = self.nowPainting.rect.height / 2
	local var_99_11
	local var_99_12
	local var_99_13 = GetOrAddComponent(self.background, "PinchZoom")
	local var_99_14 = GetOrAddComponent(self.background, "EventTriggerListener")
	local var_99_15 = true
	local var_99_16 = false

	var_99_14:AddPointDownFunc(function(arg_100_0)
		if Input.touchCount == 1 or IsUnityEditor then
			var_99_16 = true
			var_99_15 = true
		elseif Input.touchCount >= 2 then
			var_99_15 = false
			var_99_16 = false
		end

		return
	end)
	var_99_14:AddPointUpFunc(function(arg_101_0)
		if Input.touchCount <= 2 then
			var_99_15 = true
		end

		return
	end)
	var_99_14:AddBeginDragFunc(function(arg_102_0, arg_102_1)
		var_99_16 = false
		var_99_11 = arg_102_1.position.x * var_99_7 - var_99_9 - tf(self.nowPainting).localPosition.x
		var_99_12 = arg_102_1.position.y * var_99_8 - var_99_10 - tf(self.nowPainting).localPosition.y

		return
	end)
	var_99_14:AddDragFunc(function(arg_103_0, arg_103_1)
		if var_99_13.processing then
			return
		end

		if var_99_15 then
			local var_103_0 = tf(self.nowPainting).localPosition

			tf(self.nowPainting).localPosition = Vector3(arg_103_1.position.x * var_99_7 - var_99_9 - var_99_11, arg_103_1.position.y * var_99_8 - var_99_10 - var_99_12, -22)
		end

		return
	end)
	onButton(self, self.background, function()
		self:hidePaintView()

		return
	end, SFX_CANCEL)

	function ShipMainScene:hidePaintView(arg_105_1)
		if not arg_105_1 and not var_99_16 then
			return
		end

		self.character:GetComponent("Image").enabled = true
		Input.multiTouchEnabled = false

		setActive(self.common, true)
		SwitchPanel(self.shipInfo, -460, nil, var_0_2 * 2)

		var_99_14.enabled = false
		var_99_13.enabled = false
		self.character.localScale = Vector3.one

		self.shipDetailView:Show()
		setActive(self.blurPanel, true)
		setActive(pg.playerResUI._go, true)

		for iter_105_0, iter_105_1 in ipairs(var_99_0) do
			setActive(iter_105_1, true)
		end

		closePortrait()

		self.nowPainting.localScale = Vector3(1, 1, 1)

		setAnchoredPosition(self.nowPainting, {
			x = var_99_5,
			y = var_99_6
		})

		self.background:GetComponent("Button").enabled = false
		self.nowPainting:GetComponent("CanvasGroup").blocksRaycasts = true
		self.mainMask.enabled = true

		self.mainMask:PerformClipping()

		self.inPaintingView = false

		return
	end

	SwitchPanel(self.shipInfo, var_0_1, nil, var_0_2 * 2):setOnComplete(System.Action(function()
		var_99_13.enabled = true
		var_99_14.enabled = true
		self.background:GetComponent("Button").enabled = true
		self.nowPainting:GetComponent("CanvasGroup").blocksRaycasts = false

		return
	end))

	return
end

function ShipMainScene:onBackPressed()
	if self.inUpgradeAnim then
		return
	end

	if self.awakenPlay then
		return
	end

	if self.shipChangeNameView.isOpenRenamePanel then
		self.shipChangeNameView:ActionInvoke("DisplayRenamePanel", false)

		return
	end

	if self.shipCustomMsgBox.isShowCustomMsgBox then
		self.shipCustomMsgBox:ActionInvoke("hideCustomMsgBox")

		return
	end

	if self.shipHuntingRangeView.onSelected then
		self.shipHuntingRangeView:ActionInvoke("HideHuntingRange")

		return
	end

	if self.inPaintingView then
		self:hidePaintView(true)

		return
	end

	if self.expItemUsagePage and self.expItemUsagePage:GetLoaded() and self.expItemUsagePage:isShowing() then
		self.expItemUsagePage:Hide()

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self.common:Find("top/back_btn"))

	return
end

function ShipMainScene:willExit()
	Input.multiTouchEnabled = true

	self:UnOverlayPanel(self.chat, self.character)
	self:blurPage(ShipViewConst.currentPage)
	setActive(self.background, false)

	if self.designBg then
		PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)
	end

	if self.metaBg then
		PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)
	end

	self.intensifyToggle:GetComponent("Toggle").onValueChanged:RemoveAllListeners()
	self.upgradeToggle:GetComponent("Toggle").onValueChanged:RemoveAllListeners()
	LeanTween.cancel(self.chat.gameObject)

	if self.paintingCode then
		for iter_108_0 = 1, #self.tablePainting do
			local var_108_0 = go(self.tablePainting[iter_108_0])

			if LeanTween.isTweening(var_108_0) then
				LeanTween.cancel(go(var_108_0))
			end
		end

		retPaintingPrefab(self.nowPainting, self.paintingCode)
	end

	self.shipDetailView:Destroy()
	self.shipFashionView:Destroy()
	self.shipEquipView:Destroy()
	self.shipHuntingRangeView:Destroy()
	self.shipCustomMsgBox:Destroy()
	self.shipChangeNameView:Destroy()
	clearImageSprite(self.background)

	if self.energyTimer then
		self.energyTimer:Stop()

		self.energyTimer = nil
	end

	if self.chatTimer then
		self.chatTimer:Stop()

		self.chatTimer = nil
	end

	self:StopPreVoice()
	cameraPaintViewAdjust(false)

	if self.tweens then
		cancelTweens(self.tweens)
	end

	self:UnOverlayPanel(self.blurPanel, self._tf)

	self.shareData = nil

	return
end

function ShipMainScene:RefreshShipExpItemUsagePage()
	if self.expItemUsagePage and self.expItemUsagePage:GetLoaded() and self.expItemUsagePage:isShowing() then
		self.expItemUsagePage:Flush(self.shipVO)
	end

	return
end

function ShipMainScene:OnWillLogout()
	if self.inPaintingView then
		self:hidePaintView(true)
	end

	return
end

function ShipMainScene:checkPaintingRes(arg_111_1)
	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = PaintingGroupConst.GetPaintingNameListByShipVO(self.shipVO),
		finishFunc = arg_111_1
	})

	return
end

return ShipMainScene
