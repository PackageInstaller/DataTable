local var_0_0 = class("GameKeyBindingItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.fixedController_ = arg_2_0.controllerEx_:GetController("fixed")
	arg_2_0.styleController_ = arg_2_0.controllerEx_:GetController("style")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.keyBtn_, nil, function()
		arg_4_0:StartListeningNewKey()
	end)
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.super.Dispose(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0.layoutName_ = arg_8_1
	arg_8_0.itemData_ = arg_8_2
	arg_8_0.gamepadType_ = arg_8_3
	arg_8_0.controlType_ = arg_8_4
end

function var_0_0.SetKeyChangedCallback(arg_9_0, arg_9_1)
	arg_9_0.onKeyChanged_ = arg_9_1
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0:IsOpNotAllow(arg_10_0.itemData_.buttonName)

	arg_10_0.fixedController_:SetSelectedState(tostring(var_10_0))

	arg_10_0.nameText_.text = LuaHidTools.GetOpName(arg_10_0.itemData_.buttonName)

	local var_10_1 = arg_10_0:GetKeyIcon(arg_10_0.itemData_.keyName)

	if var_10_1 ~= nil then
		local var_10_2 = KeyCode[arg_10_0.itemData_.keyName]
		local var_10_3 = var_10_2 and tostring(var_10_2:ToInt()) or arg_10_0.itemData_.keyName
		local var_10_4 = LuaForGamepad.IsGamepadKey(var_10_3)

		arg_10_0.styleController_:SetSelectedState(var_10_4 and "gamepad" or "keyboard")

		arg_10_0.keyImage_.sprite = var_10_1

		arg_10_0.keyImage_:SetNativeSize()
	else
		arg_10_0.styleController_:SetSelectedState("text")

		arg_10_0.keyText_.text = GetKeyCodeMappedName(arg_10_0.itemData_.keyName)
	end
end

function var_0_0.SetKey(arg_11_0, arg_11_1)
	local var_11_0 = LuaForGamepad.ConvertName(arg_11_1)
	local var_11_1

	var_11_1 = arg_11_0:GetKeyIcon(var_11_0) ~= nil

	if arg_11_0.onKeyChanged_ then
		local var_11_2 = arg_11_0.itemData_.keyName

		if KeyCode[var_11_2] then
			var_11_2 = tostring(KeyCode[var_11_2]:ToInt())
		end

		local var_11_3 = {
			layoutName = arg_11_0.layoutName_,
			buttonName = arg_11_0.itemData_.buttonName,
			buttonInt = arg_11_0.itemData_.buttonInt,
			key = arg_11_1,
			keyName = var_11_0,
			oldKey = var_11_2,
			oldKeyName = arg_11_0.itemData_.keyName
		}

		arg_11_0.onKeyChanged_(arg_11_0, var_11_3)
	end
end

function var_0_0.StartListeningNewKey(arg_12_0)
	if arg_12_0:IsOpNotAllow(arg_12_0.itemData_.buttonName) then
		ShowTips("INPUT_KEY_UNCHANGEABLE")

		return
	end

	JumpTools.OpenPageByJump("gameKeyListening", {
		gamepadType = arg_12_0.gamepadType_,
		controlType = arg_12_0.controlType_,
		listenCallback = function(arg_13_0)
			arg_12_0:SetKey(arg_13_0)
		end
	})
end

function var_0_0.IsOpNotAllow(arg_14_0, arg_14_1)
	return LuaHidTools.IsOpNotAllow(arg_14_0.gamepadType_, arg_14_1)
end

function var_0_0.GetKeyIcon(arg_15_0, arg_15_1)
	return LuaForGamepad.GetKeyIcon(arg_15_1, arg_15_0.gamepadType_)
end

return var_0_0
