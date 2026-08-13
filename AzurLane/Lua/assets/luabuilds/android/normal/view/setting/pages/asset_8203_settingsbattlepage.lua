class = var_0_10000

local var_0_0 = "SettingsBattlePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))
local var_0_2 = "joystick_anchorX"
local var_0_3 = "joystick_anchorY"
local var_0_4 = "skill_1_anchorX"
local var_0_5 = "skill_1_anchorY"
local var_0_6 = "skill_2_anchorX"
local var_0_7 = "skill_2_anchorY"
local var_0_8 = "skill_3_anchorX"
local var_0_9 = "skill_3_anchorY"
local var_0_10 = "skill_4_anchorX"
local var_0_11 = "skill_4_anchorY"

Color = var_0_10011
var_0_1.CLD_RED = var_0_10011.New(0.6, 0.05, 0.05, 0.5)
Color = var_11
var_0_1.DEFAULT_GREY = var_11.New(0.5, 0.5, 0.5, 0.5)

function var_0_1.getUIName(arg_1_0)
	return "SettingsBattlePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.editPanel = var_1.Find(var_2_0, "editor")
	findTF = var_1

	local var_2_1 = var_1(arg_2_0._tf, "editor/buttons")

	findTF = var_2
	arg_2_0.normalBtns = var_2(var_2_1, "normal")
	findTF = var_2
	arg_2_0.editBtns = var_2(var_2_1, "editing")
	findTF = var_2
	arg_2_0.saveBtn = var_2(arg_2_0.editBtns, "save")
	findTF = var_2
	arg_2_0.cancelBtn = var_2(arg_2_0.editBtns, "cancel")
	findTF = var_2
	arg_2_0.editBtn = var_2(arg_2_0.normalBtns, "edit")
	findTF = var_2
	arg_2_0.revertBtn = var_2(arg_2_0.normalBtns, "reset")
	findTF = var_2
	arg_2_0.interface = var_2(arg_2_0._tf, "editor/editing_region")
	findTF = var_2
	arg_2_0.stick = var_2(arg_2_0.interface, "Stick")
	findTF = var_2
	arg_2_0.skillBtn1 = var_2(arg_2_0.interface, "Skill_1")
	findTF = var_2
	arg_2_0.skillBtn2 = var_2(arg_2_0.interface, "Skill_2")
	findTF = var_2
	arg_2_0.skillBtn3 = var_2(arg_2_0.interface, "Skill_3")
	findTF = var_2
	arg_2_0.skillBtn4 = var_2(arg_2_0.interface, "Skill_4")

	local var_2_2 = arg_2_0.stick

	arg_2_0.eventStick = var_2.GetComponent(var_2_2, "EventTriggerListener")

	local var_2_3 = arg_2_0.skillBtn1

	arg_2_0.eventSkillBtn1 = var_2.GetComponent(var_2_3, "EventTriggerListener")

	local var_2_4 = arg_2_0.skillBtn2

	arg_2_0.eventSkillBtn2 = var_2.GetComponent(var_2_4, "EventTriggerListener")

	local var_2_5 = arg_2_0.skillBtn3

	arg_2_0.eventSkillBtn3 = var_2.GetComponent(var_2_5, "EventTriggerListener")

	local var_2_6 = arg_2_0.skillBtn4

	arg_2_0.eventSkillBtn4 = var_2.GetComponent(var_2_6, "EventTriggerListener")
	findTF = var_2
	arg_2_0.mask = var_2(arg_2_0.interface, "mask")
	findTF = var_2
	arg_2_0.topArea = var_2(arg_2_0.interface, "top")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_2_0.cg = var_2_8(var_2_7, var_4(var_1_10005))

	local var_2_9 = arg_2_0._parentTf.parent
	local var_2_10 = var_2.Find(var_2_9, "blur_panel")
	local var_2_11 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_2_0.topLayerCg = var_2_11(var_2_10, var_4(var_1_10005))
	setActive = var_2

	var_2(arg_2_0._tf, true)

	setText = var_2

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "editor/editing_region/mask/middle/Text")

	i18n = var_2_12

	var_2(var_2_13, var_2_12("settings_battle_tip"))

	setText = var_2

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "editor/buttons/normal/edit/Image")

	i18n = var_2_14

	var_2(var_2_15, var_2_14("settings_battle_Btn_edit"))

	setText = var_2

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "editor/buttons/normal/reset/Image")

	i18n = var_2_16

	var_2(var_2_17, var_2_16("settings_battle_Btn_reset"))

	setText = var_2

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "editor/title")

	i18n = var_2_18

	var_2(var_2_19, var_2_18("settings_battle_title"))

	setText = var_2

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "editor/buttons/editing/save/Image")

	i18n = var_2_20

	var_2(var_2_21, var_2_20("settings_battle_Btn_save"))

	setText = var_2

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "editor/buttons/editing/cancel/Image")

	i18n = var_2_22

	var_2(var_2_23, var_2_22("settings_battle_Btn_cancel"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.editBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.EditModeEnabled(var_4_0, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.revertBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {
			hideNo = false
		}

		i18n = var_2_10003
		var_5_2.content = var_2_10003("setting_interface_revert_check")

		function var_5_2.onYes()
			local var_6_0 = arg_3_0

			var_0.RevertInterfaceSetting(var_6_0, true)

			return
		end

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		if arg_3_0._currentDrag then
			LuaHelper = var_0

			var_0.triggerEndDrag(arg_3_0._currentDrag)
		end

		pg = var_0

		local var_7_0 = var_0.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {
			hideNo = false
		}

		i18n = var_2_10003
		var_7_2.content = var_2_10003("setting_interface_cancel_check")

		function var_7_2.onYes()
			local var_8_0 = arg_3_0

			var_0.EditModeEnabled(var_8_0, false)

			local var_8_1 = arg_3_0

			var_0.RevertInterfaceSetting(var_8_1, false)

			return
		end

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.saveBtn

	local function var_3_11()
		if arg_3_0._currentDrag then
			LuaHelper = var_0

			var_0.triggerEndDrag(arg_3_0._currentDrag)
		end

		local var_9_0 = arg_3_0

		var_0.EditModeEnabled(var_9_0, false)

		local var_9_1 = arg_3_0

		var_0.SaveInterfaceSetting(var_9_1)

		pg = var_0

		local var_9_2 = var_0.TipsMgr.GetInstance()
		local var_9_3 = var_0.ShowTips

		i18n = var_2

		var_9_3(var_9_2, var_2("setting_interface_save_success"))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)
	arg_3_0:InitInterfaceComponents()

	return
end

function var_0_1.InitInterfaceComponents(arg_10_0)
	ys = var_1_10001

	local var_10_0 = var_1_10001.Battle.BattleConfig.JOY_STICK_DEFAULT_PREFERENCE

	arg_10_0:InitInterfaceComponent(arg_10_0.stick, arg_10_0.eventStick, var_0_2, var_0_3, var_10_0)

	ys = var_2

	local var_10_1 = var_2.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE

	arg_10_0:InitInterfaceComponent(arg_10_0.skillBtn1, arg_10_0.eventSkillBtn1, var_0_4, var_0_5, var_10_1[1])
	arg_10_0:InitInterfaceComponent(arg_10_0.skillBtn2, arg_10_0.eventSkillBtn2, var_0_6, var_0_7, var_10_1[2])
	arg_10_0:InitInterfaceComponent(arg_10_0.skillBtn3, arg_10_0.eventSkillBtn3, var_0_8, var_0_9, var_10_1[3])
	arg_10_0:InitInterfaceComponent(arg_10_0.skillBtn4, arg_10_0.eventSkillBtn4, var_0_10, var_0_11, var_10_1[4])

	local var_10_2 = arg_10_0:GetScale()

	arg_10_0.components = {
		arg_10_0.topArea,
		arg_10_0.stick,
		arg_10_0.skillBtn1,
		arg_10_0.skillBtn2,
		arg_10_0.skillBtn3,
		arg_10_0.skillBtn4
	}

	for iter_10_0 = 2, #arg_10_0.components do
		setLocalScale = var_8

		var_8(arg_10_0.components[iter_10_0], var_10_2)
	end

	arg_10_0:EditModeEnabled(false)

	return
end

function var_0_1.GetScale(arg_11_0)
	rtf = var_1_10001

	local var_11_0 = var_1_10001(arg_11_0.interface).rect.width

	rtf = var_2

	local var_11_1 = var_2(arg_11_0.interface).rect.height

	rtf = var_3

	local var_11_2 = var_3(arg_11_0._parentTf).rect.width

	rtf = var_4

	local var_11_3 = var_4(arg_11_0._parentTf).rect.height
	local var_11_4

	if var_11_0 / var_11_1 > var_11_2 / var_11_3 then
		var_11_4 = var_11_1 / var_11_3
	else
		var_11_4 = var_11_0 / var_11_2
	end

	Vector3 = var_6

	return var_6.New(var_11_4, var_11_4, 1)
end

function var_0_1.InitInterfaceComponent(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	rtf = var_1_10006

	local var_12_0 = var_1_10006(arg_12_0._parentTf).rect.width

	rtf = var_7

	local var_12_1 = var_7(arg_12_0._parentTf).rect.height
	local var_12_2 = var_12_0 * 0.5 + arg_12_0.interface.localPosition.x + arg_12_0.interface.parent.localPosition.x + arg_12_0.interface.parent.parent.localPosition.x
	local var_12_3 = var_12_1 * 0.5 + arg_12_0.interface.localPosition.y + arg_12_0.interface.parent.localPosition.y + arg_12_0.interface.parent.parent.localPosition.y
	local var_12_4
	local var_12_5
	local var_12_6
	local var_12_7

	arg_12_2:AddBeginDragFunc(function(arg_13_0, arg_13_1)
		arg_12_0._currentDrag = arg_12_2

		local var_13_0 = var_12_0

		UnityEngine = var_3
		var_12_6 = var_13_0 / var_3.Screen.width

		local var_13_1 = var_12_1

		UnityEngine = var_3
		var_12_7 = var_13_1 / var_3.Screen.height
		var_12_4 = arg_12_1.localPosition.x
		var_12_5 = arg_12_1.localPosition.y

		return
	end)
	arg_12_2:AddDragFunc(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_12_1

		Vector3 = var_2_10003
		var_14_0.localPosition = var_2_10003(arg_14_1.position.x * var_12_6 - var_12_2, arg_14_1.position.y * var_12_7 - var_12_3, 0)

		local var_14_1 = arg_12_0

		var_2.CheckInterfaceIntersect(var_14_1)

		return
	end)
	arg_12_2:AddDragEndFunc(function(arg_15_0, arg_15_1)
		arg_12_0._currentDrag = nil

		local var_15_0 = arg_12_0

		if var_2.CheckInterfaceIntersect(var_15_0) then
			local var_15_1 = arg_12_1

			Vector3 = var_2_10004
			var_15_1.localPosition = var_2_10004(var_12_4, var_12_5, 0)
		end

		local var_15_2 = arg_12_0

		var_3.CheckInterfaceIntersect(var_15_2)

		return
	end)
	arg_12_0:SetInterfaceAnchor(arg_12_1, arg_12_3, arg_12_4, arg_12_5)

	return
end

function var_0_1.EditModeEnabled(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.normalBtns, not arg_16_1)

	setActive = var_1_10002

	var_1_10002(arg_16_0.mask, not arg_16_1)

	setActive = var_1_10002

	var_1_10002(arg_16_0.editBtns, arg_16_1)

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.components) do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(iter_16_1, "rect"), arg_16_1)

		if 1 < iter_16_0 then
			GetOrAddComponent = var_1_10007
			var_1_10007 = var_1_10007(iter_16_1, "EventTriggerListener")
			var_1_10007.enabled = arg_16_1
		end
	end

	Input = var_2
	var_2.multiTouchEnabled = not arg_16_1
	arg_16_0.topLayerCg.blocksRaycasts = not arg_16_1

	return
end

function var_0_1.SetInterfaceAnchor(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0
	local var_17_1

	if arg_17_5 then
		var_17_0 = arg_17_4.x
		var_17_1 = arg_17_4.y
	else
		PlayerPrefs = var_1_10008
		var_17_0 = var_1_10008.GetFloat(arg_17_2, arg_17_4.x)
		PlayerPrefs = var_1_10008
		var_17_1 = var_1_10008.GetFloat(arg_17_3, arg_17_4.y)
	end

	rtf = var_1_10008

	local var_17_2 = var_1_10008(arg_17_0.interface).rect.width

	rtf = var_9

	local var_17_3 = var_9(arg_17_0.interface).rect.height
	local var_17_4 = (var_17_0 - 0.5) * var_17_2
	local var_17_5 = (var_17_1 - 0.5) * var_17_3

	Vector3 = var_1_10012
	arg_17_1.localPosition = var_1_10012(var_17_4, var_17_5, 0)

	return
end

local function var_0_12(arg_18_0)
	rtf = var_1_10001

	local var_18_0 = var_1_10001(arg_18_0).rect.width * var_1.lossyScale.x
	local var_18_1 = var_2.height * var_1.lossyScale.y
	local var_18_2 = var_1.position

	UnityEngine = var_1_10006

	return var_1_10006.Rect.New(var_18_2.x - var_18_0 / 2, var_18_2.y - var_18_1 / 2, var_18_0, var_18_1)
end

function var_0_1.CheckInterfaceIntersect(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = false
	local var_19_2 = {}
	local var_19_3 = var_0_12(arg_19_0.interface)

	ipairs = var_5

	for iter_19_0, iter_19_1 in var_5(arg_19_0.components) do
		var_19_2[iter_19_1] = var_0_12(iter_19_1:Find("rect"))
	end

	ipairs = var_5

	for iter_19_2, iter_19_3 in var_5(arg_19_0.components) do
		ipairs = var_1_10010

		for iter_19_4, iter_19_5 in var_1_10010(arg_19_0.components) do
			if iter_19_3 ~= iter_19_5 then
				local var_19_4 = var_19_2[iter_19_3]

				if var_15.Overlaps(var_19_4, var_19_2[iter_19_5]) then
					var_19_0[iter_19_5] = true
				end
			end
		end

		if 1 < iter_19_2 then
			Vector2 = var_1_10010
			var_1_10010 = var_1_10010.New(var_19_2[iter_19_3].xMin, var_19_2[iter_19_3].yMin)
			Vector2 = var_11

			local var_19_5 = var_11.New(var_19_2[iter_19_3].xMax, var_19_2[iter_19_3].yMax)

			iter_19_4 = var_19_3

			if var_19_3.Contains(iter_19_4, var_1_10010) then
				iter_19_4 = var_19_3

				if not var_19_3.Contains(iter_19_4, var_19_5) then
					var_19_0[iter_19_3] = true
				end
			end
		end
	end

	ipairs = var_5

	for iter_19_6, iter_19_7 in var_5(arg_19_0.components) do
		findTF = var_1_10010

		local var_19_6 = var_1_10010(iter_19_7, "rect")

		var_1_10010 = var_1_10010.GetComponent
		typeof = var_12
		Image = iter_19_4
		var_1_10010 = var_1_10010(var_19_6, var_12(iter_19_4))

		if var_19_0[iter_19_7] then
			var_1_10010.color = var_0_1.CLD_RED
			var_19_1 = true
		else
			var_1_10010.color = var_0_1.DEFAULT_GREY
		end
	end

	return var_19_1
end

function var_0_1.RevertInterfaceSetting(arg_20_0, arg_20_1)
	ys = var_1_10002

	local var_20_0 = var_1_10002.Battle.BattleConfig.JOY_STICK_DEFAULT_PREFERENCE

	ys = var_1_10003

	local var_20_1 = var_1_10003.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE

	arg_20_0:SetInterfaceAnchor(arg_20_0.stick, var_0_2, var_0_3, var_20_0, arg_20_1)
	arg_20_0:SetInterfaceAnchor(arg_20_0.skillBtn1, var_0_4, var_0_5, var_20_1[1], arg_20_1)
	arg_20_0:SetInterfaceAnchor(arg_20_0.skillBtn2, var_0_6, var_0_7, var_20_1[2], arg_20_1)
	arg_20_0:SetInterfaceAnchor(arg_20_0.skillBtn3, var_0_8, var_0_9, var_20_1[3], arg_20_1)
	arg_20_0:SetInterfaceAnchor(arg_20_0.skillBtn4, var_0_10, var_0_11, var_20_1[4], arg_20_1)
	arg_20_0:SaveInterfaceSetting()

	return
end

function var_0_1.SaveInterfaceSetting(arg_21_0)
	arg_21_0:OverrideInterfaceSetting(arg_21_0.stick, var_0_2, var_0_3)
	arg_21_0:OverrideInterfaceSetting(arg_21_0.skillBtn1, var_0_4, var_0_5)
	arg_21_0:OverrideInterfaceSetting(arg_21_0.skillBtn2, var_0_6, var_0_7)
	arg_21_0:OverrideInterfaceSetting(arg_21_0.skillBtn3, var_0_8, var_0_9)
	arg_21_0:OverrideInterfaceSetting(arg_21_0.skillBtn4, var_0_10, var_0_11)

	return
end

function var_0_1.OverrideInterfaceSetting(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	rtf = var_1_10004

	local var_22_0 = var_1_10004(arg_22_0.interface).rect.width

	rtf = var_5

	local var_22_1 = var_5(arg_22_0.interface).rect.height
	local var_22_2 = (arg_22_1.localPosition.x + var_22_0 * 0.5) / var_22_0
	local var_22_3 = (arg_22_1.localPosition.y + var_22_1 * 0.5) / var_22_1

	PlayerPrefs = var_8

	var_8.SetFloat(arg_22_2, var_22_2)

	PlayerPrefs = var_8

	var_8.SetFloat(arg_22_3, var_22_3)

	return
end

function var_0_1.OnDestroy(arg_23_0)
	ClearEventTrigger = var_1_10001

	var_1_10001(arg_23_0.eventStick)

	ClearEventTrigger = var_1_10001

	var_1_10001(arg_23_0.eventSkillBtn1)

	ClearEventTrigger = var_1_10001

	var_1_10001(arg_23_0.eventSkillBtn2)

	ClearEventTrigger = var_1_10001

	var_1_10001(arg_23_0.eventSkillBtn3)

	ClearEventTrigger = var_1_10001

	var_1_10001(arg_23_0.eventSkillBtn4)

	Input = var_1_10001
	var_1_10001.multiTouchEnabled = true

	return
end

function var_0_1.Show(arg_24_0)
	arg_24_0.cg.blocksRaycasts = true
	arg_24_0.cg.alpha = 1

	return
end

function var_0_1.Hide(arg_25_0)
	arg_25_0.cg.blocksRaycasts = false
	arg_25_0.cg.alpha = 0

	return
end

return var_0_1
