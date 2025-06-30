--[[ 
-----------------------------------------------------
@filename       : EliminateTaskItem
@Description    : 消消乐章节区域item
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateTaskItem", Class.impl("lib.component.BaseItemRender"))

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onClickHandler)
end

function onInit(self, go)
    super.onInit(self, go)

    self.mAwardItemList = {}
    
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mRectScroll = self:getChildGO("Scroll View"):GetComponent(ty.RectTransform)
    self.mAwardContent = self:getChildTrans("Content")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mImgPass = self:getChildGO("mImgPass")

    self:setBtnLabel(self.mBtnGet, 3, "领取")
end

function active(self)
    super.active(self)
end

function setData(self, param)
    super.setData(self, param)
    local taskConfigVo = self.data
    if (taskConfigVo) then
        self.mTxtDes.text = _TT(taskConfigVo.taskDes)

        self:removeAwardItemList()
        local awardList = taskConfigVo.awardList
        for i = 1, #awardList do
            local tid = awardList[i][1]
            local num = awardList[i][2]
            local propsGrid = PropsGrid:create(self.mAwardContent, {tid, num}, 0.65, false)
            table.insert(self.mAwardItemList, propsGrid)
        end
        gs.TransQuick:UIPosX(self.mAwardContent, 0)
        gs.TransQuick:SizeDelta01(self.mRectScroll, math.min(380, #awardList * (128 * 0.65) + (#awardList - 1) * 18))

        local taskVo = eliminate.EliminateManager:getTaskVoById(taskConfigVo.taskId)
        if(taskVo)then
            self.mBtnGet:SetActive(taskVo:getState() == task.AwardRecState.CAN_REC)
            self.mImgPass:SetActive(taskVo:getState() == task.AwardRecState.HAS_REC)
            self.mTxtProgress.gameObject:SetActive(taskVo:getState() == task.AwardRecState.UN_REC)
            self.mTxtProgress.text = string.format("%s<size=22>/%s</size>", taskVo.count, taskConfigVo.maxCount)
        else
            self.mBtnGet:SetActive(false)
            self.mImgPass:SetActive(false)
            self.mTxtProgress.gameObject:SetActive(true)
            self.mTxtProgress.text = string.format("%s<size=22>/%s</size>", 0, taskConfigVo.maxCount)
        end
    else
        self:deActive()
    end
end

function onClickHandler(self)
    local taskConfigVo = self.data
    local taskVo = eliminate.EliminateManager:getTaskVoById(taskConfigVo.taskId)
    if(taskVo)then
        if(taskVo:getState() == task.AwardRecState.UN_REC)then
            gs.Message.Show(_TT(572)) --未可领取
        elseif(taskVo:getState() == task.AwardRecState.CAN_REC)then
            GameDispatcher:dispatchEvent(EventName.REQ_ELIMINATE_TASK_AWARD, {taskConfigVo})
        elseif(taskVo:getState() == task.AwardRecState.HAS_REC)then
            gs.Message.Show(_TT(411)) --已领取
        end
    else
        gs.Message.Show(_TT(572)) --未可领取
    end
end

function removeAwardItemList(self)
    for i = #self.mAwardItemList, 1, -1 do
        local item = self.mAwardItemList[i]
        item:poolRecover()
    end
    self.mAwardItemList = {}
end

function deActive(self)
    super.deActive(self)
    self:removeAwardItemList()
end

function onDelete(self)
    super.onDelete(self)
end

return _M