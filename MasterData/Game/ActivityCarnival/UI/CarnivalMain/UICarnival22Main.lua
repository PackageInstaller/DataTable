local UICarnival22Main = class("UICarnival22Main", UIBaseWindow)
local base = UIBaseWindow
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")
local UINCarnivalNewUnlock = require("Game.ActivityCarnival.UI.CarnivalMain.UINCarnivalNewUnlock")
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UICarnival22Main:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickDifficulty)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickTask)
  UIUtil.AddButtonListener(self.ui.btn_Choose, self, self.OnClickDifficulty)
  UIUtil.AddButtonListener(self.ui.btn_Level, self, self._OnClickLevel)
  UIUtil.AddButtonListener(self.ui.btn_Tintensify, self, self.OnClickTech)
  UIUtil.AddButtonListener(self.ui.btn_MiniGame, self, self.OnClickPlayGame)
  UIUtil.AddButtonListener(self.ui.btn_Recall, self, self.OnClickPlotReview)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self.OnClickTicket)
  UIUtil.AddButtonListener(self.ui.btn_Difficult, self, self.OnClickHardDungeon)
  self.__RefreshEnvCallback = BindCallback(self, self.__RefreshEnv)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnivalEnvUnlock, self.__RefreshEnvCallback)
  self.__CarnivalTimePassCallback = BindCallback(self, self.__CarnivalTimePass)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnivalTimePass, self.__CarnivalTimePassCallback)
  self.__UpdateItemCallback = BindCallback(self, self.__UpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__UpdateItemCallback)
  self.__RefreshTaskCallback = BindCallback(self, self.__RefreshTask)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__RefreshTaskCallback)
  self._OnExpLevelChnageFunc = BindCallback(self, self.__RefreshLevel)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnivalExpLevelChange, self._OnExpLevelChnageFunc)
  self.__RefreshRecommePowerCallback = BindCallback(self, self.__RefreshRecommePower)
  self.__UpdateReddotCallback = BindCallback(self, self.__UpdateReddot)
  self.__TryOpenNewUnlockCallback = BindCallback(self, self.__TryOpenNewUnlock)
  self._newUnlockNode = UINCarnivalNewUnlock.New()
  self._newUnlockNode:Init(self.ui.unlock)
  self._newUnlockNode:CarnivalNewUnlockBindFunc(BindCallback(self, self.OnClickPlotReview), BindCallback(self, self.OnClickDifficulty))
  self._newUnlockNode:Hide()
  self._conditionListener = ConditionListener.New()
  self._resloader = CS.ResLoader.Create()
end

function UICarnival22Main:InitCarnivalMain(activityCarnival, enterSectorFunc, closeCallback)
  AudioManager:PlayAudioById(3331)
  self._carnivalData = activityCarnival
  self._carnivalCfg = self._carnivalData:GetCarnivalMainCfg()
  UIUtil.SetTopStateInfoFunc(self, function()
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(self._carnivalCfg.guide_id, nil)
  end)
  self._enterSectorFunc = enterSectorFunc
  self._closeCallback = closeCallback
  local showItemId = self._carnivalCfg.ticket_item
  self.ui.img_res_Icon.sprite = CRH:GetSpriteByItemId(showItemId)
  self.ui.tex_res_Count.text = tostring(PlayerDataCenter:GetItemCount(showItemId))
  self:__RefreshLevel()
  self:__RefreshTask()
  self:__RefreshEnv()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__RefreshTime, self)
  self:__RefreshTime()
  self:__RefreshRecommePower()
  local node = self._carnivalData:GetActivityReddot()
  RedDotController:AddListener(node.nodePath, self.__UpdateReddotCallback)
  self:__UpdateReddot(node)
  if self._carnivalCfg.first_avg > 0 then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(self._carnivalCfg.first_avg)
    if not played and self._carnivalData:IsActivityRunning() then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, self._carnivalCfg.first_avg)
    else
      AudioManager:PlayAudioById(1223)
    end
  end
  self:RefreshCarnivalBtnState()
  local unlock = CheckCondition.CheckLua(self._carnivalCfg.hard_pre_condition, self._carnivalCfg.pre_para1, self._carnivalCfg.pre_para2)
  if not unlock then
    self._conditionListener:AddConditionChangeListener(1, function()
      self:__RefreshBattleBtnState()
    end, self._carnivalCfg.hard_pre_condition, self._carnivalCfg.pre_para1, self._carnivalCfg.pre_para2)
  end
  self:__TryOpenNewUnlock()
  local logoName = "UI_CarnivalLogo_" .. tostring(self._carnivalData:GetActId())
  self.ui.logo.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetCarnivalPic(logoName), function(texture)
    if not IsNull(self.transform) then
      self.ui.logo.texture = texture
      self.ui.logo.gameObject:SetActive(true)
    end
  end)
end

function UICarnival22Main:__RefreshLevel()
  local level, exp = self._carnivalData:GetCarnivalLevelExp()
  local expCfg = self._carnivalData:GetCarnivalExpCfg()
  local needExp = expCfg[level].need_exp
  self.ui.tex_Lv:SetIndex(0, tostring(level))
  self.ui.img_level_Fill.fillAmount = exp / needExp
end

function UICarnival22Main:__RefreshTime()
  local nextTime = self._carnivalData:GetCarnivalTaskNextTm()
  local diff = nextTime - PlayerDataCenter.timestamp
  if 3600 < diff then
    local h = math.floor(diff / 3600)
    local m = math.floor(diff % 3600 / 60)
    self.ui.tex_task_Time:SetIndex(0, tostring(h), tostring(m))
  elseif 60 < diff then
    local m = math.floor(diff / 60)
    self.ui.tex_task_Time:SetIndex(1, tostring(m))
  else
    self.ui.tex_task_Time:SetIndex(1, "0")
  end
  if self._showEndTime == nil or self._showEndTime < PlayerDataCenter.timestamp then
    local titleIndex = 0
    self._showEndTime = self._carnivalData:GetActivityEndTime()
    if self._showEndTime < PlayerDataCenter.timestamp then
      self._showEndTime = self._carnivalData:GetActivityDestroyTime()
      titleIndex = 1
    end
    local timeTable = TimeUtil:TimestampToDate(self._showEndTime, false, true)
    self.ui.tex_act_Time:SetIndex(0, string.format("%02d", timeTable.month), string.format("%02d", timeTable.day), string.format("%02d", timeTable.hour), string.format("%02d", timeTable.min))
    self.ui.tex_endTimeTitle:SetIndex(titleIndex)
  end
  diff = self._showEndTime - PlayerDataCenter.timestamp
  local day = math.floor(diff / 86400)
  self.ui.tex_day:SetIndex(0, tostring(day))
end

function UICarnival22Main:__RefreshTask()
  local taskDic = self._carnivalData:GetCarnivalTask()
  local totalCount = 0
  local completeCount = 0
  for taskId, _ in pairs(taskDic) do
    totalCount = totalCount + 1
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData == nil then
      completeCount = completeCount + 1
    end
  end
  self.ui.tex_task_Process:SetIndex(0, tostring(completeCount), tostring(totalCount))
end

function UICarnival22Main:__UpdateItem(itemUpdate)
  local showItemId = self._carnivalCfg.ticket_item
  if itemUpdate[showItemId] == nil then
    return
  end
  self.ui.tex_res_Count.text = tostring(PlayerDataCenter:GetItemCount(showItemId))
end

function UICarnival22Main:__RefreshEnv()
  local unlockDic = self._carnivalData:GetCarnivalUnlockEnv()
  local maxEnv = #self._carnivalData:GetCarnivalEnvCfg()
  self.ui.tex_DifficultyCN:SetIndex(0, tostring(table.count(unlockDic)), tostring(maxEnv))
  self:__RefreshRecommePower()
  local curStageCfg = self._carnivalData:GetCarnivalEpStageCfg()
  local unComplete = SectorStageDetailHelper.IsSectorHasUnComplete(curStageCfg.sector)
  self.ui.obj_Continue:SetActive(unComplete)
  self.ui.obj_Go:SetActive(not unComplete)
end

function UICarnival22Main:__RefreshRecommePower()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local envId, diffculty = saveUserData:GetCarnivalDiffEnv(self._carnivalCfg.id)
  local stageCfg = self:__GetStageByEnvAndDiffculty(envId, diffculty)
  local recommenPower = stageCfg.combat
  self.ui.tex_Recommend.text = tostring(recommenPower)
end

function UICarnival22Main:__GetStageByEnvAndDiffculty(envId, diffculty)
  if envId == nil or diffculty == nil then
    local envCfgs = self._carnivalData:GetCarnivalEnvCfg()
    envId = envCfgs[1].id
    diffculty = 1
  end
  local envCfg = self._carnivalData:GetCarnivalEnvCfgById(envId)
  if envCfg == nil then
    error("envCfg is NIL  id is " .. tostring(envId))
    return nil
  end
  local stageId = envCfg.stage_id[diffculty]
  if stageId == nil then
    error("stageId is NIL, envId is " .. tostring(envId) .. " diffculty is " .. tostring(diffculty))
    return nil
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    error("stageCfg is NIL, envId is " .. tostring(envId) .. " diffculty is " .. tostring(diffculty) .. " stageId is " .. tostring(stageId))
    return nil
  end
  return stageCfg
end

function UICarnival22Main:__CarnivalTimePass()
  self:__RefreshTask()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__RefreshTime, self)
  self:__RefreshTime()
end

function UICarnival22Main:__UpdateReddot(node)
  local taskNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Task)
  local taskPeriodNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.TaskPeriod)
  local rewardNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Reward)
  local unlockEnvNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
  local unlockStageNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockStage)
  local techNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Tech)
  local hardDunNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockHardDun)
  local autoTechNode = node:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.AutoTech)
  local taskRedCount = taskNode ~= nil and taskNode:GetRedDotCount() or 0
  local taskPeriodRedCount = taskPeriodNode ~= nil and taskPeriodNode:GetRedDotCount() or 0
  local rewardRedCount = rewardNode ~= nil and rewardNode:GetRedDotCount() or 0
  local unlockEnvRedCount = unlockEnvNode ~= nil and unlockEnvNode:GetRedDotCount() or 0
  local unlockStageRedCount = unlockStageNode ~= nil and unlockStageNode:GetRedDotCount() or 0
  local techRedCount = techNode ~= nil and techNode:GetRedDotCount() or 0
  local hardDunRedCount = hardDunNode ~= nil and hardDunNode:GetRedDotCount() or 0
  local autoTechCount = autoTechNode ~= nil and autoTechNode:GetRedDotCount() or 0
  self.ui.task_redDot:SetActive(0 < taskRedCount)
  self.ui.task_blueDot:SetActive(taskRedCount == 0 and 0 < taskPeriodRedCount)
  self.ui.reward_redDot:SetActive(0 < rewardRedCount)
  self.ui.env_redDot:SetActive(0 < unlockEnvRedCount)
  self.ui.review_blueDot:SetActive(0 < unlockStageRedCount)
  self.ui.tech_blueDot:SetActive(0 < techRedCount and autoTechCount == 0)
  self.ui.tech_redDot:SetActive(0 < autoTechCount)
  self.ui.hard_blueDot:SetActive(0 < hardDunRedCount)
end

function UICarnival22Main:CarnivalReEnterSector(secotrId)
  if secotrId ~= self._carnivalCfg.story_stage and secotrId ~= self._carnivalCfg.main_stage then
    return
  end
  if SectorStageDetailHelper.IsSectorNoCollide(secotrId) then
    if secotrId == self._carnivalCfg.story_stage then
      self:OnClickPlotReview()
    elseif SectorStageDetailHelper.IsSectorHasUnComplete(secotrId) then
      local playModule = SectorStageDetailHelper.SectorPlayMoudle(secotrId)
      SectorStageDetailHelper.ContinueUncompleteStage(playModule)
    end
  end
end

function UICarnival22Main:OnClickHardDungeon()
  if not self._carnivalData:IsActivityRunning() then
    return
  end
  local unlock = CheckCondition.CheckLua(self._carnivalCfg.hard_pre_condition, self._carnivalCfg.pre_para1, self._carnivalCfg.pre_para2)
  if not unlock then
    return
  end
  self:__CancleReddot(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockHardDun)
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22Challenge, function(win)
    if win ~= nil then
      win:InitCarnivalChallenge(self._carnivalData)
    end
  end)
end

function UICarnival22Main:OnClickPlayGame()
  if not self._carnivalData:IsActivityRunning() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22MiniGame, function(win)
    if win ~= nil then
      win:InitCarnivalMiniGame(self._carnivalData)
    end
  end)
end

function UICarnival22Main:OnClickTech()
  if not self._carnivalData:IsActivityRunning() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22StrategyOverview, function(win)
    if win ~= nil then
      win:InitActivityCarnivalTech(self._carnivalData)
    end
  end)
end

function UICarnival22Main:OnClickTask()
  if not self._carnivalData:IsActivityRunning() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22Task, function(win)
    if win ~= nil then
      win:InitCarnivalTask(self._carnivalData, self.__TryOpenNewUnlockCallback)
      self:__CancleReddot(ActivityCarnivalEnum.eActivityCarnivalReddot.TaskPeriod)
    end
  end)
end

function UICarnival22Main:_OnClickLevel()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22Progress, function(win)
    if win == nil then
      return
    end
    win:InitCarnivalProgress(self._carnivalData, self.__TryOpenNewUnlockCallback)
    if self._jumpEnvCallback == nil then
      self._jumpEnvCallback = BindCallback(self, self.__JumpEnv)
      self._jumpSectorStageCallback = BindCallback(self, self.__JumpSectorStage)
    end
    win:BindCarnivalJumpEnvFunc(self._jumpEnvCallback)
    win:BindCarnivalJumpSectorStageFunc(self._jumpSectorStageCallback)
  end)
end

function UICarnival22Main:OnClickPlotReview()
  if not SectorStageDetailHelper.IsSectorNoCollide(self._carnivalCfg.story_stage, true) then
    return
  end
  if self._enterSectorFunc ~= nil then
    self:Hide()
    self._enterSectorFunc(self._carnivalCfg.story_stage, 1, nil, function()
      if not IsNull(self.transform) then
        self:Show()
      end
    end)
  end
end

function UICarnival22Main:OnClickDifficulty()
  if not self._carnivalData:IsActivityRunning() then
    return
  end
  local curStageCfg = self._carnivalData:GetCarnivalEpStageCfg()
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(curStageCfg.sector)
  local unComplete, unStageId = SectorStageDetailHelper.HasUnCompleteStage(playMoudle)
  if unComplete then
    local curStageCfg = self._carnivalData:GetCarnivalEpStageCfg()
    if unStageId ~= curStageCfg.id then
      SectorStageDetailHelper.TryToShowCurrentLevelTips(playMoudle)
    else
      ExplorationManager:ContinueLastExploration()
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22Select, function(win)
    if win ~= nil then
      PlayerDataCenter.sectorStage:SetSelectSectorId(self._carnivalCfg.main_stage)
      win:InitCarnival22Select(self._carnivalData, self.__RefreshRecommePowerCallback)
    end
  end)
end

function UICarnival22Main:OnClickTicket()
  local showItemId = self._carnivalCfg.ticket_item
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  window:ParentWindowType(self:GetUIWindowTypeId())
  window:InitCommonItemDetail(ConfigData.item[showItemId])
end

function UICarnival22Main:__CancleReddot(nodeId)
  local reddot = self._carnivalData:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childNode = reddot:GetChild(nodeId)
  if childNode == nil then
    return
  end
  childNode:SetRedDotCount(0)
end

function UICarnival22Main:__TryOpenNewUnlock()
  self:__RefreshEnv()
  if self._carnivalData:IsExistCarnivalNewunlock() then
    self._newUnlockNode:Show()
    self._newUnlockNode:InitCarnivalNewUnlock(self._carnivalData)
  end
end

function UICarnival22Main:OnClickBack()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil then
    sectorCtrl:PlaySectorBgm()
  end
  if self._closeCallback ~= nil then
    self._closeCallback(false)
  end
  self:Delete()
end

function UICarnival22Main:RefreshCarnivalBtnState()
  local isRuningEnd = not self._carnivalData:IsActivityRunning()
  self.ui.obj_Locked_MiniGame:SetActive(isRuningEnd)
  self.ui.obj_Locked_Tintensify:SetActive(isRuningEnd)
  self.ui.obj_Locked_Battle:SetActive(isRuningEnd)
  self.ui.obj_Locked_Task:SetActive(isRuningEnd)
  self.ui.uI_Carnival22Main_glow:SetActive(not isRuningEnd)
  self:__RefreshBattleBtnState()
end

function UICarnival22Main:__RefreshBattleBtnState()
  local unlock = CheckCondition.CheckLua(self._carnivalCfg.hard_pre_condition, self._carnivalCfg.pre_para1, self._carnivalCfg.pre_para2)
  local isRuningEnd = not self._carnivalData:IsActivityRunning()
  if isRuningEnd then
    self.ui.diffcult_Locked:SetActive(true)
    self.ui.tex_Condition.text = self.ui.tex_Condition_miniGame.text
  elseif not unlock then
    self.ui.diffcult_Locked:SetActive(true)
    local des = CheckCondition.GetUnlockInfoLua(self._carnivalCfg.hard_pre_condition, self._carnivalCfg.pre_para1, self._carnivalCfg.pre_para2)
    self.ui.tex_Condition.text = des
  else
    self.ui.diffcult_Locked:SetActive(false)
  end
end

function UICarnival22Main:__JumpSectorStage(stageId, isAvg)
  if self._enterSectorFunc ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.Carnival22Main)
    self:Hide()
    self._enterSectorFunc(self._carnivalCfg.story_stage, 1, nil, function()
      if not IsNull(self.transform) then
        self:Show()
      end
    end, function()
      local sectorWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
      if sectorWin ~= nil then
        sectorWin:LocationSectorStageItem(stageId, isAvg)
      end
    end)
  end
end

function UICarnival22Main:__JumpEnv(envId)
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.Carnival22Main)
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22Select, function(win)
    if win ~= nil then
      PlayerDataCenter.sectorStage:SetSelectSectorId(self._carnivalCfg.main_stage)
      win:InitCarnival22Select(self._carnivalData, self.__RefreshRecommePowerCallback)
      win:EnterSelectEnv(envId)
    end
  end)
end

function UICarnival22Main:OnDelete()
  self._conditionListener:Delete()
  self._carnivalData:ClearNewUnlockInfo()
  local node = self._carnivalData:GetActivityReddot()
  if node ~= nil then
    RedDotController:RemoveListener(node.nodePath, self.__UpdateReddotCallback)
  end
  base.OnDelete(self)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnivalEnvUnlock, self.__RefreshEnvCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__UpdateItemCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnivalTimePass, self.__CarnivalTimePassCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__RefreshTaskCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnivalExpLevelChange, self._OnExpLevelChnageFunc)
end

return UICarnival22Main
