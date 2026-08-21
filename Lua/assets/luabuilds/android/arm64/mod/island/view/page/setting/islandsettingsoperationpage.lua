local var_0_0 = class("IslandSettingsOperationPage", import("view.base.BaseSubView"))

var_0_0.CLD_RED = Color.New(0.6, 0.05, 0.05, 0.5)
var_0_0.DEFAULT_GREY = Color.New(0.5, 0.5, 0.5, 0.5)

function var_0_0.getUIName(arg_1_0)
	return "IslandSettingsOperatePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.editPanel = arg_2_0._tf:Find("editor")

	local var_2_0 = findTF(arg_2_0._tf, "editor/buttons")

	arg_2_0.normalBtns = findTF(var_2_0, "normal")
	arg_2_0.editBtns = findTF(var_2_0, "editing")
	arg_2_0.saveBtn = findTF(arg_2_0.editBtns, "save")
	arg_2_0.cancelBtn = findTF(arg_2_0.editBtns, "cancel")
	arg_2_0.editBtn = findTF(arg_2_0.normalBtns, "edit")
	arg_2_0.revertBtn = findTF(arg_2_0.normalBtns, "reset")
	arg_2_0.interface = findTF(arg_2_0._tf, "editor/editing_region")
	arg_2_0.stick = findTF(arg_2_0.interface, "move")
	arg_2_0.opTFList = {}

	table.insert(arg_2_0.opTFList, findTF(arg_2_0.interface, "op_btn"))
	table.insert(arg_2_0.opTFList, findTF(arg_2_0.interface, "jump"))
	table.insert(arg_2_0.opTFList, findTF(arg_2_0.interface, "scope"))
	table.insert(arg_2_0.opTFList, findTF(arg_2_0.interface, "seed"))

	arg_2_0.eventStick = arg_2_0.stick:GetComponent("EventTriggerListener")
	arg_2_0.eventStickList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.opTFList) do
		table.insert(arg_2_0.eventStickList, iter_2_1:GetComponent("EventTriggerListener"))
	end

	arg_2_0.mask = findTF(arg_2_0.interface, "mask")
	arg_2_0.topArea = findTF(arg_2_0.interface, "top")
	arg_2_0.cg = arg_2_0._tf:GetComponent(typeof(CanvasGroup))
	arg_2_0.topLayerCg = arg_2_0._parentTf.parent:Find("adapt"):GetComponent(typeof(CanvasGroup))

	setActive(arg_2_0._tf, true)
	setText(arg_2_0._tf:Find("editor/editing_region/mask/middle/Text"), i18n("settings_battle_tip"))
	setText(arg_2_0._tf:Find("editor/buttons/normal/edit/Image"), i18n("settings_battle_Btn_edit"))
	setText(arg_2_0._tf:Find("editor/buttons/normal/reset/Image"), i18n("settings_battle_Btn_reset"))
	setText(arg_2_0._tf:Find("editor/title/title_name"), i18n("settings_battle_title"))
	setText(arg_2_0._tf:Find("editor/buttons/editing/save/Image"), i18n("settings_battle_Btn_save"))
	setText(arg_2_0._tf:Find("editor/buttons/editing/cancel/Image"), i18n("settings_battle_Btn_cancel"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.editBtn, function()
		arg_3_0:EditModeEnabled(true)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.revertBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("setting_interface_revert_check"),
			onYes = function()
				arg_3_0:RevertInterfaceSetting(true)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		if arg_3_0._currentDrag then
			LuaHelper.triggerEndDrag(arg_3_0._currentDrag)
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("setting_interface_cancel_check"),
			onYes = function()
				arg_3_0:EditModeEnabled(false)
				arg_3_0:RevertInterfaceSetting(false)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.saveBtn, function()
		if arg_3_0._currentDrag then
			LuaHelper.triggerEndDrag(arg_3_0._currentDrag)
		end

		arg_3_0:EditModeEnabled(false)
		arg_3_0:SaveInterfaceSetting()
		pg.TipsMgr.GetInstance():ShowTips(i18n("setting_interface_save_success"))

		return
	end, SFX_PANEL)
	arg_3_0:InitInterfaceComponents()

	return
end

function var_0_0.InitInterfaceComponents(arg_10_0)
	arg_10_0:InitInterfaceComponent(arg_10_0.stick, arg_10_0.eventStick, IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX, IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.opTFList) do
		arg_10_0:InitInterfaceComponent(iter_10_1, arg_10_0.eventStickList[iter_10_0], IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[iter_10_0], IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[iter_10_0], IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[iter_10_0])
	end

	local var_10_0 = arg_10_0:GetScale()

	arg_10_0.components = {
		arg_10_0.topArea,
		arg_10_0.stick
	}

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.opTFList) do
		table.insert(arg_10_0.components, iter_10_3)
	end

	for iter_10_4 = 2, #arg_10_0.components do
		setLocalScale(arg_10_0.components[iter_10_4], var_10_0)
	end

	arg_10_0:EditModeEnabled(false)

	return
end

function var_0_0.GetScale(arg_11_0)
	local var_11_0 = rtf(arg_11_0.interface).rect.width
	local var_11_1 = rtf(arg_11_0.interface).rect.height
	local var_11_2 = rtf(arg_11_0._parentTf).rect.width
	local var_11_3 = rtf(arg_11_0._parentTf).rect.height
	local var_11_4 = var_11_0 / var_11_1 > var_11_2 / var_11_3 and var_11_1 / var_11_3 or var_11_0 / var_11_2

	return Vector3.New(var_11_4, var_11_4, 1)
end

function var_0_0.InitInterfaceComponent(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = rtf(arg_12_0._parentTf).rect.width * 0.5 + arg_12_0.interface.localPosition.x + arg_12_0.interface.parent.localPosition.x + arg_12_0.interface.parent.parent.localPosition.x
	local var_12_1 = rtf(arg_12_0._parentTf).rect.height * 0.5 + arg_12_0.interface.localPosition.y + arg_12_0.interface.parent.localPosition.y + arg_12_0.interface.parent.parent.localPosition.y
	local var_12_2
	local var_12_3
	local var_12_4
	local var_12_5

	arg_12_2:AddBeginDragFunc(function(arg_13_0, arg_13_1)
		arg_12_0._currentDrag = arg_12_2
		var_12_4 = var_0 / UnityEngine.Screen.width
		var_12_5 = var_0 / UnityEngine.Screen.height
		var_12_2 = arg_12_1.localPosition.x
		var_12_3 = arg_12_1.localPosition.y

		return
	end)
	arg_12_2:AddDragFunc(function(arg_14_0, arg_14_1)
		arg_12_1.localPosition = Vector3(arg_14_1.position.x * var_12_4 - var_12_0, arg_14_1.position.y * var_12_5 - var_12_1, 0)

		arg_12_0:CheckInterfaceIntersect()

		return
	end)
	arg_12_2:AddDragEndFunc(function(arg_15_0, arg_15_1)
		arg_12_0._currentDrag = nil

		if arg_12_0:CheckInterfaceIntersect() then
			arg_12_1.localPosition = Vector3(var_12_2, var_12_3, 0)
		end

		arg_12_0:CheckInterfaceIntersect()

		return
	end)
	arg_12_0:SetInterfaceAnchor(arg_12_1, arg_12_3, arg_12_4, arg_12_5)

	return
end

function var_0_0.EditModeEnabled(arg_16_0, arg_16_1)
	setActive(arg_16_0.normalBtns, not arg_16_1)
	setActive(arg_16_0.mask, not arg_16_1)
	setActive(arg_16_0.editBtns, arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.components) do
		setActive(findTF(iter_16_1, "rect"), arg_16_1)

		if iter_16_0 > 1 then
			GetOrAddComponent(iter_16_1, "EventTriggerListener").enabled = arg_16_1
		end
	end

	Input.multiTouchEnabled = not arg_16_1
	arg_16_0.topLayerCg.blocksRaycasts = not arg_16_1

	return
end

function var_0_0.SetInterfaceAnchor(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0
	local var_17_1

	if arg_17_5 then
		var_17_0 = arg_17_4.x
		var_17_1 = arg_17_4.y
	else
		var_17_0 = PlayerPrefs.GetFloat(arg_17_2, arg_17_4.x)
		var_17_1 = PlayerPrefs.GetFloat(arg_17_3, arg_17_4.y)
	end

	arg_17_1.anchoredPosition = Vector3(var_17_0, var_17_1, 0)

	return
end

local function var_0_1(arg_18_0)
	local var_18_0 = rtf(arg_18_0)

	return UnityEngine.Rect.New(var_18_0.position.x - var_18_0.rect.width * var_18_0.lossyScale.x / 2, var_18_0.position.y - var_18_0.rect.height * var_18_0.lossyScale.y / 2, var_18_0.rect.width * var_18_0.lossyScale.x, var_18_0.rect.height * var_18_0.lossyScale.y)
end

function var_0_0.CheckInterfaceIntersect(arg_19_0)
	local var_19_0 = false
	local var_19_1 = var_0_1(arg_19_0.interface)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.components) do
		({})[iter_19_1] = var_0_1(iter_19_1:Find("rect"))
	end

	for iter_19_2, iter_19_3 in ipairs(arg_19_0.components) do
		for iter_19_4, iter_19_5 in ipairs(arg_19_0.components) do
			if iter_19_3 ~= iter_19_5 and ({})[iter_19_3]:Overlaps(({})[iter_19_5]) then
				({})[iter_19_5] = true
			end
		end

		if iter_19_2 > 1 then
			local var_19_2 = Vector2.New(({})[iter_19_3].xMax, ({})[iter_19_3].yMax)

			if not var_19_1:Contains((Vector2.New(({})[iter_19_3].xMin, ({})[iter_19_3].yMin))) or not var_19_1:Contains(var_19_2) then
				({})[iter_19_3] = true
			end
		end
	end

	for iter_19_6, iter_19_7 in ipairs(arg_19_0.components) do
		local var_19_3 = findTF(iter_19_7, "rect"):GetComponent(typeof(Image))

		if ({})[iter_19_7] then
			var_19_3.color = var_0_0.CLD_RED
			var_19_0 = true
		else
			var_19_3.color = var_0_0.DEFAULT_GREY
		end
	end

	return var_19_0
end

function var_0_0.RevertInterfaceSetting(arg_20_0, arg_20_1)
	arg_20_0:SetInterfaceAnchor(arg_20_0.stick, IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX, IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE, arg_20_1)

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.opTFList) do
		arg_20_0:SetInterfaceAnchor(iter_20_1, IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[iter_20_0], IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[iter_20_0], IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[iter_20_0], arg_20_1)
	end

	arg_20_0:SaveInterfaceSetting()

	return
end

function var_0_0.SaveInterfaceSetting(arg_21_0)
	arg_21_0:OverrideInterfaceSetting(arg_21_0.stick, IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX, IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.opTFList) do
		arg_21_0:OverrideInterfaceSetting(iter_21_1, IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[iter_21_0], IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[iter_21_0])
	end

	return
end

function var_0_0.OverrideInterfaceSetting(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	PlayerPrefs.SetFloat(arg_22_2, arg_22_1.anchoredPosition.x)
	PlayerPrefs.SetFloat(arg_22_3, arg_22_1.anchoredPosition.y)

	return
end

function var_0_0.OnDestroy(arg_23_0)
	ClearEventTrigger(arg_23_0.eventStick)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.eventStickList) do
		ClearEventTrigger(iter_23_1)
	end

	Input.multiTouchEnabled = true

	return
end

function var_0_0.Show(arg_24_0)
	arg_24_0.cg.blocksRaycasts = true
	arg_24_0.cg.alpha = 1

	return
end

function var_0_0.Hide(arg_25_0)
	arg_25_0.cg.blocksRaycasts = false
	arg_25_0.cg.alpha = 0

	return
end

return var_0_0
