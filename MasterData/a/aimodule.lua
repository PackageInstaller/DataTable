--- AI 模块入口：注册、创建、开战演示
--- 战斗框架仅通过本模块与 AI 交互，便于整体迁移
local AIModule = {}

local AIConst = require("AIConst")
local AILog = require("AILog")
local AutoChessAIContext = require("AutoChessAIContext")

---@type table<string, string> 逻辑名 -> require 模块名
local registry = {
	[AIConst.DEFAULT_AI] = AIConst.DEFAULT_AI,
}

---注册 AI 脚本名 → require 模块名
---@param logicName string 如 AI_Default
---@param moduleName string? require 名，默认同 logicName
function AIModule.Register(logicName, moduleName)
	registry[logicName] = moduleName or logicName
end

---解析 AI 名，空则回退 AI_Default
---@param logicName string?
---@return string
function AIModule.ResolveName(logicName)
	if string.isNullOrEmpty(logicName) then
		return AIConst.DEFAULT_AI
	end
	return logicName
end

---为实体创建 AI 上下文（桥接 AutoChess 框架）
---@param entity AutoChessEntity
---@return AutoChessAIContext
function AIModule.CreateContext(entity)
	return AutoChessAIContext:new(entity)
end

---按逻辑名实例化 AI 行为类（AIBase 子类）
---@param logicName string?
---@param ctx AutoChessAIContext
---@return AIBase
function AIModule.CreateHandler(logicName, ctx)
	logicName = AIModule.ResolveName(logicName)
	local moduleName = registry[logicName] or logicName
	local AIClass = require(moduleName)
	return AIClass:new(ctx)
end

---当前是否 AI 演示战斗且进行中
---@return boolean
function AIModule.IsEnabled()
	local mgr = AutoChessManager.instance()
	return mgr.isBattleing and mgr.isAIBattle
end

---开关 AI 战斗标记（isAIBattle）
---@param enabled boolean
function AIModule.SetEnabled(enabled)
	AutoChessManager.instance().isAIBattle = enabled
end

--- 解析 AI 测试用友方编队：优先当前场景 side=1 单位，否则读存档
---@param mgr AutoChessManager
---@return AutoChessEntityInfo[]
---@return table? mapData
local function resolveAllyFormations(mgr)
	local allies = mgr:CollectAllyFormationsFromScene()
	local saved = mgr:LoadBattleInfo()
	local mapData = mgr:GetEditorMapData() or (saved and saved.map) or mgr.map.map
	if #allies > 0 then
		return allies, mapData
	end
	if saved ~= nil and saved.entitys ~= nil then
		for i = 1, #saved.entitys do
			local d = saved.entitys[i]
			if d.side == nil or d.side == 1 then
				table.insert(allies, tablex.copy(d, true))
			end
		end
		mapData = saved.map or mapData
	end
	return allies, mapData
end

--- AI 演示开战：按当前编队（或存档）生成双方镜像
function AIModule.StartDemoBattle()
	local mgr = AutoChessManager.instance()
	if mgr.isBattleing then
		AILog.Print("AIModule", "#FF6666", "已在战斗中，请先结束当前战斗")
		return
	end
	local allies, mapData = resolveAllyFormations(mgr)
	if mapData == nil then
		AILog.Print("AIModule", "#FF6666", "无地图数据")
		return
	end
	if #allies == 0 then
		AILog.Print("AIModule", "#FF6666", "无友方编队：请放置 side=1 角色后开战，或先保存编队")
		return
	end
	AILog.StartSession(string.format("AI Demo Battle allies=%d editorMap=%dx%d", #allies, #mapData[1], #mapData))
	AILog.Print("AIModule", "#33FF66", "AI 开战 友方单位数=%s", #allies)
	mgr:SavePreBattleSnapshot(allies, mapData)
	mgr.isAIBattle = true
	mgr:ClearAllEntities()
	mgr:ResetEntityUID()
	local halfW = #mapData[1]
	local w = mgr:ExpandBattleMap(mapData)
	local ew, eh = mgr.map:GetMapSize()
	AILog.DumpWalkMap(mgr.map.map, string.format("镜像地图 editor=%dx%d -> battle=%dx%d", halfW, #mapData, ew, eh))
	for i = 1, #allies do
		local src = allies[i]
		local allyData = tablex.copy(src, true)
		if allyData.gridPos ~= nil and allyData.gridPos.x > halfW then
			allyData.gridPos.x = 2 * halfW - allyData.gridPos.x + 1
		end
		allyData.uid = mgr:GetEntityUID()
		allyData.side = 1
		allyData.dir = allyData.dir or { x = 1, y = 0 }
		mgr:CreateEntity(allyData)
		local enemyData = tablex.copy(allyData, true)
		enemyData.uid = mgr:GetEntityUID()
		enemyData.side = 2
		enemyData.gridPos = {
			x = 2 * w - allyData.gridPos.x + 1,
			y = allyData.gridPos.y,
		}
		enemyData.dir = { x = -1, y = 0 }
		mgr:CreateEntity(enemyData)
	end
	mgr:FinishBattleStart()
end

---手动导出当前 AI 日志（不结束战斗）
---@return string?
function AIModule.ExportLog()
	local AILog = require("AILog")
	if not AILog.IsEnabled() or not AILog.IsRecording() then
		return nil
	end
	if AILog.Flush() then
		local path = AILog.GetFilePath()
		LuaLogger.ds(string.format("[AILog] 中途导出 (%d 行) -> %s", AILog.GetLineCount(), path))
		return path
	end
	return nil
end

---结束 AI 日志会话
---@param footer string?
---@return string?
function AIModule.EndLogSession(footer)
	return require("AILog").EndSession(footer)
end

return AIModule
