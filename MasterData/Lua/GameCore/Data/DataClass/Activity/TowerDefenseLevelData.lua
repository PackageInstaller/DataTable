local TowerDefenseLevelData = class("TowerDefenseLevelData")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  JointDrill_StartTiming = "OnEvent_BattleStart",
  JointDrill_MonsterSpawn = "OnEvent_MonsterSpawn",
  JointDrill_BattleLvsToggle = "OnEvent_BattleLvsToggle",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete",
  JointDrill_Gameplay_Time = "OnEvent_JointDrill_Gameplay_Time",
  JointDrill_DamageValue = "OnEvent_GiveUpBattle",
  RestartJointDrill = "OnEvent_RestartJointDrill",
  RetreatJointDrill = "OnEvent_RetreatJointDrill",
  JointDrill_Result = "OnEvent_JointDrill_Result",
  InputEnable = "OnEvent_InputEnable"
}

function TowerDefenseLevelData:ctor()
end

function TowerDefenseLevelData:InitData(nLevelId, tbCharacter, nItemId, nActId)
  self.nLevelId = nLevelId
  self.tbCharacterData = {}
  self.nActId = nActId
  self.tbCharacterId = tbCharacter
  self.nItemId = nItemId
  self.bRestart = false
  self:BindEvent()
end

function TowerDefenseLevelData:Restart()
  self.tbCharacterData = {}
  self.bRestart = true
end

function TowerDefenseLevelData:AddCharacter(nCharacterId, nEntityId)
  local characterData = {
    nCharacterId = nCharacterId,
    nEntityId = nEntityId,
    nLevel = 1,
    tbPotentialList = {},
    nCD = ConfigTable.GetData("TowerDefenseCharacter", nCharacterId).SkillCd // 10000
  }
  self.tbCharacterData[nCharacterId] = characterData
end

function TowerDefenseLevelData:CharacterLevelUp(nCharacterId)
  if self.tbCharacterData[nCharacterId] == nil then
    return
  end
  local nLevel = self.tbCharacterData[nCharacterId].nLevel
  nLevel = math.min(6, nLevel + 1)
  self.tbCharacterData[nCharacterId].nLevel = nLevel
  EventManager.Hit("TowerDefenseChar_levelUp", nCharacterId, self.tbCharacterData[nCharacterId].nLevel)
end

function TowerDefenseLevelData:AddPotential(nCharacterId, nPotentialId)
  if self.tbCharacterData[nCharacterId] == nil then
    return
  end
  local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
  stPerkInfo.perkId = nPotentialId
  stPerkInfo.nCount = 1
  local bChange = false
  if 1 <= #self.tbCharacterData[nCharacterId].tbPotentialList then
    bChange = true
  end
  safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, {stPerkInfo}, nCharacterId, bChange)
  table.insert(self.tbCharacterData[nCharacterId].tbPotentialList, nPotentialId)
  table.sort(self.tbCharacterData[nCharacterId].tbPotentialList, function(a, b)
    return a < b
  end)
end

function TowerDefenseLevelData:RefreshCharSkillCd(nCharacterId, nCD)
  if self.tbCharacterData[nCharacterId] == nil then
    return
  end
  self.tbCharacterData[nCharacterId].nCD = nCD
end

function TowerDefenseLevelData:GetCharSkillCD(nCharacterId)
  if self.tbCharacterData[nCharacterId] == nil then
    return nil
  end
  return self.tbCharacterData[nCharacterId].nCD
end

function TowerDefenseLevelData:GetPotentialByChar(nCharacterId)
  if self.tbCharacterData[nCharacterId] == nil then
    return nil
  end
  return self.tbCharacterData[nCharacterId].tbPotentialList
end

function TowerDefenseLevelData:GetCharacterLevel(nCharacterId)
  if self.tbCharacterData[nCharacterId] == nil then
    return nil
  end
  return self.tbCharacterData[nCharacterId].nLevel
end

function TowerDefenseLevelData:GetCharacterEntityId(nCharacterId)
  if self.tbCharacterData[nCharacterId] == nil then
    return nil
  end
  return self.tbCharacterData[nCharacterId].nEntityId
end

function TowerDefenseLevelData:GetCharacterData(nCharacterId)
  if self.tbCharacterData[nCharacterId] == nil then
    return nil
  end
  return self.tbCharacterData[nCharacterId]
end

function TowerDefenseLevelData:RemoveCharacterPotential(nCharacterId, nLevel)
  if self.tbCharacterData[nCharacterId] == nil then
    return
  end
  local potentialList = self.tbCharacterData[nCharacterId].tbPotentialList
  local cfg = ConfigTable.GetData("TowerDefenseCharacter", nCharacterId)
  if cfg == nil then
    return
  end
  local removePotentialList = cfg["NewPotential" .. tostring(nLevel)]
  local nRemovePotentialId = 0
  for _, nPotentialId in ipairs(removePotentialList) do
    local nIndex = table.indexof(potentialList, nPotentialId)
    if 0 < nIndex then
      nRemovePotentialId = nPotentialId
      table.remove(potentialList, nIndex)
      break
    end
  end
  if 0 < nRemovePotentialId then
    local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
    stPerkInfo.perkId = nRemovePotentialId
    stPerkInfo.nCount = -1
    safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, {stPerkInfo}, nCharacterId, true)
  end
end

function TowerDefenseLevelData:OnEvent_UnloadComplete()
  if not self.bRestart then
    NovaAPI.EnterModule("MainMenuModuleScene", true)
    self:UnBindEvent()
    return
  end
  if self.nLevelId == 0 or self.nLevelId == nil then
    return
  end
  self.bRestart = false
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", self.nLevelId)
  if levelConfig == nil then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefensePanel)
  local sItem = tostring(self.nItemId)
  local sChar = ""
  for index, value in ipairs(self.tbCharacterId) do
    sChar = sChar .. tostring(value)
    if index ~= #self.tbCharacterId then
      sChar = sChar .. ","
    end
  end
  local param = {}
  table.insert(param, sItem)
  table.insert(param, sChar)
  CS.AdventureModuleHelper.EnterTowerDefenseLevel(levelConfig.FloorId, param)
  EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefensePanel, self.nActId, self.nLevelId)
end

function TowerDefenseLevelData:OnEvent_AdventureModuleEnter()
  EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefensePanel, self.nActId, self.nLevelId)
end

function TowerDefenseLevelData:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function TowerDefenseLevelData:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

return TowerDefenseLevelData
