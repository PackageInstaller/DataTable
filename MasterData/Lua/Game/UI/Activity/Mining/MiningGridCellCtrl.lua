local MiningGridCellCtrl = class("MiningGridCellCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
MiningGridCellCtrl._mapNodeConfig = {
  image_SuperHard = {sComponentName = "Image"},
  btn_SuperHard = {
    sNodeName = "image_SuperHard",
    sComponentName = "UIButton"
  },
  image_Hard = {sComponentName = "Image"},
  btn_Hard = {sNodeName = "image_Hard", sComponentName = "UIButton"},
  image_Normal = {sComponentName = "Image"},
  btn_Normal = {
    sNodeName = "image_Normal",
    sComponentName = "UIButton"
  },
  image_Fragile = {sComponentName = "Image"},
  btn_Fragile = {
    sNodeName = "image_Fragile",
    sComponentName = "UIButton"
  },
  effect = {},
  effect_Spade = {},
  effect_OnHit = {},
  effect_Reward = {},
  effect_Critical = {},
  effect_UnUseAxe = {},
  effect_Spurting = {},
  effect_Transform = {},
  _Hint = {}
}

function MiningGridCellCtrl:Init()
  self.nIndex = 0
  self.bMark = false
  self.funcCallback = nil
  self.tbTimer = {}
end

function MiningGridCellCtrl:InitTempEffectData()
  self.bNextIsCritical = false
  self.bNextIsUnUse = false
end

function MiningGridCellCtrl:Awake(...)
  self._mapNode.image_SuperHard.alphaHitTestMinimumThreshold = 0.1
  self._mapNode.image_Hard.alphaHitTestMinimumThreshold = 0.1
  self._mapNode.image_Normal.alphaHitTestMinimumThreshold = 0.1
  self._mapNode.image_Fragile.alphaHitTestMinimumThreshold = 0.1
  self:SetChildActive(self._mapNode.effect, false)
  self:SetChildActive(self._mapNode.effect_OnHit, false)
end

function MiningGridCellCtrl:SetChildActive(go, bActive)
  local nChildCount = go.transform.childCount
  for i = 1, nChildCount do
    local child = go.transform:GetChild(i - 1)
    child.gameObject:SetActive(bActive)
  end
end

function MiningGridCellCtrl:SetData(nId, nStatus, bMark, btnCallback, nIndex)
  self:Init()
  self:InitTempEffectData()
  self._mapNode._Hint:SetActive(false)
  self.nId = nId
  self.nIndex = nIndex
  self.funcCallback = btnCallback
  self.nStatus = nil
  self:UpdateData(nStatus)
  self.bMark = bMark
  if self.bMark and nStatus ~= GameEnum.miningGridType.Destroyed then
    self:UpdateEffect(GameEnum.miningSupportEffect.TreasureMarkerOnGridDestroyed)
  end
end

function MiningGridCellCtrl:UpdateData(nStatus, nEffectType, bPlayCellInAnim)
  local oldStatus = self.nStatus
  self.nStatus = nStatus
  self:UpdateImage(nStatus, bPlayCellInAnim)
  self:ClearButtonListener()
  self:ClearTimer()
  self:SetChildActive(self._mapNode.effect, false)
  self:SetChildActive(self._mapNode.effect_OnHit, false)
  if nEffectType == GameEnum.miningSupportEffect.TreasureMarkerOnGridDestroyed then
    self.bMark = true
  end
  if nStatus ~= GameEnum.miningGridType.Destroyed and self.bMark then
    self:UpdateEffect(GameEnum.miningSupportEffect.TreasureMarkerOnGridDestroyed)
  end
  if nEffectType == GameEnum.miningSupportEffect.Dig then
    self:PlayDigSound(oldStatus)
  end
  self:SetButtonListener(nStatus, self.funcCallback)
  if nEffectType ~= nil then
    self:UpdateEffect(nEffectType)
  end
  self:UpdateOnHitAnima(oldStatus)
end

function MiningGridCellCtrl:ClearTimer()
  for key, timer in pairs(self.tbTimer) do
    timer:_Stop()
  end
  self.tbTimer = {}
end

function MiningGridCellCtrl:UpdateEffect(nEffectType)
  local timer
  if nEffectType == GameEnum.miningSupportEffect.Dig then
    self:UpdateDigEffect()
  elseif nEffectType == GameEnum.miningSupportEffect.NeighborDestroyed then
  elseif nEffectType == GameEnum.miningSupportEffect.AreaDamageOnDig then
    WwiseAudioMgr:PostEvent("mode_digging2_sputter")
    self._mapNode.effect_Spurting:SetActive(true)
    timer = self:AddTimer(1, 0.5, function()
      self._mapNode.effect_Spurting:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif nEffectType == GameEnum.miningSupportEffect.ConsumePreserver then
    self.bNextIsUnUse = true
  elseif nEffectType == GameEnum.miningSupportEffect.ConverterOnEnterLayer then
    WwiseAudioMgr:PostEvent("mode_digging2_transform")
    self._mapNode.effect_Transform:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_Transform:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif nEffectType == GameEnum.miningSupportEffect.ConverterOnReceiveTreasure then
    WwiseAudioMgr:PostEvent("mode_digging2_transform")
    self._mapNode.effect_Transform:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_Transform:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif nEffectType == GameEnum.miningSupportEffect.ConverterOnGridDestroyed then
    WwiseAudioMgr:PostEvent("mode_digging2_transform")
    self._mapNode.effect_Transform:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_Transform:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif nEffectType == GameEnum.miningSupportEffect.CriticalDamage then
    self.bNextIsCritical = true
  elseif nEffectType == GameEnum.miningSupportEffect.TreasureMarkerOnGridDestroyed then
    self._mapNode.effect_Reward:SetActive(true)
    WwiseAudioMgr:PostEvent("mode_digging1_cast_targat")
  elseif nEffectType == GameEnum.miningSupportEffect.Char134 then
    WwiseAudioMgr:PostEvent("mode_digging2_sputter")
    self._mapNode.effect_Spurting:SetActive(true)
    timer = self:AddTimer(1, 0.5, function()
      self._mapNode.effect_Spurting:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif nEffectType == GameEnum.miningSupportEffect.Char156 then
    WwiseAudioMgr:PostEvent("mode_digging2_transform")
    self._mapNode.effect_Transform:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_Transform:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif nEffectType == GameEnum.miningSupportEffect.Npc132 then
  elseif nEffectType == GameEnum.miningSupportEffect.Max then
  elseif nEffectType == GameEnum.miningSupportEffect.ProbRefundConsumeOnEmptyDigDestroy then
    self._mapNode.effect_UnUseAxe:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_UnUseAxe:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  end
end

function MiningGridCellCtrl:UpdateDigEffect()
  local timer
  self._mapNode.effect_Spade:SetActive(true)
  self:AddTimer(1, 0.14, function()
    self._mapNode.effect_Spade:SetActive(false)
  end, true, true, true, nil)
  if not self.bNextIsCritical and not self.bNextIsUnUse then
  elseif self.bNextIsCritical then
    self._mapNode.effect_Critical:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_Critical:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
      self.bNextIsCritical = false
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  elseif self.bNextIsUnUse then
    self._mapNode.effect_UnUseAxe:SetActive(true)
    timer = self:AddTimer(1, 1, function()
      self._mapNode.effect_UnUseAxe:SetActive(false)
      local index = table.indexof(self.tbTimer, timer)
      if 0 < index then
        table.remove(self.tbTimer, index)
      end
      self.bNextIsUnUse = false
    end, true, true, true, nil)
    table.insert(self.tbTimer, timer)
  end
end

function MiningGridCellCtrl:UpdateImage(cellType, bPlayInAnima)
  self._mapNode.image_SuperHard.gameObject:SetActive(false)
  self._mapNode.image_Hard.gameObject:SetActive(false)
  self._mapNode.image_Normal.gameObject:SetActive(false)
  self._mapNode.image_Fragile.gameObject:SetActive(false)
  if cellType == GameEnum.miningGridType.Fragile then
    self._mapNode.image_Fragile.gameObject:SetActive(true)
    if bPlayInAnima then
      local anim = self._mapNode.image_Fragile.gameObject:GetComponent("Animator")
      anim:Play("Cell_in")
    end
  elseif cellType == GameEnum.miningGridType.Normal then
    self._mapNode.image_Normal.gameObject:SetActive(true)
    if bPlayInAnima then
      local anim = self._mapNode.image_Normal.gameObject:GetComponent("Animator")
      anim:Play("Cell_in")
    end
  elseif cellType == GameEnum.miningGridType.Hard then
    self._mapNode.image_Hard.gameObject:SetActive(true)
    if bPlayInAnima then
      local anim = self._mapNode.image_Hard.gameObject:GetComponent("Animator")
      anim:Play("Cell_in")
    end
  elseif cellType == GameEnum.miningGridType.SuperHard then
    self._mapNode.image_SuperHard.gameObject:SetActive(true)
    if bPlayInAnima then
      local anim = self._mapNode.image_SuperHard.gameObject:GetComponent("Animator")
      anim:Play("Cell_in")
    end
  else
    self._mapNode.effect_Reward:SetActive(false)
  end
end

function MiningGridCellCtrl:UpdateOnHitAnima(cellType)
  local imgOnHit_SuperHard = self._mapNode.effect_OnHit.transform:Find("imgOnHit_SuperHard")
  local imgOnHit_Hard = self._mapNode.effect_OnHit.transform:Find("imgOnHit_Hard")
  local imgOnHit_Normal = self._mapNode.effect_OnHit.transform:Find("imgOnHit_Normal")
  local imgOnHit_Fragile = self._mapNode.effect_OnHit.transform:Find("imgOnHit_Fragile")
  local wwiseEvent, go
  if cellType == GameEnum.miningGridType.Fragile then
    go = imgOnHit_Fragile
  elseif cellType == GameEnum.miningGridType.Normal then
    go = imgOnHit_Normal
  elseif cellType == GameEnum.miningGridType.Hard then
    go = imgOnHit_Hard
  else
    if cellType == GameEnum.miningGridType.SuperHard then
      go = imgOnHit_SuperHard
    else
    end
  end
  if go ~= nil then
    self._mapNode.effect_OnHit:SetActive(true)
    go.gameObject:SetActive(true)
    self:AddTimer(1, 0.26, function()
      go.gameObject:SetActive(false)
      self._mapNode.effect_OnHit:SetActive(false)
    end, true, true, true, nil)
  end
end

function MiningGridCellCtrl:PlayDigSound(oldStatus)
  local wwiseEvent
  if oldStatus == GameEnum.miningGridType.Fragile then
    wwiseEvent = "mode_digging1_dig_light"
  elseif oldStatus == GameEnum.miningGridType.Normal then
    wwiseEvent = "mode_digging1_dig_light"
  elseif oldStatus == GameEnum.miningGridType.Hard then
    wwiseEvent = "mode_digging1_dig_medium"
  elseif oldStatus == GameEnum.miningGridType.SuperHard then
    wwiseEvent = "mode_digging1_dig_heavy"
  end
  if wwiseEvent ~= nil then
    WwiseAudioMgr:PostEvent(wwiseEvent)
  end
end

function MiningGridCellCtrl:SetButtonListener(cellType, callback)
  if cellType == GameEnum.miningGridType.Fragile then
    self._mapNode.btn_Fragile.onClick:AddListener(function(...)
      callback(self.nId)
    end)
  elseif cellType == GameEnum.miningGridType.Normal then
    self._mapNode.btn_Normal.onClick:AddListener(function(...)
      callback(self.nId)
    end)
  elseif cellType == GameEnum.miningGridType.Hard then
    self._mapNode.btn_Hard.onClick:AddListener(function(...)
      callback(self.nId)
    end)
  else
    if cellType == GameEnum.miningGridType.SuperHard then
      self._mapNode.btn_SuperHard.onClick:AddListener(function(...)
        callback(self.nId)
      end)
    else
    end
  end
end

function MiningGridCellCtrl:ClearButtonListener()
  self._mapNode.btn_SuperHard.onClick:RemoveAllListeners()
  self._mapNode.btn_Hard.onClick:RemoveAllListeners()
  self._mapNode.btn_Normal.onClick:RemoveAllListeners()
  self._mapNode.btn_Fragile.onClick:RemoveAllListeners()
end

function MiningGridCellCtrl:ShowHint()
  self._mapNode._Hint:SetActive(true)
end

return MiningGridCellCtrl
