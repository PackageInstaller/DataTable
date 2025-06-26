-- 充值类型
recharge.RechargeType = {
    MONEY_ITIANIUM = 1, -- 钛金石
    MONTH_CARD = 2, -- 月卡
    TONG_XING_ZHENG = 3, -- 通行证
    GIFT_DIRECT_BUY = 4, -- 直购礼包
    GROWTH_FUND_BUY = 5, -- 成长基金

    FASHION_PERMIT = 6,--时装通行证

    STRENGTH_CARD = 7,--体力月卡
    LIMITSHOP_GIFT = 8,--商场限时礼包

    FASHION_PERMIT_TWO = 9, -- 时装通行证2
    SUPERCIAL = 10,-- 阿尔戈特供
    CARNIVAL_GIFT = 11,-- 狂欢好礼
    SELECT_GIFT = 12, -- 自选礼包

    FASHION_HISTORY = 13, -- 时装回廊

    FASHION_OTHER = 14,--组合部件
    FASHION_COMBO = 15,--组合
}

recharge.rechargeDirectId = {
    oneYuanGift = "102", --一元礼包
    sevenStamina = "4", --七天体力礼包
}

recharge.rechargeDic = {}
--充值
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM] = {}
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM]["1"] = _TT(50058)
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM]["2"] = _TT(50059)
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM]["3"] = _TT(50060)
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM]["4"] = _TT(50061)
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM]["5"] = _TT(50062)
recharge.rechargeDic[recharge.RechargeType.MONEY_ITIANIUM]["6"] = _TT(50063)
--月卡
recharge.rechargeDic[recharge.RechargeType.MONTH_CARD] = _TT(50002)
--通行证
recharge.rechargeDic[recharge.RechargeType.TONG_XING_ZHENG] = {}
recharge.rechargeDic[recharge.RechargeType.TONG_XING_ZHENG]["1"] = _TT(72112)
recharge.rechargeDic[recharge.RechargeType.TONG_XING_ZHENG]["2"] = _TT(72113)
recharge.rechargeDic[recharge.RechargeType.TONG_XING_ZHENG]["3"] = _TT(72113)
--直购礼包
recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY] = {}
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["4"] = _TT(13830)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["100"] = _TT(513818)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["101"] = _TT(513816)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["102"] = _TT(513814)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["103"] = _TT(513815)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["104"] = _TT(513805)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["105"] = _TT(513801)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["106"] = _TT(513811)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["107"] = _TT(513072)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["108"] = _TT(513073)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["109"] = _TT(513074)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["110"] = _TT(513075)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["111"] = _TT(513076)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["112"] = _TT(513077)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["116"] = _TT(513807)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["117"] = _TT(513806)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["118"] = _TT(513803)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["119"] = _TT(513810)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["120"] = _TT(513804)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["121"] = _TT(513812)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["122"] = _TT(513813)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["123"] = _TT(513071)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["124"] = _TT(513817)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["125"] = _TT(513071)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["201"] = _TT(513701)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["202"] = _TT(513702)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["204"] = _TT(513704)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["205"] = _TT(513705)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["206"] = _TT(513701)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["207"] = _TT(513702)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["209"] = _TT(513704)
-- recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["210"] = _TT(513705)

recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["211"] = _TT(513707)
recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["212"] = _TT(513708)
recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["213"] = _TT(513709)
recharge.rechargeDic[recharge.RechargeType.GIFT_DIRECT_BUY]["214"] = _TT(513710)

--成长基金
recharge.rechargeDic[recharge.RechargeType.GROWTH_FUND_BUY] = _TT(72110)

recharge.rechargeDic[recharge.RechargeType.FASHION_PERMIT] = {}
recharge.rechargeDic[recharge.RechargeType.FASHION_PERMIT]["1"] = "时装通行证"

recharge.rechargeDic[recharge.RechargeType.STRENGTH_CARD]  = _TT(50072)

recharge.rechargeDic[recharge.RechargeType.FASHION_PERMIT_TWO] = {}
recharge.rechargeDic[recharge.RechargeType.FASHION_PERMIT_TWO]["1"] = "时装通行证2"



recharge.rechargeDic[recharge.RechargeType.SUPERCIAL] = {}
recharge.rechargeDic[recharge.RechargeType.SUPERCIAL]["1"] = _TT(138020)
recharge.rechargeDic[recharge.RechargeType.SUPERCIAL]["4"] = _TT(138021)
recharge.rechargeDic[recharge.RechargeType.SUPERCIAL]["7"] = _TT(138022)
recharge.rechargeDic[recharge.RechargeType.SUPERCIAL]["9"] = _TT(138023)
recharge.rechargeDic[recharge.RechargeType.SUPERCIAL]["11"] = _TT(138024)

recharge.rechargeDic[recharge.RechargeType.CARNIVAL_GIFT] = {}
recharge.rechargeDic[recharge.RechargeType.CARNIVAL_GIFT]["1"] = _TT(138501)

recharge.rechargeDic[recharge.RechargeType.SELECT_GIFT] = {}
recharge.rechargeDic[recharge.RechargeType.SELECT_GIFT]["1"] = _TT(149003)
recharge.rechargeDic[recharge.RechargeType.SELECT_GIFT]["2"] = _TT(149004)
recharge.rechargeDic[recharge.RechargeType.SELECT_GIFT]["3"] = _TT(149005)
recharge.rechargeDic[recharge.RechargeType.SELECT_GIFT]["4"] = _TT(149006)
recharge.rechargeDic[recharge.RechargeType.SELECT_GIFT]["5"] = _TT(149007)


recharge.sendRecharge = function(cusType, cusSubType, detailId, successCallBack)
    detailId = detailId and tostring(detailId) or detailId
    local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(cusType, cusSubType, detailId)
    if rechargeVo then
        local name = ""
        if cusType == recharge.RechargeType.GIFT_DIRECT_BUY then
            -- 直购礼包统一处理
            if detailId then
                local vo = purchase.DirectBuyManager:getDirectBuyVoById(detailId)
                if vo then
                    name = vo:getItemName()
                end
            end
        elseif cusType == recharge.RechargeType.LIMITSHOP_GIFT then
            local vo = activity.ActitvityExtraManager:getLimitShopGiftDic()[detailId]
            if vo then
                name = vo:getName()
            end
        elseif cusType == recharge.RechargeType.FASHION_HISTORY then
            local vo = activity.ActitvityExtraManager:getFashionHisDataById(tonumber(detailId))
            if vo then
                name = _TT(vo.rechargeName)
            end
        elseif cusType == recharge.RechargeType.FASHION_OTHER then
            name = purchase.FashionShopManager:getRechargeName(tonumber(detailId))
        elseif cusType == recharge.RechargeType.FASHION_COMBO then
            local vo = purchase.FashionShopManager:getComboShopItemById(tonumber(detailId))
                if vo then
                    name = _TT(vo.configVo.name)
                end
        else
            name = recharge.rechargeDic[cusType]
            if detailId then
                name = recharge.rechargeDic[cusType][detailId]
            end
        end
        --cusLog("发送充值请求====".. "类型：".. cusType.. "===".. "传入id".. detailId.. "===".. "name:".. name)
        
        GameDispatcher:dispatchEvent(EventName.REQ_RECHARGE, { type = rechargeVo.type, subType = nil, itemId = rechargeVo.itemId, itemTitle = _TT(50026), itemName = name, itemDes = _TT(50027), successFun = successCallBack })
    else
        logError("无对应充值数据====" .. "类型：" .. cusType .. "===" .. "传入id" .. detailId)
    end
end

--[[ 替换语言包自动生成，请勿修改！
]]