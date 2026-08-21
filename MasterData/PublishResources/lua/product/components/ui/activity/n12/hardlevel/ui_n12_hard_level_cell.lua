_class("UIN12HardLevelCell", UICustomWidget)
UIN12HardLevelCell = UIN12HardLevelCell

function UIN12HardLevelCell:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UIN12HardLevelCell:OnShow(uiParams)
  self:_GetComponents()
end

function UIN12HardLevelCell:_GetComponents()
  self._levelIcon = self:GetUIComponent("RawImageLoader", "LevelIcon")
  self._scoreValue = self:GetUIComponent("UILocalizationText", "ScoreValue")
  self._levelName = self:GetUIComponent("UILocalizationText", "LevelName")
  self._lockObj = self:GetGameObject("Lock")
  self._lockText = self:GetUIComponent("UILocalizationText", "LockText")
end

function UIN12HardLevelCell:SetData(campaign, levelIndex, levelData, score)
  self._campaign = campaign
  self._levelIndex = levelIndex
  self._levelData = levelData
  self._missionId = self._levelData[levelIndex][1]
  self._unlockTime = self._levelData[levelIndex][2]
  self:RefreshUIInfo(score)
end

function UIN12HardLevelCell:RefreshUIInfo(score)
  self._score = score
  self._levelIcon:LoadImage(HardLevelCellImg[self._levelIndex])
  self._scoreValue:SetText(self._score)
  local cfg = Cfg.cfg_component_challenge_mission({
    CampaignMissionId = self._missionId
  })
  self._levelName:SetText(StringTable.Get(cfg[1].MissionName))
  local remainTime = self._unlockTime - self._svrTimeModule:GetServerTime() * 0.001
  self._lockObj:SetActive(0 < remainTime)
  if 0 < remainTime then
    self._lockText:SetText(StringTable.Get("str_n12_unlock", N12ToolFunctions.GetRemainTime(remainTime)))
  end
end

function UIN12HardLevelCell:LevelIconOnClick(go)
  if not self._lockObj.activeSelf then
    N12ToolFunctions.SetLocalDBInt(N12OperationRecordKey.HardLevelIndex, self._levelIndex)
    self:SwitchState(UIStateType.UIN12HardlLevelInfo)
  end
end
