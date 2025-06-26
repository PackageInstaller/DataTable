--[[ 
-----------------------------------------------------
@filename       : WelfareOptGoldWisingView
@Description    : 金币许愿
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptGoldWishingView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptGoldWishingView.prefab")

function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

-- 初始化
function configUI(self)
    self.mTipsTxt1 = self:getChildGO("TipsTxt1"):GetComponent(ty.Text)
    self.mTipsTxt2 = self:getChildGO("TipsTxt2"):GetComponent(ty.Text)
    self.mTipsTxt3 = self:getChildGO("TipsTxt3"):GetComponent(ty.Text)
    self.mTipsTxt4 = self:getChildGO("TipsTxt4"):GetComponent(ty.Text)

    self.mChangeBtn = self:getChildGO("ChangeBtn")
    self.mChangeBtnImg = self.mChangeBtn:GetComponent(ty.AutoRefImage)

    self.mChangeBtnTxt = self:getChildGO("ChangeBtnTxt"):GetComponent(ty.Text)
    --self.mChangeBtnEnTxt = self:getChildGO("ChangeBtnEnTxt"):GetComponent(ty.Text)

    self.mPropImg = self:getChildGO("PropImg"):GetComponent(ty.AutoRefImage)
    self.mPropNum = self:getChildGO("PropNum"):GetComponent(ty.Text)

    self.mPropGroup = self:getChildGO("PropGroup")

    self.mRedPoint = self:getChildGO("RedPoint")
    self:setGuideTrans("guide_BtnGoldWishing", self.mChangeBtn.transform)

    --self.mRedPoint = self:getChildGO("RedPoint")
end

--激活
function active(self)
    super.active(self)

    MoneyManager:setMoneyTidList({MoneyTid.GOLD_COIN_TID})
    GameDispatcher:addEventListener(EventName.UPDATE_WELFARE_GOLD_WISH, self.__updateGoldWishingHandler, self)

    self:showPanel()
end

--更新金币祈愿
function __updateGoldWishingHandler(self)
    self:showPanel()
end

function showPanel(self)
    local vo = welfareOpt.WelfareOptManager:getGoldWishingServerData()
    self.tadayTimes = vo.hadWishTimes
    self.accTimes = vo.accWishTimes
    self.state = vo.state
    self.wishEndTime = vo.wishEndTime

    self.goldData = welfareOpt.WelfareOptManager:getGoldWishingData(self.tadayTimes + 1)
    local wishMax = sysParam.SysParamManager:getValue(47)
    self.tadayMax = sysParam.SysParamManager:getValue(48)

    LoopManager:removeTimer(self, self.__setTime)
    if self.state == 0 then
        if self.tadayMax == self.tadayTimes then
            self.mChangeBtn.gameObject:SetActive(false)
            self.mTipsTxt1.text = _TT(48107) --"今日金币祈愿已完成"
            self.mPropGroup:SetActive(false)
        else
            self.mTipsTxt1.text = _TT(48108, self.goldData.goldCost)
            self.mPropGroup:SetActive(true)

            self.mPropNum.text = self.goldData.goldCost
            local myNum = MoneyUtil.getMoneyCountByTid(1)
            self.mRedPoint:SetActive(myNum >= self.goldData.goldCost)

            self.mPropNum.gameObject:SetActive(true)
            self.mPropImg.gameObject:SetActive(true)
            self.mTipsTxt2.gameObject:SetActive(false)
            self.mChangeBtnTxt.text = _TT(48109)
            self.mChangeBtnTxt.alignment = gs.TextAnchor.MiddleRight
            self.mChangeBtn.gameObject:SetActive(true)
    
            self.mChangeBtnImg:SetImg(UrlManager:getCommon4Path("common_3401.png"), false)
            self.mChangeBtnTxt.color = gs.COlOR_WHITE
        end
        --self.mChangeBtnEnTxt.color = gs.COlOR_BLACK
    elseif self.state == 1 then
        self.mTipsTxt1.text = _TT(48110)
        --self.mTipsTxt2.text = string.substitute("大概{0}后送达")
        self.mTipsTxt2.gameObject:SetActive(true)
        self.mPropNum.gameObject:SetActive(false)
        self.mPropImg.gameObject:SetActive(false)
        LoopManager:addTimer(0, 0, self, self.__setTime)
        self.mChangeBtn.gameObject:SetActive(false)
    elseif self.state == 2 then
        self.mTipsTxt1.text = _TT(48112) --"奖励已送达,请注意查收!"
        self.mChangeBtnTxt.text = _TT(48113) --"查看奖励"
        self.mChangeBtnTxt.alignment = gs.TextAnchor.MiddleCenter
        self.mChangeBtn.gameObject:SetActive(true)
        self.mTipsTxt2.gameObject:SetActive(false)

        self.mChangeBtnImg:SetImg(UrlManager:getCommonNewPath("common_3401.png"), false)
        self.mChangeBtnTxt.color = gs.COlOR_WHITE
        --self.mChangeBtnEnTxt.color = gs.COlOR_WHITE
        self.mPropGroup:SetActive(false)
    end
    self.mTipsTxt4.text = _TT(48114, self.tadayMax - self.tadayTimes)
    self.mTipsTxt3.text = _TT(48121, self.accTimes, wishMax)
end

function __setTime(self)
    local endTime = self.wishEndTime
    local clientTime = GameManager:getClientTime()

    local reamainTime = endTime - clientTime
    -- if(reamainTime <= 0) then
    --     self:showPanel()
    --     return
    -- end

    -- local hours = math.floor((reamainTime % 86400)/3600)
    -- local mins = math.floor((reamainTime % 3600)/60)
    -- local secs = reamainTime % 60

    -- local s = hours..":"..mins..":"..secs

    self.mTipsTxt2.text = _TT(48111, TimeUtil.getFormatTimeBySeconds_1(reamainTime))
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_WELFARE_GOLD_WISH, self.__updateGoldWishingHandler, self)
    LoopManager:removeTimer(self, self.__setTime)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mChangeBtn, self.__onChangeBtnClick)
end

function __onChangeBtnClick(self)
    if self.state == 0 then
        if self.tadayMax == self.tadayTimes then
            gs.Message.Show(_TT(48115))
            return
        end

        local myNum = MoneyUtil.getMoneyCountByTid(1)
        if self.goldData.goldCost > myNum then
            gs.Message.Show(_TT(48116))
            return
        end

        GameDispatcher:dispatchEvent(EventName.REQ_START_GOLD_WISH)
    elseif self.state == 2 then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_GOLD_WISH)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
