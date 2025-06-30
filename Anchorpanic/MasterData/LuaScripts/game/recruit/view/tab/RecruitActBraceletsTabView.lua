module("recruit.RecruitActBraceletsTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitActBraceletsTab.prefab")

function ctor(self, recruitId)
    self.m_recruitId = recruitId

    super.ctor(self)
end

function onLoadAssetComplete(self)
    -- 实例化是一个克隆对象，并不是加载的那个prefab，需要重新取
    self.UIObject = AssetLoader.GetGO(self.UIRes, self)
    self.UITrans = self.UIObject.transform

    local res_list = {121, 122, 123}

    local go_dic = {}
    for i = 1, #res_list do
        local go = self.UITrans:Find("RecruitActBraceletsTab_" ..res_list[i]).gameObject
        go:SetActive(res_list[i] == self.m_recruitId)
        go_dic[res_list[i]] = go
    end

    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(go_dic[self.m_recruitId])

    self:configUI()
    self:dispatchEvent(EVENT_LOAD_FINISH)
    self:addOnParent()
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.m_btnLog = self:getChildGO("BtnLog")
    self.m_btnRule = self:getChildGO("BtnRule")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")

    self.m_propsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.m_textCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.m_propsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.m_textCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)
    self.mBtnLook = self:getChildGO("mBtnLook")
    self.mBtnShop = self:getChildGO("BtnShop")
    self.mTxtData = self:getChildGO("mTxtData"):GetComponent(ty.Text)
    self.mDebugUpInfo = self:getChildGO("mDebugUpInfo")

    self.mTextBuyTips = self:getChildGO("mTextBuyTips"):GetComponent(ty.Text)
    self.mImgShopIcon = self:getChildGO("mImgShopIcon"):GetComponent(ty.AutoRefImage)
    self.mTextBuyCount = self:getChildGO("mTextBuyCount"):GetComponent(ty.Text)
    self.mTextBuy = self:getChildGO("mTextBuy"):GetComponent(ty.Text)
    self.mShopBuy = self:getChildGO("mShopBuy")
    self.shopBuyLayout = self:getChildGO("shopBuyLayout")

end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.bagUpdate, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateRedState, self)

    self:updateView(true)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.bagUpdate, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateRedState, self)

end

function initViewText(self)
    super.initViewText(self)

    self:setBtnLabel(self.mBtnOne, 28035, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28036, "招募十次")

    self.mTextBuyTips.text = _TT(93126)
    self.mTextBuy.text = _TT(10)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLook, self.onClickLookTips)
    self:addUIEvent(self.mBtnShop, self.onClickShop)

    self:addUIEvent(self.m_btnLog, self.onClickLogHandler)
    self:addUIEvent(self.m_btnRule, self.onClickRuleHandler)
    self:addUIEvent(self.mBtnOne, self.onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.onClickTenHandler)
    self:addUIEvent(self.mShopBuy, self.onClickShopBuy)
end

function onClickLookTips(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)

    local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
    equipVo:setTid(configVo.show_item)
    TipsFactory:equipTips(equipVo)
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

function onClickOneHandler(self)
    if (recruit.RecruitManager.recruitTopTimes + 1 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 1)
    end
end

function onClickTenHandler(self)
    if (recruit.RecruitManager.recruitTopTimes + 10 > sysParam.SysParamManager:getValue(SysParamType.RECRUIT_TOP_DAILY_MAX)) then
        gs.Message.Show(_TT(28009))--"不可超过招募次数上限"
    else
        self:checkSend(self.m_recruitId, 10)
    end
end

function onClickShopBuy(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local shopId = configVo.show_item
    local shopVo = shop.ShopManager:getShopItemByTid(ShopType.COVENANT, shopId)
    if shopVo then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_VIEW, shopVo)
    else
        logError("商店没有这个商品 id = " .. shopId)
    end
end

function checkSend(self, recruitId, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, {recruitId = recruitId, times = times})
end

function onUpdateViewHandler(self, args)
    -- local type = args.type
    -- if (type == self.m_recruitType) then
    self:updateView(false)
    -- end
end

function updateView(self, cusIsInit)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local costMoneyTid_one = configVo:getCostOneId()
    local costMoneyCount_one = configVo:getCostOneNum()
    local costMoneyTid_ten = configVo:getCostTenId()
    local costMoneyCount_ten = configVo:getCostTenNum()

    self.m_propsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
    self.m_textCount_one.text = "x" .. costMoneyCount_one
    self.m_propsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
    self.m_textCount_ten.text = "x" .. costMoneyCount_ten

    self:upateActTime()

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
        self.mDebugUpInfo:SetActive(true)

        local debugUpInfo = recruit.RecruitManager:getDebugShowRecruitUpInfoMsg(self.m_recruitId)
        if debugUpInfo then
            local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
            equipVo:setTid(configVo.show_item)

            local msg = ""
            for i, v in ipairs(debugUpInfo.other_ratio) do
                msg = msg .. v.key .. ": " .. v.value .. "\n"
            end
            self.mTxtData.text = "当前UP烙痕：" .. equipVo:getName() .. " tid: " .. configVo.show_item .. "\n当前UP烙痕权重：" .. debugUpInfo.up_ratio .. "\n其他烙痕权重：\n" .. msg
        else
            self.mTxtData.text = "获取UP Debug数据出错了，请排查是否是配置出错。卡池ID:" .. self.m_recruitId
        end
    else
        self.mDebugUpInfo:SetActive(false)
        self.mTxtData.text = ""
    end

    self:updateRedState()
    self:refreshShopBuy()
    self:shopBuyRedUpdate()
end

function refreshShopBuy(self)
    self.shopBuyLayout:SetActive(false)

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local shopId = configVo.show_item
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

function bagUpdate(self)
    self:refreshShopBuy()
    self:updateRedState()
    self:shopBuyRedUpdate()
end

function shopBuyRedUpdate(self)
    if recruit.RecruitManager:updateActBraceletsShopBuyRedState(self.m_recruitId) then
        RedPointManager:add(self:getChildTrans("mShopBuy"), nil, 46, 9)
    else
        RedPointManager:remove(self:getChildTrans("mShopBuy"))
    end
end

function updateRedState(self)
    if recruit.RecruitManager:updateAppBraceletsShopRedState() then
        RedPointManager:add(self:getChildTrans("mShopRed"), nil, 0, 0)
    else
        RedPointManager:remove(self:getChildTrans("mShopRed"))
    end
end

function upateActTime(self)
    local menuVo = recruit.RecruitManager:getRecruitMenuVo(self.m_recruitId)

    local beginTime = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.beginTime))
    local endTime, endHour = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuVo.endTime))
    self.mTextTime.text = string.format("%s%s    %s", _TT(28046), endTime, endHour)
end

-- 已招募次数
function getRecruitTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).guaranteed_times
end
-- 需要招募次数
function getNeedTimes(self)
    return recruit.RecruitManager:getRecruitInfo(self.m_recruitId).guaranteed_limit
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(572):"未可领取"
语言包: _TT(7):"已领取"
]]
