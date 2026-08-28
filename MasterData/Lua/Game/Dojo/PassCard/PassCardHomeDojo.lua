-------------------------------------------------------------------------------
-- Pass卡 - 主页数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-29 15:51:40
-------------------------------------------------------------------------------

local ProductDojo = import('Game.Dojo.PassCard.PassCardHomeProductDojo')
local BaseDojo    = import('Game.Dojo.BaseDojo')

---@class PassCardHomeDojo : BaseDojo
---@field New fun():PassCardHomeDojo
local PassCardHomeDojo = Class('PassCardHomeDojo', BaseDojo)


function PassCardHomeDojo:__init()
    ---@type integer @ 排期ID
    self.scheduleId = 0

    ---@type integer @ 赛季开始时间
    self.startTime = 0
    
    ---@type integer @ 当前排期剩余秒数
    self.leftSeconds = 0

    ---@type integer @ 当前总经验
    self.passCardTotalExp = 0

    ---@type integer @ 当前显示经验（未满级：当前等级多出的经验，满级后：可领取的溢出经验）
    self.passCardShowExp = 0

    ---@type integer @ 当前溢出的经验
    self.passCardOverExp = 0

    ---@type integer @ 当前Pass卡等级
    self.passCardLevel = 0

    ---@type PassCardUtils.PassType @ 当前Pass卡类型（0：未购买，1：买的普通，2：买的进阶）
    self.passCardType = 0

    ---@type table<integer, PassCardHomeProductDojo> @ 商品信息字典
    self.productDojoMap = {}

    ---@type table<integer, boolean> @ 已领取的 等级奖励id字典
    self.rewardsDrawnIdMap = {}

    ---@type integer @ 已领取的 循环奖励次数
    self.drawnCircleTimes = 0

    ---@type integer @ 可领取的 循环奖励次数
    self.canDrawCircleTimes = 0
end


function PassCardHomeDojo:__delete()
    self.scheduleId         = nil
    self.startTime          = nil
    self.leftSeconds        = nil
    self.passCardTotalExp   = nil
    self.passCardShowExp    = nil
    self.passCardOverExp    = nil
    self.passCardLevel      = nil
    self.passCardType       = nil
    self.productDojoMap     = nil
    self.rewardsDrawnIdMap  = nil
    self.drawnCircleTimes   = nil
    self.canDrawCircleTimes = nil
end


---@param jsonData table
---@return PassCardHomeDojo
function PassCardHomeDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.passCardTotalExp = checkInt(jsonData.exp)

    self.passCardType = checkInt(jsonData.bought)

    self.drawnCircleTimes = checkInt(jsonData.drawnCircleRewardsTimes)

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


---@param drawId integer
---@return boolean
function PassCardHomeDojo:IsDrawnRewardsId(drawId)
    return checkBool(self.rewardsDrawnIdMap[checkInt(drawId)])
end


---@param drawId integer
function PassCardHomeDojo:SaveDrawnRewardsId(drawId)
    self.rewardsDrawnIdMap[checkInt(drawId)] = true
end


---@param productId integer
---@return PassCardHomeProductDojo
function PassCardHomeDojo:GetProductDojo(productId)
    return self.productDojoMap[checkInt(productId)]
end


return PassCardHomeDojo
