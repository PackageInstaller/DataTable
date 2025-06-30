--[[ SetActive
-----------------------------------------------------
@filename       : ActivitySubscribeGift
@Description      关注领取奖励
@date           : 2023-06-23 
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('Celebration.CelebrationAccRechargeView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/CelebrationAccRechargeView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.mDayItemList = {}
    self.mAwardItemList = {}
end
--析构  
function dtor(self)
end

function initData(self)
    self.mTargetAwardItem=nil
    self.mTimeSn=nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnGotoRecharge = self:getChildGO("mBtnGotoRecharge")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mTxtRechargeDes = self:getChildGO("mTxtRechargeDes"):GetComponent(ty.Text)
    self.mLyScroller:SetItemRender(Celebration.CelebrationAccRechargeItem)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_CELEBRATION_ACC_RECHARGE_LIST,self.updateList,self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CELEBRATION_ACC_RECHARGE_LIST,self.updateList,self)
    self:clearScrollerItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtRechargeDes.text = _TT(121014,Celebration.CelebrationManager:getRechargeNum())
    self:setBtnLabel(self.mBtnGotoRecharge, 121013, "前往充值")
end


function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGotoRecharge,self.onClickGotoRechargeHandler)
end

function onClickGotoRechargeHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
end

-- 更新 View 界面
function updateView(self)
    self:updateList(true)
    --self.mTimeSn = self:addTimer(1,0,self.updateTime)
    local curActivityOverTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.CelebrationTotalTopUp):getOverTime()
    local md, hm = TimeUtil.getMDHByTime2(curActivityOverTime)
    self.mTxtTime.text = _TT(121009,md .. " " .. hm) 

end

function updateList(self,isInit)
    self:clearScrollerItem()
    self.mBtnGotoRecharge:SetActive(true)
    local list = Celebration.CelebrationManager:getRechargeList()
    table.sort(list,function (vo1,vo2)
        if vo1:getState()==vo2:getState() then
            return vo1.index<vo2.index
        else
            return vo1:getState()<vo2:getState()
        end
    end)
    for i = 1, 4 do
        list[i].tweenId =i
    end
    if isInit then
        self:setTimeout(3 * 0.02, function() self.mLyScroller.DataProvider = list end)
    else
        if (self.mLyScroller.Count <= 0) then
            self.mLyScroller.DataProvider = list
        else
            self.mLyScroller:ReplaceAllDataProvider(list)
        end
    end
end

function clearScrollerItem(self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function clearDayItem(self)
    if #self.mDayItemList>0 then
        for _, dayItem in ipairs(self.mDayItemList) do
            dayItem:poolRecover()
            dayItem=nil
        end
        self.mDayItemList={}
    end
end

return _M