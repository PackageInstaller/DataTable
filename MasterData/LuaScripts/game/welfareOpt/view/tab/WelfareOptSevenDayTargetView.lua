--[[ 
-----------------------------------------------------
@filename       : SevenDayTarget
@Description    : 新手目标面板
@date           : 2022-3-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptSevenDayTargetView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptSevenDayTargetView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.openDay = activityTarget.ActivityTargetManager:getActivityTargetDay()
    self.selectDay = self.openDay
    self.taskInfo = nil
    self.mIsUnfinished = true
    self.mHasDoneList = {}
    self.mItemList = {}
    self.mSnLists = {}
end

function configUI(self)
    self.mBtnRecAll = self:getChildGO("mBtnRecAll")
    self.mScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(welfareOpt.WelfareOptSevenDayItem)

end

function setData(self, args)
    super.setData(self, args)
end

function active(self)
    super.active(self)
    self.mIsFrist = true
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.SET_WELFAREOPT_PAGE, 6)
    self:defaultData()
    self:randerHeadTitle()
    self:updateView()
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_TARGET_PANEL, self.onReflashHandler, self)
end

function deActive(self)
    super.deActive(self)
    self:recoverGrid()
    self:recoverSn()
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_TARGET_PANEL, self.onReflashHandler, self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end

end

function initViewText(self)
    self:setBtnLabel(self.mBtnRecAll, 403, "领取全部")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecAll, self.onReciveAllRewardHandler)
    self:addUIEvent(self:getChildGO("mImgClickZone"), function()
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, { heroTid = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET_HERO_TID })
    end)
end

function defaultData(self)
    self.taskInfo = activityTarget.ActivityTargetManager:getActivityTargetData(self.selectDay)
    while (self.mIsUnfinished) do
        self:isUnfinished(self.taskInfo)
        if not self.mIsUnfinished then
            return
        end
        self.selectDay = self.selectDay - 1
        if (self.selectDay == 0) then
            self.selectDay = self.mIsUnfinished == true and self.openDay or 1
            self.mIsUnfinished = false
        end
        self.taskInfo = activityTarget.ActivityTargetManager:getActivityTargetData(self.selectDay)
    end
end

function randerHeadTitle(self)
    if next(self.mItemList) == nil then
        self:recoverGrid()
        self:recoverSn()
        -- 列表表头
        for i = 1, 7 do
            local item = SimpleInsItem:create(self:getChildGO("mItemDay"), self:getChildTrans("mGuideGroup"), "SevenDayTargetItemDay")
            item:getGo():SetActive(false)
            self:setGuideTrans("guide_WelfareOpt_SevenDayTarget" .. i, item:getTrans())
            self.mItemList[i] = item
            item:addUIEvent(nil, function() self:onDayClickHandler(i) end)
            local itemTxt = item:getChildGO("mTxtDay"):GetComponent(ty.Text)
            local mTxtTips = item:getChildGO("mTxtTips"):GetComponent(ty.Text)
            itemTxt.text = i
            mTxtTips.text = _TT(44501)
            item:getChildGO("mImgBg"):SetActive(i == self.selectDay)
            local performAni = function()
                if (not gs.GoUtil.IsCompNull(item:getGo():GetComponent(ty.Animator))) then
                    item:getGo():SetActive(true)
                    item:getGo():GetComponent(ty.Animator):SetTrigger("show")
                end
            end
            table.insert(self.mSnLists, LoopManager:addFrame(7 + i * 2, 1, self, performAni))
        end
    end

    for i = 1, 7 do
        local item = self.mItemList[i]
        item:getChildGO("mImgComplete"):SetActive(activityTarget.ActivityTargetManager:getActivityTargetIsAllOver(i))
        item:getChildGO("mImgLock"):SetActive(i > self.openDay)
        local isRed = false
        if (i <= self.openDay) then
            local taskInfo = activityTarget.ActivityTargetManager:getActivityTargetData(i)
            for i = 1, #taskInfo do
                if taskInfo[i].serverData.state == 0 then
                    isRed = true
                    break
                end
            end
        end

        if (isRed) then
            RedPointManager:add(self.mItemList[i]:getChildTrans("root"), nil, 44, 10)
        else
            RedPointManager:remove(self.mItemList[i]:getChildTrans("root"))
        end
    end

end

function onReflashHandler(self)
    self.taskInfo = activityTarget.ActivityTargetManager:getActivityTargetData(self.selectDay)
    self.openDay = activityTarget.ActivityTargetManager:getActivityTargetDay()
    self:randerHeadTitle()
    self:updateView()
end

function updateView(self)
    local canRecAll = true
    canRecAll = self:isCanRecAll(self.taskInfo)
    if canRecAll then
        self.mBtnRecAll:SetActive(true)
    else
        self.mBtnRecAll:SetActive(false)
    end
    if self.mIsFrist then
        for i = 1, 3 do
            self.taskInfo[i].tweenId = i
        end
        self.mIsFrist = false
        self:setTimeout(3 * 0.02, function() self.mScroller.DataProvider = self.taskInfo end)

    else
        for i = 1, 3 do
            self.taskInfo[i].tweenId = nil
        end

        self.mScroller:ReplaceAllDataProvider(self.taskInfo)
    end
    --任务列表

end

function onDayClickHandler(self, index)
    if (index > self.openDay) then
        gs.Message.Show(_TT(44659, index))
    elseif (index ~= self.selectDay) then
        self.mScroller:StopTweenMove()
        self.mItemList[self.selectDay]:getChildGO("mImgBg"):SetActive(false)
        self.mItemList[index]:getChildGO("mImgBg"):SetActive(true)
        self.selectDay = index
        self:onReflashHandler()
        self.mScroller:JumpToTop()
    end
end

function onReciveAllRewardHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_TARGET_GAIN_AWARD, self.mHasDoneList)
end

function isCanRecAll(self, list)
    self.mHasDoneList = {}
    self.mDoneAll = true
    for _, v in pairs(list) do
        if (v.serverData.state == 0) then --已完成未领奖
            self.mDoneAll = false
            table.insert(self.mHasDoneList, v.serverData.id)
        end
    end
    return #self.mHasDoneList >= 1 and true or false
end
--有无未完成
function isUnfinished(self, list)
    self.mIsUnfinished = true
    for _, v in pairs(list) do
        if (v.serverData and v.serverData.state == 0) then --已完成未领奖
            self.mIsUnfinished = false
            break
        end
    end
    return self.mIsUnfinished
end

function recoverGrid(self)
    for i = 1, #self.mItemList do
        RedPointManager:remove(self.mItemList[i]:getChildTrans("root"))
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

function recoverSn(self)
    if next(self.mSnLists) then
        for _, sn in pairs(self.mSnLists) do
            LoopManager:removeFrameByIndex(sn)
        end
        self.mSnLists = {}
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]