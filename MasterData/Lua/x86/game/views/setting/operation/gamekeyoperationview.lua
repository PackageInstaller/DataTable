local GameKeyOperationView = class("GameKeyOperationView", ReduxView)
local cjson = require("cjson")
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

function GameKeyOperationView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		self.scrollView_.verticalNormalizedPosition = 1
	end
end

function GameKeyOperationView:OnCtor(arg_2_1, arg_2_2, arg_2_3)
	self.gameObject_ = arg_2_2
	self.transform_ = arg_2_2.transform
	self.settingView_ = arg_2_1
	self.params_ = arg_2_3

	self:Init()
	self:OnEnter()
end

function GameKeyOperationView:Init()
	self:InitUI()
	self:AddUIListener()

	self.keysChangeInfo_ = {}
	self.cursorSensitivity = {}
	self.remapNotice_ = {}
	self.oldRemapNotice_ = {}

	self:InitDropdownData()
end

function GameKeyOperationView:InitUI()
	self:BindCfgUI()

	self.bindings_ = {}
	self.bindings_[CONTROL_TYPES.Move] = GameKeyBindingContent.New(self.moveBindingGo_)
	self.bindings_[CONTROL_TYPES.View] = GameKeyBindingContent.New(self.viewBindingGo_)
	self.bindings_[CONTROL_TYPES.SubJoystick] = GameKeyBindingContent.New(self.subJoyBindingGo_)
	self.bindings_[CONTROL_TYPES.Battle] = GameKeyBindingContent.New(self.battleBindingGo_)
	self.bindings_[CONTROL_TYPES.Operation] = GameKeyBindingContent.New(self.operBindingGo_)
	self.bindings_[CONTROL_TYPES.System] = GameKeyBindingContent.New(self.sysBindingGo_)
	self.bindings_[CONTROL_TYPES.MiniGame] = GameKeyBindingContent.New(self.miniGameBindingGo_)
	self.bindings_[CONTROL_TYPES.SandPlay] = GameKeyBindingContent.New(self.sandPlayBindingGo_)

	for iter_4_0, iter_4_1 in pairs(self.bindings_) do
		iter_4_1:SetKeyChangedCallback(function(arg_5_0, arg_5_1, arg_5_2)
			self:OnKeyChanged(arg_5_0, arg_5_1, arg_5_2, iter_4_0)
		end)
	end

	self:RegistEventListener(BATTLE_UI_ADJUSTED, handler(self, self.RefreshBattleUIName))
	self:RegistEventListener(JOYSTICK_TYPE_SELECT, handler(self, self.OnJoystickTypeSelect))

	self.remapToggleCon_ = self.remapToggleConEx_:GetController("default0")
	self.gamepadToggleCon_ = self.gamepadToggleConEx_:GetController("default0")
	self.autoHideToggleCon_ = self.autoHideToggleConEx_:GetController("default0")
	self.holdGamepadCon_ = self.holdGamepadConEx_:GetController("default0")
	self.battleCursorCon_ = self.battleCursorConEx_:GetController("default0")
	self.hidTypeCon_ = self.controllerEx_:GetController("hidType")
end

function GameKeyOperationView:AddUIListener()
	self:AddBtnListener(self.keyboardBtn_, nil, function()
		local var_7_0 = LuaHidTools.GetPlayerSelectKeyboard()

		self:SwitchToHID((var_7_0 == 0 or nil) and (HID_TYPES.KeyMouse or var_7_0))
	end)
	self:AddBtnListener(self.gamepadBtn_, nil, function(arg_8_0)
		local var_8_0 = LuaHidTools.GetPlayerSelectJoystick()

		self:SwitchToHID((var_8_0 == 0 or nil) and (HID_TYPES.Xbox or var_8_0))
	end)
	self:AddBtnListener(self.gamepadSelBtn_, nil, function(arg_9_0)
		LuaHidTools.OpenGamepadSelectWin((LuaHidTools.GetPlayerSelectJoystick()))
	end)
	self:AddToggleListener(self.keyboardDropdown_, function(arg_10_0)
		self:SwitchToHID((arg_10_0 == 0 or nil) and (HID_TYPES.Keyboard or HID_TYPES.KeyMouse))
		LuaHidTools.SetPlayerSelectKeyboard(self.gamepadType_)
		self:RefreshControlTypeName()
	end)
	self:AddToggleListener(self.gamepadToggle_, function(arg_11_0)
		self.gamepadEnable_ = arg_11_0

		self.gamepadToggleCon_:SetSelectedState(arg_11_0 and "on" or "off")
		self:RefreshSlider()
		self:UpdateBindingVisibility()

		if arg_11_0 then
			self:RebuildUILayout()
		else
			self.remapNoticeToggle_.isOn = false
		end
	end)
	self:AddToggleListener(self.remapNoticeToggle_, function(arg_12_0)
		self:SetRemapNotice(arg_12_0)
	end)
	self:AddToggleListener(self.autoHideToggle_, function(arg_13_0)
		LuaForCursor.SetKeyboardAutoHide(arg_13_0)
		self.autoHideToggleCon_:SetSelectedState(arg_13_0 and "on" or "off")
		self:RefreshHIDToggles()
	end)
	self:AddToggleListener(self.holdGamepadToggle_, function(arg_14_0)
		LuaHidTools.SetIsKeepJoystickType(arg_14_0)
		self.holdGamepadCon_:SetSelectedState(arg_14_0 and "on" or "off")
		self:RefreshHIDToggles()
	end)
	self:AddToggleListener(self.battleCursorToggle_, function(arg_15_0)
		LuaForCursor.SetBattleShowCursor(arg_15_0)
		self.battleCursorCon_:SetSelectedState(arg_15_0 and "on" or "off")
		self:RefreshHIDToggles()
	end)
	self:AddBtnListener(self.battleUiAdjBtn_, nil, function()
		self:Go("battleUIAdjust", {})
	end)
	self.cursorSenSlider_.onValueChanged:AddListener(function(arg_17_0)
		self.cursorSensitivity[self.gamepadType_] = arg_17_0

		local var_17_0 = self:GetLayoutName(self.gamepadType_)

		LuaForGamepad.SetCursorSensitivity(var_17_0, LuaForGamepad.GetDefaultLayoutFileName(var_17_0), arg_17_0)
	end)
	self:AddPressingByTimeListener(self.cursorSenSubGo_, 3, 0.5, 0.5, function()
		if self.cursorSenSlider_.value > 0 then
			self.cursorSenSlider_.value = self.cursorSenSlider_.value - 1

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.cursorSenAddGo_, 3, 0.5, 0.5, function()
		if self.cursorSenSlider_.value < 100 then
			self.cursorSenSlider_.value = self.cursorSenSlider_.value + 1

			return true
		end

		return false
	end)
end

function GameKeyOperationView:OnEnter()
	self.keysChangeInfo_ = {}
	self.gamepadType_ = LuaForGamepad.GetGamepadType()

	if self.gamepadType_ == HID_TYPES.None then
		self.gamepadType_ = HID_TYPES.Keyboard
	end

	self.layoutName_ = self:GetLayoutName(self.gamepadType_)
	self.gamepadEnable_ = self:IsJoystickEnable()
	self.oldGamepadEnable_ = self.gamepadEnable_
	self.oldGamepadType_ = self.gamepadType_
	self.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(self.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(self.layoutName_))
	self.oldCursorSensitivity = {}

	self:RefreshHIDToggles()

	self.oldHoldGamePadToggle_ = self.holdGamepadToggle_.isOn
	self.oldBattleCursorToggle_ = self.battleCursorToggle_.isOn

	self:RefreshUI()
end

function GameKeyOperationView:InitDropdownData()
	self.keyboardDropdown_.options:Clear()

	for iter_21_0, iter_21_1 in ipairs({
		"KEYBOARD_CONTROL_MODE_1",
		"KEYBOARD_CONTROL_MODE_2"
	}) do
		self.keyboardDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips(iter_21_1), nil))
	end

	self.keyboardDropdown_:RefreshShownValue()

	self.keyboardDropdown_.value = (LuaHidTools.GetPlayerSelectKeyboard() == HID_TYPES.Keyboard and 1 or 2) - 1
end

function GameKeyOperationView:OnExit()
	for iter_22_0, iter_22_1 in pairs(self.bindings_) do
		iter_22_1:OnExit()
	end

	self:StopRebuildTimer()
end

function GameKeyOperationView:Dispose()
	for iter_23_0, iter_23_1 in pairs(self.bindings_) do
		iter_23_1:Dispose()
	end

	GameKeyOperationView.super.Dispose(self)
end

function GameKeyOperationView:RefreshUI()
	self:RefreshBattleUIName()
	self:RefreshControlTypeName()
	self:RefreshRemapNoticeToggle()

	self.holdGamepadText_.text = GetTips("GAMEPAD_HOLD_SELECTION")
end

function GameKeyOperationView:RefreshBindingUI()
	self.controlGroupsData_ = cjson.decode((LuaForGamepad.GetLayoutControlGroups(self.layoutName_)))

	self:ApplyTmpChanges()

	for iter_25_0, iter_25_1 in ipairs(self.controlGroupsData_.groups) do
		self.bindings_[iter_25_1.controlType]:SetData(self.layoutName_, "", iter_25_1, self.gamepadType_)
		self.bindings_[iter_25_1.controlType]:RefreshUI()
	end

	self:RebuildUILayout()
end

function GameKeyOperationView:StopRebuildTimer()
	if self.timerRebuild_ then
		self.timerRebuild_:Stop()

		self.timerRebuild_ = nil
	end
end

function GameKeyOperationView:ApplyTmpChanges()
	if #self.keysChangeInfo_ <= 0 then
		return
	end

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(self.controlGroupsData_.groups) do
		local var_27_1 = {}

		for iter_27_2, iter_27_3 in ipairs(iter_27_1.items) do
			var_27_1[iter_27_3.buttonInt] = iter_27_3
		end

		var_27_0[iter_27_1.controlType] = var_27_1
	end

	for iter_27_4, iter_27_5 in ipairs(self.keysChangeInfo_) do
		if iter_27_5.layoutName == self.layoutName_ then
			if var_27_0[iter_27_5.controlType] then
				if var_27_0[iter_27_5.controlType][iter_27_5.buttonInt] then
					var_27_0[iter_27_5.controlType][iter_27_5.buttonInt].keyName = iter_27_5.keyName
				end
			end
		end
	end
end

function GameKeyOperationView:RebuildUILayout()
	self:StopRebuildTimer()

	self.timerData_counter = 0
	self.timerRebuild_ = FrameTimer.New(function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

		self.timerData_counter = self.timerData_counter + 1

		if self.timerData_counter == 3 then
			self:StopRebuildTimer()
		end
	end, 1, 3)

	self.timerRebuild_:Start()
end

function GameKeyOperationView:RefreshHIDToggles()
	self:SwitchToHID(self.gamepadType_)

	self.gamepadToggle_.isOn = self.gamepadEnable_
	self.autoHideToggle_.isOn = LuaForCursor.GetKeyboardAutoHide()
	self.holdGamepadToggle_.isOn = LuaHidTools.IsKeepJoystickType()
	self.battleCursorToggle_.isOn = LuaForCursor.GetBattleShowCursor()
end

function GameKeyOperationView:RefreshSlider()
	local var_31_0 = self.gamepadType_ == HID_TYPES.Xbox or self.gamepadType_ == HID_TYPES.PS4

	SetActive(self.cursorSenGo_, (self.gamepadType_ == HID_TYPES.Xbox or self.gamepadType_ == HID_TYPES.PS4) and self.gamepadEnable_)

	if not var_31_0 then
		return
	end

	if self.oldCursorSensitivity[self.gamepadType_] == nil then
		self.oldCursorSensitivity[self.gamepadType_] = LuaForGamepad.GetCursorSensitivity(self.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(self.layoutName_))
	end

	if self.cursorSensitivity[self.gamepadType_] == nil then
		self.cursorSensitivity[self.gamepadType_] = self.oldCursorSensitivity[self.gamepadType_]
	end

	self.cursorSenSlider_.value = self.cursorSensitivity[self.gamepadType_]
end

function GameKeyOperationView:SwitchToHID(arg_32_1)
	if arg_32_1 == HID_TYPES.Keyboard or arg_32_1 == HID_TYPES.KeyMouse then
		self.hidTypeCon_:SetSelectedState(GameToSDK.IsEditorOrPcPlatform() and "keyboard" or "keyboard_mobile")
	elseif arg_32_1 == HID_TYPES.Xbox or arg_32_1 == HID_TYPES.PS4 then
		self.hidTypeCon_:SetSelectedState("gamepad")
	else
		self.hidTypeCon_:SetSelectedState("none")
	end

	self:SetHidType(arg_32_1)
	self:RefreshSlider()
	self:RefreshRemapNoticeToggle()
	self:RefreshControlTypeName()
	self:RefreshBindingUI()
	self:UpdateBindingVisibility()
end

function GameKeyOperationView:SwitchBindingVisibility(arg_33_1)
	for iter_33_0, iter_33_1 in pairs(self.bindings_) do
		if arg_33_1 then
			SetActive(iter_33_1.gameObject_, self.controlGroupsData_.groups[iter_33_0] and #self.controlGroupsData_.groups[iter_33_0].items > 0)
		else
			SetActive(iter_33_1.gameObject_, false)
		end
	end
end

function GameKeyOperationView:UpdateBindingVisibility()
	SetActive(self.autoHideGo_, self.gamepadType_ == HID_TYPES.Keyboard)

	if self.gamepadType_ == HID_TYPES.Keyboard or self.gamepadType_ == HID_TYPES.KeyMouse then
		self:SwitchBindingVisibility(true)
		SetActive(self.remapNoticeGo_, true)
	elseif self.gamepadType_ == HID_TYPES.Xbox or self.gamepadType_ == HID_TYPES.PS4 then
		self:SwitchBindingVisibility(self.gamepadEnable_)
		SetActive(self.gamepadGo_, self.gamepadEnable_)
		SetActive(self.remapNoticeGo_, self.gamepadEnable_)
	else
		self:SwitchBindingVisibility(false)
	end
end

function GameKeyOperationView:OnKeyChanged(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = true

	for iter_35_0, iter_35_1 in ipairs(self.controlGroupsData_.groups) do
		if iter_35_1.conflictGroup == arg_35_3.conflictGroup then
			for iter_35_2, iter_35_3 in ipairs(iter_35_1.items) do
				if iter_35_3.keyName == arg_35_3.keyName and iter_35_3.buttonInt ~= arg_35_3.buttonInt then
					var_35_0 = false

					if LuaHidTools.IsOpNotAllow(self.gamepadType_, iter_35_3.buttonName) then
						ShowTips((GetTipsF("INPUT_KEY_NOT_ALLOW", GetKeyCodeMappedName(arg_35_3.keyName))))
						arg_35_2:StartListeningNewKey()

						return
					end

					local function var_35_1(arg_36_0)
						if not arg_36_0 then
							arg_35_2:StartListeningNewKey()

							return
						end

						self:AddKeyChangeInfo({
							conflictGroup = iter_35_1.conflictGroup,
							controlType = iter_35_1.controlType,
							layoutName = self.layoutName_,
							buttonInt = iter_35_3.buttonInt,
							key = arg_35_3.oldKey,
							keyName = arg_35_3.oldKeyName
						})
						self:AddKeyChangeInfo(arg_35_3)
						self:RefreshBindingUI()
					end

					JumpTools.Back()
					self:Go("gameKeyConflict", {
						listenCallback = var_35_1,
						opName = arg_35_3.buttonName,
						conflictOpName = iter_35_3.buttonName,
						key = arg_35_3.key,
						keyName = arg_35_3.keyName,
						gamepadType = self.gamepadType_
					})

					return
				end
			end
		end
	end

	if var_35_0 then
		self:AddKeyChangeInfo(arg_35_3)
		self:RefreshBindingUI()
	end

	JumpTools.Back()
end

function GameKeyOperationView:AddKeyChangeInfo(arg_37_1)
	self:RemoveChangesIf(function(arg_38_0)
		return arg_38_0.conflictGroup == arg_37_1.conflictGroup and arg_38_0.buttonInt == arg_37_1.buttonInt
	end)
	table.insert(self.keysChangeInfo_, arg_37_1)
end

function GameKeyOperationView:RemoveChangesIf(arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(self.keysChangeInfo_) do
		if arg_39_1(iter_39_1) then
			table.insert(var_39_0, iter_39_1)
		end
	end

	for iter_39_2, iter_39_3 in ipairs(var_39_0) do
		table.removebyvalue(self.keysChangeInfo_, iter_39_3)
	end
end

function GameKeyOperationView:SaveData()
	local var_40_0 = P08.Gamepad.En_ButtonType.Special_CampSkill:ToInt()

	for iter_40_0, iter_40_1 in ipairs(self.keysChangeInfo_) do
		if iter_40_1.buttonInt == var_40_0 then
			LuaForGamepad.SetLayoutItem(iter_40_1.layoutName, LuaForGamepad.GetDefaultLayoutFileName(iter_40_1.layoutName), P08.Gamepad.En_ButtonType.MasterSkill:ToInt(), iter_40_1.key)
		end

		LuaForGamepad.SetLayoutItem(iter_40_1.layoutName, LuaForGamepad.GetDefaultLayoutFileName(iter_40_1.layoutName), iter_40_1.buttonInt, iter_40_1.key)
	end

	for iter_40_2, iter_40_3 in pairs(self.cursorSensitivity) do
		local var_40_1 = self:GetLayoutName(iter_40_2)

		LuaForGamepad.SetCursorSensitivity(var_40_1, LuaForGamepad.GetDefaultLayoutFileName(var_40_1), iter_40_3)
	end

	self:SendSDK()
	LuaForGamepad.ReloadLayout()

	self.keysChangeInfo_ = {}
	self.oldGamepadType_ = self.gamepadType_
	self.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(self.layoutName_, LuaForGamepad.GetDefaultLayoutFileName(self.layoutName_))

	LuaForGamepad.SetDeviceEnable(HID_TYPES.Xbox, self.gamepadEnable_)
	LuaForGamepad.SetDeviceEnable(HID_TYPES.PS4, self.gamepadEnable_)

	self.oldGamepadEnable_ = self.gamepadEnable_
	self.oldHoldGamePadToggle_ = nil
	self.oldBattleCursorToggle_ = nil
	self.cursorSensitivity = {}
	self.oldCursorSensitivity = {}

	self:RefreshHIDToggles()

	for iter_40_4, iter_40_5 in pairs(self.remapNotice_) do
		LuaHidTools.SetRemapNotice(iter_40_4, iter_40_5)
	end

	self.remapNotice_ = {}
	self.oldRemapNotice_ = {}
	self.remapNoticeToggle_.isOn = self:GetRemapNotice()

	self:NotifyKeyChange()
end

function GameKeyOperationView:RecoverTmpData()
	for iter_41_0, iter_41_1 in pairs(self.oldCursorSensitivity) do
		local var_41_0 = self:GetLayoutName(iter_41_0)

		LuaForGamepad.SetCursorSensitivity(var_41_0, LuaForGamepad.GetDefaultLayoutFileName(var_41_0), iter_41_1)
	end

	self.keysChangeInfo_ = {}
	self.gamepadType_ = self.oldGamepadType_
	self.layoutName_ = self:GetLayoutName(self.gamepadType_)
	self.holdGamepadToggle_.isOn = self.oldHoldGamePadToggle_
	self.battleCursorToggle_.isOn = self.oldBattleCursorToggle_
	self.gamepadEnable_ = self.oldGamepadEnable_
	self.cursorSensitivity = {}

	self:RefreshHIDToggles()

	for iter_41_2, iter_41_3 in pairs(self.oldRemapNotice_) do
		LuaHidTools.SetRemapNotice(iter_41_2, iter_41_3)
	end

	self.remapNotice_ = {}
	self.oldRemapNotice_ = {}

	self:RefreshRemapNoticeToggle()
end

function GameKeyOperationView:ResetDefaultData()
	LuaForGamepad.DeleteLayoutJson(self.layoutName_)
	LuaForGamepad.ReloadLayout()
	LuaForGamepad.SetDeviceEnable(HID_TYPES.Xbox, true)
	LuaForGamepad.SetDeviceEnable(HID_TYPES.PS4, true)

	self.gamepadToggle_.isOn = true
	self.oldHoldGamePadToggle_ = nil
	self.oldBattleCursorToggle_ = nil
	self.holdGamepadToggle_.isOn = false
	self.battleCursorToggle_.isOn = true
	self.keysChangeInfo_ = {}
	self.cursorSensitivity = {}
	self.oldCursorSensitivity = {}

	self:RefreshSlider()
	self:RefreshBindingUI()

	self.remapNotice_ = {}
	self.oldRemapNotice_ = {}

	LuaHidTools.ResetRemapNotice()
	self:RefreshRemapNoticeToggle()
	self:NotifyKeyChange()
end

function GameKeyOperationView:CheckDataChange()
	return #self.keysChangeInfo_ > 0 or self.gamepadEnable_ ~= self.oldGamepadEnable_ or self.remapNotice_[HID_TYPES.Keyboard] ~= self.oldRemapNotice_[HID_TYPES.Keyboard] or self.remapNotice_[HID_TYPES.KeyMouse] ~= self.oldRemapNotice_[HID_TYPES.KeyMouse] or self.remapNotice_[HID_TYPES.Xbox] ~= self.oldRemapNotice_[HID_TYPES.Xbox] or self.remapNotice_[HID_TYPES.PS4] ~= self.oldRemapNotice_[HID_TYPES.PS4] or self.cursorSensitivity[HID_TYPES.Xbox] ~= self.oldCursorSensitivity[HID_TYPES.Xbox] or self.cursorSensitivity[HID_TYPES.PS4] ~= self.oldCursorSensitivity[HID_TYPES.PS4] or self.oldHoldGamePadToggle_ ~= nil or self.oldBattleCursorToggle_ ~= nil
end

function GameKeyOperationView:SetRemapNotice(arg_44_1)
	self.remapToggleCon_:SetSelectedState(arg_44_1 and "on" or "off")

	if self.gamepadType_ == HID_TYPES.Xbox or self.gamepadType_ == HID_TYPES.PS4 then
		self.remapNotice_[HID_TYPES.Xbox] = arg_44_1
		self.remapNotice_[HID_TYPES.PS4] = arg_44_1

		LuaHidTools.SetRemapNotice(HID_TYPES.Xbox, arg_44_1)
		LuaHidTools.SetRemapNotice(HID_TYPES.PS4, arg_44_1)
	elseif self.gamepadType_ == HID_TYPES.Keyboard or self.gamepadType_ == HID_TYPES.KeyMouse then
		self.remapNotice_[HID_TYPES.Keyboard] = arg_44_1
		self.remapNotice_[HID_TYPES.KeyMouse] = arg_44_1

		LuaHidTools.SetRemapNotice(HID_TYPES.Keyboard, arg_44_1)
		LuaHidTools.SetRemapNotice(HID_TYPES.KeyMouse, arg_44_1)
	end
end

function GameKeyOperationView:GetRemapNotice()
	local var_45_0 = LuaHidTools.GetRemapNotice(self.gamepadType_)

	if self.oldRemapNotice_[self.gamepadType_] == nil then
		if self.gamepadType_ == HID_TYPES.Xbox or self.gamepadType_ == HID_TYPES.PS4 then
			self.oldRemapNotice_[HID_TYPES.Xbox] = var_45_0
			self.oldRemapNotice_[HID_TYPES.PS4] = var_45_0
		elseif self.gamepadType_ == HID_TYPES.Keyboard or self.gamepadType_ == HID_TYPES.KeyMouse then
			self.oldRemapNotice_[HID_TYPES.Keyboard] = var_45_0
			self.oldRemapNotice_[HID_TYPES.KeyMouse] = var_45_0
		end
	end

	return var_45_0
end

function GameKeyOperationView:RefreshRemapNoticeToggle()
	self.remapNoticeToggle_.isOn = self:GetRemapNotice()
end

function GameKeyOperationView:IsJoystickEnable()
	return LuaForGamepad.IsDeviceEnable((LuaHidTools.GetPlayerSelectJoystick()))
end

function GameKeyOperationView:NotifyKeyChange()
	if not self.remapNoticeToggle_.isOn then
		return
	end

	LuaHidTools.SetRemapNotice(self.gamepadType_, false)
	FrameTimer.New(function()
		LuaHidTools.SetRemapNotice(self.gamepadType_, true)
	end, 1, 1):Start()
end

function GameKeyOperationView:RefreshBattleUIName()
	local var_50_1 = SettingData:GetBattleUISettingData()

	self.battleUiText_.text = var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_0 and GetTips("BATTLE_UI_DEFAULT_PRESET") or var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_1 and string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 1) or var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_2 and string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 2) or var_50_1.battle_ui_cur_type == var_50_1.battle_ui_type_3 and string.format(GetTips("BATTLE_UI_SCHEME_INDEX"), 3) or GetTips("BATTLE_UI_DEFAULT_PRESET")
end

function GameKeyOperationView:RefreshGamepadName()
	self.gamepadSelText_.text = GetTips("GAMEPAD_ICON_PATTERN_" .. (LuaHidTools.GetPlayerSelectJoystick() == HID_TYPES.Xbox and 2 or 1))
end

function GameKeyOperationView:RefreshKeyboardName()
	local var_52_0 = LuaHidTools.GetPlayerSelectKeyboard() == HID_TYPES.KeyMouse and 2 or 1
end

function GameKeyOperationView:RefreshControlTypeName()
	if self.gamepadType_ == HID_TYPES.Keyboard or self.gamepadType_ == HID_TYPES.KeyMouse then
		self:RefreshKeyboardName()
	elseif self.gamepadType_ == HID_TYPES.Xbox or self.gamepadType_ == HID_TYPES.PS4 then
		self:RefreshGamepadName()
	end
end

function GameKeyOperationView:OnJoystickTypeSelect(arg_54_1)
	self:RefreshControlTypeName()
	self:SwitchToHID(arg_54_1)

	self.holdGamepadToggle_.isOn = LuaHidTools.IsKeepJoystickType()
end

function GameKeyOperationView:SetHidType(arg_55_1)
	self.gamepadType_ = arg_55_1
	self.layoutName_ = self:GetLayoutName(self.gamepadType_)
end

function GameKeyOperationView:GetLayoutName(arg_56_1)
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

function GameKeyOperationView:SendSDK()
	if not GameToSDK.IsEditorOrPcPlatform() then
		return
	end

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(self.keysChangeInfo_) do
		local var_57_1 = var_57_0[iter_57_1.layoutName]

		if not var_57_0[iter_57_1.layoutName] then
			var_57_1 = {}
			var_57_0[iter_57_1.layoutName] = var_57_1
		end

		table.insert(var_57_1, {
			buttonType = tostring(iter_57_1.buttonInt),
			value = iter_57_1.key
		})
	end

	for iter_57_2, iter_57_3 in ipairs({
		HID_TYPES.Keyboard,
		HID_TYPES.Xbox,
		HID_TYPES.PS4,
		HID_TYPES.KeyMouse
	}) do
		local var_57_2 = var_57_0[self:GetLayoutName(iter_57_3)]

		if var_57_2 then
			local var_57_3 = iter_57_3

			if iter_57_3 > HID_TYPES.Other then
				var_57_3 = var_57_3 - 1
			end

			SDKTools.SendMessageToSDK("keymap_setting", {
				type = var_57_3,
				other_arrayobject = var_57_2
			})
		end
	end
end

return GameKeyOperationView
