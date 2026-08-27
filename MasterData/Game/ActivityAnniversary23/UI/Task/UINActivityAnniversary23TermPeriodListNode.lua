local UINActivityAnniversary23TermPeriodListNode = class("UINActivityAnniversary23TermPeriodListNode", UIBaseNode)
local base = UIBaseNode
local UINActivityAnniversary23TermPeriodListItem = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23TermPeriodListItem")
local UINTaskViewReward = require("Game.Task.NewUI.UINTaskViewReward")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINActivityAnniversary23TermPeriodListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.peroidItemPool = UIItemPool.New(UINActivityAnniversary23TermPeriodListItem, self.ui.obj_peroidItem)
  self.ui.obj_peroidItem:SetActive(false)
  self.viewReward = UINTaskViewReward.New()
  self.viewReward:Init(self.ui.viewReward)
end

function UINActivityAnniversary23TermPeriodListNode:InitTermPeroidList(actTermTaskData, term, callback)
  self._actTermTaskData = actTermTaskData
  self._term = term
  local allCfg = ConfigData.activity_general_quest_bp[actTermTaskData._frameId]
  if allCfg == nil then
    error("cant get activity_general_quest_bp config!!")
    return
  end
  local cfg = allCfg[term]
  if cfg == nil then
    error("cant get activity_general_quest_bp config!!")
    return
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actTermTaskData._frameId)
  if actFrameData == nil then
    error("actData is nil!")
    return
  end
  self.ui.img_Process.fillAmount = 0
  local actData = actFrameData:GetActivityData()
  local bpTable = actData:GetActivityBpPointByTerm(term)
  local dataNum = #cfg
  self.itemNum = dataNum
  local unitRate = 1 / (dataNum * 2 - 1)
  local fillValue = 0
  local needPoint
  local currActiveNum = bpTable.point
  local remaindActiveNum = currActiveNum
  local totalActiveNum = 0
  local fitNum = 0
  local maxPoint = 0
  self.peroidItemPool:HideAll()
  for index, data in ipairs(cfg) do
    local item = self.peroidItemPool:GetOne()
    local stateType = TaskEnum.eTaskState.InProgress
    if bpTable.rewardGotPoint >= data.point or bpTable.point >= data.point then
      stateType = TaskEnum.eTaskState.Completed
      if bpTable.rewardGotPoint >= data.point then
        stateType = TaskEnum.eTaskState.Picked
      end
      fitNum = fitNum + 1
      remaindActiveNum = currActiveNum - data.point
    elseif needPoint == nil then
      needPoint = data.level == 1 and data.point or data.point - cfg[index - 1].point
    end
    item:InitPeroidItem(data, actTermTaskData._frameId, self.viewReward, stateType, callback)
    if index == #cfg then
      maxPoint = data.point
    end
  end
  if needPoint == nil then
    fillValue = unitRate * (fitNum * 2 - 1)
  elseif fitNum == 0 then
    fillValue = unitRate * (remaindActiveNum / needPoint)
  else
    fillValue = unitRate * (fitNum * 2 - 1) + 2 * unitRate * (remaindActiveNum / needPoint)
  end
  self:SetProcessTween(fillValue, 0.8)
  self.ui.tex_TotalPoint:SetIndex(0, tostring(bpTable.point), tostring(maxPoint))
  self.ui.tex_peroidType:SetIndex(3)
  self:LayOutItems()
end

function UINActivityAnniversary23TermPeriodListNode:LayOutItems()
  local startPos = self.ui.pointStart.position
  local endPos = self.ui.pointEnd.position
  local length = endPos.x - startPos.x
  local unitLength = length / (self.itemNum * 2 - 1)
  for i, item in ipairs(self.peroidItemPool.listItem) do
    local pos = item.transform.position
    item.transform.position = Vector3.New(startPos.x + unitLength * (2 * i - 1), pos.y, pos.z)
  end
end

function UINActivityAnniversary23TermPeriodListNode:SetProcessTween(setValue, duration)
  if setValue <= 0 then
    return
  end
  local isComplete = ControllerManager:GetController(ControllerTypeId.Task):IsDailyCompleteToRefresh()
  if not isComplete then
    self.ui.img_Process.fillAmount = setValue
  else
    if self.processSeq ~= nil then
      self.processSeq:Kill()
    end
    self.ui.img_Process.color = Color.white
    self.processSeq = cs_DoTween.Sequence()
    self.processSeq:Append(self.ui.img_Process:DOFillAmount(setValue, duration))
    self.processSeq:Join(self.ui.img_Process:DOColor(self.ui.col_processColor, 0.2):SetLoops(5))
    self.processSeq:SetAutoKill(false)
  end
end

function UINActivityAnniversary23TermPeriodListNode:OnDelete()
  self.peroidItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINActivityAnniversary23TermPeriodListNode
