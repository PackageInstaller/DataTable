local base = UIBaseNode
local UINMlstShetBandListItem = class("UINMlstShetBandListItem", base)
local cs_Ease = CS.DG.Tweening.Ease
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINMlstShetBandListTaskItem = require("Game.MileStone.UI.Sheet.BandList.ListItem.UINMlstShetBandListTaskItem")
local UINMlstShetBandListHeroItem = require("Game.MileStone.UI.Sheet.BandList.ListItem.UINMlstShetBandListHeroItem")
local UINMlstShetBandListEmptyHeroItem = require("Game.MileStone.UI.Sheet.BandList.ListItem.UINMlstShetBandListEmptyHeroItem")
local TaskUtil = require("Game.Task.TaskUtil")
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local heroHeadNum = 6
local COLOR_GRAY_NONE = Color.New(0.8117647, 0.8117647, 0.8117647, 1)
local COLOR_GRAY_PICKED = Color.New(0.5294118, 0.5294118, 0.5294118, 1)

function UINMlstShetBandListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.layoutElem.enabled = false
  UIUtil.AddButtonListener(self.ui.btn_StageCheck, self, self._OnClickStageCheck)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self._OnClickPickStageReward)
  UIUtil.AddButtonListener(self.ui.btn_PickAll, self, self._OnClickPickAllTaskReward)
  UIUtil.AddButtonListener(self.ui.btn_DropDown, self, self._OnClickShowTask)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
  self.taskItemPool = UIItemPool.New(UINMlstShetBandListTaskItem, self.ui.taskItem, false)
  self.heroItemPool = UIItemPool.New(UINMlstShetBandListHeroItem, self.ui.heroItem, false)
  self.emptyHeroItemPool = UIItemPool.New(UINMlstShetBandListEmptyHeroItem, self.ui.emptyHeroItem, false)
  self._pickTaskRewardFunc = BindCallback(self, self._OnPickTaskReward)
end

function UINMlstShetBandListItem:SetMlstShetBandListItemFunc(showStageRewardFunc, pickAllTaskFunc, pickTaskFunc)
  self._showStageRewardFunc = showStageRewardFunc
  self._pickAllTaskFunc = pickAllTaskFunc
  self._pickTaskFunc = pickTaskFunc
end

function UINMlstShetBandListItem:SetMlstShetBandListItemHideTaskDic(hideTaskDic)
  self._hideTaskDic = hideTaskDic
end

function UINMlstShetBandListItem:InitNmlstShetBandListItem(bandData)
  self.bandData = bandData
  self.ui.tex_Title.text = bandData:GetMlstBandName()
  self:_UpdCurStageReward()
  self:_UpdTaskList()
  self:_UpdHero()
end

function UINMlstShetBandListItem:PlayInitTween(index)
  self:_ClearTween()
  local durationTime = 0.5
  local delayTime = 0.1 + index * 0.2
  self.ui.infoGroup.transform:DOLocalMoveX(-70, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(delayTime)
  self.ui.canvas_InfoGroup:DOFade(0, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(delayTime)
  if self.canPickMulty then
    delayTime = delayTime + 0.1
    self.ui.pickAllTask.transform:DOLocalMoveX(-70, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(delayTime)
    self.ui.canvas_PickAllTask:DOFade(0, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(delayTime)
  end
  for num, taskItem in pairs(self.taskItemPool.listItem) do
    taskItem.transform:DOLocalMoveX(-70, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(delayTime + num * 0.05)
    taskItem.ui.canvas_taskItem:DOFade(0, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(delayTime + num * 0.05)
  end
end

function UINMlstShetBandListItem:_UpdCurStageReward()
  local stageId = self.bandData:GetMlstBandStage()
  local maxStage = self.bandData:GetMlstBandStageMax()
  local curScore = self.bandData:GetMlstBandCurScore()
  local scoreMax = self.bandData:GetMlstBandScoreMax()
  self.ui.obj_State:SetActive(false)
  if 0 < scoreMax then
    if curScore >= scoreMax then
      self.ui.btn_Receive.gameObject:SetActive(true)
    else
      self.ui.btn_Receive.gameObject:SetActive(false)
      self.ui.tex_State:SetIndex(1)
      self.ui.img_obj_State.color = COLOR_GRAY_NONE
      self.ui.obj_State:SetActive(true)
    end
    self.ui.tex_Point.gameObject:SetActive(true)
    self.ui.tex_Point:SetIndex(0, tostring(curScore), tostring(scoreMax))
  else
    self.ui.tex_Point.gameObject:SetActive(false)
    self.ui.tex_State:SetIndex(0)
    self.ui.img_obj_State.color = COLOR_GRAY_PICKED
    self.ui.obj_State:SetActive(true)
  end
  self.ui.tex_Stage:SetIndex(stageId - 1)
  local rewardIds, rewardNums = self.bandData:GetMlstBandReawrd(stageId)
  local isPicked = scoreMax == 0
  self.rewardItemPool:HideAll()
  for k, itemId in ipairs(rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    local itemNum = rewardNums[k]
    local item = self.rewardItemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
    item:SetNotNeedAnyJump(true)
  end
end

function UINMlstShetBandListItem:_UpdHero()
  local heroIdList = self.bandData:GetMlstBandHeroIdList()
  self.heroItemPool:HideAll()
  self.emptyHeroItemPool:HideAll()
  for i = 1, heroHeadNum do
    local heroId = heroIdList[i]
    if heroId then
      local item = self.heroItemPool:GetOne()
      item:InitMlstShetBandListHeroItem(heroId)
    else
      local item = self.emptyHeroItemPool:GetOne()
      item:InitMlstShetBandListEmptyHeroItem(i)
    end
  end
end

function UINMlstShetBandListItem:_UpdTaskList()
  self.taskItemPool:HideAll()
  local hideTask = self._hideTaskDic[self.bandData:GetMlstBandId()]
  if hideTask == nil then
    local canPickRewardNum = self.bandData:GetMlstBandCurTaskStateNum()
    hideTask = canPickRewardNum == 0
    self._hideTaskDic[self.bandData:GetMlstBandId()] = hideTask
  end
  self.ui.obj_ArrowUP.eulerAngles = Vector3.Temp(0, 0, hideTask and 180 or 0)
  if hideTask then
    self.ui.pickAllTask:SetActive(false)
    CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
    return
  end
  local taskDataList = self.bandData:GetMlstBandCurTaskList()
  local scoreItemId = self.bandData:GetMlstBandScoreId()
  self._completedTaskIdDic = {}
  local pickableNum = 0
  local pickableScore = 0
  TaskUtil.SortTaskDataList(taskDataList)
  for k, taskData in ipairs(taskDataList) do
    if not taskData:IsPickedTaskReward() and taskData:CheckComplete() then
      local score = MilestoneUtil.GetMlstTaskScore(taskData, scoreItemId)
      pickableScore = pickableScore + score
      pickableNum = pickableNum + 1
      self._completedTaskIdDic[taskData.id] = true
    end
    local item = self.taskItemPool:GetOne()
    item:InitMlstShetBandListTaskItem(taskData, scoreItemId, self._pickTaskRewardFunc)
  end
  self.canPickMulty = 1 < pickableNum
  self.ui.pickAllTask:SetActive(self.canPickMulty)
  if self.canPickMulty then
    self.ui.tex_AllPoint:SetIndex(0, tostring(pickableScore))
  end
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
end

function UINMlstShetBandListItem:_OnClickStageCheck()
  if self._showStageRewardFunc then
    self._showStageRewardFunc(self.bandData)
  end
end

function UINMlstShetBandListItem:_OnClickPickStageReward()
  local bandId = self.bandData:GetMlstBandId()
  local milestoneNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Milestone)
  milestoneNetCtrl:CS_Milestone_Band_Reward(bandId, function(args)
    if (args == nil or args.Count == 0) and isGameDev then
      error("args.Count == 0")
    end
    local rewardsDic = args[0]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window ~= nil then
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseDic(rewardsDic):SetCRNotHandledGreat(true)
        window:AddAndTryShowReward(CRData)
      end
    end)
  end)
end

function UINMlstShetBandListItem:_OnClickPickAllTaskReward()
  if self._pickAllTaskFunc then
    self._pickAllTaskFunc(self._completedTaskIdDic)
  end
end

function UINMlstShetBandListItem:_OnPickTaskReward(taskData)
  if self._pickTaskFunc then
    self._pickTaskFunc(taskData)
  end
end

function UINMlstShetBandListItem:_ClearTween()
  self.ui.infoGroup.transform:DOComplete()
  self.ui.canvas_InfoGroup:DOComplete()
  self.ui.pickAllTask.transform:DOComplete()
  self.ui.canvas_PickAllTask:DOComplete()
  for num, taskItem in pairs(self.taskItemPool.listItem) do
    taskItem.transform:DOComplete()
    taskItem.ui.canvas_taskItem:DOComplete()
  end
end

function UINMlstShetBandListItem:_OnClickShowTask()
  self._hideTaskDic[self.bandData:GetMlstBandId()] = not self._hideTaskDic[self.bandData:GetMlstBandId()]
  self:_UpdTaskList()
end

function UINMlstShetBandListItem:OnDelete()
  self.rewardItemPool:DeleteAll()
  self.taskItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINMlstShetBandListItem
