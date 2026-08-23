local MyElem = require("app.view.module.login.model.MyElem")
local AllElem = require("app.view.module.login.model.AllElem")
local SubElem = require("app.view.module.login.model.SubElem")
local LoginServerListPop = class("LoginServerListPop", require("app.fairyGUI.login.UI_LoginServerListPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		resName = "LoginServerListPop",
		pkgName = "login"
	})
end)

function LoginServerListPop:ctor()
	self:showAtCenter()
	self:addBg("bg/login/bg_dl_beijing.jpg")

	self._curTreeElem = nil
	self._tmpServerList = nil
	self._selectedServer = false

	require("app.view.module.login.view.LoginServerListPopExLogic").setExtLogic(self)
	self:initTreeList()
	self:initServerList()
	self:registerEvents()
end

function LoginServerListPop:registerEvents()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SDK_GET_SERVER_LIST, self._onGetServerList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SDK_GET_MY_SERVER_LIST, self._onGetMyServerList, self)
end

function LoginServerListPop:onLoad()
	self.m_kindTree:startUp(self)
	self.m_kindTree:setTreeCellLineGap(10)
	g.core.platform.PlatformProxy:reqServerList()
	self:_updateServerData()
end

function LoginServerListPop:onUnload()
	self.m_kindTree:startUp(nil)
end

function LoginServerListPop:initTreeList()
	return
end

function LoginServerListPop:onTreeSelectChange(arg_7_1)
	self._curTreeElem = arg_7_1

	local var_7_0 = arg_7_1:buildServers() or {}

	self._tmpServerList = var_7_0

	local var_7_1 = #var_7_0

	self.m_stateController:setSelectedIndex(#var_7_0 > 0 and 0 or 1)
	self.m_serverList:setNumItems(var_7_1)
end

function LoginServerListPop:initServerList()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemProvider(handler(self, self._onServerItemTempl))
	self.m_serverList:setItemRenderer(handler(self, self._onServerItemUpdate))
	self.m_serverList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onServerSelected))
end

function LoginServerListPop:_onServerItemTempl(arg_9_1)
	return self._curTreeElem:getServerTemplate()
end

function LoginServerListPop:_onServerItemUpdate(arg_10_1, arg_10_2)
	arg_10_2:updateServerCell(arg_10_1, self._tmpServerList[arg_10_1 + 1])
end

function LoginServerListPop:_onServerSelected(arg_11_1, arg_11_2)
	g.core.platform.ServerListProxy:clearSummonServer()

	local var_11_0 = arg_11_1:getDataValue()

	if self._tmpServerList[var_11_0 + 1].openTime and g.core.common.ServerTime:getLeftSeconds(self._tmpServerList[var_11_0 + 1].openTime) > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100035, {
			time = g.core.common.ServerTime:getDateMDHMFormat(self._tmpServerList[var_11_0 + 1].openTime)
		}))
	end

	self._selectedServer = true

	local var_11_1 = self._tmpServerList[var_11_0 + 1]
	local var_11_2 = g.core.platform.ServerListProxy:getBaseMainServer(self._tmpServerList[var_11_0 + 1].sid)

	if var_11_2 and not g.core.platform.ServerListProxy:isMyServer(var_11_1) then
		var_11_1 = var_11_2
	end

	self:dispatchCompEvent("server", var_11_1, var_11_0 + 1)
	g.core.module.ModuleManager:popComponent()
end

function LoginServerListPop:_updateServerData()
	self:initTreeData()
	self.m_kindTree:refreshUI()
	self.m_kindTree:setSelectTreeIndex(0)
end

function LoginServerListPop:initTreeData()
	self.m_kindTree:cleanTree()
	self.m_kindTree:pushMainElem(MyElem.new())
	self.m_kindTree:pushMainElem(AllElem.new())

	for iter_13_0 = 1, #(g.core.platform.ServerListProxy:getServerList() or {}), 10 do
		self.m_kindTree:frontSubElem(SubElem.new(iter_13_0))
	end
end

function LoginServerListPop:_onGetMyServerList()
	local var_14_0 = g.core.platform.ServerListProxy:getMyServerList()

	if var_14_0 and #var_14_0 > 0 then
		self.m_kindTree:setSelectTreeIndex(0)
	end
end

function LoginServerListPop:_onGetServerList()
	self:_updateServerData()
end

return LoginServerListPop
