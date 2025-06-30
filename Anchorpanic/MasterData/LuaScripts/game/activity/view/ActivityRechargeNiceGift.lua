--[[ SetActive
-----------------------------------------------------
@filename       : ActivityRechargeNiceGift
@Description      关注领取奖励
@date           : 2024-09-03 
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityRechargeNiceGift', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityRechargeNiceGift.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mTime = nil
    self.mAwardList = {}
    self.mNumitemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mContent = self:getChildTrans("mContent")
    self.mNumTrans = self:getChildTrans("mNumTrans")
    self.mBtnRecharge = self:getChildGO("mBtnRecharge")
    self.mMoneyNumItem = self:getChildGO("mMoneyNumItem")
    self.mTxtActivityTime = self:getChildGO("mTxtActivityTime"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_RECHARGENICE_GIFT, self.updateView, self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECHARGENICE_GIFT, self.updateView, self)
    self:clearAllItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecharge,self.onClickHandle)
end

-- 更新 View 界面
function updateView(self)
   self:clearAllItem()
   self:addTime()
   self.mBtnRecharge:SetActive(activity.ActitvityExtraManager:getRechargeNcieGiftState()~=2) 
   self:setBtnLabel(self.mBtnRecharge,(activity.ActitvityExtraManager:getRechargeNcieGiftState()==1 and 412 or 121013),"")
   local num= sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_RECHARGE_NUM)
   for i, v in ipairs(self:getAllNum(num)) do
        local numItem=SimpleInsItem:create(self.mMoneyNumItem, self.mNumTrans, "num"..v)
        numItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("activity/rechargeNum_"..v..".png"),true)
        table.insert(self.mNumitemList, numItem)
   end
   local awardList=AwardPackManager:getAwardListById(sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_RECHARGE_AWARD))
   for i, vo in ipairs(awardList) do
    local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = vo.num, parent = self.mContent, scale = 1.0, showUseInTip = true })
    propsGrid:setHasRec(activity.ActitvityExtraManager:getRechargeNcieGiftState()==2)
    propsGrid:setIsShowCanRec(activity.ActitvityExtraManager:getRechargeNcieGiftState()~=2)
    table.insert(self.mAwardList, propsGrid)
   end
end

function clearAllItem(self)
    if #self.mAwardList>0 then
        for i, item in ipairs(self.mAwardList) do
            item:poolRecover()
        end 
        self.mAwardList={}
    end
    if #self.mNumitemList>0 then
        for i, item in ipairs(self.mNumitemList) do
            item:poolRecover()
        end
        self.mNumitemList={}
    end
    if self.mTime then
        LoopManager:removeTimerByIndex(self.mTime)
        self.mTime=nil
    end
end

function addTime(self)
    self:updateTime()
    self.mTime= LoopManager:addTimer(1,0,self,self.updateTime)
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.RechargeNiceGift) then
        local RemainingTime =activity.ActivityManager:getActivityVoById(activity.ActivityId.RechargeNiceGift):getEndTime() - GameManager:getClientTime()
        self.mTxtActivityTime.text=_TT(94557).. TimeUtil.getFormatTimeBySeconds_9(RemainingTime)
    end
end

function onClickHandle(self)
    if activity.ActitvityExtraManager:getRechargeNcieGiftState()==1 then
        GameDispatcher:dispatchEvent(EventName.REQ_REC_RECHARGENICE_GIFT_AWARD)
    else
        if activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit) and activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit):isOpen() then
            local linkCode=sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_RECHARGE_LINK_ID)
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI,{linkId = linkCode })
        else
            gs.Message.Show(_TT(94503))  
        end

    end
end

function getAllNum(self,curNum)
    local numList={}
    if curNum>=1000 then
        table.insert(numList,((curNum - curNum % 1000) / 1000))
        curNum=curNum-1000
    end
    if curNum>=100 then
        table.insert(numList,((curNum % 1000 - curNum % 100) / 100))
        curNum=curNum-100
    end
    if curNum>=10 then
        table.insert(numList,((curNum % 100 - curNum % 10) / 10))
        curNum=curNum-10
    end
    if curNum>0 then
        table.insert(numList,(curNum % 10))
    end
    return numList
end

return _M