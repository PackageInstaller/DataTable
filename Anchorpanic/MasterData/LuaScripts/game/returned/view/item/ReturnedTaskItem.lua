--[[ 
-----------------------------------------------------
@filename       : ReturnedTaskItem
@Description    : 回归任务
@date           : 2023-11-01 14:13:54
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.view.item.ReturnedTaskItem', Class.impl("lib.component.BaseItemRender"))

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
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    self.mImgTitleState = self:getChildGO("mImgTitleState"):GetComponent(ty.AutoRefImage)
    self.mTxtGet.text = _TT(3) -- 领取
    self.mTxtGoto.text = _TT(4) -- 前往
end

function setData(self, param)
    super.setData(self, param)

    self.taskVo = param

    self:updateView()
end

--激活
function active(self)
    super.active(self)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onOpHandler)
    self:addUIEvent(self.mBtnGoto, self.onOpHandler)
end


function updateView(self)
    local awardList = self.taskVo.taskReward
    self.mTxtName.text = _TT(self.taskVo:getDescribe())

    self.mNoGet:SetActive(false)
    self.mGroupGeted:SetActive(false)
    self.mReceivedGroup:SetActive(false)
    local color = "202226"
    local state = self.taskVo:getState()
    self.mImgTitleState.gameObject:SetActive(state ~= ReturnedTaskState.HAS_REC)
    if (state == ReturnedTaskState.HAS_REC) then
        -- 已领取
        self.mBtnGet:SetActive(false)
        self.mBtnGoto:SetActive(false)
        self.mGroupGeted:SetActive(true)
        self.mReceivedGroup:SetActive(true)
    elseif (state == ReturnedTaskState.CAN_REC) then
        -- 可领取
        self.mImgTitleState.color = gs.ColorUtil.GetColor("FCAD48ff")
        self.mBtnGet:SetActive(true)
        self.mBtnGoto:SetActive(false)
    elseif (state == ReturnedTaskState.UN_REC) then
        self.mImgTitleState.color = gs.ColorUtil.GetColor("202226ff")
        self.mNoGet:SetActive(true)
        local linkId = self.taskVo:getUiCode()
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
    self.mTxtCurNum.text = _TT(45013, HtmlUtil:colorAndSize(self.taskVo:getCount(), "141c2bff", 40), self.taskVo:getTime())
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
    local state = self.taskVo:getState()
    if (state == ReturnedTaskState.HAS_REC) then
        gs.Message.Show(_TT(7))
    elseif (state == ReturnedTaskState.CAN_REC) then
        if (self.taskVo.type == 2) then
            GameDispatcher:dispatchEvent(EventName.REQ_REC_RETURNED_TASK_AWARD, { taskId = self.taskVo:getId() })
        else
            GameDispatcher:dispatchEvent(EventName.REQ_REC_RETURNED_TASK_AWARD, { taskId = self.taskVo:getId() })
        end
    elseif (state == ReturnedTaskState.UN_REC) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.taskVo:getUiCode() })
    end
end

return _M