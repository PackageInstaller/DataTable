_class("UIActivityExploreBuildBossData", Object)
UIActivityExploreBuildBossData = UIActivityExploreBuildBossData

function UIActivityExploreBuildBossData:Constructor(cfg)
  self._name = StringTable.Get(cfg.BossName)
  self._spine = cfg.Spine
  self._idleAnim = cfg.IdleAnim
  self._unlockAnim = cfg.UnLockAnim
  self._disappearAnim = cfg.DisappearAnim
  self._unlockAnimLength = cfg.UnLockAnimLength
  self._disappearAnimLength = cfg.DisappearAnimLength
end

function UIActivityExploreBuildBossData:GetName()
  return self._name
end

function UIActivityExploreBuildBossData:GetSpine()
  return self._spine
end

function UIActivityExploreBuildBossData:GetIdleAnim()
  return self._idleAnim
end

function UIActivityExploreBuildBossData:GetUnlockAnim()
  return self._unlockAnim
end

function UIActivityExploreBuildBossData:GetDisappearAnim()
  return self._disappearAnim
end

function UIActivityExploreBuildBossData:GetUnlockAnimLength()
  return self._unlockAnimLength
end

function UIActivityExploreBuildBossData:GetDisappearAnimLength()
  return self._disappearAnimLength
end

_class("UIActivityExploreLevelData", Object)
UIActivityExploreLevelData = UIActivityExploreLevelData

function UIActivityExploreLevelData:Constructor(missionId, component, componentInfo, isHard)
  self._isHard = isHard
  self._component = component
  self._componentInfo = componentInfo
  self._missionId = missionId
  self._isComplete = self._componentInfo.m_pass_mission_info[self._missionId] ~= nil
  local cmpID = self._component:GetComponentCfgId()
  local lineMissionCfgs = Cfg.cfg_component_line_mission({
    ComponentID = cmpID,
    CampaignMissionId = self._missionId
  })
  local lineMissionCfg = lineMissionCfgs[1]
  self._isOpen = true
  local needMissionId = lineMissionCfg.NeedMissionId
  if needMissionId ~= nil and 0 < needMissionId then
    self._isOpen = self._componentInfo.m_pass_mission_info[needMissionId] ~= nil
    local needMissionCfg = Cfg.cfg_campaign_mission[needMissionId]
    local missionName = StringTable.Get(needMissionCfg.Name)
    self._tips = StringTable.Get("str_n33_level_lock_tips", missionName)
  end
  local missionCfg = Cfg.cfg_campaign_mission[self._missionId]
  self._name = StringTable.Get(missionCfg.Name)
  self._star = 0
  local passInfo = self._componentInfo.m_pass_mission_info[self._missionId]
  if passInfo then
    local module = GameGlobal.GetModule(MissionModule)
    self._star = module:ParseStarInfo(passInfo.star)
    if self._isHard then
      self._star = 1
    end
  end
  self._totalStar = 3
  if self._isHard then
    self._totalStar = 1
  end
  self._levelType = missionCfg.Type
  if self._levelType == DiscoveryStageType.Plot then
    self._totalStar = 0
  end
  self._boss = nil
  if self._levelType == DiscoveryStageType.FightBoss then
    local cfg = Cfg.cfg_n33_boss[self._missionId]
    if cfg then
      self._boss = UIActivityExploreBuildBossData:New(cfg)
    end
  end
end

function UIActivityExploreLevelData:IsHard()
  return self._isHard
end

function UIActivityExploreLevelData:GetTips()
  return self._tips
end

function UIActivityExploreLevelData:GetComponent()
  return self._component
end

function UIActivityExploreLevelData:GetComponentInfo()
  return self._componentInfo
end

function UIActivityExploreLevelData:GetMissionId()
  return self._missionId
end

function UIActivityExploreLevelData:GetTotalStar()
  return self._totalStar
end

function UIActivityExploreLevelData:GetStar()
  return self._star
end

function UIActivityExploreLevelData:GetLevelType()
  return self._levelType
end

function UIActivityExploreLevelData:IsOpen()
  return self._isOpen
end

function UIActivityExploreLevelData:IsComplete()
  return self._isComplete
end

function UIActivityExploreLevelData:GetName()
  return self._name
end

function UIActivityExploreLevelData:GetBoss()
  return self._boss
end

_class("UIActivityExploreBuildData", Object)
UIActivityExploreBuildData = UIActivityExploreBuildData

function UIActivityExploreBuildData:Constructor(cfg, component, componentInfo, lockIcon, openIcon, selectIcon, isHard)
  self._isHard = isHard
  self._component = component
  self._componentInfo = componentInfo
  self._lockIcon = lockIcon
  self._openIcon = openIcon
  self._selectIcon = selectIcon
  self._buildId = cfg.ArchitectureId
  self._name = StringTable.Get(cfg.Name)
  self._des = StringTable.Get(cfg.Des)
  self._buildUnLockAnimationLength = cfg.BuildUnLockAnimLength
  self._missions = {}
  if cfg.MissionIds then
    for i = 1, #cfg.MissionIds do
      self._missions[#self._missions + 1] = UIActivityExploreLevelData:New(cfg.MissionIds[i], self._component, self._componentInfo, self._isHard)
    end
  end
  self._lockMissionId = cfg.BuildLockMissionId
  if not self._lockMissionId then
    self:PlayOpenAnim()
  end
  self._position = Vector2(cfg.Position[1], cfg.Position[2])
end

function UIActivityExploreBuildData:GetBuildUnlockAnimationLength()
  return 700
end

function UIActivityExploreBuildData:GetLockIcon()
  return self._lockIcon
end

function UIActivityExploreBuildData:GetOpenIcon()
  return self._openIcon
end

function UIActivityExploreBuildData:GetSelectIcon()
  return self._selectIcon
end

function UIActivityExploreBuildData:BuildId()
  return self._buildId
end

function UIActivityExploreBuildData:GetName()
  return self._name
end

function UIActivityExploreBuildData:GetDes()
  return self._des
end

function UIActivityExploreBuildData:GetMissions()
  return self._missions
end

function UIActivityExploreBuildData:GetPosition()
  return self._position
end

function UIActivityExploreBuildData:IsOpen()
  if self._lockMissionId == nil or self._lockMissionId <= 0 then
    return true
  end
  return self._componentInfo.m_pass_mission_info[self._lockMissionId] ~= nil
end

function UIActivityExploreBuildData:TotalStar()
  local totalStar = 0
  for i = 1, #self._missions do
    local mission = self._missions[i]
    if mission:IsOpen() then
      totalStar = totalStar + self._missions[i]:GetTotalStar()
    end
  end
  return totalStar
end

function UIActivityExploreBuildData:GetStar()
  local star = 0
  for i = 1, #self._missions do
    star = star + self._missions[i]:GetStar()
  end
  return star
end

function UIActivityExploreBuildData:GetCanPlayOpenAnim()
  if self:IsOpen() and self:HasPlayOpenAnim() == false then
    return true
  end
  return false
end

function UIActivityExploreBuildData:GetCanPlayDiappearAnimBoss()
  for i = 1, #self._missions do
    local mission = self._missions[i]
    if mission:GetBoss() ~= nil and mission:IsOpen() and mission:IsComplete() and self:HasPlayDisappearAnim(mission:GetMissionId()) == false then
      return mission
    end
  end
  return nil
end

function UIActivityExploreBuildData:GetCanPlayEnterAnimBoss()
  for i = 1, #self._missions do
    local mission = self._missions[i]
    if mission:GetBoss() ~= nil and mission:IsOpen() and mission:IsComplete() == false and self:HasPlayEnterAnim(mission:GetMissionId()) == false then
      return mission
    end
  end
  return nil
end

function UIActivityExploreBuildData:GetCurrentLevel()
  for i = 1, #self._missions do
    local mission = self._missions[i]
    if mission:IsOpen() == true and mission:IsComplete() == false then
      return mission
    end
  end
  return nil
end

function UIActivityExploreBuildData:IsCurrentBuild()
  local currentLevel = self:GetCurrentLevel()
  return currentLevel ~= nil
end

function UIActivityExploreBuildData:HasPlayOpenAnim()
  local key = self:GetOpenAnimSaveKey()
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return false
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 1
end

function UIActivityExploreBuildData:PlayOpenAnim()
  local key = self:GetOpenAnimSaveKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIActivityExploreBuildData:HasPlayEnterAnim(missionId)
  local key = self:GetEnterBossSaveKey(missionId)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return false
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 1
end

function UIActivityExploreBuildData:PlayEnterAnim(missionId)
  local key = self:GetEnterBossSaveKey(missionId)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIActivityExploreBuildData:HasPlayDisappearAnim(missionId)
  local key = self:GetDisappearBossSaveKey(missionId)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return false
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 1
end

function UIActivityExploreBuildData:PlayDisappearAnim(missionId)
  local key = self:GetDisappearBossSaveKey(missionId)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIActivityExploreBuildData:GetDisappearBossSaveKey(missionId)
  return self:GetCustomFlagKey("BOSS_DISAPPEAR_KEY_" .. missionId)
end

function UIActivityExploreBuildData:GetEnterBossSaveKey(missionId)
  return self:GetCustomFlagKey("BOSS_ENTER_KEY_" .. missionId)
end

function UIActivityExploreBuildData:GetOpenAnimSaveKey()
  local buildType = 1
  if self._isHard then
    buildType = 2
  end
  return self:GetCustomFlagKey("OPEN_ANIMATION_ENTER_KEY_" .. self._buildId .. buildType)
end

function UIActivityExploreBuildData:GetCustomFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end
