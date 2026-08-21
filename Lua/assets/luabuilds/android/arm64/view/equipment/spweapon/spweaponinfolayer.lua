local var_0_0 = class("SpWeaponInfoLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SpWeaponInfoUI"
end

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
var_0_0.TYPE_DEFAULT = 1
var_0_0.TYPE_SHIP = 2
var_0_0.TYPE_REPLACE = 3
var_0_0.TYPE_DISPLAY = 4
var_0_0.SHOW_UNIQUE = {
	1,
	2,
	3,
	4
}

function var_0_0.init(arg_2_0)
	arg_2_0.toggles = {}

	for iter_2_0, iter_2_1 in ipairs({
		"default",
		"replace",
		"display"
	}) do
		arg_2_0[iter_2_1 .. "Panel"] = arg_2_0._tf:Find(iter_2_1)
		arg_2_0.toggles[iter_2_1 .. "Panel"] = arg_2_0._tf:Find("toggle_controll/" .. iter_2_1)
	end

	Canvas.ForceUpdateCanvases()

	arg_2_0.sample = arg_2_0._tf:Find("sample")

	setActive(arg_2_0.sample, false)

	arg_2_0.txtQuickEnable = findTF(arg_2_0._tf, "txtQuickEnable")

	setText(arg_2_0.txtQuickEnable, i18n("ship_equip_check"))
	setText(arg_2_0._tf:Find("sample/empty/Text"), i18n("spweapon_ui_empty"))

	return
end

function var_0_0.setEquipment(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.equipmentVO = arg_3_1
	arg_3_0.oldEquipmentVO = arg_3_2

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

function var_0_0.didEnter(arg_8_0)
	local var_8_0 = arg_8_0.contextData.quickFlag or false

	setActive(arg_8_0.txtQuickEnable, var_8_0)

	local var_8_1 = defaultValue(arg_8_0.contextData.type, var_0_0.TYPE_DEFAULT)

	arg_8_0.isShowUnique = table.contains(var_0_0.SHOW_UNIQUE, var_8_1)

	onButton(arg_8_0, arg_8_0._tf:Find("bg"), function()
		arg_8_0:closeView()

		return
	end, SOUND_BACK)
	arg_8_0:initAndSetBtn(var_8_1)

	if var_8_1 == var_0_0.TYPE_DEFAULT then
		arg_8_0:updateOperation1()
	elseif var_8_1 == var_0_0.TYPE_SHIP then
		arg_8_0:updateOperation2()
	elseif var_8_1 == var_0_0.TYPE_REPLACE then
		arg_8_0:updateOperation3()
	elseif var_8_1 == var_0_0.TYPE_DISPLAY then
		arg_8_0:updateOperation4()
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)

	return
end

local var_0_1 = {
	{
		"Enhance",
		"msgbox_text_noPos_intensify"
	},
	{
		"Replace",
		"msgbox_text_replace"
	},
	{
		"Unload",
		"msgbox_text_unload"
	},
	{
		"Modify",
		"msgbox_text_modify"
	}
}

function var_0_0.initAndSetBtn(arg_10_0, arg_10_1)
	if arg_10_1 == var_0_0.TYPE_DEFAULT or arg_10_1 == var_0_0.TYPE_SHIP then
		arg_10_0.defaultEquipTF = arg_10_0.defaultPanel:Find("equipment") or arg_10_0:cloneSampleTo(arg_10_0.defaultPanel, var_0_0.Middle, "equipment")

		table.Foreach(var_0_1, function(arg_11_0, arg_11_1)
			local var_11_0 = arg_10_0.defaultPanel:Find("actions/action_button_" .. arg_11_0)

			arg_10_0["default" .. arg_11_1[1] .. "Btn"] = var_11_0

			setText(var_11_0:GetChild(0), i18n(arg_11_1[2]))

			return
		end)
		onButton(arg_10_0, arg_10_0.defaultReplaceBtn, function()
			arg_10_0:emit(SpWeaponInfoMediator.ON_CHANGE)

			return
		end, SFX_PANEL)
		onButton(arg_10_0, arg_10_0.defaultEnhanceBtn, function()
			arg_10_0:emit(SpWeaponInfoMediator.ON_INTENSIFY)

			return
		end, SFX_PANEL)
		onButton(arg_10_0, arg_10_0.defaultUnloadBtn, function()
			arg_10_0:emit(SpWeaponInfoMediator.ON_UNEQUIP)

			return
		end, SFX_UI_DOCKYARD_EQUIPOFF)
		onButton(arg_10_0, arg_10_0.defaultModifyBtn, function()
			arg_10_0:emit(SpWeaponInfoMediator.ON_MODIFY)

			return
		end, SFX_PANEL)
	elseif arg_10_1 == var_0_0.TYPE_REPLACE then
		arg_10_0.replaceSrcEquipTF = arg_10_0.replacePanel:Find("equipment") or arg_10_0:cloneSampleTo(arg_10_0.replacePanel, var_0_0.Left, "equipment")
		arg_10_0.replaceDstEquipTF = arg_10_0.replacePanel:Find("equipment_on_ship") or arg_10_0:cloneSampleTo(arg_10_0.replacePanel, var_0_0.Right, "equipment_on_ship")
		arg_10_0.replaceCancelBtn = arg_10_0.replacePanel:Find("actions/cancel_button")
		arg_10_0.replaceConfirmBtn = arg_10_0.replacePanel:Find("actions/action_button_2")

		setText(arg_10_0.replaceConfirmBtn:Find("label"), i18n("msgbox_text_confirm"))
		setText(arg_10_0.replaceCancelBtn:Find("label"), i18n("msgbox_text_cancel"))
		onButton(arg_10_0, arg_10_0.replaceCancelBtn, function()
			arg_10_0:closeView()

			return
		end, SFX_CANCEL)
		onButton(arg_10_0, arg_10_0.replaceConfirmBtn, function()
			if arg_10_0.contextData.quickCallback then
				arg_10_0.contextData.quickCallback()
				arg_10_0:closeView()
			else
				arg_10_0:emit(SpWeaponInfoMediator.ON_EQUIP)
			end

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	elseif arg_10_1 == var_0_0.TYPE_DISPLAY then
		arg_10_0.displayEquipTF = arg_10_0.displayPanel:Find("equipment") or arg_10_0:cloneSampleTo(arg_10_0.displayPanel, var_0_0.Middle, "equipment")
		arg_10_0.displayMoveBtn = arg_10_0.displayPanel:Find("actions/move_button")

		setText(arg_10_0.displayMoveBtn:Find("label"), i18n("msgbox_text_equipdetail"))
		onButton(arg_10_0, arg_10_0.displayMoveBtn, function()
			arg_10_0:emit(SpWeaponInfoMediator.ON_MOVE, arg_10_0.shipVO.id)

			return
		end)
	end

	return
end

function var_0_0.updateOperation1(arg_19_0)
	triggerToggle(arg_19_0.toggles.defaultPanel, true)
	arg_19_0:updateEquipmentPanel(arg_19_0.defaultEquipTF, arg_19_0.equipmentVO, SpWeaponHelper.TransformNormalInfo(arg_19_0.equipmentVO))
	setActive(arg_19_0.defaultEnhanceBtn, true)
	setActive(arg_19_0.defaultReplaceBtn, false)
	setActive(arg_19_0.defaultUnloadBtn, false)
	setActive(arg_19_0.defaultModifyBtn, true)

	return
end

function var_0_0.updateOperation2(arg_20_0)
	triggerToggle(arg_20_0.toggles.defaultPanel, true)

	local var_20_0 = arg_20_0.shipVO:GetSpWeapon()

	arg_20_0:updateEquipmentPanel(arg_20_0.defaultEquipTF, var_20_0, SpWeaponHelper.TransformNormalInfo(var_20_0))
	setActive(arg_20_0.defaultEnhanceBtn, true)
	setActive(arg_20_0.defaultReplaceBtn, true)
	setActive(arg_20_0.defaultUnloadBtn, true)
	setActive(arg_20_0.defaultModifyBtn, true)

	local var_20_1 = arg_20_0.defaultEquipTF:Find("head")

	setActive(var_20_1, arg_20_0.shipVO)

	if arg_20_0.shipVO then
		setImageSprite(findTF(var_20_1, "Image"), LoadSprite("qicon/" .. arg_20_0.shipVO:getPainting()))
	end

	return
end

function var_0_0.updateOperation3(arg_21_0)
	triggerToggle(arg_21_0.toggles.replacePanel, true)

	if arg_21_0.equipmentVO then
		local var_21_0, var_21_1 = SpWeaponHelper.CompareNormalInfo(arg_21_0.equipmentVO, arg_21_0.oldEquipmentVO)

		arg_21_0:updateEquipmentPanel(arg_21_0.replaceSrcEquipTF, arg_21_0.equipmentVO, var_21_0)
		arg_21_0:updateEquipmentPanel(arg_21_0.replaceDstEquipTF, arg_21_0.oldEquipmentVO, var_21_1)
	else
		arg_21_0:updateEquipmentPanel(arg_21_0.replaceSrcEquipTF, nil)
		arg_21_0:updateEquipmentPanel(arg_21_0.replaceDstEquipTF, arg_21_0.oldEquipmentVO, SpWeaponHelper.TransformNormalInfo(arg_21_0.oldEquipmentVO))
	end

	local var_21_2 = arg_21_0.replaceDstEquipTF:Find("head")

	setActive(var_21_2, arg_21_0.oldShipVO)

	if arg_21_0.oldShipVO then
		setImageSprite(findTF(var_21_2, "Image"), LoadSprite("qicon/" .. arg_21_0.oldShipVO:getPainting()))
	end

	return
end

function var_0_0.updateOperation4(arg_22_0)
	triggerToggle(arg_22_0.toggles.displayPanel, true)
	arg_22_0:updateEquipmentPanel(arg_22_0.displayEquipTF, arg_22_0.equipmentVO, SpWeaponHelper.TransformNormalInfo(arg_22_0.equipmentVO))
	setActive(arg_22_0.displayMoveBtn, arg_22_0.shipVO)

	local var_22_0 = arg_22_0.displayEquipTF:Find("head")

	setActive(var_22_0, arg_22_0.shipVO)

	if arg_22_0.shipVO then
		setImageSprite(findTF(var_22_0, "Image"), LoadSprite("qicon/" .. arg_22_0.shipVO:getPainting()))
	end

	return
end

function var_0_0.updateOperationAward(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0.awards = arg_23_3

	if arg_23_1.childCount == 0 then
		for iter_23_0 = 1, #arg_23_3 do
			cloneTplTo(arg_23_2, arg_23_1)
		end
	end

	for iter_23_1 = 1, #arg_23_3 do
		local var_23_0 = arg_23_1:GetChild(iter_23_1 - 1)

		updateDrop(var_23_0, arg_23_3[iter_23_1])
		onButton(arg_23_0, var_23_0, function()
			arg_23_0:emit(var_0_0.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setText(findTF(var_23_0, "name_panel/name"), getText(findTF(var_23_0, "name")))
		setText(findTF(var_23_0, "name_panel/number"), " x " .. getText(findTF(var_23_0, "icon_bg/count")))
		setActive(findTF(var_23_0, "icon_bg/count"), false)
	end

	return
end

function var_0_0.updateEquipmentPanel(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1:Find("info")

	setActive(var_25_0, arg_25_2)
	setActive(arg_25_1:Find("empty"), not arg_25_2)

	if not arg_25_2 then
		return
	end

	setScrollText(findTF(findTF(var_25_0, "name"), "mask/Text"), arg_25_2:GetName())

	local var_25_1 = findTF(var_25_0, "equip")

	setImageSprite(findTF(var_25_1, "bg"), GetSpriteFromAtlas("ui/equipmentinfoui_atlas", "equip_bg_" .. ItemRarity.Rarity2Print(arg_25_2:GetRarity())))
	updateSpWeapon(var_25_1, arg_25_2, {
		noIconColorful = true
	})
	setActive(findTF(var_25_1, "slv"), arg_25_2:GetLevel() > 1)
	setText(findTF(var_25_1, "slv/Text"), arg_25_2:GetLevel() - 1)
	setActive(findTF(var_25_1, "slv/next"), false)
	setText(findTF(var_25_1, "slv/next/Text"), arg_25_2:GetLevel() - 1)

	local var_25_2 = var_25_1:Find("tier")

	setActive(var_25_2, arg_25_2)

	local var_25_3 = arg_25_2:GetTechTier()

	eachChild(var_25_2, function(arg_26_0)
		setActive(arg_26_0, tostring(var_25_3) == arg_26_0.gameObject.name)

		return
	end)
	updateSpWeaponInfo(var_25_0:Find("attributes/view/content"), arg_25_3, arg_25_2:GetSkillGroup())

	return
end

function var_0_0.cloneSampleTo(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = cloneTplTo(arg_27_0.sample, arg_27_1, arg_27_3)

	var_27_0.localPosition = Vector3.New(var_0_0.pos[arg_27_2][1], var_0_0.pos[arg_27_2][2], var_0_0.pos[arg_27_2][3])

	if arg_27_4 then
		var_27_0:SetSiblingIndex(arg_27_4)
	end

	return var_27_0
end

function var_0_0.willExit(arg_28_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_28_0._tf)

	return
end

function var_0_0.onBackPressed(arg_29_0)
	arg_29_0:closeView()

	return
end

return var_0_0
