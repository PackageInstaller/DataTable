--[[ 
-----------------------------------------------------
@filename       : FirstChargePanelTwo 30
@Description    : 首充面板 30元
@Author         : Sxt
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("firstCharge.FirstChargePanelTwo", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("firstCharge/FirstChargePanelTwo.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setUICode(LinkCode.FirstChargeTwo)
end

function initData(self)
    self.mPropsItemList = {}
    self.mDailyItemList = {}
    self.mCurDaily = 1
end

-- 初始化
function configUI(self)
    super.configUI(self)
    -- self.mItemDay = self:getChildGO("mItemDay")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnLock = self:getChildGO("mBtnLock")
    self.mBtnReceive = self:getChildGO("mBtnReceive")
    self.mImgReceived = self:getChildGO("mImgReceived")
    self.mGroupTrans = self:getChildTrans("mGroupTrans")
    -- self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtReceived = self:getChildGO("mTxtReceived"):GetComponent(ty.Text)
    -- self.mTxtTitleDown = self:getChildGO("mTxtTitleDown"):GetComponent(ty.Text)
    -- self.mTxtTitleDes = self:getChildGO("mTxtTitleDes"):GetComponent(ty.Text)
    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)

    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO,self.showPanel,self)
    GameDispatcher:addEventListener(EventName.UPDATE_FIRSTCHARGE_PANEL, self.updateView, self)
GameDispatcher:addEventListener(EventName.RESET_HIDE_PROMO,self.resetHide,self)
    -- if args and args.isShowToggle then
    --     self.mToggleRemaid.gameObject:SetActive(true)
    -- else
    --     self.mToggleRemaid.gameObject:SetActive(false)
    -- end
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO,self.showPanel,self)
    GameDispatcher:removeEventListener(EventName.RESET_HIDE_PROMO,self.resetHide,self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FIRSTCHARGE_PANEL, self.updateView, self)
    self:closeDailyList()
    self:closePropsList()

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    if self.mToggleRemaid.isOn then
        GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {
            moduleId = RemindConst.ACTIVITY_PROMO_SHOW
        })
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLock, self.onClickLockHandler)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnReceive, self.onClickReciveHandler)
end

function initViewText(self)
    self.mTxtTips.text = _TT(151016)
    -- self.mTxtTitle.text = "日连续可领取"
    self.mTxtReceived.text = _TT(411) -- 已领取
    -- self.mTxtTitleDown.text = _TT(50069)--shou
end

function updateView(self)
    self.isBuy = recharge.RechargeManager:getIsBuyThirtyGift()
    self.rechargeVo = purchase.DirectBuyManager:getDirectBuyVoById(recharge.rechargeDirectId.thirtyYuanGift)
    if self.rechargeVo == nil then
        return
    end
    if self.isBuy then
        self:close()
        return
    end
    self:closePropsList()
    local propsList = AwardPackManager:getAwardListById(self.rechargeVo.dropId)
    for k, v in pairs(propsList) do
        local vo = props.PropsManager:getTypePropsVoByTid(v.tid)
        local propsGrid = PropsGrid:createByData({
            tid = v.tid,
            num = v.num,
            parent = self.mGroupTrans,
            scale = 0.78,
            showUseInTip = true
        })
        table.insert(self.mPropsItemList, propsGrid)

        propsGrid:setCallBack(self,function ()
            if vo.type == PropsType.HERO then
                self:hideSelf()
            end
            propsGrid:onDefaultClickHandler()
        end)
    end

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    
    self:setBtnLabel(self.mBtnReceive, -1,"¥".. self.rechargeVo.price / 100)
    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)

    self.mBtnReceive:SetActive(self.isBuy == false)
    self.mImgReceived:SetActive(self.isBuy)
end

function hideSelf(self)
    self.UIRootNode.gameObject:SetActive(false)
end

function resetHide(self)
    self.UIRootNode.gameObject:SetActive(true)
end

function updateTime(self)

    local clientTime = GameManager:getClientTime()
    local remainingTime = self.rechargeVo.end_time - clientTime
    local timeTxt = remainingTime <= 0 and "活动已结束" or TimeUtil.getHMSByTime(remainingTime)

    self.mTxtTimer.text = timeTxt

    if remainingTime <= 0 then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
        self:close()
        return
    end

end


function closePropsList(self)
    if #self.mPropsItemList > 0 then
        for _, item in ipairs(self.mPropsItemList) do
            item:poolRecover()
            item = nil
        end
        self.mPropsItemList = {}
    end
    if self.mSn then
        LoopManager:removeFrameByIndex(self.mSn)
        self.mSn = nil
    end
end

function closeDailyList(self)
    if #self.mDailyItemList > 0 then
        for _, item in ipairs(self.mDailyItemList) do
            item:poolRecover()
            item = nil
        end
        self.mDailyItemList = {}
    end
end

function onClickReciveHandler(self)
    recharge.sendRecharge(recharge.RechargeType.GIFT_DIRECT_BUY, nil, recharge.rechargeDirectId.thirtyYuanGift, function()
        self:close()
    end)
end
-- 查看泠详情
function onClickLockHandler(self)
    self:hideSelf()
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, {
        heroTid = 1011
    })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
