require "class"
---@class BattleHistoryManager
local BattleHistoryManager = class("BattleHistoryManager")
local BattleCore = require "BattleCore"

function BattleHistoryManager:ctor()
	BattleCore.ds("BattleHistoryManager ctor")
	self._isInit = false
	self._historyDic = {}
end

---历史数据
-- local HistroyData = {
--	mainRole = role,
-- 	battleData = {},
-- 	rolesData = {},
-- 	mapData = {}
-- }

---实例化
---@return BattleHistoryManager
function BattleHistoryManager.instance()
	if (BattleHistoryManager._instance == nil) then
		BattleHistoryManager._instance = BattleHistoryManager:new()
	end
	return BattleHistoryManager._instance
end

---初始化管理器
function BattleHistoryManager:initManager()
	---@type table<integer, HistroyData[]>
	self._historyDic = {}
	self._isInit = true
end

---添加历史数据
---@param round integer 回合
---@param data HistroyData 数据
function BattleHistoryManager:addHistoryData(round, data)
	if (not self._historyDic[round]) then
		self._historyDic[round] = {}
	end
	table.insert(self._historyDic[round], data)
end

---获取历史数据
---@param round integer 回合
---@param index integer 序号
---@return HistroyData? 数据
function BattleHistoryManager:getHistoryData(round, index)
	BattleCore.ds("BattleHistoryManager:getHistoryData",round, index)
	if (self._historyDic[round] and self._historyDic[round][index]) then
		local d = self._historyDic[round][index]
		return d
	end
	return nil
end

---获取最后回合数
---@return integer round 回合
function BattleHistoryManager:getLastRound()
	return tablex.size(self._historyDic)
end

function BattleHistoryManager:checkHasHistoryData()
	return tablex.next(self._historyDic) ~= nil
end

---通过回合获取历史数据列表
---@param round integer 回合
---@return HistroyData[] 数据列表
function BattleHistoryManager:getDataListByRound(round)
	-- LuaLogger.ds("BattleHistoryManager:getDataListByRound self._historyDic",tablex.dump(self._historyDic))
	return self._historyDic[round]
end

---裁剪后续数据（回溯后）
---@param round integer 回合
---@param index integer 序号
function BattleHistoryManager:cutAfterData(round, index)
	BattleCore.ds("BattleHistoryManager:cutAfterData", round, index)
	for key, value in pairs(self._historyDic) do
		if (key > round) then
			BattleCore.ds("BattleHistoryManager:cutAfterData after round")
			self._historyDic[key] = nil
		elseif (key == round) then
			BattleCore.ds("BattleHistoryManager:cutAfterData curround", #value)
			for i = #value, 1, -1 do
				print("BattleHistoryManager:cutAfterData index", i)
				if (i >= index) then
					BattleCore.ds("BattleHistoryManager:cutAfterData curround after index")
					table.remove(value, i)
				end
			end
		end
	end
	local battleMgr = BattleCore:getBattleMgr()
	battleMgr:getReporter():cutAfterOrder(round, index)
	battleMgr:getReporter():cutAfterReport(round, index)
end

---切换历史数据中的主要角色
---@param roleId integer 角色ID
function BattleHistoryManager:switchMainRoleInHistory(roleId)
	local roundData = self._historyDic[#self._historyDic]
	if not roundData then
		return
	end
	roundData[#roundData].mainRole = roleId
end

return BattleHistoryManager