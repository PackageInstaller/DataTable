--[[ 
-----------------------------------------------------
@filename       : MainActivityTaskItem
@Description    : 活动玩法任务Item
@date           : 2023/5/24 15:00
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------]]
module("mainActivity.MainActivityTaskItem ", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.awardPropsList = {}
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self:getChildGO("mTextGo"):GetComponent(ty.Text).text = _TT(4)
    self:getChildGO("mTextRecieve"):GetComponent(ty.Text).text = _TT(3)--领取
    self.mPropsContent = self:getChildTrans("mPropsContent")
    self:addOnClick(self:getChildGO("mBtnReceive"), self.__onClickRecHandler)
end


function deActive(self)
    super.deActive(self)
    self:recoverGrid()
end

function setData(self, param)
    super.setData(self, param)
    if self.data then
        self.mTxtDes.text = _TT(self.data.des)

        local received = mainActivity.MainActivityManager:checkTaskAwardReceived(self.data.id)
        self:getChildGO("mGroupReceived"):SetActive(received)

        local taskMsgVo = mainActivity.MainActivityManager:getTaskMsgVo(self.data.id)
        self.canReceive = taskMsgVo ~= nil and taskMsgVo.state == 0

        self:getChildGO("mBtnReceive"):SetActive(self.canReceive)

        local cannotReceive = taskMsgVo == nil or taskMsgVo.state == 1
        if cannotReceive then
            self:getChildGO("mBtnUnfinished"):SetActive(true)
            if not self.mTxtPro then
                self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
            end
            if not self.mTxtAll then
                self.mTxtAll = self:getChildGO("mTxtAll"):GetComponent(ty.Text)
            end
            self.mTxtPro.text = taskMsgVo ~= nil and taskMsgVo.count or 0
            self.mTxtAll.text = "/" .. self.data.needTimes
        else
            self:getChildGO("mBtnUnfinished"):SetActive(false)
        end

        self:recoverGrid()
        for _, awardPropsVo in pairs(self.data.reward)
        do
            local grid = PropsGrid:createByData({ tid = awardPropsVo.tid, num = awardPropsVo.num, parent = self.mPropsContent, scale = 1, showUseInTip = true, isTween = false })
            table.insert(self.awardPropsList, grid)
        end

    end
end

function onDelete(self)
    super.onDelete(self)
end


function __onClickRecHandler(self)
    local taskId = self.data.id
    if self.canReceive then
        GameDispatcher:dispatchEvent(EventName.REQ_MAINACTIVITY_TASK_AWARD_RECEIVE, { taskId })
    end
end

function recoverGrid(self)
    if next(self.awardPropsList) then
        for i = 1, #self.awardPropsList do
            self.awardPropsList[i]:poolRecover()
        end
        self.awardPropsList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]