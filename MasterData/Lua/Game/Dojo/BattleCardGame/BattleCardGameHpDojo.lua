-------------------------------------------------------------------------------
-- 和风战牌 - 体力数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-02 12:08:02
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGameHpDojo : BaseDojo
---@field New fun():BattleCardGameHpDojo
local BattleCardGameHpDojo = Class('BattleCardGameHpDojo', BaseDojo)


function BattleCardGameHpDojo:__init()
    ---@type integer @ 体力道具id
    self.hpGoodsId = 0

    ---@type integer @ 当前体力值
    self.hpPoint = 0

    ---@type integer @ 体力上限值
    self.hpLimit = 0

    ---@type integer @ 已购买的次数
    self.buyTimes = 0

    ---@type integer @ 购买次数上限
    self.buyLimit = 0

    ---@type integer @ 体力恢复值
    self.recoverNum = 0

    ---@type integer @ 恢复剩余秒数（0 表示已满）
    self.recoverTime = 0

    ---@type table @ 兑换消耗数据
    self.consumeData = {}
end


function BattleCardGameHpDojo:__delete()
    self.hpGoodsId   = nil
    self.hpPoint     = nil
    self.hpLimit     = nil
    self.buyTimes    = nil
    self.buyLimit    = nil
    self.recoverNum  = nil
    self.recoverTime = nil
    self.consumeData = nil
end


---@param jsonData table
---@return BattleCardGameHpDojo
function BattleCardGameHpDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.hpGoodsId   = BattleCardGameUtils.GetHpGoodsId()
    self.hpLimit     = BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.HP_LIMIT_NUM)
    self.buyLimit    = BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.HP_EXCHANGE_LIMIT)
    self.recoverNum  = BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.HP_RECEIVE_NUM)
    self.consumeData = { goodsId = BattleCardGameUtils.GetHpExchangeId(), num = 0 }
    self.recoverTime = checkInt(jsonData.nextRecoverTime)
    self:UpdateBuyTimes(jsonData.buyTimes)
    self:UpdateHpPoint(jsonData.hp)

    return self
end


--- 更新Hp点数
---@param hpPoint integer
function BattleCardGameHpDojo:UpdateHpPoint(hpPoint)
    self.hpPoint = checkInt(hpPoint)
    -- 刷新顶部货币栏
    Events.Broadcast(Constants.EventNames.EveryThingChangeEventName)
end


--- 增加hp点数
---@param hpPoint integer
function BattleCardGameHpDojo:AppendHpPoint(hpPoint)
    self:UpdateHpPoint(self.hpPoint + checkInt(hpPoint))
end


--- 更新购买次数
---@param buyTimes integer
function BattleCardGameHpDojo:UpdateBuyTimes(buyTimes)
    self.buyTimes = checkInt(buyTimes)
    -- 刷新兑换消耗数量
    self.consumeData.num = BattleCardGameUtils.GetHpExchangeNum(self.buyTimes + 1)
end


--- 是否满体力了
---@return boolean
function BattleCardGameHpDojo:IsFulled()
    return self.hpPoint >= self.hpLimit
end


--- 检测兑换消耗是否足够
---@param showTips boolean | nil @ 是否显示不足提示
---@return boolean
function BattleCardGameHpDojo:CheckConsume(isShowTips)
    local _, errorTips = GoodsUtils.CheckGoodConsume(self.consumeData)
    if isShowTips and errorTips ~= nil then
        GameUtils.Toast(errorTips)
    end
    return errorTips == nil
end


return BattleCardGameHpDojo
