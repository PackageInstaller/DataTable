--[[ 
-----------------------------------------------------
@filename       : NovicePromotionPlanView
@Description    : 新手活动-升格计划
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NovicePromotionPlanView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("noviceActivity/NovicePromotionPlanView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(noviceActivity.NovicePermotionPlanItem)
    self.mTxtStartTime = self:getChildGO("mTxtStartTime"):GetComponent(ty.Text)
    self.mTxtEndTime = self:getChildGO("mTxtEndTime"):GetComponent(ty.Text)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_UPGRADE_PLAN_VIEW, self.updateInfo, self)
    self:addTimer()
    self:updateInfo()
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_UPGRADE_PLAN_VIEW, self.updateInfo, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    self:removeTimer()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function addTimer(self)
    self:removeTimer()
    self:updateRemainingTimer()
    self.mRemainingSn = LoopManager:addTimer(1, 0, self, self.updateRemainingTimer)
end

function removeTimer(self)
    if self.mRemainingSn then
        LoopManager:removeTimerByIndex(self.mRemainingSn)
        self.mRemainingSn = nil
    end
end

function updateRemainingTimer(self)
    local time = activity.ActivityManager:getNoviceActivityEndTime() - GameManager:getClientTime()
    self.mTxtEndTime.text = _TT(3530) .. TimeUtil.getNewRoleShowTime(time, true)
end

function updateInfo(self)
    local list = noviceActivity.NoviceActivityManager:getUpgradePlanList()
    if list and next(list) then
        if list.tweenId == nil then
            for i = 1, #list do
                list[i].tweenId = i * 3.5
            end
        end
    end
    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]