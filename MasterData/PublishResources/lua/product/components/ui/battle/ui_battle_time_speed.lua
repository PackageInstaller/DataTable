_class("UIBattleTimeSpeed", UICustomWidget)
UIBattleTimeSpeed = UIBattleTimeSpeed

function UIBattleTimeSpeed:Constructor()
  self._roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = self._roleModule:GetPstId()
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  self._isLevelPass = enterData:LevelIsPass()
  self._enableExSpeed = false
  self._autoFightEnable = nil
  self._playerPrefsKey = pstId .. BattleConst.TimeSpeedKeyStr
  if not self:IsSpeedBthEnable() then
    self._curTimeSpeedIdx = 1
  else
    self._curTimeSpeedIdx = self:GetPlayerPrefsIndex()
    if self:IsSerialAutoFight() then
      self:SavePlayerTimeSpeed()
    end
  end
  self._btImgName = {
    "thread_junei_btn1",
    "thread_junei_btn2",
    "thread_junei_4xbtn"
  }
end

function UIBattleTimeSpeed:GetPlayerPrefsIndex()
  local ret
  if not self:IsSerialAutoFight() then
    ret = UnityEngine.PlayerPrefs.GetInt(self._playerPrefsKey, 1)
    if ret == table.count(BattleConst.TimeSpeedList) and not self:IsSpeedExBtnEnable() then
      ret = ret - 1
    end
  else
    ret = self:GetSerialAutoFightBattleTimeSpeed()
  end
  return ret
end

function UIBattleTimeSpeed:IsSerialAutoFight()
  local mdSerialFight = self:GetModule(SerialAutoFightModule)
  return mdSerialFight:IsRunning()
end

function UIBattleTimeSpeed:GetSerialAutoFightBattleTimeSpeed()
  return table.count(BattleConst.TimeSpeedList)
end

function UIBattleTimeSpeed:OnShow()
  self.enableFakeInput = true
  self._img = self:GetUIComponent("Image", "img")
  self._atlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  if not self:IsSpeedBthEnable() then
    self._img.color = Color.gray
    return
  end
  self._img.color = Color.white
  self:AttachEvent(GameEventType.BattleTimeSpeed, self.ToggleTimeScale)
end

function UIBattleTimeSpeed:OnHide()
  HelperProxy:GetInstance():SetGameTimeScale(1)
  self:DetachEvent(GameEventType.BattleTimeSpeed, self.ToggleTimeScale)
end

function UIBattleTimeSpeed:FlushTimeScale(ignoreUI)
  local minScale = BattleConst.TimeSpeedList[1]
  local timeScale = BattleConst.TimeSpeedList[self._curTimeSpeedIdx]
  HelperProxy:GetInstance():SetGameTimeScale(timeScale)
  if not ignoreUI then
    local imgName = self._btImgName[self._curTimeSpeedIdx]
    imgName = imgName or self._btImgName[1]
    self._img.sprite = self._atlas:GetSprite(imgName)
  end
  AudioHelperController.SetInnerGameSoundPlaySpeed(timeScale)
end

function UIBattleTimeSpeed:ToggleTimeScale(isReset, ignoreUI)
  if isReset then
    self._curTimeSpeedIdx = self:GetPlayerPrefsIndex()
  else
    self._curTimeSpeedIdx = 1
  end
  self:FlushTimeScale(ignoreUI)
end

function UIBattleTimeSpeed:imgOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleTimeSpeed",
    input = "imgOnClick",
    args = {}
  })
  if not self:IsSpeedBthEnable() then
    ToastManager.ShowToast(StringTable.Get("str_battle_speed_mission_error"))
    return
  end
  local maxSpeedIndex = table.count(BattleConst.TimeSpeedList)
  if not self:IsSpeedExBtnEnable() then
    maxSpeedIndex = BattleConst.Speed2Index
  end
  if maxSpeedIndex > self._curTimeSpeedIdx then
    self._curTimeSpeedIdx = self._curTimeSpeedIdx + 1
  else
    self._curTimeSpeedIdx = 1
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DoubleSpeed, self._curTimeSpeedIdx)
  self:SavePlayerTimeSpeed()
  self:FlushTimeScale()
  GameGlobal.UAReportForceGuideEvent("FightClick", {
    "PlaySpeed",
    self._curTimeSpeedIdx
  }, false, true)
end

function UIBattleTimeSpeed:SavePlayerTimeSpeed()
  UnityEngine.PlayerPrefs.SetInt(self._playerPrefsKey, self._curTimeSpeedIdx)
end

function UIBattleTimeSpeed:ForceDefaultSpeed()
  self._curTimeSpeedIdx = 1
  self:SavePlayerTimeSpeed()
  self:FlushTimeScale()
end

function UIBattleTimeSpeed:IsSpeedExBtnEnable()
  if self._autoFightEnable == nil then
    local match = GameGlobal.GetUIModule(MatchModule)
    local data = match:CheckAutoEnable()
    self._autoFightEnable = data.bEnable
    self._enableExSpeed = match:CheckExSpeedEnable()
  end
  return self._enableExSpeed
end

function UIBattleTimeSpeed:IsSpeedBthEnable()
  local cfg = Cfg.cfg_global.ui_battle_time_speed_mission.TableValue
  if not cfg then
    return false
  end
  local missions = cfg.disableMissionList
  if not missions then
    return false
  end
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  self._isLevelPass = enterData:LevelIsPass()
  if enterData:GetMatchType() == MatchType.MT_Maze then
    self._isLevelPass = true
  end
  if enterData:GetMatchType() ~= MatchType.MT_Mission then
    return true
  end
  local mission = self:GetModule(MissionModule)
  for _, missionID in ipairs(missions) do
    if not mission:IsPassMissionID(missionID) then
      return false
    end
  end
  if self._isLevelPass then
    return true
  end
  local curStageId = enterData:GetMissionCreateInfo().mission_id
  local inDisableList = table.icontains(missions, curStageId)
  return not inDisableList
end
