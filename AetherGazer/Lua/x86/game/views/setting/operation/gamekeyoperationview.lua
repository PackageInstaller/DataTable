local var_0_0 = class("GameKeyOperationView", ReduxView)
local var_0_1 = require("cjson")
local var_0_2 = {
	KeyMouse = "KeyMouseLayout",
	Keyboard = "KeyboardLayout",
	Other = "OtherLayout",
	PS = "PS4Layout",
	Xbox = "XboxLayout"
}

CONTROL_TYPES = {
	Move = 1,
	View = 2,
	SandPlay = 8,
	System = 6,
	MiniGame = 7,
	Battle = 4,
	SubJoystick = 3,
	Operation = 5,
	None = 0
}

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		arg_1_0.scrollView_.verticalNormalizedPosition = 1
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.settingView_ = arg_2_1
	arg_2_0.params_ = arg_2_3

	arg_2_0:Init()
	arg_2_0:OnEnter()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.keysChangeInfo_ = {}
	arg_3_0.cursorSensitivity = {}
	arg_3_0.remapNotice_ = {}
	arg_3_0.oldRemapNotice_ = {}

	arg_3_0:InitDropdownData()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.bindings_ = {}
	arg_4_0.bindings_[CONTROL_TYPES.Move] = GameKeyBindingContent.New(arg_4_0.moveBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.View] = GameKeyBindingContent.New(arg_4_0.viewBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.SubJoystick] = GameKeyBindingContent.New(arg_4_0.subJoyBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.Battle] = GameKeyBindingContent.New(arg_4_0.battleBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.Operation] = GameKeyBindingContent.New(arg_4_0.operBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.System] = GameKeyBindingContent.New(arg_4_0.sysBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.MiniGame] = GameKeyBindingContent.New(arg_4_0.miniGameBindingGo_)
	arg_4_0.bindings_[CONTROL_TYPES.SandPlay] = GameKeyBindingContent.New(arg_4_0.sandPlayBindingGo_)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.bindings_) do
		iter_4_1:SetKeyChangedCallback(function(arg_5_0, arg_5_1, arg_5_2)
			arg_4_0:OnKeyChanged(arg_5_0, arg_5_1, arg_5_2, iter_4_0)
		end)
	end

	arg_4_0:RegistEventListener(BATTLE_UI_ADJUSTED, handler(arg_4_0, arg_4_0.RefreshBattleUIName))
	arg_4_0:RegistEventListener(JOYSTICK_TYPE_SELECT, handler(arg_4_0, arg_4_0.OnJoystickTypeSelect))

	arg_4_0.remapToggleCon_ = arg_4_0.remapToggleConEx_:GetController("default0")
	arg_4_0.gamepadToggleCon_ = arg_4_0.gamepadToggleConEx_:GetController("default0")
	arg_4_0.autoHideToggleCon_ = arg_4_0.autoHideToggleConEx_:GetController("default0")
	arg_4_0.holdGamepadCon_ = arg_4_0.holdGamepadConEx_:GetController("default0")
	arg_4_0.battleCursorCon_ = arg_4_0.battleCursorConEx_:GetController("default0")
	arg_4_0.hidTypeCon_ = arg_4_0.controllerEx_:GetController("hidType")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.keyboardBtn_, nil, function()
		local var_7_0 = LuaHidTools.GetPlayerSelectKeyboard()

		arg_6_0:SwitchToHID(var_7_0 == 0 and HID_TYPES.KeyMouse or var_7_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.gamepadBtn_, nil, function(arg_8_0)
		local var_8_0 = LuaHidTools.GetPlayerSelectJoystick()

		arg_6_0:SwitchToHID(var_8_0 == 0 and HID_TYPES.Xbox or var_8_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.gamepadSelBtn_, nil, function(arg_9_0)
		local var_9_0 = LuaHidTools.GetPlayerSelectJoystick()

		LuaHidTools.OpenGamepadSelectWin(var_9_0)
	end)
	arg_6_0:AddToggleListener(arg_6_0.keyboardDropdown_, function(arg_10_0)
		arg_6_0:SwitchToHID(arg_10_0 == 0 and HID_TYPES.Keyboard or HID_TYPES.KeyMouse)
		LuaHidTools.SetPlayerSelectKeyboard(arg_6_0.gamepadType_)
		arg_6_0:RefreshControlTypeName()
	end)
	arg_6_0:AddToggleListener(arg_6_0.gamepadToggle_, function(arg_11_0)
		arg_6_0.gamepadEnable_ = arg_11_0

		arg_6_0.gamepadToggleCon_:SetSelectedState(arg_11_0 and "on" or "off")
		arg_6_0:RefreshSlider()
		arg_6_0:UpdateBindingVisibility()

		if arg_11_0 then
			arg_6_0:RebuildUILayout()
		else
			arg_6_0.remapNoticeToggle_.isOn = false
		end
	end)
	arg_6_0:AddToggleListener(arg_6_0.remapNoticeToggle_, function(arg_12_0)
		arg_6_0:SetRemapNotice(arg_12_0)
	end)
	arg_6_0:AddToggleListener(arg_6_0.autoHideToggle_, function(arg_13_0)
		LuaForCursor.SetKeyboardAutoHide(arg_13_0)
		arg_6_0.autoHideToggleCon_:SetSelectedState(arg_13_0 and "on" or "off")
		arg_6_0:RefreshHIDToggles()
	end)
	arg_6_0:AddToggleListener(arg_6_0.holdGamepadToggle_, function(arg_14_0)
		LuaHidTools.SetIsKeepJoystickType(arg_14_0)
		arg_6_0.holdGamepadCon_:SetSelectedState(arg_14_0 and "on" or "off")
		arg_6_0:RefreshHIDToggles()
	end)
	arg_6_0:AddToggleListener(arg_6_0.battleCursorToggle_, function(arg_15_0)
		LuaForCursor.SetBattleShowCursor(arg_15_0)
		arg_6_0.battleCursorCon_:SetSelectedState(arg_15_0 and "on" or "off")
		arg_6_0:RefreshHIDToggles()
	end)
	arg_6_0:AddBtnListener(arg_6_0.battleUiAdjBtn_, nil, function()
		arg_6_0:Go("battleUIAdjust", {})
	end)
	arg_6_0.cursorSenSlider_.onValueChanged:AddListener(function(arg_17_0)
		arg_6_0.cursorSensitivity[arg_6_0.gamepadType_] = arg_17_0

		local var_17_0 = arg_6_0:GetLayoutName(arg_6_0.gamepadType_)

		LuaForGamepad.SetCursorSensitivity(var_17_0, LuaForGamepad.GetDefaultLayoutFileName(var_17_0), arg_17_0)
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.cursorSenSubGo_, 3, 0.5, 0.5, function()
		if arg_6_0.cursorSenSlider_.value > 0 then
			arg_6_0.cursorSenSlider_.value = arg_6_0.cursorSenSlider_.value - 1

			return true
		end

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.cursorSenAddGo_, 3, 0.5, 0.5, function()
		if arg_6_0.cursorSenSlider_.value < 100 then
			arg_6_0.cursorSenSlider_.value = arg_6_0.cursorSenSlider_.value + 1

			return true
		end

		return false
	end)
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.keysChangeInfo_ = {}
	arg_20_0.gamepadType_ = LuaForGamepad.GetGamepadType()

	if arg_20_0.gamepadType_ == HID_TYPES.None then
		arg_20_0.gamepadType_ = HID_TYPES.Keyboard
	end

	arg_20_0.layoutName_ = arg_20_0:GetLayoutName(arg_20_0.gamepadType_)
	arg_20_0.gamepadEnable_ = arg_20_0:IsJoystickEnable()
	arg_20_0.oldGamepadEnable_ = arg_20_0.gamepadEnable_
	arg_20_0.oldGamepadType_ = arg_20_0.gamepadType_
	arg_20_0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(arg_20_0.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(arg_20_0.layoutName_))
	arg_20_0.oldCursorSensitivity = {}

	arg_20_0:RefreshHIDToggles()

	arg_20_0.oldHoldGamePadToggle_ = arg_20_0.holdGamepadToggle_.isOn
	arg_20_0.oldBattleCursorToggle_ = arg_20_0.battleCursorToggle_.isOn

	arg_20_0:RefreshUI()
end

function var_0_0.InitDropdownData(arg_21_0)
	arg_21_0.keyboardDropdown_.options:Clear()

	local var_21_0 = {
		"KEYBOARD_CONTROL_MODE_1",
		"KEYBOARD_CONTROL_MODE_2"
	}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		arg_21_0.keyboardDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips(iter_21_1), nil))
	end

	arg_21_0.keyboardDropdown_:RefreshShownValue()

	local var_21_1 = LuaHidTools.GetPlayerSelectKeyboard()

	arg_21_0.keyboardDropdown_.value = (var_21_1 == HID_TYPES.Keyboard and 1 or 2) - 1
end

function var_0_0.OnExit(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.bindings_) do
		iter_22_1:OnExit()
	end

	arg_22_0:StopRebuildTimer()
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.bindings_) do
		iter_23_1:Dispose()
	end

	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.RefreshUI(arg_24_0)
	arg_24_0:RefreshBattleUIName()
	arg_24_0:RefreshControlTypeName()
	arg_24_0:RefreshRemapNoticeToggle()

	arg_24_0.holdGamepadText_.text = GetTips("GAMEPAD_HOLD_SELECTION")
end

function var_0_0.RefreshBindingUI(arg_25_0)
	local var_25_0 = LuaForGamepad.GetLayoutControlGroups(arg_25_0.layoutName_)

	arg_25_0.controlGroupsData_ = var_0_1.decode(var_25_0)

	arg_25_0:ApplyTmpChanges()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.controlGroupsData_.groups) do
		local var_25_1 = ""
		local var_25_2 = arg_25_0.bindings_[iter_25_1.controlType]

		var_25_2:SetData(arg_25_0.layoutName_, var_25_1, iter_25_1, arg_25_0.gamepadType_)
		var_25_2:RefreshUI()
	end

	arg_25_0:RebuildUILayout()
end

function var_0_0.StopRebuildTimer(arg_26_0)
	if arg_26_0.timerRebuild_ then
		arg_26_0.timerRebuild_:Stop()

		arg_26_0.timerRebuild_ = nil
	end
end

function var_0_0.ApplyTmpChanges(arg_27_0)
	if #arg_27_0.keysChangeInfo_ <= 0 then
		return
	end

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.controlGroupsData_.groups) do
		local var_27_1 = {}

		for iter_27_2, iter_27_3 in ipairs(iter_27_1.items) do
			var_27_1[iter_27_3.buttonInt] = iter_27_3
		end

		var_27_0[iter_27_1.controlType] = var_27_1
	end

	for iter_27_4, iter_27_5 in ipairs(arg_27_0.keysChangeInfo_) do
		if iter_27_5.layoutName == arg_27_0.layoutName_ then
			local var_27_2 = var_27_0[iter_27_5.controlType]

			if var_27_2 then
				local var_27_3 = var_27_2[iter_27_5.buttonInt]

				if var_27_3 then
					var_27_3.keyName = iter_27_5.keyName
				end
			end
		end
	end
end

function var_0_0.RebuildUILayout(arg_28_0)
	arg_28_0:StopRebuildTimer()

	arg_28_0.timerData_counter = 0
	arg_28_0.timerRebuild_ = FrameTimer.New(function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_0.contentTrans_)

		arg_28_0.timerData_counter = arg_28_0.timerData_counter + 1

		if arg_28_0.timerData_counter == 3 then
			arg_28_0:StopRebuildTimer()
		end
	end, 1, 3)

	arg_28_0.timerRebuild_:Start()
end

function var_0_0.RefreshHIDToggles(arg_30_0)
	arg_30_0:SwitchToHID(arg_30_0.gamepadType_)

	arg_30_0.gamepadToggle_.isOn = arg_30_0.gamepadEnable_
	arg_30_0.autoHideToggle_.isOn = LuaForCursor.GetKeyboardAutoHide()
	arg_30_0.holdGamepadToggle_.isOn = LuaHidTools.IsKeepJoystickType()
	arg_30_0.battleCursorToggle_.isOn = LuaForCursor.GetBattleShowCursor()
end

function var_0_0.RefreshSlider(arg_31_0)
	local var_31_0 = arg_31_0.gamepadType_ == HID_TYPES.Xbox or arg_31_0.gamepadType_ == HID_TYPES.PS4

	SetActive(arg_31_0.cursorSenGo_, var_31_0 and arg_31_0.gamepadEnable_)

	if not var_31_0 then
		return
	end

	if arg_31_0.oldCursorSensitivity[arg_31_0.gamepadType_] == nil then
		local var_31_1 = LuaForGamepad.GetCursorSensitivity(arg_31_0.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(arg_31_0.layoutName_))

		arg_31_0.oldCursorSensitivity[arg_31_0.gamepadType_] = var_31_1
	end

	if arg_31_0.cursorSensitivity[arg_31_0.gamepadType_] == nil then
		arg_31_0.cursorSensitivity[arg_31_0.gamepadType_] = arg_31_0.oldCursorSensitivity[arg_31_0.gamepadType_]
	end

	arg_31_0.cursorSenSlider_.value = arg_31_0.cursorSensitivity[arg_31_0.gamepadType_]
end

function var_0_0.SwitchToHID(arg_32_0, arg_32_1)
	if arg_32_1 == HID_TYPES.Keyboard or arg_32_1 == HID_TYPES.KeyMouse then
		local var_32_0 = GameToSDK.IsEditorOrPcPlatform()

		arg_32_0.hidTypeCon_:SetSelectedState(var_32_0 and "keyboard" or "keyboard_mobile")
	elseif arg_32_1 == HID_TYPES.Xbox or arg_32_1 == HID_TYPES.PS4 then
		arg_32_0.hidTypeCon_:SetSelectedState("gamepad")
	else
		arg_32_0.hidTypeCon_:SetSelectedState("none")
	end

	arg_32_0:SetHidType(arg_32_1)
	arg_32_0:RefreshSlider()
	arg_32_0:RefreshRemapNoticeToggle()
	arg_32_0:RefreshControlTypeName()
	arg_32_0:RefreshBindingUI()
	arg_32_0:UpdateBindingVisibility()
end

function var_0_0.SwitchBindingVisibility(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.bindings_) do
		if arg_33_1 then
			local var_33_0 = arg_33_0.controlGroupsData_.groups[iter_33_0]

			SetActive(iter_33_1.gameObject_, var_33_0 and #var_33_0.items > 0)
		else
			SetActive(iter_33_1.gameObject_, false)
		end
	end
end

function var_0_0.UpdateBindingVisibility(arg_34_0)
	local var_34_0 = arg_34_0.gamepadType_

	SetActive(arg_34_0.autoHideGo_, var_34_0 == HID_TYPES.Keyboard)

	if var_34_0 == HID_TYPES.Keyboard or var_34_0 == HID_TYPES.KeyMouse then
		arg_34_0:SwitchBindingVisibility(true)
		SetActive(arg_34_0.remapNoticeGo_, true)
	elseif var_34_0 == HID_TYPES.Xbox or var_34_0 == HID_TYPES.PS4 then
		arg_34_0:SwitchBindingVisibility(arg_34_0.gamepadEnable_)
		SetActive(arg_34_0.gamepadGo_, arg_34_0.gamepadEnable_)
		SetActive(arg_34_0.remapNoticeGo_, arg_34_0.gamepadEnable_)
	else
		arg_34_0:SwitchBindingVisibility(false)
	end
end

function var_0_0.OnKeyChanged(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = true

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.controlGroupsData_.groups) do
		if iter_35_1.conflictGroup == arg_35_3.conflictGroup then
			for iter_35_2, iter_35_3 in ipairs(iter_35_1.items) do
				if iter_35_3.keyName == arg_35_3.keyName and iter_35_3.buttonInt ~= arg_35_3.buttonInt then
					var_35_0 = false

					if LuaHidTools.IsOpNotAllow(arg_35_0.gamepadType_, iter_35_3.buttonName) then
						local var_35_1 = GetTipsF("INPUT_KEY_NOT_ALLOW", GetKeyCodeMappedName(arg_35_3.keyName))

						ShowTips(var_35_1)
						arg_35_2:StartListeningNewKey()

						return
					end

					local function var_35_2(arg_36_0)
						if not arg_36_0 then
							arg_35_2:StartListeningNewKey()

							return
						end

						arg_35_0:AddKeyChangeInfo({
							conflictGroup = iter_35_1.conflictGroup,
							controlType = iter_35_1.controlType,
							layoutName = arg_35_0.layoutName_,
							buttonInt = iter_35_3.buttonInt,
							key = arg_35_3.oldKey,
							keyName = arg_35_3.oldKeyName
						})
						arg_35_0:AddKeyChangeInfo(arg_35_3)
						arg_35_0:RefreshBindingUI()
					end

					JumpTools.Back()
					arg_35_0:Go("gameKeyConflict", {
						listenCallback = var_35_2,
						opName = arg_35_3.buttonName,
						conflictOpName = iter_35_3.buttonName,
						key = arg_35_3.key,
						keyName = arg_35_3.keyName,
						gamepadType = arg_35_0.gamepadType_
					})

					return
				end
			end
		end
	end

	if var_35_0 then
		arg_35_0:AddKeyChangeInfo(arg_35_3)
		arg_35_0:RefreshBindingUI()
	end

	JumpTools.Back()
end

function var_0_0.AddKeyChangeInfo(arg_37_0, arg_37_1)
	arg_37_0:RemoveChangesIf(function(arg_38_0)
		return arg_38_0.conflictGroup == arg_37_1.conflictGroup and arg_38_0.buttonInt == arg_37_1.buttonInt
	end)
	table.insert(arg_37_0.keysChangeInfo_, arg_37_1)
end

function var_0_0.RemoveChangesIf(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.keysChangeInfo_) do
		if arg_39_1(iter_39_1) then
			table.insert(var_39_0, iter_39_1)
		end
	end

	for iter_39_2, iter_39_3 in ipairs(var_39_0) do
		table.removebyvalue(arg_39_0.keysChangeInfo_, iter_39_3)
	end
end

function var_0_0.SaveData(arg_40_0)
	local var_40_0 = P08.Gamepad.En_ButtonType.Special_CampSkill:ToInt()

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.keysChangeInfo_) do
		if iter_40_1.buttonInt == var_40_0 then
			LuaForGamepad.SetLayoutItem(iter_40_1.layoutName, LuaForGamepad.GetDefaultLayoutFileName(iter_40_1.layoutName), P08.Gamepad.En_ButtonType.MasterSkill:ToInt(), iter_40_1.key)
		end

		LuaForGamepad.SetLayoutItem(iter_40_1.layoutName, LuaForGamepad.GetDefaultLayoutFileName(iter_40_1.layoutName), iter_40_1.buttonInt, iter_40_1.key)
	end

	for iter_40_2, iter_40_3 in pairs(arg_40_0.cursorSensitivity) do
		local var_40_1 = arg_40_0:GetLayoutName(iter_40_2)

		LuaForGamepad.SetCursorSensitivity(var_40_1, LuaForGamepad.GetDefaultLayoutFileName(var_40_1), iter_40_3)
	end

	arg_40_0:SendSDK()
	LuaForGamepad.ReloadLayout()

	arg_40_0.keysChangeInfo_ = {}

	local var_40_2 = arg_40_0:GetRemapNotice()

	arg_40_0.oldGamepadType_ = arg_40_0.gamepadType_
	arg_40_0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(arg_40_0.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(arg_40_0.layoutName_))

	LuaForGamepad.SetDeviceEnable(HID_TYPES.Xbox, arg_40_0.gamepadEnable_)
	LuaForGamepad.SetDeviceEnable(HID_TYPES.PS4, arg_40_0.gamepadEnable_)

	arg_40_0.oldGamepadEnable_ = arg_40_0.gamepadEnable_
	arg_40_0.oldHoldGamePadToggle_ = nil
	arg_40_0.oldBattleCursorToggle_ = nil
	arg_40_0.cursorSensitivity = {}
	arg_40_0.oldCursorSensitivity = {}

	arg_40_0:RefreshHIDToggles()

	for iter_40_4, iter_40_5 in pairs(arg_40_0.remapNotice_) do
		LuaHidTools.SetRemapNotice(iter_40_4, iter_40_5)
	end

	arg_40_0.remapNotice_ = {}
	arg_40_0.oldRemapNotice_ = {}
	arg_40_0.remapNoticeToggle_.isOn = var_40_2

	arg_40_0:NotifyKeyChange()
end

function var_0_0.RecoverTmpData(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.oldCursorSensitivity) do
		local var_41_0 = arg_41_0:GetLayoutName(iter_41_0)

		LuaForGamepad.SetCursorSensitivity(var_41_0, LuaForGamepad.GetDefaultLayoutFileName(var_41_0), iter_41_1)
	end

	arg_41_0.keysChangeInfo_ = {}
	arg_41_0.gamepadType_ = arg_41_0.oldGamepadType_
	arg_41_0.layoutName_ = arg_41_0:GetLayoutName(arg_41_0.gamepadType_)
	arg_41_0.holdGamepadToggle_.isOn = arg_41_0.oldHoldGamePadToggle_
	arg_41_0.battleCursorToggle_.isOn = arg_41_0.oldBattleCursorToggle_
	arg_41_0.gamepadEnable_ = arg_41_0.oldGamepadEnable_
	arg_41_0.cursorSensitivity = {}

	arg_41_0:RefreshHIDToggles()

	for iter_41_2, iter_41_3 in pairs(arg_41_0.oldRemapNotice_) do
		LuaHidTools.SetRemapNotice(iter_41_2, iter_41_3)
	end

	arg_41_0.remapNotice_ = {}
	arg_41_0.oldRemapNotice_ = {}

	arg_41_0:RefreshRemapNoticeToggle()
end

function var_0_0.ResetDefaultData(arg_42_0)
	LuaForGamepad.DeleteLayoutJson(arg_42_0.layoutName_)
	LuaForGamepad.ReloadLayout()
	LuaForGamepad.SetDeviceEnable(HID_TYPES.Xbox, true)
	LuaForGamepad.SetDeviceEnable(HID_TYPES.PS4, true)

	arg_42_0.gamepadToggle_.isOn = true
	arg_42_0.oldHoldGamePadToggle_ = nil
	arg_42_0.oldBattleCursorToggle_ = nil
	arg_42_0.holdGamepadToggle_.isOn = false
	arg_42_0.battleCursorToggle_.isOn = true
	arg_42_0.keysChangeInfo_ = {}
	arg_42_0.cursorSensitivity = {}
	arg_42_0.oldCursorSensitivity = {}

	arg_42_0:RefreshSlider()
	arg_42_0:RefreshBindingUI()

	arg_42_0.remapNotice_ = {}
	arg_42_0.oldRemapNotice_ = {}

	LuaHidTools.ResetRemapNotice()
	arg_42_0:RefreshRemapNoticeToggle()
	arg_42_0:NotifyKeyChange()
end

function var_0_0.CheckDataChange(arg_43_0)
	local var_43_0 = arg_43_0.cursorSensitivity[HID_TYPES.Xbox] ~= arg_43_0.oldCursorSensitivity[HID_TYPES.Xbox] or arg_43_0.cursorSensitivity[HID_TYPES.PS4] ~= arg_43_0.oldCursorSensitivity[HID_TYPES.PS4]
	local var_43_1 = arg_43_0.remapNotice_[HID_TYPES.Keyboard] ~= arg_43_0.oldRemapNotice_[HID_TYPES.Keyboard] or arg_43_0.remapNotice_[HID_TYPES.KeyMouse] ~= arg_43_0.oldRemapNotice_[HID_TYPES.KeyMouse] or arg_43_0.remapNotice_[HID_TYPES.Xbox] ~= arg_43_0.oldRemapNotice_[HID_TYPES.Xbox] or arg_43_0.remapNotice_[HID_TYPES.PS4] ~= arg_43_0.oldRemapNotice_[HID_TYPES.PS4]

	return #arg_43_0.keysChangeInfo_ > 0 or arg_43_0.gamepadEnable_ ~= arg_43_0.oldGamepadEnable_ or var_43_1 or var_43_0 or arg_43_0.oldHoldGamePadToggle_ ~= nil or arg_43_0.oldBattleCursorToggle_ ~= nil
end

function var_0_0.SetRemapNotice(arg_44_0, arg_44_1)
	arg_44_0.remapToggleCon_:SetSelectedState(arg_44_1 and "on" or "off")

	if arg_44_0.gamepadType_ == HID_TYPES.Xbox or arg_44_0.gamepadType_ == HID_TYPES.PS4 then
		arg_44_0.remapNotice_[HID_TYPES.Xbox] = arg_44_1
		arg_44_0.remapNotice_[HID_TYPES.PS4] = arg_44_1

		LuaHidTools.SetRemapNotice(HID_TYPES.Xbox, arg_44_1)
		LuaHidTools.SetRemapNotice(HID_TYPES.PS4, arg_44_1)
	elseif arg_44_0.gamepadType_ == HID_TYPES.Keyboard or arg_44_0.gamepadType_ == HID_TYPES.KeyMouse then
		arg_44_0.remapNotice_[HID_TYPES.Keyboard] = arg_44_1
		arg_44_0.remapNotice_[HID_TYPES.KeyMouse] = arg_44_1

		LuaHidTools.SetRemapNotice(HID_TYPES.Keyboard, arg_44_1)
		LuaHidTools.SetRemapNotice(HID_TYPES.KeyMouse, arg_44_1)
	end
end

function var_0_0.GetRemapNotice(arg_45_0)
	local var_45_0 = LuaHidTools.GetRemapNotice(arg_45_0.gamepadType_)

	if arg_45_0.oldRemapNotice_[arg_45_0.gamepadType_] == nil then
		if arg_45_0.gamepadType_ == HID_TYPES.Xbox or arg_45_0.gamepadType_ == HID_TYPES.PS4 then
			arg_45_0.oldRemapNotice_[HID_TYPES.Xbox] = var_45_0
			arg_45_0.oldRemapNotice_[HID_TYPES.PS4] = var_45_0
		elseif arg_45_0.gamepadType_ == HID_TYPES.Keyboard or arg_45_0.gamepadType_ == HID_TYPES.KeyMouse then
			arg_45_0.oldRemapNotice_[HID_TYPES.Keyboard] = var_45_0
			arg_45_0.oldRemapNotice_[HID_TYPES.KeyMouse] = var_45_0
		end
	end

	return var_45_0
end

function var_0_0.RefreshRemapNoticeToggle(arg_46_0)
	arg_46_0.remapNoticeToggle_.isOn = arg_46_0:GetRemapNotice()
end

function var_0_0.IsJoystickEnable(arg_47_0)
	local var_47_0 = LuaHidTools.GetPlayerSelectJoystick()

	return LuaForGamepad.IsDeviceEnable(var_47_0)
end

function var_0_0.NotifyKeyChange(arg_48_0)
	if not arg_48_0.remapNoticeToggle_.isOn then
		return
	end

	LuaHidTools.SetRemapNotice(arg_48_0.gamepadType_, false)
	FrameTimer.New(function()
		LuaHidTools.SetRemapNotice(arg_48_0.gamepadType_, true)
	end, 1, 1):Start()
end

function var_0_0.RefreshBattleUIName(arg_50_0)
	local var_50_0 = ""
	local var_50_1 = SettingData:GetBattleUISettingData()

	if var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_0 then
		var_50_0 = GetTips("BATTLE_UI_DEFAULT_PRESET")
	elseif var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_1 then
		var_50_0 = string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 1)
	elseif var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_2 then
		var_50_0 = string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 2)
	elseif var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_3 then
		var_50_0 = string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 3)
	else
		var_50_0 = GetTips("BATTLE_UI_DEFAULT_PRESET")
	end

	arg_50_0.battleUiText_.text = var_50_0
end

function var_0_0.RefreshGamepadName(arg_51_0)
	local var_51_0 = LuaHidTools.GetPlayerSelectJoystick() == HID_TYPES.Xbox and 2 or 1

	arg_51_0.gamepadSelText_.text = GetTips("GAMEPAD_ICON_PATTERN_" .. var_51_0)
end

function var_0_0.RefreshKeyboardName(arg_52_0)
	local var_52_0

	var_52_0 = LuaHidTools.GetPlayerSelectKeyboard() == HID_TYPES.KeyMouse and 2 or 1
end

function var_0_0.RefreshControlTypeName(arg_53_0)
	local var_53_0 = arg_53_0.gamepadType_

	if var_53_0 == HID_TYPES.Keyboard or var_53_0 == HID_TYPES.KeyMouse then
		arg_53_0:RefreshKeyboardName()
	elseif var_53_0 == HID_TYPES.Xbox or var_53_0 == HID_TYPES.PS4 then
		arg_53_0:RefreshGamepadName()
	end
end

function var_0_0.OnJoystickTypeSelect(arg_54_0, arg_54_1)
	arg_54_0:RefreshControlTypeName()
	arg_54_0:SwitchToHID(arg_54_1)

	arg_54_0.holdGamepadToggle_.isOn = LuaHidTools.IsKeepJoystickType()
end

function var_0_0.SetHidType(arg_55_0, arg_55_1)
	arg_55_0.gamepadType_ = arg_55_1
	arg_55_0.layoutName_ = arg_55_0:GetLayoutName(arg_55_0.gamepadType_)
end

function var_0_0.GetLayoutName(arg_56_0, arg_56_1)
	if arg_56_1 == HID_TYPES.Keyboard then
		return var_0_2.Keyboard
	elseif arg_56_1 == HID_TYPES.KeyMouse then
		return var_0_2.KeyMouse
	elseif arg_56_1 == HID_TYPES.Xbox then
		return var_0_2.Xbox
	elseif arg_56_1 == HID_TYPES.PS4 then
		return var_0_2.PS
	else
		return var_0_2.Other
	end
end

function var_0_0.SendSDK(arg_57_0)
	if not GameToSDK.IsEditorOrPcPlatform() then
		return
	end

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_0.keysChangeInfo_) do
		local var_57_1 = var_57_0[iter_57_1.layoutName]

		if not var_57_1 then
			var_57_1 = {}
			var_57_0[iter_57_1.layoutName] = var_57_1
		end

		table.insert(var_57_1, {
			buttonType = tostring(iter_57_1.buttonInt),
			value = iter_57_1.key
		})
	end

	local var_57_2 = {
		HID_TYPES.Keyboard,
		HID_TYPES.Xbox,
		HID_TYPES.PS4,
		HID_TYPES.KeyMouse
	}

	for iter_57_2, iter_57_3 in ipairs(var_57_2) do
		local var_57_3 = var_57_0[arg_57_0:GetLayoutName(iter_57_3)]

		if var_57_3 then
			local var_57_4 = iter_57_3

			if var_57_4 > HID_TYPES.Other then
				var_57_4 = var_57_4 - 1
			end

			SDKTools.SendMessageToSDK("keymap_setting", {
				type = var_57_4,
				other_arrayobject = var_57_3
			})
		end
	end
end

return var_0_0
