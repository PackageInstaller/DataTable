
-- local CardProgressionEntity    = import("Game.CardProgression.CardProgressionEntity")
local Interfaces = Interfaces

---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")

local Singleton = import('Frame.Singleton')
---@class CardProgressionMgr
---@field GetInstance fun(self:CardProgressionMgr):CardProgressionMgr
local CardProgressionMgr = Class("CardProgressionMgr", Singleton)

function CardProgressionMgr:__init(...)
    self._allCardEntity = nil
end

function CardProgressionMgr:__delete(...)
    self._cardComp  = nil
    self._equipComp = nil
    self._allCardEntity = nil
end

--- GetCardComponent
---@return CardComponent
function CardProgressionMgr:GetCardComp()
    if self._cardComp == nil then
        ---@type CardComponent
        self._cardComp  = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    end
    return self._cardComp
end

--- GetEquipmentComponent
---@return EquipmentComponent
function CardProgressionMgr:GetEquipmentComp()
    if self._equipComp == nil then
        ---@type EquipmentComponent
        self._equipComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
    end
    return self._equipComp
end

--- RequestOverseaCardLevelUp
--- 请求卡牌升级
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardLevelUp(requestData, consumeData, cardDojo)
    return self:RequestInterface(Interfaces.OverseaCardLevelUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local oldDojo = clone(cardDojo)
        local dojo = self:UpdateCardDojo(requestData, responseData)
        
        --- 播放升级语音
        RoleVoiceMgr:GetInstance():PlayRoleLevelUpVoiceByCardId(dojo.cardId, nil, dojo.cardSkin)

        return {oldDojo = oldDojo, dojo = dojo, isLevelUp = true}
    end, consumeData)
end

--- RequestOverseaCardAdvanceLevelUp
--- 请求卡牌进阶
---@param requestData table 请求数据
---@param consumeData table 
---@param cardDojo CardDojo 
function CardProgressionMgr:RequestOverseaCardAdvanceLevelUp(requestData, consumeData, cardDojo, oldCE)
    return self:RequestInterface(Interfaces.OverseaCardAdvanceLevelUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local rewards      = checkTable(responseData.rewards)
        local isUnlockSkin = next(rewards) ~= nil
        local cardSkin
        if isUnlockSkin then
            for i, v in ipairs(rewards) do
                ---@type RewardDojo
                local reward = v
                cardSkin = reward.goodsId
                local goodsType = GoodsUtils.GetIdType(cardSkin)
                if goodsType == Constants.IDType.CardSkin then
                    break
                end
            end
            GoodsUtils.DrawRewards(rewards)
        end

        local advanceLevel = checkNumber(responseData.cardAdvanceLevel)
        local cardSkin     = checkNumber(responseData.cardSkin) 
        local realCardSkin = cardSkin > 0 and cardSkin or nil
        local oldDojo      = clone(cardDojo)
        local dojo         = self:UpdateCardDojo(requestData, {advanceLevel = advanceLevel, cardSkin = realCardSkin})
        
        local ce = FormulaUtils.GetCardFightingStrengthen(dojo)
        if oldCE ~= ce then
            ---@type CardProgressionUtils
            local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
            CardProgressionUtils.ChangePointToast(ce - oldCE)
        end

        return {dojo = dojo, oldDojo = oldDojo, isAdvanceLevelUp = true, isUnlockSkin = isUnlockSkin}
    end, consumeData)
end

--- RequestOverseaCardStarUp
--- 请求卡牌升星
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardStarUp(requestData, consumeData, cardDojo)
    return self:RequestInterface(Interfaces.OverseaCardStarUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        
        local oldDojo = clone(cardDojo)
        ---@type CardDojo
        local dojo = self:UpdateCardDojo(requestData, {
            star = responseData.cardStar, 
            awakeningLevel = responseData.awakeningLevel,
            finalSkillLevel = responseData.finalSkillLevel,
        })

        return {dojo = dojo, isStarUp = true, oldDojo = oldDojo}
    end, consumeData)
end

--- RequestOverseaCardAwakeningLevelUp
--- 卡请求觉醒升级
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardAwakeningLevelUp(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaCardAwakeningLevelUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local dojo = self:UpdateCardDojo(requestData, {awakeningLevel = responseData.awakeningLevel})

        return {dojo = dojo}
    end, consumeData)
end

--- RequestOverseaCardAwakeningLevelUp
--- 卡请求觉醒升级
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardAwakeningSkillLevelUp(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaCardAwakeningSkillLevelUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local dojo = self:UpdateCardDojo(requestData, {awakeningLevel = responseData.awakeningLevel})

        return {dojo = dojo}
    end, consumeData)
end

--- RequestOverseaCardAwakeningLevelUp
--- 卡请求觉醒升级
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardFinalSkillLevelUp(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaCardFinalSkillLevelUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local dojo = self:UpdateCardDojo(requestData, {finalSkillLevel = responseData.finalSkillLevel})

        return {dojo = dojo}
    end, consumeData)
end

--- RequestOverseaCardWeaponUnlock
--- 请求专武解锁
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardWeaponUnlock(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaCardWeaponUnlock, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local dojo = self:UpdateCardDojo(requestData, {weaponUnlocked = 1})

        return {dojo = dojo, isReloadModel = true}
    end, consumeData)
end

--- RequestOverseaCardSkinLevelUp
--- 卡请求皮肤升级
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardSkinLevelUp(requestData, times)
    return self:RequestInterface(Interfaces.OverseaCardSkinLevelUp, requestData, function(responseData)
        local level = responseData.level
        ---@type CardSkinComponent
        local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)

        cardSkinComponent:SetSkinLevelById(requestData.skinId, level)

        cardSkinComponent:AddSkinLevelUpTimes(times)

        local consume = checkTable(responseData.consume)
        GoodsUtils.ConsumeGoods(consume)
        
        return {level = level}
    end)
end

--- RequestOverseaCardChangeSkin
--- 卡请求更换皮肤
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardChangeSkin(requestData)
    return self:RequestInterface(Interfaces.OverseaCardChangeSkin, requestData, function(responseData)
        local dojo = self:UpdateCardDojo(requestData, {cardSkin = requestData.cardSkinId})
        return {dojo = dojo}
    end)
end

--- RequestOverseaCardGift
--- 请求送礼
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardGift(requestData, consumeData, todaySendGiftTimes, favorGiftIdStr)
    return self:RequestInterface(Interfaces.OverseaCardGift, requestData, function(responseData)
        local favorLevel = checkNumber(responseData.favorabilityLevel)
        local dojo = self:UpdateCardDojo(requestData, {favorabilityLevel = favorLevel, favorabilityExp = responseData.favorabilityExp, cafeEnergy = checkNumber(responseData.cafeEnergy), todaySendGiftTimes = todaySendGiftTimes, favorGiftId = favorGiftIdStr})
        
        return {dojo = dojo}
    end, consumeData)
end

--- RequestOverseaCardDrawFavorRewards
--- 领取请求感度奖励
---@param requestData table 请求数据
---@param vo FavorableExpRewardVo
function CardProgressionMgr:RequestOverseaCardDrawFavorRewards(requestData, vo)
    return self:RequestInterface(Interfaces.OverseaCardDrawFavorRewards, requestData, function(responseData)
        ---------------------------------
        --- 更新奖励
        local rewards = responseData.rewards
        GoodsUtils.DrawRewards(responseData.rewards)

        ---------------------------------
        --- 更新卡牌数据
        local level        = vo.level
        local playerCardId = requestData.playerCardId
        ---@type CardComponent
        local comp         = self:GetCardComp()
        ---@type CardDojo
        local cardDojo     = comp:GetCardById(playerCardId)
        cardDojo:AddFavorLv2ReceivedRes(level)
        --
        --if not string.isEmpty(vo.voice) then
        --    local goodsId = checkNumber(CardConfMgr:GetInstance():GetCardProgressionParamsById(CardProgressionConstants.Params.RoleVoiceId))
        --    table.insert(rewards, {goodsId = goodsId, num = 1})
        --end
        --
        --if not string.isEmpty(vo.file) then
        --    local goodsId = checkNumber(CardConfMgr:GetInstance():GetCardProgressionParamsById(CardProgressionConstants.Params.RoleFileId))
        --    table.insert(rewards, {goodsId = goodsId, num = 1})
        --end
        
        return { dojo = cardDojo, rewards = rewards, property = vo.property, level = vo.level }
    end)
end

--- RequestOverseaEquipmentEquip
--- 请求装备
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaEquipmentEquip(requestData, cb)
    return self:RequestInterface(Interfaces.OverseaEquipmentEquip, requestData, function(responseData)
        local cardDojo = self:GetCardComp():GetCardById(requestData.playerCardId)
        Events.Broadcast(Constants.EventNames.EquipmentPresetDialogUpdate)
        if cb then
            cb(responseData)
        end
        return {dojo = cardDojo}
    end)
end

--- RequestOverseaEquipmentLevelUp
--- 请求装备升级
---@param requestData table 请求数据
---@param consumeData table 消耗
function CardProgressionMgr:RequestOverseaEquipmentLevelUp(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaEquipmentLevelUp, requestData, function(responseData)
        GoodsUtils.DrawRewards(consumeData, true)
        local equipComp = self:GetEquipmentComp()
        local befDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        local playerEquipment = checkTable(responseData.playerEquipment)
        equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, playerEquipment)
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local playerDojo = playerComponent.playerDojo
        playerDojo.equipLevelUpTimes = checkInt(playerDojo.equipLevelUpTimes) + 1
        local curDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        --EquipUtils.EnterEquipmentUpgradeFinishDialog(befDojo, curDojo, Constants.UICultivateLevelUpFinishType.Equip)
        Events.Broadcast(Constants.EventNames.CardProgressEquipLevelUpFinish, curDojo)
        return {isReload = true}
    end)
end

--- RequestOverseaEquipmentStarUp
--- 请求装备升星
---@param requestData table 请求数据
---@param consumeData table 消耗
---@param finishType Constants.UICultivateLevelUpFinishType 打脸类型
function CardProgressionMgr:RequestOverseaEquipmentStarUp(requestData, consumeData, finishType, isDisable)
    return self:RequestInterface(Interfaces.OverseaEquipmentStarUp, requestData, function(responseData)
        GoodsUtils.DrawRewards(consumeData, true)
        local equipComp = self:GetEquipmentComp()
        local befDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        local playerEquipment = checkTable(responseData.playerEquipment)
        equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, playerEquipment)
        local curDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        if not isDisable then
            EquipUtils.EnterEquipmentUpgradeFinishDialog(befDojo, curDojo, finishType or Constants.UICultivateLevelUpFinishType.EquipStar)
        else
            Events.Broadcast(Constants.EventNames.CardProgressEquipLadderRiseUpgradeFinish, curDojo)
            
        end
        return {isReload = true}
    end)
end

---请求装备快速升级
function CardProgressionMgr:RequestOverseaEquipmentQuickUpgrade(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaEquipmentOneKeyUp, requestData, function(responseData)
        GoodsUtils.DrawRewards(consumeData, true)
        local equipComp = self:GetEquipmentComp()
        local befDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        local playerEquipment = checkTable(responseData.playerEquipment)
        equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, playerEquipment)
        local curDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        if checkInt(befDojo.star) == checkInt(curDojo.star) then
            Events.Broadcast(Constants.EventNames.CardProgressEquipLevelUpFinish, curDojo)
        else
            EquipUtils.EnterEquipmentUpgradeFinishDialog(befDojo, curDojo, Constants.UICultivateLevelUpFinishType.EquipStar)
        end
        return {isReload = true}
    end)
end

--- RequestOverseaEquipmentStarUp
--- 请求装备刻印
---@param requestData table 请求数据
---@param consumeData table 消耗
function CardProgressionMgr:RequestOverseaEquipmentEngrave(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaEquipmentEngrave, requestData, function(responseData)
        GoodsUtils.ConsumeGoods(consumeData, true)
        local equipComp = self:GetEquipmentComp()
        local befDojo = clone(equipComp:GetEquipById(requestData.playerEquipmentId))
        befDojo.bindPlayerCardId = requestData.playerCardId
        equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, befDojo)
        EquipUtils.EnterEquipmentEngraveSuccessDialog(requestData.playerEquipmentId)
        return {isReload = true}
    end)
end

--- RequestOverseaEquipmentLockAttr
--- 请求锁定词条
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaEquipmentLockAttr(requestData)
    return self:RequestInterface(Interfaces.OverseaEquipmentLockAttr, requestData, function(responseData)
    end)
end

--- RequestOverseaEquipmentResetAttr
--- 请求装备洗练
---@param requestData table 请求数据
---@param consumeData table 消耗
function CardProgressionMgr:RequestOverseaEquipmentResetAttr(requestData, consumeData, cb)
    return self:RequestInterface(Interfaces.OverseaEquipmentResetAttr, requestData, function(responseData)
        GoodsUtils.DrawRewards(consumeData, true)
        local playerEquipment = checkTable(responseData.playerEquipment)
        self._equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, playerEquipment)
        
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local playerDojo = playerComponent.playerDojo
        playerDojo.equipResetTimes = checkInt(playerDojo.equipResetTimes) + 1
        
        if cb then
            cb(playerEquipment)
        end
        return {isReload = true}
    end)
end

--- OverseaEquipmentRedReset
--- 请求装备重铸
---@param requestData table 请求数据
---@param consumeData table 消耗
function CardProgressionMgr:RequestOverseaEquipmentRedReset(requestData, cb)
    return self:RequestInterface(Interfaces.OverseaEquipmentRedReset, requestData, function(responseData)
        local playerEquipment = checkTable(responseData.playerEquipment)
        self._equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, playerEquipment)

        if responseData.consume then
            GoodsUtils.ConsumeGoods(responseData.consume, true)
        end

        -- local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        -- local playerDojo = playerComponent.playerDojo
        -- playerDojo.equipResetTimes = checkInt(playerDojo.equipResetTimes) + 1
        
        if cb then
            cb(playerEquipment)
        end
        return {isReload = true}
    end)
end

--- RequestOverseaEquipmentRecast
---请求装备固化
---@param requestData table 请求数据
---@param consumeData table 消耗
function CardProgressionMgr:RequestOverseaEquipmentCuring(requestData, consumeData, cb)
    return self:RequestInterface(Interfaces.OverseaEquipmentEnhance, requestData, function(responseData)
        GoodsUtils.DrawRewards(consumeData, true)
        local playerEquipment = checkTable(responseData.playerEquipment)
        self._equipComp:UpdateEquipDojoByServerData(requestData.playerEquipmentId, playerEquipment)
        if cb then
            cb(playerEquipment)
        end
        return {isReload = true}
    end)
end

--- RequestOverseaEquipmentRecycle
--- 请求装备分解
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaEquipmentRecycle(requestData, cb)
    return self:RequestInterface(Interfaces.OverseaEquipmentRecycle, requestData, function(responseData)
        if cb then
            cb(responseData)
        end
    end)
end

--- RequestOverseaEquipmentExchange
--- 请求装备分解
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaEquipmentExchange(requestData)
    return self:RequestInterface(Interfaces.OverseaEquipmentExchange, requestData, function(responseData)
        local equipComp = self:GetEquipmentComp()
        equipComp:ExchangeEquipmentOfTwoCards(requestData.playerCardId1, requestData.playerCardId2)
        local dojos = {}
        table.insert(dojos, self:GetCardComp():GetCardById(requestData.playerCardId1))
        table.insert(dojos, self:GetCardComp():GetCardById(requestData.playerCardId2))
        return {dojos = dojos}
    end)
end

--- RequestOverseaStoryRewardsReceive
--- 角色故事奖励
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaStoryRewardsReceive(requestData)
    return self:RequestInterface(Interfaces.OverseaCardStoryRewardsReceive, requestData, function(responseData)
        ---------------------------------
        --- 更新奖励
        local rewards = responseData.rewards
        GoodsUtils.DrawRewards(rewards)

        ---------------------------------
        --- 更新卡牌数据
        local playerCardId = requestData.playerCardId
        ---@type CardComponent
        local comp         = self:GetCardComp()
        ---@type CardDojo
        local cardDojo     = comp:GetCardById(playerCardId)
        cardDojo:AddStoryId2ReceivedRes(requestData.storyId)
        
        return {rewards = rewards, storyId = requestData.storyId}
    end)
end

--- RequestOverseaCardWeaponLevelUp
--- 请求 卡牌专武升级
---@param requestData table 请求数据
function CardProgressionMgr:RequestOverseaCardWeaponLevelUp(requestData, consumeData)
    return self:RequestInterface(Interfaces.OverseaCardWeaponLevelUp, requestData, function(responseData)
        ---------------------------------
        --- 更新卡牌数据
        local isSuccess = checkNumber(responseData.result) == 1
        responseData.weaponFailTimes = isSuccess and 0 or checkNumber(responseData.weaponFailTimes)
        local dojo =  self:UpdateCardDojo(requestData, responseData)
        
        local maxLv = CardConfMgr:GetInstance():GetMaxCardExclusiveWeaponLv(dojo.cardId)
        return {dojo = dojo, isSuccess = isSuccess, isReloadModel = checkNumber(dojo.weaponUnlocked) >= maxLv}
    end, consumeData)
end


--- RequestInterface
--- 请求养成相关接口
---@param interface Interfaces 必传
---@param requestData table 必传
---@param callback function(table) 必传
---@param consumeData table 可选
function CardProgressionMgr:RequestInterface(interface, requestData, callback, consumeData)
    return GameUtils.Request(interface, requestData, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end

        ---------------------------------------
        ---更新全局数据
        local localData
        if callback then
            localData = callback(response.data)
        end

        ---------------------------------
        --- 更新升级消耗
        if consumeData then
            GoodsUtils.DrawRewards(consumeData)
        end

        ---------------------------------------
        --- 更新本地数据
        Events.Broadcast(CardProgressionConstants.EventNames.RequestSuccess, interface, localData)
    end)
end

function CardProgressionMgr:UpdateCardDojo(requestData, responseData)
    local playerCardId = requestData.playerCardId
    ---------------------------------
    --- 更新卡牌数据
    ---@type CardComponent
    local comp = self:GetCardComp()
    local dojo = comp:UpdateCardDojo(playerCardId, responseData)
    return dojo
end

---获取装备洗练次数
function CardProgressionMgr:GetEquipResetTimes()
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local playerDojo = playerComponent.playerDojo
    return checkInt(playerDojo.equipResetTimes)
end

---检查自动洗练功能是否解锁
function CardProgressionMgr:CheckRecastAutoUnlock()
    local limit = checkNumber(CardConfMgr:GetInstance():GetCardProgressionParamsById(CardProgressionConstants.Params.EquipmentRecastAutoUnlockLimit))
    return self:GetEquipResetTimes() >= limit
end

return CardProgressionMgr