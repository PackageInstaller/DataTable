require "class"
---@class LevelTargetsManager
local LevelTargetsManager = class("LevelTargetsManager")
local BattleCore = require "BattleCore"

function LevelTargetsManager:ctor()
	BattleCore.ds("LevelTargetsManager ctor")
	self._isInit = false
	self._targetsStates = {}
end

---实例化
---@return LevelTargetsManager
function LevelTargetsManager.instance()
	if (LevelTargetsManager._instance == nil) then
		LevelTargetsManager._instance = LevelTargetsManager:new()
		LevelTargetsManager._instance:_initTargetsEvent()
	end
	return LevelTargetsManager._instance
end

function LevelTargetsManager:initTargetList()
	---@type table<LevelTargetType,table>
    self._levelTargetList = {
        [GE.LevelTargetType.DefeatAllEnemies] = {
            true,
        },
        [GE.LevelTargetType.OurSideAllDefeated] = {
            true,
        },
        [GE.LevelTargetType.CompleteWithinSpecifiedRound] = {
			true,
            10
        },
		[GE.LevelTargetType.SpecialBattleEvent] = {
            true,
        },
    }
end

---初始化管理器
function LevelTargetsManager:initManager()
	self._targetsStates = {}
end

---初始化目标事件
function LevelTargetsManager:_initTargetsEvent()
	self.targetsEvent = {
		[GE.LevelTargetType.DefeatAllEnemies] = self._defeatAllEnemies,
		[GE.LevelTargetType.DefeatTargetEnemy] = self._defeatTargetEnemy,
		[GE.LevelTargetType.CompleteWithinSpecifiedRound] = self._completeWithinSpecifiedRound,
		[GE.LevelTargetType.OurSideDefeatedLessThan] = self._ourSideDefeatedLessThan,
		[GE.LevelTargetType.OurSideAllDefeated] = self._ourSideAllDefeated,
		[GE.LevelTargetType.SpecialBattleEvent] = self._specialBattleEvent,
	}
	self._isInit = true
end

---是否已完成目标
---@param id integer id
---@param value table 参数
---@return boolean win
---@return boolean lose
function LevelTargetsManager:isTargetFinish(id, value)
	return self.targetsEvent[id](self, value)
end

function LevelTargetsManager:getTargetState(id)
	return self._targetsStates[id]
end

---击败所有敌人(win)
---@return boolean win
---@return boolean lose
function LevelTargetsManager:_defeatAllEnemies()
	local roleMgr = BattleCore:getBattleRoleMgr()
	return #roleMgr:getRolesByCamp(GE.BattleCampType.Enemy) <= 0, false
end

---击败目标敌人(win)
---@return boolean win
---@return boolean lose
function LevelTargetsManager:_defeatTargetEnemy()
	-- local roleMgr = BattleCore:getBattleRoleMgr()
	-- roleMgr:getRole()
	-- return roleMgr:isDefeatTargetEnemy(), false
	return false, false
end

---指定回合前完成关卡(lose)
---@return boolean win
---@return boolean lose
function LevelTargetsManager:_completeWithinSpecifiedRound(value)
	local round = value[2]
	local battleMgr = BattleCore:getBattleMgr()
	if (round <= battleMgr:getCurrentRound()) then
		BattleCore.ds("LevelTargetsManager:_completeWithinSpecifiedRound 失败", round, battleMgr:getCurrentRound())
		return false, true
	end
	-- LuaLogger.ds("LevelTargetsManager:_completeWithinSpecifiedRound 未成功")
	return false, false
end

---我方撤退角色不超过"num"个(lose)
---@return boolean win
---@return boolean lose
function LevelTargetsManager:_ourSideDefeatedLessThan(value)
	return false, false
end

---我方角色全部撤退(lose)
---@return boolean win
---@return boolean lose
function LevelTargetsManager:_ourSideAllDefeated(value)
	local roleMgr = BattleCore:getBattleRoleMgr()
	return false, #roleMgr:getRolesByCamp(GE.BattleCampType.Friend) <= 0
end

---特殊战斗事件(win or lose)
---@return boolean win
---@return boolean lose
function LevelTargetsManager:_specialBattleEvent()
	local eventMgr = BattleCore:getEventMgr()
	local state = eventMgr:getEventLevelTarget()
	return state.isWin, state.isLose
end

function LevelTargetsManager:ChangeFinalRound(value)
	local d = self._levelTargetList[GE.LevelTargetType.CompleteWithinSpecifiedRound]
	d[2] = value
end

---@param targetType LevelTargetType
function LevelTargetsManager:SetLevelTargetActive(targetType, isActive)
	local d = self._levelTargetList[targetType] or {}
	d[1] = isActive
	self._levelTargetList[targetType] = d
end

---胜利失败检测
---@return boolean isResult
function LevelTargetsManager:checkWinLose()
	local win = false
	local lose = false

	local battleMgr = BattleCore:getBattleMgr()

	for targetId, targetData in pairs(self._levelTargetList) do
        if targetData[1] == true then
            win, lose = self:isTargetFinish(targetId, targetData)
        end

		if (win or lose) then break end
	end

	-- LuaLogger.ds("LevelTargetsManager:checkWinLose", win, lose)
	if (win or lose) then
		local result = win and true or false
		battleMgr:setGameResult(result)
		return true
	end
	return false
end

return LevelTargetsManager