_class("UIN5BattleFieldStageInfo", UIController)
UIN5BattleFieldStageInfo = UIN5BattleFieldStageInfo

function UIN5BattleFieldStageInfo:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._totalWave = 0
  self._totalMilitaryExploit = 0
  self._todayWave = 0
  self._todayMilitaryExploit = 0
  self._tempTotalWave = 0
  self._tempTotalMilitaryExploit = 0
  self._tempTodayWave = 0
  self._tempTodayMilitaryExploit = 0
  self._tempTotalWaveDelta = 0
  self._tempTotalMilitaryExploitDelta = 0
  self._tempTodayWaveDelta = 0
  self._tempTodayMilitaryExploitDelta = 0
end

function UIN5BattleFieldStageInfo:OnShow(uiParams)
  self._cfg_battlefiled = uiParams[1]
  self._cfg_conquest_mission = uiParams[2]
  self._componentInfo = uiParams[3]
  self._cfg_conquest_level_waves = Cfg.cfg_conquest_level_wave({
    LevelID = self._cfg_conquest_mission[1].LevelID
  })
  self:_GetComponents()
  self:_OnValue()
end

function UIN5BattleFieldStageInfo:_GetComponents()
  self._uianim = self:GetGameObject("uianim")
  self._stageName = self:GetUIComponent("UILocalizationText", "StageName")
  self._content = self:GetUIComponent("UIRichText", "Content")
  self._waveValue = self:GetUIComponent("UILocalizationText", "WaveValue")
  self._totalMilitaryExploitValue = self:GetUIComponent("UILocalizationText", "TotalMilitaryExploitValue")
  self._passWaveValue = self:GetUIComponent("UILocalizationText", "PassWaveValue")
  self._todayMilitaryExploitValue = self:GetUIComponent("UILocalizationText", "TodayMilitaryExploitValue")
  self._recommendInfo = self:GetUIComponent("UILocalizationText", "RecommendInfo")
  self._curPassWaveText = self:GetUIComponent("UILocalizationText", "CurPassWaveText")
  self._curMilitaryExploitText = self:GetUIComponent("UILocalizationText", "CurMilitaryExploitText")
  self._recommendPetText = self:GetUIComponent("UILocalizationText", "RecommendPetText")
end

function UIN5BattleFieldStageInfo:_OnValue()
  self._stageName:SetText(StringTable.Get(self._cfg_battlefiled.MissionName))
  self._content:SetText(StringTable.Get(self._cfg_battlefiled.MissionDec))
  self._recommendInfo:SetText(StringTable.Get(self._cfg_conquest_mission[1].RecommendDesc))
  self._curPassWaveText:SetText(StringTable.Get("str_n5_battlefield_battle_pass_wave"))
  self._curMilitaryExploitText:SetText(StringTable.Get("str_n5_battlefield_today_militaryexploit"))
  self._recommendPetText:SetText(StringTable.Get("str_n5_recommend_pet"))
  self._totalWave = self._cfg_conquest_mission[1].WaveCount
  self._totalMilitaryExploit = self:_CalcTotalMilitaryExploit()
  self._todayWave = self._componentInfo.m_battlefield_info.m_challenge_mission_info[self._cfg_battlefiled.CampaignMissionID].wave_index
  self._todayMilitaryExploit = self._componentInfo.m_battlefield_info.m_challenge_mission_info[self._cfg_battlefiled.CampaignMissionID].military_exploit
  self._tempTotalWaveDelta = self._totalWave / App.TargetFrame
  self._tempTotalMilitaryExploitDelta = self._totalMilitaryExploit / App.TargetFrame
  self._tempTodayWaveDelta = self._todayWave / App.TargetFrame
  self._tempTodayMilitaryExploitDelta = self._todayMilitaryExploit / App.TargetFrame
end

function UIN5BattleFieldStageInfo:InfoBtnOnClick(go)
  self:ShowDialog("UIN5BattleFieldEnemyInfo", self._cfg_conquest_mission[1], self._componentInfo)
end

function UIN5BattleFieldStageInfo:BattleBtnOnClick(go)
  local ctx = self._missionModule:TeamCtx()
  ctx:Init(TeamOpenerType.Conquest, {
    self._cfg_conquest_mission[1].MissionID,
    EConquestMissionComponentType.ECONMCT_BATTLEFIELD,
    self._cfg_battlefiled.ComponentID,
    self._componentInfo.m_battlefield_info.m_cur_index,
    self._cfg_conquest_mission[1].LevelID
  })
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams()
end

function UIN5BattleFieldStageInfo:CloseBtnOnClick()
  self:_Close()
end

function UIN5BattleFieldStageInfo:_Close()
  self:CloseDialog()
end

function UIN5BattleFieldStageInfo:_CalcTotalMilitaryExploit()
  local militaryexploit = 0
  if self._cfg_conquest_level_waves then
    for key, value in pairs(self._cfg_conquest_level_waves) do
      if value.WaveIndex <= self._cfg_conquest_mission[1].WaveCount then
        militaryexploit = militaryexploit + value.WaveFirstPassAward[2]
      end
    end
  end
  return militaryexploit
end

function UIN5BattleFieldStageInfo:OnUpdate(deltaTimeMS)
  if self._tempTotalWave == self._totalWave and self._tempTotalMilitaryExploit == self._totalMilitaryExploit and self._tempTodayWave == self._todayWave and self._tempTodayMilitaryExploit == self._todayMilitaryExploit then
    return
  end
  self._tempTotalWave = self:_UpdataText(self._totalWave, self._tempTotalWave, self._tempTotalWaveDelta, self._waveValue)
  self._tempTotalMilitaryExploit = self:_UpdataText(self._totalMilitaryExploit, self._tempTotalMilitaryExploit, self._tempTotalMilitaryExploitDelta, self._totalMilitaryExploitValue)
  self._tempTodayWave = self:_UpdataText(self._todayWave, self._tempTodayWave, self._tempTodayWaveDelta, self._passWaveValue)
  self._tempTodayMilitaryExploit = self:_UpdataText(self._todayMilitaryExploit, self._tempTodayMilitaryExploit, self._tempTodayMilitaryExploitDelta, self._todayMilitaryExploitValue)
end

function UIN5BattleFieldStageInfo:_UpdataText(targetValue, curValue, delta, text)
  if curValue < targetValue then
    curValue = curValue + delta
    if targetValue <= curValue then
      curValue = targetValue
    end
  else
    curValue = targetValue
  end
  text:SetText(math.ceil(curValue))
  return curValue
end
