local UINTaskPeroidNode = class("UINTaskPeroidNode", UIBaseNode)
local base = UIBaseNode
local UINTaskPeroidNodeItem = require("Game.Task.NewUI.UINTaskPeroidNodeItem")
local TaskEnum = require("Game.Task.TaskEnum")
local UINTaskViewReward = require("Game.Task.NewUI.UINTaskViewReward")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINTaskPeroidNode:OnInit()
  self.itemNum = 0
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.peroidItemPool = UIItemPool.New(UINTaskPeroidNodeItem, self.ui.obj_peroidItem)
  self.ui.obj_peroidItem:SetActive(false)
  self.viewReward = UINTaskViewReward.New()
  self.viewReward:Init(self.ui.viewReward)
  self.ui.col_processColor = self.ui.img_Process.color
  self.diffPeroidProcessDic = {}
end

function UINTaskPeroidNode:RefreshPeroid(peroidId, peroidDatas, resetActive)
  local dataNum = #peroidDatas
  self.itemNum = dataNum
  local unitRate = 1 / (self.itemNum * 2 - 1)
  local needPoint
  local pointId = peroidDatas[1].stcData.activeId
  local currActiveNum = PlayerDataCenter:GetItemCount(pointId)
  local remaindActiveNum = currActiveNum
  local totalActiveNum = 0
  local fitNum = 0
  if resetActive then
    self.peroidItemPool:HideAll()
  end
  for index, data in ipairs(peroidDatas) do
    totalActiveNum = data.stcData.activeNum
    local item
    if resetActive then
      item = self.peroidItemPool:GetOne()
    else
      item = self.peroidItemPool.listItem[index]
    end
    if data.stateType == TaskEnum.eTaskState.Completed or data.stateType == TaskEnum.eTaskState.Picked then
      fitNum = fitNum + 1
      remaindActiveNum = currActiveNum - data.stcData.activeNum
    elseif data.stateType == TaskEnum.eTaskState.InProgress and needPoint == nil then
      needPoint = index == 1 and data.stcData.activeNum or data.stcData.activeNum - peroidDatas[index - 1].stcData.activeNum
    end
    local itemCfg, num = self:__GetHightestValueItemCfg(data.stcData.rewardIds, data.stcData.rewardNums)
    item:InitPeroidItem(index, data.stateType, totalActiveNum, itemCfg, num, self.viewReward, data)
  end
  self.ui.tex_TotalPoint:SetIndex(0, tostring(currActiveNum), tostring(totalActiveNum))
  local fillValue = 0
  if needPoint == nil then
    fillValue = unitRate * (fitNum * 2 - 1)
  elseif fitNum == 0 then
    fillValue = unitRate * (remaindActiveNum / needPoint)
  else
    fillValue = unitRate * (fitNum * 2 - 1) + 2 * unitRate * (remaindActiveNum / needPoint)
  end
  if self.diffPeroidProcessDic[peroidId] == nil or self.diffPeroidProcessDic[peroidId] == fillValue then
    self.diffPeroidProcessDic[peroidId] = fillValue
    if self.processSeq ~= nil then
      self.processSeq:Kill()
    end
    self.ui.img_Process.fillAmount = fillValue
    self.ui.img_Process.color = self.ui.col_processColor
  else
    self.diffPeroidProcessDic[peroidId] = fillValue
    self:SetProcessTween(fillValue, 0.8)
  end
  local peroidTypeIndex = 0
  if peroidId == TaskEnum.eTaskType.WeeklyTask then
    peroidTypeIndex = 1
  elseif peroidId == TaskEnum.eTaskType.WeeklyChallengeTask then
    peroidTypeIndex = 2
  end
  self.ui.tex_peroidType:SetIndex(peroidTypeIndex)
  self:LayOutItems()
end

function UINTaskPeroidNode:LayOutItems()
  local startPos = self.ui.pointStart.position
  local endPos = self.ui.pointEnd.position
  local length = endPos.x - startPos.x
  local unitLength = length / (self.itemNum * 2 - 1)
  for i, item in ipairs(self.peroidItemPool.listItem) do
    local pos = item.transform.position
    item.transform.position = Vector3.New(startPos.x + unitLength * (2 * i - 1), pos.y, pos.z)
  end
end

function UINTaskPeroidNode:__GetHightestValueItemCfg(idList, numList)
  local itemCfgs = {}
  for index, id in ipairs(idList) do
    table.insert(itemCfgs, {
      cfg = ConfigData.item[id],
      num = numList[index]
    })
  end
  table.sort(itemCfgs, function(a, b)
    if a.quality == b.quality then
      return a.cfg.price < b.cfg.price
    else
      return a.cfg.quality < b.cfg.quality
    end
  end)
  return itemCfgs[1].cfg, itemCfgs[1].num
end

function UINTaskPeroidNode:SetProcessTween(setValue, duration)
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

function UINTaskPeroidNode:GetTaskPeroidProgressPos()
  local anchoredPosition = self.ui.progressPos.anchoredPosition
  anchoredPosition.x = self.ui.img_Process.transform.rect.width * self.ui.img_Process.fillAmount
  self.ui.progressPos.anchoredPosition = anchoredPosition
  return self.ui.progressPos.position
end

function UINTaskPeroidNode:OnDelete()
  if self.processSeq ~= nil then
    self.processSeq:Kill()
    self.processSeq = nil
  end
  base.OnDelete(self)
end

return UINTaskPeroidNode
