local var_0_0 = {}

function var_0_0:setExtLogic()
	if not var_0_0._isEnable() then
		return
	end

	self._requestedOpGameIds = {}
	self._isFrist = true
	self._originServer = g.core.platform.ServerListProxy:getCurServer()

	local var_1_0 = {
		setExtLogic = true,
		_isEnable = true
	}

	for iter_1_0, iter_1_1 in pairs(var_0_0) do
		if type(iter_1_1) == "function" and not var_1_0[iter_1_0] then
			self[iter_1_0] = iter_1_1
		end
	end

	self:_initServerGroupList()
end

function var_0_0:onLoad()
	self.m_kindTree:startUp(self)
	self.m_kindTree:setTreeCellLineGap(10)

	if #self._serverGroupInfo > 0 then
		local var_2_0 = g.core.platform.ServerListProxy:getLastLoginServerByMuiltGroup()
		local var_2_1 = 0

		if var_2_0 then
			local var_2_2 = string.sub(var_2_0.sid, 1, 4)

			for iter_2_0, iter_2_1 in ipairs(self._serverGroupInfo) do
				if iter_2_1.opGameId == var_2_2 then
					var_2_1 = iter_2_0 - 1

					break
				end
			end
		end

		self.m_groupList:setSelectedIndex(var_2_1)
		self:_onServerGroupSelected()
	else
		g.core.platform.PlatformProxy:reqServerList()

		self._requestedOpGameIds[tostring((g.core.platform.PlatformProxy:getOpGameId()))] = true
	end

	self:_updateServerData()
end

function var_0_0:onUnload()
	self.m_kindTree:startUp(nil)

	if not self._selectedServer then
		local var_3_0 = self._originServer
		local var_3_1 = string.sub(self._originServer.sid, 1, 4)

		g.core.platform.ServerListProxy:setCurServerList(var_3_1)
		g.core.platform.PlatformProxy:requestPlatformConfig({
			opGameId = var_3_1
		}, function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_LOCAL_CHOOSE_SERVER, false, var_3_0, 0)
		end)
	end
end

function var_0_0:onTreeSelectChange(arg_5_1)
	self._curTreeElem = arg_5_1

	local var_5_0 = arg_5_1:buildServers() or {}

	self._tmpServerList = var_5_0

	local var_5_1 = #var_5_0

	self.m_stateController:setSelectedIndex(#var_5_0 > 0 and 0 or 1)
	self.m_serverList:setNumItems(var_5_1)

	if self.m_kindTree:getSelectedTreeIndex() > 0 then
		self.m_isShowGroupController:setSelectedIndex(#self._serverGroupInfo > 0 and 1 or 0)
	else
		self.m_isShowGroupController:setSelectedIndex(0)
	end
end

function var_0_0:_initServerGroupList()
	self.m_groupList:setVirtual()
	self.m_groupList:setItemRenderer(handler(self, self._onServerGroupItemUpdate))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onServerGroupSelected))

	local var_6_0 = config.PUBLISH_REGION

	if config.PUBLISH_REGION == 0 then
		var_6_0 = 2
	end

	local var_6_1 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[var_6_0]

	self._serverGroupInfo = {}

	if var_6_1.SERVER_OTHER_GROUP and #var_6_1.SERVER_OTHER_GROUP > 0 then
		self._serverGroupInfo[1] = {
			name = 100070 + var_6_0,
			opGameId = g.core.platform.PlatformProxy:getOpGameId()
		}

		for iter_6_0, iter_6_1 in ipairs(var_6_1.SERVER_OTHER_GROUP) do
			self._serverGroupInfo[#self._serverGroupInfo + 1] = iter_6_1
		end
	end

	self.m_groupList:setNumItems(#self._serverGroupInfo)
end

function var_0_0:_onServerGroupItemUpdate(arg_7_1, arg_7_2)
	arg_7_2:updateGroupCell(self._serverGroupInfo[arg_7_1 + 1])
end

function var_0_0:_onServerGroupSelected(arg_8_1, arg_8_2)
	local var_8_0 = self._serverGroupInfo[self.m_groupList:getSelectedIndex() + 1]

	g.core.platform.ServerListProxy:switchServerList(var_8_0.opGameId, not self._requestedOpGameIds[tostring(var_8_0.opGameId)])
	self:_onGetServerList()
	self:_onGetMyServerList()

	self._requestedOpGameIds[tostring(var_8_0.opGameId)] = true
end

function var_0_0:_onGetMyServerList()
	local var_9_0 = self.m_groupList:getSelectedIndex()
	local var_9_1 = g.core.platform.ServerListProxy:getMyServerList()

	if var_9_1 and #var_9_1 > 0 then
		self.m_kindTree:setSelectTreeIndex(0)
	end

	if not self._isFrist then
		self.m_kindTree:setSelectTreeIndex(1)
		self.m_kindTree:setSelectTreeIndex(2)

		if var_9_0 >= 0 then
			self.m_groupList:setSelectedIndex(var_9_0)
		end
	end
end

function var_0_0:_onGetServerList()
	self.m_kindTree:setSelectTreeIndex(-1)

	local var_10_0 = self.m_groupList:getSelectedIndex()

	self:_updateServerData()

	if not self._isFrist then
		self.m_kindTree:setSelectTreeIndex(1)
		self.m_kindTree:setSelectTreeIndex(2)

		if var_10_0 >= 0 then
			self.m_groupList:setSelectedIndex(var_10_0)
		end
	else
		self._isFrist = false
	end
end

function var_0_0._isEnable()
	return config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN
end

return var_0_0
