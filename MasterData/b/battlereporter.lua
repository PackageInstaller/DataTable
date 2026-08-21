require "class"
---@class BattleReporter
local BattleReporter = class("BattleReporter")
local BattleCore = require "BattleCore"

function BattleReporter:ctor()
	BattleCore.ds("BattleReporter:ctor")
	self:init()
end

---@class BattleReporterData
---@field initData OrderReportInitData 初始化数据
---@field orders BaseClientOrderData[] 指令数据
---@field reports table 游戏过程表现战报
---@field result BattleResultType 战斗结果
---@field battleStartData BattleStartInfo? 战斗开始数据
---@field resultData BattleResultData 战斗结果数据
---@field gameData table 完整游戏数据

---初始化
function BattleReporter:init()
	self._lastTriggerId = nil
	---@type BattleReporterData
	self.battleReports = {
		initData = {},
		orders = {},
		-- prepareReports = {},
		reports = {},
		result = GE.BattleResultType.Lose,
		resultData = {},
		gameData = {},
		statistic = {},
		simpleReport = {},
		battleStartData = {}
	}
	self._tempReports = {}	--临时战报（未打包战报）
	self._curReports = {}	--当前战报（未播放战报）
end

---获取战报 （游戏过程战报）
---@return table
function BattleReporter:getReports()
	return self.battleReports.reports
end

---获取战斗结果数据
---@return table
function BattleReporter:getResultData()
	return self.battleReports.resultData
end

-- ---获取准备阶段战报
-- ---@return table
-- function BattleReporter:getPrepareReports()
-- 	return self.battleReports.prepareReports
-- end

---获取当前打包的战报（未播放战报）
---@param getAll boolean 获取所有（包括临时战报）
---@return table
function BattleReporter:getCurrentReports(getAll)
	if getAll then
		self:packStep()
	end
	local r = tablex.clone(self._curReports)
	self:switchCurrentReports()
	return r
end

---切换当前战报至游戏过程战报
function BattleReporter:switchCurrentReports()
	local curReports = self._curReports
	local reports = self.battleReports.reports
	for index = 1, #curReports do
		reports[#reports + 1] = curReports[index]
	end
	self._curReports = {}
end

---将当前未播放的临时战报插入进游戏过程战报
function BattleReporter:clearCurReports()
	self._curReports = {}
end

-- ---切换当前战报至准备阶段战报
-- function BattleReporter:switchCurrentReportsToPrepare()
-- 	self:packStep()
-- 	for index, value in ipairs(self._curReports) do
-- 		table.insert(self.battleReports.prepareReports, tablex.clone(value))
-- 	end
-- 	self._curReports = {}
-- end

---设置初始化数据
---@param data OrderReportInitData
function BattleReporter:setInitData(data)
	self.battleReports.initData = data
end

---设置战斗开始数据
---@param data BattleStartInfo
function BattleReporter:setBattleStartData(data)
	self.battleReports.battleStartData = data
end

---添加战报
---@param type BattleReportType
---@param data table
function BattleReporter:addReport(type, data)
	local battleMgr = BattleCore:getBattleMgr()
	local showMgr = battleMgr:getShowManager()
	if (not showMgr and battleMgr:isVerifyMode()) then
		return
	end
	local roundInfo = battleMgr:getRoundInfo()
	local report = {
		type = type,
		data = data,
		roundInfo = roundInfo
	}

	table.insert(self._tempReports, report)
end

---设置战斗结果
---@param result integer 战斗结果
function BattleReporter:setResult(result)
	self.battleReports.result = result
end

---设置战斗结果数据
---@param data BattleResultData
function BattleReporter:setResultData(data)
	self.battleReports.resultData = data
end

---设置完整游戏数据
---@param data table
function BattleReporter:setGameData(data)
	self.battleReports.gameData = data
end

---设置统计数据
function BattleReporter:setStatistic(roleId, type, value)
	if (not self.battleReports.statistic) then
		return
	end
	local dataId = 10000 + roleId
	if (not self.battleReports.statistic[dataId]) then
		self.battleReports.statistic[dataId] = {}
	end
	if (not self.battleReports.statistic[dataId][type]) then
		self.battleReports.statistic[dataId][type] = 0
	end
	self.battleReports.statistic[dataId][type] = self.battleReports.statistic[dataId][type] + value
end

---设置简易战报数据
function BattleReporter:setSimpleReport(round, roleId, defeatRoleId, isMonster)
	if (not self.battleReports.simpleReport) then
		return
	end
	local roleMgr = BattleCore:getBattleMgr():getRoleManager()
	local role = roleMgr:getRole(roleId)
	local defeatRole = roleMgr:getRole(defeatRoleId)
	local dataId = 10000 + roleId
	local roundId = 20000 + round
	if (not self.battleReports.simpleReport[roundId]) then
		self.battleReports.simpleReport[roundId] = {
			round = round,
			reportList = {},
			monsterReportList = {}
		}
	end
	local repoerData = {
		roleId = roleId,
		roleCid = role and role.cid or 0,
		defeatList = {},
		defeatCidList = {}
	}
	if (isMonster) then
		if (not self.battleReports.simpleReport[roundId].reportList[dataId]) then
			self.battleReports.simpleReport[roundId].reportList[dataId] = repoerData
		end
		table.insert(self.battleReports.simpleReport[roundId].reportList[dataId].defeatList, defeatRoleId)
		table.insert(self.battleReports.simpleReport[roundId].reportList[dataId].defeatCidList, defeatRole and defeatRole.cid or 0)
	else
		if (not self.battleReports.simpleReport[roundId].monsterReportList[dataId]) then
			self.battleReports.simpleReport[roundId].monsterReportList[dataId] = repoerData
		end
		table.insert(self.battleReports.simpleReport[roundId].monsterReportList[dataId].defeatList, defeatRoleId)
		table.insert(self.battleReports.simpleReport[roundId].monsterReportList[dataId].defeatCidList, defeatRole and defeatRole.cid or 0)
	end
end


---打包临时战报
---被打包的战报在表现阶段会已组为单位播放
function BattleReporter:packStep()
	if (next(self._tempReports)) then
		BattleCore.ds("BattleRole:doAffixesByData", "pack step report", debug.traceback())
		local reports_group = self._tempReports
		self._tempReports = {}
		self._curReports[#self._curReports + 1] = reports_group
	end
end

---@class BaseClientOrderData
---@field roundInfo RoundInfo 回合信息
---@field type BattleOrderType 指令类型
---@field data table 指令数据

---添加操作指令
---@param type BattleOrderType
---@param data table
function BattleReporter:addOrder(type, data)
	local battleMgr = BattleCore:getBattleMgr()

	local order = {
		roundInfo = battleMgr:getRoundInfo(),
		type = type,
		data = data,
	}
	table.insert(self.battleReports.orders, order)
end

---裁剪后续指令（回溯后）
function BattleReporter:cutAfterOrder(round, index)
	BattleCore.ds("BattleReporter:cutAfterOrder", round, index)
	for i = #self.battleReports.orders, 1, -1 do
		local roundInfo = self.battleReports.orders[i].roundInfo
		if (roundInfo.round > round or (roundInfo.round == round and roundInfo.index >= index)) then
			table.remove(self.battleReports.orders, i)
		else
			break
		end
	end
end

---导出战报文件
---@param savePath string 文件目录
function BattleReporter:exportReports(savePath)
	BattleCore.ds("BattleReporter:exportReports savePath", savePath)
	local file = io.open(savePath,"w")
	io.output(file)
	-- tablex.dumpSetting.ShowQuote = true
	-- tablex.dumpSetting.ShowIndex = false

	---------------------------------------------------------------------
	--指令战报（只包含关键指令数据，道具数据等）
	local orderReport = {
		battleStartData = self.battleReports.battleStartData,
		initData = self.battleReports.initData,
		orders = self.battleReports.orders,
		result = self.battleReports.result,
		resultData = self.battleReports.resultData,
	}
	-- LuaLogger.ds("BattleReporter:exportReports orderReport", tablex.dump(orderReport))
	io.write("return " .. tablex.dump(orderReport))
	---------------------------------------------------------------------
	--完整战报（包含完整游戏录像数据，关卡数据，方便测试）
	-- io.write("return " .. tablex.dump(self.battleReports))
	---------------------------------------------------------------------
	io.close()
end

function BattleReporter:readLuaReports(reportFile)
	local report = tablex.clone(require(reportFile))
	return report
end

---读取战报文件
function BattleReporter:readReports()
	local report = tablex.clone(require(Config.GameReportPath))
	return report
end

---加载指令战报
---@param orderReport BattleOrderReport 指令战报
function BattleReporter:loadOrderReport(orderReport)
	self.battleReports = {
		initData = orderReport.initData or {},
		orders = orderReport.orders or {},
		-- prepareReports = orderReport.prepareReports or {},
		reports = orderReport.reports or {},
		result = orderReport.result or GE.BattleResultType.Lose,
		resultData = orderReport.resultData or {},
		gameData = orderReport.gameData or {},
	}
end

function BattleReporter:getOrderReport()
	---@type BattleOrderReport
	local orderReport = {
		initData = self.battleReports.initData,
		orders = self:getServeBattleOrders(),
		result = self.battleReports.result,
		resultData = self.battleReports.resultData,
	}
	return tablex.copy(orderReport)
end

function BattleReporter:getServeBattleOrders()
	local serveOrders = {}
	for _, order in ipairs(self.battleReports.orders) do
		local d = {
			type = order.type,
			data = order.data,
		}
		table.insert(serveOrders, d)
	end
	return serveOrders
end

---获取指令
---@return table 指令数组
function BattleReporter:getOrders()
	return self.battleReports.orders
end

---裁剪后续战报（回溯后）
function BattleReporter:cutAfterReport(round, index)
	BattleCore.ds("BattleReporter:cutAfterReport", round, index)
	for i = #self.battleReports.reports, 1, -1 do
		local stepReports = self.battleReports.reports[i]
		for j = #stepReports, 1, -1 do
			local report = stepReports[j]
			if (report.roundInfo.round > round) then
				table.remove(self.battleReports.reports, i)
				break
			elseif (report.roundInfo.round == round and report.roundInfo.index >= index) then
				table.remove(stepReports, j)
			else
				return
			end
		end
	end
end

function BattleReporter:SetLastTriggerId(triggerId)
	self._lastTriggerId = triggerId
end

function BattleReporter:GetLastTriggerId()
	return self._lastTriggerId
end

return BattleReporter