-------------------------------------------------------------------------------
-- 和风战牌 - 逻辑模块
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 16:55:17
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local ECSComponent = import('Frame.ECS.ECSComponent')

---@class BattleCardGameComponent : ECSComponent
local BattleCardGameComponent = Class('BattleCardGameComponent', ECSComponent)


function BattleCardGameComponent:__init()
    self.name = 'BattleCardGameComponent'

    ---@type BattleCardGameHomeDojo
    self.homeDojo_ = import('Game.Dojo.BattleCardGame.BattleCardGameHomeDojo').New()

    ---@type BattleCardGameHpDojo
    self.hpDojo_ = import('Game.Dojo.BattleCardGame.BattleCardGameHpDojo').New()

    ---@type BattleCardGamePlayDojo
    self.playDojo_ = import('Game.Dojo.BattleCardGame.BattleCardGamePlayDojo').New()

    ---@type BattleCardGameSocketClient
    self.client_ = import('Game.UI.BattleCardGame.BattleCardGameSocketClient').New()

    ---@type Engine.Modules.CDTimerModule
    self.hpCdTimer_ = nil
end


function BattleCardGameComponent:__delete()
    self:HpCountdownClean_()

    if self.client_ then
        self.client_:SocketDestory()
        self.client_ = nil
    end

    self.playDojo_ = nil
    self.homeDojo_ = nil
    self.hpDojo_   = nil
end


-------------------------------------------------
-- get / set

---@return BattleCardGameHomeDojo
function BattleCardGameComponent:GetHomeDojo()
    return self.homeDojo_
end


---@return BattleCardGameHpDojo
function BattleCardGameComponent:GetHpDojo()
    return self.hpDojo_
end


---@return BattleCardGamePlayDojo
function BattleCardGameComponent:GetPlayDojo()
    return self.playDojo_
end


---@return BattleCardGameSocketClient
function BattleCardGameComponent:GetClient()
    return self.client_
end


-------------------------------------------------------------------------------
-- home data
-------------------------------------------------------------------------------

--- 请求 和风战牌 入口数据
---@param callback fun():void | nil
function BattleCardGameComponent:SyncHomeData(callback)
    GameUtils.Request(Interfaces.BattleCardGameHome, {}, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- update homeDojo
            local responseData = checkTable(response.data)
            self:GetHomeDojo():Fill(responseData)

            -- upodate hpDojo
            self:SnycHpData(responseData.hp)

            -- check redPoint
            self:CheckCollectionRed()

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


-------------------------------------------------------------------------------
-- deck data
-------------------------------------------------------------------------------

--- 请求 和风战牌 保存牌组
---@param deckId integer
---@param cardIdList integer[]
---@param callback fun():void | nil
function BattleCardGameComponent:SaveDeckData(deckId, cardIdList, callback)
    local requestData = {deckId = checkInt(deckId), battleCards = table.concat(cardIdList, ',')}
    GameUtils.Request(Interfaces.BattleCardGameSaveDeck, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- update deckData
            self:GetHomeDojo():SaveDeckCards(deckId, cardIdList)

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


-------------------------------------------------------------------------------
-- collect data
-------------------------------------------------------------------------------

--- 请求 和风战牌 领取收集奖励
---@param collectId integer
---@param callback fun():void | nil
function BattleCardGameComponent:DrawCollection(collectId, callback)
    local requestData = {collectId = checkInt(collectId)}
    GameUtils.Request(Interfaces.BattleCardGameDrawCollect, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then

            local responseData = checkTable(response.data)

            -- update darwCollect
            self:GetHomeDojo():SaveDrawCollect(collectId)

            -- draw rewards
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList, true)

            -- show rewards
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})

            -- check redPoint
            self:CheckCollectionRed()

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


-------------------------------------------------------------------------------
-- hp data
-------------------------------------------------------------------------------

--- 同步 和风战牌 体力数据
---@param hpData table
---@param callback fun():void | nil
function BattleCardGameComponent:SnycHpData(hpData, callback)
    -- update hp data
    self:GetHpDojo():Fill(hpData)

    -- check countdown
    if self:GetHpDojo().recoverTime > 0 then
        self:HpCountdownStart_()
    else
        self:HpCountdownClean_()
    end

    -- done callback
    if callback then
        callback()
    end
end


function BattleCardGameComponent:HpCountdownClean_()
    if self.hpCdTimer_ then
        CfUtils.CDTimerRemove(self.hpCdTimer_)
        self.hpCdTimer_ = nil
    end
end


function BattleCardGameComponent:HpCountdownStart_()
    self:HpCountdownClean_()
    
    local countdownTime = math.max(self:GetHpDojo().recoverTime, 1)
    self.hpCdTimer_ = CfUtils.CDTimerAppend(1, countdownTime, false, true, function(count, timerId, elapsed)

        -- update time
        self:GetHpDojo().recoverTime = self:GetHpDojo().recoverTime - elapsed

        -- send event
        if Events.HasListener(Constants.EventNames.BATTLE_CARD_GAME_HP_CD_CHANGE) then
            Events.Broadcast(Constants.EventNames.BATTLE_CARD_GAME_HP_CD_CHANGE)
        end

        -- check ended
        if count <= 0 then
            self:SyncHomeData()
        end
    end)
end


-- 显示购买体力
function BattleCardGameComponent:ShowBuyActivityHp()
    local buyTimes  = self:GetHpDojo().buyTimes
    local buyLimit  = self:GetHpDojo().buyLimit
    local buyTips   = localize('今日剩余兑换次数: _num_', {_num_ = buyLimit - buyTimes})
    local priceData = {
        currency = self:GetHpDojo().consumeData.goodsId,
        current  = self:GetHpDojo().consumeData.num,
    }
    CfUtils.DialogOpen(Constants.UITypeIds.UICommonBuyItemDialog, {
        goodsId      = self:GetHpDojo().hpGoodsId,
        goodsNum     = self:GetHpDojo().recoverNum,
        maxHaveNum   = self:GetHpDojo().hpLimit,
        prices       = { priceData },
        maxBuyNum    = buyTimes >= buyLimit and 0 or 1,
        activityTips = buyTips,
        isShowNum    = true,
        buyCb        = function(price, buyNum)
            local requestData = {activityUuid = self:GetHomeDojo().activityUuid}
            GameUtils.Request(Interfaces.BattleCardGameBuyHp, requestData, function(request, response)

                local responseData = checkTable(response.data)

                -- update hpData
                self:SnycHpData(responseData.hp)

                -- consume goods
                local consumeList = checkTable(responseData.consume)
                GoodsUtils.ConsumeGoods(consumeList, true)

                -- draw rewards
                local rewardList = checkTable(responseData.rewards)
                -- GoodsUtils.DrawRewards(rewardList, true)  -- 因为 .hp 数据中已经更新了最新的hp值，并且更新了购买次数，所以不能再重复领取奖励

                -- show rewards
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
            end)
        end
    })
end


-------------------------------------------------------------------------------
-- red point
-------------------------------------------------------------------------------

-- 检查牌册是否有奖励红点
function BattleCardGameComponent:CheckCollectionRed()
    local hasCollectionRed = false
    for _, collectionVo in ipairs(BattleCardGameUtils.GetAllCollectionVo()) do
        local hasDrawCollect  = self:GetHomeDojo():HasDrawCollect(collectionVo.collectId)
        local hasCollectAllAt = self:GetHomeDojo():HasCollectAllAt(collectionVo.collectId)
        if not hasDrawCollect and hasCollectAllAt then
            hasCollectionRed = true
            break
        end
    end
    GameUtils.SetRedPointNum(Constants.RedPointConst.BattleCardAlbum, hasCollectionRed and 1 or 0)
    GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.BattleCardAlbum)
end


return BattleCardGameComponent
