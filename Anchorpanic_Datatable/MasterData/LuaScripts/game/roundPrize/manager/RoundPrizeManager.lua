-- @FileName:   RoundPrizeManager.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-20 17:42:57
-- @Copyright:   (LY) 2024 锚点降临

module('game.roundPrize.manager.RoundPrizeManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)

end

function parseMainInfo(self, msg)
    self.m_MainInfo = msg
end

function getMainInfo(self)
    return self.m_MainInfo
end

function isGetReward(self, id)
    if not self.m_MainInfo then
        return false
    end

    for k, v in pairs(self.m_MainInfo.acc_gained_list) do
        if v == id then
            return true
        end
    end

    return false
end

---------------------------------------------------------配置--------------------------------------------------------------

function parseProbabilityConfigData(self)
    self.mProbabilityConfigDic = {}
    local baseData = RefMgr:getData("new_year_turntable_data")
    for key, data in pairs(baseData) do
        local vo = roundPrize.RoundPrizeProbabilityConfigVo.new()
        vo:parseData(key, data)
        self.mProbabilityConfigDic[key] = vo
    end
end

function parseRewardConfigData(self)
    self.mRewardConfigDic = {}
    local baseData = RefMgr:getData("new_year_turntable_acc_data")
    for key, data in pairs(baseData) do
        table.insert(self.mRewardConfigDic, {id = key, reward = data.rewards})
    end

    table.sort(self.mRewardConfigDic, function (a, b)
        return a.id < b.id
    end)
end

function getProbabilityConfigVo(self, id)
    id = id or 1
    if not self.mProbabilityConfigDic then
        self:parseProbabilityConfigData()
    end

    return self.mProbabilityConfigDic[id]
end

function getRewardConfigVo(self)
    if not self.mRewardConfigDic then
        self:parseRewardConfigData()
    end

    return self.mRewardConfigDic
end

function isShowRed(self)
    if self:isShowShopRed() then 
        return true
    end

    if self:isShowRewardRed() then 
        return true
    end

    if self:isShowPrizeRed() then 
        return true
    end

    return false
end

function isShowShopRed(self)
    local shopDataList = shop.ShopManager:getShopItemList(ShopType.ROUNDPRIZE)
    for i = 1, #shopDataList do
        if MoneyUtil.getMoneyCountByTid(shopDataList[i]:getRealPayType()) >= shopDataList[i].price then
            return true
        end
    end

    return false
end

function isShowRewardRed(self)
    local main_info = self:getMainInfo()
    if main_info then
        local rewardConfigVo = self:getRewardConfigVo()
        if rewardConfigVo then
            for i = 1, #rewardConfigVo do
                if main_info.acc_times >= rewardConfigVo[i].id and not self:isGetReward(rewardConfigVo[i].id) then
                    return true
                end
            end
        end
    end

    return false
end

function isShowPrizeRed(self)
    local prizeconfigVo = self:getProbabilityConfigVo()
    if prizeconfigVo then
        return MoneyUtil.getMoneyCountByTid(prizeconfigVo.cost_one_id) >= prizeconfigVo.cost_one_num
    end
end

return _M
