

module("seabed.SeabedTaskItem", Class.impl("lib.component.BaseItemRender"))

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
    self.msgVo = self.taskVo.msgVo
    self:updateView()
end

function updateView(self)
    --local taskConfigVo = task.DailyTaskManager:getTaskConfigVo(self.taskVo.id)
    local awardList = self.taskVo.rewards
    self.mTxtName.text = _TT(111170)
    self.mTxtTitle.text = _TT(self.taskVo.des)

    self.mImgProBar.fillAmount = self.msgVo.count/self.taskVo.times 
    self.mNoGet:SetActive(false)
    self.mGroupGeted:SetActive(false)
    self.mReceivedGroup:SetActive(false)
    local color = "202226"
    local state = self.msgVo.state +1
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
        local linkId = self.taskVo:getUiCode()
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
    self.mTxtCurNum.text = _TT(45013, HtmlUtil:colorAndSize(self.msgVo.count, "141c2bff", 40),self.taskVo.times)
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
    local state = self.msgVo.state +1
    if (state == task.AwardRecState.HAS_REC) then
        gs.Message.Show(_TT(7))
    elseif (state == task.AwardRecState.CAN_REC) then

        local list = {}
        table.insert(list, self.taskVo.id)
        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_TASK_REWARD, list)
    elseif (state == task.AwardRecState.UN_REC) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = taskConfigVo:getUiCode() })
    end
end

return _M