-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/BirthdayEditTipsView.lua

module("logic.extensions.playerinfo.view.info.BirthdayEditTipsView", package.seeall)

local M = class("BirthdayEditTipsView", ViewComponent)
local MonthDayCountMap = {
	31,
	29,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
}

function M:buildUI()
	self._btnBg = self:getBtn("1&universal_second_tips_common_bg_-1467035629")
	self._saveBtn = self:getBtnByPath("content/btnConfirm")
	self._cancelBtn = self:getBtnByPath("content/btnCancel")
	self._txtMonth = self:getInput("player_enter_birth_tips_1453544203")
	self._txtDay = self:getInput("player_enter_birth_tips_-949569722")
	self._btnExit = self:getBtn("1&universal_second_tips_common_bg_1201003252")
end

function M:bindEvents()
	self._saveBtn:AddClickListener(self._onClickSave, self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
	self._txtMonth:AddOnEndEdit(self._onEndEditInput, self)
	self._txtDay:AddOnEndEdit(self._onEndEditInput, self)
	self._btnExit:AddClickListener(self._onClickCancel, self)
	self._btnBg:AddClickListener(self._onClickCancel, self)
end

function M:unbindEvents()
	self._saveBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._txtMonth:RemoveOnEndEdit()
	self._txtDay:RemoveOnEndEdit()
	self._btnExit:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function M:_onEndEditInput()
	local month = tonumber(self._txtMonth:GetText()) or 1
	local day = tonumber(self._txtDay:GetText()) or 1

	if month < 1 or month > 12 then
		month = 1
	end

	if day < 1 or day > MonthDayCountMap[month] then
		day = 1
	end

	self._txtMonth:SetText(string.format("%02d", month))
	self._txtDay:SetText(string.format("%02d", day))
end

function M:onEnter()
	local info = self:getFirstParam()

	self._callBackFunc = info.callBackFunc
	self._callBackHandle = info.callBackHandle

	local month = info.month or 1
	local day = info.day or 1

	self._txtMonth:SetText(string.format("%02d", month))
	self._txtDay:SetText(string.format("%02d", day))
end

function M:destroyUI()
	self._saveBtn = nil
	self._cancelBtn = nil
	self._callBackFunc = nil
	self._callBackHandle = nil
end

function M:_onClickSave()
	local info = {}

	info.callBackFunc = self._callBackFunc
	info.callBackHandle = self._callBackHandle
	info.month = self._txtMonth:GetText()
	info.day = self._txtDay:GetText()

	ViewMgr.instance:open(ViewName.BirthdayConfirmTips, info)
	self:close()
end

function M:_onClickCancel()
	self:close()
end

return M
