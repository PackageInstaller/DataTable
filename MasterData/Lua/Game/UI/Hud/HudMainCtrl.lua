local AdventureModuleHelper = CS.AdventureModuleHelper
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local ClientManager = CS.ClientManager.Instance
local Time = CS.UnityEngine.Time
local HudSourceGroup = {
  None = 0,
  Master = 1,
  Assist = 2
}
local HudMainCtrl = class("HudMainCtrl", BaseCtrl)
HudMainCtrl._mapNodeConfig = {
  Root = {sNodeName = "Root"},
  DamageNumberRoot = {},
  DamageWordRoot = {},
  BattleTarget = {sComponentName = "Canvas"}
}
HudMainCtrl._mapEventConfig = {
  PlayerShow = "OnEvent_PlayerShowChanged",
  PlayerBloodShow = "OnEvent_PlayerBloodShow",
  ShowBossHUD = "OnEvent_ShowBossHUD",
  MonsterHUDChange = "OnEvent_MonsterHUDChange",
  AllHudShow = "OnEvent_AllHudShowChanged",
  HudDestroy = "OnEvent_HudDestroyed",
  HudDamage = "OnEvent_HudDamaged",
  HudHeal = "OnEvent_HudHealed",
  HudDefence = "OnEvent_HudDefenced",
  HudDotDamage = "OnEvent_HudDotDamage",
  HudBreakScore = "OnEvent_HudBreakOutScore",
  ADVENTURE_LEVEL_END = "OnEvent_LevelEnd",
  NPCShow = "OnEvent_NPCShow",
  TriggerElementMark = "OnEvent_HudMark",
  TestSwitchHudDamage = "OnEvent_SwitchHudDamage",
  TestSwitchHudHpBar = "OnEvent_SwitchHudHpBar",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  CacheInstanceHud = "OnEvent_CacheInstanceHud",
  SpecialHudShow = "OnEvent_HuoChuiBossShow",
  ToughnessStateChangedForGlobal = "OnEvent_ToughnessStateChangedForGlobal",
  ADVENTURE_BATTLE_MONSTER_DECLARE_DIED = "OnEvent_MonsterDeclareDied",
  [EventId.SettingsBattleClose] = "OnEvent_SettingsChanged"
}

function HudMainCtrl:Awake()
end

function HudMainCtrl:OnEnable()
  self.resistanceTipInterval = ConfigTable.GetConfigNumber("HudResistanceTipInterval")
  self.hudMergeInterval = ConfigTable.GetConfigNumber("HudDamageMergeInterval", true) or 1
  self.nHudDamageMode = self:GetHudDamageMode()
  self.mergeHuds = {}
  self.hudId = 0
  self.playerHuds = {}
  self.tbPlayerBloodState = {}
  self.monsterHuds = {}
  self.monsterAdvHuds = {}
  self.numberHuds = {}
  self.npcHuds = {}
  self.specialHuds = {}
  self.nBloodType = 0
  self.tbBossBloodState = {}
  self.nTypeGreyResistanceTime = {}
  self.tabToughnessEntity = {}
  self.tabToughnessEntityVal = {}
  self.tabToughnessHudId = {}
  self.playerHudPrefab = self:LoadAsset("UI/HUD/PlayerHUD.prefab")
  self.monsterHudPrefab = self:LoadAsset("UI/HUD/MonsterHUD.prefab")
  self.monsterHudEpicPrefab = self:LoadAsset("UI/HUD/MonsterHUD_Epic.prefab")
  self.playerSummonerHudPrefab = self:LoadAsset("UI/HUD/MonsterHUD_PlayerSummoner.prefab")
  self.critDamageHudPrefab = self:LoadAsset("UI/HUD/CritDamageHUDNumber_UI.prefab")
  self.dotDamageHudPrefab = self:LoadAsset("UI/HUD/DotDamageHUDNumber_UI.prefab")
  self.damageHudPrefab = self:LoadAsset("UI/HUD/DamageHUDNumber_UI.prefab")
  self.minDamageHUDNumber = self:LoadAsset("UI/HUD/MinDamageHUDNumber_UI.prefab")
  self.healHudPrefab = self:LoadAsset("UI/HUD/HealHUDNumber_UI.prefab")
  self.wordHudPrefab = self:LoadAsset("UI/HUD/WordHud_UI.prefab")
  self.npcHudPrefab = self:LoadAsset("UI/HUD/NpcHud.prefab")
  self.breakOutHudPrefab = self:LoadAsset("UI/HUD/BreakOutHUDNumber_UI.prefab")
  self.damageMergeMasterPrefab = self:LoadAsset("UI/HUD/DamageHUDNumber_UI_Merge_Master.prefab")
  self.damageMergeAssistPrefab = self:LoadAsset("UI/HUD/DamageHUDNumber_UI_Merge_Assist.prefab")
  self.critDamageHudPrefab_Vampire = self:LoadAsset("UI/HUD/CritDamageHUDNumber_UI_Vampire.prefab")
  self.minDamageHUDNumber_Vampire = self:LoadAsset("UI/HUD/MinDamageHUDNumber_UI_Vampire.prefab")
  self.damageHudPrefab_Vampire = self:LoadAsset("UI/HUD/DamageHUDNumber_UI_Vampire.prefab")
  self.critDamageHudPrefab_Soldier = self:LoadAsset("UI/HUD/CritDamageHUDNumber_UI_Soldier.prefab")
  self.toughnessDamageHUD = self:LoadAsset("UI/HUD/ToughnessDamageHUD_UI.prefab")
  self.TEST_VISIBLE_HUD_DAMAGE = true
  local tbParam = self:GetPanelParam()
  self.isVampireInstance = tbParam[1] or false
  local bNotAdventureEnter = tbParam[2]
  self.jointDrillType = tbParam[3]
  self.isSoldierType = tbParam[4] or false
  if not bNotAdventureEnter then
    self._mapNode.BattleTarget.gameObject:SetActive(true)
  end
end

function HudMainCtrl:OnDisable()
  self:Clear()
  self.playerHudPrefab = nil
  self.monsterHudPrefab = nil
  self.monsterHudEpicPrefab = nil
  self.critDamageHudPrefab = nil
  self.dotDamageHudPrefab = nil
  self.damageHudPrefab = nil
  self.damageMergeMasterPrefab = nil
  self.damageMergeAssistPrefab = nil
  self.minDamageHUDNumber = nil
  self.healHudPrefab = nil
  self.wordHudPrefab = nil
  self.npcHudPrefab = nil
  self.breakOutHudPrefab = nil
  self.critDamageHudPrefab_Vampire = nil
  self.minDamageHUDNumber_Vampire = nil
  self.damageHudPrefab_Vampire = nil
  self.critDamageHudPrefab_Soldier = nil
  self.toughnessDamageHUD = nil
end

function HudMainCtrl:OnDestroy()
end

function HudMainCtrl:Clear()
  for _, v in pairs(self.playerHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  for _, v in pairs(self.monsterHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  for _, v in pairs(self.monsterAdvHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  for _, v in pairs(self.numberHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  for _, v in pairs(self.npcHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  for _, v in pairs(self.specialHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  self.hudId = 0
  self.playerHuds = {}
  self.tbPlayerBloodState = {}
  self.monsterHuds = {}
  self.monsterAdvHuds = {}
  self.numberHuds = {}
  self.npcHuds = {}
  self.specialHuds = {}
  self.nBloodType = 0
  self.tbBossBloodState = {}
  self.nTypeGreyResistanceTime = {}
  self.tabToughnessEntity = {}
  self.tabToughnessEntityVal = {}
  self.tabToughnessHudId = {}
  self.mergeHuds = {}
end

function HudMainCtrl:MonsterShowChanged(id, showed, nType, nDataId)
  local monsterHud = self.monsterHuds[id]
  if showed then
    if monsterHud == nil then
      monsterHud = self:SpawnPrefabInstance(self.monsterHudPrefab, "Game.UI.Hud.MonsterHudCtrl", "HUD", self._mapNode.Root)
      monsterHud.gameObject.transform.localScale = Vector3.one
      self.monsterHuds[id] = monsterHud
    end
    if monsterHud ~= nil then
      monsterHud:SetMonsterId(id, nType)
      local height = AdventureModuleHelper.GetEntityMonsterBarHeight(id)
      local offset = Vector3(0, height, 0)
      AdventureModuleHelper.SetHudFollowTarget(id, monsterHud.gameObject, offset, true)
    end
  elseif monsterHud ~= nil then
    self:DespawnPrefabInstance(monsterHud, "HUD")
    self.monsterHuds[id] = nil
  end
end

function HudMainCtrl:MonsterAdvShowChanged(id, showed, nType, nDataId)
  local monsterHud = self.monsterAdvHuds[id]
  local isPlayerSummoner = nType == GameEnum.monsterBloodType.PLAYERSUMMON
  if showed then
    if monsterHud == nil then
      if isPlayerSummoner then
        printLog(tostring(id) .. "player summon")
        monsterHud = self:SpawnPrefabInstance(self.playerSummonerHudPrefab, "Game.UI.Hud.PlayerSummonerHudCtrl", "HUD", self._mapNode.Root)
      else
        printLog(tostring(id) .. "monster")
        monsterHud = self:SpawnPrefabInstance(self.monsterHudEpicPrefab, "Game.UI.Hud.EliteMonsterHudCtrl", "HUD", self._mapNode.Root)
      end
      self.monsterAdvHuds[id] = monsterHud
      monsterHud.gameObject.transform.localScale = Vector3.one
    end
    if monsterHud ~= nil then
      monsterHud:SetMonsterId(id, nDataId, nType)
      local height = AdventureModuleHelper.GetEntityMonsterBarHeight(id)
      local offset = Vector3(0, height, 0)
      AdventureModuleHelper.SetHudFollowTarget(id, monsterHud.gameObject, offset, true)
    end
  elseif monsterHud ~= nil then
    self:DespawnPrefabInstance(monsterHud, "HUD")
    self.monsterAdvHuds[id] = nil
  end
end

function HudMainCtrl:GetHudDamageMode()
  local nMode = LocalSettingData.GetLocalSettingData("HudDamageShow")
  return nMode
end

function HudMainCtrl:IsHudDamageClosed()
  return self.nHudDamageMode == AllEnum.BattleHudDamageSetting.Close
end

function HudMainCtrl:IsHudDamageMerged()
  return self.nHudDamageMode == AllEnum.BattleHudDamageSetting.Merge
end

function HudMainCtrl:GetMergeKey(nEntityId, nFromId)
  local nGroup = AdventureModuleHelper.GetHudDamageSourceGroup(nFromId or 0)
  if nGroup == HudSourceGroup.None then
    return nil, nGroup
  end
  return string.format("%s_%s", tostring(nEntityId), tostring(nGroup)), nGroup
end

function HudMainCtrl:GetMergePrefab(nGroup)
  if nGroup == HudSourceGroup.Assist then
    return self.damageMergeAssistPrefab
  end
  return self.damageMergeMasterPrefab
end

function HudMainCtrl:TryMergeDamage(sKey, nValue, nHudColorIndex)
  local tbMerge = self.mergeHuds[sKey]
  if tbMerge == nil then
    return false
  end
  local hud = self.numberHuds[tbMerge.nHudId]
  if hud == nil then
    self.mergeHuds[sKey] = nil
    return false
  end
  if Time.time - tbMerge.nLastTS > self.hudMergeInterval then
    self.mergeHuds[sKey] = nil
    return false
  end
  tbMerge.nValue = tbMerge.nValue + nValue
  tbMerge.nLastTS = Time.time
  AdventureModuleHelper.RefreshHudValue(hud.gameObject, tbMerge.nValue, nHudColorIndex)
  return true
end

function HudMainCtrl:RecordMergeHud(sKey, nHudId, nValue)
  if sKey == nil then
    return
  end
  self.mergeHuds[sKey] = {
    nHudId = nHudId,
    nValue = nValue,
    nLastTS = Time.time
  }
end

function HudMainCtrl:RemoveMergeHudById(nHudId)
  if self.mergeHuds == nil then
    return
  end
  for sKey, tbMerge in pairs(self.mergeHuds) do
    if tbMerge.nHudId == nHudId then
      self.mergeHuds[sKey] = nil
    end
  end
end

function HudMainCtrl:OnEvent_SettingsChanged()
  local nMode = self:GetHudDamageMode()
  if nMode ~= self.nHudDamageMode then
    self.nHudDamageMode = nMode
    self.mergeHuds = {}
  end
end

function HudMainCtrl:OnEvent_ShowBossHUD(bossId, nType, showed, nDataId, nBloodType)
  self.nBloodType = nBloodType
  showed = showed and self.tbBossBloodState[bossId] == true
  self:MonsterAdvShowChanged(bossId, showed, nType, nDataId)
end

function HudMainCtrl:OnEvent_MonsterHUDChange(id, nType, showed, nDataId)
  if nType == GameEnum.monsterBloodType.BOSSRUSH then
    return
  end
  if nType == GameEnum.monsterBloodType.JOINTDRILLBOSS and (self.jointDrillType == nil or self.jointDrillType == GameEnum.JointDrillMode.JointDrill_Mode_1) then
    return
  end
  if nType == GameEnum.monsterBloodType.SIMPLE or nType == GameEnum.monsterBloodType.SIMPLE2 then
    self:MonsterShowChanged(id, showed, nType, nDataId)
  else
    self.tbBossBloodState[id] = showed
    if showed and (nType == GameEnum.monsterBloodType.BOSS or nType == GameEnum.monsterBloodType.MINIBOSS) and self.nBloodType == AllEnum.BossBloodType.Single then
      showed = false
    end
    self:MonsterAdvShowChanged(id, showed, nType, nDataId)
  end
end

function HudMainCtrl:OnEvent_PlayerShowChanged(id, showed)
  if id == 0 then
    return
  end
  local playerHud = self.playerHuds[id]
  if showed then
    if playerHud == nil then
      playerHud = self:SpawnPrefabInstance(self.playerHudPrefab, "Game.UI.Hud.PlayerHudCtrl", "HUD", self._mapNode.Root)
      self.playerHuds[id] = playerHud
      playerHud.gameObject.transform.localScale = Vector3.one
    end
    if playerHud ~= nil then
      playerHud:SetPlayerId(id)
      AdventureModuleHelper.SetHudFollowTarget(id, playerHud.gameObject, Vector3.zero, false)
      if self.tbPlayerBloodState[id] == false then
        playerHud:SetBloodVisible(false)
      end
    end
  elseif playerHud ~= nil then
    self:DespawnPrefabInstance(playerHud, "HUD")
    self.playerHuds[id] = nil
  end
end

function HudMainCtrl:OnEvent_PlayerBloodShow(id, showed)
  if id == 0 then
    return
  end
  self.tbPlayerBloodState[id] = showed
  local playerHud = self.playerHuds[id]
  if playerHud ~= nil then
    playerHud:SetBloodVisible(showed)
  end
end

function HudMainCtrl:OnEvent_AllHudShowChanged(showed)
  if self.TEST_VISIBLE_HUD_DAMAGE == true then
    self._mapNode.Root.transform.localScale = showed and Vector3.one or Vector3.zero
  else
    self._mapNode.Root.transform.localScale = Vector3.zero
  end
  if self.TEST_VISIBLE_HUD_DAMAGE == true then
    self._mapNode.DamageNumberRoot.transform.localScale = showed and Vector3.one or Vector3.zero
    self._mapNode.DamageWordRoot.transform.localScale = showed and Vector3.one or Vector3.zero
  else
    self._mapNode.DamageNumberRoot.transform.localScale = Vector3.zero
    self._mapNode.DamageWordRoot.transform.localScale = Vector3.zero
  end
  NovaAPI.SetComponentEnable(self._mapNode.BattleTarget, showed)
end

function HudMainCtrl:OnEvent_HudDestroyed(id)
  local hud = self.numberHuds[id]
  if hud ~= nil then
    self:DespawnPrefabInstance(hud, "HUD")
    self.numberHuds[id] = nil
  end
  self:RemoveMergeHudById(id)
end

function HudMainCtrl:OnEvent_HudDamaged(id, value, isCrit, hitDamageConfig, formId, isMark, fromElementType, hudColorIndex)
  if self.tabToughnessEntity[id] then
    self:SetToughnessValue(id, value)
    return
  end
  if self:IsHudDamageClosed() then
    return
  end
  local sMergeKey, nMergeGroup
  if self:IsHudDamageMerged() then
    sMergeKey, nMergeGroup = self:GetMergeKey(id, formId)
    if sMergeKey ~= nil and self:TryMergeDamage(sMergeKey, value, hudColorIndex or 4) then
      self:CheckGreyResistanceTip(id, hudColorIndex)
      return
    end
  end
  local hud
  if sMergeKey ~= nil then
    hud = self:SpawnPrefabInstance(self:GetMergePrefab(nMergeGroup), "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
  elseif hitDamageConfig and hitDamageConfig.IsDenseType then
    if self.isVampireInstance then
      if isCrit then
        hud = self:SpawnPrefabInstance(self.critDamageHudPrefab_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      else
        hud = self:SpawnPrefabInstance(self.minDamageHUDNumber_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      end
    elseif isCrit then
      if self.isSoldierType then
        hud = self:SpawnPrefabInstance(self.critDamageHudPrefab_Soldier, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
        local CritImage_Color2 = hud.gameObject.transform:Find("text/CritImage_Color2").gameObject
        local CritImage_Color3 = hud.gameObject.transform:Find("text/CritImage_Color3").gameObject
        CritImage_Color2:SetActive(hudColorIndex == 2)
        CritImage_Color3:SetActive(hudColorIndex == 3)
      else
        hud = self:SpawnPrefabInstance(self.critDamageHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      end
    else
      hud = self:SpawnPrefabInstance(self.minDamageHUDNumber, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    end
  elseif self.isVampireInstance then
    if isCrit then
      hud = self:SpawnPrefabInstance(self.critDamageHudPrefab_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    else
      hud = self:SpawnPrefabInstance(self.damageHudPrefab_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    end
  elseif isCrit then
    if self.isSoldierType then
      hud = self:SpawnPrefabInstance(self.critDamageHudPrefab_Soldier, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      local CritImage_Color2 = hud.gameObject.transform:Find("text/CritImage_Color2").gameObject
      local CritImage_Color3 = hud.gameObject.transform:Find("text/CritImage_Color3").gameObject
      CritImage_Color2:SetActive(hudColorIndex == 2)
      CritImage_Color3:SetActive(hudColorIndex == 3)
    else
      hud = self:SpawnPrefabInstance(self.critDamageHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    end
  else
    hud = self:SpawnPrefabInstance(self.damageHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
  end
  self.hudId = self.hudId + 1
  local _formId = formId
  if formId == nil then
    _formId = 0
  end
  local _fromElementType = 0
  if fromElementType ~= nil then
    _fromElementType = fromElementType
  end
  local _hudColorIndex = 4
  if hudColorIndex ~= nil then
    _hudColorIndex = hudColorIndex
  end
  local hudHitDamage = hitDamageConfig
  local bHudCrit = isCrit
  if sMergeKey ~= nil then
    hudHitDamage = nil
    bHudCrit = false
  end
  AdventureModuleHelper.SetHudValue(hud.gameObject, id, self.hudId, value, false, hudHitDamage, _formId, bHudCrit, false, _fromElementType, _hudColorIndex)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
  self:RecordMergeHud(sMergeKey, self.hudId, value)
  self:CheckGreyResistanceTip(id, hudColorIndex)
end

function HudMainCtrl:CheckGreyResistanceTip(id, hudColorIndex)
  if hudColorIndex == nil or hudColorIndex ~= 5 then
    return
  end
  if self.nTypeGreyResistanceTime[id] == nil or self.nTypeGreyResistanceTime[id] + self.resistanceTipInterval <= ClientManager.serverTimeStampWithTimeZone then
    self.nTypeGreyResistanceTime[id] = ClientManager.serverTimeStampWithTimeZone
    self:OnEvent_HudDefenced(id, 3)
  end
end

function HudMainCtrl:OnEvent_HudDotDamage(id, value, isCrit, hitDamageConfig, formId, hudColorIndex, fromElementType)
  if self.tabToughnessEntity[id] then
    self:SetToughnessValue(id, value)
    return
  end
  if self:IsHudDamageClosed() then
    return
  end
  local sMergeKey, nMergeGroup
  if self:IsHudDamageMerged() then
    sMergeKey, nMergeGroup = self:GetMergeKey(id, formId)
    if sMergeKey ~= nil and self:TryMergeDamage(sMergeKey, value, hudColorIndex or 4) then
      return
    end
  end
  local bMerge = sMergeKey ~= nil
  local hudPrefab = self.dotDamageHudPrefab
  if bMerge then
    hudPrefab = self:GetMergePrefab(nMergeGroup)
  end
  local hud = self:SpawnPrefabInstance(hudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
  self.hudId = self.hudId + 1
  local _formId = formId
  if formId == nil then
    _formId = 0
  end
  local _fromElementType = 0
  if fromElementType ~= nil then
    _fromElementType = fromElementType
  end
  local hudHitDamage = hitDamageConfig
  local bHudCrit = isCrit
  if bMerge then
    hudHitDamage = nil
    bHudCrit = false
  end
  AdventureModuleHelper.SetHudValue(hud.gameObject, id, self.hudId, value, false, hudHitDamage, _formId, bHudCrit, not bMerge, _fromElementType, hudColorIndex)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
  self:RecordMergeHud(sMergeKey, self.hudId, value)
end

function HudMainCtrl:OnEvent_HudHealed(id, value)
  if self:IsHudDamageClosed() then
    return
  end
  local hud = self:SpawnPrefabInstance(self.healHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
  self.hudId = self.hudId + 1
  AdventureModuleHelper.SetHudValue(hud.gameObject, id, self.hudId, value, true, nil, 0, false, false)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

function HudMainCtrl:OnEvent_HudBreakOutScore(id, value)
  local nWordType = 1
  local hud = self:SpawnPrefabInstance(self.breakOutHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageWordRoot)
  self.hudId = self.hudId + 1
  local Value = string.format("+%s", value)
  AdventureModuleHelper.SetHudStringValue(hud.gameObject, id, self.hudId, Value, nWordType, false)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

function HudMainCtrl:OnEvent_HudDefenced(id, valueType)
  if self:IsHudDamageClosed() then
    return
  end
  local nWordType
  local hud = self:SpawnPrefabInstance(self.wordHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageWordRoot)
  self.hudId = self.hudId + 1
  local value = ""
  if valueType == 1 then
    nWordType = 8
    value = ConfigTable.GetUIText("Hud_Missing_Tip")
  elseif valueType == 2 then
    nWordType = 7
    value = ConfigTable.GetUIText("Hud_Immunity_Tip")
  elseif valueType == 3 then
    nWordType = 9
    value = ConfigTable.GetUIText("Hud_Resistance_Tip")
  end
  AdventureModuleHelper.SetHudStringValue(hud.gameObject, id, self.hudId, value, nWordType, false)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

function HudMainCtrl:OnEvent_HudMark(id, valueType, stringKey)
  local nWordType = valueType
  local hud = self:SpawnPrefabInstance(self.wordHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageWordRoot)
  self.hudId = self.hudId + 1
  local value = ConfigTable.GetUIText(stringKey)
  AdventureModuleHelper.SetHudStringValue(hud.gameObject, id, self.hudId, value, nWordType, false)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

function HudMainCtrl:OnEvent_LevelEnd()
  self:Clear()
end

function HudMainCtrl:OnEvent_NPCShow(bShow, id, uid, nCostCount, nHasCount)
  if id == 0 then
    return
  end
  local npcHud = self.npcHuds[uid]
  if bShow then
    if npcHud == nil then
      npcHud = self:SpawnPrefabInstance(self.npcHudPrefab, "Game.UI.Hud.NpcHudCtrl", "HUD", self._mapNode.Root)
      npcHud.gameObject.transform.localScale = Vector3.one
      self.npcHuds[uid] = npcHud
    end
    if npcHud ~= nil then
      npcHud:ShowNpc(id, uid, nCostCount, nHasCount)
    end
  elseif npcHud ~= nil then
    npcHud:HideNpc()
  end
end

function HudMainCtrl:OnEvent_HuoChuiBossShow(bShow, id, nInitValue, nInitState)
  local huoChuiHudPrefab = self:LoadAsset("UI/HUD/HudHuoChuiBoss.prefab")
  if id == 0 then
    return
  end
  local specialHud = self.specialHuds[id]
  if bShow then
    if specialHud == nil then
      specialHud = self:SpawnPrefabInstance(huoChuiHudPrefab, "Game.UI.Hud.HuoChuiHudCtrl", "HUD", self._mapNode.Root)
      self.specialHuds[id] = specialHud
    end
    if specialHud ~= nil then
      specialHud:SetMonsterId(id, nInitValue, nInitState)
      AdventureModuleHelper.SetHudFollowTarget(id, specialHud.gameObject, Vector3.zero, true)
    end
  elseif specialHud ~= nil then
    specialHud:Hide()
  end
end

function HudMainCtrl:OnEvent_SwitchHudDamage()
  local x = self._mapNode.DamageNumberRoot.transform.localScale.x
  if 0 < x then
    self.TEST_VISIBLE_HUD_DAMAGE = false
    self._mapNode.DamageNumberRoot.transform.localScale = Vector3.zero
    self._mapNode.DamageWordRoot.transform.localScale = Vector3.zero
  else
    self.TEST_VISIBLE_HUD_DAMAGE = true
    self._mapNode.DamageNumberRoot.transform.localScale = Vector3.one
    self._mapNode.DamageWordRoot.transform.localScale = Vector3.one
  end
end

function HudMainCtrl:OnEvent_SwitchHudHpBar()
  local x = self._mapNode.Root.transform.localScale.x
  if 0 < x then
    self._mapNode.Root.transform.localScale = Vector3.zero
    self._mapNode.BattleTarget.transform.localScale = Vector3.zero
  else
    self._mapNode.Root.transform.localScale = Vector3.one
    self._mapNode.BattleTarget.transform.localScale = Vector3.one
  end
end

function HudMainCtrl:OnEvent_AdventureModuleEnter()
  self._mapNode.BattleTarget.gameObject:SetActive(true)
end

function HudMainCtrl:OnEvent_CacheInstanceHud(count)
  local function wait()
    local tmpIndex = 0
    
    for i = 1, count do
      tmpIndex = tmpIndex - 1
      local hud = self:SpawnPrefabInstance(self.critDamageHudPrefab_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      self.numberHuds[tmpIndex] = hud
    end
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    for i = 1, count do
      tmpIndex = tmpIndex - 1
      local hud = self:SpawnPrefabInstance(self.minDamageHUDNumber_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      self.numberHuds[tmpIndex] = hud
    end
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    for i = 1, count do
      tmpIndex = tmpIndex - 1
      local hud = self:SpawnPrefabInstance(self.damageHudPrefab_Vampire, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
      self.numberHuds[tmpIndex] = hud
    end
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:Clear()
  end
  
  cs_coroutine.start(wait)
end

function HudMainCtrl:OnEvent_ToughnessStateChangedForGlobal(id, toughnessBroken)
  if toughnessBroken then
    self.tabToughnessEntity[id] = true
  else
    self:DestroyToughnessHud(id)
  end
end

function HudMainCtrl:OnEvent_MonsterDeclareDied(id)
  self:DestroyToughnessHud(id)
end

function HudMainCtrl:DestroyToughnessHud(id)
  if self.tabToughnessEntity[id] ~= nil then
    self.tabToughnessEntity[id] = nil
    self.tabToughnessEntityVal[id] = nil
    local hud = self.numberHuds[self.tabToughnessHudId[id]]
    local tmpHudId = self.tabToughnessHudId[id]
    self.tabToughnessHudId[id] = nil
    if hud ~= nil then
      do
        local hudAni = hud.gameObject:GetComponent("Animator")
        hudAni:Play("ToughnessDamageHUD_out")
        CS.WwiseAudioManager.Instance:PlaySound("ui_battle_boss_poRen_hitValue")
        self:AddTimer(1, 1.45, function()
          self:OnEvent_HudDestroyed(tmpHudId)
        end, true, true, true, nil)
      end
    end
  end
end

function HudMainCtrl:SetToughnessValue(id, val)
  if self.tabToughnessHudId[id] == nil then
    local hud = self:SpawnPrefabInstance(self.toughnessDamageHUD, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    self.hudId = self.hudId + 1
    self.tabToughnessEntityVal[id] = val
    local texTotal = hud.gameObject.transform:Find("text1/Title/texTotal"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(texTotal, ConfigTable.GetUIText("Hud_Total_Damage"))
    AdventureModuleHelper.SetHudToughnessDamageValue(hud.gameObject, id, self.hudId, val, false, false)
    self.numberHuds[self.hudId] = hud
    self.tabToughnessHudId[id] = self.hudId
    hud.gameObject.transform:SetAsLastSibling()
    local hudAni = hud.gameObject:GetComponent("Animator")
    hudAni:Play("ToughnessDamageHUD_in")
  else
    local hud = self.numberHuds[self.tabToughnessHudId[id]]
    if hud ~= nil then
      self.tabToughnessEntityVal[id] = self.tabToughnessEntityVal[id] + val
      AdventureModuleHelper.SetHudToughnessDamageValue(hud.gameObject, id, self.hudId, self.tabToughnessEntityVal[id], false, true)
      local texAin = hud.gameObject.transform:Find("text1"):GetComponent("Animator")
      texAin:Play("ToughnessDamageHUD_up")
    end
  end
end

return HudMainCtrl
