--[[ 
-----------------------------------------------------
@filename       : DailyTaskItem
@Description    : 日常任务项目
@date           : 2020-11-26 19:58:23
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.task.dailyTask.view.item.view.DailyTaskItem", Class.impl("lib.component.BaseItemRender"))

--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)
    self.mNoGet = self:getChildGO("mNoGet")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mContent = self:getChildTrans("mContent")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mReceivedGroup = self:getChildGO("mReceivedGroup")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtGoto = self:getChildGO("mTxtGoto"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)
    self.mGroupGuide = self:getChildGO("mGroupGuide"):GetComponent(ty.CanvasGroup)
    self.mImgTitleState = self:getChildGO("mImgTitleState"):GetComponent(ty.AutoRefImage)
    self.mTxtGet.text = _TT(3) -- 领取
    self.mTxtGoto.text = _TT(4) -- 前往
end

-- override 虚拟列表被激活时自动调用
function active(self)
    super.active(self)
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onOpHandler)
    self:addUIEvent(self.mBtnGoto, self.onOpHandler)
end

function setData(self, param)
    super.setData(self, param)
    self.taskVo = param
    if (self.taskVo.id == 1) then
        self:setGuideTrans("guide_mGuideDaily_1", self.mBtnGet.transform)
    end
    self:updateView()
end

function updateView(self)
    local taskConfigVo = task.DailyTaskManager:getTaskConfigVo(self.taskVo.id)
    local awardList = self.taskVo.propsList
    self.mTxtName.text = _TT(taskConfigVo:getTitle())
    self.mTxtTitle.text = _TT(taskConfigVo:getDescribe())

    self.mImgProBar.fillAmount = self.taskVo.count / taskConfigVo:getTime()
    self.mNoGet:SetActive(false)
    self.mGroupGeted:SetActive(false)
    self.mReceivedGroup:SetActive(false)
    local color = "202226"
    local state = self.taskVo:getState()
    self.mImgTitleState.gameObject:SetActive(state ~= task.AwardRecState.HAS_REC)
    if (state == task.AwardRecState.HAS_REC) then
        -- 已领取
        self.mBtnGet:SetActive(false)
        self.mBtnGoto:SetActive(false)
        self.mGroupGeted:SetActive(true)
        self.mGroupGuide:GetComponent(ty.CanvasGroup).alpha = 1
        self.mReceivedGroup:SetActive(true)
    elseif (state == task.AwardRecState.CAN_REC) then
        -- 可领取
        self.mImgTitleState.color = gs.ColorUtil.GetColor("FCAD48ff")
        self.mBtnGet:SetActive(true)
        self.mBtnGoto:SetActive(false)
        self.mGroupGuide:GetComponent(ty.CanvasGroup).alpha = 1
    elseif (state == task.AwardRecState.UN_REC) then
        self.mImgTitleState.color = gs.ColorUtil.GetColor("202226ff")
        self.mNoGet:SetActive(true)
        local linkId = taskConfigVo:getUiCode()
        self.mGroupGuide:GetComponent(ty.CanvasGroup).alpha = 1
        if linkId == 0 then
            self.mGroupIng:SetActive(true)
            self.mBtnGoto:SetActive(false)
            self.mBtnGet:SetActive(false)
        else
            self.mGroupIng:SetActive(false)
            -- 未领取
            self.mBtnGet:SetActive(false)
            self.mBtnGoto:SetActive(true)
        end
    end
    self.mTxtCurNum.text = _TT(45013, HtmlUtil:colorAndSize(self.taskVo.count, "141c2bff", 40), taskConfigVo:getTime())
    self:recoverAllGrid()
    for i = 1, #awardList do
        local propsGrid = PropsGrid:create(self.mContent, awardList[i])
        propsGrid:setCountTextSize(26)
        table.insert(self.mGridList, propsGrid)
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mContent)
end


function recoverAllGrid(self)
    if self.mGridList then
        for i = 1, #self.mGridList do
            self.mGridList[i]:poolRecover()
        end
    end
    self.mGridList = {}
end

function onOpHandler(self)
    local taskConfigVo = task.DailyTaskManager:getTaskConfigVo(self.taskVo.id)
    local state = self.taskVo:getState()
    if (state == task.AwardRecState.HAS_REC) then
        gs.Message.Show(_TT(7))
    elseif (state == task.AwardRecState.CAN_REC) then
        if (self.taskVo.type == 2) then
            GameDispatcher:dispatchEvent(EventName.REQ_REC_TASK_AWARD, { taskId = self.taskVo.id })
        else
            GameDispatcher:dispatchEvent(EventName.REQ_REC_TASK_AWARD, { taskId = self.taskVo.id })
        end
    elseif (state == task.AwardRecState.UN_REC) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = taskConfigVo:getUiCode() })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]