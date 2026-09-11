local MusicKeySetItem = class("MusicKeySetItem", ReduxView)

function MusicKeySetItem:OnCtor(arg_1_1, arg_1_2)
	self.trackIndex = arg_1_2
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MusicKeySetItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MusicKeySetItem:InitUI()
	self:BindCfgUI()
end

function MusicKeySetItem:AddUIListener()
	self:AddBtnListener(self.keyBtn_, nil, function()
		self:StartListeningNewKey()
	end)
end

function MusicKeySetItem:SetData(arg_6_1)
	self.KeyName = arg_6_1
	self.trackNameText_.text = string.format(GetTips("ACTIVITY_MUSIC_SETTING_TRANK"), self.trackIndex)
	self.keyNameText_.text = GetKeyCodeMappedName(arg_6_1)
end

function MusicKeySetItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function MusicKeySetItem:Dispose()
	MusicKeySetItem.super.Dispose(self)
end

function MusicKeySetItem:SetKeyChanged(arg_9_1)
	self.onKeyChanged_ = arg_9_1
end

function MusicKeySetItem:SetKey(arg_10_1)
	if self.onKeyChanged_ then
		if KeyCode[self.keyName] then
			local var_10_0 = tostring(KeyCode[self.keyName]:ToInt())
		end

		self.onKeyChanged_({
			key = arg_10_1,
			keyName = LuaForGamepad.ConvertName(arg_10_1),
			oldKeyName = self.KeyName
		})
	end
end

function MusicKeySetItem:StartListeningNewKey()
	JumpTools.OpenPageByJump("gameKeyListening", {
		controlType = 0,
		gamepadType = HID_TYPES.Keyboard,
		listenCallback = function(arg_12_0)
			self:SetKey(arg_12_0)
		end
	})
end

return MusicKeySetItem
