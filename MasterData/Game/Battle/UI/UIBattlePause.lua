local UIBattlePause = class("UIBattlePause", UIBaseWindow)
local base = UIBaseWindow
local SectorEnum = require("Game.Sector.SectorEnum")
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local cs_MessageCommon = CS.MessageCommon

function UIBattlePause:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_GiveUp, self, self.__OnClickGiveUp)
  UIUtil.AddButtonListener(self.ui.btn_Reload, self, self.__OnClickRestart)
  UIUtil.AddButtonListener(self.ui.btn_GoOn, self, self.__OnClickContinue)
  UIUtil.AddButtonListener(self.ui.btn_Setting, self, self.__OnClickSetting)
  UIUtil.AddButtonListener(self.ui.btn_Interrupt, self, self.__OnClickInterrupt)
  UIUtil.AddButtonListener(self.ui.btn_RestartEp, self, self.__OnClickRestartEp)
  UIUtil.AddButtonListener(self.ui.btn_Intro, self, self.__OnClickIntro)
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    self.ui.btn_GiveUp.gameObject:SetActive(false)
  end
  self.ui.tex_GiveupDes:SetIndex(0)
end

function UIBattlePause:InitBattlePause(giveUpBattleFunc, restartFunc, pauseFunc)
  UIUtil.SetTopStatus(self, self.OnContinue, nil, nil, nil, true)
  self.giveUpBattleFunc = giveUpBattleFunc
  self.restartFunc = restartFunc
  self.pauseFunc = pauseFunc
  self.ui.btn_Intro.gameObject:SetActive(false)
  local isInExploration = ExplorationManager:IsInExploration()
  local isInBrotato = BattleUtil.IsInBrotatBattle()
  self.__hasRestartLimit = isInExploration and ExplorationManager:GetEpModuleId() ~= proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  self.__hasRestartLimit = self.__hasRestartLimit and not isInBrotato
  self.ui.obj_levelInfo:SetActive(isInExploration or WarChessManager:GetIsInWarChess())
  self.ui.tex_RestartCount.gameObject:SetActive(self.__hasRestartLimit)
  local supportInterrupt = BattleUtil.IsSupportInterruptPlay()
  self.ui.btn_Interrupt.gameObject:SetActive(supportInterrupt)
  local enableRestartEpFloor = isInExploration and ExplorationManager.epCtrl.mapData:EnableEpFloorRestart() and ExplorationManager:GetCurLevelIndex() >= 1 and ExplorationManager.epCtrl.battleCtrl:IsBattleBeforeRunning() and not ExplorationManager.epCtrl:GetCurrentRoomData():IsStartRoom()
  self.ui.btn_RestartEp.gameObject:SetActive(enableRestartEpFloor)
  if enableRestartEpFloor then
    local usedNum = ExplorationManager.epCtrl.mapData:GetEpFloorRestartTimes()
    local remainNum = math.max(ConfigData.game_config.epFloorRestartLimitNum - usedNum, 0)
    self.ui.tex_RestartEpCount:SetIndex(0, tostring(remainNum))
    self._restartEpLimit = remainNum <= 0
    self.ui.cs_RestartEp.alpha = self._restartEpLimit and 0.4 or 1
  end
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  if sectorStageCfg ~= nil then
    local msg
    if sectorStageCfg.endlessCfg ~= nil then
      msg = ConfigData:GetEndlessInfoMsg(sectorStageCfg.endlessCfg, sectorStageCfg.endlessCfg.index * 10)
    elseif sectorStageCfg.challengeCfg ~= nil then
      local moduleId = ExplorationManager:GetEpModuleId()
      msg = ConfigData:GetChallengeInfoMsg(moduleId)
    elseif isInBrotato then
      msg = ConfigData:GetSectorName(sectorStageCfg.sector)
    else
      msg = ConfigData:GetSectorInfoMsg(sectorStageCfg.sector, sectorStageCfg.num, sectorStageCfg.difficulty)
    end
    self.ui.tex_LevelCount.text = msg
    self.ui.tex_LevelName.text = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    if self.__hasRestartLimit then
      self.__battleCountLimit = ExplorationManager.epCtrl.battleCtrl:GetEpBattleLastCount()
      self.ui.tex_RestartCount:SetIndex(0, tostring(self.__battleCountLimit))
      if 0 >= self.__battleCountLimit then
        self.ui.cs_Restart.alpha = 0.4
      else
        self.ui.cs_Restart.alpha = 1
      end
    end
    if ExplorationManager.epCtrl:IsCompleteExploration() then
      self.ui.tex_GiveupDes:SetIndex(1)
    else
      self.ui.tex_GiveupDes:SetIndex(0)
    end
  end
  if isInExploration and ExplorationManager.epCtrl.battleCtrl:IsCloseReloadSupport() then
    self:SetAboutBattleUIActive(false)
  else
    self:SetAboutBattleUIActive(true)
  end
  self.transform:SetAsLastSibling()
  local isInDungeonAuto = BattleDungeonManager:InBattleDungeon() and BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode()
  self.ui.tex_GiveupAutoDes.gameObject:SetActive(isInDungeonAuto)
  if isInDungeonAuto then
    self.ui.tex_GiveupAutoDes:SetIndex(0)
  end
  if BattleUtil.IsInWinterChallengeDungeon() then
    self:SetBtPauseWinChanllenge()
  end
  local isInTDBattle = BattleUtil.IsInTDBattle()
  if isInTDBattle and not BattleUtil.IsSpecialTDMode() then
    self:SetBattlePauseIntro(ConfigData.game_config.TDTipsIntroduceId)
  elseif BattleUtil.IsInDailyDungeon() then
    self:SetBattlePauseIntro(PicTipsConsts.DailyDungeon)
  elseif BattleUtil.IsInBrotatBattle() then
    self:SetBattlePauseIntro(BattleUtil.GetGuidTipId())
  end
  if WarChessManager:GetIsInWarChess() then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    local couldEscapeFromBattle = true
    if wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.battle then
      couldEscapeFromBattle = wcCtrl.battleCtrl:GetWCAllowRetreatBattle()
    end
    self.ui.btn_GiveUp.gameObject:SetActive(couldEscapeFromBattle)
    local name, index = WarChessManager:GetLevelNameAndIndex()
    self.ui.tex_LevelCount.text = index
    self.ui.tex_LevelName.text = name
  end
end

function UIBattlePause:SetBattlePauseIntro(introId)
  self._introId = introId
  if 0 < introId then
    self.ui.btn_Intro.gameObject:SetActive(true)
  end
end

function UIBattlePause:SetBtPauseWinChanllenge()
  self:SetBtPauseReturn2HomeFunc(function()
    BattleDungeonManager:InjectBattleExitEvent(nil)
    BattleDungeonManager:RetreatDungeon()
  end, true)
  self.ui.tex_CurScore.gameObject:SetActive(true)
  self.ui.tex_GiveupDes:SetIndex(2)
  self.ui.tex_GiveupAutoDes.gameObject:SetActive(true)
  self.ui.tex_GiveupAutoDes:SetIndex(1)
  local dgLevelData = BattleDungeonManager.dunInterfaceData:GetIDungeonLevelData()
  local score = dgLevelData:GetSctIIChallengeDgScore()
  self.ui.tex_CurScore:SetIndex(0, tostring(score))
  
  function self._customeGiveUpBattleFunc()
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
    if sectorIICtrl == nil then
      return
    end
    sectorIICtrl:ReqSettleActSctIIChallengeDg(dgLevelData, function()
      local dgBattleCtrl = BattleDungeonManager:GetDungeonCtrl()
      if dgBattleCtrl == nil then
        error("dgBattleCtrl == nil")
        self:_GiveUp()
        return
      end
      dgBattleCtrl.battleCtrl:DgTryAddWinterChallengeScoreShow()
      local giveUpFunc = self.giveUpBattleFunc
      dgBattleCtrl:AddDungeonLogic(DungeonConst.LogicType.ExitDungeon, nil, function()
        if giveUpFunc then
          giveUpFunc()
        end
        AudioManager:PlayAudioById(1082)
      end)
      dgBattleCtrl:StartRunNextLogic()
      self:Delete()
    end)
  end
end

function UIBattlePause:__OnClickGiveUp()
  if self._customeGiveUpBattleFunc ~= nil then
    self._customeGiveUpBattleFunc()
    return
  end
  self:_GiveUp()
end

function UIBattlePause:_GiveUp()
  if self.giveUpBattleFunc ~= nil then
    self.giveUpBattleFunc()
  end
  AudioManager:PlayAudioById(1082)
end

function UIBattlePause:__OnClickRestart()
  if self.__hasRestartLimit and self.__battleCountLimit <= 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(171))
    return
  end
  AudioManager:StopSource(eAudioSourceType.VoiceSource)
  AudioManager:PlayAudioById(1084)
  if self.restartFunc ~= nil then
    self.restartFunc()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if win ~= nil then
    win:StopUseChipEffect()
    win.buffList:CleanDropBuff()
  end
  UIUtil.PopFromBackStackByUiTab(self)
end

function UIBattlePause:__OnClickRestartEp()
  if self._restartEpLimit then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(764))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(198), function()
      UIUtil.PopFromBackStackByUiTab(self)
      ExplorationManager:ReqRestartEpFloor()
    end)
  end)
end

function UIBattlePause:OnContinue()
  AudioManager:PlayAudioById(1083)
  if self.pauseFunc ~= nil then
    self.pauseFunc(false)
  end
  self:Hide()
end

function UIBattlePause:__OnClickContinue()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBattlePause:__OnClickSetting()
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    if win ~= nil then
      win:InitSettingByFrom(UIWindowTypeID.BattlePause)
      win:SetUIMailHideCallback(function()
        local battleSkillWindow = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
        if battleSkillWindow ~= nil then
          battleSkillWindow:RefreshUltSkillAutoUltToggle()
        end
      end)
    end
  end)
end

function UIBattlePause:SetBtPauseReturn2HomeFunc(return2HomeFunc, forceOpen)
  self.return2HomeFunc = return2HomeFunc
  if forceOpen then
    self.ui.btn_Interrupt.gameObject:SetActive(true)
  end
end

function UIBattlePause:__OnClickInterrupt()
  if self.return2HomeFunc ~= nil then
    self.return2HomeFunc()
    return
  end
  if not ExplorationManager:IsInExploration() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(197), function()
      UIUtil.PopFromBackStackByUiTab(self)
      ExplorationManager:ExitExploration(Consts.SceneName.Main)
      if Time.unity_time.timeScale ~= 1 then
        Time.unity_time.timeScale = 1
      end
    end)
  end)
end

function UIBattlePause:__OnClickIntro()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(self._introId, nil)
end

function UIBattlePause:SetAboutBattleUIActive(active)
  self.ui.btn_Reload.gameObject:SetActive(active)
  self.ui.tex_RestartCount.gameObject:SetActive(self.__hasRestartLimit and active)
end

function UIBattlePause:OnDelete()
  base.OnDelete(self)
  self.giveUpBattleFunc = nil
  self.restartFunc = nil
  self.pauseFunc = nil
end

return UIBattlePause
