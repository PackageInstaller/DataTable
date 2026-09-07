local MetaCharacterRepairLayer = class("MetaCharacterRepairLayer", import("...base.BaseUI"))

function MetaCharacterRepairLayer:getUIName()
	return "MetaCharacterRepairUI"
end

function MetaCharacterRepairLayer:init()
	self:initTipText()
	self:initData()
	self:findUI()
	self:addListener()

	for iter_2_0, iter_2_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		if not self.curMetaCharacterVO:getAttrVO(iter_2_1):isLock() then
			triggerToggle(self.attrTFList[iter_2_1], true)

			break
		end
	end

	return
end

function MetaCharacterRepairLayer:didEnter()
	self:doRepairProgressPanelAni()
	self:updateAttrListPanel()
	self:updateRepairBtn()
	self:updateDetailPanel()
	self:TryPlayGuide()

	return
end

function MetaCharacterRepairLayer:willExit()
	return
end

function MetaCharacterRepairLayer:onBackPressed()
	if isActive(self.repairEffectBoxPanel) then
		self:closeRepairEffectBoxPanel()

		return
	elseif isActive(self.detailPanel) then
		self:closeDetailPanel()

		return
	else
		self:emit(MetaCharacterRepairLayer.ON_BACK_PRESSED)
	end

	return
end

function MetaCharacterRepairLayer:initTipText()
	setText(self._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemCannon/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))
	setText(self._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemTorpedo/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))
	setText(self._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemAir/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))
	setText(self._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemReload/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))

	return
end

function MetaCharacterRepairLayer:initData()
	self.metaCharacterProxy = getProxy(MetaCharacterProxy)
	self.bayProxy = getProxy(BayProxy)
	self.attrTFList = {}
	self.curAttrName = nil
	self.curMetaShipID = self.contextData.shipID
	self.curShipVO = nil
	self.curMetaCharacterVO = nil

	self:updateData()

	return
end

function MetaCharacterRepairLayer:findUI()
	self.repairPanel = self._tf:Find("Repair")
	self.attrListPanel = self.repairPanel:Find("AttrListPanel")
	self.attrItemContainer = self.attrListPanel:Find("AttrItemContainer")
	self.attrCannonTF = self.attrItemContainer:Find("AttrItemCannon")
	self.attrTorpedoTF = self.attrItemContainer:Find("AttrItemTorpedo")
	self.attrAirTF = self.attrItemContainer:Find("AttrItemAir")
	self.attrReloadTF = self.attrItemContainer:Find("AttrItemReload")
	self.attrTFList.cannon = self.attrCannonTF
	self.attrTFList.torpedo = self.attrTorpedoTF
	self.attrTFList.air = self.attrAirTF
	self.attrTFList.reload = self.attrReloadTF
	self.repairPercentText = self.repairPanel:Find("SynProgressPanel/SynRate/NumTextText")
	self.repairSliderTF = self.repairPanel:Find("SynProgressPanel/Slider")
	self.repairBtn = self.repairPanel:Find("RepairBtn")
	self.repairBtnDisable = self.repairPanel:Find("RepairBtnDisable")
	self.showDetailLine = self._tf:Find("ShowDetailLine")
	self.showDetailBtn = self.showDetailLine:Find("ShowDetailBtn")
	self.detailPanel = self._tf:Find("Detail")
	self.detailBG = self.detailPanel:Find("BG")
	self.detailTF = self.detailPanel:Find("Panel")
	self.detailCloseBtn = self.detailTF:Find("CloseBtn")
	self.detailLineTpl = self.detailTF:Find("DetailLineTpl")
	self.detailItemTpl = self.detailTF:Find("DetailItemTpl")
	self.detailItemContainer = self.detailTF:Find("ScrollView/Viewport/Content")
	self.repairEffectBoxPanel = self._tf:Find("RepairEffectBox")

	return
end

function MetaCharacterRepairLayer:addListener()
	for iter_9_0, iter_9_1 in pairs(self.attrTFList) do
		onToggle(self, iter_9_1, function(arg_10_0)
			if arg_10_0 == true then
				self.curAttrName = iter_9_0

				self:updateRepairBtn()
			else
				self.curAttrName = nil

				self:updateRepairBtn(true)
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.repairBtn, function()
		pg.m02:sendNotification(GAME.REPAIR_META_CHARACTER, {
			shipID = self.curMetaShipID,
			attr = self.curAttrName
		})

		return
	end, SFX_PANEL)
	onButton(self, self.showDetailBtn, function()
		if not isActive(self.detailPanel) then
			self:openDetailPanel()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.showDetailLine, function()
		if not isActive(self.detailPanel) then
			self:openDetailPanel()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.detailCloseBtn, function()
		self:closeDetailPanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.detailBG, function()
		self:closeDetailPanel()

		return
	end, SFX_CANCEL)

	return
end

function MetaCharacterRepairLayer:TryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0027")

	return
end

function MetaCharacterRepairLayer:doRepairProgressPanelAni()
	local var_17_0 = self.curMetaCharacterVO:getRepairRate()
	local var_17_1 = GetComponent(self.repairSliderTF, typeof(Slider))

	var_17_1.minValue = 0
	var_17_1.maxValue = 1

	if var_17_0 > 0 then
		self:managedTween(LeanTween.value, nil, go(self.repairSliderTF), var_17_1.value, var_17_0, 0.5):setOnUpdate(System.Action_float(function(arg_18_0)
			self:updateRepairProgressPanel(arg_18_0)

			return
		end)):setOnComplete(System.Action(function()
			self:updateRepairProgressPanel(var_17_0)

			return
		end))
	else
		self:updateRepairProgressPanel(var_17_0)
	end

	return
end

function MetaCharacterRepairLayer:updateRepairProgressPanel(arg_20_1)
	local var_20_0 = arg_20_1 or self.curMetaCharacterVO:getRepairRate()

	setSlider(self.repairSliderTF, 0, 1, var_20_0)
	setText(self.repairPercentText, string.format("%d", var_20_0 * 100))

	return
end

function MetaCharacterRepairLayer:updateAttrListPanel()
	for iter_21_0, iter_21_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		self:updateAttrItem(self.attrTFList[iter_21_1], iter_21_1)
	end

	return
end

function MetaCharacterRepairLayer:updateAttrItem(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:Find("LockPanel")
	local var_22_1 = arg_22_1:Find("UnSelectPanel")
	local var_22_2 = arg_22_1:Find("SelectedPanel")

	GetComponent(var_22_2:Find("TitleImg"), "Image"):SetNativeSize()

	local var_22_3 = self.curMetaCharacterVO:getAttrVO(arg_22_2)

	if var_22_3:isLock() then
		setActive(var_22_1, false)
		setActive(var_22_2, false)
		setActive(var_22_0, true)

		arg_22_1:GetComponent("Toggle").interactable = false
	else
		local var_22_4 = arg_22_1:GetComponent("Toggle")

		setActive(var_22_1, not var_22_4.isOn)
		setActive(var_22_2, var_22_4.isOn)
		setActive(var_22_0, false)

		var_22_4.interactable = true

		local var_22_5 = var_22_2:Find("AttrRepairValue/Image")
		local var_22_6 = var_22_2:Find("AttrRepairValue/NextValueText")
		local var_22_7 = var_22_2:Find("IconTpl")
		local var_22_8 = var_22_2:Find("ItemCount")
		local var_22_9 = var_22_8:Find("NumText")
		local var_22_10 = var_22_3:getAddition()

		setText(var_22_1:Find("ValueText"), "+" .. var_22_10)
		setText(var_22_2:Find("ValueText"), "+" .. var_22_10)
		setText(var_22_2:Find("AttrRepairValue/CurValueText"), "+" .. var_22_10)

		local var_22_11 = var_22_3:isMaxLevel()
		local var_22_12 = not var_22_11 and var_22_3:getItem() or var_22_3:getItemByLevel(var_22_3:getLevel() - 1)
		local var_22_13 = var_22_12:getItemId()
		local var_22_14 = var_22_12:getTotalCnt()
		local var_22_15 = getProxy(BagProxy):getItemCountById(var_22_13)

		if var_22_15 < var_22_14 then
			var_22_15 = setColorStr(var_22_15, COLOR_RED)
		end

		setText(var_22_9, var_22_15 .. "/" .. var_22_14)

		local var_22_16 = {
			type = DROP_TYPE_ITEM,
			id = var_22_13,
			count = var_22_14
		}

		updateDrop(var_22_7, var_22_16, {
			hideName = true
		})
		onButton(self, var_22_7, function()
			self:emit(BaseUI.ON_DROP, var_22_16)

			return
		end, SFX_PANEL)
		setActive(var_22_5, not var_22_11)
		setActive(var_22_6, not var_22_11)

		if var_22_11 then
			setText(var_22_6, var_22_10)
		else
			setText(var_22_6, "+" .. var_22_10 + var_22_12:getAdditionValue())
		end

		if var_22_11 then
			setActive(var_22_7, false)
			setActive(var_22_8, false)
		else
			setActive(var_22_7, true)
			setActive(var_22_8, true)
		end
	end

	return
end

function MetaCharacterRepairLayer:updateRepairBtn(arg_24_1)
	if arg_24_1 == true then
		setActive(self.repairBtn, false)
		setActive(self.repairBtnDisable, false)

		return
	end

	local var_24_0 = self.curMetaCharacterVO:getAttrVO(self.curAttrName)
	local var_24_1 = var_24_0:isMaxLevel()
	local var_24_2 = not var_24_1 and var_24_0:getItem() or var_24_0:getItemByLevel(var_24_0:getLevel() - 1)
	local var_24_3 = var_24_2:getTotalCnt() <= getProxy(BagProxy):getItemCountById((var_24_2:getItemId()))

	if var_24_1 then
		setActive(self.repairBtn, false)
		setActive(self.repairBtnDisable, false)
	elseif not var_24_3 then
		setActive(self.repairBtn, false)
		setActive(self.repairBtnDisable, true)
	else
		setActive(self.repairBtn, true)
		setActive(self.repairBtnDisable, false)
	end

	return
end

function MetaCharacterRepairLayer:updateDetailItem(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("LineContainer")
	local var_25_1 = arg_25_1:Find("LockPanel")
	local var_25_2 = arg_25_2.progress

	setText(var_25_1:Find("TipText"), i18n("meta_repair_effect_unlock", arg_25_2.progress))
	setActive(var_25_1, not (var_25_2 <= self.curMetaCharacterVO:getRepairRate() * 100))

	local var_25_3 = arg_25_2:getAttrAdditionList()
	local var_25_4 = #var_25_3
	local var_25_5 = arg_25_2:getDescs()
	local var_25_6 = UIItemList.New(var_25_0, self.detailLineTpl)

	var_25_6:make(function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_2:Find("AttrLine")
		local var_26_1 = arg_26_2:Find("UnlockTipLine")
		local var_26_2 = arg_26_2:Find("Text")

		if arg_26_0 == UIItemList.EventUpdate then
			arg_26_1 = arg_26_1 + 1

			if arg_26_1 == 1 then
				setActive(var_26_0, false)
				setActive(var_26_1, false)
				setActive(var_26_2, true)
				setText(var_26_2, i18n("meta_repair_effect_unlock", var_25_2))

				return
			end

			if arg_26_1 <= var_25_4 + 1 then
				setActive(var_26_0, true)
				setActive(var_26_1, false)
				setImageSprite(var_26_0:Find("AttrIcon"), LoadSprite("attricon", var_25_3[arg_26_1 - 1][1]))
				setText(var_26_0:Find("AttrNameText"), AttributeType.Type2Name(var_25_3[arg_26_1 - 1][1]))
				setText(var_26_0:Find("NumText"), "+" .. var_25_3[arg_26_1 - 1][2])
			else
				setActive(var_26_0, false)
				setActive(var_26_1, true)
				setScrollText(var_26_1:Find("Text"), var_25_5[arg_26_1 - 1 - var_25_4])
			end
		end

		return
	end)
	var_25_6:align(#var_25_3 + #var_25_5 + 1)

	return
end

function MetaCharacterRepairLayer:updateDetailPanel()
	setActive(self.detailPanel, false)

	local var_27_0 = self.curMetaCharacterVO:getEffects()

	self.detailList = UIItemList.New(self.detailItemContainer, self.detailItemTpl)

	self.detailList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			self:updateDetailItem(arg_28_2, var_27_0[arg_28_1 + 1])
		end

		return
	end)
	self.detailList:align(#var_27_0)

	return
end

function MetaCharacterRepairLayer:updateData()
	self.curShipVO = self.bayProxy:getShipById(self.curMetaShipID)
	self.curMetaCharacterVO = self.curShipVO:getMetaCharacter()

	return
end

function MetaCharacterRepairLayer:checkSpecialEffect()
	local var_30_0 = self.bayProxy:getShipById(self.curMetaShipID):getMetaCharacter()
	local var_30_1 = var_30_0:getRepairRate() * 100
	local var_30_2 = self.curMetaCharacterVO:getRepairRate() * 100

	for iter_30_0, iter_30_1 in ipairs((var_30_0:getEffects())) do
		if var_30_2 < iter_30_1.progress and iter_30_1.progress <= var_30_1 then
			self:openRepairEffectBoxPanel(iter_30_1)

			break
		end
	end

	return
end

function MetaCharacterRepairLayer:openRepairEffectBoxPanel(arg_31_1)
	local var_31_0 = arg_31_1:getAttrAdditionList()
	local var_31_1 = #var_31_0
	local var_31_2 = arg_31_1:getDescs()
	local var_31_3 = 1 + #var_31_0 + #var_31_2
	local var_31_4 = arg_31_1.progress
	local var_31_5 = self.repairEffectBoxPanel:Find("BG")

	onButton(self, self.repairEffectBoxPanel:Find("Box/BtnContainer/ConfirmBtn"), function()
		self:closeRepairEffectBoxPanel()

		return
	end, SFX_CANCEL)

	local var_31_6 = self.repairEffectBoxPanel:Find("Box/Panel/TypeRepairEffect")
	local var_31_7 = UIItemList.New(var_31_6, (var_31_6:Find("DetailLineTpl")))

	var_31_7:make(function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = arg_33_2:Find("AttrLine")
		local var_33_1 = arg_33_2:Find("UnlockTipLine")

		if arg_33_0 == UIItemList.EventUpdate then
			arg_33_1 = arg_33_1 + 1

			if arg_33_1 == 1 then
				setActive(var_33_0, false)
				setActive(var_33_1, true)
				setScrollText(var_33_1:Find("Text"), i18n("meta_repair_effect_special", var_31_4))
			elseif arg_33_1 > 1 and arg_33_1 <= 1 + var_31_1 then
				setActive(var_33_0, true)
				setActive(var_33_1, false)
				setImageSprite(var_33_0:Find("AttrIcon"), LoadSprite("attricon", var_31_0[arg_33_1 - 1][1]))
				setText(var_33_0:Find("AttrNameText"), AttributeType.Type2Name(var_31_0[arg_33_1 - 1][1]))
				setText(var_33_0:Find("NumText"), "+" .. var_31_0[arg_33_1 - 1][2])
			elseif arg_33_1 > 1 + var_31_1 and arg_33_1 <= var_31_3 then
				setActive(var_33_0, false)
				setActive(var_33_1, true)
				setScrollText(var_33_1:Find("Text"), var_31_2[arg_33_1 - (1 + var_31_1)])
			end
		end

		return
	end)
	var_31_7:align(1 + #var_31_0 + #var_31_2)
	setActive(self.repairEffectBoxPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(self.repairEffectBoxPanel)

	return
end

function MetaCharacterRepairLayer:closeRepairEffectBoxPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.repairEffectBoxPanel)
	setActive(self.repairEffectBoxPanel, false)

	return
end

function MetaCharacterRepairLayer:openDetailPanel()
	setActive(self.detailPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(self.detailPanel)

	self.isOpening = true

	self:managedTween(LeanTween.value, nil, go(self.detailTF), self.detailTF.rect.width, 0, 0.3):setOnUpdate(System.Action_float(function(arg_36_0)
		setAnchoredPosition(self.detailTF, {
			x = arg_36_0
		})

		return
	end)):setOnComplete(System.Action(function()
		self.isOpening = nil

		return
	end))

	return
end

function MetaCharacterRepairLayer:closeDetailPanel()
	if self.isClosing or self.isOpening then
		return
	end

	self.isClosing = true

	self:managedTween(LeanTween.value, nil, go(self.detailTF), 0, self.detailTF.rect.width, 0.3):setOnUpdate(System.Action_float(function(arg_39_0)
		setAnchoredPosition(self.detailTF, {
			x = arg_39_0
		})

		return
	end)):setOnComplete(System.Action(function()
		self.isClosing = nil

		setActive(self.detailPanel, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.detailPanel)

		return
	end))

	return
end

return MetaCharacterRepairLayer
