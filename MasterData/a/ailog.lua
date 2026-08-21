--- AI 模块日志（Unity 富文本颜色 + 落盘到 txt 便于排查）
---@class AILog
local AILog = {}

local AIConst = require("AIConst")

local C_SEARCH_OK = "#33FF66"
local C_SEARCH_FAIL = "#FFCC33"
local C_MOVE = "#FFAA00"
local C_ATTACK = "#33FF66"
local C_DAMAGE = "#FF5555"
local C_HP = "#FFFFFF"
local C_HP_LOW = "#FFCC33"
local C_HP_ZERO = "#FF4444"
local C_HP_REMAIN = "#66FF99"
local C_DEAD = "#FF2222"
local C_ARROW = "#AAAAAA"
local C_META = "#888888"

---@type string[]
AILog._lines = {}
---@type string?
AILog._filePath = nil
---@type boolean
AILog._enabled = false
---@type string?
AILog._lastWriteError = nil

---@param entity AutoChessEntity?
---@return string label
---@return string color
local function formatUnitColored(entity)
	if entity == nil then
		return "?", "#FFFFFF"
	end
	local side = entity.GetSide and entity:GetSide() or 1
	local color = (side == 2) and "#FF8866" or "#66CCFF"
	local cfg = entity.roleCfg
	if cfg ~= nil and cfg.name ~= nil and cfg.name ~= "" then
		return string.format("s%s·%s", side, cfg.name), color
	end
	return string.format("s%s·%s", side, entity:GetID()), color
end

---@param hp number
---@param maxHp number
---@return string
local function hpAfterColor(hp, maxHp)
	if hp <= 0 then
		return C_HP_ZERO
	end
	if maxHp > 0 and hp / maxHp <= 0.35 then
		return C_HP_LOW
	end
	return C_HP_REMAIN
end

---@return string 带毫秒的时间戳（日志行前缀）
function AILog.GetTimestamp()
	if Time ~= nil and Time.time ~= nil then
		return string.format("%.3f", Time.time)
	end
	return os.date("%H:%M:%S")
end

---@param text string
---@return string
local function stripRichText(text)
	if text == nil then
		return ""
	end
	return (string.gsub(text, "<[^>]+>", ""))
end

---@return string
local function normalizePath(path)
	if path == nil then
		return ""
	end
	return string.gsub(path, "\\", "/")
end

---@return string
local function resolveLogDir()
	local dir
	if GV ~= nil and GV.IsEditor then
		dir = UnityEngine.Application.dataPath .. "/../../../AutoChessAI_Logs"
	else
		dir = DFileUtil.GetPersistentDataPath() .. "/AutoChessAI"
	end
	dir = normalizePath(dir)
	if not DFileUtil.CreateDir(dir) then
		AILog._lastWriteError = "CreateDir failed: " .. dir
	end
	return dir
end

---@param path string
---@param line string
---@param append boolean
---@return boolean
local function writeLineToFile(path, line, append)
	local err = DFileUtil.WriteFile(path, line, append)
	if err ~= nil and err ~= "" then
		AILog._lastWriteError = err
		return false
	end
	return true
end

---@param path string
---@param lines string[]
---@param extraLines string[]?
---@return boolean
local function writeAllLines(path, lines, extraLines)
	if path == nil or path == "" then
		AILog._lastWriteError = "empty path"
		return false
	end
	local append = false
	for i = 1, #lines do
		if not writeLineToFile(path, lines[i], append) then
			return false
		end
		append = true
	end
	if extraLines ~= nil then
		for i = 1, #extraLines do
			if not writeLineToFile(path, extraLines[i], true) then
				return false
			end
		end
	end
	return true
end

---当前日志文件路径（未开始记录时为 nil）
---@return string?
function AILog.GetFilePath()
	return AILog._filePath
end

---日志功能是否开启（读 AIConst.ENABLE_AI_LOG）
---@return boolean
function AILog.IsEnabled()
	return AIConst.ENABLE_AI_LOG == true
end

---是否正在记录会话（已 StartSession 且未 EndSession）
---@return boolean
function AILog.IsRecording()
	return AILog.IsEnabled() and AILog._enabled
end

---追加一行到内存缓冲（带时间戳）
---@param line string
function AILog.AppendLine(line)
	if not AILog.IsEnabled() or not AILog._enabled or line == nil or line == "" then
		return
	end
	local entry = string.format("[%s] %s", AILog.GetTimestamp(), line)
	table.insert(AILog._lines, entry)
end

---@param plainLine string
---@param richLine string
local function emit(plainLine, richLine)
	if not AILog.IsEnabled() then
		return
	end
	AILog.AppendLine(plainLine)
	LuaLogger.ds(richLine)
end

---开始新一轮 AI 日志（开战时调用）
---@param header string?
function AILog.StartSession(header)
	if not AILog.IsEnabled() then
		return
	end
	AILog._enabled = true
	AILog._lines = {}
	AILog._lastWriteError = nil
	local dir = resolveLogDir()
	local stamp = os.date("%Y%m%d_%H%M%S")
	AILog._filePath = normalizePath(string.format("%s/AutoChessAI_%s.txt", dir, stamp))
	local headerLines = {
		"=== AutoChess AI Log ===",
		string.format("Started: %s", os.date("%Y-%m-%d %H:%M:%S")),
	}
	if header ~= nil and header ~= "" then
		table.insert(headerLines, header)
	end
	table.insert(headerLines, string.format("File: %s", AILog._filePath))
	table.insert(headerLines, "")
	for i = 1, #headerLines do
		AILog.AppendLine(headerLines[i])
	end
	local ok = writeAllLines(AILog._filePath, headerLines, nil)
	local tip
	if ok and DFileUtil.FileExists(AILog._filePath) then
		tip = string.format("[AILog] 开始记录 AI 日志 -> %s", AILog._filePath)
	else
		tip = string.format("[AILog] 日志文件创建失败 path=%s err=%s", tostring(AILog._filePath), tostring(AILog._lastWriteError))
		LuaLogger.es(tip)
	end
	LuaLogger.ds(tip)
end

---将可走图落盘（0/.=可走，非0/#=障碍）
---@param mapData int[][]
---@param label string?
function AILog.DumpWalkMap(mapData, label)
	if not AILog._enabled or mapData == nil then
		return
	end
	local h = #mapData
	local w = h > 0 and #mapData[1] or 0
	AILog.AppendLine(string.format("[地图] %s (%dx%d, .=可走 #=障碍)", label or "walk", w, h))
	for y = 1, h do
		local row = {}
		for x = 1, w do
			local v = mapData[y] and mapData[y][x] or 1
			row[x] = (v == 0) and "." or "#"
		end
		AILog.AppendLine(string.format("%2d: %s", y, table.concat(row)))
	end
	AILog.AppendLine("")
	AILog.Flush()
end

---内存中已缓冲的日志行数
---@return integer
function AILog.GetLineCount()
	return #AILog._lines
end

---把内存中的日志整份写入磁盘
---@param extraLines string[]?
---@return boolean
function AILog.Flush(extraLines)
	if not AILog.IsEnabled() or AILog._filePath == nil then
		AILog._lastWriteError = "no file path"
		return false
	end
	local ok = writeAllLines(AILog._filePath, AILog._lines, extraLines)
	if not ok then
		LuaLogger.es(string.format("[AILog] 写入失败 path=%s err=%s", AILog._filePath, tostring(AILog._lastWriteError)))
		return false
	end
	if not DFileUtil.FileExists(AILog._filePath) then
		AILog._lastWriteError = "file not exists after write"
		LuaLogger.es(string.format("[AILog] 写入后文件不存在 path=%s", AILog._filePath))
		return false
	end
	return true
end

---结束并落盘（战斗结束时可调用）
---@param footer string?
---@return string? filePath
function AILog.EndSession(footer)
	if not AILog._enabled then
		return AILog._filePath
	end
	if footer ~= nil and footer ~= "" then
		AILog.AppendLine(footer)
	end
	local path = AILog._filePath
	local footerLines = {
		"",
		"=== End ===",
		string.format("Ended: %s", os.date("%Y-%m-%d %H:%M:%S")),
	}
	if footer ~= nil and footer ~= "" then
		table.insert(footerLines, footer)
	end
	table.insert(footerLines, string.format("TotalLines: %d", #AILog._lines))
	local ok = AILog.Flush(footerLines)
	local size = (path ~= nil and DFileUtil.FileExists(path)) and DFileUtil.GetFileSize(path) or 0
	if ok then
		LuaLogger.ds(string.format("[AILog] 日志已保存 (%d 行, %d bytes) -> %s", #AILog._lines, size, path))
	else
		LuaLogger.es(string.format("[AILog] 日志保存失败 (%d 行) path=%s err=%s", #AILog._lines, tostring(path), tostring(AILog._lastWriteError)))
	end
	AILog._enabled = false
	return path
end

---通用彩色日志（同时输出到控制台与落盘缓冲）
---@param tag string? 如 AI_Default
---@param color string
---@param fmt string
function AILog.Print(tag, color, fmt, ...)
	tag = tag or "AI"
	local plain = string.format("[%s] " .. fmt, tag, ...)
	local head = string.format("<color=#AAAAAA>[%s]</color>", tag)
	local rich = string.format(head .. " <color=" .. color .. ">" .. fmt .. "</color>", ...)
	emit(plain, rich)
end

--- 攻击成功（测试用，单行关键信息）
---@param casterLabel string 单位标签
---@param targetLabel string 
---@param skillLabel string 如 召唤飞机
function AILog.AttackSuccess(casterLabel, targetLabel, skillLabel)
	local plain = string.format("攻击成功 %s -> %s | %s", casterLabel, targetLabel, skillLabel)
	local rich = string.format(
		"<color=#33FF66>攻击成功</color> <color=#FFFFFF>%s → %s</color> <color=#33CCFF>| %s</color>",
		casterLabel, targetLabel, skillLabel)
	emit(plain, rich)
end

--- 伤害与血量变化（战斗内统一输出）
---@param caster AutoChessEntity?
---@param target AutoChessEntity
---@param damage number
---@param hpBefore number
---@param hpAfter number
---@param maxHp number
---@param isDead boolean
function AILog.Damage(caster, target, damage, hpBefore, hpAfter, maxHp, isDead)
	local casterLabel, casterColor = formatUnitColored(caster)
	local targetLabel, targetColor = formatUnitColored(target)
	local afterColor = hpAfterColor(hpAfter, maxHp)
	local maxStr = maxHp > 0 and tostring(maxHp) or "?"
	local deadTag = isDead and " 击破!" or ""
	local plain = string.format(
		"%s -> %s -%s HP %s->%s/%s%s",
		stripRichText(casterLabel), stripRichText(targetLabel),
		math.floor(damage + 0.5),
		math.floor(hpBefore + 0.5), math.floor(hpAfter + 0.5), maxStr, deadTag)
	local richDead = isDead and string.format(" <color=%s>击破!</color>", C_DEAD) or ""
	local rich = string.format(
		"<color=%s>%s</color> <color=%s>→</color> <color=%s>%s</color>"
		.. " <color=%s>-%s</color> <color=%s>HP</color> <color=%s>%s</color><color=%s>→</color><color=%s>%s</color><color=%s>/%s</color>%s",
		casterColor, casterLabel,
		C_ARROW,
		targetColor, targetLabel,
		C_DAMAGE, math.floor(damage + 0.5),
		C_META,
		C_HP, math.floor(hpBefore + 0.5),
		C_ARROW, afterColor, math.floor(hpAfter + 0.5),
		C_META, maxStr,
		richDead)
	emit(plain, rich)
end

local C_HEAL = "#66FF99"

--- 治疗与血量恢复（baseDamage<0 时）
---@param caster AutoChessEntity?
---@param target AutoChessEntity
---@param healAmount number 技能计算治疗量（正值）
---@param hpBefore number
---@param hpAfter number
---@param maxHp number
---@param skillLabel string?
function AILog.Heal(caster, target, healAmount, hpBefore, hpAfter, maxHp, skillLabel)
	local casterLabel, casterColor = formatUnitColored(caster)
	local targetLabel, targetColor = formatUnitColored(target)
	local actualHeal = math.max(0, math.floor(hpAfter - hpBefore + 0.5))
	local afterColor = hpAfterColor(hpAfter, maxHp)
	local maxStr = maxHp > 0 and tostring(maxHp) or "?"
	local skillTag = (skillLabel ~= nil and skillLabel ~= "") and (" | " .. skillLabel) or ""
	local plain = string.format(
		"加血 %s -> %s +%s HP %s->%s/%s%s",
		stripRichText(casterLabel), stripRichText(targetLabel),
		actualHeal,
		math.floor(hpBefore + 0.5), math.floor(hpAfter + 0.5), maxStr, skillTag)
	local richSkill = (skillLabel ~= nil and skillLabel ~= "")
		and string.format(" <color=#33CCFF>| %s</color>", skillLabel) or ""
	local rich = string.format(
		"<color=%s>加血</color> <color=%s>%s</color> <color=%s>→</color> <color=%s>%s</color>"
		.. " <color=%s>+%s</color> <color=%s>HP</color> <color=%s>%s</color><color=%s>→</color><color=%s>%s</color><color=%s>/%s</color>%s",
		C_HEAL,
		casterColor, casterLabel,
		C_ARROW,
		targetColor, targetLabel,
		C_HEAL, actualHeal,
		C_META,
		C_HP, math.floor(hpBefore + 0.5),
		C_ARROW, afterColor, math.floor(hpAfter + 0.5),
		C_META, maxStr,
		richSkill)
	emit(plain, rich)
end

---索敌成功类日志（绿色）
function AILog.SearchOk(tag, fmt, ...) AILog.Print(tag, C_SEARCH_OK, fmt, ...) end
---索敌失败/未找到类日志（黄色）
function AILog.SearchFail(tag, fmt, ...) AILog.Print(tag, C_SEARCH_FAIL, fmt, ...) end
---移动决策类日志（橙色）
function AILog.Move(tag, fmt, ...) AILog.Print(tag, C_MOVE, fmt, ...) end
---攻击决策类日志（绿色）
function AILog.Attack(tag, fmt, ...) AILog.Print(tag, C_ATTACK, fmt, ...) end

return AILog
