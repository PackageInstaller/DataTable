-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\UI\\DebugButton.lua

local DebugConst = require("Debug/DebugConst")
local UserData = require("Helper/UserData")
local strClassName = "DebugButton"
local DebugButton = Class(strClassName, UIControls.Child)

function DebugButton:ctor()
	self:initUI()

	self.useChild = false
end

function DebugButton:initUI()
	self.btnBase = UIControls.Button(self, "Button", "Text")

	self.btnBase:addEventClick(self.onButtonOnClick)

	self.dropSelect = UIControls.Dropdown(self, "Dropdown")

	self.dropSelect:addEventValueChanged(self.onDropdownValueChanged)

	self.toggleSelect = UIControls.Toggle(self, "Toggle", "Label")

	self.toggleSelect:setText("开关")
	self.toggleSelect:addEventValueChanged(self.onToggleValueChanged)

	self.input = UIControls.Input(self, "InputField")
	self.inputBtn = UIControls.Button(self, "InputField/Button")

	self.inputBtn:addEventClick(self.onConfirmInput)
end

function DebugButton:setting(data)
	if data == nil then
		self:setVisible(false)

		return
	end

	self.data = data

	self.btnBase:setText(self.data.name)

	if self.data.typ == DebugConst.BTN_TYPE_COMBOX or self.data.typ == DebugConst.BTN_TYPE_TEST_COMBOX then
		if self.data.typ == DebugConst.BTN_TYPE_COMBOX then
			self.dropSelect:setItems(self.data.value)
		elseif self.data.typ == DebugConst.BTN_TYPE_TEST_COMBOX then
			self.dropSelect:setItems(self.data.value())
		end
	elseif self.data.typ == DebugConst.BTN_TYPE_CHECKBOX then
		self.toggleSelect:setOn(self.data.value)
		self.toggleSelect:addEventValueChanged(self.onToggleValueChanged)
	end

	self.dropSelect:setVisible(false)
	self.toggleSelect:setVisible(false)
	self.input:setVisible(false)
	self:setVisible(true)

	if self.data.typ == DebugConst.BTN_TYPE_INPUT then
		local str = UserData.loadCommonData(self.data.name)

		self.input:setText(str or "")
	end
end

function DebugButton:onButtonOnClick(sender)
	self.useChild = not self.useChild

	if self.data.typ == DebugConst.BTN_TYPE_MENU then
		local menu = self.data.value
		local count = #menu

		if menu[count] ~= self.mWindow.homeData then
			menu[count + 1] = self.mWindow.homeData
		end

		self.mWindow:setMenu(menu)
	elseif self.data.typ == DebugConst.BTN_TYPE_BUTTON then
		self.data.func(self, self.mWindow)
	elseif self.data.typ == DebugConst.BTN_TYPE_COMBOX or self.data.typ == DebugConst.BTN_TYPE_TEST_COMBOX then
		self.dropSelect:setVisible(self.useChild)
	elseif self.data.typ == DebugConst.BTN_TYPE_CHECKBOX then
		self.toggleSelect:setVisible(self.useChild)
	elseif self.data.typ == DebugConst.BTN_TYPE_INPUT then
		self.input:setVisible(self.useChild)
	end
end

function DebugButton:onDropdownValueChanged(sender)
	self.data.func(self, self.mWindow, sender:getText())
end

function DebugButton:onToggleValueChanged(sender)
	self.data.func(self, self.mWindow, sender:isOn())
end

function DebugButton:onConfirmInput(sender)
	self.data.func(self, self.mWindow, self.input:getText())
	UserData.saveCommonData(self.data.name, self.input:getText())
end

return DebugButton
