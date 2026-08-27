local base = UIBaseWindow
local UIMilestoneSheet = class("UIMilestoneSheet", UIBaseWindow)
local cs_Tweening = CS.DG.Tweening
local cs_DoTween = cs_Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local UINMilestoneSheetLeft = require("Game.MileStone.UI.Sheet.Left.UINMilestoneSheetLeft")
local UINMlstSheetTaskList = require("Game.MileStone.UI.Sheet.TaskList.UINMlstSheetTaskList")
local UINMlstShetRewardStage = require("Game.MileStone.UI.Sheet.RewardStage.UINMlstShetRewardStage")
local UINMilestoneStar = require("Game.MileStone.UI.Common.UINMilestoneStar")
local UINMlstTaskOverview = require("Game.MileStone.UI.Sheet.TaskOverview.UINMlstTaskOverview")
local UINMlstSheetBandList = require("Game.MileStone.UI.Sheet.BandList.UINMlstSheetBandList")
local UINMilestoneUpgrageNotice = require("Game.MileStone.UI.Sheet.UpgradeNotice.UINMilestoneUpgrageNotice")

function UIMilestoneSheet:OnInit()
  self._resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.pageUp, self, self._OnClickUp)
  UIUtil.AddButtonListener(self.ui.pageDown, self, self._OnClickDown)
  UIUtil.AddButtonListener(self.ui.btn_QuickCheck, self, self._OnClickQuickCheck)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(BindCallback(self, self._OnClickReturn)):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self._mlstLeftNode = UINMilestoneSheetLeft.New()
  self._mlstLeftNode:Init(self.ui.left)
  self._mlstTaskNode = UINMlstSheetTaskList.New(self)
  self._mlstTaskNode:Init(self.ui.taskList)
  self._mlstBandNode = UINMlstSheetBandList.New(self)
  self._mlstBandNode:Init(self.ui.bandList)
  self.starNode = UINMilestoneStar.New()
  self.starNode:Init(self.ui.uINSixPointStar)
  self._upgradeNoticeNode = UINMilestoneUpgrageNotice.New()
  self._upgradeNoticeNode:Init(self.ui.upgradeNotice)
  self._upgradeNoticeNode:Hide()
  self.__ShowMilestoneStageUpNotice = BindCallback(self, self.ShowMilestoneStageUpNotice)
  self.__onMsDataUpdate = BindCallback(self, self.__OnMsDataUpdate)
  MsgCenter:AddListener(eMsgEventId.milestoneDataUpdate, self.__onMsDataUpdate)
  self.ui.anim_mileStone:Play("UI_MilestoneSheet")
end

function UIMilestoneSheet:InitMilestoneSheet(msData, mlstDemitionData)
  self.msData = msData
  self._mlstDemitionData = mlstDemitionData
  self.starNode:InitSixPointStar(nil)
  self._upgradeNoticeNode:InitMilestoneUpgrageNotice(self._resloader)
  self:__RefreshCurPage(false)
  self:RefreshSheetSixPointStar(true, true)
end

function UIMilestoneSheet:__RefreshCurPage(needAnim)
  local delayTime = 0
  if needAnim then
    delayTime = 0.3
    self.ui.anim_mileStone:Rewind()
    self.ui.anim_mileStone:Play("UI_MilestoneSheet_OutAndIn")
  end
  TimerManager:StopTimer(self.__changePageTimer)
  self.__changePageTimer = TimerManager:StartTimer(delayTime, function()
    self.ui.tex_TitleName.text = self._mlstDemitionData:GetMlstDimensionName()
    self.ui.tex_EnName.text = self._mlstDemitionData:GetMlstDimensionNameEn()
    local path = PathConsts:GetAtlasAssetPath("Milestone")
    local atlas = self._resloader:LoadABAsset(path)
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(atlas, self._mlstDemitionData:GetMlstDimensionIcon())
    local lastModuleId = self:_GetNextModuleId(false)
    local lastDemitionData = self.msData:GetMilestoneDimensionData(lastModuleId)
    local nextModuleId = self:_GetNextModuleId(true)
    local nextDemitionData = self.msData:GetMilestoneDimensionData(nextModuleId)
    self.ui.tex_PageUpName.text = lastDemitionData:GetMlstDimensionName()
    self.ui.tex_PageDownName.text = nextDemitionData:GetMlstDimensionName()
    if self._mlstDemitionData:GetMlstDimensionId() == MilestoneEnum.eMileStoneModule.mind then
      self._mlstBandNode:InitMlstSheetBandList(self.msData)
      self._mlstTaskNode:Hide()
    else
      self._mlstTaskNode:InitMlstSheetTaskList(self._mlstDemitionData)
      self._mlstBandNode:Hide()
    end
    self:__RefreshTopProcessBar()
    self._mlstLeftNode:InitMilestoneSheetLeft(self._mlstDemitionData, self.__ShowMilestoneStageUpNotice)
  end, nil, true)
end

function UIMilestoneSheet:__RefreshTopProcessBar(isHaveAnim)
  local curScore = self._mlstDemitionData:GetMlstDimensionScore()
  local curScoreMax = self._mlstDemitionData:GetMlstDimensionScoreMax()
  local rate
  if curScoreMax == 0 then
    rate = 1
  else
    rate = math.clamp(curScore / curScoreMax, 0, 1)
  end
  if isHaveAnim then
    local targetFillAmount = MilestoneUtil.GetMilstoneFillRateWithProcessId(rate)
    local oldFillAmount = self.ui.progressFill.fillAmount or 0
    if targetFillAmount < oldFillAmount then
      local lastTime = (1 - targetFillAmount) * 0.5
      self.ui.progressFill:DOFillAmount(1, lastTime):SetLink(self.gameObject):OnComplete(function()
        self.ui.progressFill.fillAmount = 0
      end)
      self.ui.progressFill:DOFillAmount(targetFillAmount, targetFillAmount * 0.5):SetDelay(lastTime + 0.1):SetLink(self.gameObject)
    else
      self.ui.progressFill:DOFillAmount(targetFillAmount, (targetFillAmount - oldFillAmount) * 0.5):SetLink(self.gameObject)
    end
    self.ui.tex_ProgressPercent:SetIndex(0, tostring(math.floor(rate * 100)))
  else
    self.ui.progressFill.fillAmount = MilestoneUtil.GetMilstoneFillRateWithProcessId(rate)
    self.ui.tex_ProgressPercent:SetIndex(0, tostring(math.floor(rate * 100)))
  end
end

function UIMilestoneSheet:_GetNextModuleId(isNext)
  local curId = self._mlstDemitionData:GetMlstDimensionId()
  local nextId = curId + (isNext and -1 or 1)
  nextId = nextId % ConfigData.milestone_module.maxModuleId
  if nextId == 0 then
    nextId = ConfigData.milestone_module.maxModuleId
  end
  return nextId
end

function UIMilestoneSheet:_ChangePage(isNext)
  local nextId = self:_GetNextModuleId(isNext)
  self._mlstDemitionData = self.msData:GetMilestoneDimensionData(nextId)
  self:__RefreshCurPage(true)
  self:RefreshSheetSixPointStar(true, false)
end

function UIMilestoneSheet:_OnClickUp()
  self:_ChangePage(false)
end

function UIMilestoneSheet:_OnClickDown()
  self:_ChangePage(true)
end

function UIMilestoneSheet:_OnClickQuickCheck()
  if self.mlstTaskOverview == nil then
    self.mlstTaskOverview = UINMlstTaskOverview.New()
    self.mlstTaskOverview:Init(self.ui.taskOverviewNode)
  end
  self.mlstTaskOverview:Show()
  self.mlstTaskOverview:InitMlstTaskOverview(self.msData, self._mlstDemitionData)
end

function UIMilestoneSheet:RefreshSheetSixPointStar(rotate, moveAndScale)
  local stageDic, processDic = self.msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic, false)
  if rotate then
    local curId = self._mlstDemitionData:GetMlstDimensionId()
    self.starNode.transform:DOLocalRotate(Vector3.New(0, 0, -30 + curId * -60 + 360), 0.7):SetLink(self.starNode.gameObject):SetEase(cs_Ease.OutQuart)
  end
  if moveAndScale then
    self.starNode.transform:DOMove(self.ui.sixStarPlace.position, 0.55):SetDelay(0.3):SetEase(cs_Ease.OutQuart):SetLink(self.starNode.gameObject)
    self.starNode.transform:DOScale(self.ui.sixStarPlace.localScale.x, 0.55):SetDelay(0.3):SetEase(cs_Ease.OutQuart):SetLink(self.starNode.gameObject)
  end
end

function UIMilestoneSheet:__OnMsDataUpdate()
  local stageDic, processDic = self.msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic, true)
  self:__RefreshTopProcessBar(true)
  self._mlstLeftNode:InitMilestoneSheetLeft(self._mlstDemitionData, self.__ShowMilestoneStageUpNotice)
  self._mlstBandNode:OnMsBandDataUpdate()
end

function UIMilestoneSheet:ShowMilestoneStageUpNotice()
  if self._mlstDemitionData:IsMlstDimensionScoreMax() then
    return
  end
  self._upgradeNoticeNode:Show()
  self._upgradeNoticeNode:ShowStageUp(self._mlstDemitionData)
end

function UIMilestoneSheet:ShowMlstModuleExpChangeNotice(oldProcess)
  self._upgradeNoticeNode:Show()
  self._upgradeNoticeNode:ShowMlstModuleExpChange(self.msData, self._mlstDemitionData, oldProcess)
end

function UIMilestoneSheet:PickMlstTaskReward(taskData)
  local oldProcess = self._mlstDemitionData:GetMlstDimensionScoreProgress()
  local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtr:SendCommitQuestReward(taskData, true, nil, function()
    self:ShowMlstModuleExpChangeNotice(oldProcess)
  end)
end

function UIMilestoneSheet:PickMlstTaskDicReward(taskIdDic)
  local oldProcess = self._mlstDemitionData:GetMlstDimensionScoreProgress()
  local taskctl = ControllerManager:GetController(ControllerTypeId.Task, true)
  taskctl:SendOneKeyPick(taskIdDic, nil, function()
    self:ShowMlstModuleExpChangeNotice(oldProcess)
  end)
end

function UIMilestoneSheet:ShowMilstBandStageReward(bandData)
  if self._bandStageRewardNode == nil then
    self._bandStageRewardNode = UINMlstShetRewardStage.New()
    self._bandStageRewardNode:Init(self.ui.rewardSatgeWindow)
  end
  self._bandStageRewardNode:Show()
  self._bandStageRewardNode:InitMlstShetRewardStage(bandData)
end

function UIMilestoneSheet:_OnClickReturn()
  self:Delete()
end

function UIMilestoneSheet:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.milestoneDataUpdate, self.__onMsDataUpdate)
  TimerManager:StopTimer(self.__changePageTimer)
  self._mlstLeftNode:Delete()
  self._mlstTaskNode:Delete()
  self._mlstBandNode:Delete()
  self.starNode:Delete()
  self._upgradeNoticeNode:Delete()
  if self.mlstTaskOverview then
    self.mlstTaskOverview:Delete()
  end
  if self._bandStageRewardNode then
    self._bandStageRewardNode:Delete()
  end
  if self._resloader then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.OnDelete(self)
end

return UIMilestoneSheet
