-------------------------------------------------------------------------------
-- Pass卡 - 工具类
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-03 18:46:09
-------------------------------------------------------------------------------

---@class PassCardUtils
local PassCardUtils = {}


---@alias PassCardUtils.PassType integer @ Pass卡类型
PassCardUtils.PassType = {
    FREE   = 0, -- 免费
    NORMAL = 1, -- 标准
    DELUXE = 2, -- 豪华
}


---@alias PassCardUtils.TaskType integer @ Pass卡任务类型
PassCardUtils.TaskType = {
    Daily = 1,  -- 日常
    Elite = 2,  -- 精英（周常）
}


---@alias PassCardUtils.ParamsId integer @ Pass卡参数id
PassCardUtils.ParamsId = {
    FREE_PARSS_NAME           = 2,  -- 免费 合约名称（文本）
    NORMAL_PARSS_NAME         = 3,  -- 标准 合约名称（文本）
    DELUXE_PARSS_NAME         = 4,  -- 豪华 合约名称（文本）
    NORMAL_PARSS_PRODUCT      = 5,  -- 标准 合约商品id
    DELUXE_PARSS_PRODUCT      = 6,  -- 豪华 合约商品id
    DELUXE_DIFF_PRODUCT       = 7,  -- 豪华 合约差价商品id
    PASS_RULE_ID              = 9,  -- 规则说明ID
    LEVEL_EACH_EXP            = 10, -- 合约等级 每级经验
    LEVEL_BUY_CONSUME_ID      = 11, -- 合约等级 购买消耗的道具ID
    LEVEL_BUY_CONSUME_NUM     = 12, -- 合约等级 购买消耗的道具数量
    PASS_BOTTOM_TIPS          = 13, -- 页面下部提示内容（文本）
    LOOP_CHEST_DESCR          = 14, -- 循环宝箱奖励规则（文本）
    DTASK_REFRESH_FREE        = 15, -- 每日任务 免费刷新次数
    ETASK_REFRESH_FREE        = 16, -- 精英任务 免费刷新次数
    DTASK_REFRESH_CONSUME_ID  = 17, -- 每日任务 付费刷新所需道具ID
    DTASK_REFRESH_CONSUME_NUM = 18, -- 每日任务 付费刷新所需道具数量
    ETASK_REFRESH_CONSUME_ID  = 19, -- 精英任务 付费刷新所需道具ID
    ETASK_REFRESH_CONSUME_NUM = 20, -- 精英任务 付费刷新所需道具数量
    DTASK_SHOW_COUNT          = 21, -- 每日任务 任务数
    ETASK_SHOW_COUNT          = 22, -- 精英任务 任务数
    DTASK_PARSS_EXP_EXTRA     = 23, -- 每日任务 合约经验加成（加成百分比，向上取整）Ps：无论标准还是豪华，买了就有加成
}


---@alias PassCardUtils.EventName string @ Pass卡事件名字
PassCardUtils.EventName = {
    PASS_CARD_EXP_CHANGE  = 'OVERSEA_PASS_CARD.EXP_CHANGE',   -- Pass卡 经验变化
    PASS_CARD_LOOP_TIMES  = 'OVERSEA_PASS_CARD.LOOP_TIMES',   -- Pass卡 循环宝箱次数
    PASS_CARD_TYPE_CHANGE = 'OVERSEA_PASS_CARD.TYPE_CHANGE',  -- Pass卡 类型变化
    PASS_CARD_BUY_DIALOG  = 'OVERSEA_PASS_CARD.BUY_DIALOG',   -- Pass卡 购买弹窗
}


---@type table<ClubUtils.ParamsId, number>
PassCardUtils.paramValueMap_ = {}


-------------------------------------------------------------------------------
-- about conf
-------------------------------------------------------------------------------

--- Pass卡参数表
---@return PassCardParamsVo
function PassCardUtils.GetPassCardParamsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting4050, 'PassCard.PassCardParamsVo', id) or {}
end


--- Pass卡奖励表
---@return PassCardRewardVo
function PassCardUtils.GetPassCardRewardVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting4051, 'PassCard.PassCardRewardVo', id) or {}
end


--- Pass卡精英任务表
---@return PassCardEliteTaskVo
function PassCardUtils.GetPassCardEliteTaskVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting4053, 'PassCard.PassCardEliteTaskVo', id) or {}
end


--- Pass卡每日任务表
---@return PassCardDailyTaskVo
function PassCardUtils.GetPassCardDailyTaskVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting4054, 'PassCard.PassCardDailyTaskVo', id) or {}
end


--- Pass卡排期表
---@return PassCardPlanVo
function PassCardUtils.GetPassCardPlanVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting4055, 'PassCard.PassCardPlanVo', id) or {}
end


--- 根据 排期ID，返回所有的 Pass卡奖励id列表
---@param scheduleId integer
---@return string[]
function PassCardUtils.GetAllRewardIds(scheduleId)
    return CfUtils.GetIdGroupData(AutoIds.IdSetting4051, scheduleId) or {}
end


--- 根据 排期ID + Pass卡等级，返回对应的 Pass卡奖励id
---@param scheduleId integer
---@param passLevel integer
---@return integer
function PassCardUtils.GetAllRewardIdByLv(scheduleId, passLevel)
    local confName = string.fmt('%1ID2Group', AutoIds.IdSetting4051)
    local confKey  = string.fmt('%1_%2', checkInt(scheduleId), checkInt(passLevel))
    return checkInt(CfUtils.GetStringIdGroupData(confName, confKey))
end


--- 根据参数id 获取参数表的值
---@param paramId PassCardUtils.ParamsId
---@return number
function PassCardUtils.GetParamValue(paramId)
    local paramValue = PassCardUtils.paramValueMap_[paramId]
    if not paramValue then
        local paramVo = PassCardUtils.GetPassCardParamsVo(paramId)
        paramValue = checkNumber(paramVo.paramNum)
        PassCardUtils.paramValueMap_[paramId] = paramValue
    end
    return paramValue
end


--- 根据参数id 获取参数表的描述
---@param paramId PassCardUtils.ParamsId
---@return string
function PassCardUtils.GetParamDescr(paramId)
    local paramVo = PassCardUtils.GetPassCardParamsVo(paramId)
    return checkString(paramVo.paramTxt)
end


-------------------------------------------------------------------------------
-- about short
-------------------------------------------------------------------------------

---@return PassCardComponent
function PassCardUtils.GetComp()
    return GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PassCardComponent)
end


-------------------------------------------------------------------------------
-- about level
-------------------------------------------------------------------------------

--- 根据 目标等级 转换升级所需经验
---@return integer
function PassCardUtils.ConvertPassUpgradeExp()
    return PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_EACH_EXP)
end


--- 根据 总经验值 转换为对应的等级信息
---@param passCardExp integer
---@param levelLimit integer
---@return table
function PassCardUtils.ConvertPassExpToLevel(passCardExp, levelLimit)
    local eachLevelExp  = PassCardUtils.ConvertPassUpgradeExp()
    local passCardExp   = checkInt(passCardExp)
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

--- 根据 赛季id + Pass卡类型，生成 全部等级 的奖励数据map
---@param scheduleId integer
---@param passTypes PassCardUtils.PassType[]
---@return table<string, table>
function PassCardUtils.GetAllRewardDataMap(scheduleId, passTypes)
    local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)
    local endedLevel = checkInt(passPlanVo.passLevelMax)
    return PassCardUtils.GetLevelRewardDataMap(scheduleId, passTypes, 1, endedLevel)
end


--- 根据 赛季id + Pass卡类型，生成 指定等级范围 的奖励数据map
---@param scheduleId integer
---@param passTypes PassCardUtils.PassType[]
---@param startLevel integer
---@param endedLevel integer
---@return table<string, table>
function PassCardUtils.GetLevelRewardDataMap(scheduleId, passTypes, startLevel, endedLevel)
    local passTypeMap = {}
    for _, passType in ipairs(passTypes) do
        passTypeMap[passType] = true
    end
    
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
    
    for passLevel = math.max(startLevel, 1), endedLevel do
        local rewardId = PassCardUtils.GetAllRewardIdByLv(scheduleId, passLevel)
        local rewardVo = PassCardUtils.GetPassCardRewardVo(rewardId)
        if passTypeMap[PassCardUtils.PassType.FREE] then
            addRewardFunc(rewardVo.freeGoodsId, rewardVo.freeGoodsNum)
        end
        if passTypeMap[PassCardUtils.PassType.NORMAL] then
            addRewardFunc(rewardVo.normalGoodsId, rewardVo.normalGoodsNum)
        end
        if passTypeMap[PassCardUtils.PassType.DELUXE] then
            addRewardFunc(rewardVo.deluxeGoodsId, rewardVo.deluxeGoodsNum)
        end
    end
    return rewardDataMap
end


--- 转换 奖励数据map 为 列表格式（按品质排序）
---@param rewardDataMap table
---@return table[]
function PassCardUtils.ConvertRewardDataMapToList(rewardDataMap)
    local goodsConfMgr  = GoodsConfMgr:GetInstance()
    local goodsQualityMap = {}
    local passRewardsList = {}
    for _, rewardData in pairs(checkTable(rewardDataMap)) do
        local goodsId = checkInt(rewardData.goodsId)
        if not goodsQualityMap[goodsId] then
            local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
            local quality = checkInt(goodsVo.quality)
            goodsQualityMap[goodsId] = quality
        end
        table.insert(passRewardsList, rewardData)
    end
    table.sort(passRewardsList, function(aRewardData, bRewardData)
        local aQuality = goodsQualityMap[aRewardData.goodsId]
        local bQuality = goodsQualityMap[bRewardData.goodsId]
        return aQuality > bQuality
    end)
    return passRewardsList
end


return PassCardUtils
