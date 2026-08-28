-------------------------------------------------------------------------------
-- 噩梦回响Pass卡 - 主页数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-17 19:28:33
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.FightReady.ChaoticRecallPassCard.ChaoticRecallPassCardUtils')
local ProductDojo   = import('Game.Dojo.ChaoticRecallPassCard.ContractRecallPassCardHomeProductDojo')
local BaseDojo      = import('Game.Dojo.BaseDojo')

---@class ContractRecallPassCardHomeDojo : BaseDojo
---@field New fun():ContractRecallPassCardHomeDojo
local ContractRecallPassCardHomeDojo = Class('ContractRecallPassCardHomeDojo', BaseDojo)


function ContractRecallPassCardHomeDojo:__init()
    ---@type integer @ 排期ID
    self.scheduleId = 0

    ---@type integer @ 当前排期剩余秒数
    self.leftSeconds = 0

    ---@type integer @ 当前总经验
    self.passCardTotalExp = 0

    ---@type boolean @ 是否购买了Pass卡
    self.isBoughtPassCard = 0

    ---@type table<integer, ContractRecallPassCardHomeProductDojo> @ 商品信息字典
    self.productDojoMap = {}

    ---@type table<integer, boolean> @ 已领取的 等级奖励id字典
    self.rewardsDrawnIdMap = {}

    ---@type integer @ 已领取的 循环奖励次数
    self.drawnCircleTimes = 0

    ---@type integer @ 展示1项目 道具id
    self.showItem1GoodsId = 0

    ---@type integer @ 展示2项目 道具id
    self.showItem2GoodsId = 0

    ---@type integer @ 展示3项目 图片路径
    self.showItem3ImgPath = ''

    ------------------------------------------------- [extra]

    ---@type integer @ 当前显示经验（未满级：当前等级多出的经验，满级后：可领取的溢出经验）
    self.passCardShowExp = 0

    ---@type integer @ 当前溢出的经验
    self.passCardOverExp = 0

    ---@type integer @ 当前Pass卡等级
    self.passCardLevelNow = 0
    
    ---@type integer @ 最大Pass卡等级
    self.passCardLevelMax = 0

    ---@type integer @ 可领取的 循环奖励次数
    self.canDrawCircleTimes = 0

    ------------------------------------------------- [cache]

    ---@type table[] @ 领取奖励数据列表
    self.drawRewardList = {}

    ---@type table<integer, integer> @ 领取奖励总道具数量map
    self.totalGoodsNumMap = {}
end


function ContractRecallPassCardHomeDojo:__delete()
    self.scheduleId         = nil
    self.leftSeconds        = nil
    self.passCardTotalExp   = nil
    self.isBoughtPassCard   = nil
    self.productDojoMap     = nil
    self.rewardsDrawnIdMap  = nil
    self.drawnCircleTimes   = nil
    self.showItem1GoodsId   = nil
    self.showItem2GoodsId   = nil
    self.showItem3ImgPath   = nil
    --                      = extra
    self.passCardShowExp    = nil
    self.passCardOverExp    = nil
    self.passCardLevelNow   = nil
    self.passCardLevelMax   = nil
    self.canDrawCircleTimes = nil
    --                      = cache
    self.drawRewardList     = nil
    self.totalGoodsNumMap   = nil
end


---@param jsonData table
---@return ContractRecallPassCardHomeDojo
function ContractRecallPassCardHomeDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.scheduleId       = checkInt(jsonData.scheduleId)
    self.leftSeconds      = checkInt(jsonData.leftSeconds)
    self.isBoughtPassCard = checkInt(jsonData.bought) == 1  -- 0:未购买 1:买了
    self.drawnCircleTimes = checkInt(jsonData.drawnCircleRewardsTimes)
    self.showItem1GoodsId = checkInt(jsonData.itemId1)
    self.showItem2GoodsId = checkInt(jsonData.itemId2)
    self.showItem3ImgPath = parse_pathNameByData(checkString(jsonData.img3))

    -- update passLevel
    self.passCardLevelMax = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_MAX_NUM)
    self:UpdatePassCardExp(jsonData.exp)

    -- update drawIds
    self.rewardsDrawnIdMap = {}
    for _, drawId in ipairs(checkTable(jsonData.drawnLevelRewards)) do
        self.rewardsDrawnIdMap[checkInt(drawId)] = true
    end

    -- update products
    self.productDojoMap = {}
    for productId, productData in pairs(checkTable(jsonData.products)) do
        self.productDojoMap[checkInt(productId)] = ProductDojo.New():Fill(productData)
    end

    return self
end

-------------------------------------------------
-- get / set

--- Pass卡是否满级
---@return boolean
function ContractRecallPassCardHomeDojo:IsPassLevelMax()
    return self.passCardLevelNow >= self.passCardLevelMax
end


--- 是否 领取了指定id的奖励
---@param drawId integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsDrawnRewardsId(drawId)
    return checkBool(self.rewardsDrawnIdMap[checkInt(drawId)])
end


--- 获取 指定id的商品dojo
---@param productId integer
---@return ContractRecallPassCardHomeProductDojo
function ContractRecallPassCardHomeDojo:GetProductDojo(productId)
    return self.productDojoMap[checkInt(productId)]
end


--- 获取 付费Pass卡商品dojo
---@param productId integer
---@return ContractRecallPassCardHomeProductDojo
function ContractRecallPassCardHomeDojo:GetPaidPassCardProductDojo()
    local productId = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.PAID_PARSS_PRODUCT)
    return self:GetProductDojo(productId)
end


--- 获取 指定id的总量奖励数据
---@param goodsId integer
---@return integer
function ContractRecallPassCardHomeDojo:GetTotalRewardGoodsData(goodsId)
    return checkInt(self.totalGoodsNumMap[checkInt(goodsId)])
end


-------------------------------------------------
-- public

--- 重载缓存数据
function ContractRecallPassCardHomeDojo:RebuildCacheData()
    -- rebuild allDrawDataList
    self:RebuildDrawRewardList_()
end


--- 记录 已领取指定id的奖励
---@param drawId integer
function ContractRecallPassCardHomeDojo:SaveDrawnRewardsId(drawId)
    self.rewardsDrawnIdMap[checkInt(drawId)] = true
end


-------------------------------------------------------------------------------
-- about level
-------------------------------------------------------------------------------

--- 更新 Pass卡经验
---@param newExp integer @ 最新Pass卡经验
function ContractRecallPassCardHomeDojo:UpdatePassCardExp(newPassExp)
    local newTotalExp     = checkInt(newPassExp)
    local passLevelData   = PassCardUtils.ConvertPassExpToLevel(newTotalExp, self.passCardLevelMax)
    self.passCardTotalExp = newTotalExp
    self.passCardLevelNow = passLevelData.level
    
    if self:IsPassLevelMax() then
        self.passCardOverExp = passLevelData.exp
        self:UpdateDrawnCircleTimes(self.drawnCircleTimes)
    else
        self.passCardOverExp = 0
        self:UpdateDrawnCircleTimes(0)
        self.passCardShowExp = passLevelData.exp
    end

    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_EXP_CHANGE)
end


--- 更新 循环宝箱次数
---@param drawnTimes integer @ 最新已经领取次数
function ContractRecallPassCardHomeDojo:UpdateDrawnCircleTimes(drawnTimes)
    local loopChestEachExp   = PassCardUtils.GetLoopChestEachExp()
    local passCardOverExp    = self.passCardOverExp
    local drawnCircleTimes   = checkInt(drawnTimes)
    local canDrawPassCardExp = passCardOverExp - (drawnCircleTimes * loopChestEachExp)
    local canDrawCircleTimes = math.floor(canDrawPassCardExp / loopChestEachExp)

    self.drawnCircleTimes   = drawnCircleTimes
    self.canDrawCircleTimes = canDrawCircleTimes
    self.passCardShowExp    = canDrawPassCardExp

    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_LOOP_TIMES)
end


--- 更新 Pass卡购买状态
---@param passCardType PassCardUtils.PassType
function ContractRecallPassCardHomeDojo:UpdatePassCardType(isBought)
    self.isBoughtPassCard = checkBool(isBought)
    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_TYPE_CHANGE)
end


-------------------------------------------------------------------------------
-- about rewards
-------------------------------------------------------------------------------

-- 生成领取奖励数据列表
function ContractRecallPassCardHomeDojo:RebuildDrawRewardList_()
    self.drawRewardList   = {}
    self.totalGoodsNumMap = {}

    local passCardLevelMax = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_MAX_NUM)
    for rewardIndex, rewardVo in ipairs(PassCardUtils.GetAllPassCardRewardVo()) do

        -- 按理说应该整个奖励表全都要的，但是不知为何奖励表配55条，而最大等级只有50，所以只能做一层过滤处理
        if rewardVo.passLevel <= passCardLevelMax then
            local showFreeRewards = {}
            local showPaidRewards = {}
            self.drawRewardList[rewardIndex] = {
                rewardVo        = rewardVo,
                rewardId        = rewardVo.rewardId,
                passLevel       = checkInt(rewardVo.passLevel),
                showFreeRewards = showFreeRewards,
                showPaidRewards = showPaidRewards,
            }

            for _, goodsData in pairs(rewardVo.freeRewards) do
                local goodsId  = goodsData.goodsId
                local goodsNum = goodsData.num
                self.totalGoodsNumMap[goodsId] = self.totalGoodsNumMap[goodsId] or 0
                self.totalGoodsNumMap[goodsId] = self.totalGoodsNumMap[goodsId] + goodsNum
                table.insert(showFreeRewards, {goodsId = goodsId, num = goodsNum, text = 'x'..goodsNum})
            end

            for _, goodsData in pairs(rewardVo.paidRewards) do
                local goodsId  = goodsData.goodsId
                local goodsNum = goodsData.num
                self.totalGoodsNumMap[goodsId] = self.totalGoodsNumMap[goodsId] or 0
                self.totalGoodsNumMap[goodsId] = self.totalGoodsNumMap[goodsId] + goodsNum
                table.insert(showPaidRewards, {goodsId = goodsId, num = goodsNum, text = 'x'..goodsNum})
            end
        end
    end
end


--- 是否 领取了指定位置的 免费奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsDrawnFreeRewardsAt(drawIndex)
    ---@type ChaoticRecallPassCardRewardVo
    local rewardVo = self.drawRewardList[drawIndex].rewardVo
    return self:IsDrawnRewardsId(rewardVo.freeDrawId)
end

--- 是否 领取了指定位置的 付费奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsDrawnPaidRewardsAt(drawIndex)
    ---@type ChaoticRecallPassCardRewardVo
    local rewardVo = self.drawRewardList[drawIndex].rewardVo
    return self:IsDrawnRewardsId(rewardVo.paidDrawId)
end

--- 是否 领取了指定位置的 全部奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsDrawnAllRewardsAt(drawIndex)
    return self:IsDrawnFreeRewardsAt(drawIndex) and self:IsDrawnPaidRewardsAt(drawIndex)
end


--- 是否 解锁了指定位置的 免费奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsUnlockFreeRewardsAt(drawIndex)
    local passLevel = self.drawRewardList[drawIndex].passLevel
    return self.passCardLevelNow >= passLevel
end

--- 是否 解锁了指定位置的 付费奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsUnlockPaidRewardsAt(drawIndex)
    return self:IsUnlockFreeRewardsAt(drawIndex) and self.isBoughtPassCard
end

--- 是否 解锁了指定位置的 全部奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:IsUnlockAllRewardsAt(drawIndex)
    return self:IsUnlockFreeRewardsAt(drawIndex) and self:IsUnlockPaidRewardsAt(drawIndex)
end


--- 获取 全部奖励中 可领取的id列表
---@return integer[]
function ContractRecallPassCardHomeDojo:GetAllCanDrawIdList()
    local drawIdList = {}
    for drawIndex, drawData in ipairs(self.drawRewardList) do
        ---@type ChaoticRecallPassCardRewardVo
        local rewardVo = drawData.rewardVo
        -- check freeReward
        if self:IsUnlockFreeRewardsAt(drawIndex) and not self:IsDrawnFreeRewardsAt(drawIndex) then
            table.insert(drawIdList, rewardVo.freeDrawId)
        end
        -- check paidReward
        if self:IsUnlockPaidRewardsAt(drawIndex) and not self:IsDrawnPaidRewardsAt(drawIndex) then
            table.insert(drawIdList, rewardVo.paidDrawId)
        end
    end
    return drawIdList
end


--- 是否 指定位置 有可领取的奖励
---@param drawIndex integer
---@return boolean
function ContractRecallPassCardHomeDojo:HasCanDrawRewardsAt(drawIndex)
    -- check freeReward
    if self:IsUnlockFreeRewardsAt(drawIndex) and not self:IsDrawnFreeRewardsAt(drawIndex) then
        return true
    end
    -- check paidReward
    if self:IsUnlockPaidRewardsAt(drawIndex) and not self:IsDrawnPaidRewardsAt(drawIndex) then
        return true
    end
    return false
end


--- 是否 有可领取的奖励
function ContractRecallPassCardHomeDojo:HasCanDrawRewards()
    for drawIndex, _ in ipairs(self.drawRewardList) do
        if self:HasCanDrawRewardsAt(drawIndex) then
            return true
        end
    end
    return false
end


return ContractRecallPassCardHomeDojo
