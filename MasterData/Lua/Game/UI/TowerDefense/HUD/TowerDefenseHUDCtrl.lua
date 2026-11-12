local TowerDefenseHUDCtrl = class("TowerDefenseHUDCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
TowerDefenseHUDCtrl._mapNodeConfig = {
  Root = {},
  DamageNumberRoot = {},
  DamageWordRoot = {}
}
TowerDefenseHUDCtrl._mapEventConfig = {
  TOWERDEFENSE_SET_ROLE_ON_STAGE_RESULT = "OnEvent_PlayerShowChanged",
  TOWERDEFENSE_MONSTER_STATE = "OnEvent_MonsterActive",
  TowerDefense_Restart = "OnEvent_Restart",
  HudDestroy = "OnEvent_HudDestroyed",
  HudDamage = "OnEvent_HudDamaged",
  HudHeal = "OnEvent_HudHealed",
  HudDefence = "OnEvent_HudDefenced",
  HudDotDamage = "OnEvent_HudDotDamage",
  TriggerElementMark = "OnEvent_HudMark"
}
TowerDefenseHUDCtrl._mapRedDotConfig = {}

function TowerDefenseHUDCtrl:Awake()
  self.PlayerHUDPrefab = self:LoadAsset("UI/Play_TowerDefence/HUD/PlayerHUD.prefab")
  self.MonsterHUDPrefab = self:LoadAsset("UI/Play_TowerDefence/HUD/MonsterHUD.prefab")
  self.critDamageHudPrefab = self:LoadAsset("UI/HUD/CritDamageHUDNumber_UI.prefab")
  self.dotDamageHudPrefab = self:LoadAsset("UI/HUD/DotDamageHUDNumber_UI.prefab")
  self.damageHudPrefab = self:LoadAsset("UI/Play_TowerDefence/HUD/DamageHUDNumber_UI.prefab")
  self.minDamageHUDNumber = self:LoadAsset("UI/HUD/MinDamageHUDNumber_UI.prefab")
  self.wordHudPrefab = self:LoadAsset("UI/HUD/WordHud_UI.prefab")
  self.healHudPrefab = self:LoadAsset("UI/HUD/HealHUDNumber_UI.prefab")
  self.monsterHuds = {}
  self.playerHuds = {}
  self.numberHuds = {}
  self.tabToughnessEntity = {}
  self.hudId = 0
end

function TowerDefenseHUDCtrl:OnDestroy()
  self.PlayerHUDPrefab = nil
  self.MonsterHUDPrefab = nil
  self.critDamageHudPrefab = nil
  self.dotDamageHudPrefab = nil
  self.damageHudPrefab = nil
  self.minDamageHUDNumber = nil
  self.wordHudPrefab = nil
  self.healHudPrefab = nil
  for key, value in pairs(self.monsterHuds) do
    self:DespawnPrefabInstance(value, "HUD")
  end
  for key, value in pairs(self.playerHuds) do
    self:DespawnPrefabInstance(value, "HUD")
  end
  for _, v in pairs(self.numberHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  self.monsterHuds = {}
  self.playerHuds = {}
  self.numberHuds = {}
  self.tabToughnessEntity = {}
  self.hudId = 0
end

function TowerDefenseHUDCtrl:OnEvent_PlayerShowChanged(bResult, nEntityId, nCharacterId)
  if nEntityId == 0 then
    return
  end
  local playerHud = self.playerHuds[nCharacterId]
  if bResult then
    if playerHud == nil then
      playerHud = self:SpawnPrefabInstance(self.PlayerHUDPrefab, "Game.UI.TowerDefense.HUD.PlayerHudCtrl", "HUD", self._mapNode.Root)
      self.playerHuds[nCharacterId] = playerHud
      playerHud.gameObject.transform.localScale = Vector3.one
    end
    if playerHud ~= nil then
      playerHud:SetPlayerId(nCharacterId)
      local height = CS.AdventureModuleHelper.GetHudOffsetHeight(nEntityId)
      local offset = Vector3(0, height, 0)
      CS.AdventureModuleHelper.SetHudFollowTarget(nEntityId, playerHud.gameObject, offset, false)
    end
  elseif playerHud ~= nil then
    self:DespawnPrefabInstance(playerHud, "HUD")
    self.playerHuds[nCharacterId] = nil
  end
end

function TowerDefenseHUDCtrl:OnEvent_MonsterActive(nEntityId, bShow)
  if nEntityId == 0 then
    return
  end
  local monsterHud = self.monsterHuds[nEntityId]
  if bShow then
    if monsterHud == nil then
      monsterHud = self:SpawnPrefabInstance(self.MonsterHUDPrefab, "Game.UI.TowerDefense.HUD.MonsterHudCtrl", "HUD", self._mapNode.Root)
      self.monsterHuds[nEntityId] = monsterHud
      monsterHud.gameObject.transform.localScale = Vector3.one
    end
    if monsterHud ~= nil then
      monsterHud:SetMonsterId(nEntityId)
      local height = CS.AdventureModuleHelper.GetEntityMonsterBarHeight(nEntityId)
      local offset = Vector3(0, height, 0)
      CS.AdventureModuleHelper.SetHudFollowTarget(nEntityId, monsterHud.gameObject, offset, true)
    end
  elseif monsterHud ~= nil then
    self:DespawnPrefabInstance(monsterHud, "HUD")
    self.monsterHuds[nEntityId] = nil
  end
end

function TowerDefenseHUDCtrl:OnEvent_Restart()
  for _, value in pairs(self.monsterHuds) do
    self:DespawnPrefabInstance(value, "HUD")
  end
  for _, value in pairs(self.playerHuds) do
    self:DespawnPrefabInstance(value, "HUD")
  end
  for _, v in pairs(self.numberHuds) do
    self:DespawnPrefabInstance(v, "HUD")
  end
  self.monsterHuds = {}
  self.playerHuds = {}
  self.numberHuds = {}
  self.tabToughnessEntity = {}
  self.hudId = 0
end

function TowerDefenseHUDCtrl:OnEvent_HudDestroyed(id)
  local hud = self.numberHuds[id]
  if hud ~= nil then
    self:DespawnPrefabInstance(hud, "HUD")
    self.numberHuds[id] = nil
  end
end

function TowerDefenseHUDCtrl:OnEvent_HudDamaged(id, value, isCrit, hitDamageConfig, formId, isMark, fromElementType, hudColorIndex)
  if self.tabToughnessEntity[id] then
    self:SetToughnessValue(id, value)
    return
  end
  local hud
  if hitDamageConfig and hitDamageConfig.IsDenseType then
    if isCrit then
      hud = self:SpawnPrefabInstance(self.critDamageHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    else
      hud = self:SpawnPrefabInstance(self.minDamageHUDNumber, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
    end
  elseif isCrit then
    hud = self:SpawnPrefabInstance(self.critDamageHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
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
  AdventureModuleHelper.SetHudValue(hud.gameObject, id, self.hudId, value, false, hitDamageConfig, _formId, isCrit, false, _fromElementType, _hudColorIndex)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
  if hudColorIndex ~= nil and hudColorIndex == 5 and (self.nTypeGreyResistanceTime[id] == nil or self.nTypeGreyResistanceTime[id] + self.resistanceTipInterval <= CS.ClientManager.Instance.serverTimeStampWithTimeZone) then
    self.nTypeGreyResistanceTime[id] = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    self:OnEvent_HudDefenced(id, 3)
  end
end

function TowerDefenseHUDCtrl:OnEvent_HudDotDamage(id, value, isCrit, hitDamageConfig, formId, isMark, fromElementType)
  if self.tabToughnessEntity[id] then
    self:SetToughnessValue(id, value)
    return
  end
  local hud = self:SpawnPrefabInstance(self.dotDamageHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
  self.hudId = self.hudId + 1
  local _formId = formId
  if formId == nil then
    _formId = 0
  end
  local _fromElementType = 0
  if fromElementType ~= nil then
    _fromElementType = fromElementType
  end
  AdventureModuleHelper.SetHudValue(hud.gameObject, id, self.hudId, value, false, hitDamageConfig, _formId, isCrit, true, _fromElementType, 4)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

function TowerDefenseHUDCtrl:OnEvent_HudHealed(id, value)
  local hud = self:SpawnPrefabInstance(self.healHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageNumberRoot)
  self.hudId = self.hudId + 1
  AdventureModuleHelper.SetHudValue(hud.gameObject, id, self.hudId, value, true, nil, 0, false, false)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

function TowerDefenseHUDCtrl:OnEvent_HudDefenced(id, valueType)
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

function TowerDefenseHUDCtrl:OnEvent_HudMark(id, valueType, stringKey)
  local nWordType = valueType
  local hud = self:SpawnPrefabInstance(self.wordHudPrefab, "Game.UI.Hud.HudNumberCtrl", "HUD", self._mapNode.DamageWordRoot)
  self.hudId = self.hudId + 1
  local value = ConfigTable.GetUIText(stringKey)
  AdventureModuleHelper.SetHudStringValue(hud.gameObject, id, self.hudId, value, nWordType, false)
  self.numberHuds[self.hudId] = hud
  hud.gameObject.transform:SetAsLastSibling()
end

return TowerDefenseHUDCtrl
