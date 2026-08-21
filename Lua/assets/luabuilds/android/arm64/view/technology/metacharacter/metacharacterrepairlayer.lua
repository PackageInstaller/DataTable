local var_0_0 = class("MetaCharacterRepairLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MetaCharacterRepairUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initTipText()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	for iter_2_0, iter_2_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		local var_2_0 = arg_2_0.curMetaCharacterVO:getAttrVO(iter_2_1)

		if not var_2_0:isLock() then
			triggerToggle(arg_2_0.attrTFList[iter_2_1], true)

			break
		end
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:doRepairProgressPanelAni()
	arg_3_0:updateAttrListPanel()
	arg_3_0:updateRepairBtn()
	arg_3_0:updateDetailPanel()
	arg_3_0:TryPlayGuide()

	return
end

function var_0_0.willExit(arg_4_0)
	return
end

function var_0_0.onBackPressed(arg_5_0)
	if isActive(arg_5_0.repairEffectBoxPanel) then
		arg_5_0:closeRepairEffectBoxPanel()

		return
	elseif isActive(arg_5_0.detailPanel) then
		arg_5_0:closeDetailPanel()

		return
	else
		arg_5_0:emit(var_0_0.ON_BACK_PRESSED)
	end

	return
end

function var_0_0.initTipText(arg_6_0)
	setText(arg_6_0._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemCannon/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))
	setText(arg_6_0._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemTorpedo/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))
	setText(arg_6_0._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemAir/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))
	setText(arg_6_0._tf:Find("Repair/AttrListPanel/AttrItemContainer/AttrItemReload/SelectedPanel/AttrRepairTipText"), i18n("meta_repair"))

	return
end

function var_0_0.initData(arg_7_0)
	arg_7_0.metaCharacterProxy = getProxy(MetaCharacterProxy)
	arg_7_0.bayProxy = getProxy(BayProxy)
	arg_7_0.attrTFList = {}
	arg_7_0.curAttrName = nil
	arg_7_0.curMetaShipID = arg_7_0.contextData.shipID
	arg_7_0.curShipVO = nil
	arg_7_0.curMetaCharacterVO = nil

	arg_7_0:updateData()

	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.repairPanel = arg_8_0._tf:Find("Repair")
	arg_8_0.attrListPanel = arg_8_0.repairPanel:Find("AttrListPanel")
	arg_8_0.attrItemContainer = arg_8_0.attrListPanel:Find("AttrItemContainer")
	arg_8_0.attrCannonTF = arg_8_0.attrItemContainer:Find("AttrItemCannon")
	arg_8_0.attrTorpedoTF = arg_8_0.attrItemContainer:Find("AttrItemTorpedo")
	arg_8_0.attrAirTF = arg_8_0.attrItemContainer:Find("AttrItemAir")
	arg_8_0.attrReloadTF = arg_8_0.attrItemContainer:Find("AttrItemReload")
	arg_8_0.attrTFList.cannon = arg_8_0.attrCannonTF
	arg_8_0.attrTFList.torpedo = arg_8_0.attrTorpedoTF
	arg_8_0.attrTFList.air = arg_8_0.attrAirTF
	arg_8_0.attrTFList.reload = arg_8_0.attrReloadTF
	arg_8_0.repairPercentText = arg_8_0.repairPanel:Find("SynProgressPanel/SynRate/NumTextText")
	arg_8_0.repairSliderTF = arg_8_0.repairPanel:Find("SynProgressPanel/Slider")
	arg_8_0.repairBtn = arg_8_0.repairPanel:Find("RepairBtn")
	arg_8_0.repairBtnDisable = arg_8_0.repairPanel:Find("RepairBtnDisable")
	arg_8_0.showDetailLine = arg_8_0._tf:Find("ShowDetailLine")
	arg_8_0.showDetailBtn = arg_8_0.showDetailLine:Find("ShowDetailBtn")
	arg_8_0.detailPanel = arg_8_0._tf:Find("Detail")
	arg_8_0.detailBG = arg_8_0.detailPanel:Find("BG")
	arg_8_0.detailTF = arg_8_0.detailPanel:Find("Panel")
	arg_8_0.detailCloseBtn = arg_8_0.detailTF:Find("CloseBtn")
	arg_8_0.detailLineTpl = arg_8_0.detailTF:Find("DetailLineTpl")
	arg_8_0.detailItemTpl = arg_8_0.detailTF:Find("DetailItemTpl")
	arg_8_0.detailItemContainer = arg_8_0.detailTF:Find("ScrollView/Viewport/Content")
	arg_8_0.repairEffectBoxPanel = arg_8_0._tf:Find("RepairEffectBox")

	return
end

function var_0_0.addListener(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.attrTFList) do
		onToggle(arg_9_0, iter_9_1, function(arg_10_0)
			if arg_10_0 == true then
				arg_9_0.curAttrName = iter_9_0

				arg_9_0:updateRepairBtn()
			else
				arg_9_0.curAttrName = nil

				arg_9_0:updateRepairBtn(true)
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_9_0, arg_9_0.repairBtn, function()
		pg.m02:sendNotification(GAME.REPAIR_META_CHARACTER, {
			shipID = arg_9_0.curMetaShipID,
			attr = arg_9_0.curAttrName
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.showDetailBtn, function()
		if not isActive(arg_9_0.detailPanel) then
			arg_9_0:openDetailPanel()
		end

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.showDetailLine, function()
		if not isActive(arg_9_0.detailPanel) then
			arg_9_0:openDetailPanel()
		end

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.detailCloseBtn, function()
		arg_9_0:closeDetailPanel()

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.detailBG, function()
		arg_9_0:closeDetailPanel()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.TryPlayGuide(arg_16_0)
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0027")

	return
end

function var_0_0.doRepairProgressPanelAni(arg_17_0)
	local var_17_0 = arg_17_0.curMetaCharacterVO:getRepairRate()
	local var_17_1 = GetComponent(arg_17_0.repairSliderTF, typeof(Slider))

	var_17_1.minValue = 0
	var_17_1.maxValue = 1

	if var_17_0 > 0 then
		arg_17_0:managedTween(LeanTween.value, nil, go(arg_17_0.repairSliderTF), var_17_1.value, var_17_0, 0.5):setOnUpdate(System.Action_float(function(arg_18_0)
			arg_17_0:updateRepairProgressPanel(arg_18_0)

			return
		end)):setOnComplete(System.Action(function()
			arg_17_0:updateRepairProgressPanel(var_17_0)

			return
		end))
	else
		arg_17_0:updateRepairProgressPanel(var_17_0)
	end

	return
end

function var_0_0.updateRepairProgressPanel(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 or arg_20_0.curMetaCharacterVO:getRepairRate()

	setSlider(arg_20_0.repairSliderTF, 0, 1, var_20_0)
	setText(arg_20_0.repairPercentText, string.format("%d", var_20_0 * 100))

	return
end

function var_0_0.updateAttrListPanel(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		arg_21_0:updateAttrItem(arg_21_0.attrTFList[iter_21_1], iter_21_1)
	end

	return
end

function var_0_0.updateAttrItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:Find("LockPanel")
	local var_22_1 = arg_22_1:Find("UnSelectPanel")
	local var_22_2 = arg_22_1:Find("SelectedPanel")

	GetComponent(var_22_2:Find("TitleImg"), "Image"):SetNativeSize()

	local var_22_3 = arg_22_0.curMetaCharacterVO:getAttrVO(arg_22_2)

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
		updateDrop(var_22_7, {
			type = DROP_TYPE_ITEM,
			id = var_22_13,
			count = var_22_14
		}, {
			hideName = true
		})
		onButton(arg_22_0, var_22_7, function()
			arg_22_0:emit(BaseUI.ON_DROP, var_0)

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

function var_0_0.updateRepairBtn(arg_24_0, arg_24_1)
	if arg_24_1 == true then
		setActive(arg_24_0.repairBtn, false)
		setActive(arg_24_0.repairBtnDisable, false)

		return
	end

	local var_24_0 = arg_24_0.curMetaCharacterVO:getAttrVO(arg_24_0.curAttrName)
	local var_24_1 = var_24_0:isMaxLevel()
	local var_24_2 = not var_24_1 and var_24_0:getItem() or var_24_0:getItemByLevel(var_24_0:getLevel() - 1)
	local var_24_3 = var_24_2:getTotalCnt() <= getProxy(BagProxy):getItemCountById((var_24_2:getItemId()))

	if var_24_1 then
		setActive(arg_24_0.repairBtn, false)
		setActive(arg_24_0.repairBtnDisable, false)
	elseif not var_24_3 then
		setActive(arg_24_0.repairBtn, false)
		setActive(arg_24_0.repairBtnDisable, true)
	else
		setActive(arg_24_0.repairBtn, true)
		setActive(arg_24_0.repairBtnDisable, false)
	end

	return
end

function var_0_0.updateDetailItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("LineContainer")
	local var_25_1 = arg_25_1:Find("LockPanel")
	local var_25_2 = arg_25_2.progress

	setText(var_25_1:Find("TipText"), i18n("meta_repair_effect_unlock", arg_25_2.progress))
	setActive(var_25_1, not (var_25_2 <= arg_25_0.curMetaCharacterVO:getRepairRate() * 100))

	local var_25_3 = UIItemList.New(var_25_0, arg_25_0.detailLineTpl)

	var_25_3:make(function(arg_26_0, arg_26_1, arg_26_2)
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

			if arg_26_1 <= var_0 + 1 then
				setActive(var_26_0, true)
				setActive(var_26_1, false)
				setImageSprite(var_26_0:Find("AttrIcon"), LoadSprite("attricon", var_0[arg_26_1 - 1][1]))
				setText(var_26_0:Find("AttrNameText"), AttributeType.Type2Name(var_0[arg_26_1 - 1][1]))
				setText(var_26_0:Find("NumText"), "+" .. var_0[arg_26_1 - 1][2])
			else
				setActive(var_26_0, false)
				setActive(var_26_1, true)
				setScrollText(var_26_1:Find("Text"), var_0[arg_26_1 - 1 - var_0])
			end
		end

		return
	end)
	var_25_3:align(#arg_25_2:getAttrAdditionList() + #arg_25_2:getDescs() + 1)

	return
end

function var_0_0.updateDetailPanel(arg_27_0)
	setActive(arg_27_0.detailPanel, false)

	local var_27_0 = arg_27_0.curMetaCharacterVO:getEffects()

	arg_27_0.detailList = UIItemList.New(arg_27_0.detailItemContainer, arg_27_0.detailItemTpl)

	arg_27_0.detailList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			arg_27_0:updateDetailItem(arg_28_2, var_27_0[arg_28_1 + 1])
		end

		return
	end)
	arg_27_0.detailList:align(#arg_27_0.curMetaCharacterVO:getEffects())

	return
end

function var_0_0.updateData(arg_29_0)
	arg_29_0.curShipVO = arg_29_0.bayProxy:getShipById(arg_29_0.curMetaShipID)
	arg_29_0.curMetaCharacterVO = arg_29_0.curShipVO:getMetaCharacter()

	return
end

function var_0_0.checkSpecialEffect(arg_30_0)
	local var_30_0 = arg_30_0.bayProxy:getShipById(arg_30_0.curMetaShipID):getMetaCharacter()
	local var_30_1 = var_30_0:getRepairRate() * 100
	local var_30_2 = arg_30_0.curMetaCharacterVO:getRepairRate() * 100

	for iter_30_0, iter_30_1 in ipairs((var_30_0:getEffects())) do
		if var_30_2 < iter_30_1.progress and iter_30_1.progress <= var_30_1 then
			arg_30_0:openRepairEffectBoxPanel(iter_30_1)

			break
		end
	end

	return
end

function var_0_0.openRepairEffectBoxPanel(arg_31_0, arg_31_1)
	local var_31_0 = 1 + #arg_31_1:getAttrAdditionList() + #arg_31_1:getDescs()
	local var_31_1 = arg_31_1.progress
	local var_31_2 = arg_31_0.repairEffectBoxPanel:Find("BG")

	onButton(arg_31_0, arg_31_0.repairEffectBoxPanel:Find("Box/BtnContainer/ConfirmBtn"), function()
		arg_31_0:closeRepairEffectBoxPanel()

		return
	end, SFX_CANCEL)

	local var_31_3 = arg_31_0.repairEffectBoxPanel:Find("Box/Panel/TypeRepairEffect")
	local var_31_4 = UIItemList.New(var_31_3, (var_31_3:Find("DetailLineTpl")))

	var_31_4:make(function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = arg_33_2:Find("AttrLine")
		local var_33_1 = arg_33_2:Find("UnlockTipLine")

		if arg_33_0 == UIItemList.EventUpdate then
			arg_33_1 = arg_33_1 + 1

			if arg_33_1 == 1 then
				setActive(var_33_0, false)
				setActive(var_33_1, true)
				setScrollText(var_33_1:Find("Text"), i18n("meta_repair_effect_special", var_31_1))
			elseif arg_33_1 > 1 and arg_33_1 <= 1 + var_0 then
				setActive(var_33_0, true)
				setActive(var_33_1, false)
				setImageSprite(var_33_0:Find("AttrIcon"), LoadSprite("attricon", var_0[arg_33_1 - 1][1]))
				setText(var_33_0:Find("AttrNameText"), AttributeType.Type2Name(var_0[arg_33_1 - 1][1]))
				setText(var_33_0:Find("NumText"), "+" .. var_0[arg_33_1 - 1][2])
			elseif arg_33_1 > 1 + var_0 and arg_33_1 <= var_31_0 then
				setActive(var_33_0, false)
				setActive(var_33_1, true)
				setScrollText(var_33_1:Find("Text"), var_0[arg_33_1 - (1 + var_0)])
			end
		end

		return
	end)
	var_31_4:align(1 + #arg_31_1:getAttrAdditionList() + #arg_31_1:getDescs())
	setActive(arg_31_0.repairEffectBoxPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_31_0.repairEffectBoxPanel)

	return
end

function var_0_0.closeRepairEffectBoxPanel(arg_34_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_34_0.repairEffectBoxPanel)
	setActive(arg_34_0.repairEffectBoxPanel, false)

	return
end

function var_0_0.openDetailPanel(arg_35_0)
	setActive(arg_35_0.detailPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_35_0.detailPanel)

	arg_35_0.isOpening = true

	arg_35_0:managedTween(LeanTween.value, nil, go(arg_35_0.detailTF), arg_35_0.detailTF.rect.width, 0, 0.3):setOnUpdate(System.Action_float(function(arg_36_0)
		setAnchoredPosition(arg_35_0.detailTF, {
			x = arg_36_0
		})

		return
	end)):setOnComplete(System.Action(function()
		arg_35_0.isOpening = nil

		return
	end))

	return
end

function var_0_0.closeDetailPanel(arg_38_0)
	if arg_38_0.isClosing or arg_38_0.isOpening then
		return
	end

	arg_38_0.isClosing = true

	arg_38_0:managedTween(LeanTween.value, nil, go(arg_38_0.detailTF), 0, arg_38_0.detailTF.rect.width, 0.3):setOnUpdate(System.Action_float(function(arg_39_0)
		setAnchoredPosition(arg_38_0.detailTF, {
			x = arg_39_0
		})

		return
	end)):setOnComplete(System.Action(function()
		arg_38_0.isClosing = nil

		setActive(arg_38_0.detailPanel, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_38_0.detailPanel)

		return
	end))

	return
end

return var_0_0
