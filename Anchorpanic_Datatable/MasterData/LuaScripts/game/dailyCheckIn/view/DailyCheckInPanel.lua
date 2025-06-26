--[[ 
-----------------------------------------------------
@filename       : DailyCheckInPanel
@Description    : 签到面板
@date           : 2023-3-13 
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("dailyCheckIn.DailyCheckInPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("dailyCheckIn/DailyCheckInPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle("每日签到")
    self:setUICode(LinkCode.HomeSignIn)
end

function initData(self)
    self.mPropsItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBlackMask = self:getChildGO("mBlackMask")
    self.mIconMoonth = self:getChildGO("mIconMoonth")
    self.mGlowEffect = self:getChildGO("mGlowEffect")
    self.mNomalTrans = self:getChildTrans("mNomalTrans")
    self.mImgCheckState = self:getChildGO("mImgCheckState")
    self.mMonthlyTrans = self:getChildTrans("mMonthlyTrans")
    self.mImgMonthlyAward = self:getChildGO("mImgMonthlyAward")
    self.mImgGiveMonthlyAward = self:getChildGO("mImgGiveMonthlyAward")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mImgMonth = self:getChildGO("mImgMonth"):GetComponent(ty.AutoRefImage)
    self.mImgTxtMonth = self:getChildGO("mImgTxtMonth"):GetComponent(ty.AutoRefImage)
    self.mScroller:SetItemRender(dailyCheckIn.DailyCheckInItem)
    self.mTxtMoonthTime = self:getChildGO("mTxtMoonthTime"):GetComponent(ty.Text)
    self.mTxtCheckState = self:getChildGO("mTxtCheckState"):GetComponent(ty.Text)
    self.mTxtNomalAward = self:getChildGO("mTxtNomalAward"):GetComponent(ty.Text)
    self.mTxtMonthlyAward = self:getChildGO("mTxtMonthlyAward"):GetComponent(ty.Text)
    self.mImgCurMonth = self:getChildGO("mImgCurMonth"):GetComponent(ty.AutoRefImage)
    self.mImgIconEffect = self:getChildGO("mImgIconEffect"):GetComponent(ty.AutoRefImage)

    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mTxtShowPropsNum = self:getChildGO("mTxtShowPropsNum"):GetComponent(ty.Text)
    self.mTxtPropsName = self:getChildGO("mTxtPropsName"):GetComponent(ty.Text)

    self.mGiveMonthlyTrans = self:getChildTrans("mGiveMonthlyTrans")
    self.mTxtGiveMoonthTime = self:getChildGO("mTxtGiveMoonthTime"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SIGNIN_VIEW, self.updateView, self)
    --GameDispatcher:addEventListener(EventName.UPDATE_SELECT_STATE, self.updateShowInfo, self)

    self:updateView()
    self:updateTime()
    self:addTimer(1, 0, self.updateTime)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SIGNIN_VIEW, self.updateView, self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_STATE, self.updateShowInfo, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end

end

function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.SIGNIN_PANEL_CLOSE)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mImgMonthlyAward, self.onMonthCardHandler)

    self:addUIEvent(self.mImgGiveMonthlyAward,self.onStrengthCardHandler)
end

function open(self, args)
    super.open(self, args)
    local isInit = args
    if dailyCheckIn.DailyCheckInManager:getIsSign() == false then
        if isInit then
            if self.mScroller then
                self.mScroller:CleanAllItem()
            end
            self:updateView()
            --self:updateShowInfo(dailyCheckIn.DailyCheckInManager:getCurDailyCheckInVo())
        end
        GameDispatcher:dispatchEvent(EventName.REQ_SIGNIN)
    end
end

function initViewText(self)
    self.mTxtNomalAward.text = _TT(48149)
end

function updateView(self, awardVo)
    local list = dailyCheckIn.DailyCheckInManager:getDailyCheckInList()
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    if dailyCheckIn.DailyCheckInManager:getCurMonth() < 10 then
        self.mImgMonth:SetImg(UrlManager:getPackPath("dailyCheckIn/signNum_0.png"), true)
        self.mImgCurMonth:SetImg(UrlManager:getPackPath("dailyCheckIn/signNum_" ..
                                                            dailyCheckIn.DailyCheckInManager:getCurMonth() .. ".png"),
            true)
    else
        self.mImgMonth:SetImg(UrlManager:getPackPath("dailyCheckIn/signNum_1.png"), true)
        self.mImgCurMonth:SetImg(UrlManager:getPackPath("dailyCheckIn/signNum_" ..
                                                            (dailyCheckIn.DailyCheckInManager:getCurMonth() - 10) ..
                                                            ".png"), true)
    end
    self.mImgTxtMonth:SetImg(UrlManager:getPackPath("dailyCheckIn/mon_" ..
                                                        dailyCheckIn.DailyCheckInManager:getCurMonth() .. ".png"), true)

    self:updateShowInfo(dailyCheckIn.DailyCheckInManager:getCurDailyCheckInVo())
    if awardVo then
        GameDispatcher:dispatchEvent(EventName.UPDATE_SIGNIN_ITEM, awardVo)
    end
end

function updateShowInfo(self, dailyVo)
    self.mImgProps:SetImg(UrlManager:getPropsIconUrl(dailyVo:gettDailyItemTid()), false)
    self.mTxtShowPropsNum.text = "x" .. dailyVo:getDailyItemNum()
    local vo = props.PropsManager:getTypePropsVoByTid(dailyVo:gettDailyItemTid())
    self.mTxtPropsName.text = vo:getName()

    self:closePropsList()
    -- local propsGrid1 = PropsGrid:createByData({ tid = dailyVo:gettDailyItemTid(), num = dailyVo:getDailyItemNum(), parent = self.mNomalTrans, scale = 1, showUseInTip = true })
    -- propsGrid1:setHasRec(dailyVo:getIsRecived())
    -- table.insert(self.mPropsItemList, propsGrid1)
    for index, awardVo in ipairs(dailyVo:getMooncardAwardList()) do
        local propVo = props.PropsManager:getPropsConfigVo(awardVo[1])
        local item = SimpleInsItem:create(self:getChildGO("mGroupItem"), self.mMonthlyTrans,
            "DailyCheckInPanelsignMonthlyItem")
        item:getChildGO("mImgColorLine"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(
            ColorUtil:getPropLineColor(propVo.color))
        item:getChildGO("mImgIconEffect"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(propVo.tid),
            false)
        item:getChildGO("mGlowEffect_" .. propVo.color):SetActive(true)
        item:getChildGO("mGroupHasRec"):SetActive(purchase.MonthCardManager:getIsBuyMonthlyed())
        item:getChildGO("mTxtCountRight"):SetActive(awardVo[2] > 1)
        item:getChildGO("mTxtCountRight"):GetComponent(ty.Text).text = awardVo[2]
        item:addUIEvent(nil, function()
            local rect = item:getTrans()
            if (propVo.type ~= PropsType.EQUIP) then
                TipsFactory:propsTips({
                    propsVo = propVo,
                    isShowUseBtn = nil
                }, {
                    rectTransform = rect
                })
            end
        end)
        table.insert(self.mPropsItemList, item)
    end

    local tid = sysParam.SysParamManager:getValue(SysParamType.STRENGTH_PROPS_TID)
    local count = sysParam.SysParamManager:getValue(SysParamType.STRENGTH_PROPS_COUNT)
    local propVo = props.PropsManager:getPropsConfigVo(tid)
    local item = SimpleInsItem:create(self:getChildGO("mGroupItem"), self.mGiveMonthlyTrans,"DailyCheckInPanelsignMonthlyItem")
    item:getChildGO("mImgColorLine"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(
        ColorUtil:getPropLineColor(propVo.color))
    item:getChildGO("mImgIconEffect"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(propVo.tid),
        false)
    item:getChildGO("mGlowEffect_" .. propVo.color):SetActive(true)
    item:getChildGO("mGroupHasRec"):SetActive(purchase.MonthCardManager:getIsBuyStrengthMonthlyed())
    item:getChildGO("mTxtCountRight"):SetActive(count > 1)
    item:getChildGO("mTxtCountRight"):GetComponent(ty.Text).text = count
    item:addUIEvent(nil, function()
        local rect = item:getTrans()
        if (propVo.type ~= PropsType.EQUIP) then
            TipsFactory:propsTips({
                propsVo = propVo,
                isShowUseBtn = nil
            }, {
                rectTransform = rect
            })
        end
    end)
    table.insert(self.mPropsItemList, item)
    -- self.mImgIconEffect:SetImg(UrlManager:getPropsIconUrl(self.mMonthPropVo.tid), false)
end

function closePropsList(self)
    if #self.mPropsItemList > 0 then
        for _, item in ipairs(self.mPropsItemList) do
            item:poolRecover()
            item = nil
        end
        self.mPropsItemList = {}
    end
end

function onMonthCardHandler(self)
    --if purchase.MonthCardManager:getLeftDays() <= 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
            linkId = LinkCode.MonthCard
        })
        -- GameDispatcher:dispatchEvent(EventName.OPEN_PURCHASE_PANEL, { type = purchase.PurchaseTab.MONTH_CARD })
        self:close()
    --end
end

function onStrengthCardHandler(self)
    --if purchase.MonthCardManager:getStrengthLeftDays() <= 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
            linkId = LinkCode.StrengthCard
        })
        self:close()
    --end
end

function updateTime(self)
    local Time = TimeUtil.getTimeTable(GameManager:getClientTime())
    local curTime = Time.hour < 5 and welfareOpt.WelfareOptManager:getConversionTimetoSec1(5, 0, 0) or
                        welfareOpt.WelfareOptManager:getConversionTimetoSec1(29, 0, 0)
    local subTime = curTime - welfareOpt.WelfareOptManager:getConversionTimetoSec1(Time.hour, Time.min, Time.sec)
    self.mTxtTime.text = TimeUtil.getHMSByTime(subTime) .. "  刷新"
    -- self.mTxtMoonthTime.text = purchase.MonthCardManager:getLeftDays() <= 0 and "去开通" or
    --                                HtmlUtil:size(_TT(50017, purchase.MonthCardManager:getLeftDays()), 20)
    -- self.mTxtMoonthTime.gameObject:SetActive(purchase.MonthCardManager:getLeftDays() > 0)
    -- self.mImgMonthlyAward:SetActive(purchase.MonthCardManager:getLeftDays() <= 0)
    -- self.mImgGiveMonthlyAward:SetActive(purchase.MonthCardManager:getStrengthLeftDays()<=0)
    -- self.mIconMoonth:SetActive(purchase.MonthCardManager:getLeftDays() <= 0)
    -- self.mTxtMoonthTime.color = gs.ColorUtil.GetColor("ffffffff")
    -- if purchase.MonthCardManager:getLeftDays() < 3 and purchase.MonthCardManager:getLeftDays() > 0 then
    --     self.mTxtMoonthTime.text = _TT(50017, purchase.MonthCardManager:getLeftDays()) .. "!"
    --     self.mTxtMoonthTime.color = gs.ColorUtil.GetColor("d53529ff")
    -- end
    self.mTxtMoonthTime.text = HtmlUtil:size(_TT(50017, purchase.MonthCardManager:getLeftDays()), 20)
    self.mTxtMoonthTime.gameObject:SetActive(purchase.MonthCardManager:getLeftDays()>0)
    self.mTxtGiveMoonthTime.text = HtmlUtil:size(_TT(50017, purchase.MonthCardManager:getStrengthLeftDays()), 20)
    self.mTxtGiveMoonthTime.gameObject:SetActive(purchase.MonthCardManager:getStrengthLeftDays()>0)
end

function hideMask(self)
    self.mask:SetActive(false)
    self.mBtnClose:SetActive(false)
    self.mBlackMask:SetActive(false)
    if self.mBlurMask then
        gs.GameObject.Destroy(self.mBlurMask)
        self.mBlurMask = nil
    end
    -- self.m_childGos["BaseBlurMask"]:SetActive(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
