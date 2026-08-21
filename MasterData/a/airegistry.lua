--- 英雄 / 舰种 → AI 脚本名映射
--- 优先级：英雄表 aiScript > 英雄表 restraintType 舰种默认 > 本地 Register 兜底
local AIRegistry = {}

--- 舰种 restraintType → AI 名（英雄表未配 aiScript 时使用，待需求确认后填写）
local restraintTypeAI = {
}
--- 英雄 id → AI 名（仅开发/过渡兜底，正式以英雄表为准）
local heroIdAI = {}

---@param aiScript string?
---@return string?
local function normalizeAiScript(aiScript)
	if aiScript == nil or aiScript == "" then
		return nil
	end
	if string.isNullOrEmpty(aiScript) then
		return nil
	end
	return aiScript
end

--- 从英雄表配置解析 AI 脚本名
---@param heroId integer?
---@param heroCfg AutoChessHeroTable?
---@return string? 未配置时返回 nil，由 AIModule 使用 AI_Default
function AIRegistry.ResolveForHero(heroId, heroCfg)
	if heroCfg ~= nil then
		local fromTable = normalizeAiScript(heroCfg.aiScript)
		if fromTable ~= nil then
			return fromTable
		end
		local restraintType = heroCfg.restraintType
		if restraintType ~= nil and restraintTypeAI[restraintType] ~= nil then
			return restraintTypeAI[restraintType]
		end
	end
	if heroId ~= nil and heroIdAI[heroId] ~= nil then
		return heroIdAI[heroId]
	end
	return nil
end

--- 注册舰种默认 AI（表未配 aiScript 时按 restraintType 回落）
---@param restraintType integer
---@param logicName string
function AIRegistry.RegisterRestraintType(restraintType, logicName)
	restraintTypeAI[restraintType] = logicName
end

--- 注册英雄 id 兜底 AI（过渡用，优先改英雄表 aiScript）
---@param heroId integer
---@param logicName string
function AIRegistry.RegisterHero(heroId, logicName)
	heroIdAI[heroId] = logicName
end

--- 注册 AI 模块到 AIModule（新 AI 脚本加完后调用一次）
---@param logicName string
function AIRegistry.RegisterAIModule(logicName)
	require("AIModule").Register(logicName)
end

return AIRegistry
