
--[[ SetActive
-----------------------------------------------------
@filename       : CelebrationSuperGiftView
@Description      二周年超级礼物
@Author         : sxt
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('Celebration.CelebrationSuperGiftView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/CelebrationSuperGiftView.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mGiftItemList = {}
    self.mFrameSnList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mPropsContent = self:getChildTrans("mPropsContent")
    self.mGiftItem = self:getChildGO("mGiftItem")
    self.mBtnBuy = self:getChildGO("mBtnBuy"):GetComponent(ty.Button)
    self.mImgBuyed = self:getChildGO("mImgBuyed")
    self.mTxtBuyed = self:getChildGO("mTxtBuyed"):GetComponent(ty.Text)
    self.mImgHeroHar = self:getChildGO("mImgHeroHar"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO,self.showPanel,self)
    self:showPanel(true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItemList()
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO,self.showPanel,self)
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:clearFrameSn()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTips.text = _TT(151017)
    self.mTxtBuyed.text = _TT(136515)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onClickBuy)
end

function onClickBuy(self)
    if self.isBuy then
        gs.Message.Show(_TT(136515))
    else
        recharge.sendRecharge(recharge.RechargeType.GIFT_DIRECT_BUY, nil, recharge.rechargeDirectId.twoAnniversaryGift)
    end
   
    --GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_CELEBRATION_TARGET_TASK_AWARD)
end

function showPanel(self,isInit)

    local isHar = (RefMgr:getSpecialConfig() and sdk.ChannelData:getIsChannelHarmonious())
    self.mImgHeroHar.gameObject:SetActive(isHar)
    
    self:clearItemList()
    self.isBuy = recharge.RechargeManager:getIsBuySuperGift()
    self.rechargeVo = purchase.DirectBuyManager:getDirectBuyVoById(recharge.rechargeDirectId.twoAnniversaryGift)
    if self.rechargeVo == nil then
        self:close()
        return
    end
    local propsList = AwardPackManager:getAwardListById(self.rechargeVo.dropId)
    for i = 1, #propsList, 1 do
        local item = SimpleInsItem:create(self.mGiftItem,self.mPropsContent,"mCelerationGitItem")
        item:getGo():SetActive(false)
      
        if isInit then
            local tween = item:getGo():GetComponent(ty.UIDoTween)
            local frameSn = LoopManager:addFrame(4 + i * 2, 1, self, function()
                item:getGo():SetActive(true)
                tween:BeginTween()
            end)
            table.insert(self.mFrameSnList, frameSn)
        else
            item:getGo():SetActive(true)
        end

        local vo = props.PropsManager:getTypePropsVoByTid(propsList[i].tid)
        local num = propsList[i].num

        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPropsIconUrl(propsList[i].tid),false
        )
       

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = vo.name
        item:getChildGO("mTxtNum"):GetComponent(ty.Text).text = _TT(151018,num)

        item:getChildGO("mIsGeted"):SetActive(self.isBuy)
        table.insert(self.mGiftItemList,item)
    end

    if self.isBuy then
        self:setBtnLabel(self.mBtnBuy, -1,_TT(136515))
    else
        self:setBtnLabel(self.mBtnBuy, -1,"¥".. self.rechargeVo.price / 100)
    end
   
    --self.mBtnBuy.gameObject:SetActive(not self.isBuy)
    self.mImgBuyed:SetActive(false)
    self.mBtnBuy.interactable = not self.isBuy
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
            --self:close()
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
           
            return
        end
    else
        --self:close()
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
       
    end

end

function clearFrameSn(self)
    if self.mFrameSnList then
        for i, v in ipairs(self.mFrameSnList) do
            LoopManager:removeFrameByIndex(v)
        end
    end
    self.mFrameSnList = {}
end

function clearItemList(self)
    for i = 1, #self.mGiftItemList, 1 do
        self.mGiftItemList[i]:poolRecover()
    end
    self.mGiftItemList = {}
end

return _M