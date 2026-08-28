-------------------------------------------------------------------------------
-- 噩梦回响Pass卡 - 工具类
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-17 21:08:58
-------------------------------------------------------------------------------

---@class ChaoticRecallPassCardUtils
local ChaoticRecallPassCardUtils = {}


---@alias ChaoticRecallPassCardUtils.ParamsId integer @ Pass卡参数id
ChaoticRecallPassCardUtils.ParamsId = {
    FREE_PARSS_NAME       = 1,  -- 免费 合约名称（文本）
    PAID_PARSS_NAME       = 2,  -- 付费 合约名称（文本）
    PAID_PARSS_PRODUCT    = 4,  -- 付费 合约商品id
    PASS_RULE_ID          = 5,  -- 规则说明ID
    LEVEL_BUY_CONSUME_ID  = 6,  -- 合约等级 购买消耗的道具ID
    LEVEL_BUY_CONSUME_NUM = 7,  -- 合约等级 购买消耗的道具数量
    PASS_BOTTOM_TIPS      = 8,  -- 页面下部提示内容（文本）
    LOOP_CHEST_DESCR      = 9,  -- 循环宝箱 奖励规则（文本）
    LEVEL_MAX_NUM         = 10, -- 合约等级 最大等级
    EXP_EACH_CHEST        = 11, -- 循环宝箱 每级经验
    EXP_POINT_ID          = 12, -- 经验点数道具id
    EXP_CONVERT_NUM       = 13, -- 噩梦回响1颗星星转化为多少经验
    LEVEL_EACH_EXP        = 16, -- 合约等级 每级经验
    LOOP_CHEST_ID         = 17, -- 循环宝箱 宝箱id
}


---@alias ChaoticRecallPassCardUtils.EventName string @ Pass卡事件名字
ChaoticRecallPassCardUtils.EventName = {
    PASS_CARD_EXP_CHANGE  = 'CHAOTIC_RECALL_PASS_CARD.EXP_CHANGE',   -- Pass卡 经验变化
    PASS_CARD_LOOP_TIMES  = 'CHAOTIC_RECALL_PASS_CARD.LOOP_TIMES',   -- Pass卡 循环宝箱次数
    PASS_CARD_TYPE_CHANGE = 'CHAOTIC_RECALL_PASS_CARD.TYPE_CHANGE',  -- Pass卡 类型变化
}


---@type table<ChaoticRecallPassCardUtils.ParamsId, number>
ChaoticRecallPassCardUtils.paramValueMap_ = {}


-------------------------------------------------------------------------------
-- about conf
-------------------------------------------------------------------------------

--- 噩梦回响Pass卡参数表
---@return ChaoticRecallPassCardParamsVo
function ChaoticRecallPassCardUtils.GetPassCardParamsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting6401, 'ChaoticRecallPassCard.ChaoticRecallPassCardParamsVo', id) or {}
end


--- 噩梦回响Pass卡奖励表
---@return ChaoticRecallPassCardRewardVo
function ChaoticRecallPassCardUtils.GetPassCardRewardVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting6402, 'ChaoticRecallPassCard.ChaoticRecallPassCardRewardVo', id) or {}
end


--- 噩梦回响Pass卡奖励表
---@return ChaoticRecallPassCardRewardVo[]
function ChaoticRecallPassCardUtils.GetAllPassCardRewardVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting6402, 'ChaoticRecallPassCard.ChaoticRecallPassCardRewardVo')
end


--- 根据参数id 获取参数表的值
---@param paramId ChaoticRecallPassCardUtils.ParamsId
---@return number
function ChaoticRecallPassCardUtils.GetParamValue(paramId)
    local paramValue = ChaoticRecallPassCardUtils.paramValueMap_[paramId]
    if not paramValue then
        local paramVo = ChaoticRecallPassCardUtils.GetPassCardParamsVo(paramId)
        paramValue = checkNumber(paramVo.paramNum)
        ChaoticRecallPassCardUtils.paramValueMap_[paramId] = paramValue
    end
    return paramValue
end


--- 根据参数id 获取参数表的描述
---@param paramId ChaoticRecallPassCardUtils.ParamsId
---@return string
function ChaoticRecallPassCardUtils.GetParamDescr(paramId)
    local paramVo = ChaoticRecallPassCardUtils.GetPassCardParamsVo(paramId)
    return checkString(paramVo.paramTxt)
end


-------------------------------------------------------------------------------
-- about level
-------------------------------------------------------------------------------

--- 根据 目标等级 转换升级所需经验
---@return integer
function ChaoticRecallPassCardUtils.ConvertPassUpgradeExp()
    return ChaoticRecallPassCardUtils.GetParamValue(ChaoticRecallPassCardUtils.ParamsId.LEVEL_EACH_EXP)
end


--- 根据 目标等级 转换宝箱所需经验
---@return integer
function ChaoticRecallPassCardUtils.GetLoopChestEachExp()
    return ChaoticRecallPassCardUtils.GetParamValue(ChaoticRecallPassCardUtils.ParamsId.EXP_EACH_CHEST)
end


--- 根据 总经验值 转换为对应的等级信息
---@param passCardExp integer
---@param levelLimit integer
---@return table
function ChaoticRecallPassCardUtils.ConvertPassExpToLevel(passCardExp, levelLimit)
    local eachLevelExp  = ChaoticRecallPassCardUtils.ConvertPassUpgradeExp()
    local passCardExp   = checkInt(passCardExp) + eachLevelExp  -- 需要默认从1级开始，所以计算公式始终有一个等级的经验
    local convertLevel  = math.floor(passCardExp / eachLevelExp)
    local overflowLevel = convertLevel - checkInt(levelLimit)
    if overflowLevel > 0 then
        convertLevel = checkInt(levelLimit)  -- 等级不能超上限，超等级上限的经验溢出
    end
    local convertExp = passCardExp - (convertLevel * eachLevelExp)
    return {level = convertLevel, exp = convertExp}
end


-------------------------------------------------------------------------------
-- about rewards
-------------------------------------------------------------------------------

--- 根据 赛季id + Pass卡类型，生成 指定等级范围 的奖励数据map
---@param hasPaidPassCard boolean
---@param startLevel integer
---@param endedLevel integer
---@return table<string, table>
function ChaoticRecallPassCardUtils.GetLevelRewardDataMap(hasPaidPassCard, startLevel, endedLevel)
    local rewardDataMap = {}
    local addRewardFunc = function(goodsId, goodsNum)
        if goodsId > 0 then
            local rewardData = rewardDataMap[tostring(goodsId)]
            if not rewardData then
                rewardData = {goodsId = goodsId, num = 0}
                rewardDataMap[tostring(goodsId)] = rewardData
            end
            rewardData.num = rewardData.num + goodsNum
        end
    end

    for _, rewardVo in ipairs(ChaoticRecallPassCardUtils.GetAllPassCardRewardVo()) do
        if rewardVo.passLevel >= startLevel and rewardVo.passLevel <= endedLevel then
            for _, goodsData in ipairs(rewardVo.freeRewards) do
                addRewardFunc(goodsData.goodsId, goodsData.num)
            end
            if hasPaidPassCard then
                for _, goodsData in ipairs(rewardVo.paidRewards) do
                    addRewardFunc(goodsData.goodsId, goodsData.num)
                end
            end
        end
    end
    
    return rewardDataMap
end


return ChaoticRecallPassCardUtils
