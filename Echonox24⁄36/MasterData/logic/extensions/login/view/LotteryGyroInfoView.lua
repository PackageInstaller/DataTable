-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LotteryGyroInfoView.lua

module("logic.extensions.login.view.LotteryGyroInfoView", package.seeall)

local LotteryGyroInfoView = class("LotteryGyroInfoView", ViewComponent)
local kLength = 14

function LotteryGyroInfoView:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._input = self:getInput("login/inputClouds")
	self._input1 = self:getInput("login (1)/inputClouds")
	self._input2 = self:getInput("login (2)/inputClouds")
	self._input3 = self:getInput("login (3)/inputClouds")
	self._input4 = self:getInput("login (4)/inputClouds")
	self._input5 = self:getInput("login (5)/inputClouds")
	self._input6 = self:getInput("login (6)/inputClouds")
end

function LotteryGyroInfoView:bindEvents()
	self._btnClose:AddClickListener(self.back, self)
	self._input:AddOnValueChanged(self._onChangeParam, self)
	self._input1:AddOnValueChanged(self._onChangeParam1, self)
	self._input2:AddOnValueChanged(self._onChangeParam2, self)
	self._input3:AddOnValueChanged(self._onChangeParam3, self)
	self._input4:AddOnValueChanged(self._onChangeParam4, self)
	self._input5:AddOnValueChanged(self._onChangeParam5, self)
	self._input6:AddOnValueChanged(self._onChangeParam6, self)
end

function LotteryGyroInfoView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._input:RemoveOnValueChanged()
	self._input1:RemoveOnValueChanged()
	self._input2:RemoveOnValueChanged()
	self._input3:RemoveOnValueChanged()
	self._input4:RemoveOnValueChanged()
	self._input5:RemoveOnValueChanged()
	self._input6:RemoveOnValueChanged()
end

function LotteryGyroInfoView:onEnter()
	self._input:SetText(Astral.LocalStorage.Instance:GetString("lottery_decrease_3", "1,3,5,7,9,11,13,15,20,13,22,20,22,5"))
	self._input1:SetText(tonumber(Astral.LocalStorage.Instance:GetString("minDistance", 0.04)))
	self._input2:SetText(tonumber(Astral.LocalStorage.Instance:GetString("x_Max", 20)))
	self._input3:SetText(tonumber(Astral.LocalStorage.Instance:GetString("y_Max", 20)))
	self._input4:SetText(tonumber(Astral.LocalStorage.Instance:GetString("minResetOffset", 0.01)))
	self._input5:SetText(tonumber(Astral.LocalStorage.Instance:GetString("reboundTime", 0.5)))
	self._input6:SetText(tonumber(Astral.LocalStorage.Instance:GetString("resetBoundTime", 3)))
end

function LotteryGyroInfoView:onExit()
	return
end

function LotteryGyroInfoView:_onChangeParam()
	local value = self._input:GetText()

	if value == "" or string.gsub(value, "^%s*(.-)%s*$", "%1") == "" then
		value = 1
	end

	local valueArr = string.split(value, ",")

	for i, v in ipairs(valueArr) do
		if v == "" then
			return
		end
	end

	local newDecrease = {}

	for i = 1, #valueArr do
		table.insert(newDecrease, tonumber(valueArr[i]))
	end

	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROINFO_CHANGE, newDecrease)
	Astral.LocalStorage.Instance:SetString("lottery_decrease_3", value)
end

function LotteryGyroInfoView:_onChangeParam1()
	local value = self._input1:GetText()

	if value == "" then
		return
	end

	Astral.LocalStorage.Instance:SetString("minDistance", value)
	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROPARAM_CHANGE)
end

function LotteryGyroInfoView:_onChangeParam2()
	local value = self._input2:GetText()

	if value == "" then
		return
	end

	Astral.LocalStorage.Instance:SetString("x_Max", value)
	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROPARAM_CHANGE)
end

function LotteryGyroInfoView:_onChangeParam3()
	local value = self._input3:GetText()

	if value == "" then
		return
	end

	Astral.LocalStorage.Instance:SetString("y_Max", value)
	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROPARAM_CHANGE)
end

function LotteryGyroInfoView:_onChangeParam4()
	local value = self._input4:GetText()

	if value == "" then
		return
	end

	Astral.LocalStorage.Instance:SetString("minResetOffset", value)
	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROPARAM_CHANGE)
end

function LotteryGyroInfoView:_onChangeParam5()
	local value = self._input5:GetText()

	if value == "" then
		return
	end

	Astral.LocalStorage.Instance:SetString("reboundTime", value)
	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROPARAM_CHANGE)
end

function LotteryGyroInfoView:_onChangeParam6()
	local value = self._input6:GetText()

	if value == "" then
		return
	end

	Astral.LocalStorage.Instance:SetString("resetBoundTime", value)
	GlobalDispatcher:dispatchEvent(EventType.LOTTERY_GYROPARAM_CHANGE)
end

return LotteryGyroInfoView
