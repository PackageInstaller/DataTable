--[[ 
-----------------------------------------------------
@filename       : NoviceActivityBraceltesItem
@Description    : 新手活动招募手环 Item
@date           : 2023-06-6
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NoviceActivityBraceltesItem ", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.awardPropsList = {}
    self.mImPro = self:getChildGO("ImPro"):GetComponent(ty.Image)
    self.mTextName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTextPro = self:getChildGO("TextPro"):GetComponent(ty.Text)
    self:getChildGO("TextGet"):GetComponent(ty.Text).text = _TT(3)
    self:getChildGO("mTxtIng"):GetComponent(ty.Text).text = _TT(4)--前往
    self.Content = self:getChildTrans("Content")
    self:addOnClick(self:getChildGO("mBtnGet"), self.__onClickRecHandler)
    self:addOnClick(self:getChildGO("mGroupIng"), self.__onClickRecHandler)
end

function deActive(self)
    super.deActive(self)
    self:recoverGrid()
end

function onDelete(self)
    super.onDelete(self)

end

function setData(self, param)
    super.setData(self, param)
    if self.data then
        self.mTextName.text = _TT(self.data.des)
        local max = noviceActivity.NoviceActivityManager:getMaxBracelets()
        local nowGetNum = noviceActivity.NoviceActivityManager.braceletsRecruitedTimes > max and max or noviceActivity.NoviceActivityManager.braceletsRecruitedTimes
        self.mTextPro.text = nowGetNum .. "/" .. self.data.needNum
        self.mImPro.fillAmount = nowGetNum / self.data.needNum

        local received = noviceActivity.NoviceActivityManager:checkBraceletsReceived(self.data.id)
        self:getChildGO("GroupHasRec"):SetActive(received)

        self.canReceive = not received and nowGetNum >= self.data.needNum
        self:getChildGO("mBtnGet"):SetActive(self.canReceive)

        self.canNotReceive = nowGetNum < self.data.needNum and not received
        self:getChildGO("mGroupIng"):SetActive(self.canNotReceive)

        self:recoverGrid()
        for _, awardPropsVo in pairs(self.data.reward)
        do
            local grid = PropsGrid:createByData({ tid = awardPropsVo.tid, num = awardPropsVo.num, parent = self.Content, scale = 1, showUseInTip = true, isTween = false })
            grid:setCountTextSize(26)
            table.insert(self.awardPropsList, grid)
        end
    else

    end
end

function __onClickRecHandler(self)
    local taskId = self.data.id
    if self.canReceive then
        GameDispatcher:dispatchEvent(EventName.REQ_RECEIVE_RECRUIT_BRACELETS, taskId)
    end
    if self.canNotReceive then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.RecruitBracelets })
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