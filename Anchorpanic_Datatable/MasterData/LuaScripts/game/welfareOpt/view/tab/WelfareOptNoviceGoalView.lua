--[[ 
-----------------------------------------------------
@filename       : NoviceGoalPanel
@Description    : 新人训练营
@date           : 2022-3-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptNoviceGoalView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptNoviceGoalView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.taskInfo = nil
    self.mDoneAll = true
    self.mPropsGridList = {}
    self.mHasDoneList = {}
    self.stagePropsList = {}
    --滑动框最大高度（取决于全部领取按钮是否显示，显示为最小，反之最大）
    -- self.mScrollHeightMax = 390
    --滑动框最小高度
    -- self.mScrollHeightMin = 311
end

function configUI(self)
    self.mScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScrollerTrans = self:getChildTrans('LyScroller')
    self.mScroller:SetItemRender(welfareOpt.WelfareOptMissionItem)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mBtnRecStage = self:getChildGO("mBtnRecStage")
    self.mGroupContent = self.m_childTrans["mGroupContent"]
    self.mBtnRecAll = self:getChildGO("mBtnRecAll")
    self.mRedPoint1 = self:getChildTrans("mRedPoint1")
    self.mRedPoint2 = self:getChildGO("mRedPoint2")
end

function setData(self, args)
    super.setData(self, args)
end

function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.REQ_TRAINER_PANEL)
    self:updateView()
    GameDispatcher:addEventListener(EventName.UPDATE_TRAINER_PANEL, self.onReflashHandler, self)

    self:setGuideTrans("guide_WelfareOpt_NoviceGoal_ShowAward", self.mBtnRecStage.transform)
end

function deActive(self)
    super.deActive(self)
    self:recoverGrid()
    MoneyManager:setMoneyTidList()
    --RedPointManager:remove(self.mRedPoint2)
    GameDispatcher:removeEventListener(EventName.UPDATE_TRAINER_PANEL, self.onReflashHandler, self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnRecAll, 403, "领取全部")
    -----------------------------------------------------
    self.mTxtTip.text = _TT(48129)--"完成【当前阶段训练】可获得以下奖励"
    self:getChildGO("mTxtTitle_02"):GetComponent(ty.Text).text = _TT(48128)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecAll, self.onReciveAllRewardHandler)
    self:addUIEvent(self.mBtnRecStage, self.onReciveStageRewardHandler)
    self:addUIEvent(self:getChildGO("mImgClickZone"), function()
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, { heroTid = welfareOpt.WelfareOptConst.WELFAREOPT_NOVICE_GOAL_HERO_TID })
    end)
end

function onReflashHandler(self)
    self:updateView()
end

function updateView(self)
    self:recoverGrid()
    self.taskInfo = welfareOpt.WelfareOptManager:getTrainerData()
    self.mBtnRecStage:SetActive(true)
    for i = 1, #self.taskInfo.taskList do
        if self.taskInfo.taskList[i].state ~= 2 then
            self.mBtnRecStage:SetActive(false)
            break
        end
    end

    self.mRedPoint2:SetActive(false)
    if self:isCanRecAll(self.taskInfo.taskList) then
        self.mBtnRecAll:SetActive(true)
        -- gs.TransQuick:SizeDelta02(self.mScrollerTrans, self.mScrollHeightMin)
    else
        self.mBtnRecAll:SetActive(false)
        --gs.TransQuick:SizeDelta02(self.mScrollerTrans, self.mScrollHeightMax)
    end

    if (self.mDoneAll and self.taskInfo.reciveAll == 0) then
        self.mRedPoint2:SetActive(true)
    end
    self.mTxtTitle.text = self.taskInfo.step

    for i = 1, 4 do
        if self.taskInfo.taskList[i] then
            self.taskInfo.taskList[i].tweenId = 6 + i * 2
        end
    end
    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = self.taskInfo.taskList
    else
        self.mScroller:ReplaceAllDataProvider(self.taskInfo.taskList)
    end

    local rewardList = welfareOpt.WelfareOptManager:getNoviceAwardData(self.taskInfo.step).mStepReward

    for i = 1, #rewardList do
        local propsGrid = PropsGrid:createByData({ tid = rewardList[i][1], num = rewardList[i][2], parent = self.mGroupContent, showUseInTip = false })--PropsGrid:create(self.mGroupContent, rewardList[i], 1)
        propsGrid:setCountTextSize(24)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function onReciveAllRewardHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_TRAINER_REWARD, self.mHasDoneList)
    GameDispatcher:dispatchEvent(EventName.REQ_TRAINER_PANEL)
end

function onReciveStageRewardHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_TRAINER_STAGE_REWARD)
    self.isRecStage = true
end

function isCanRecAll(self, list)
    self.mHasDoneList = {}
    self.mDoneAll = true
    for _, v in pairs(list) do
        if (v.state ~= 2) then
            self.mDoneAll = false
            if (v.state == 0) then --已完成未领奖
                table.insert(self.mHasDoneList, v.id)
            end
        end
    end
    return #self.mHasDoneList >= 2 and true or false
end
function recoverGrid(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]