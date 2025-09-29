-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/selectserver/SelectServerCell.lua

module("logic.extensions.selectserver.SelectServerCell", package.seeall)

local M = class("SelectServerCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._serverName = false
	self._selectBtn = false
	self._normalNode = false
	self._selectNode = false
	self._fluencyNode = false
	self._maintenanceNode = false
end

function M:Awake()
	M.super.Awake(self)

	self._serverName = self._viewElementsRegistry:findUIElement("select_server_tab_879282984", UIComponentType.Text)
	self._selectBtn = self._viewElementsRegistry:findUIElement("select_server_tab_2140675108", UIComponentType.ButtonAdapter)
	self._normalNode = self._viewElementsRegistry:findUIElement("select_server_tab_920894979")
	self._selectNode = self._viewElementsRegistry:findUIElement("select_server_tab_325623809")
	self._maintenanceNode = self._viewElementsRegistry:findUIElement("select_server_tab_51952055")
	self._fluencyNode = self._viewElementsRegistry:findUIElement("select_server_tab_891786692")

	self._selectBtn:AddClickListener(self._selectCell, self)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self._selectBtn:RemoveClickListener()
end

function M:updateData(data)
	M.super.updateData(self, data)

	if data then
		local host = data.host or "未开服"

		if data.hostPorts and tostring(data.hostPorts) ~= "userdata: NULL" then
			local info = string.split(data.hostPorts[1], ":")

			host = info[1]
		end

		self._serverName.text = StringUtil.getServerName(data.name, host)

		local isOpen = data.state == 1

		goutil.setActive(self._fluencyNode, isOpen)
		goutil.setActive(self._maintenanceNode, not isOpen)
	end
end

function M:onSelect(isSelected)
	if isSelected then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_SELECT_SERVER_EVENT, self._data)
	end

	goutil.setActive(self._selectNode, isSelected)
	goutil.setActive(self._normalNode, not isSelected)
end

function M:_selectCell()
	self:setSelect(true)
end

return M
