--[[ 
-----------------------------------------------------
@filename       : NovicePermotionPlanItem
@Description    : 新手活动-升格计划
@date           : 2023-6-6 11:24:23
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.noviceActivity.view.item.NovicePermotionPlanItem", Class.impl("lib.component.BaseItemRender"))

--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
    self.mBar = self:getChildGO("mBar"):GetComponent(ty.Image)
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtGoto = self:getChildGO("mTxtGoto"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtShowProgress = self:getChildGO("mTxtShowProgress"):GetComponent(ty.Text)
    self.mTxtGet.text = _TT(3) -- 领取
    self.mTxtGoto.text = _TT(4) -- 前往
    self.mGridList = {}
end

-- override 虚拟列表被激活时自动调用
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_UPGRADE_PLAN_ITEM, self.updateView, self)
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

-- 渲染器item销毁
function onDelete(self)
    super.onDelete(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_UPGRADE_PLAN_ITEM, self.updateView, self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onClickHandler)
    self:addUIEvent(self.mBtnGoto, self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)
    self.taskVo = param
    self:updateView()
end

function updateView(self)
    local taskConfigVo = task.DailyTaskManager:getTaskConfigVo(self.taskVo.id)
    local awardList = self.taskVo:getAwardList()
    self.mTxtTitle.text = self.taskVo:getDescribe()
    self.mBar.fillAmount = self.taskVo:getCurCount() / self.taskVo:getTime()
    local state = self.taskVo:getState()
    self.mBtnGet:SetActive(state == task.AwardRecState.CAN_REC)
    self.mBtnGoto:SetActive(state == task.AwardRecState.UN_REC)
    self.mGroupGeted:SetActive(state == task.AwardRecState.HAS_REC)
    self.mTxtShowProgress.text = _TT(45013, self.taskVo:getCurCount(), self.taskVo:getTime())
    self:recoverAllGrid()
    for index, awardVo in ipairs(awardList) do
        local propsGrid = PropsGrid:createByData({ tid = awardVo[1], num = awardVo[2], parent = self.mAwardTrans, scale = 1, showUseInTip = true })
        propsGrid:setCountTextSize(26)
        table.insert(self.mGridList, propsGrid)
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mAwardTrans)
end


function recoverAllGrid(self)
    if #self.mGridList > 0 then
        for i = 1, #self.mGridList do
            self.mGridList[i]:poolRecover()
        end
        self.mGridList = {}
    end
end

function onClickHandler(self)
    local state = self.taskVo:getState()
    if (state == task.AwardRecState.CAN_REC) then
        GameDispatcher:dispatchEvent(EventName.REQ_RECEIVE_UPGRADE_PLAN_AWARD, self.taskVo.id)
    elseif (state == task.AwardRecState.UN_REC) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Hero })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]