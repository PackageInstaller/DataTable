
--[[ SetActive
-----------------------------------------------------
@filename       : ActivityPromoView5
@Description      二周年超级礼物 拍脸
@Author         : sxt
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityPromoView5', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPromoView5.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mGiftItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mPropsContent = self:getChildTrans("mPropsContent")
    self.mGiftItem = self:getChildGO("mGiftItem")
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mImgBuyed = self:getChildGO("mImgBuyed")
    self.mTxtBuyed = self:getChildGO("mTxtBuyed"):GetComponent(ty.Text)

    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO,self.showPanel,self)
    self:showPanel()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItemList()
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO,self.showPanel,self)
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    if self.mToggleRemaid.isOn then
        GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, { moduleId = RemindConst.ACTIVITY_PROMO_SHOW })
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTips.text = "购买即可获得"
    self.mTxtBuyed.text = _TT(136515)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnBuy, self.onClickBuy)
end

function onClickBuy(self)
    recharge.sendRecharge(recharge.RechargeType.GIFT_DIRECT_BUY, nil, recharge.rechargeDirectId.twoAnniversaryGift)
    --GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_CELEBRATION_TARGET_TASK_AWARD)
end

function showPanel(self)
    self:clearItemList()
    self.isBuy = recharge.RechargeManager:getIsBuySuperGift()
    self.rechargeVo = purchase.DirectBuyManager:getDirectBuyVoById(recharge.rechargeDirectId.twoAnniversaryGift)
    local propsList = AwardPackManager:getAwardListById(self.rechargeVo.dropId)
    for i = 1, #propsList, 1 do
        local item = SimpleInsItem:create(self.mGiftItem,self.mPropsContent,"mCelerationGitItem")
        local vo = props.PropsManager:getTypePropsVoByTid(propsList[i].tid)
        local num = propsList[i].num

        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPropsIconUrl(propsList[i].tid),false
        )

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = vo.name
        item:getChildGO("mTxtNum"):GetComponent(ty.Text).text = "x".. num

        table.insert(self.mGiftItemList,item)
    end

    self:setBtnLabel(self.mBtnBuy, -1,"¥".. self.rechargeVo.price / 100)
    self.mBtnBuy:SetActive(not self.isBuy)
    self.mImgBuyed:SetActive(self.isBuy)

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function updateTime(self)

    if activity.ActivityManager:getActivityVoById(activity.ActivityId.TwoAnniversary) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.TwoAnniversary)
            :getEndTime() - clientTime
        local timeTxt = RemainingTime <= 0 and "活动已结束" or _TT(3530) ..TimeUtil.getFormatTimeBySeconds_9(RemainingTime)
        self.mTxtTimer.text = timeTxt
        if RemainingTime <= 0 then
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
            self:close()
            return
        end
    else
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
        self:close()
    end

end

function clearItemList(self)
    for i = 1, #self.mGiftItemList, 1 do
        self.mGiftItemList[i]:poolRecover()
    end
    self.mGiftItemList = {}
end

return _M