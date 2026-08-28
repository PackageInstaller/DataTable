-------------------------------------------------------------------------------
-- 和风战牌 - 游戏数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-02 14:03:15
-------------------------------------------------------------------------------

local KLobbyClientEx           = CS.Engine.Network.KLobbyClientEx
local BattleCardGameUtils      = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local BattleCardGamePlayerDojo = import('Game.Dojo.BattleCardGame.BattleCardGamePlayerDojo')
local BattleCardGameBoardDojo  = import('Game.Dojo.BattleCardGame.BattleCardGameBoardDojo')
local BattleCardGameRuleDojo   = import('Game.Dojo.BattleCardGame.BattleCardGameRuleDojo')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGamePlayDojo : BaseDojo
---@field New fun():BattleCardGamePlayDojo
local BattleCardGamePlayDojo = Class('BattleCardGamePlayDojo', BaseDojo)


function BattleCardGamePlayDojo:__init()
    ---@type integer @ 房间id
    self.roomId = 0

    ---@type integer @ npc关卡id
    self.npcQuestId = 0

    ---@type BattleCardGamePlayerDojo @ 玩家数据
    self.operatorDojo = BattleCardGamePlayerDojo.New()

    ---@type BattleCardGamePlayerDojo @ 对手数据
    self.opponentDojo = BattleCardGamePlayerDojo.New()

    ---@type integer[] @ 规则id列表
    self.ruleIdList = {}

    ---@type table[] @ 初始规则效果（战前规则）
    self.initRuleEffects = {}

    ---@type BattleCardGameRuleDojo @ 规则数据
    self.gameRuleDojo = BattleCardGameRuleDojo.New(self)

    ---@type BattleCardGameBoardDojo[] @ 棋盘数据
    self.boardDojoList = {}

    local boardIndex = 1
    for row = 1, BattleCardGameUtils.PlayDefines.BOARD_ROWS do
        for col = 1, BattleCardGameUtils.PlayDefines.BOARD_COLS do
            local boardDojo  = BattleCardGameBoardDojo.New()
            boardDojo.rowNum = row
            boardDojo.colNum = col
            boardDojo.siteId = boardIndex
            self.boardDojoList[boardIndex] = boardDojo
            boardIndex = boardIndex + 1
        end
    end

    ---@type integer @ 当前回合玩家id
    self.roundPlayerId = 0

    ---@type integer @ 回合的总秒数
    self.roundSeconds_ = 0

    ---@type number @ 切换回合的时间点
    self.roundTiming_ = 0

    ---@type table[] @ 待处理的时间结果列表
    self.eventResults = {}

    ---@type BattleCardGameUtils.PlayResult @ 游戏结果类型
    self.resultType = BattleCardGameUtils.PlayResult.NONE

    ---@type boolean @ 本剧游戏是否结束
    self.isGameOver = false
end


function BattleCardGamePlayDojo:__delete()
    self.roomId          = nil
    self.npcQuestId      = nil
    self.ruleIdList      = nil
    self.operatorDojo    = nil
    self.opponentDojo    = nil
    self.gameRuleDojo    = nil
    self.boardDojoList   = nil
    self.roundPlayerId   = nil
    self.initRuleEffects = nil
    self.roundSeconds_   = nil
    self.roundTiming_    = nil
    self.eventResults    = nil
    self.resultType      = nil
    self.isGameOver      = nil
end


function BattleCardGamePlayDojo:Cleanup()
    self.operatorDojo:Cleanup()
    self.opponentDojo:Cleanup()
    self.gameRuleDojo:Cleanup()

    for _, boardDojo in ipairs(self.boardDojoList) do
        boardDojo:Cleanup()
    end

    self.roomId          = 0
    self.npcQuestId      = 0
    self.ruleIdList      = {}
    self.initRuleEffects = {}
    self.roundPlayerId   = 0
    self.roundSeconds_   = 0
    self.roundTiming_    = 0
    self.eventResults    = {}
    self.resultType      = BattleCardGameUtils.PlayResult.NONE
    self.isGameOver      = false
end


--- 是否 当前为玩家回合
---@return boolean
function BattleCardGamePlayDojo:IsOperatorRound()
    return self.roundPlayerId == self.operatorDojo.playerId
end


--- 切换回合信息
---@param roundSeconds integer @ 回合时长
---@param roundPlayerId integer @ 回合玩家id
function BattleCardGamePlayDojo:SwitchRoundInfo(roundSeconds, roundPlayerId)
    self.roundTiming_  = KLobbyClientEx.clientTime / 1000
    self.roundSeconds_ = checkInt(roundSeconds)
    self.roundPlayerId = checkInt(roundPlayerId)
end


--- 设置 当前回合剩余秒数
---@param leftSeconds integer
function BattleCardGamePlayDojo:SetLeftRoundSeconds(leftSeconds)
    local passedTime  = self.rounSounds_ - checkInt(leftSeconds)
    self.roundTiming_ = KLobbyClientEx.clientTime - passedTime
end


--- 获取 当前回合剩余秒数
---@return integer
function BattleCardGamePlayDojo:GetLeftRoundSeconds()
    return checkInt(math.max((self.roundTiming_ + self.roundSeconds_) - (KLobbyClientEx.clientTime / 1000), 0))
end


--- 获取 当前回合总时长
---@return integer
function BattleCardGamePlayDojo:GetTotalRoundSeconds()
    return self.roundSeconds_
end


--- 是否 填充满全部棋盘
---@return boolean
function BattleCardGamePlayDojo:IsFilledAllBoard()
    local isFilledAllBoard = true
    for _, boardDojo in ipairs(self.boardDojoList) do
        if boardDojo:IsEmpty() then
            isFilledAllBoard = false
            break
        end
    end
    return isFilledAllBoard
end


--- 获取 当前玩家分数
---@return integer
function BattleCardGamePlayDojo:GetOperatorScore()
    return self:CalculatePlayerScore_(self.operatorDojo)
end


--- 获取 当前对手分数
---@return integer
function BattleCardGamePlayDojo:GetOpponentScore()
    return self:CalculatePlayerScore_(self.opponentDojo)
end


--- 判断 本局是否胜利
---@return boolean
function BattleCardGamePlayDojo:IsPlayResultWin()
    return self.resultType == BattleCardGameUtils.PlayResult.WIN
end


--- 解析 规则游戏规则
function BattleCardGamePlayDojo:ParseGameRules()
    self.gameRuleDojo:ParseGameInitRules()
end


-------------------------------------------------
-- private

--- 计算玩家当前分数（棋盘上的属于自己的卡 + 剩余的手牌）
---@param playerDojo BattleCardGamePlayerDojo
function BattleCardGamePlayDojo:CalculatePlayerScore_(playerDojo)
    local boardCards = 0
    local leftCards  = 0
    if playerDojo and checkInt(playerDojo.playerId) ~= 0 then
        local playerId = checkInt(playerDojo.playerId)
        for _, boardDojo in ipairs(self.boardDojoList) do
            if boardDojo.ownerId == playerId then
                boardCards = boardCards + 1
            end
        end
        leftCards = #playerDojo.handCards - #playerDojo.playCards
    end
    return boardCards + leftCards
end


return BattleCardGamePlayDojo
