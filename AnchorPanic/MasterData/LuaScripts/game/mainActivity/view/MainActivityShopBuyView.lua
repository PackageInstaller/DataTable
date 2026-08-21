--[[ 
-----------------------------------------------------
@filename       : MainActivityShopBuyView
@Description    : 活动玩法商店
@date           : 2023/5/24 15:00
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------]] module("mainActivity.MainActivityShopBuyView",
    Class.impl(shop.ShopBuyView))

function onBuyHandler(self)
    if self.mShopVo:getLimit() ~= 0 and self.mShopVo:getBuyTimes() >= self.mShopVo:getLimit() then
        gs.Message.Show(_TT(1379))
        return
    end

    local function call()
        local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.mShopVo:getRealPayType(), self.mNumberStepper
            .CurrCount * self.mShopVo:getPrice(), true, true)
        if result and tips == "" then
            GameDispatcher:dispatchEvent(EventName.REQ_MAINACTIVITY_BUY, {
                id = self.mShopVo:getId(),
                purchaseTime = self.mNumberStepper.CurrCount
            })
            self:close()
        end

        if not result then
            UIFactory:alertMessge(tips, true, function()
                self:close()
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        end
    end

    local propsVo = props.PropsManager:getPropsConfigVo(self.mShopVo.item_tid)

    --获取类型为时装 需要判断是否已经获取过时装了
    if propsVo.effectType == 13 then
        local heroTid = propsVo.effectList[1]
        local fashionId = propsVo.effectList[2]

        local have = fashion.FashionManager:getHeroFashionHaveInfo(fashion.Type.CLOTHES, heroTid, fashionId)
        if have == false then
            call()
        else
            UIFactory:alertMessge(_TT(84506), true, function()
                call()
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        end
    else
        call()
    end
    -- 
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
