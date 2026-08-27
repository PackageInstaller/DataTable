local base = UIBaseNode
local UINMilestoneSheetLeft = class("UINMilestoneSheetLeft", base)
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINMltsSheetLeftStageItem = require("Game.MileStone.UI.Sheet.Left.UINMltsSheetLeftStageItem")

function UINMilestoneSheetLeft:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CheckStage, self, self._OnClickAllStage)
  UIUtil.AddButtonListener(self.ui.btn_Pick, self, self._OnClickPickReward)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.UINBaseItemWithReceived, false)
  self.stageItemPool = UIItemPool.New(UINMltsSheetLeftStageItem, self.ui.stageItem, false)
  self.stageItemDic = {}
end

function UINMilestoneSheetLeft:InitMilestoneSheetLeft(mlstDemitionData, showStageUpCallback)
  self._mlstDemitionData = mlstDemitionData
  self.showStageUpCallback = showStageUpCallback
  local curScore = self._mlstDemitionData:GetMlstDimensionScore()
  local maxScore = self._mlstDemitionData:GetMlstDimensionScoreMax()
  if maxScore == 0 then
    local finalStageScore = self._mlstDemitionData:GetPickrewardStageScore4Stage(ConfigData.milestone_mile_color.maxStageId)
    self.ui.tex_Progress:SetIndex(0, tostring(finalStageScore), tostring(finalStageScore))
  else
    self.ui.tex_Progress:SetIndex(0, tostring(curScore), tostring(maxScore))
  end
  self.ui.Tex_Stage.text = MilestoneUtil.GetSPSStageId2EngChar(self._mlstDemitionData:GetMlstDimensionStage())
  self._isShowAllStage = false
  self:_UpdStage()
  self:RefreshIsCouldPickStageReward()
end

function UINMilestoneSheetLeft:RefreshIsCouldPickStageReward()
  local curScore = self._mlstDemitionData:GetMlstDimensionScore()
  local maxScore = self._mlstDemitionData:GetMlstDimensionScoreMax()
  local isCouldPic = curScore >= maxScore and maxScore ~= 0
  self.ui.obj_UnClear:SetActive(not isCouldPic)
  self.ui.btn_Pick.gameObject:SetActive(isCouldPic)
  if maxScore == 0 then
    self.ui.tex_UnClear:SetIndex(1)
  else
    self.ui.tex_UnClear:SetIndex(0)
  end
end

function UINMilestoneSheetLeft:_OnClickAllStage()
  self._isShowAllStage = not self._isShowAllStage
  self:_UpdStage()
  if not self._isShowAllStage then
    return
  end
  local curStage = self._mlstDemitionData:GetMlstDimensionStage()
  local maxStage = ConfigData.milestone_mile_color.maxStageId
  local rate
  if curStage == 1 then
    rate = 0
  else
    local maxSize = 15 + 150 * maxStage + 10 * (maxStage - 1)
    local viewSize = 390
    local needMoveUp = 15 + 150 * (curStage - 1) + 10 * (curStage - 1)
    rate = needMoveUp / (maxSize - viewSize)
  end
  self.ui.allStageListList:DOVerticalNormalizedPos(1 - rate, 0.2):SetLink(self.gameObject)
end

function UINMilestoneSheetLeft:_UpdStage()
  self.ui.allStageList:SetActive(self._isShowAllStage)
  self.ui.rewardList:SetActive(not self._isShowAllStage)
  self.ui.Obj_DownArrow.eulerAngles = Vector3.Temp(0, 0, self._isShowAllStage and 0 or 180)
  if self._isShowAllStage then
    self:_UpdAllStageReward()
  else
    self:_UpdCurStageReward()
  end
end

function UINMilestoneSheetLeft:_UpdCurStageReward()
  self.rewardItemPool:HideAll()
  local moduleId = self._mlstDemitionData:GetMlstDimensionId()
  local curStage = self._mlstDemitionData:GetMlstDimensionStage()
  local maxScore = self._mlstDemitionData:GetMlstDimensionScoreMax()
  local rewardCfg = ConfigData.milestones_module_reward[moduleId] and ConfigData.milestones_module_reward[moduleId][curStage]
  if rewardCfg == nil then
    error(string.format("Cant get milestones_module_reward cfg, moduleId:%s, stageId:%s", moduleId, curStage))
    return
  end
  local isPicked = maxScore == 0
  for itemId, itemNum in pairs(rewardCfg.reward) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("cant get item cfg, itemId:" .. tostring(itemId))
      return
    end
    local item = self.rewardItemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
    item:SetNotNeedAnyJump(true)
  end
end

function UINMilestoneSheetLeft:_UpdAllStageReward()
  local moduleId = self._mlstDemitionData:GetMlstDimensionId()
  local pickedScore = self._mlstDemitionData:GetMlstDimensionPickedScore()
  self.stageItemPool:HideAll()
  self.stageItemDic = {}
  for stageId = 1, ConfigData.milestone_mile_color.maxStageId do
    local needScore = self._mlstDemitionData:GetPickrewardScore4Stage(stageId)
    local isPicked = pickedScore >= needScore
    local item = self.stageItemPool:GetOne()
    item:InitMltsSheetLeftStageItem(moduleId, stageId, isPicked)
    self.stageItemDic[stageId] = item
  end
end

function UINMilestoneSheetLeft:_OnClickPickReward()
  local moduleId = self._mlstDemitionData:GetMlstDimensionId()
  local milestoneNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Milestone)
  local oldStageId = self._mlstDemitionData:GetMlstDimensionStage()
  local oldProcess = self._mlstDemitionData:GetMlstDimensionScoreProgress()
  milestoneNetCtrl:CS_Milestone_Module_Reward(moduleId, function(args)
    if (args == nil or args.Count == 0) and isGameDev then
      error("args.Count == 0")
    end
    local rewardsDic = args[0]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(rewardsDic):SetCRNotHandledGreat(true):SetCRShowOverFunc(self.showStageUpCallback)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function UINMilestoneSheetLeft:OnDelete()
  self.rewardItemPool:DeleteAll()
  self.stageItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINMilestoneSheetLeft
