local UIBattleFail = class("UIBattleFail", UIBaseWindow)
local base = UIBaseWindow
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_MessageCommon = CS.MessageCommon

function UIBattleFail:OnShow()
  base.OnShow(self)
  if self.__isIgnoreDelay then
    self.__isIgnoreDelay = false
    return
  end
  if self.ui.canvasGroup == nil then
    return
  end
  self.ui.canvasGroup.interactable = false
  self.ui.canvasGroup.alpha = 0
  local winTween = cs_DoTween.Sequence()
  winTween:Append(self.ui.canvasGroup:DOFade(1, 0.1))
  winTween:AppendCallback(function()
    self.ui.canvasGroup.interactable = true
  end)
  winTween:SetEase(cs_Ease.Linear)
  winTween:SetDelay(2)
  winTween:SetLink(self.gameObject)
end

function UIBattleFail:SetIgnoreDelayFlagOnce(isIgnoreDelay)
  self.__isIgnoreDelay = isIgnoreDelay
end

function UIBattleFail:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_GiveUp, self, self.__OnClickGiveUp)
  UIUtil.AddButtonListener(self.ui.btn_Reload, self, self.__OnClickRestart)
  UIUtil.AddButtonListener(self.ui.btn_Formation, self, self.__OnClickFormation)
  UIUtil.AddButtonListener(self.ui.btn_Statistic, self, self.__ShowBattleStatistic)
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self.__OnClickContinue)
  UIUtil.AddButtonListener(self.ui.btn_Healing, self, self.__OnClickUseHealing)
  UIUtil.AddButtonListener(self.ui.Btn_ChardunHealing, self, self.__OnClickUseHealing)
  UIUtil.AddButtonListener(self.ui.btn_Rewind, self, self.__OnClickTurnRewind)
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleFailExit)
  self._isUnlockBattleExit = isUnlockBattleExit
  if not isUnlockBattleExit then
    self.ui.btn_GiveUp.gameObject:SetActive(false)
  end
  self.ui.tex_Fail:SetIndex(0)
end

function UIBattleFail:InitBattleFail(giveUpBattleFunc, restartFunc, statisticFunc, reviveFunc)
  self.giveUpBattleFunc = giveUpBattleFunc
  self.restartFunc = restartFunc
  self.statisticFunc = statisticFunc
  self.reviveFunc = reviveFunc
  local showLvInfo = false
  if BattleUtil.IsBattleEnableFormation() then
    self.ui.btn_Formation.gameObject:SetActive(true)
    self.ui.tex_Fail:SetIndex(1)
    if BattleDungeonManager.dungeonCtrl ~= nil then
      self.ui.tex_LevelCount.text = LanguageUtil.GetLocaleText(BattleDungeonManager.dungeonCtrl.dungeonCfg.name)
    end
    showLvInfo = true
  end
  if BattleUtil.IsInHGV3NormalDungeon() then
    self.ui.tex_Fail:SetIndex(1)
    if BattleDungeonManager.dungeonCtrl ~= nil then
      self.ui.tex_LevelCount.text = LanguageUtil.GetLocaleText(BattleDungeonManager.dungeonCtrl.dungeonCfg.name)
    end
    showLvInfo = true
    local HGV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
    local heroGrowV3Data = HGV3Ctrl:GetHeroGrowV3Data()
    local itemId, maxNum = heroGrowV3Data:GetHGV3medicineItemId()
    local curNum = PlayerDataCenter:GetItemCount(itemId)
    self.ui.Btn_ChardunHealing.gameObject:SetActive(true)
    self.ui.tex_ChardunHealingCount:SetIndex(0, tostring(curNum))
    if 0 < curNum then
      self.ui.canvasGroup_ChardunHealing.alpha = 1
    else
      self.ui.canvasGroup_ChardunHealing.alpha = 0.4
    end
  end
  local isInExploration = ExplorationManager:IsInExploration()
  self.__hasRestartLimit = isInExploration and ExplorationManager:GetEpModuleId() ~= proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  self.__hasRestartLimit = self.__hasRestartLimit and not BattleUtil.IsInBrotatBattle()
  self.ui.tex_RestartCount.gameObject:SetActive(self.__hasRestartLimit)
  if isInExploration then
    showLvInfo = true
  end
  self.ui.obj_levelInfo:SetActive(showLvInfo)
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  if sectorStageCfg ~= nil then
    local roomData = ExplorationManager.epCtrl.playerCtrl:GetCurrentRoomData()
    if roomData ~= nil then
      local roomType = roomData.type
      local roomTypeCfg = ConfigData.exploration_roomtype[roomType]
      self.ui.tex_LevelCount.text = LanguageUtil.GetLocaleText(roomTypeCfg.title)
      if ExplorationManager.epCtrl:IsCompleteExploration() then
        self.ui.tex_Fail:SetIndex(0)
      else
        self.ui.tex_Fail:SetIndex(1)
      end
    else
      self.ui.tex_LevelCount.gameObject:SetActive(false)
    end
    if self.__hasRestartLimit then
      self.__battleCountLimit = ExplorationManager.epCtrl.battleCtrl:GetEpBattleLastCount()
      self.ui.tex_RestartCount:SetIndex(0, tostring(self.__battleCountLimit))
      if 0 >= self.__battleCountLimit then
        self.ui.cs_Restart.alpha = 0.4
      else
        self.ui.cs_Restart.alpha = 1
      end
    end
  end
end

function UIBattleFail:InitWCBattleFail(battleName, giveUpBattleFunc, continueFunc, restartFunc, statisticFunc)
  self.giveUpBattleFunc = giveUpBattleFunc
  self.continueFunc = continueFunc
  self.restartFunc = restartFunc
  self.statisticFunc = statisticFunc
  self.ui.tex_LevelCount.text = battleName
  self.ui.tex_RetreatTips.gameObject:SetActive(true)
  self.ui.btn_Continue.gameObject:SetActive(true)
  self.ui.tex_RestartCount.gameObject:SetActive(false)
  self.ui.tex_Fail:SetIndex(1)
end

function UIBattleFail:InitWCSeasonBattleFail(battleName, returnBeforeBattleFunc, continueFunc, restartFunc, statisticFunc, reviveFunc)
  self.returnBeforeBattleFunc = returnBeforeBattleFunc
  self.continueFunc = continueFunc
  self.restartFunc = restartFunc
  self.statisticFunc = statisticFunc
  self.reviveFunc = reviveFunc
  self.ui.tex_LevelCount.text = battleName
  self.ui.tex_RetreatTips.gameObject:SetActive(true)
  self.ui.tex_RestartCount.gameObject:SetActive(false)
  self.ui.tex_Fail:SetIndex(1)
  self.ui.img_FailBG:SetIndex(1)
  self.ui.img_continue_FailBG:SetIndex(1)
  self.ui.btn_GiveUp.gameObject:SetActive(false)
  self.ui.btn_Continue.gameObject:SetActive(true)
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  local spitemCfg = WarChessSeasonManager:GetWcSSpItemConfigByLogicType(eWarChessEnum.WCSpecialItemLogicType.healing)
  if spitemCfg ~= nil and spitemCfg.is_show_in_battle then
    self.ui.btn_Healing.gameObject:SetActive(true)
    local healingItemId, healingCount = WarChessSeasonManager:GetWcSSpItemByLogicType(eWarChessEnum.WCSpecialItemLogicType.healing)
    local itemCfg = ConfigData.item[healingItemId]
    local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    self.ui.tex_Name_Healing.text = itemName
    if healingCount >= spitemCfg.ex_arg2[2] then
      self.ui.tex_Count_Healing:SetIndex(0, tostring(healingCount))
      self.ui.canvasGroup_Healing.alpha = 1
    else
      self.ui.tex_Count_Healing:SetIndex(1, itemName)
      self.ui.canvasGroup_Healing.alpha = 0.4
    end
  end
  self.ui.btn_Rewind.gameObject:SetActive(true)
  local warchessCtrl = WarChessManager:GetWarChessCtrl()
  local _, rewindCount = warchessCtrl.turnCtrl:GetWCRewindTimes()
  if rewindCount == 0 then
    self.ui.canvasGroup_Rewind.alpha = 0.4
    self.ui.tex_Count_Rewind.gameObject:SetActive(true)
  else
    self.ui.canvasGroup_Rewind.alpha = 1
    self.ui.tex_Count_Rewind.gameObject:SetActive(false)
  end
end

function UIBattleFail:HideBattleReviewBtn()
  self.ui.btn_Rewind.gameObject:SetActive(false)
end

function UIBattleFail:SetBattleGiveupAcitve(active)
  self.ui.btn_GiveUp.gameObject:SetActive(active and self._isUnlockBattleExit)
end

function UIBattleFail:SetBattleFailEnterFmtFunc(enterFmtFunc)
  self.enterFmtFunc = enterFmtFunc
end

function UIBattleFail:__OnClickGiveUp()
  if self.giveUpBattleFunc ~= nil then
    self.giveUpBattleFunc()
  end
  AudioManager:PlayAudioById(1082)
  self:Delete()
end

function UIBattleFail:__OnClickRestart()
  if self.__hasRestartLimit and self.__battleCountLimit <= 0 then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(171))
    return
  end
  AudioManager:PlayAudioById(1084)
  if self.restartFunc ~= nil then
    self.restartFunc()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
end

function UIBattleFail:__OnClickFormation()
  local function applyFunc()
    if self.enterFmtFunc ~= nil then
      self.enterFmtFunc()
    end
    self:Hide()
    UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
    UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
  end
  
  local inDailyDungeon = BattleUtil.IsInDailyDungeon()
  if inDailyDungeon and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeonQuick) then
    local battleDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    if not PlayerDataCenter:IsDungeonModuleOpenQuick(battleDyncElem.moduleId) and not battleDyncElem:IsFailInDgBattle() then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(9308), function()
        applyFunc()
      end, nil)
      return
    end
  end
  applyFunc()
end

function UIBattleFail:__ShowBattleStatistic()
  if self.statisticFunc ~= nil then
    self.statisticFunc()
  end
end

function UIBattleFail:__OnClickContinue()
  if self.continueFunc ~= nil then
    self.continueFunc()
  end
end

function UIBattleFail:__OnClickUseHealing()
  if self.reviveFunc ~= nil then
    self.reviveFunc()
  end
end

function UIBattleFail:__OnClickTurnRewind()
  if self.returnBeforeBattleFunc ~= nil then
    self.returnBeforeBattleFunc()
  end
end

function UIBattleFail:OnDelete()
  base.OnDelete(self)
  self.__isIgnoreDelay = false
end

return UIBattleFail
