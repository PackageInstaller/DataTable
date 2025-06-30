--[[-----------------------------------------------------
@filename       : DailyTaskBoxItem
@Description    : 日常任务评分箱子
@date           : 2020-11-26 19:57:53
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.task.dailyTask.view.item.DailyTaskBoxItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("taskHall/dailyTask/DailyTaskBoxItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.data = nil
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mIsSelectGroup = self:getChildGO("mIsSelectGroup")
    self.mGeted = self:getChildGO("mGeted")
    self.mNotGet = self:getChildGO("mNotGet")
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroup, self.onClick)
end

function onClick(self)
    if (self.data:getState() == task.AwardRecState.UN_REC) then
        GameDispatcher:dispatchEvent(EventName.UPDATE_TASK_SHOWTIPS, { tip = _TT(663, self.data.score), propsList = self.data.propsList, trans = self.UITrans, index = self.data.id })
    elseif (self.data:getState() == task.AwardRecState.CAN_REC) then
        GameDispatcher:dispatchEvent(EventName.REQ_REC_TASK_SCORE_AWARD, { scoreAwardId = self.data.id })
        GameDispatcher:dispatchEvent(EventName.HIDDEN_TASK_SHOWTIPS, {})
    elseif (self.data:getState() == task.AwardRecState.HAS_REC) then
        -- gs.Message.Show(_TT(411))
        GameDispatcher:dispatchEvent(EventName.UPDATE_TASK_SHOWTIPS, { tip = _TT(411), propsList = self.data.propsList, trans = self.UITrans, index = self.data.id })
        --GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(663, self.data.score), propsList = self.data.propsList })
    end
end

function setData(self, cusData, cusParent)
    self:setParentTrans(cusParent)
    self.data = cusData
    self.mTxtScore.text = cusData.score
    self:updataView(cusData)
end
function updataView(self, data)
    self.mIsSelectGroup:SetActive(self.data:getState() == task.AwardRecState.CAN_REC)
    self.mGeted:SetActive(self.data:getState() == task.AwardRecState.HAS_REC)
    self.mNotGet:SetActive(self.data:getState() == task.AwardRecState.UN_REC)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]