-------------------------------------------------------------------------------
-- 和风战牌 - 关卡信息
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameNpcQuestVo : SettingRefBase @ AutoIds.IdSetting10006
local BattleCardGameNpcQuestVo = Class('BattleCardGameNpcQuestVo', SettingRefBase)


function BattleCardGameNpcQuestVo:__init()
    ---@type integer @ 关卡id
    self.questId = 0

    ---@type string @ NPC称号
    self.npcTitle = ''

    ---@type string @ NPC名称
    self.npcName = ''

    ---@type integer[][] @ 打牌的卡组（key：序列，value：卡组id列表）
    self.cardDecks = {}

    ---@type integer[] @ 规则列表（对战规则: 填写时会用牌王规则覆盖流行规则，不填写则使用今日排期的流行规则）
    self.questRules = {}

    ---@type integer @ 解锁要求的卡牌收集数量
    self.unlockCount = 0

    ---@type table @ 奖励列表
    self.rewards = {}

    ---@type integer @ 每期活动内奖励限制次数，重开活动后刷新
    self.rewardLimit = 0

    ---@type integer @ 扣除道具id（结算时扣除的体力）
    self.costGoodsId = 0

    ---@type integer @ 扣除道具数量（0为副本关卡，入口界面列表需过滤掉）
    self.costGoodsNum = 0

    ---@type integer[] @ 展示稀有掉落卡
    self.showCards = {}

    ---@type integer @ npc立绘id
    self.npcDrawId = 0

    ---@type integer @ npc头像id
    self.npcHeadAvatar = 0

    ---@type integer @ npc头像框id
    self.npcHeadFrame = 0

    ---@type integer @ npc台词
    self.npcLines = 0
end


function BattleCardGameNpcQuestVo:__delete()
    self.questId       = nil
    self.npcTitle      = nil
    self.npcName       = nil
    self.cardDecks     = nil
    self.questRules    = nil
    self.unlockCount   = nil
    self.rewards       = nil
    self.rewardLimit   = nil
    self.costGoodsId   = nil
    self.costGoodsNum  = nil
    self.showCards     = nil
    self.npcDrawId     = nil
    self.npcHeadAvatar = nil
    self.npcHeadFrame  = nil
    self.npcLines      = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameNpcQuestVo
function BattleCardGameNpcQuestVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.questId        = parse_number(row, 'id')
    self.npcTitle       = parse_localizeText(row, 'title')
    self.npcName        = parse_localizeText(row, 'name')
    self.questRules     = parse_numbers(row, 'rules')
    self.unlockCount    = parse_number(row, 'lockDemand')
    self.rewards        = parse_rewardData(row, 'reward', 'rewardNum')
    self.rewardLimit    = parse_number(row, 'rawardLimit')
    self.costGoodsId    = parse_number(row, 'costItem')
    self.costGoodsNum   = parse_number(row, 'costNum')
    self.showCards      = parse_numbers(row, 'showReward')
    self.npcDrawId      = parse_number(row, 'draw')
    self.npcHeadAvatar  = parse_number(row, 'head')
    self.npcHeadFrame   = parse_number(row, 'headframe')
    self.npcLines       = parse_localizeText(row, 'lines')

    self.cardDecks = {}
    for _, cards in ipairs(parse_strings2(row, 'deck')) do
        local cardList = {}
        for cardIndex, cardId in ipairs(string.split2(cards, ',')) do
            cardList[cardIndex] = checkInt(cardId)
        end
        if #cardList > 0 then
            table.insert(self.cardDecks, cardList)
        end
    end

    return self
end


--- 是否 在初始卡组中
---@return boolean
function BattleCardGameNpcQuestVo:IsInDeck()
    return #self.deckList > 0
end


--- 是否 为测试关卡
---@return boolean
function BattleCardGameNpcQuestVo:IsTestQuest()
    return self.questId > 999900
end


--- 获取 关卡类型
---@return integer
function BattleCardGameNpcQuestVo:GetQuestType()
    local questType = 0
    if #self.showCards > 0 and self.showCards[1] > 0 then
        local cardVo = BattleCardGameUtils.GetCardInfoVo(self.showCards[1])
        questType = checkInt(cardVo.cardKind)
    end
    return questType
end


return BattleCardGameNpcQuestVo
