-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/report/view/ReportView.lua

module("logic.extensions.report.view.ReportView", package.seeall)

local M = class("ReportView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._btnCancel = self:getBtn("2&btn_left_-1571983320")
	self._btnInform = self:getBtn("3&btn_right_1251431307")
	self._inputField = self:getInput("friend_inform_tips_-534683837")
	self._toggleList = {
		self:getGo("friend_inform_tips_-117467382"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-1376390319"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-324740771"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-1169979783"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-1918541226"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-714236235"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-1194960417"):GetComponent(UIComponentType.SpaceXToggle),
		self:getGo("friend_inform_tips_-1767859658"):GetComponent(UIComponentType.SpaceXToggle)
	}
end

function M:destroyUI()
	self._btnClose = nil
	self._btnCancel = nil
	self._btnInform = nil
	self._inputField = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnInform:AddClickListener(self._onClickInform, self)

	for i, toggle in ipairs(self._toggleList) do
		toggle:AddListener(function()
			self:_onClickToggle(i)
		end, self)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnInform:RemoveClickListener()

	for i, toggle in ipairs(self._toggleList) do
		toggle:RemoveListener()
	end
end

function M:onEnter()
	local openParam = self:getOpenParam()

	self._data = openParam[1]
	self._toggleList[1].IsOn = true
	self._selectEnum = 1

	self._inputField:SetText("")
end

function M:onExit()
	return
end

function M:_onClickClose()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_window_close, nil, nil, nil)
	self:close()
end

function M:_onClickCancel()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click_cancel, nil, nil, nil)
	self:close()
end

function M:_onClickInform()
	local content = self._data and self._data.content
	local cause = self._inputField:GetText()
	local playerId = self._data and self._data.playerId

	ReportAgent.instance:sendReportUserRequest(playerId, self._selectEnum, cause, content)
	FloatWordMgr.instance:show("举报成功")
	self:close()
end

function M:_onClickToggle(index)
	local toggle = self._toggleList[index]

	if toggle.IsOn then
		self._selectEnum = index
	end
end

return M
