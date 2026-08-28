-------------------------------------------------------------------------------
-- 和风战牌 - 规则数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-18 19:54:54
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGameRuleDojo : BaseDojo
---@field New fun():BattleCardGameRuleDojo
local BattleCardGameRuleDojo = Class('BattleCardGameRuleDojo', BaseDojo)


function BattleCardGameRuleDojo:__init(gamePlayDojo)
    ---@type BattleCardGamePlayDojo
    self.gamePlayDojo_ = gamePlayDojo

    ---@type table[] 初始效果显示数据
    self.initEffectViewDatas = {}

    ---@type boolean @ 是否生效 混乱规则
    self.hasChaosRuleEffects = false

    ---@type boolean @ 是否生效 秩序规则
    self.hasOrderRuleEffects = false

    ---@type boolean @ 是否生效 同盟强化
    self.hasTypeIncreaseRule = false

    ---@type boolean @ 是否生效 同盟弱化
    self.hasTypeDecreaseRule = false

    ---@type table<integer, integer> @ 初始 卡牌额外属性值map（key：卡牌类型，value：额外值）
    self.cardInitExtAttrMap = {}

    ---@type table<integer, integer> @ 游戏中 卡牌额外属性值map（key：卡牌类型，value：额外值）
    self.cardPlayExtAttrMap = {}
end


function BattleCardGameRuleDojo:__delete()
    self.gamePlayDojo_       = nil
    self.initEffectViewDatas = nil
    self.hasChaosRuleEffects = nil
    self.hasOrderRuleEffects = nil
    self.hasTypeIncreaseRule = nil
    self.hasTypeDecreaseRule = nil
    self.cardInitExtAttrMap  = nil
    self.cardPlayExtAttrMap  = nil
end


function BattleCardGameRuleDojo:Cleanup()
    self.initEffectViewDatas = {}
    self.hasChaosRuleEffects = false
    self.hasOrderRuleEffects = false
    self.hasTypeIncreaseRule = false
    self.hasTypeDecreaseRule = false
    self.cardInitExtAttrMap  = {}
    self.cardPlayExtAttrMap  = {}
end


--- 解析 游戏初始规则
function BattleCardGameRuleDojo:ParseGameInitRules()
    local GameRuleEffects = BattleCardGameUtils.RuleEffects
    local initRuleEffects = self.gamePlayDojo_.initRuleEffects
    local operatorDojo    = self.gamePlayDojo_.operatorDojo
    local opponentDojo    = self.gamePlayDojo_.opponentDojo

    for ruldIndex, ruldId in ipairs(self.gamePlayDojo_.ruleIdList) do
        local ruldInfoVo = BattleCardGameUtils.GetRuleInfoVo(ruldId)
        local effectData = { ruldId = ruldId, ruleType = ruldInfoVo.ruleType }

        ------------------------------------------------- 1:明牌
        if ruldInfoVo.ruleType == GameRuleEffects.CARDS_PUBLIC then
            effectData.publicCardNum = ruldInfoVo.targetNum
            
        ------------------------------------------------- 5:交换（只互换一张）
        elseif ruldInfoVo.ruleType == GameRuleEffects.CARDS_SWAP then
            for _, initEffect in ipairs(initRuleEffects) do
                if initEffect.swap then
                    operatorDojo.swapIndex = checkInt(initEffect.swap[tostring(operatorDojo.playerId)])
                    opponentDojo.swapIndex = checkInt(initEffect.swap[tostring(opponentDojo.playerId)])
                    effectData.swapOperatorIndex = operatorDojo.swapIndex
                    effectData.swapOpponentIndex = opponentDojo.swapIndex
                    break
                end
            end
        
        ------------------------------------------------- 2:混乱
        elseif ruldInfoVo.ruleType == GameRuleEffects.ORDER_CHAOS then
            self.hasChaosRuleEffects = true
            for _, initEffect in ipairs(initRuleEffects) do
                if initEffect.chaos then
                    for playIndex, orderIndex in ipairs(initEffect.chaos[tostring(operatorDojo.playerId)]) do
                        operatorDojo.playOrder[playIndex] = checkInt(orderIndex)
                    end
                    for playIndex, orderIndex in ipairs(initEffect.chaos[tostring(opponentDojo.playerId)]) do
                        opponentDojo.playOrder[playIndex] = checkInt(orderIndex)
                    end
                    effectData.operatorPlayOrder = operatorDojo.playOrder
                    effectData.opponentPlayOrder = opponentDojo.playOrder
                    break
                end
            end

        ------------------------------------------------- 6:秩序
        elseif ruldInfoVo.ruleType == GameRuleEffects.ORDER_INDEX then
            self.hasOrderRuleEffects = true
            for playIndex = 1, BattleCardGameUtils.DeckCardCount do
                operatorDojo.playOrder[playIndex] = playIndex
                opponentDojo.playOrder[playIndex] = playIndex
            end
            effectData.operatorPlayOrder = operatorDojo.playOrder
            effectData.opponentPlayOrder = opponentDojo.playOrder

        ------------------------------------------------- 3:王牌杀手 | 7:逆转 | 10:同数 | 11:同数连锁 | 12:加算 | 14:加算连锁
        elseif ruldInfoVo.ruleType == GameRuleEffects.RULE_OVERFLOW
            or ruldInfoVo.ruleType == GameRuleEffects.RULE_REVERSAL
            or ruldInfoVo.ruleType == GameRuleEffects.RULE_SAME
            or ruldInfoVo.ruleType == GameRuleEffects.RULE_SAME_COMBO
            or ruldInfoVo.ruleType == GameRuleEffects.RULE_PLUS
            or ruldInfoVo.ruleType == GameRuleEffects.RULE_PLUS_COMBO then
            -- 目前没表现效果，也不需要加特殊标识处理

        ------------------------------------------------- 4:同盟强化
        elseif ruldInfoVo.ruleType == GameRuleEffects.TYPE_INCREASE then
            self.hasTypeIncreaseRule = true

        ------------------------------------------------- 8:同盟弱化
        elseif ruldInfoVo.ruleType == GameRuleEffects.TYPE_DECREASE then
            self.hasTypeDecreaseRule = true

        ------------------------------------------------- 9:同盟初始强化
        elseif ruldInfoVo.ruleType == GameRuleEffects.TYPE_INC_FIXED then
            local cardType = checkInt(ruldInfoVo.targetId)
            local attrNum  = checkInt(ruldInfoVo.targetNum)
            if cardType > 0 and attrNum > 0 then
                self.cardInitExtAttrMap[cardType] = checkInt(self.cardInitExtAttrMap[cardType]) + attrNum
                effectData.initExtAttrType = cardType
                effectData.initExtAttrNum  = self.cardInitExtAttrMap[cardType]
            end

        ------------------------------------------------- 14:同盟初始弱化
        elseif ruldInfoVo.ruleType == GameRuleEffects.TYPE_DEC_FIXED then
            local cardType = checkInt(ruldInfoVo.targetId)
            local attrNum  = checkInt(ruldInfoVo.targetNum)
            if cardType > 0 and attrNum > 0 then
                self.cardInitExtAttrMap[cardType] = checkInt(self.cardInitExtAttrMap[cardType]) - attrNum
                effectData.initExtAttrType = cardType
                effectData.initExtAttrNum  = self.cardInitExtAttrMap[cardType]
            end

        -------------------------------------------------
        end
        self.initEffectViewDatas[ruldIndex] = effectData
    end
end


--- 解析 当前卡牌属性加减
---@return table<integer, integer>
function BattleCardGameRuleDojo:ParseCardPlayExtAttr()
    self.cardPlayExtAttrMap = {}

    -- parse board cards
    for position, boardDojo in ipairs(self.gamePlayDojo_.boardDojoList) do
        if boardDojo.cardId > 0 then
            local cardVo   = BattleCardGameUtils.GetCardInfoVo(boardDojo.cardId)
            local cardType = checkInt(cardVo.cardKind)
            if cardType > 0 then -- 有属性的才统计
                if self.hasTypeIncreaseRule then
                    self.cardPlayExtAttrMap[cardType] = checkInt(self.cardPlayExtAttrMap[cardType]) + 1
                end
                if self.hasTypeDecreaseRule then
                    self.cardPlayExtAttrMap[cardType] = checkInt(self.cardPlayExtAttrMap[cardType]) - 1
                end
            end
        end
    end

    -- merge init attr
    for cardType, attrNum in pairs(self.cardInitExtAttrMap) do
        self.cardPlayExtAttrMap[cardType] = checkInt(self.cardPlayExtAttrMap[cardType]) + attrNum
    end

    return self.cardPlayExtAttrMap
end


--- 检测 两个属性值是否有差异
---@param oldAttrMap table<string, integer>
---@param newAttrMap table<string, integer>
---@return boolean
function BattleCardGameRuleDojo:CheckAttrMapHasDiff(oldAttrMap, newAttrMap)
    local hasAttrChanged = false
    for attrIndex, attrValue in pairs(newAttrMap) do
        if oldAttrMap[attrIndex] ~= attrValue then
            hasAttrChanged = true
            break
        end
    end
    return hasAttrChanged
end


return BattleCardGameRuleDojo
