--[[ 
-----------------------------------------------------
@filename       : ActivityTargetView
@Description    : 新手目标页面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.activityTarget.view.ActivityTargetView", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activityTarget/ActivityTargetView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)
    self.mDayItems = {}
    self.mScoreItems = {}
    self.mTaskItems = {}
    self.mAwardItems = {}
end






-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTimeTxt = self:getChildGO("TimeTxt"):GetComponent(ty.Text)
    self.mCurrentScoreTxt = self:getChildGO("CurrentScoreTxt"):GetComponent(ty.Text)
    self.mMaxScoreTxt = self:getChildGO("MaxScoreTxt"):GetComponent(ty.Text)

    self.mAllScoreBg = self:getChildGO("AllScoreBg"):GetComponent(ty.RectTransform)
    self.mAllScoreImg = self:getChildGO("AllScoreImg"):GetComponent(ty.RectTransform)

    self.mScoreRectTransform = self:getChildGO("AllScoreContent"):GetComponent(ty.RectTransform)
    --self.mDayScroll = self:getChildGO("DayScrollView"):GetComponent(ty.ScrollRect)
    self.mDayContent = self:getChildTrans("DayContent")

    self.mTaskScroll = self:getChildGO("TaskScrollView"):GetComponent(ty.LyScroller)
    self.mTaskScroll:SetItemRender(activityTarget.TaskItem)
    self.mScoreItem = self:getChildGO("ScoreItem")
    self.mDayItem = self:getChildGO("DayItem")
    self.mCloseBtn = self:getChildGO("CloseBtn")
    self.mScoreTitle = self:getChildGO("ScoreTitle"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mScoreTitle.text = _TT(44657) --"EMAIL LIST"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mCloseBtn, self.onClickClose)
end
--激活
function active(self)
    super.active(self)
    self.UIObject:SetActive(true)
    --MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.HIDE_ACTIVITY_PANEL, self.__onHideHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_TARGET_PANEL, self.__onUpdateActivityTargetHandler, self)

    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_TARGET_SCORE, self.__onUpdateActivityScoreHandler, self)

    self.cusDay = 1
    self:showPanel(true)

    if(self.day > 7) then
        self.day = 7
    end
    self:__onDayChilck(self.day)
end


function deActive(self)
    --MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})

    GameDispatcher:removeEventListener(EventName.HIDE_ACTIVITY_PANEL, self.__onHideHandler, self)
    super.deActive(self)
   
    LoopManager:removeTimer(self, self.__updateTime)

    GameDispatcher:removeEventListener(
        EventName.UPDATE_ACTIVITY_TARGET_PANEL,
        self.__onUpdateActivityTargetHandler,
        self
    )

    GameDispatcher:removeEventListener(
        EventName.UPDATE_ACTIVITY_TARGET_SCORE,
        self.__onUpdateActivityScoreHandler,
        self
    )

    self:__clearDayItems()
    self:__clearScoreItems()
end

function __onHideHandler(self, args)
    self:onClickClose()
    if args == nil then
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, args)
    end
end

function __onUpdateActivityScoreHandler(self)
    self:__updateScore()
end

function showPanel(self, init)
    self:__updateDayItem()
    self:__updateScore()
    self:__updateTask(init)

    LoopManager:removeTimer(self, self.__updateTime)
    self.mEndTime = activityTarget.ActivityTargetManager:getEndTime()
    if self.mEndTime > 0 then
        LoopManager:addTimer(0, 0, self, self.__updateTime)
    else
        self.mTimeTxt.text = _TT(44502) --"无期限"
    end
end

function __updateDayItem(self)
    self:__clearDayItems()
    self.day = activityTarget.ActivityTargetManager:getActivityTargetDay()
    self.taskList = activityTarget.ActivityTargetManager:getActivityTargetData(self.cusDay)
    for i = 1, 7 do
        local go = gs.GameObject.Instantiate(self.mDayItem, self.mDayContent, false)

        local text = go.transform:Find("Group/DayTxt"):GetComponent(ty.Text)

        text.text = _TT(44658, i)

        local group = go.transform:Find("Group"):GetComponent(ty.RectTransform)

        gs.TransQuick:UIPosX(group, i * -10)
        local normal = go.transform:Find("Group/Normal").gameObject
        local lock = go.transform:Find("Group/Lock").gameObject
        local select = go.transform:Find("Group/Select").gameObject
        text.color = gs.ColorUtil.GetColor("747474ff")

        if i > self.day then
            lock:SetActive(true)

            select:SetActive(false)
        elseif i == self.cusDay then
            --text.fontSize = 50
            text.color = gs.COlOR_BLACK
            select:SetActive(true)
        else
            --local red = activityTarget.ActivityTargetManager:getActivityTargetRed(i)
            --go.transform:Find("RedPoint").gameObject:SetActive(red)
            lock:SetActive(false)

            --text.fontSize = 30
            select:SetActive(false)
        end
        local red = activityTarget.ActivityTargetManager:getActivityTargetRed(i)

        if red then
            RedPointManager:add(go.transform:Find("Group/RedPoint").transform)
        else
            RedPointManager:remove(go.transform:Find("Group/RedPoint").transform)
        end
        --go.transform:Find("Group/RedPoint").gameObject:SetActive(red)

        self:addUIEvent(go, self.__onDayChilck, nil, i)

        table.insert(self.mDayItems, go)
    end
end

function __updateTask(self, init)
    self.taskList = self:sortTaskList(self.taskList)
    if init == true then
        self.mTaskScroll.DataProvider = self.taskList
    else
        self.mTaskScroll:ReplaceAllDataProvider(self.taskList)
    end
end

function __updateScore(self)
    self:__clearScoreItems()

    self.score = activityTarget.ActivityTargetManager:getActivityTargetScore()
    self.maxScore = activityTarget.ActivityTargetManager:getActivityTargetMaxScore()
    self.score = gs.Mathf.Clamp(self.score, 0, self.maxScore)

    self.mCurrentScoreTxt.text = self.score
    self.mMaxScoreTxt.text = "/" .. self.maxScore
    gs.TransQuick:SizeDelta01(self.mAllScoreImg, (self.score / self.maxScore) * self.mAllScoreBg.sizeDelta.x)

    self.scoreList = activityTarget.ActivityTargetManager:getScoreAwardList()

    for i = 1, #self.scoreList do
        local go = gs.GameObject.Instantiate(self.mScoreItem, self.mScoreRectTransform.transform, false)
        local rt = go:GetComponent(ty.RectTransform)

        local min = go.transform:Find("Min").gameObject
        local max = go.transform:Find("Max").gameObject

        local scoreTxt = go.transform:Find("Bottom/ScoreTxt"):GetComponent(ty.Text)
        scoreTxt.color = gs.ColorUtil.GetColor("000000ff")
        min:SetActive(true)
        max:SetActive(false)
        scoreTxt.text = self.scoreList[i].score

        ------------min
        local minGeted = min.transform:Find("Geted").gameObject
        local minSelect = min.transform:Find("Select").gameObject
        -- 任务状态，1:未完成，0:已完成未领奖，2:已领取奖励
        if self.scoreList[i].m_state == 0 then
            minGeted:SetActive(false)
            minSelect:SetActive(true)
        elseif self.scoreList[i].m_state == 1 then
            minGeted:SetActive(false)
            minSelect:SetActive(false)
        elseif self.scoreList[i].m_state == 2 then
            minGeted:SetActive(true)
            minSelect:SetActive(false)
        end

        local maxGeted = max.transform:Find("Geted").gameObject
        local maxSelect = max.transform:Find("Select").gameObject
        --针对最后一个的特殊处理 max
        if i == #self.scoreList then
            min:SetActive(false)
            max:SetActive(true)
            if self.scoreList[i].m_state == 0 then
                maxGeted:SetActive(false)
                maxSelect:SetActive(true)
            elseif self.scoreList[i].m_state == 1 then
                maxGeted:SetActive(false)
                maxSelect:SetActive(false)
            elseif self.scoreList[i].m_state == 2 then
                maxGeted:SetActive(true)
                maxSelect:SetActive(false)
            end
        end

        gs.TransQuick:LPosZero(rt)
        gs.TransQuick:LPosXY(rt, self.scoreList[i].score / self.maxScore * self.mAllScoreBg.sizeDelta.x, 3.4)

        self:addUIEvent(go.transform:Find("Btn").gameObject, self.__onScoreTxtClick, nil, {id = i, data = self.scoreList[i]})
        table.insert(self.mScoreItems, go)
    end
end

function __updateTime(self)
    local currentTime = GameManager:getClientTime()
    local reamainTime = self.mEndTime - currentTime
    if (reamainTime <= 0) then
        self:onClickClose()
        return
    end

    self.mTimeTxt.text = _TT(44505, TimeUtil.getFormatTimeBySeconds_1(reamainTime))
end

function sortTaskList(self, list)
    local okNotGetList = {}
    local notOkList = {}
    local getedList = {}

    for i = 1, #list do
        local vo = activityTarget.ActivityTargetManager:getTaskVo(list[i].id)
        if vo.m_state == 0 then
            table.insert(okNotGetList, list[i])
        elseif vo.m_state == 1 then
            table.insert(notOkList, list[i])
        elseif vo.m_state == 2 then
            table.insert(getedList, list[i])
        end
    end

    for i = 1, #notOkList do
        table.insert(okNotGetList, notOkList[i])
    end

    for i = 1, #getedList do
        table.insert(okNotGetList, getedList[i])
    end

    return okNotGetList
end

function __onDayChilck(self, id)
    if id > self.day then
        gs.Message.Show(_TT(44659,id))
    else
        self.cusDay = id
        self:showPanel(false)
    end
end

function __onScoreTxtClick(self, args)
    local id = args.id
    local data = args.data

    if data.m_state == 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_TARGET_GAIN_SCORE_AWARD, {id = id})
    elseif data.m_state == 1 then
        local vo = activityTarget.ActivityTargetManager:getActivityTargetScoreAwardDataByScore(id)
        GameDispatcher:dispatchEvent(
            EventName.OPEN_DAILY_TASK_AWARD_PANEL,
            {tip = _TT(44506, vo.targetScore), propsList = vo.scoreData}
        )
    elseif data.m_state == 2 then
        gs.Message.Show(_TT(411))
    end
end

function __onUpdateActivityTargetHandler(self)
    self:__updateDayItem()
    self:__updateTask(false)
    self:__updateScore()
end

function __clearDayItems(self)
    for i = 1, #self.mDayItems do
        gs.GameObject.Destroy(self.mDayItems[i])
    end
    self.mDayItems = {}
end

function __clearScoreItems(self)
    for i = 1, #self.mScoreItems do
        gs.GameObject.Destroy(self.mScoreItems[i])
    end
    self.mScoreItems = {}
end

function __clearPropGridItems(self)
    for i = 1, #self.mAwardItems do
        self.mAwardItems[i]:poolRecover()
    end
    self.mAwardItems = {}
end

function __clearTaskItems(self)
    -- for i = 1, #self.mTaskItems do
    --     gs.GameObject.Destroy(self.mTaskItems[i])
    -- end
    -- self.mTaskItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
