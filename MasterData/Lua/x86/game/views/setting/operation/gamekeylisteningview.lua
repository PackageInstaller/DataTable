local GameKeyListeningView = class("GameKeyListeningView", ReduxView)
local cjson = require("cjson")

function GameKeyListeningView:UIName()
	return "Widget/System/Setting/SettingHandlUI"
end

function GameKeyListeningView:UIParent()
	return manager.ui.uiPop.transform
end

function GameKeyListeningView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameKeyListeningView:InitUI()
	self:BindCfgUI()
end

function GameKeyListeningView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function GameKeyListeningView:OnEnter()
	self.gamepadType_ = self.params_.gamepadType

	SetActive(self.confirmBtn_.gameObject, false)
	self:StartKeyListening()
end

function GameKeyListeningView:OnExit()
	self:StopKeyListening()

	self.params_.listenCallback = nil
end

function GameKeyListeningView:SendKeyResult(arg_9_1)
	if self.params_.listenCallback then
		self.params_.listenCallback((self:MapKey(arg_9_1)))
	end
end

function GameKeyListeningView:StartKeyListening()
	self:StopKeyListening()

	self.contentText_.text = GetTips("PLEASE_INPUT_KEY")

	LuaForCursor.SetCanMove(false)
	LuaForGamepad.ClearInputValue()

	self.lastKey_ = nil
	self.candidateKey_ = nil
	self.candidateCount_ = 0
	self.timer_ = FrameTimer.New(function()
		local var_11_0 = self:GetInputKey()

		if not self:IsKeyLegal(var_11_0) then
			return
		end

		LuaForGamepad.ClearInputValue()
		self:SendKeyResult(var_11_0)
	end, 1, -1)

	self.timer_:Start()
end

function GameKeyListeningView:StopKeyListening()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	LuaForCursor.SetCanMove(true)
end

function GameKeyListeningView:IsKeyLegal(arg_13_1)
	if arg_13_1 == "" then
		return false
	end

	local var_13_0 = LuaForGamepad.ConvertName(arg_13_1)

	print(string.format("输入名称: %s", var_13_0))

	local var_13_1 = self.gamepadType_

	if LuaHidTools.IsKeyNotAllow(self.gamepadType_, var_13_0, self.params_.controlType) then
		ShowTips((GetTipsF("INPUT_KEY_NOT_ALLOW", GetKeyCodeMappedName(var_13_0))))

		return false
	end

	return (var_13_1 == 2 or var_13_1 == 3) == LuaForGamepad.IsGamepadKey(arg_13_1)
end

function GameKeyListeningView:GetInputData()
	local var_14_0 = LuaForGamepad.GetInputListString()

	if var_14_0 and var_14_0 ~= "" then
		print(string.format("InputingList: %s", var_14_0))
	end

	local var_14_1 = self.gamepadType_ == 2 or self.gamepadType_ == 3
	local var_14_2 = ""
	local var_14_3 = LuaForGamepad.GetAllInputResultJson()

	if var_14_3 and var_14_3 ~= "" then
		for iter_14_0, iter_14_1 in ipairs(cjson.decode(var_14_3).m_inputValueList) do
			if var_14_1 == LuaForGamepad.IsGamepadKey(iter_14_1.m_axisName) and not string.find(iter_14_1.m_axisName, "Mouse_") then
				var_14_2 = iter_14_1

				break
			end
		end
	end

	return var_14_2
end

function GameKeyListeningView:GetInputKey()
	local var_15_0 = self:GetInputData()

	if var_15_0 == "" then
		if self.lastKey_ then
			self.lastKey_ = nil

			return self.lastKey_
		end

		return ""
	end

	local var_15_1 = var_15_0.m_axisName

	if var_15_0.m_axisName ~= self.lastKey_ then
		if var_15_1 == self.candidateKey_ then
			self.candidateCount_ = self.candidateCount_ + 1
		else
			self.candidateKey_ = var_15_1
			self.candidateCount_ = 1
		end

		if self.candidateCount_ >= 3 then
			self.lastKey_ = var_15_1
		end
	end

	return ""
end

function GameKeyListeningView:MapKey(arg_16_1)
	local var_16_0 = tonumber(arg_16_1)

	if var_16_0 then
		print("converting keypad input to alpha")

		if var_16_0 == 271 then
			return "13"
		end

		if var_16_0 >= 256 and var_16_0 <= 265 then
			return tostring(48 + var_16_0 - 256)
		end
	end

	return arg_16_1
end

function GameKeyListeningView:Dispose()
	GameKeyListeningView.super.Dispose(self)
end

return GameKeyListeningView
