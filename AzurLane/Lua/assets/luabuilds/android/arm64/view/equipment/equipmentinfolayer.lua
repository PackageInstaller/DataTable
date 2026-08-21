local var_0_0 = class("EquipmentInfoLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EquipmentInfoUI"
end

var_0_0.PANEL_DESTROY = "Destroy"
var_0_0.PANEL_REVERT = "Revert"
var_0_0.Left = 1
var_0_0.Middle = 2
var_0_0.Right = 3
var_0_0.pos = {
	{
		-353,
		30,
		0
	},
	{
		0,
		30,
		0
	},
	{
		353,
		30,
		0
	}
}

function var_0_0.init(arg_2_0)
	arg_2_0.toggles = {}

	for iter_2_0, iter_2_1 in ipairs({
		"default",
		"replace",
		"display",
		"destroy",
		"revert"
	}) do
		arg_2_0[iter_2_1 .. "Panel"] = arg_2_0._tf:Find(iter_2_1)
		arg_2_0.toggles[iter_2_1 .. "Panel"] = arg_2_0._tf:Find("toggle_controll/" .. iter_2_1)
	end

	arg_2_0.sample = arg_2_0._tf:Find("sample")

	setActive(arg_2_0.sample, false)
	setActive(arg_2_0.defaultPanel:Find("transform_tip"), false)

	arg_2_0.txtQuickEnable = findTF(arg_2_0._tf, "txtQuickEnable")

	setText(arg_2_0.txtQuickEnable, i18n("ship_equip_check"))

	arg_2_0.equipDestroyConfirmWindow = EquipDestoryConfirmWindow.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.setEquipment(arg_3_0, arg_3_1)
	arg_3_0.equipmentVO = arg_3_1

	return
end

function var_0_0.setShip(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.shipVO = arg_4_1
	arg_4_0.oldShipVO = arg_4_2

	return
end

function var_0_0.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_0.checkOverGold(arg_6_0, arg_6_1)
	local var_6_0 = _.detect(arg_6_1, function(arg_7_0)
		return arg_7_0.type == DROP_TYPE_RESOURCE and arg_7_0.id == 1
	end).count or 0

	if arg_6_0.player:GoldMax(var_6_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_0.setDestroyCount(arg_8_0, arg_8_1)
	arg_8_1 = math.clamp(arg_8_1, 1, arg_8_0.equipmentVO.count)

	if arg_8_0.destroyCount ~= arg_8_1 then
		arg_8_0.destroyCount = arg_8_1

		arg_8_0:updateDestroyCount()
	end

	return
end

function var_0_0.didEnter(arg_9_0)
	local var_9_0 = arg_9_0.contextData.quickFlag or false

	setActive(arg_9_0.txtQuickEnable, var_9_0)

	local var_9_1 = defaultValue(arg_9_0.contextData.type, EquipmentInfoMediator.TYPE_DEFAULT)

	arg_9_0.isShowUnique = table.contains(EquipmentInfoMediator.SHOW_UNIQUE, var_9_1)

	onButton(arg_9_0, arg_9_0._tf:Find("bg"), function()
		if isActive(arg_9_0.destroyPanel) then
			triggerToggle(arg_9_0.toggles.defaultPanel, true)

			return
		end

		arg_9_0:closeView()

		return
	end, SOUND_BACK)
	arg_9_0:initAndSetBtn(var_9_1)

	if var_9_1 == EquipmentInfoMediator.TYPE_DEFAULT then
		arg_9_0:updateOperation1()
	elseif var_9_1 == EquipmentInfoMediator.TYPE_SHIP then
		arg_9_0:updateOperation2()
	elseif var_9_1 == EquipmentInfoMediator.TYPE_REPLACE then
		arg_9_0:updateOperation3()
	elseif var_9_1 == EquipmentInfoMediator.TYPE_DISPLAY then
		arg_9_0:updateOperation4()
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	return
end

function var_0_0.initAndSetBtn(arg_11_0, arg_11_1)
	if arg_11_1 == EquipmentInfoMediator.TYPE_DEFAULT or arg_11_1 == EquipmentInfoMediator.TYPE_SHIP then
		arg_11_0.defaultEquipTF = arg_11_0.defaultPanel:Find("equipment") or arg_11_0:cloneSampleTo(arg_11_0.defaultPanel, var_0_0.Middle, "equipment")
		arg_11_0.defaultReplaceBtn = arg_11_0.defaultPanel:Find("actions/action_button_3")
		arg_11_0.defaultDestroyBtn = arg_11_0.defaultPanel:Find("actions/action_button_1")
		arg_11_0.defaultEnhanceBtn = arg_11_0.defaultPanel:Find("actions/action_button_2")
		arg_11_0.defaultUnloadBtn = arg_11_0.defaultPanel:Find("actions/action_button_4")
		arg_11_0.defaultRevertBtn = arg_11_0.defaultEquipTF:Find("info/equip/revert_btn")
		arg_11_0.defaultTransformTipBar = arg_11_0.defaultEquipTF:Find("transform_tip")

		if arg_11_1 == EquipmentInfoMediator.TYPE_DEFAULT and not arg_11_0.defaultTransformTipBar then
			local var_11_0 = arg_11_0.defaultPanel:Find("transform_tip")

			setParent(var_11_0, arg_11_0.defaultEquipTF)

			var_11_0.sizeDelta.y = 0
			var_11_0.sizeDelta = var_11_0.sizeDelta

			setAnchoredPosition(var_11_0, Vector2.zero)

			arg_11_0.defaultTransformTipBar = var_11_0
		end

		onButton(arg_11_0, arg_11_0.defaultReplaceBtn, function()
			local var_12_0, var_12_1 = ShipStatus.ShipStatusCheck("onModify", arg_11_0.shipVO)

			if not var_12_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_12_1)

				return
			end

			arg_11_0:emit(EquipmentInfoMediator.ON_CHANGE)

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.defaultEnhanceBtn, function()
			if arg_11_0.shipVO then
				local var_13_0, var_13_1 = ShipStatus.ShipStatusCheck("onModify", arg_11_0.shipVO)

				if not var_13_0 then
					pg.TipsMgr.GetInstance():ShowTips(var_13_1)

					return
				end
			end

			arg_11_0:emit(EquipmentInfoMediator.ON_INTENSIFY)

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.defaultUnloadBtn, function()
			local var_14_0, var_14_1 = ShipStatus.ShipStatusCheck("onModify", arg_11_0.shipVO)

			if not var_14_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_14_1)

				return
			end

			arg_11_0:emit(EquipmentInfoMediator.ON_UNEQUIP)

			return
		end, SFX_UI_DOCKYARD_EQUIPOFF)
		onButton(arg_11_0, arg_11_0.defaultDestroyBtn, function()
			triggerToggle(arg_11_0.toggles.destroyPanel, true)

			if not arg_11_0.initDestroyPanel then
				arg_11_0:initAndSetBtn(var_0_0.PANEL_DESTROY)
			end

			arg_11_0:updateEquipmentPanel(arg_11_0.destroyEquipTF, arg_11_0.equipmentVO)

			if arg_11_0.equipmentVO.count > 0 then
				arg_11_0:setDestroyCount(1)
			end

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.defaultRevertBtn, function()
			triggerToggle(arg_11_0.toggles.revertPanel, true)

			if not arg_11_0.initRevertPanel then
				arg_11_0:initAndSetBtn(var_0_0.PANEL_REVERT)
			end

			arg_11_0:updateRevertPanel()

			return
		end, SFX_PANEL)
	elseif arg_11_1 == EquipmentInfoMediator.TYPE_REPLACE then
		arg_11_0.replaceSrcEquipTF = arg_11_0.replacePanel:Find("equipment") or arg_11_0:cloneSampleTo(arg_11_0.replacePanel, var_0_0.Left, "equipment")
		arg_11_0.replaceDstEquipTF = arg_11_0.replacePanel:Find("equipment_on_ship") or arg_11_0:cloneSampleTo(arg_11_0.replacePanel, var_0_0.Right, "equipment_on_ship")
		arg_11_0.replaceCancelBtn = arg_11_0.replacePanel:Find("actions/cancel_button")
		arg_11_0.replaceConfirmBtn = arg_11_0.replacePanel:Find("actions/action_button_2")

		onButton(arg_11_0, arg_11_0.replaceCancelBtn, function()
			if isActive(arg_11_0.destroyPanel) then
				triggerToggle(arg_11_0.toggles.defaultPanel, true)

				return
			end

			arg_11_0:closeView()

			return
		end, SFX_CANCEL)
		onButton(arg_11_0, arg_11_0.replaceConfirmBtn, function()
			local var_18_0, var_18_1 = arg_11_0.shipVO:canEquipAtPos(arg_11_0.equipmentVO, arg_11_0.contextData.pos)

			if not var_18_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_equipmentInfoLayer_error_canNotEquip", var_18_1))

				return
			end

			if arg_11_0.contextData.quickCallback then
				arg_11_0.contextData.quickCallback()
				arg_11_0:closeView()
			else
				arg_11_0:emit(EquipmentInfoMediator.ON_EQUIP)
			end

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	elseif arg_11_1 == EquipmentInfoMediator.TYPE_DISPLAY then
		arg_11_0.displayEquipTF = arg_11_0.displayPanel:Find("equipment") or arg_11_0:cloneSampleTo(arg_11_0.displayPanel, var_0_0.Middle, "equipment")
		arg_11_0.displayMoveBtn = arg_11_0.displayPanel:Find("actions/move_button")
		arg_11_0.defaultTransformTipBar = arg_11_0.displayEquipTF:Find("transform_tip")

		if arg_11_0.contextData.showTransformTip and not arg_11_0.defaultTransformTipBar then
			local var_11_1 = arg_11_0.defaultPanel:Find("transform_tip")

			setParent(var_11_1, arg_11_0.displayEquipTF)

			var_11_1.sizeDelta.y = 0
			var_11_1.sizeDelta = var_11_1.sizeDelta

			setAnchoredPosition(var_11_1, Vector2.zero)

			arg_11_0.defaultTransformTipBar = var_11_1
		end

		onButton(arg_11_0, arg_11_0.displayMoveBtn, function()
			arg_11_0:emit(EquipmentInfoMediator.ON_MOVE, arg_11_0.shipVO.id)

			return
		end)
	elseif arg_11_1 == var_0_0.PANEL_DESTROY then
		arg_11_0.initDestroyPanel = true
		arg_11_0.destroyEquipTF = arg_11_0.destroyPanel:Find("equipment") or arg_11_0:cloneSampleTo(arg_11_0.destroyPanel, var_0_0.Left, "equipment")
		arg_11_0.destroyCounter = arg_11_0.destroyPanel:Find("destroy")
		arg_11_0.destroyValue = arg_11_0.destroyCounter:Find("count/number_panel/value")
		arg_11_0.destroyLeftButton = arg_11_0.destroyCounter:Find("count/number_panel/left")
		arg_11_0.destroyRightButton = arg_11_0.destroyCounter:Find("count/number_panel/right")
		arg_11_0.destroyBonusList = arg_11_0.destroyCounter:Find("got/list")
		arg_11_0.destroyBonusItem = arg_11_0.destroyCounter:Find("got/item")
		arg_11_0.destroyCancelBtn = arg_11_0.destroyPanel:Find("actions/cancel_button")
		arg_11_0.destroyConfirmBtn = arg_11_0.destroyPanel:Find("actions/destroy_button")

		onButton(arg_11_0, arg_11_0.destroyLeftButton, function()
			arg_11_0:setDestroyCount(arg_11_0.destroyCount - 1)

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.destroyRightButton, function()
			arg_11_0:setDestroyCount(arg_11_0.destroyCount + 1)

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.destroyCounter:Find("count/max"), function()
			arg_11_0:setDestroyCount(arg_11_0.equipmentVO.count)

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.destroyCancelBtn, function()
			triggerToggle(arg_11_0.toggles.defaultPanel, true)

			return
		end, SFX_CANCEL)
		onButton(arg_11_0, arg_11_0.destroyConfirmBtn, function()
			if not arg_11_0:checkOverGold(arg_11_0.awards) then
				return
			end

			local var_24_0 = {}

			if arg_11_0.equipmentVO:isImportance() then
				table.insert(var_24_0, function(arg_25_0)
					arg_11_0.equipDestroyConfirmWindow:Load()
					arg_11_0.equipDestroyConfirmWindow:ActionInvoke("Show", {
						setmetatable({
							count = arg_11_0.destroyCount
						}, {
							__index = arg_11_0.equipmentVO
						})
					}, arg_25_0)

					return
				end)
			end

			seriesAsync(var_24_0, function()
				arg_11_0:emit(EquipmentInfoMediator.ON_DESTROY, arg_11_0.destroyCount)

				return
			end)

			return
		end, SFX_UI_EQUIPMENT_RESOLVE)
	elseif arg_11_1 == var_0_0.PANEL_REVERT then
		arg_11_0.initRevertPanel = true
		arg_11_0.revertEquipTF = arg_11_0.revertPanel:Find("equipment") or arg_11_0:cloneSampleTo(arg_11_0.revertPanel, var_0_0.Left, "equipment")
		arg_11_0.revertAwardContainer = arg_11_0.revertPanel:Find("item_panel/got/list")
		arg_11_0.revertCancelBtn = arg_11_0.revertPanel:Find("actions/cancel_button")
		arg_11_0.revertConfirmBtn = arg_11_0.revertPanel:Find("actions/revert_button")
		arg_11_0.itemTpl = arg_11_0:getTpl("item_panel/got/item", arg_11_0.revertPanel)

		onButton(arg_11_0, arg_11_0.revertCancelBtn, function()
			triggerToggle(arg_11_0.toggles.defaultPanel, true)

			return
		end, SFX_CANCEL)
		onButton(arg_11_0, arg_11_0.revertConfirmBtn, function()
			if not arg_11_0:checkOverGold(arg_11_0.awards) then
				return
			end

			arg_11_0:emit(EquipmentInfoMediator.ON_REVERT, arg_11_0.equipmentVO.id)

			return
		end, SFX_UI_EQUIPMENT_RESOLVE)
	end

	return
end

function var_0_0.updateOperation1(arg_29_0)
	triggerToggle(arg_29_0.toggles.defaultPanel, true)
	arg_29_0:updateEquipmentPanel(arg_29_0.defaultEquipTF, arg_29_0.equipmentVO)

	local var_29_1 = arg_29_0.defaultRevertBtn

	if not LOCK_EQUIP_REVERT then
		local var_29_2 = arg_29_0.fromEquipmentView

		if arg_29_0.fromEquipmentView then
			if arg_29_0.equipmentVO:getConfig("level") > 1 then
				var_29_2 = getProxy(BagProxy):getItemCountById(Item.REVERT_EQUIPMENT_ID) > 0

				var_29_0(var_29_1, var_29_2)
				setActive(arg_29_0.defaultReplaceBtn, false)
				setActive(arg_29_0.defaultUnloadBtn, false)

				local var_29_3 = arg_29_0.contextData.destroy and arg_29_0.equipmentVO.count > 0

				setActive(arg_29_0.defaultDestroyBtn, var_29_3)
				arg_29_0:UpdateTransformTipBar(arg_29_0.equipmentVO)

				return
			end
		end
	end
end

function var_0_0.updateOperation2(arg_30_0)
	triggerToggle(arg_30_0.toggles.defaultPanel, true)
	arg_30_0:updateEquipmentPanel(arg_30_0.defaultEquipTF, arg_30_0.shipVO:getEquip(arg_30_0.contextData.pos))
	setActive(arg_30_0.defaultDestroyBtn, false)
	setActive(arg_30_0.defaultReplaceBtn, true)
	setActive(arg_30_0.defaultUnloadBtn, true)
	setActive(arg_30_0.defaultRevertBtn, false)

	local var_30_0 = arg_30_0.defaultEquipTF:Find("head")

	setActive(var_30_0, arg_30_0.shipVO)

	if arg_30_0.shipVO then
		setImageSprite(findTF(var_30_0, "Image"), LoadSprite("qicon/" .. arg_30_0.shipVO:getPainting()))
	end

	if arg_30_0.defaultTransformTipBar then
		setActive(arg_30_0.defaultTransformTipBar, false)
	end

	return
end

function var_0_0.updateOperation3(arg_31_0)
	triggerToggle(arg_31_0.toggles.replacePanel, true)

	local var_31_0 = arg_31_0.shipVO:getEquip(arg_31_0.contextData.pos)

	if var_31_0 then
		local var_31_1 = var_31_0:GetPropertiesInfo()
		local var_31_2 = arg_31_0.equipmentVO:GetPropertiesInfo()

		if EquipType.getCompareGroup(var_31_0.configId) == EquipType.getCompareGroup(arg_31_0.equipmentVO.configId) then
			Equipment.InsertAttrsCompare(var_31_1.attrs, var_31_2.attrs, arg_31_0.shipVO)
		end

		arg_31_0:updateEquipmentPanel(arg_31_0.replaceSrcEquipTF, var_31_0, var_31_1)
		arg_31_0:updateEquipmentPanel(arg_31_0.replaceDstEquipTF, arg_31_0.equipmentVO, var_31_2)
	else
		arg_31_0:updateEquipmentPanel(arg_31_0.replaceSrcEquipTF, var_31_0)
		arg_31_0:updateEquipmentPanel(arg_31_0.replaceDstEquipTF, arg_31_0.equipmentVO)
	end

	local var_31_3 = arg_31_0.replaceDstEquipTF:Find("head")

	setActive(var_31_3, arg_31_0.oldShipVO)

	if arg_31_0.oldShipVO then
		setImageSprite(findTF(var_31_3, "Image"), LoadSprite("qicon/" .. arg_31_0.oldShipVO:getPainting()))
	end

	return
end

function var_0_0.updateOperation4(arg_32_0)
	triggerToggle(arg_32_0.toggles.displayPanel, true)
	arg_32_0:updateEquipmentPanel(arg_32_0.displayEquipTF, arg_32_0.equipmentVO)
	setActive(arg_32_0.displayMoveBtn, arg_32_0.shipVO)

	local var_32_0 = arg_32_0.displayEquipTF:Find("head")

	setActive(var_32_0, arg_32_0.shipVO)

	if arg_32_0.shipVO then
		setImageSprite(findTF(var_32_0, "Image"), LoadSprite("qicon/" .. arg_32_0.shipVO:getPainting()))
	end

	arg_32_0:UpdateTransformTipBar(arg_32_0.equipmentVO)

	return
end

function var_0_0.updateRevertPanel(arg_33_0)
	local var_33_0 = arg_33_0.equipmentVO:GetRootEquipment()
	local var_33_1 = var_33_0:GetPropertiesInfo()

	Equipment.InsertAttrsCompare(arg_33_0.equipmentVO:GetPropertiesInfo().attrs, var_33_1.attrs, arg_33_0.shipVO)
	arg_33_0:updateEquipmentPanel(arg_33_0.revertEquipTF, var_33_0, var_33_1, arg_33_0.equipmentVO:getConfig("level"))
	arg_33_0:updateOperationAward(arg_33_0.revertAwardContainer, arg_33_0.itemTpl, arg_33_0.equipmentVO:getRevertAwards())

	return
end

function var_0_0.updateDestroyCount(arg_34_0)
	setText(arg_34_0.destroyValue, arg_34_0.destroyCount)

	local var_34_0 = arg_34_0.equipmentVO:getConfig("destory_item") or {}
	local var_34_1 = arg_34_0.equipmentVO:getConfig("destory_gold") or 0
	local var_34_2 = 0 + var_34_1 * arg_34_0.destroyCount

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		table.insert({}, {
			type = DROP_TYPE_ITEM,
			id = iter_34_1[1],
			count = iter_34_1[2] * arg_34_0.destroyCount
		})
	end

	table.insert({}, {
		id = 1,
		type = DROP_TYPE_RESOURCE,
		count = var_34_2
	})
	arg_34_0:updateOperationAward(arg_34_0.destroyBonusList, arg_34_0.destroyBonusItem, {})

	return
end

function var_0_0.updateOperationAward(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0.awards = arg_35_3

	if arg_35_1.childCount == 0 then
		for iter_35_0 = 1, #arg_35_3 do
			cloneTplTo(arg_35_2, arg_35_1)
		end
	end

	for iter_35_1 = 1, #arg_35_3 do
		local var_35_0 = arg_35_1:GetChild(iter_35_1 - 1)

		updateDrop(var_35_0, arg_35_3[iter_35_1])
		onButton(arg_35_0, var_35_0, function()
			arg_35_0:emit(var_0_0.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setText(findTF(var_35_0, "name_panel/name"), getText(findTF(var_35_0, "name")))
		setText(findTF(var_35_0, "name_panel/number"), " x " .. getText(findTF(var_35_0, "icon_bg/count")))
		setActive(findTF(var_35_0, "icon_bg/count"), false)
	end

	return
end

function var_0_0.updateEquipmentPanel(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = arg_37_1:Find("info")

	setActive(var_37_0, arg_37_2)
	setActive(arg_37_1:Find("empty"), not arg_37_2)

	if arg_37_2 then
		local var_37_1 = findTF(var_37_0, "name")

		setScrollText(findTF(var_37_1, "mask/Text"), arg_37_2:getConfig("name"))

		local var_37_2 = arg_37_2:isUnique() and arg_37_0.isShowUnique

		setActive(findTF(var_37_1, "unique"), var_37_2)

		local var_37_3 = findTF(var_37_0, "equip")

		setImageSprite(findTF(var_37_3, "bg"), GetSpriteFromAtlas("ui/equipmentinfoui_atlas", "equip_bg_" .. EquipmentRarity.Rarity2Print(arg_37_2:getConfig("rarity"))))
		updateEquipment(var_37_3, arg_37_2, {
			noIconColorful = true
		})
		setActive(findTF(var_37_3, "revert_btn"), false)
		setActive(findTF(var_37_3, "slv"), arg_37_4 or arg_37_2:getConfig("level") > 1)

		local var_37_5 = findTF(var_37_3, "slv/Text")

		if arg_37_4 then
			local var_37_6 = arg_37_4 - 1 or arg_37_2:getConfig("level") - 1

			var_37_4(var_37_5, var_37_6)
			setActive(findTF(var_37_3, "slv/next"), arg_37_4)
			setText(findTF(var_37_3, "slv/next/Text"), arg_37_2:getConfig("level") - 1)

			local var_37_7 = var_37_3:Find("tier")

			setActive(var_37_7, arg_37_2)

			local var_37_8

			if not arg_37_2:getConfig("tech") then
				var_37_8 = 1
			end

			eachChild(var_37_7, function(arg_38_0)
				setActive(arg_38_0, tostring(var_37_8) == arg_38_0.gameObject.name)

				return
			end)
			setImageSprite(findTF(var_37_3, "title"), GetSpriteFromAtlas("equiptype", EquipType.type2Tag(arg_37_2:getConfig("type"))))

			local var_37_9 = arg_37_2:getConfig("speciality") ~= "无" and arg_37_2:getConfig("speciality") or i18n1("—")

			setText(var_37_3:Find("speciality/Text"), var_37_9)
			updateEquipInfo(var_37_0:Find("attributes/view/content"), arg_37_3 or arg_37_2:GetPropertiesInfo(), arg_37_2:GetSkill(), arg_37_0.shipVO)

			return
		end
	end
end

function var_0_0.UpdateTransformTipBar(arg_39_0, arg_39_1)
	if not arg_39_0.defaultTransformTipBar then
		return
	end

	local var_39_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "EquipmentTransformTreeMediator")
	local var_39_1 = EquipmentProxy.GetTransformTargets(Equipment.GetEquipRootStatic(arg_39_1.id))

	setActive(arg_39_0.defaultTransformTipBar, not LOCK_EQUIPMENT_TRANSFORM and var_39_0 and #var_39_1 > 0)

	if isActive(arg_39_0.defaultTransformTipBar) then
		local var_39_2 = pg.equip_upgrade_data

		UIItemList.StaticAlign(arg_39_0.defaultTransformTipBar:Find("list"), arg_39_0.defaultTransformTipBar:Find("list/transformTarget"), #var_39_1, function(arg_40_0, arg_40_1, arg_40_2)
			if arg_40_0 == UIItemList.EventUpdate then
				setActive(arg_40_2:Find("link"), arg_40_1 > 0)

				local var_40_0 = var_39_2[var_39_1[arg_40_1 + 1]] and var_39_2[var_39_1[arg_40_1 + 1]].target_id

				if not (var_39_2[var_39_1[arg_40_1 + 1]] and var_39_2[var_39_1[arg_40_1 + 1]].target_id) then
					setActive(arg_40_2, false)

					return
				end

				updateDrop(arg_40_2:Find("item"), {
					type = DROP_TYPE_EQUIP,
					id = var_40_0
				})
				onButton(arg_39_0, arg_40_2:Find("item"), function()
					local var_41_0 = CreateShell(arg_39_1)

					if arg_39_0.shipVO then
						var_41_0.shipId = arg_39_0.shipVO.id
						var_41_0.shipPos = arg_39_0.contextData.pos
					end

					arg_39_0:emit(EquipmentInfoMediator.OPEN_LAYER, Context.New({
						mediator = EquipmentTransformMediator,
						viewComponent = EquipmentTransformLayer,
						data = {
							fromStoreHouse = true,
							formulaId = var_39_1[arg_40_1 + 1],
							sourceEquipmentInstance = {
								type = DROP_TYPE_EQUIP,
								id = arg_39_1.id,
								template = var_41_0
							}
						}
					}))

					return
				end, SFX_PANEL)
				arg_40_2:Find("mask/name"):GetComponent("ScrollText"):SetText(Equipment.getConfigData(var_40_0).name)
			end

			return
		end)
	end

	return
end

function var_0_0.cloneSampleTo(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = cloneTplTo(arg_42_0.sample, arg_42_1, arg_42_3)

	var_42_0.localPosition = Vector3.New(var_0_0.pos[arg_42_2][1], var_0_0.pos[arg_42_2][2], var_0_0.pos[arg_42_2][3])

	if arg_42_4 then
		var_42_0:SetSiblingIndex(arg_42_4)
	end

	return var_42_0
end

function var_0_0.willExit(arg_43_0)
	arg_43_0.equipDestroyConfirmWindow:Destroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_43_0._tf)

	return
end

function var_0_0.onBackPressed(arg_44_0)
	if arg_44_0.equipDestroyConfirmWindow:isShowing() then
		arg_44_0.equipDestroyConfirmWindow:Hide()

		return
	end

	if isActive(arg_44_0.destroyPanel) then
		triggerToggle(arg_44_0.toggles.defaultPanel, true)

		return
	end

	arg_44_0:closeView()

	return
end

return var_0_0
