local GameKeyBindingItem = class("GameKeyBindingItem", ReduxView)

function GameKeyBindingItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function GameKeyBindingItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.fixedController_ = self.controllerEx_:GetController("fixed")
	self.styleController_ = self.controllerEx_:GetController("style")
end

function GameKeyBindingItem:InitUI()
	self:BindCfgUI()
end

function GameKeyBindingItem:AddUIListeners()
	self:AddBtnListener(self.keyBtn_, nil, function()
		self:StartListeningNewKey()
	end)
end

function GameKeyBindingItem:OnExit()
	return
end

function GameKeyBindingItem:Dispose()
	self.super.Dispose(self)
end

function GameKeyBindingItem:SetData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.layoutName_ = arg_8_1
	self.itemData_ = arg_8_2
	self.gamepadType_ = arg_8_3
	self.controlType_ = arg_8_4
end

function GameKeyBindingItem:SetKeyChangedCallback(arg_9_1)
	self.onKeyChanged_ = arg_9_1
end

function GameKeyBindingItem:RefreshUI()
	self.fixedController_:SetSelectedState(tostring((self:IsOpNotAllow(self.itemData_.buttonName))))

	self.nameText_.text = LuaHidTools.GetOpName(self.itemData_.buttonName)

	local var_10_0 = self:GetKeyIcon(self.itemData_.keyName)

	if var_10_0 ~= nil then
		self.styleController_:SetSelectedState(LuaForGamepad.IsGamepadKey(KeyCode[self.itemData_.keyName] and tostring(KeyCode[self.itemData_.keyName]:ToInt()) or self.itemData_.keyName) and "gamepad" or "keyboard")

		self.keyImage_.sprite = var_10_0

		self.keyImage_:SetNativeSize()
	else
		self.styleController_:SetSelectedState("text")

		self.keyText_.text = GetKeyCodeMappedName(self.itemData_.keyName)
	end
end

function GameKeyBindingItem:SetKey(arg_11_1)
	local var_11_0 = LuaForGamepad.ConvertName(arg_11_1)
	local var_11_1 = self:GetKeyIcon(var_11_0) ~= nil

	if self.onKeyChanged_ then
		local var_11_2 = self.itemData_.keyName

		if KeyCode[self.itemData_.keyName] then
			var_11_2 = tostring(KeyCode[var_11_2]:ToInt())
		end

		self:onKeyChanged_({
			layoutName = self.layoutName_,
			buttonName = self.itemData_.buttonName,
			buttonInt = self.itemData_.buttonInt,
			key = arg_11_1,
			keyName = var_11_0,
			oldKey = var_11_2,
			oldKeyName = self.itemData_.keyName
		})
	end
end

function GameKeyBindingItem:StartListeningNewKey()
	if self:IsOpNotAllow(self.itemData_.buttonName) then
		ShowTips("INPUT_KEY_UNCHANGEABLE")

		return
	end

	JumpTools.OpenPageByJump("gameKeyListening", {
		gamepadType = self.gamepadType_,
		controlType = self.controlType_,
		listenCallback = function(arg_13_0)
			self:SetKey(arg_13_0)
		end
	})
end

function GameKeyBindingItem:IsOpNotAllow(arg_14_1)
	return LuaHidTools.IsOpNotAllow(self.gamepadType_, arg_14_1)
end

function GameKeyBindingItem:GetKeyIcon(arg_15_1)
	return LuaForGamepad.GetKeyIcon(arg_15_1, self.gamepadType_)
end

return GameKeyBindingItem
