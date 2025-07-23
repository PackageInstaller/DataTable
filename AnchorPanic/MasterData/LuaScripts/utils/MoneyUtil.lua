-- 货币类型，和后端对应
MoneyType = {
    -- 金币
    GOLD_COIN_TYPE = 1,
    -- 钛金石
    ITIANIUM_TYPE = 3,
    -- 竞技币
    ARENA_COIN_TYPE = 4,
    -- 装饰币
    DECORATE_COIN_TYPE = 5,
    -- 战勋
    MEDAL_COIN_TYPE = 6,
    -- 无限币
    INFINITECITY_COIN_TYPE = 7,
    -- 声望
    PRESTIGE_COIN_TYPE = 8,
    -- 战员亲密度
    INTIMACY_TYPE = 9,
    -- 抗疫血清
    ANTIEPIDEMIC_SERUM_TYPE = 10,
    -- 战员经验
    HERO_GLOBAL_EXP_TYPE = 11,
    -- 指挥官经验
    PLAYER_EXP_TYPE = 12,
    -- 玩家声望经验
    PLAYER_PRESTIGE_EXP_TYPE = 13,
    -- 玩家助手经验
    PLAYER_HELPER_EXP_TYPE = 14,
    -- 钛石(充值货币)
    PAY_ITIANIUM_TYPE = 15,
    -- 通行证经验 17

    --产能
    CAPACITY_TYPE = 19,
    --肉鸽
    ROGUELIKE_TYPE = 20,
    --使徒之证
    APOSTLES2COIN_TYPE = 24,
    --时装币
    FASHION_TYPE = 27,

    --巅峰竞技场
    PVP_HELL_Type = 29,

    --联盟币
    GUILD_TYPE = 30,

    --开心农场货币
    HappyFarm_TYPE = 33,

    --联盟团战货币
    GUILDWAR_TYPE = 35,
    ------------------------------非货币类，但需要在货币栏上显示使用
    -- 碎片货币
    PAY_FRAGMENTS_TYPE_TYPE = 1500,
    -- dna心智体货币
    DNA_TYPE = 2070,
    -- 基因参数
    COVENANT_GENE_POINT_TYPE = 20050,
    ------------------------------特殊------------------------------
    -- 人名币
    MONEY = 999,

    ------------------------------限时货币  限时活动的货币
    -- 活动玩法货币 限时
    ACTIVITY_COIN_TYPE = 28
}

-- 货币tid（取自道具表tid），和MoneyType匹配
MoneyTid = {
    -- 金币
    GOLD_COIN_TID = 1,
    -- 钛金石
    ITIANIUM_TID = 3,
    -- 竞技币
    ARENA_COIN_TID = 4,
    -- 装饰币
    DECORATE_COIN_TID = 5,
    -- 战勋
    MEDAL_COIN_TID = 6,
    -- 无限币
    INFINITECITY_COIN_TID = 7,
    -- 声望值
    PRESTIGE_COIN_TID = 8,
    -- 战员亲密度
    INTIMACY_TID = 9,
    -- 抗疫血清
    ANTIEPIDEMIC_SERUM_TID = 10,
    -- 战员经验
    HERO_GLOBAL_EXP_TID = 11,
    -- 指挥官经验
    PLAYER_EXP_TID = 12,
    -- 玩家声望经验
    PLAYER_PRESTIGE_EXP_TID = 13,
    -- 研究所经验
    PLAYER_HELPER_EXP_TID = 14,
    -- 钛石(充值货币)
    PAY_ITIANIUM_TID = 15,
    --电力
    POWER_TID = 19,
    --函数币(肉鸽关卡内货币)
    FUNCTION_TID = 20,
    --肉鸽货币
    ROGUELIKE_TID = 21,
    --使徒只证
    APOSTLES2COIN = 24,
    --活跃度
    ACTIVITY = 25,
    --时装币
    FASHION_TID = 27,
    --巅峰竞技场
    PVP_HELL_TID = 29,
    --联盟币
    GUILD_TID = 30,
    --新无限城
    DOUNDLESS_TID = 31,

    --开心农场货币
    HAPPYFARM_TID = 33,
    --联盟团战货币
    GUILDWAR_TID = 35,
    ------------------------------非货币类，但需要在货币栏上显示使用
    -- 碎片货币
    PAY_FRAGMENTS_TYPE_TID = 1500,
    -- 模组构件
    MODULE_MEMBER_TYPE_TID = 2001,
    -- 普通招募券
    RECRUIT_COMMON_TICKET_TID = 2021,
    -- 高级招募券
    RECRUIT_TOP_TICKET_TID = 2022,
    -- 限定招募券
    RECRUIT_ACT_TICKET_TID = 2023,
    --
    RECRUIT_BRACELETS_TICKET_TID = 2051,
    -- 限定研发
    RECRUIT_ACT_BRACELETS_TICKET_TID = 2052,
    -- 限定研发
    RECRUIT_BRACELETS_CONVERT_TID = 2060,
    -- dna心智体货币
    DNA_TID = 2070,
    -- 竞技场挑战券
    ARENA_CHALLENGE_TICKET_TID = 2150,
    -- 基因参数
    COVENANT_GENE_POINT_TID = 20050,
    --普通津贴
    NORMAL_SUBSIDY_TID = 2160,
    --幸运津贴
    HIGH_SUBSIDY_TID = 2161,
    --总力战道具
    DISASTER_TID = 2169,
    --联盟资金
    GUILD_FUND_TID = 2170,

    -- 联盟科技道具
    ITEM_2171 = 2171,
    ITEM_2172 = 2172,
    ITEM_2173 = 2173,
    ITEM_2174 = 2174,
    ITEM_2175 = 2175,
    ITEM_2176 = 2176,

    ITEM_2061 = 2061,

    --无人机
    UAV_TID = 2800,

    --钛石
    TITANITE_TID = 2801,

    --新年抽奖道具
    ROUNDPRIZE_PROPS = 2071,

    ROUNDPRIZE_PROPS_TWO = 2073,

    ------------------------------限时货币  限时活动的货币
    -- 活动玩法货币 限时
    ACTIVITY_COIN_TID = 28,

}

-- 联盟科技耗材道具列表
MoneyTid.GUILD_SKILL_ITEM_LIST = {
    MoneyTid.ITEM_2171,
    MoneyTid.ITEM_2172,
    MoneyTid.ITEM_2173,
    MoneyTid.ITEM_2174,
    MoneyTid.ITEM_2175,
    MoneyTid.ITEM_2176,
}

-- 道具相关的配置进列表，通过背包更新货币栏检测
PROPS_MONEY_TID_LIST = {
    MoneyTid.PAY_FRAGMENTS_TYPE_TID,
    MoneyTid.RECRUIT_COMMON_TICKET_TID,
    MoneyTid.RECRUIT_TOP_TICKET_TID,
    MoneyTid.RECRUIT_ACT_TICKET_TID,
    MoneyTid.RECRUIT_ACT_BRACELETS_TICKET_TID,
    MoneyTid.ARENA_CHALLENGE_TICKET_TID,
    MoneyTid.COVENANT_GENE_POINT_TID,
    MoneyTid.NORMAL_SUBSIDY_TID,
    MoneyTid.HIGH_SUBSIDY_TID,
    MoneyTid.RECRUIT_BRACELETS_TICKET_TID,
    MoneyTid.TITANITE_TID,
    MoneyTid.RECRUIT_BRACELETS_CONVERT_TID,
    MoneyTid.MODULE_MEMBER_TYPE_TID,
    MoneyTid.ITEM_2061,
    MoneyTid.PVP_HELL_TID,
    MoneyTid.DISASTER_TID,
    MoneyTid.ROUNDPRIZE_PROPS,
    MoneyTid.ROUNDPRIZE_PROPS_TWO,
    MoneyTid.GUILDWAR_TID,
    MoneyTid.DNA_TID,
}

MoneyUtil = {}
-- 根据货币tid获取道具图标(大图标)
function MoneyUtil.getMoneyPropsIconUrlByTid(moneyTid)
    return UrlManager:getPropsIconUrl(moneyTid)
end

-- 根据货币tid获取40x40图标(小图标)
function MoneyUtil.getMoneyIconUrlByTid(moneyTid)
    return UrlManager:getMoneyIconUrl(moneyTid)
end

-- 根据货币类型获取货币图标
function MoneyUtil.getMoneyIconUrlByType(moneyType)
    return MoneyUtil.getMoneyIconUrlByTid(MoneyUtil.getMoneyTidByType(moneyType))
end

-- 根据货币tid获取货币名称
function MoneyUtil.getMoneyNameByTid(moneyTid)
    local propsConfigVo = props.PropsManager:getPropsConfigVo(moneyTid)
    if propsConfigVo then
        return propsConfigVo:getName()
    end
end

-- 根据货币类型获取货币名称
function MoneyUtil.getMoneyNameByType(moneyType)
    return MoneyUtil.getMoneyNameByTid(MoneyUtil.getMoneyTidByType(moneyType))
end

-- 根据货币id获取玩家的货币数量
function MoneyUtil.getMoneyCountByTid(moneyTid)
    local count = -1
    local playerVo = role.RoleManager:getRoleVo()
    if (moneyTid == MoneyTid.GOLD_COIN_TID) then
        count = playerVo:getPlayerGoldCoin()
    elseif (moneyTid == MoneyTid.ITIANIUM_TID) then
        count = playerVo:getPlayerItianium()
    elseif (moneyTid == MoneyTid.ARENA_COIN_TID) then
        count = playerVo:getPlayerArenaCoin()
    elseif (moneyTid == MoneyTid.DECORATE_COIN_TID) then
        count = playerVo:getPlayerDecorateCoin()
    elseif (moneyTid == MoneyTid.INTIMACY_TID) then
        count = -1
    elseif (moneyTid == MoneyTid.ANTIEPIDEMIC_SERUM_TID) then
        count = stamina.StaminaManager:getStamina()
    elseif (moneyTid == MoneyTid.HERO_GLOBAL_EXP_TID) then
        count = playerVo:getPlayerHeroGlobalExp()
    elseif (moneyTid == MoneyTid.PLAYER_EXP_TID) then
        count = playerVo:getPlayerExp()
    elseif (moneyTid == MoneyTid.INFINITECITY_COIN_TID) then
        count = playerVo:getInfiniteCityCoin()
    elseif (moneyTid == MoneyTid.PRESTIGE_COIN_TID) then
        count = playerVo:getPrestigeCoin()
    elseif (moneyTid == MoneyTid.PLAYER_PRESTIGE_EXP_TID) then
        count = playerVo:getPlayerPrestigeExp()
    elseif (moneyTid == MoneyTid.PLAYER_HELPER_EXP_TID) then
        count = playerVo:getPlayerHelperGlobalExp()
    elseif (moneyTid == MoneyTid.PAY_ITIANIUM_TID) then
        count = playerVo:getPayItianium()
    elseif (moneyTid == MoneyTid.COVENANT_GENE_POINT_TID) then
        count = covenant.CovenantManager.remainGeneNum
    elseif (moneyTid == MoneyTid.FUNCTION_TID) then
        count = playerVo:getFunctionCoin()
    elseif (moneyTid == MoneyTid.ROGUELIKE_TID) then
        count = playerVo:getRogueLikeCoin()
    elseif (moneyTid == MoneyTid.POWER_TID) then
        count = playerVo:getPlayerCapacitey()
    elseif (moneyTid == MoneyTid.MODULE_MEMBER_TYPE_TID) then
        count = playerVo:getPlayerModuleMember()
    elseif (moneyTid == MoneyTid.APOSTLES2COIN) then
        count = playerVo:getPlayerApostles2Coin()
    elseif (moneyTid == MoneyTid.UAV_TID) then
        count = playerVo:getPlayerDrone()
    elseif (moneyTid == MoneyTid.FASHION_TID) then
        count = playerVo:getFashionCoin()
    elseif (moneyTid == MoneyTid.ACTIVITY_COIN_TID) then
        count = playerVo:getActivityCoin()
    elseif (moneyTid == MoneyTid.PVP_HELL_TID) then
        count = playerVo:getPvpHellCoin()
    elseif (moneyTid == MoneyTid.GUILD_TID) then
        count = playerVo:getGuildCoin()
    elseif (moneyTid == MoneyTid.DOUNDLESS_TID) then
        count = playerVo:getDoundlessCoin()
    elseif (moneyTid == MoneyTid.GUILD_FUND_TID) then
        count = guild.GuildManager:getGuildCoin()
    elseif (moneyTid == MoneyTid.HAPPYFARM_TID) then
        count = playerVo:getHappyFarmMoney()
    elseif (moneyTid == MoneyTid.GUILDWAR_TID) then
        count = playerVo:getGuildWarCoin()
    else
        count = bag.BagManager:getPropsCountByTid(moneyTid)
    end
    return count
end

-- 根据货币类型获取玩家的货币数量
function MoneyUtil.getMoneyCountByType(moneyType)
    return MoneyUtil.getMoneyCountByTid(MoneyUtil.getMoneyTidByType(moneyType))
end

-- 货币类型和道具id转化
function MoneyUtil.getMoneyTidByType(moneyType)
    local tid = moneyType
    -- 正常不用映射，需要自写
    -- if (moneyType == MoneyType.GOLD_COIN_TYPE) then
    --     tid = MoneyTid.GOLD_COIN_TID
    -- end
    return tid
end

-- 货币类型和uicode转化
function MoneyUtil.getUicodeByType(moneyType)
    local uiCode = -1
    return uiCode
end

-- 根据金钱类型和需要数量，判断是否足够的提示
-- moneyTid 金钱道具模版tid
-- count 需要的数量
-- isFormatTip  是否格式化文字提示
--                      true 为格式化正式tips 【按货币类型分类】default为“您的。。不足，还需要。。”。 false为弱提示弹窗   前提是要开启isShowTip
-- isShowTip    是否文字提示  true 为开启文字提示 false 不提示

function MoneyUtil.judgeNeedMoneyCountByTid(moneyTid, count, isFormatTip, isShowTip)
    local hasCount = MoneyUtil.getMoneyCountByTid(moneyTid)
    local moneyName = MoneyUtil.getMoneyNameByTid(moneyTid)
    if (count > 0 and hasCount < count) then
        local tips = isFormatTip and "您的" .. moneyName .. "不足，还需要" .. tonumber(count - hasCount) .. moneyName or moneyName .. "不足"
        if isFormatTip and (isShowTip == true or isShowTip == nil) then
            if (moneyTid == MoneyTid.ITIANIUM_TID) then
                local sum = MoneyUtil.getMoneyCountByTid(MoneyTid.PAY_ITIANIUM_TID) + hasCount
                if sum >= count then
                    local needPayTi = count - hasCount
                    tips = _TT(67, needPayTi) --"源晶辉锭不足，是否使用{0}星彩源晶等量兑换？"
                    return true, tips
                else
                    tips = _TT(68) -- "源晶辉锭不足，是否前往兑换？"
                end
            end
            if (moneyTid == MoneyTid.PAY_ITIANIUM_TID) then
                tips = _TT(66) -- "星彩源晶不足，是否前往兑换？"
            end
        elseif (isShowTip == true or isShowTip == nil) then
            gs.Message.Show(tips)
        end
        return false, tips
    end

    return true, ""
end
-- 源晶辉锭兑换某商品
function MoneyUtil.judgeNeedMoneyCountByTidTips(moneyTid, count, shopVo, callBack, endCall)
    local price = shopVo and shopVo:getPrice() or 1
    local needMoney = count * price
    local needCount = count
    local hasMoney = MoneyUtil.getMoneyCountByTid(moneyTid)
    local deletionMoney = needMoney - hasMoney
    UIFactory:alertMessge(_TT(67, deletionMoney), true, function()
        local sum = MoneyUtil.getMoneyCountByTid(MoneyTid.PAY_ITIANIUM_TID)
        if sum >= deletionMoney then
            convert.ConvertManager:sendBuyTitumMsg(deletionMoney, MoneyTid.PAY_ITIANIUM_TID, moneyTid)
            if endCall then
                endCall()
            end
        else
            UIFactory:alertMessge(_TT(66), true, function()
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Purchase})
                if endCall then
                    endCall()
                end
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
        )
    end
end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

-- 根据金钱类型和需要数量，判断是否足够的提示
-- moneyType 金钱道具模版tid
-- count 需要的数量
-- gapTip是否提示差多少
function MoneyUtil.judgeNeedMoneyCountByType(moneyType, count, isFormatTip, isShowTip)
    local tid = MoneyUtil.getMoneyTidByType(moneyType)
    if (tid > 0) then
        return MoneyUtil.judgeNeedMoneyCountByTid(tid, count, isFormatTip, isShowTip)
    else
        return false
    end
end

function MoneyUtil.shortValueStr(cusValue, cusType)
    if not cusValue then
        return 0
    end
    if (not cusType or cusType == 1) and cusValue >= 1000000 then
        local k_value = math.floor(cusValue / 1000)
        return k_value .. "k"
    end
    if cusType and cusType == 2 and cusValue >= 1000000 then
        local k_value = math.floor(cusValue / 10000)
        return k_value .. "万"
    end
    return cusValue
end

function MoneyUtil.setCostIconAndNum(id, needNum, ariImage, textCpt, isNoColorChange, enoughColor, notEnoughtColor)
    enoughColor = enoughColor or "FFFFFFFF"
    notEnoughtColor = notEnoughtColor or "DE1E1EFF"
    ariImage:SetImg(UrlManager:getPropsIconUrl(id), false)
    local ownNum = MoneyUtil.getMoneyCountByTid(id)
    textCpt.text = needNum
    if not isNoColorChange then
        textCpt.color = gs.ColorUtil.GetColor(ownNum >= needNum and enoughColor or notEnoughtColor)
    end
end

return MoneyUtil
