-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/BirthdayConfirmTips.lua

module("logic.extensions.playerinfo.view.info.BirthdayConfirmTips", package.seeall)

local M = class("BirthdayConfirmTips", ViewComponent)

function M:buildUI()
	self._txtContent = self:getUIComponent("message_dialog_-858469084", UIComponentType.TextMeshProUGUI)
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("4&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("5&btn_right_1251431307"), CommButton)
	self._btnAgree = self:getGo("message_tips_1745137423")
	self._btnExit = self:getBtn("message_tips_1822196934")
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnExit:AddClickListener(self._onClickCancel, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function M:onEnter()
	goutil.setActive(self._btnAgree, false)

	local info = self:getFirstParam()

	self._callBackFunc = info.callBackFunc
	self._callBackHandle = info.callBackHandle
	self._month = info.month
	self._day = info.day
	self._txtContent.text = string.format("<color=#b6b7b7>是否确认主管生日为<color=#ffffff>%s月%s日</color>，一经确认不可修改</color>", info.month, info.day)
end

function M:_onClickConfirm()
	if self._callBackFunc then
		self._callBackFunc(self._callBackHandle, self._month, self._day)
	end

	self:close()
end

function M:_onClickCancel()
	self:close()
end

return M
