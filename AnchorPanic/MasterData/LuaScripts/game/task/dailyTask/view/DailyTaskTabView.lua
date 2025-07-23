--[[ 
-----------------------------------------------------
@filename       : DailyTaskTabView
@Description    : 日常任务2.0
@date           : 2020-11-26 14:14:40
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.task.dailyTask.view.DailyTaskTabView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("taskHall/dailyTask/DailyTaskTabView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mType = task.TYPE_DAILY_TASK
    self.mBoxItemList = {}
    self.mPropsList = {}
    self.mScrollerHeight = 0
    self.mCurIndex = 0
end

-- 初始化
function configUI(self)
    self.mAllBtn = self:getChildGO("mBtnAll")
    self.mBtnHidden = self:getChildGO("mBtnHidden")
    self.mGroupBox = self:getChildTrans("mGroupBox")
    self.mGuideGroup = self:getChildGO("mGuideGroup")
    self.mAwardGroup = self:getChildGO("mAwardGroup")
    self.mAutoReceive = self:getChildGO("mAutoReceive")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mBar = self:getChildGO("mBar"):GetComponent(ty.Image)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtScoreCur = self:getChildGO("mTxtScoreCur"):GetComponent(ty.Text)
    self.mTxtScoreSum = self:getChildGO("mTxtScoreSum"):GetComponent(ty.Text)
    self.mTxtAwardTips = self:getChildGO("mTxtAwardTips"):GetComponent(ty.Text)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    self.mAwardGroupAni = self:getChildGO("mAwardGroup"):GetComponent(ty.Animator)
    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mScrollerRect = self:getChildGO("LyScroller"):GetComponent(ty.RectTransform)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(task.DailyTaskItem)
    self:setGuideTrans("funcTips_dailyTask_1", self:getChildTrans("mDailyTask1"))
    self:setGuideTrans("funcTips_dailyTask_2", self:getChildTrans("mDailyTask2"))
end

--激活
function active(self)
    super.active(self)
    self.mAwardGroup:SetActive(false)
    self.mBtnHidden:SetActive(false)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_SHOWTIPS, self.updateAwardShow, self)
    GameDispatcher:addEventListener(EventName.HIDDEN_TASK_SHOWTIPS, self.hiddenAwardShow, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_AWARD, self.__onGetAwardHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_DATA, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_LIST, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ALL_TASK_AWARD, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_SCORE_AWARD, self.__onUpdateBoxItemList, self)
    GameDispatcher:addEventListener(EventName.UPDATE_DAILY_TASK_SCORE, self.__onUpdateBoxItemList, self)
    --MoneyManager:setMoneyTidList()
    self:updateView()
    self:updateTaskList(true)
    self.mFrameSn1 = LoopManager:addFrame(1, 1, self, self.updateBoxItemList)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_SHOWTIPS, self.updateAwardShow, self)
    GameDispatcher:removeEventListener(EventName.HIDDEN_TASK_SHOWTIPS, self.hiddenAwardShow, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_AWARD, self.__onGetAwardHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_DATA, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_LIST, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ALL_TASK_AWARD, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_SCORE_AWARD, self.__onUpdateBoxItemList, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DAILY_TASK_SCORE, self.__onUpdateBoxItemList, self)
    --MoneyManager:setMoneyTidList()
    LoopManager:removeFrameByIndex(self.frameId)
    LoopManager:removeFrameByIndex(self.frameId2)
    local height = self.mAutoReceive.activeSelf == true and (self.mScrollerHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height) or self.mScrollerHeight
    gs.TransQuick:SizeDelta02(self.mScrollerRect.gameObject.transform, height)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
    if self.mFrameSn1 then
        LoopManager:removeFrameByIndex(self.mFrameSn1)
        self.mFrameSn1 = nil
    end
    gs.TransQuick:LPosX(self.mAwardGroup.transform, 0)
    self:recoverPropsList()
    self.mAwardGroup:SetActive(false)
    self.mBtnHidden:SetActive(false)
    self.mCurIndex = 0
    self:recoverBoxItemList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    --string.sub 截取字符串汉字占用3个字符 数字、英文及符号占用1个字符
    self.mTxtTips.text = _TT(265)  --"每日05:00重置"
    self.mTxtAwardTips.text = _TT(165) .. ":"--"查看奖励"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHidden, self.hiddenAwardShow)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
    self:addUIEvent(self.mAllBtn, self.onClickAll)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.TaskDaily })
end

function onClickAll(self)
    GameDispatcher:dispatchEvent(EventName.REQ_REC_ALL_TASK_AWARD, { type = task.TYPE_DAILY_TASK })
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.Task })
end

function __onUpdateViewHandler(self, args)
    if (not args or self.mType == args.type) then
        self:updateView()
        self:updateTaskList()
        self:updateBoxItemList()
    end
end

function __onUpdateBoxItemList(self, args)
    if (self.mType == args.type) then
        self:updateView()
        self:updateBoxItemList()
    end
end

function __onGetAwardHandler(self, args)
    if (self.mType == args.type) then
        self:updateTaskList()
        self:updateBoxItemList()
    end
end

function updateView(self)
    if self.mScrollerHeight == 0 then
        self.mScrollerHeight = self.mScrollerRect.sizeDelta.y
    end
    local curNum = 0
    if task.DailyTaskManager.dailyTaskScore > task.DailyTaskManager.maxDailyTaskScore then
        curNum = task.DailyTaskManager.maxDailyTaskScore
        self.mTxtScoreCur.text = task.DailyTaskManager.maxDailyTaskScore
    else
        self.mTxtScoreCur.text = task.DailyTaskManager.dailyTaskScore
        curNum = task.DailyTaskManager.dailyTaskScore
    end
    self.mTxtScoreSum.text = " " .. task.DailyTaskManager.maxDailyTaskScore
    self.mBar.fillAmount = curNum / task.DailyTaskManager.maxDailyTaskScore
end

function updateTaskList(self, isInit)
    --将对虚拟列表拉伸操作放于虚拟列表之前 避免虚拟列表计算时重新计算内容填充内容
    local list = task.DailyTaskManager:getTaskList(self.mType)
    self.mAutoReceive:SetActive((task.DailyTaskManager:getTaskCanRecList(self.mType) >= 1))
    local height = self.mAutoReceive.activeSelf == true and (self.mScrollerHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height) or self.mScrollerHeight
    gs.TransQuick:SizeDelta02(self.mScrollerRect.gameObject.transform, height)
    self.mTxtAutoReceive.text = _TT(962, task.DailyTaskManager:getTaskCanRecList(self.mType))
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
    self.mFrameSn = LoopManager:addFrame(3, 1, self, function()
        for i = 1, #list do
            list[i].tweenId = 2 + (i - 1) * 4
        end
        if isInit or self.mScroller.Count <= 0 then
            self.mScroller.DataProvider = list
        else
            self.mScroller:ReplaceAllDataProvider(list)
        end
    end)
end
--阶段奖励预览弹窗
function updateAwardShow(self, data)
    self.mAwardGroup:SetActive(true)
    if (self.mAwardGroup.activeSelf == true) and (self.mCurIndex ~= data.index) then
        self:recoverPropsList()
        self.mCurIndex = data.index
        self.mAwardGroup.transform:SetParent(data.trans, false)
        local pos = math.abs(self.mGuideGroup.transform.rect.width) - (data.trans.anchoredPosition.x + math.abs(self.mAwardGroup.transform.rect.width / 2)) + self.mGroupBox.sizeDelta.x
        if (pos < 0) then
            gs.TransQuick:LPosX(self.mAwardGroup.transform, pos)
        else
            gs.TransQuick:LPosX(self.mAwardGroup.transform, 0)
        end
        local pos = self.mAwardGroup.transform.rect
        self.mBtnHidden:SetActive(true)
        for _, propVo in ipairs(data.propsList) do
            local propItem = PropsGrid:createByData({ tid = propVo.tid, num = propVo.count, parent = self.mAwardContent, scale = 1, showUseInTip = true })
            table.insert(self.mPropsList, propItem)
        end
        self.mTxtCondition.text = data.tip
        self.mAwardGroupAni:SetTrigger("enter")
    end
end

-- 更新评分奖励
function updateBoxItemList(self)
    self:recoverBoxItemList()
    local scoreAwardList = task.DailyTaskManager:getTaskScoreAwardList()
    table.sort(scoreAwardList, function(vo1, vo2)
        return vo1.score < vo2.score
    end)
    local groupwidth = self:getChildTrans("mProgressBar").rect.width

    for i = 1, #scoreAwardList do
        local curPosX = (groupwidth / #scoreAwardList) * i
        local scoreAwardVo = scoreAwardList[i]
        local item = task.DailyTaskBoxItem:poolGet()
        item:setData(scoreAwardList[i], self.mGroupBox)
        item:setPosition(curPosX, 22, 0)
        table.insert(self.mBoxItemList, item)
    end
end

function hiddenAwardShow(self)
    if self.mAwardGroup.activeSelf == true then
        local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAwardGroupAni, "AwardGroup_Enter")
        self.mAwardGroupAni:SetTrigger("exit")
        self:addTimer(aniTime, aniTime, function()
            gs.TransQuick:LPosX(self.mAwardGroup.transform, 0)
            self:recoverPropsList()
            self.mAwardGroup:SetActive(false)
            self.mBtnHidden:SetActive(false)
            self.mCurIndex = 0
        end)
    end
end

function recoverBoxItemList(self)
    for i = 1, #self.mBoxItemList do
        self.mBoxItemList[i]:poolRecover()
    end
    self.mBoxItemList = {}
end

function recoverPropsList(self)
    if #self.mPropsList > 0 then
        for i = 1, #self.mPropsList do
            self.mPropsList[i]:poolRecover()
        end
        self.mPropsList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]