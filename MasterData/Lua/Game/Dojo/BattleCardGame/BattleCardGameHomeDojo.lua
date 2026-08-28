-------------------------------------------------------------------------------
-- 和风战牌 - 主页数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-18 16:46:21
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGameHomeDojo : BaseDojo
---@field New fun():BattleCardGameHomeDojo
local BattleCardGameHomeDojo = Class('BattleCardGameHomeDojo', BaseDojo)


function BattleCardGameHomeDojo:__init()
    ---@type integer @ 活动唯一id
    self.activityUuid = 0

    ---@type integer @ 总表排期id
    self.scheduleId = 0

    ---@type integer[] @ 主界面展示卡牌列表
    self.homeShowCards = {}

    ---@type table<string, integer[]> @ 牌组数据（key：牌组id，value：卡牌id列表）
    self.cardDeckMap = {}

    ---@type table<integer, BattleCardGameQuestDojo> @ 关卡数据map（key：npcId，value：关卡dojo）
    self.questDojoMap = {}

    ---@type table<integer, boolean> @ 拥有的战牌
    self.cardIdMap = {}

    ---@type table<integer, boolean> @ 已领取的牌册奖励
    self.collectIdMap = {}

    ---@type string @ 长连接服务器地址（格式：xxx.xxx.xxx.xxx:xxxx）
    self.socketHost = ''

    ---@type integer @ 牌组等级
    self.deckLevel_ = 0

    ---@type boolean @ 是否为静默模式（防止初始home数据时繁触发事件）
    self.isMuteMode_ = false
end


function BattleCardGameHomeDojo:__delete()
    self.activityUuid  = nil
    self.scheduleId    = nil
    self.homeShowCards = nil
    self.cardDeckMap   = nil
    self.questDojoMap  = nil
    self.cardIdMap     = nil
    self.collectIdMap  = nil
    self.socketHost = nil
    self.deckLevel_    = nil
    self.isMuteMode_   = nil
end


---@param jsonData table
---@return BattleCardGameHomeDojo
function BattleCardGameHomeDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    -- mark mute mode
    self.isMuteMode_ = true

    -- 活动唯一id | 总表排期id | 长连接域名
    self.scheduleId   = checkInt(jsonData.scheduleId)
    self.activityUuid = checkInt(jsonData.activityUuid)
    self.socketHost   = checkString(jsonData.battleCardHost)

    -- 主界面展示卡牌
    self.homeShowCards = {}
    for showCardIndex, battleCardId in ipairs(string.split2(jsonData.homeShowCards, ';')) do
        self.homeShowCards[showCardIndex] = checkInt(battleCardId)
    end

    -- 牌组数据
    self.cardDeckMap = {}
    for deckId, cardIdList in pairs(checkTable(jsonData.deck)) do
        local deckCardIdList = {}
        for _, cardId in ipairs(cardIdList) do
            if checkInt(cardId) > 0 then
                table.insert(deckCardIdList, checkInt(cardId))
            end
        end
        self.cardDeckMap[tostring(deckId)] = deckCardIdList
    end

    -- 关卡数据
    self.questDojoMap = {}
    for questIndex, questData in ipairs(checkTable(jsonData.npc)) do
        local questDojo = import('Game.Dojo.BattleCardGame.BattleCardGameQuestDojo').New()
        questDojo:Fill(questData)
        self.questDojoMap[questDojo.questId] = questDojo
    end

    -- 战牌数据
    self.cardIdMap = {}
    for _, cardId in ipairs(checkTable(jsonData.battleCards)) do
        self.cardIdMap[checkInt(cardId)] = true
    end
    
    -- 收集数据
    self.collectIdMap = {}
    for _, collectId in ipairs(checkTable(jsonData.collects)) do
        self:SaveDrawCollect(collectId)
    end

    -- check others
    self:UpdateDeckLevel_()

    -- clean mute mode
    self.isMuteMode_ = false

    return self
end


-------------------------------------------------
-- about deck

--- 获取指定 牌组的卡牌数据
---@param deckId integer
---@return integer[]
function BattleCardGameHomeDojo:GetDeckCards(deckId)
    return checkTable(self.cardDeckMap[tostring(deckId)])
end


--- 保存指定 牌组卡牌数据
---@param deckId integer
---@param cardIdList integer[]
function BattleCardGameHomeDojo:SaveDeckCards(deckId, cardIdList)
    local deckCardIdList = {}
    for _, cardId in ipairs(cardIdList) do
        if checkInt(cardId) > 0 then
            table.insert(deckCardIdList, checkInt(cardId))
        end
    end
    self.cardDeckMap[tostring(deckId)] = deckCardIdList

    -- check event send
    if not self.isMuteMode_ then
        Events.Broadcast(BattleCardGameUtils.EventsName.DECK_CARDS_CHANGE, {deckId = deckId})
    end
end


function BattleCardGameHomeDojo:UpdateDeckLevel_()
    local oldDeckLevel = self.deckLevel_
    local newDeckLevel = 0

    -- update unlock tips
    local hasCardsNum = self:GetCardsCount()
    ---@param deckInfo BattleCardGameDeckInfoVo
    for _, deckInfo in ipairs(BattleCardGameUtils.GetAllDeckInfoVo()) do
        if hasCardsNum >= deckInfo.collectNum then
            newDeckLevel = deckInfo.deckId
        else
            break
        end
    end
    self.deckLevel_ = newDeckLevel

    -- check event send
    if not self.isMuteMode_ and self.deckLevel_ ~= oldDeckLevel then
        Events.Broadcast(BattleCardGameUtils.EventsName.DECK_LEVEL_CHANGE, {deckLevel = newDeckLevel})
    end
end


---@return integer
function BattleCardGameHomeDojo:GetDeckLevel()
    return checkInt(self.deckLevel_)
end


-------------------------------------------------
-- about card

--- 拥有的卡牌数量
---@return integer
function BattleCardGameHomeDojo:GetCardsCount()
    return table.count(self.cardIdMap)
end


--- 是否拥有 指定卡牌
---@param cardId integer
---@return boolean
function BattleCardGameHomeDojo:HasCardId(cardId)
    return checkBool(self.cardIdMap[checkInt(cardId)])
end


--- 保存记录 指定卡牌
---@param cardId integer
function BattleCardGameHomeDojo:SaveCardId(cardId)
    if self:HasCardId(cardId) then return end

    self.cardIdMap[checkInt(cardId)] = true

    -- check event send
    if not self.isMuteMode_ then
        Events.Broadcast(BattleCardGameUtils.EventsName.HAVE_CARDS_CHANGE, {cardId = cardId})
    end

    -- check deck level
    self:UpdateDeckLevel_()
end


-------------------------------------------------
-- about collect

--- 是否领取 指定收集奖励
---@param collectId integer
---@return boolean
function BattleCardGameHomeDojo:HasDrawCollect(collectId)
    return checkBool(self.collectIdMap[checkInt(collectId)])
end


--- 保存记录 指定收集奖励
---@param cardId integer
function BattleCardGameHomeDojo:SaveDrawCollect(collectId)
    self.collectIdMap[checkInt(collectId)] = true
end


--- 是否集齐 指定收集id的全部卡牌
---@param collectId integer
---@return boolean
function BattleCardGameHomeDojo:HasCollectAllAt(collectId)
    local collectVo = BattleCardGameUtils.GetCollectionVo(collectId)
    local isCollectAll = true
    for _, battleCardId in ipairs(checkTable(collectVo.cardList)) do
        if not self:HasCardId(battleCardId) then
            isCollectAll = false
            break
        end
    end
    return isCollectAll
end


return BattleCardGameHomeDojo
