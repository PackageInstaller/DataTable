local GoldenSpyFloorCtrl = class("GoldenSpyFloorCtrl", BaseCtrl)
local LevelPrefabPath = "UI_Activity/_%s/LevelPrefab/"
GoldenSpyFloorCtrl._mapNodeConfig = {
  HookCtrl = {
    sNodeName = "HookRoot",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyHookCtrl"
  },
  PrefabRoot = {
    sNodeName = "PrefabRoot",
    sComponentName = "RectTransform"
  },
  floorItemRoot = {
    sNodeName = "floorItemRoot",
    sComponentName = "RectTransform"
  }
}
local itemCtrlPath = "Game.UI.Activity.GoldenSpy."
local ItemHitAreaType = {
  [1] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [2] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [3] = AllEnum.GoldenSpyHitAreaType.Circle,
  [4] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [5] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [6] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [7] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [8] = AllEnum.GoldenSpyHitAreaType.Rectangle,
  [9] = AllEnum.GoldenSpyHitAreaType.Circle,
  [10] = AllEnum.GoldenSpyHitAreaType.Rectangle
}

function GoldenSpyFloorCtrl:Awake()
end

function GoldenSpyFloorCtrl:Init(levelId, floorId, levelCtrl)
  self.levelId = levelId
  self.floorId = floorId
  self.levelCtrl = levelCtrl
  if self.prefab ~= nil then
    for i = #self.tbItem, 1, -1 do
      self:UnbindCtrlByNode(self.tbItem[i].Ctrl)
    end
    for i = #self.tbTrap, 1, -1 do
      self:UnbindCtrlByNode(self.tbTrap[i].Ctrl)
    end
    for i = #self.tbNeedRemoveItem, 1, -1 do
      self:UnbindCtrlByNode(self.tbNeedRemoveItem[i].Ctrl)
    end
    destroy(self.prefab)
  end
  self.tbItem = {}
  self.tbNeedRemoveItem = {}
  self.tbTrap = {}
  self.prefab = nil
  local floorCfg = ConfigTable.GetData("GoldenSpyFloor", floorId)
  if floorCfg == nil then
    return
  end
  local nPrefabName = self.levelCtrl.GoldenSpyLevelData:GetLevelPrefabName()
  local goLevelPerfab = self:LoadAsset(string.format(LevelPrefabPath, self.levelCtrl.nActId) .. nPrefabName .. ".prefab")
  self.prefab = instantiate(goLevelPerfab, self._mapNode.floorItemRoot)
  self.prefab.transform.localPosition = Vector3.zero
  self.prefab.transform.localScale = Vector3.one
  self.prefab.transform.localRotation = Quaternion.identity
  self:InitItem()
  self:InitRandomBuff()
  self:InitTrap()
  self.bInvincible = false
  self._mapNode.HookCtrl:Init(self.levelId, self.floorId, self, self.levelCtrl.GoldenSpyLevelData, self.levelCtrl.GoldenSpyFloorData)
end

function GoldenSpyFloorCtrl:InitItem()
  if self.prefab == nil then
    return
  end
  local itemRoot = self.prefab.transform:Find("ItemRoot")
  if itemRoot == nil then
    return
  end
  local levelCfg = ConfigTable.GetData("GoldenSpyLevel", self.levelId)
  local nChildCount = itemRoot.transform.childCount
  for i = 1, nChildCount do
    local child = itemRoot.transform:GetChild(i - 1)
    local nItemId = tonumber(child.gameObject.name)
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", nItemId)
    if itemCfg ~= nil then
      local itemCtrl = self:BindCtrlByNode(child.gameObject, itemCtrlPath .. itemCfg.luaCtrl)
      itemCtrl:Init()
      itemCtrl:SetData({
        nUid = #self.tbItem + i,
        nItemId = nItemId,
        nHitAreaType = ItemHitAreaType[itemCfg.ItemType]
      }, self, levelCfg.ConfigId)
      table.insert(self.tbItem, {Ctrl = itemCtrl})
      self.levelCtrl.GoldenSpyFloorData:SetItem(nItemId)
    end
  end
end

function GoldenSpyFloorCtrl:InitRandomBuff()
  local levelCfg = ConfigTable.GetData("GoldenSpyLevel", self.levelId)
  if levelCfg == nil then
    return
  end
  if levelCfg.LevelType ~= GameEnum.GoldenSpyLevelType.Random then
    return
  end
  local floorCfg = ConfigTable.GetData("GoldenSpyFloor", self.floorId)
  if floorCfg == nil then
    return
  end
  local buffRandomRoot = self.prefab.transform:Find("BuffRandomRoot")
  if buffRandomRoot == nil then
    return
  end
  local randomCount = floorCfg.BuffCardCount
  local nChildCount = buffRandomRoot.childCount
  local tbAllBuffPrefab = {}
  for i = 1, nChildCount do
    local child = buffRandomRoot.transform:GetChild(i - 1)
    table.insert(tbAllBuffPrefab, child)
    child.gameObject:SetActive(false)
  end
  if randomCount > nChildCount then
    return
  end
  local randomIndex = math.random(1, nChildCount)
  for i = 1, randomCount do
    local buff = tbAllBuffPrefab[randomIndex]
    buff.gameObject:SetActive(true)
    local nItemId = tonumber(buff.gameObject.name)
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", nItemId)
    if itemCfg ~= nil then
      local buffCtrl = self:BindCtrlByNode(buff.gameObject, itemCtrlPath .. itemCfg.luaCtrl)
      buffCtrl:Init()
      buffCtrl:SetData({
        nUid = i,
        nItemId = nItemId,
        nHitAreaType = ItemHitAreaType[itemCfg.ItemType]
      }, self, levelCfg.ConfigId)
      table.insert(self.tbItem, {Ctrl = buffCtrl})
      randomIndex = randomIndex % nChildCount + 1
      self.levelCtrl.GoldenSpyFloorData:SetItem(nItemId)
    end
  end
end

function GoldenSpyFloorCtrl:InitTrap()
  if self.prefab == nil then
    return
  end
  local trapRoot = self.prefab.transform:Find("TrapRoot")
  if trapRoot == nil then
    return
  end
  local nChildCount = trapRoot.transform.childCount
  for i = 1, nChildCount do
    local child = trapRoot.transform:GetChild(i - 1)
    local trapId = tonumber(child.gameObject.name)
    local trapCfg = ConfigTable.GetData("GoldenSpyObstacle", trapId)
    if trapCfg ~= nil then
      local trapCtrl = self:BindCtrlByNode(child.gameObject, itemCtrlPath .. trapCfg.luaCtrl)
      trapCtrl:Init()
      trapCtrl:SetData({nTrapId = trapId}, self)
      table.insert(self.tbTrap, {Ctrl = trapCtrl})
    end
  end
end

function GoldenSpyFloorCtrl:StartFloor()
  self.bStartFloor = true
  local hookCtrl = self._mapNode.HookCtrl
  hookCtrl:StartSwing()
  for _, v in ipairs(self.tbItem) do
    v.Ctrl:StartFloor()
  end
  for _, v in ipairs(self.tbTrap) do
    if v.Ctrl ~= nil then
      v.Ctrl:StartFloor()
    end
  end
end

function GoldenSpyFloorCtrl:FinishFloor()
  self.bStartFloor = false
  self:Exit()
end

function GoldenSpyFloorCtrl:GetHookEndPos()
  return self._mapNode.HookCtrl:GetHookEndWorldPosition()
end

function GoldenSpyFloorCtrl:GetHookEndPosInRectLocal(targetRect)
  if targetRect == nil or targetRect:IsNull() then
    return nil
  end
  local hookCtrl = self._mapNode.HookCtrl
  if hookCtrl == nil then
    return nil
  end
  local hookPos = hookCtrl:GetHookEndWorldPosition()
  local hookRootTr = hookCtrl.gameObject.transform
  local posInCommon = hookRootTr:TransformPoint(hookPos)
  return targetRect:InverseTransformPoint(posInCommon)
end

function GoldenSpyFloorCtrl:GetHookRadius()
  return self.levelCtrl:GetHookRadius()
end

function GoldenSpyFloorCtrl:ResumeHookSwing()
  local hookCtrl = self._mapNode.HookCtrl
  if hookCtrl and hookCtrl.ResumeSwing then
    hookCtrl:ResumeSwing(true)
  end
end

function GoldenSpyFloorCtrl:Shoot(nSpeed, nRadius, nFactor, nMinSpeed, onRetractComplete, onCatched, onCatchedComplete)
  local hookCtrl = self._mapNode.HookCtrl
  if not hookCtrl or not hookCtrl:IsSwinging() then
    return
  end
  hookCtrl:PauseSwing()
  self.bInvincible = false
  hookCtrl:StartExtend(nSpeed, nRadius, nFactor, nMinSpeed, function()
    if onRetractComplete then
      onRetractComplete()
    end
  end, function(tbItemCtrl)
    if onCatched then
      onCatched(tbItemCtrl)
    end
    for _, itemCtrl in ipairs(tbItemCtrl) do
      if itemCtrl:GetItemCfg().ItemType == GameEnum.GoldenSpyItem.Boom then
        self:RemoveItem(itemCtrl)
      end
    end
    self.tbCatchedItem = tbItemCtrl
  end, function(tbItemCtrl)
    for _, itemCtrl in ipairs(tbItemCtrl) do
      if itemCtrl:GetItemCfg().ItemType == GameEnum.GoldenSpyItem.Boom then
        self:RemoveItem(itemCtrl)
      else
        for i = #self.tbItem, 1, -1 do
          if self.tbItem[i].Ctrl == itemCtrl then
            table.insert(self.tbNeedRemoveItem, self.tbItem[i])
            table.remove(self.tbItem, i)
            break
          end
        end
      end
    end
    self.tbCatchedItem = nil
    self.bInvincible = false
    if onCatchedComplete then
      onCatchedComplete(tbItemCtrl)
    end
  end)
end

function GoldenSpyFloorCtrl:SetHookType(nHookType, nFishingHookRadius, bForce)
  local hookCtrl = self._mapNode.HookCtrl
  self.nHookType = nHookType
  if hookCtrl and hookCtrl.SetHookType then
    hookCtrl:SetHookType(nHookType, nFishingHookRadius, bForce)
  end
end

function GoldenSpyFloorCtrl:RemoveItem(itemCtrl, bForce)
  local bDelSuccess = false
  local itemId = itemCtrl:GetItemCfg().Id
  for i = #self.tbItem, 1, -1 do
    if self.tbItem[i].Ctrl == itemCtrl then
      table.insert(self.tbNeedRemoveItem, self.tbItem[i])
      table.remove(self.tbItem, i)
      bDelSuccess = true
      break
    end
  end
  if bDelSuccess then
    self.levelCtrl.GoldenSpyFloorData:DeleteItem(itemId, bForce)
  end
end

function GoldenSpyFloorCtrl:CheckCanDropItem()
  local hookCtrl = self._mapNode.HookCtrl
  if hookCtrl == nil then
    return false
  end
  local hookType = hookCtrl:GetCurHookType()
  if hookType == AllEnum.GoldenSpyHookType.FishingHook then
    return false
  end
  return true
end

function GoldenSpyFloorCtrl:DropItem()
  if self.tbCatchedItem == nil then
    return
  end
  local hookCtrl = self._mapNode.HookCtrl
  hookCtrl:DropItem()
  self.levelCtrl:DropItem()
  for _, itemCtrl in ipairs(self.tbCatchedItem) do
    itemCtrl.gameObject.transform.parent = itemCtrl:GetParent()
  end
  self.tbCatchedItem = nil
end

function GoldenSpyFloorCtrl:SetHookIsInvincible(bInvincible)
  self.bInvincible = bInvincible
end

function GoldenSpyFloorCtrl:GetHookIsInvincible()
  return self.bInvincible
end

function GoldenSpyFloorCtrl:SubTime(nTime)
  self.levelCtrl:SubTime(nTime)
end

function GoldenSpyFloorCtrl:DoStartRetract()
  self.levelCtrl:StartRetract()
end

function GoldenSpyFloorCtrl:StartRetract(finishCallback)
  local hookCtrl = self._mapNode.HookCtrl
  if hookCtrl and hookCtrl.StartRetract then
    hookCtrl:StartRetract(self.levelCtrl:GetHookBaseSpeed(), function()
      self:ResumeHookSwing()
      if finishCallback then
        finishCallback()
      end
    end)
  end
end

function GoldenSpyFloorCtrl:CheckCanChangeHook()
  local hookCtrl = self._mapNode.HookCtrl
  if not hookCtrl or not hookCtrl:IsSwinging() then
    return false
  end
  return true
end

function GoldenSpyFloorCtrl:StartBoom(useCallback, finishCallback)
  if self.tbCatchedItem == nil or #self.tbCatchedItem <= 0 then
    return false
  end
  local hookCtrl = self._mapNode.HookCtrl
  if hookCtrl and not hookCtrl:CanUseBoom() then
    return false
  end
  for _, itemCtrl in ipairs(self.tbCatchedItem) do
    if itemCtrl:GetItemCfg().ItemType == GameEnum.GoldenSpyItem.Boom then
      return false
    end
  end
  if useCallback then
    useCallback()
  end
  for _, itemCtrl in ipairs(self.tbCatchedItem) do
    itemCtrl:OnSkill_Boom(function()
      self:RemoveItem(itemCtrl)
    end)
  end
  self.tbCatchedItem = nil
  self._mapNode.HookCtrl:DropItem()
  self:StartRetract(finishCallback)
  return true
end

function GoldenSpyFloorCtrl:CheckHasFrozenItem()
  for _, v in ipairs(self.tbItem) do
    local itemCfg = v.Ctrl:GetItemCfg()
    if itemCfg.ItemType == GameEnum.GoldenSpyItem.Companion or itemCfg.ItemType == GameEnum.GoldenSpyItem.Patrol then
      return true
    end
  end
  if #self.tbTrap > 0 then
    return true
  end
  return false
end

function GoldenSpyFloorCtrl:StartFrozen()
  for _, v in ipairs(self.tbItem) do
    if v.Ctrl ~= nil and (self.tbCatchedItem == nil or self.tbCatchedItem ~= nil and table.indexof(self.tbCatchedItem, v.Ctrl) <= 0) then
      v.Ctrl:OnSkill_Frozen()
    end
  end
  for _, v in ipairs(self.tbTrap) do
    if v.Ctrl ~= nil then
      v.Ctrl:OnSkill_Frozen()
    end
  end
end

function GoldenSpyFloorCtrl:StopFrozen()
  for _, v in ipairs(self.tbItem) do
    if v.Ctrl ~= nil and (self.tbCatchedItem == nil or self.tbCatchedItem ~= nil and table.indexof(self.tbCatchedItem, v.Ctrl) <= 0) then
      v.Ctrl:OnSkill_Frozen_Resume()
    end
  end
  for _, v in ipairs(self.tbTrap) do
    if v.Ctrl ~= nil then
      v.Ctrl:OnSkill_Frozen_Resume()
    end
  end
end

function GoldenSpyFloorCtrl:Pause()
  self._mapNode.HookCtrl:Pause()
  for _, v in ipairs(self.tbItem) do
    if v.Ctrl ~= nil then
      v.Ctrl:Pause()
    end
  end
  for _, v in ipairs(self.tbTrap) do
    if v.Ctrl ~= nil then
      v.Ctrl:Pause()
    end
  end
end

function GoldenSpyFloorCtrl:Exit()
  if self.prefab ~= nil then
    for i = #self.tbItem, 1, -1 do
      self.tbItem[i].Ctrl:FinishFloor()
      self:UnbindCtrlByNode(self.tbItem[i].Ctrl)
    end
    for i = #self.tbTrap, 1, -1 do
      self.tbTrap[i].Ctrl:FinishFloor()
      self:UnbindCtrlByNode(self.tbTrap[i].Ctrl)
    end
    for i = #self.tbNeedRemoveItem, 1, -1 do
      self:UnbindCtrlByNode(self.tbNeedRemoveItem[i].Ctrl)
    end
    destroy(self.prefab)
  end
  self.tbItem = {}
  self.tbTrap = {}
  self.tbNeedRemoveItem = {}
  self.prefab = nil
  self._mapNode.HookCtrl:Exit()
end

function GoldenSpyFloorCtrl:Continue()
  self._mapNode.HookCtrl:Continue()
  for _, v in ipairs(self.tbItem) do
    if v.Ctrl ~= nil then
      v.Ctrl:Resume()
    end
  end
  for _, v in ipairs(self.tbTrap) do
    if v.Ctrl ~= nil then
      v.Ctrl:Resume()
    end
  end
end

return GoldenSpyFloorCtrl
