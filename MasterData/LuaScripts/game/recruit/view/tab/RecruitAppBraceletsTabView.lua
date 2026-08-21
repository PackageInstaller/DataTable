-- @FileName:   RecruitAppBraceletsTabView.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-24 18:29:14
-- @Copyright:   (LY) 2024 锚点降临
module("recruit.RecruitAppBraceletsTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitAppBraceletsTab.prefab")

--构造函数
function ctor(self, recruitId)
    super.ctor(self)
    self.m_recruitId = recruitId
end

-- 初始化数据
function initData(self)
    -- self.m_recruitType = recruit.RecruitType.RECRUIT_APP_BRACELETS
end

function configUI(self)
    self.m_btnLog = self:getChildGO("BtnLog")
    self.m_btnRule = self:getChildGO("BtnRule")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")
    self.mBtnShop = self:getChildGO("BtnShop")
    self.mBtnSeniorApp = self:getChildGO("BtnSeniorApp")

    self.mBtnLook = self:getChildGO("mBtnLook")

    self.m_propsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.m_textCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.m_propsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.m_textCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.mTxtActivetyTime = self:getChildGO("mTxtActivetyTime"):GetComponent(ty.Text)

    self.mTextVBtnApp = self:getChildGO("mTextVBtnApp"):GetComponent(ty.Text)

    self.mImgIcon01 = self:getChildGO("mImgIcon01"):GetComponent(ty.AutoRefImage)
    self.mImgIconBg = self:getChildGO("mImgIconBg")

    self.mBtnTips = self:getChildGO("mBtnTips")

    self.mTextBuyTips = self:getChildGO("mTextBuyTips"):GetComponent(ty.Text)
    self.mImgShopIcon = self:getChildGO("mImgShopIcon"):GetComponent(ty.AutoRefImage)
    self.mTextBuyCount = self:getChildGO("mTextBuyCount"):GetComponent(ty.Text)
    self.mTextBuy = self:getChildGO("mTextBuy"):GetComponent(ty.Text)
    self.mShopBuy = self:getChildGO("mShopBuy")
    self.shopBuyLayout = self:getChildGO("shopBuyLayout")

    self.mTxtData = self:getChildGO("mTxtData"):GetComponent(ty.Text)
    self.mDebugUpInfo = self:getChildGO("mDebugUpInfo")
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.bagUpdate, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onModuleRedUpdate, self)

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.refreshShopBuy, self)

    self:updateView(true)
end

function deActive(self)
    self:clearAcitivety()

    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.bagUpdate, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onModuleRedUpdate, self)

    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.refreshShopBuy, self)

end

function initViewText(self)
    self:setBtnLabel(self.mBtnOne, 28023, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28024, "招募十次")
    self:setBtnLabel(self.mBtnSeniorApp, 135020, "招募十次")

    self.mTextVBtnApp.text = _TT(135007)

    self.mTextBuyTips.text = _TT(93126)
    self.mTextBuy.text = _TT(10)
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnLog, self.onClickLogHandler)
    self:addUIEvent(self.m_btnRule, self.onClickRuleHandler)
    self:addUIEvent(self.mBtnShop, self.onClickShop)
    self:addUIEvent(self.mBtnSeniorApp, self.onClickSeniorAppHandler)

    self:addUIEvent(self.mBtnOne, self.onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.onClickTenHandler)

    self:addUIEvent(self.mBtnLook, self.onClickApp)

    self:addUIEvent(self.mBtnTips, self.onClickLookTips)
    self:addUIEvent(self.mShopBuy, self.onClickShopBuy)
end

function onClickLookTips(self)
    local select_id = self.m_recruitInfo.select_tid
    local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
    equipVo:setTid(select_id)
    TipsFactory:equipTips(equipVo)
end

function onClickApp(self)
    -- local recruit_info = self.m_recruitInfo
    -- if recruit_info.select_tid ~= 0 and recruit_info.first_week == 1 then
    --     gs.Message.Show(_TT(135014))
    --     return
    -- end

    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_APP_SELECTPANEL, {recruitId = self.m_recruitId, type = 1})
end

function onClickShop(self)
    if read.ReadManager:isModuleRead(219, 2060) then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = 219, id = 2060})
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.CovenantShop})
end

function onClickLogHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_LOG_PANEL, {recruitId = self.m_recruitId})
end

function onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {recruitId = self.m_recruitId})
end

function onClickSeniorAppHandler(self)
    if recruit.RecruitManager:updateSeniorAppBraceletsRedState() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = 219, id = 800})
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_APP_SELECTPANEL, {recruitId = self.m_recruitId, type = 2})
end

function onClickOneHandler(self)
    if self.m_recruitInfo.select_tid == 0 then
        gs.Message.Show(_TT(135009))
        return
    end

    self:checkSend(self.m_recruitId, 1)
end

function onClickTenHandler(self)
    if self.m_recruitInfo.select_tid == 0 then
        gs.Message.Show(_TT(135009))
        return
    end

    self:checkSend(self.m_recruitId, 10)
end

function onClickShopBuy(self)
    local select_id = self.m_recruitInfo.select_tid
    if select_id ~= 0 then
        local shopId = select_id
        local shopVo = shop.ShopManager:getShopItemByTid(ShopType.COVENANT, shopId)
        if shopVo then
            GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_VIEW, shopVo)
        else
            logError("商店没有这个商品 id = " .. shopId)
        end
    end
end

function checkSend(self, recruitId, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, {recruitId = recruitId, times = times})
end

function onUpdateViewHandler(self, args)
    self:updateView(false)
end

function onDebugInfo(self)
    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
        self.mDebugUpInfo:SetActive(true)

        local debugUpInfo = recruit.RecruitManager:getDebugShowRecruitUpInfoMsg(self.m_recruitId)
        if debugUpInfo then
            local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
            equipVo:setTid(self.m_recruitInfo.select_tid)

            local msg = ""
            for i, v in ipairs(debugUpInfo.other_ratio) do
                msg = msg .. v.key .. ": " .. v.value .. "\n"
            end
            self.mTxtData.text = "当前UP烙痕：" .. equipVo:getName() .. " tid: " .. self.m_recruitInfo.select_tid .. "\n当前UP烙痕权重：" .. debugUpInfo.up_ratio .. "\n其他烙痕权重：\n" .. msg
        else
            self.mTxtData.text = "获取UP Debug数据出错了，请排查是否是配置出错。卡池ID:" .. self.m_recruitId
        end
    else
        self.mDebugUpInfo:SetActive(false)
        self.mTxtData.text = ""
    end
end

function updateView(self, cusIsInit)
    self.m_recruitInfo = recruit.RecruitManager:getRecruitInfo(self.m_recruitId)
    if self.m_recruitInfo then
        local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
        local costMoneyTid_one = configVo:getCostOneId()
        local costMoneyCount_one = configVo:getCostOneNum()
        local costMoneyTid_ten = configVo:getCostTenId()
        local costMoneyCount_ten = configVo:getCostTenNum()

        self.m_propsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
        self.m_textCount_one.text = "x" .. costMoneyCount_one
        self.m_propsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
        self.m_textCount_ten.text = "x" .. costMoneyCount_ten

        local select_id = self.m_recruitInfo.select_tid
        if select_id ~= 0 then
            self.mImgIcon01:SetImg(UrlManager:getPropsIconUrl(select_id), true)

            self:onDebugInfo()
        end

        self.mImgIconBg.gameObject:SetActive(select_id ~= 0)
        self.mBtnTips.gameObject:SetActive(select_id ~= 0)

        self:updateShowActivetyTimer()
        self:updateRedState()
        self:shopBuyRedUpdate()
        self:updateSeniorAppRed()

        self:refreshShopBuy()
    end
end

function refreshShopBuy(self)
    self.shopBuyLayout:SetActive(false)

    local select_id = self.m_recruitInfo.select_tid
    if select_id ~= 0 then
        local shopId = select_id
        local shopVo = shop.ShopManager:getShopItemByTid(ShopType.COVENANT, shopId)
        if shopVo then
            self.shopBuyLayout:SetActive(true)
            self.mImgShopIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(shopVo:getPayTid()), false)

            local namecolorStr = MoneyUtil.getMoneyCountByTid(shopVo:getRealPayType()) < shopVo.price and "FFFFFF" or "18ec68"
            self.mTextBuyCount.text = string.format("<color=#%s>%s/%s</color>", namecolorStr, MoneyUtil.getMoneyCountByTid(shopVo:getRealPayType()), MoneyUtil.shortValueStr(shopVo.price))
            -- else
            --     logError("商店没有这个商品 id = " .. shopId)
        end
    end
end

function bagUpdate(self)
    self:refreshShopBuy()
    self:updateRedState()
    self:shopBuyRedUpdate()
end

function onModuleRedUpdate(self)
    self:updateRedState()
    self:shopBuyRedUpdate()
    self:updateSeniorAppRed()
end

function shopBuyRedUpdate(self)
    if recruit.RecruitManager:updateAppBraceletsShopBuyRedState(self.m_recruitId) then
        RedPointManager:add(self:getChildTrans("mShopBuy"), nil, 46, 9)
    else
        RedPointManager:remove(self:getChildTrans("mShopBuy"))
    end
end

function updateRedState(self)
    local actBraceletsShopRedState = recruit.RecruitManager:updateAppBraceletsShopRedState()
    if actBraceletsShopRedState then
        RedPointManager:add(self:getChildTrans("mShopRed"), nil, 0, 0)
    else
        RedPointManager:remove(self:getChildTrans("mShopRed"))
    end
end

function updateSeniorAppRed(self)
    local actBraceletsShopRedState = recruit.RecruitManager:updateSeniorAppBraceletsRedState()
    if actBraceletsShopRedState then
        RedPointManager:add(self:getChildTrans("BtnSeniorApp"), nil, 15, 15)
    else
        RedPointManager:remove(self:getChildTrans("BtnSeniorApp"))
    end
end

function updateShowActivetyTimer(self)
    self:clearAcitivety()

    self.m_appType = 1
    if self.m_recruitInfo.select_tid ~= 0 then
        local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
        for k, v in pairs(configVo.hero_list[2]) do
            if self.m_recruitInfo.select_tid == v then
                self.m_appType = 2
                break
            end
        end
    end

    self:showActivetyTime()
    self.activetyTimeShowTimer = self:addTimer(1, 0, self.showActivetyTime)
end

function showActivetyTime(self)
    if self.m_appType == 1 then
        local clientDt = GameManager:getClientTime()
        clientDt = clientDt - 5 * 3600
        local clientData = os.date("*t", clientDt)

        --算出今天是周几
        local wDay = clientData.wday - 1
        if wDay == 0 then
            wDay = 7
        end

        --与下周一相差几天
        local addDay = 7 - wDay -- 完整的天数
        local addDt = addDay * 86400 + (86400 - (clientData.hour * 3600) - (clientData.min * 60) - clientData.sec) --距离一天所相差的时间

        self.mTxtActivetyTime.text = _TT(135001, TimeUtil.getFormatTimeBySeconds_1(addDt))
    else
        self.m_endTime = self.m_recruitInfo.select_plus_list[self.m_recruitInfo.select_tid]
        local time = self.m_endTime - GameManager:getClientTime()
        if time <= 0 then
            self.m_appType = 1
        else
            self.mTxtActivetyTime.text = _TT(135025) .. TimeUtil.getFormatTimeBySeconds_9(time)
        end
    end
end

function clearAcitivety(self)
    if self.activetyTimeShowTimer then
        self:removeTimerByIndex(self.activetyTimeShowTimer)
        self.activetyTimeShowTimer = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
