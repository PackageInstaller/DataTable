g.core.model.User.obtData = g.core.model.User.obtData or require("app.view.module.debug.OnlineBattleTest.model.ObtData")

local ObtDebugConst = require("app.view.module.debug.OnlineBattleTest.ObtDebugConst")
local Struct = require("app.core.common.Struct")
local socket = require("socket")
local ObtClient = class("ObtClient", require("app.fairyGUI.debug.UI_ObtClient"))

function ObtClient:ctor()
	self._client = nil
	self._lastKeepAliveTime = 0
	self._serverAliveTime = 0
	self._curVersion = 0
	self._versionList = {}
	self._allVersionData = {}
	self._selectBattleIndex = 0
	self._csvHeadList = {}
	self._pop = nil

	self:initView()
end

function ObtClient:shotDown()
	if self._client then
		self._client:close()
	end

	self._client = nil
	self._curVersion = 0
end

function ObtClient:initView()
	self.m_connectBtn:addClickListener(handler(self, self._onClickConnect))
	self.m_versionSelectComp:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickVersion))
	self.m_showProgressComp:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickProgressComp))
	self.m_allBattleList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickAllBattleList))
	self:newSchedule(handler(self, self._update), 0.1)
	self.m_allBattleList:setVirtual()
	self.m_allBattleList:setItemRenderer(handler(self, self._onRenderAllBattle))
	self.m_hasVersionController:setSelectedIndex(0)
	self.m_showProgressComp:setItems(ObtDebugConst.progressList)
	self.m_exportCsvList:setIniter()
	self.m_exportCsvList:setItemRenderer(handler(self, self._onRenderExportCsv))

	for iter_3_0, iter_3_1 in pairs(ObtDebugConst.CsvHead) do
		table.insert(self._csvHeadList, iter_3_0)
	end

	self.m_exportCsvList:setNumItems(#self._csvHeadList)
	self.m_exportBtn:addClickListener(handler(self, self._onClickExportCsv))
	self.m_serverIpInput:setText(g.core.model.User.obtData:getIp())
	self.m_serverPortInput:setText(g.core.model.User.obtData:getPort())
	self.m_lookBtn:addClickListener(handler(self, self._onLookClick))
end

function ObtClient:_onLookClick()
	self:_clearPop()

	self._pop = require("app.view.module.debug.OnlineBattleTest.ObtClientShowPop").new()

	g.core.module.ModuleManager:pushPopup(self._pop, {
		hideContinue = true,
		touchDisappear = true
	})
	self:addListen(self._pop)
end

function ObtClient:_clearPop()
	if self._pop then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self._pop)

		self._pop = nil
	end
end

function ObtClient:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "ObtClientShowPop_Clear_Pop" then
		self:_clearPop()
	end
end

function ObtClient:_onClickExportCsv()
	local var_7_0 = self.m_exportFileInput:getText()

	if var_7_0 == "" then
		g.core.module.ModuleManager:tip("请输入文件名")

		return
	end

	local var_7_1 = {}

	for iter_7_0 = 1, #self._csvHeadList do
		local var_7_2 = self.m_exportCsvList:getChildAt(iter_7_0 - 1)

		if var_7_2 and var_7_2:isSelected() and not ObtDebugConst.CsvBaseHead[self._csvHeadList[iter_7_0]] then
			table.insert(var_7_1, self._csvHeadList[iter_7_0])
		end
	end

	if #var_7_1 == 0 then
		g.core.module.ModuleManager:tip("请选择导出的字段")

		return
	end

	self:send(ObtDebugConst.export_csv, {
		fileName = var_7_0,
		headList = var_7_1
	})
end

function ObtClient:_onRenderExportCsv(arg_8_1, arg_8_2)
	arg_8_2:setTitle(ObtDebugConst.CsvHead[self._csvHeadList[arg_8_1 + 1]])

	if ObtDebugConst.CsvBaseHead[self._csvHeadList[arg_8_1 + 1]] then
		arg_8_2:setSelected(true)
		arg_8_2:setTouchable(false)
	end
end

function ObtClient:_onClickAllBattleList()
	self._selectBattleIndex = self.m_allBattleList:getSelectedIndex() + 1

	local var_9_0 = g.core.model.User.obtData:getBattle(self._selectBattleIndex)

	if var_9_0 then
		if not g.core.model.User.obtData:getUserBattleTeamIndex(var_9_0.attack) then
			self:send(ObtDebugConst.get_battle_team, var_9_0.attack)
		end

		if not g.core.model.User.obtData:getUserBattleTeamIndex(var_9_0.victim) then
			self:send(ObtDebugConst.get_battle_team, var_9_0.victim)
		end

		if not g.core.model.User.obtData:getBattleResult(var_9_0.attack, var_9_0.victim) then
			self:send(ObtDebugConst.get_battle_result, {
				attack = var_9_0.attack,
				victim = var_9_0.victim
			})
		end

		self:updateBattle()
	end
end

function ObtClient:_onClickProgressComp()
	g.core.model.User.obtData:setShowProgressIndex(self.m_showProgressComp:getSelectedIndex() + 1)
	self.m_allBattleList:refreshVirtualList()
end

function ObtClient:onLoad()
	self.m_showProgressComp:setSelectedIndex(g.core.model.User.obtData:getShowProgressIndex() - 1)
end

function ObtClient:_onRenderAllBattle(arg_12_1, arg_12_2)
	arg_12_2:updateBattleCell(arg_12_1 + 1)
end

function ObtClient:_update()
	if self._client then
		if os.time() - self._serverAliveTime > 10 then
			g.core.module.ModuleManager:tip("服务器超时,自动断开连接")
			self.m_hasVersionController:setSelectedIndex(0)
			self.m_versionSelectComp:setItems({})
			self.m_versionSelectComp:refresh()
			self:shotDown()

			return
		end

		local var_13_0, var_13_1 = self._client:receive()

		if var_13_0 then
			self:receive(var_13_0)
		elseif var_13_1 == "closed" then
			g.core.module.ModuleManager:tip("服务器关闭了连接")
			self:shotDown()

			return
		end

		if os.time() - self._lastKeepAliveTime > 5 then
			self._lastKeepAliveTime = os.time()

			self:send(ObtDebugConst.keep_alive)
		end
	end
end

function ObtClient:_onClickConnect()
	local var_14_0 = self.m_serverIpInput:getText()

	if not self:isValidIP(var_14_0) then
		g.core.module.ModuleManager:tip("ip不合法")

		return
	end

	local var_14_1 = self.m_serverPortInput:getText()

	if not self:isValidPort(var_14_1) then
		g.core.module.ModuleManager:tip("port不合法")

		return
	end

	if self._client then
		g.core.module.ModuleManager:tip("当前已经连接")

		return
	end

	self._client = socket.tcp()

	local var_14_2, var_14_3 = self._client:connect(var_14_0, var_14_1)

	if not var_14_2 then
		g.core.module.ModuleManager:tip("连接失败：" .. var_14_3)
		self:shotDown()

		return
	end

	g.core.model.User.obtData:setIp(var_14_0)
	g.core.model.User.obtData:setPort(var_14_1)
	self._client:settimeout(0)

	self._lastKeepAliveTime = os.time()
	self._serverAliveTime = self._lastKeepAliveTime

	self:send(ObtDebugConst.get_all_version)
end

function ObtClient:isValidIP(arg_15_1)
	if string.match(arg_15_1, "^([1-9]?[0-9]?[0-9])%.([1-9]?[0-9]?[0-9])%.([1-9]?[0-9]?[0-9])%.([1-9]?[0-9]?[0-9])$") then
		for iter_15_0 in string.gmatch(arg_15_1, "%d+") do
			if tonumber(iter_15_0) > 255 then
				return false
			end
		end

		return true
	end

	return false
end

function ObtClient:isValidPort(arg_16_1)
	if tonumber(arg_16_1) and tonumber(arg_16_1) > 0 and tonumber(arg_16_1) < 65535 then
		return true
	end

	return false
end

function ObtClient:onShow()
	self:setVisible(true)

	if not self._client then
		self.m_hasVersionController:setSelectedIndex(0)
	end
end

function ObtClient:onHide()
	self:setVisible(false)
	self:shotDown()
end

function ObtClient:send(arg_19_1, arg_19_2)
	if not self._client then
		g.core.module.ModuleManager:tip("未连接服务器")

		return
	end

	if type(arg_19_2) == "table" then
		arg_19_2 = json.encode(arg_19_2)
	elseif type(arg_19_2) ~= "string" then
		arg_19_2 = tostring(arg_19_2)
	end

	self._client:send(Struct.pack("<is", arg_19_1, arg_19_2 or "") .. "\n")
end

function ObtClient:receive(arg_20_1)
	local var_20_0, var_20_1 = Struct.unpack("<is", arg_20_1)

	if var_20_0 == ObtDebugConst.send_test then
		g.core.module.ModuleManager:tip("测试协议：" .. var_20_1)
	elseif var_20_0 == ObtDebugConst.get_battle_team then
		self:_onGetBattleTeam((json.decode(var_20_1)))
	elseif var_20_0 == ObtDebugConst.get_all_version then
		self:_onGetAllVersion((json.decode(var_20_1)))
	elseif var_20_0 == ObtDebugConst.get_all_battle then
		local var_20_2 = json.decode(var_20_1)

		if var_20_2.tip then
			g.core.module.ModuleManager:tip(var_20_2.tip)
		end

		if var_20_2.config then
			g.core.model.User.obtData:setVersionConfig(var_20_2.config)
		end

		self:_onGetAllBattle(var_20_2.allBattle or {})
	elseif var_20_0 == ObtDebugConst.get_battle_result then
		local var_20_3 = json.decode(var_20_1)

		if var_20_3.tip then
			g.core.module.ModuleManager:tip(var_20_3.tip)
		end

		if var_20_3.resultData then
			g.core.model.User.obtData:setBattleResult(var_20_3.attack, var_20_3.victim, var_20_3.resultData)
			self:_onGetBattleResult()
		end
	elseif var_20_0 == ObtDebugConst.export_csv then
		local var_20_4 = json.decode(var_20_1)

		if var_20_4.tip then
			g.core.module.ModuleManager:tip(var_20_4.tip)
		end

		if var_20_4.dir then
			self.m_exportDir:setText(var_20_4.dir)
		else
			self.m_exportDir:setText(var_20_4.tip or "竟然没收到路径在哪？")
		end
	elseif var_20_0 == ObtDebugConst.keep_alive then
		local var_20_6 = json.decode(var_20_1)

		self._serverAliveTime = var_20_6.serverTime and var_20_6.serverTime or os.time()
	end
end

function ObtClient:_onGetBattleTeam(arg_21_1)
	if arg_21_1.battleTeam then
		g.core.model.User.obtData:setUserBattleTeamIndex(arg_21_1.battleTeam, arg_21_1.index)
		g.core.model.User.obtData:setUserBattleTeamUid(arg_21_1.battleTeam, (arg_21_1.battleTeam.user or {}).id or arg_21_1.index)
	end

	self.m_allBattleList:refreshVirtualList()
	self:updateBattle()
end

function ObtClient:_onGetAllBattle(arg_22_1)
	g.core.model.User.obtData:setAllBattle(arg_22_1)
	self.m_allBattleList:setNumItems(#arg_22_1)
	self:updateBattle()
end

function ObtClient:_onGetBattleResult()
	self.m_allBattleList:refreshVirtualList()
	self:updateBattle()
end

function ObtClient:_onGetAllVersion(arg_24_1)
	self._versionList = {}
	self._allVersionData = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		local var_24_0 = string.match(iter_24_0, "%d+")

		table.insert(self._versionList, tostring(var_24_0))

		self._allVersionData[var_24_0] = iter_24_1
	end

	self.m_versionSelectComp:refresh()
	self.m_versionSelectComp:setItems(self._versionList)
	g.core.module.ModuleManager:tip("获取数据成功")
end

function ObtClient:_onClickVersion()
	local var_25_0 = tonumber(self._versionList[self.m_versionSelectComp:getSelectedIndex() + 1]) or 0

	if var_25_0 > 0 and var_25_0 ~= self._curVersion then
		self._curVersion = var_25_0

		g.core.model.User.obtData:setVersion(self._curVersion)
		self.m_hasVersionController:setSelectedIndex(1)
		self:send(ObtDebugConst.get_all_battle, self._curVersion)
	end
end

function ObtClient:updateBattle()
	local var_26_0 = g.core.model.User.obtData:getBattle(self._selectBattleIndex)

	if var_26_0 then
		self.m_attackTeam:updateBattleTeam((g.core.model.User.obtData:getUserBattleTeamIndex(var_26_0.attack)))
		self.m_victimTeam:updateBattleTeam((g.core.model.User.obtData:getUserBattleTeamIndex(var_26_0.victim)))
		self.m_resultComp:updateBattleResult(var_26_0, (g.core.model.User.obtData:getBattleResult(var_26_0.attack, var_26_0.victim)))
	elseif self._selectBattleIndex > 0 then
		g.core.module.ModuleManager:tip("未找到这场战斗:" .. self._selectBattleIndex)
		dump("未找到这场战斗:" .. self._selectBattleIndex)
	end
end

return ObtClient
