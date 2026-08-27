local UINavigationBar = class("UINavigationBar", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local NavigationEnum = require("Game.TopStatus.Navigation.NavigationEnum")
local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavigationBranchItem = require("Game.TopStatus.Navigation.UINNavigationBranchItem")
local JumpManager = require("Game.Jump.JumpManager")
local CS_ClientConsts = CS.ClientConsts
local TaskEnum = require("Game.Task.TaskEnum")

function UINavigationBar:OnInit()
  self.__permanent = true
  self.resloader = cs_ResLoader.Create()
  self:__TryFindLeanTouchGo()
  UIUtil.AddButtonListener(self.ui.btn_GoHome, self, self.OnClickReturnCommandRoom)
  UIUtil.AddButtonListener(self.ui.btn_backgroubd, self, self.CloseNavigationBar)
  UIUtil.AddButtonListener(self.ui.btn_GetTaskReward, self, self.OnCliclNaviCollectTaskReward)
  UIUtil.AddButtonListener(self.ui.btn_JumpToTask, self, self.OnClickNaviJump2Task)
  UIUtil.AddButtonListener(self.ui.btn_Mail, self, self.OnClickMail)
  UIUtil.AddButtonListener(self.ui.btn_Setting, self, self.OnCklickSetting)
  UIUtil.AddButtonListener(self.ui.btn_Achievement, self, self.OnCklickAchievement)
  self.__UpdateNaviTaskQucikPreview = BindCallback(self, self.UpdateNaviTaskQucikPreview)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__UpdateNaviTaskQucikPreview)
  self.ui.dotween_frame.onRewind:AddListener(BindCallback(self, self.OnNavigationCloseTweenOver))
  self.branchItemDic = {}
  self:GenAllBranches()
  self.ui.navBranchItem.gameObject:SetActive(false)
  self.redDotFuncDic = {}
  self:InitAchievemenRedDots()
  self:InitMailRedDots()
  self:__InitGameSettingReddot()
end

function UINavigationBar:__TryFindLeanTouchGo()
  if IsNull(self.leanTouchGo) then
    local inst = CS.Lean.Touch.LeanTouch.Instance
    if not IsNull(inst) then
      self.leanTouchGo = inst.gameObject
    else
      self.leanTouchGo = nil
    end
  end
end

function UINavigationBar:OnShow()
  AudioManager:PlayAudioById(1105)
  self.ui.dotween_frame:DORestart()
  self:__TryFindLeanTouchGo()
  if self.leanTouchGo ~= nil then
    self.leanTouchGo:SetActive(false)
  end
  self:UpdateNaviTaskQucikPreview()
  UINNavSpecialUIBase.ResumeSpecialUIBaseTimer()
  self:RefreshCurOpeningUI()
  self:RefreshMailBtnIsUnlock()
  self:RefreshAchievementBtnIsUnlock()
  local topWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  topWin.topGroup:RefreshHomeRedDotFx()
  topWin.topGroup:SetInfoBtnActive(false)
end

function UINavigationBar:OnClickReturnCommandRoom()
  self:CloseNavigationBar(function()
    UIUtil.ReturnHome()
  end)
end

function UINavigationBar:UpdateNaviTaskQucikPreview()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  self.ui.obj_Task:SetActive(isUnlock)
  if not isUnlock then
    return
  end
  local taskData, isTaskCompelete, isPeroid = PlayerDataCenter.allTaskData:GetTaskData4Home()
  self.__quickTaskData = taskData
  self.__quickIsPeroid = isPeroid
  if taskData == nil then
    self.ui.tex_TaskInfo:SetIndex(1)
    self.ui.tex_Progress.text = ""
    self.ui.obj_CanGet:SetActive(false)
    return
  end
  self.ui.obj_CanGet.gameObject:SetActive(isTaskCompelete)
  if self.__quickIsPeroid then
    local infoContent = ""
    local strbase = LanguageUtil.GetLocaleText(ConfigData:GetTipTag(TipTag.questsTag, self.__quickTaskData.stcData.type))
    if not string.IsNullOrEmpty(strbase) then
      infoContent = string.format(strbase, self.__quickTaskData.stcData.id)
    else
      warn("task type is not a period,type:" .. tostring(self.__quickTaskData.stcData.type) .. " local_text_id:" .. tostring(ConfigData.game_config.taskPeroidInfo[self.__quickTaskData.stcData.type]))
    end
    self.ui.tex_TaskInfo:SetIndex(0, infoContent)
    self.ui.tex_Progress.text = ""
  elseif taskData.schedule <= taskData.aim then
    local stepCfg = taskData:GetStepCfg()
    self.ui.tex_TaskInfo:SetIndex(0, taskData:GetTaskFirstStepIntro())
    self.ui.tex_Progress.text = tostring(taskData.schedule) .. "/" .. tostring(taskData.aim)
    return
  end
end

function UINavigationBar:OnCliclNaviCollectTaskReward()
  if self.__quickTaskData == nil then
    return
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task)
  if taskController ~= nil then
    local taskIds = {
      TaskEnum.eTaskType.MainTask,
      TaskEnum.eTaskType.DailyTask,
      TaskEnum.eTaskType.WeeklyTask,
      TaskEnum.eTaskType.LargeActivityTask,
      TaskEnum.eTaskType.HeroActivityTask
    }
    local ids, perodicDic = taskController:GetAllRewards(taskIds)
    if table.count(ids) >= 1 then
      taskController:SendOneKeyPick(ids, function()
        self:UpdateNaviTaskQucikPreview()
      end)
    end
    if table.count(perodicDic) > 0 then
      for type, dic in pairs(perodicDic) do
        taskController:SendCommitTaskPeriodArray(dic, type)
      end
    end
  end
end

function UINavigationBar:OnClickNaviJump2Task()
  JumpManager:Jump(JumpManager.eJumpTarget.DynTask, function(jumpCallback)
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.Task) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.Task)
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      return
    end
    if jumpCallback ~= nil then
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      jumpCallback()
    end
  end, nil, nil, true)
end

function UINavigationBar:GenAllBranches()
  local isFirst = true
  for id, navigation_mainCfg in ipairs(ConfigData.navigation_main) do
    if self.branchItemDic[id] == nil then
      local item = UINNavigationBranchItem.New()
      local go = self.ui.navBranchItem:Instantiate()
      item:Init(go)
      self.branchItemDic[id] = item
    end
    self.branchItemDic[id]:InitNavigationBranchItem(navigation_mainCfg, self.resloader)
    for _, branchBtnItem in pairs(self.branchItemDic[id].branchBtnItemDic) do
      self:InstallSpecialUI4Button(branchBtnItem)
    end
  end
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  local rectSize = self.ui.tran_Rect.sizeDelta
  self.ui.tran_SubRect.sizeDelta = rectSize
  self.ui.tran_Rect.pivot = Vector2.Temp(0, 0.5)
  for k, v in pairs(self.branchItemDic) do
    v:SetIconParent(self.ui.tran_SubRect)
  end
end

function UINavigationBar:RefreshAllBranchItem()
  for _, branchItem in pairs(self.branchItemDic) do
    branchItem:RefreshAllNBB()
  end
end

local SpecialUI4ButtonFuns = {
  [NavigationEnum.eSpecialUILogic.OasisRewardCollect] = function(self, branchBtnItem)
    local UINNavSpeciaOasisCollectReward = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpeciaOasisCollectReward")
    local specItem = UINNavSpeciaOasisCollectReward.GetSpecialUI(branchBtnItem, self.ui.obj_special_resCollect, self.resloader)
    branchBtnItem:AddNavSpecialNode(NavigationEnum.eSpecialUILogic.OasisRewardCollect, specItem)
  end,
  [NavigationEnum.eSpecialUILogic.LotteryMarker] = function(self, branchBtnItem)
    local UINNavSpeciaLotteryMarker = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpeciaLotteryMarker")
    local specItem = UINNavSpeciaLotteryMarker.GetSpecialUI(branchBtnItem, self.ui.obj_special_tips, self.resloader)
    branchBtnItem:AddNavSpecialNode(NavigationEnum.eSpecialUILogic.LotteryMarker, specItem)
  end,
  [NavigationEnum.eSpecialUILogic.SectorActivity] = function(self, branchBtnItem)
    if CS_ClientConsts.IsAudit then
      return
    end
    local UINNavSpecialSectorActivity = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialSectorActivity")
    local specItem = UINNavSpecialSectorActivity.GetSpecialUI(branchBtnItem, self.ui.obj_activitySector, self.resloader)
    branchBtnItem:AddNavSpecialNode(NavigationEnum.eSpecialUILogic.SectorActivity, specItem)
  end
}

function UINavigationBar:InstallSpecialUI4Button(branchBtnItem)
  for index, specialId in ipairs(branchBtnItem:GetAllSpecialIds()) do
    local SpecialUI4ButtonFun = SpecialUI4ButtonFuns[specialId]
    if SpecialUI4ButtonFun ~= nil then
      SpecialUI4ButtonFun(self, branchBtnItem)
    end
  end
end

function UINavigationBar:RefreshCurOpeningUI()
  local topBranchItem
  local topIndex = -1
  for _, branchItem in pairs(self.branchItemDic) do
    for _, branchBtnItems in pairs(branchItem.branchBtnItemDic) do
      branchBtnItems:RefreshIsInThisUI(false)
      local flag, index = UIUtil.CheckIsHaveSpecialMarker(branchBtnItems.navigation_subCfg.marker)
      if flag and topIndex < index then
        topIndex = index
        topBranchItem = branchBtnItems
      end
    end
  end
  if topBranchItem ~= nil then
    topBranchItem:RefreshIsInThisUI(true)
  end
end

function UINavigationBar:InitAchievemenRedDots()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel)
  
  local function redDotFunc(node)
    self.ui.redDot_achievement:SetActive(node:GetRedDotCount() > 0)
  end
  
  redDotFunc(node)
  self.redDotFuncDic[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

function UINavigationBar:RefreshAchievementBtnIsUnlock()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  self.ui.btn_Achievement.gameObject:SetActive(isUnlock)
end

function UINavigationBar:OnCklickAchievement()
  JumpManager:Jump(JumpManager.eJumpTarget.Achieve4System, function(jumpCallback)
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.AchievementSystem) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.AchievementSystem)
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      return
    end
    if jumpCallback ~= nil then
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      jumpCallback()
    end
  end, nil, nil, true)
end

function UINavigationBar:InitMailRedDots()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  
  local function redDotFunc(node)
    self.ui.redDot_mail:SetActive(node:GetRedDotCount() > 0)
  end
  
  redDotFunc(node)
  self.redDotFuncDic[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

function UINavigationBar:RefreshMailBtnIsUnlock()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  self.ui.btn_Mail.gameObject:SetActive(isUnlock)
end

function UINavigationBar:OnClickMail()
  local oringLayoutLevel = UIWindowGlobalConfig[UIWindowTypeID.Mail].LayoutLevel
  UIWindowGlobalConfig[UIWindowTypeID.Mail].LayoutLevel = EUILayoutLevel.High
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    if win ~= nil then
      self:CloseNavigationBar()
      win.ui.background.enabled = false
      win:SetFromWhichUI(nil)
      win:SetUIMailHideCallback(function()
        UIUtil.ReShowTopStatus()
      end)
      UIUtil.HideTopStatus()
    end
    UIWindowGlobalConfig[UIWindowTypeID.Mail].LayoutLevel = oringLayoutLevel
  end)
end

function UINavigationBar:OnCklickSetting()
  local oringLayoutLevel = UIWindowGlobalConfig[UIWindowTypeID.Setting].LayoutLevel
  UIWindowGlobalConfig[UIWindowTypeID.Setting].LayoutLevel = self.__layerID
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    if win ~= nil then
      self:CloseNavigationBar()
      win.ui.background.enabled = false
      win:SetFromWhichUI(nil)
      win:SetUIMailHideCallback(function()
        UIUtil.ReShowTopStatus()
      end)
      win:InitSettingByFrom()
      UIUtil.HideTopStatus()
      UIWindowGlobalConfig[UIWindowTypeID.Setting].LayoutLevel = oringLayoutLevel
    end
  end)
end

function UINavigationBar:__InitGameSettingReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Setting, RedDotStaticTypeId.GameSetting)
  if isOk then
    local function redDotFunc(node)
      self.ui.blueDot_Setting:SetActive(node:GetRedDotCount() > 0)
    end
    
    redDotFunc(node)
    self.redDotFuncDic[redDotFunc] = node
    RedDotController:AddListener(node.nodePath, redDotFunc)
  end
end

function UINavigationBar:CloseNavigationBar(callback)
  AudioManager:PlayAudioById(1106)
  self.ui.dotween_frame:DOPlayBackwards()
  self.isColsingWin = true
  self.closeCallback = callback
end

function UINavigationBar:OnNavigationCloseTweenOver()
  self:Hide()
  if self.closeCallback ~= nil then
    self.closeCallback()
    self.closeCallback = nil
  end
end

function UINavigationBar:OnHide()
  self:__TryFindLeanTouchGo()
  if self.leanTouchGo ~= nil then
    self.leanTouchGo:SetActive(true)
  end
  UINNavSpecialUIBase.PauseSpecialUIBaseTimer()
  local topStatusWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatusWin ~= nil then
    topStatusWin.topGroup:RefreshHomeRedDotFx()
    topStatusWin.topGroup:SetInfoBtnActive(true)
  end
end

function UINavigationBar:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__UpdateNaviTaskQucikPreview)
  UINNavSpecialUIBase:CleanSpecialUIBaseTimer()
  for _, branchIte in pairs(self.branchItemDic) do
    branchIte:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  for redDotFunc, node in pairs(self.redDotFuncDic) do
    RedDotController:RemoveListener(node.nodePath, redDotFunc)
  end
  self.redDotFuncDic = {}
  base.OnDelete(self)
end

return UINavigationBar
