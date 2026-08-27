local UIMilestoneMain = class("UIMilestoneMain", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_Ease = CS.DG.Tweening.Ease
local cs_TweenLoop = CS.DG.Tweening.LoopType
local cs_UnityEngine_Input = CS.UnityEngine.Input
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local UINMilestoneStar = require("Game.MileStone.UI.Common.UINMilestoneStar")
local UIMilestoneMainItem = require("Game.MileStone.UI.Main.UIMilestoneMainItem")
local UIMilestoneMainSideItem = require("Game.MileStone.UI.Main.UIMilestoneMainSideItem")

function UIMilestoneMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.starNode = UINMilestoneStar.New()
  self.starNode:Init(self.ui.uINSixPointStar)
  self.mainLeftItemPool = UIItemPool.New(UIMilestoneMainItem, self.ui.uiNMilestoneMainItem, false)
  self.mainRightItemPool = UIItemPool.New(UIMilestoneMainItem, self.ui.uiNMilestoneMainItem_left, false)
  self.leftSideItemPool = UIItemPool.New(UIMilestoneMainSideItem, self.ui.obj_leftItem, false)
  self.rightSideItemPool = UIItemPool.New(UIMilestoneMainSideItem, self.ui.obj_rightItem, false)
  self.__SetBackClickAction = BindCallback(self, self.OnClickStarPoint)
  self.__OpenMilestoneSheet = BindCallback(self, self.OpenMilestoneSheet)
  self.__onUpdate = BindCallback(self, self.__OnUpdate)
  self.__onMsDataUpdate = BindCallback(self, self.__OnMsDataUpdate)
  MsgCenter:AddListener(eMsgEventId.milestoneDataUpdate, self.__onMsDataUpdate)
  self._OnReddotChangeFunc = BindCallback(self, self._OnReddotChange)
  RedDotController:AddListener(RedDotDynPath.MlstModulePath, self._OnReddotChangeFunc)
  self.gyro = cs_UnityEngine_Input.gyro
  self.gyro.enabled = true
  UpdateManager:AddUpdate(self.__onUpdate)
end

function UIMilestoneMain:InitMilestoneMain(msData, closeCallback)
  self.msData = msData
  self.closeCallback = closeCallback
  self.resloader = cs_ResLoader.Create()
  self.starNode:InitSixPointStar(self.__SetBackClickAction)
  local stageDic, processDic = msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic, false)
  self:RefreshMilestoneItems()
  self:RefreshMilestoneSideInfo()
  self:PlayInitTween()
  GuideManager:TryTriggerGuide(eGuideCondition.InMilestone)
end

function UIMilestoneMain:RefreshMilestoneItems()
  self.mainLeftItemPool:HideAll()
  self.mainRightItemPool:HideAll()
  self._mainItemDic = {}
  for index, posTrans in ipairs(self.ui.posArray) do
    local msModuleId = index
    local item
    if index == 2 or index == 3 then
      item = self.mainRightItemPool:GetOne()
    else
      item = self.mainLeftItemPool:GetOne()
    end
    item.transform:SetParent(posTrans)
    item.transform.localPosition = Vector2.zero
    local MSDData = self.msData:GetMilestoneDimensionData(msModuleId)
    item:InitMilestoneMainItem(MSDData, self.resloader, self.__OpenMilestoneSheet)
    self._mainItemDic[msModuleId] = item
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Milestone, msModuleId)
    if ok then
      self:_OnReddotChange(node)
    end
  end
end

function UIMilestoneMain:RefreshMilestoneSideInfo()
  self.leftSideItemPool:HideAll()
  self.rightSideItemPool:HideAll()
  for index, cfg in ipairs(ConfigData.milestone_mile_profile) do
    if index ~= MilestoneEnum.eMilestoneInfoType.fairyUnlock then
      local item
      if cfg.location == MilestoneEnum.eMilestoneSideType.left then
        item = self.leftSideItemPool:GetOne()
      elseif cfg.location == MilestoneEnum.eMilestoneSideType.right then
        item = self.rightSideItemPool:GetOne()
      end
      item:InitMilestoneMainSideItem(cfg, self.msData)
    end
  end
  self.ui.leftExItem:SetAsLastSibling()
end

function UIMilestoneMain:OnClickStarPoint(msModuleId)
  self:OpenMilestoneSheet(msModuleId)
end

function UIMilestoneMain:OpenMilestoneSheet(msModuleId)
  local MSDData = self.msData:GetMilestoneDimensionData(msModuleId)
  local isSelf = self.msData:GetMSUserInfoData():GetIsSelfUserInfo()
  if not isSelf then
    return
  end
  self.ui.anim_mainAni:Play("UI_MilestoneMain_FadeOut")
  TimerManager:StopTimer(self.__sheetTimer)
  self.__sheetTimer = TimerManager:StartTimer(0.2, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.MilestoneSheet, function(win)
      if win == nil then
        return
      end
      win:InitMilestoneSheet(self.msData, MSDData)
    end)
  end, nil, true)
end

function UIMilestoneMain:GetIsSelfMileStone()
  return self.msData:GetMSUserInfoData():GetIsSelfUserInfo()
end

function UIMilestoneMain:__OnMsDataUpdate()
  local stageDic, processDic = self.msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic, true)
  for _, item in pairs(self.mainLeftItemPool.listItem) do
    item:RefreshMilestoneMainItem()
  end
  for _, item in pairs(self.mainRightItemPool.listItem) do
    item:RefreshMilestoneMainItem()
  end
end

function UIMilestoneMain:_OnReddotChange(node)
  local isSelf = self.msData:GetMSUserInfoData():GetIsSelfUserInfo()
  local moduleId = node.nodeId
  local mainItem = self._mainItemDic[moduleId]
  if mainItem then
    if not isSelf then
      mainItem:ShowMilestoneMainItemBlueDot(false)
      return
    end
    mainItem:ShowMilestoneMainItemBlueDot(node:GetRedDotCount() > 0)
  end
end

function UIMilestoneMain:__OnUpdate()
  if self.__baseRotate == nil then
    local q = self.gyro.attitude
    self.__baseRotate = Quaternion.New(q.x, q.y, q.z, q.w)
  else
    local target = self.gyro.attitude
    target = Quaternion.New(target.x, target.y, target.z, target.w)
    local difference = self.__baseRotate:Inverse() * target
    local eulerDiff = difference:ToEulerAngles()
    difference = difference:SetEuler(eulerDiff.x, eulerDiff.y, 0)
    self.__baseRotate = Quaternion.Slerp(self.__baseRotate, target, 0.1)
    self.ui.lay1.rotation = Quaternion.Slerp(self.ui.lay1.rotation, difference, 0.05)
    self.ui.lay2.rotation = Quaternion.Slerp(self.ui.lay2.rotation, difference, 0.025)
  end
end

function UIMilestoneMain:SetBackClickAction(clickAction)
  self.__clickAction = clickAction
end

function UIMilestoneMain:PlayInitTween()
  TimerManager:StopTimer(self.__animTimer)
  self.__animTimer = TimerManager:StartTimer(1.7, function()
    local X = 30
    for index, item in pairs(self.leftSideItemPool.listItem) do
      local delayTime = 0.1 + index * 0.05
      X = 30 + index * 12
      item.transform:DOLocalMoveX(X, 0.3):SetEase(cs_Ease.OutQuart):SetDelay(delayTime):SetLink(self.gameObject):From()
      item.ui.alpha_uINSideItem:DOFade(0.2, 0.03):From():SetLoops(19, cs_TweenLoop.Restart):SetLink(self.gameObject):SetDelay(0.05)
    end
    for index, item in pairs(self.rightSideItemPool.listItem) do
      X = 280 + index * 12
      local delayTime = 0.1 + index * 0.05
      item.transform:DOLocalMoveX(-X, 0.3):SetEase(cs_Ease.OutQuart):SetDelay(delayTime):SetLink(self.gameObject):From()
      item.ui.alpha_uINSideItem:DOFade(0.2, 0.03):From():SetLoops(19, cs_TweenLoop.Restart):SetLink(self.gameObject):SetDelay(0.05)
    end
  end, nil, true)
end

function UIMilestoneMain:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIMilestoneMain:OnDelete()
  TimerManager:StopTimer(self.__sheetTimer)
  TimerManager:StopTimer(self.__animTimer)
  MsgCenter:RemoveListener(eMsgEventId.milestoneDataUpdate, self.__onMsDataUpdate)
  RedDotController:RemoveListener(RedDotDynPath.MlstModulePath, self._OnReddotChangeFunc)
  if self.starNode ~= nil then
    self.starNode:Delete()
    self.starNode = nil
  end
  self.gyro.enabled = false
  UpdateManager:RemoveUpdate(self.__onUpdate)
  self:OnCloseWin()
  base.OnDelete(self)
end

return UIMilestoneMain
