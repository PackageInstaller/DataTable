local GoldenSpyHookCtrl = class("GoldenSpyHookCtrl", BaseCtrl)
local SpineManager = require("Game.Spine.SpineManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local MaxOffset = 20
local MinOffset = 10
local OffsetDir = {
  [1] = Vector2(0, 0),
  [2] = Vector2(1, 0),
  [3] = Vector2(1, 1),
  [4] = Vector2(0, 1),
  [5] = Vector2(-1, 1),
  [6] = Vector2(-1, 0),
  [7] = Vector2(-1, -1),
  [8] = Vector2(0, -1),
  [9] = Vector2(1, -1)
}
GoldenSpyHookCtrl._mapNodeConfig = {
  trHookPivot = {
    sNodeName = "HookPivot",
    sComponentName = "RectTransform"
  },
  trLine = {
    sNodeName = "hook_line",
    sComponentName = "RectTransform"
  },
  trHookEnd = {
    sNodeName = "hook",
    sComponentName = "RectTransform"
  },
  trNet = {
    sNodeName = "net_Hook",
    sComponentName = "RectTransform"
  },
  rtMaxLengthArea = {
    sNodeName = "MaxLengthArea",
    sComponentName = "RectTransform"
  },
  itemParent = {
    sNodeName = "itemParent",
    sComponentName = "RectTransform"
  },
  hookRoot = {},
  hook_open = {},
  hook_normal = {},
  hook_catched = {},
  nethookRoot = {},
  nethook_normal = {},
  nethook_catched = {},
  net_Hook = {}
}
GoldenSpyHookCtrl.DefaultLineSize = 100
GoldenSpyHookCtrl.DefaultHookPosY = -90
GoldenSpyHookCtrl.HOOK_SWING_EASE = Ease.Linear
GoldenSpyHookCtrl.HOOK_EXTEND_EASE = Ease.Linear
GoldenSpyHookCtrl.HOOK_RETRACT_EASE = Ease.Linear
GoldenSpyHookCtrl._mapEventConfig = {
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
local HookStage = {
  STATE_SWINGING = 1,
  STATE_EXTENDING = 2,
  STATE_RETRACTING = 3
}

function GoldenSpyHookCtrl:Init(levelId, floorId, floorCtrl, levelData, floorData)
  self.levelId = levelId
  self.floorId = floorId
  self.floorCtrl = floorCtrl
  self.levelData = levelData
  self.floorData = floorData
  self:DestroyItemInHook()
  local levelCfg = ConfigTable.GetData("GoldenSpyLevel", self.levelId)
  if levelCfg == nil then
    return
  end
  local configCfg = ConfigTable.GetData("GoldenSpyConfig", levelCfg.ConfigId)
  self.HOOK_SWING_LEFT_ANGLE = -configCfg.MaxAngle
  self.HOOK_SWING_RIGHT_ANGLE = configCfg.MaxAngle
  self.HOOK_SWING_DURATION = configCfg.AngleTime
  self._swingTweener = nil
  self._extendTweener = nil
  self._retractTweener = nil
  self._hookLength = 0
  self._hookState = 0
  self._onExtendComplete = nil
  self._onRetractComplete = nil
  self._swingGoingRight = true
  self._swingAtRight = false
  self.tbCatchedItem = {}
  self._mapNode.trHookPivot.localEulerAngles = Vector3(0, 0, 0)
  self._mapNode.trHookEnd.localPosition = Vector3(0, self.DefaultHookPosY, 0)
  self:ApplyHookLength()
  if self.tbTimers ~= nil then
    for _, v in ipairs(self.tbTimers) do
      if v ~= nil then
        v:Cancel()
      end
    end
  end
  self.tbTimers = {}
  if levelCfg.LevelType == GameEnum.GoldenSpyLevelType.FishingHook then
    self:SetHookType(AllEnum.GoldenSpyHookType.FishingHook, tonumber(levelCfg.Param1), true)
  else
    self:SetHookType(AllEnum.GoldenSpyHookType.Normal, 0, true)
  end
  SpineManager.Resume(self._mapNode.nethook_catched)
  if self._hookType == AllEnum.GoldenSpyHookType.Normal then
    self._mapNode.hookRoot:SetActive(true)
    self._mapNode.nethookRoot:SetActive(false)
    self._mapNode.hook_open:SetActive(false)
    self._mapNode.hook_normal:SetActive(true)
    self._mapNode.hook_catched:SetActive(false)
  elseif self._hookType == AllEnum.GoldenSpyHookType.FishingHook then
    self._mapNode.hookRoot:SetActive(false)
    self._mapNode.nethookRoot:SetActive(true)
    self._mapNode.nethook_normal:SetActive(true)
    self._mapNode.nethook_catched:SetActive(false)
  end
end

function GoldenSpyHookCtrl:SetHookType(hookType, fishingHookRadius, bForce)
  self._hookType = hookType
  if bForce or self.tempHookType == nil then
    self.tempHookType = hookType
    self.tempHookRadius = fishingHookRadius
  end
  self._fishingHookRadius = tonumber(fishingHookRadius) or 0
  if self._hookState == HookStage.STATE_SWINGING or bForce then
    if self._hookType == AllEnum.GoldenSpyHookType.Normal then
      self._mapNode.hookRoot:SetActive(true)
      self._mapNode.nethookRoot:SetActive(false)
      self._mapNode.hook_open:SetActive(false)
      self._mapNode.hook_normal:SetActive(true)
      self._mapNode.hook_catched:SetActive(false)
    elseif self._hookType == AllEnum.GoldenSpyHookType.FishingHook then
      self._mapNode.hookRoot:SetActive(false)
      self._mapNode.nethookRoot:SetActive(true)
      self._mapNode.nethook_normal:SetActive(true)
      self._mapNode.nethook_catched:SetActive(false)
    end
  end
  if NovaAPI.IsEditorPlatform() and self._fishingHookRadius > 0 then
    local tr = self._mapNode.trNet
    tr.sizeDelta = Vector2(self._fishingHookRadius * 2, self._fishingHookRadius * 2)
  end
end

function GoldenSpyHookCtrl:GetCurHookType()
  return self.tempHookType
end

function GoldenSpyHookCtrl:DestroyItemInHook()
  local itemParent = self._mapNode.itemParent
  if itemParent == nil then
    return
  end
  local nChildCount = itemParent.transform.childCount
  for i = 1, nChildCount do
    local child = itemParent.transform:GetChild(i - 1)
    destroy(child.gameObject)
  end
end

function GoldenSpyHookCtrl:ApplyHookLength()
  local tr = self._mapNode.trHookEnd
  if tr then
    tr.localPosition = Vector3(0, -self._hookLength + self.DefaultHookPosY, 0)
  end
  local rtLine = self._mapNode.trLine
  if rtLine and not rtLine:IsNull() then
    rtLine.sizeDelta = Vector2(rtLine.sizeDelta.x, self._hookLength + self.DefaultLineSize)
  end
end

function GoldenSpyHookCtrl:SetHookLength(length)
  self._hookLength = math.max(0, length)
  self:ApplyHookLength()
end

function GoldenSpyHookCtrl:_DoSwingPhase(fromAngle, toAngle, onPhaseComplete)
  local pivot = self._mapNode.trHookPivot
  if pivot == nil or onPhaseComplete == nil then
    return
  end
  if self._hookType == AllEnum.GoldenSpyHookType.Normal then
    self._mapNode.hookRoot:SetActive(true)
    self._mapNode.nethookRoot:SetActive(false)
    self._mapNode.hook_open:SetActive(false)
    self._mapNode.hook_normal:SetActive(true)
    self._mapNode.hook_catched:SetActive(false)
  elseif self._hookType == AllEnum.GoldenSpyHookType.FishingHook then
    self._mapNode.hookRoot:SetActive(false)
    self._mapNode.nethookRoot:SetActive(true)
    self._mapNode.nethook_normal:SetActive(true)
    self._mapNode.nethook_catched:SetActive(false)
  end
  self._swingGoingRight = toAngle == self.HOOK_SWING_RIGHT_ANGLE
  pivot.localEulerAngles = Vector3(0, 0, fromAngle)
  local realAngle = math.abs(toAngle - fromAngle)
  local realDuration = realAngle / 1.0 / math.abs(self.HOOK_SWING_RIGHT_ANGLE * 2) * self.HOOK_SWING_DURATION
  if self._swingTweener ~= nil then
    self._swingTweener:Kill()
    self._swingTweener = nil
  end
  self._swingTweener = pivot:DOLocalRotate(Vector3(0, 0, toAngle), realDuration, RotateMode.Fast):SetEase(self.HOOK_SWING_EASE):SetUpdate(true):OnComplete(function()
    onPhaseComplete()
  end)
end

function GoldenSpyHookCtrl:_ChainSwing()
  local pivot = self._mapNode.trHookPivot
  if pivot == nil then
    return
  end
  local leftAngle = self.HOOK_SWING_LEFT_ANGLE
  local rightAngle = self.HOOK_SWING_RIGHT_ANGLE
  if self._swingAtRight then
    self._swingGoingRight = false
    self:_DoSwingPhase(rightAngle, leftAngle, function()
      self._swingAtRight = false
      self:_ChainSwing()
    end)
  else
    self._swingGoingRight = true
    self:_DoSwingPhase(leftAngle, rightAngle, function()
      self._swingAtRight = true
      self:_ChainSwing()
    end)
  end
end

function GoldenSpyHookCtrl:StartSwing(leftAngle, rightAngle)
  if self._hookState == HookStage.STATE_EXTENDING or self._hookState == HookStage.STATE_RETRACTING then
    return
  end
  self:StopSwing()
  self:StopExtend()
  self:StopRetract()
  if self.tempHookType == AllEnum.GoldenSpyHookType.Normal then
    self._mapNode.hookRoot:SetActive(true)
    self._mapNode.nethookRoot:SetActive(false)
    self._mapNode.hook_open:SetActive(false)
    self._mapNode.hook_normal:SetActive(true)
    self._mapNode.hook_catched:SetActive(false)
  elseif self.tempHookType == AllEnum.GoldenSpyHookType.FishingHook then
    self._mapNode.hookRoot:SetActive(false)
    self._mapNode.nethookRoot:SetActive(true)
    self._mapNode.nethook_normal:SetActive(true)
    self._mapNode.nethook_catched:SetActive(false)
  end
  local pivot = self._mapNode.trHookPivot
  if pivot == nil then
    return
  end
  self._hookLength = 0
  self:ApplyHookLength()
  self._hookState = HookStage.STATE_SWINGING
  leftAngle = leftAngle or self.HOOK_SWING_LEFT_ANGLE
  rightAngle = rightAngle or self.HOOK_SWING_RIGHT_ANGLE
  self._swingAtRight = false
  self._swingGoingRight = true
  self:_DoSwingPhase(0, rightAngle, function()
    self._swingAtRight = true
    self:_ChainSwing()
  end)
  EventManager.Hit("GoldenSpyHookResumeSwing")
end

function GoldenSpyHookCtrl:CanUseBoom()
  return self.bCanUseBoom or false
end

function GoldenSpyHookCtrl:PauseSwing()
  self:StopSwing()
  if self._hookState == HookStage.STATE_SWINGING then
  end
end

function GoldenSpyHookCtrl:ResumeSwing(fromCurrent)
  local pivot = self._mapNode.trHookPivot
  if pivot == nil then
    return
  end
  local leftAngle = self.HOOK_SWING_LEFT_ANGLE
  local rightAngle = self.HOOK_SWING_RIGHT_ANGLE
  self._hookState = HookStage.STATE_SWINGING
  if fromCurrent then
    self:StopExtend()
    self:StopRetract()
    self:StopSwing()
    local curZ = self:_NormalizeAngleZ(pivot.localEulerAngles.z)
    if self._swingGoingRight then
      self._swingAtRight = false
      self._swingGoingRight = true
      self:_DoSwingPhase(curZ, rightAngle, function()
        self._swingAtRight = true
        self:_ChainSwing()
      end)
    else
      self._swingAtRight = true
      self._swingGoingRight = false
      self:_DoSwingPhase(curZ, leftAngle, function()
        self._swingAtRight = false
        self:_ChainSwing()
      end)
    end
  else
    self:StartSwing()
    return
  end
  EventManager.Hit("GoldenSpyHookResumeSwing")
end

function GoldenSpyHookCtrl:_NormalizeAngleZ(z)
  while 180 < z do
    z = z - 360
  end
  while z < -180 do
    z = z + 360
  end
  return z
end

function GoldenSpyHookCtrl:StopSwing()
  if self._swingTweener ~= nil then
    self._swingTweener:Kill()
    self._swingTweener = nil
  end
end

function GoldenSpyHookCtrl:StartExtend(speed, radius, factor, nMinSpeed, onComplete, onCatched, onCatchedComplete)
  self:StopSwing()
  self:StopExtend()
  self:StopRetract()
  EventManager.Hit("GoldenSpyHookStartExtend")
  local tr = self._mapNode.trHookEnd
  if tr == nil then
    return
  end
  self.tempHookType = self._hookType
  self.tempHookRadius = self._fishingHookRadius
  local maxLength = self:GetCurrentMaxLength()
  self._onExtendComplete = onComplete
  self._hookState = HookStage.STATE_EXTENDING
  local fromLen = self._hookLength
  local duration = (maxLength - fromLen) / speed
  if duration <= 0 then
    self._hookLength = maxLength
    self:ApplyHookLength()
    self._hookState = 0
    if self._onExtendComplete then
      self._onExtendComplete()
      self._onExtendComplete = nil
    end
    return
  end
  self.bCanUseBoom = true
  self._mapNode.hook_open:SetActive(true)
  self._mapNode.hook_normal:SetActive(false)
  self._mapNode.hook_catched:SetActive(false)
  self._extendTweener = DOTween.To(function()
    return self._hookLength
  end, function(v)
    self._hookLength = v
    self:ApplyHookLength()
    local items = self.floorCtrl.tbItem
    for _, item in ipairs(items) do
      local worldPos = self:GetHookEndWorldPosition()
      if self:CheckCatchIntersect(worldPos, radius, item.Ctrl) then
        local itemCfg = item.Ctrl:GetItemCfg()
        if itemCfg.ItemType == GameEnum.GoldenSpyItem.Boom then
          if onCatched then
            local tbCatchItems = {}
            table.insert(tbCatchItems, item.Ctrl)
            onCatched(tbCatchItems)
          end
          item.Ctrl:Boom(nil)
          self:StartRetract(speed, function()
            self:ResumeSwing(true)
            if onCatchedComplete then
              onCatchedComplete(item.Ctrl)
            end
          end)
          return
        end
        if self.tempHookType == AllEnum.GoldenSpyHookType.Normal then
          do
            local tbCatchItems = {}
            table.insert(tbCatchItems, item.Ctrl)
            if onCatched then
              onCatched(tbCatchItems)
            end
            self.tbCatchedItem = tbCatchItems
            if itemCfg.ItemType == GameEnum.GoldenSpyItem.Companion or itemCfg.ItemType == GameEnum.GoldenSpyItem.Patrol then
              item.Ctrl:onCatch()
            end
            for _, item in ipairs(self.tbCatchedItem) do
              item.gameObject.transform:SetParent(self._mapNode.itemParent)
              item.gameObject.transform.localPosition = Vector3.zero
            end
            local itemNormalWeight = item.Ctrl:GetWeight()
            for _, v in ipairs(self:GetBuffData()) do
              local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
              if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.ReduceItemWeight and self.levelData:CheckBuffActive(v) and item.Ctrl:GetItemCfg().ItemType == buffCfg.Params[1] then
                itemNormalWeight = itemNormalWeight - buffCfg.Params[2]
              end
            end
            itemNormalWeight = math.max(0, itemNormalWeight)
            local nbackSpeed = (speed - nMinSpeed) / (1 + -factor / 100 * itemNormalWeight) + nMinSpeed
            if NovaAPI.IsEditorPlatform() then
              print("GoldenSpyLevelCtrl:backSpeed=", nbackSpeed)
            end
            nbackSpeed = math.max(nMinSpeed, nbackSpeed)
            self:StartRetract(nbackSpeed, function()
              self._mapNode.hookRoot:SetActive(true)
              self._mapNode.nethookRoot:SetActive(false)
              self._mapNode.hook_open:SetActive(false)
              self._mapNode.hook_normal:SetActive(true)
              self._mapNode.hook_catched:SetActive(false)
              if onCatchedComplete then
                onCatchedComplete(self.tbCatchedItem)
              end
              for _, item in ipairs(self.tbCatchedItem) do
                item.gameObject:SetActive(false)
              end
              self.tbCatchedItem = {}
            end)
            self:StopExtend()
          end
          break
        end
        if self.tempHookType == AllEnum.GoldenSpyHookType.FishingHook then
          self._mapNode.hookRoot:SetActive(false)
          self._mapNode.nethookRoot:SetActive(true)
          self._mapNode.nethook_normal:SetActive(false)
          self._mapNode.nethook_catched:SetActive(true)
          SpineManager.PlayAnim(self._mapNode.nethook_catched, "open", false)
          WwiseAudioMgr:PostEvent("Mode_steal_net")
          self.bCanUseBoom = false
          local tbCatchItems = self:GetCatchItems()
          local tbBoomItems = {}
          for _, item in ipairs(tbCatchItems) do
            local itemCfg = item:GetItemCfg()
            if itemCfg.ItemType == GameEnum.GoldenSpyItem.Boom then
              local tbRemoveBoomItems = item:Boom(nil)
              for _, v in ipairs(tbRemoveBoomItems) do
                table.insert(tbBoomItems, v)
              end
              self.floorCtrl:RemoveItem(item)
            end
          end
          tbCatchItems = self:GetCatchItems()
          for _, item in ipairs(tbBoomItems) do
            if 0 < table.indexof(tbCatchItems, item) then
              table.remove(tbCatchItems, table.indexof(tbCatchItems, item))
            end
          end
          if onCatched and 0 < #tbCatchItems then
            onCatched(tbCatchItems)
          end
          local bIsBig = false
          for _, item in ipairs(tbCatchItems) do
            local itemCfg = item:GetItemCfg()
            if itemCfg.IsBig then
              bIsBig = true
              break
            end
          end
          local timer = self:AddTimer(1, 0.23, function()
            local nTotalWeight = 0
            for index, itemCtrl in ipairs(tbCatchItems) do
              local itemCfg = itemCtrl:GetItemCfg()
              if itemCfg.ItemType == GameEnum.GoldenSpyItem.Companion or itemCfg.ItemType == GameEnum.GoldenSpyItem.Patrol then
                itemCtrl:onCatch()
              end
              local nIndex = (index - 1) % 9 + 1
              local vOffset = OffsetDir[nIndex]
              itemCtrl.gameObject.transform:SetParent(self._mapNode.itemParent)
              itemCtrl.gameObject.transform.localPosition = Vector3(vOffset.x * math.random(MinOffset, MaxOffset), vOffset.y * math.random(MinOffset, MaxOffset) - 100, 0)
              local itemNormalWeight = itemCtrl:GetWeight()
              for _, v in ipairs(self:GetBuffData()) do
                local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
                if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.ReduceItemWeight and self.levelData:CheckBuffActive(v) and itemCtrl:GetItemCfg().ItemType == buffCfg.Params[1] then
                  itemNormalWeight = itemNormalWeight - buffCfg.Params[2]
                end
              end
              nTotalWeight = nTotalWeight + itemNormalWeight
            end
            local nbackSpeed = (speed - nMinSpeed) / (1 + -factor / 100 * nTotalWeight) + nMinSpeed
            if NovaAPI.IsEditorPlatform() then
              print("GoldenSpyLevelCtrl:backSpeed=", nbackSpeed)
            end
            local sSpineAnim = "catched2"
            if bIsBig then
              sSpineAnim = "catched1"
            end
            SpineManager.PlayAnim(self._mapNode.nethook_catched, sSpineAnim, false)
            self.bCanUseBoom = false
            local timer2 = self:AddTimer(1, 0.16, function()
              self.bCanUseBoom = true
              self:StartRetract(nbackSpeed, function()
                self._mapNode.hookRoot:SetActive(false)
                self._mapNode.nethookRoot:SetActive(true)
                self._mapNode.nethook_normal:SetActive(true)
                self._mapNode.nethook_catched:SetActive(false)
                if onCatchedComplete then
                  onCatchedComplete(tbCatchItems)
                end
                for _, item in ipairs(tbCatchItems) do
                  item.gameObject:SetActive(false)
                end
              end, true)
            end)
            table.insert(self.tbTimers, timer2)
          end, true, true, true)
          table.insert(self.tbTimers, timer)
          self:StopExtend()
        end
        break
      end
    end
  end, maxLength, duration):SetEase(self.HOOK_EXTEND_EASE):SetUpdate(true):OnComplete(function()
    self._extendTweener = nil
    self._hookState = 0
    self:StartRetract(speed, function()
      self:ResumeSwing(true)
      if onCatchedComplete then
        onCatchedComplete(self.tbCatchedItem)
      end
      self.tbCatchedItem = {}
    end)
    if self._onExtendComplete then
      self._onExtendComplete()
      self._onExtendComplete = nil
    end
  end)
end

function GoldenSpyHookCtrl:GetCatchItems()
  local tbCatchItems = {}
  local items = self.floorCtrl.tbItem
  local hookEndPos = self:GetHookEndWorldPosition()
  if self.tempHookType == AllEnum.GoldenSpyHookType.FishingHook then
    hookEndPos = self:GetHookEndWorldPositionWithNet()
  end
  for _, item in ipairs(items) do
    if self:CheckCatchIntersect(hookEndPos, self.tempHookRadius, item.Ctrl) then
      table.insert(tbCatchItems, item.Ctrl)
    end
  end
  return tbCatchItems
end

function GoldenSpyHookCtrl:GetHookEndWorldPosition()
  local rootTr = self.gameObject.transform
  local trEnd = self._mapNode.trHookEnd
  local localPt = rootTr:InverseTransformPoint(trEnd.position)
  return Vector3(localPt.x, localPt.y, 0)
end

function GoldenSpyHookCtrl:GetHookEndWorldPositionWithNet()
  local rootTr = self.gameObject.transform
  local trEnd = self._mapNode.trNet
  local localPt = rootTr:InverseTransformPoint(trEnd.position)
  return Vector3(localPt.x, localPt.y, 0)
end

function GoldenSpyHookCtrl:StopExtend()
  if self._extendTweener ~= nil then
    self._extendTweener:Kill()
    self._extendTweener = nil
  end
  if self._hookState == HookStage.STATE_EXTENDING then
    self._hookState = 0
  end
  self._onExtendComplete = nil
end

function GoldenSpyHookCtrl:PauseExtend()
  if self._extendTweener ~= nil then
    self._extendTweener:Pause()
  end
  if self._hookState == HookStage.STATE_EXTENDING then
  end
end

function GoldenSpyHookCtrl:ResumeExtend()
  if self._extendTweener ~= nil then
    self._extendTweener:Play()
  end
  if self._hookState == HookStage.STATE_EXTENDING then
  end
end

function GoldenSpyHookCtrl:StartRetract(speed, onComplete, bIsCatched)
  bIsCatched = bIsCatched or false
  self:StopSwing()
  self:StopExtend()
  self:StopRetract()
  local tr = self._mapNode.trHookEnd
  if tr == nil then
    if onComplete then
      onComplete()
    end
    return
  end
  if self.tempHookType == AllEnum.GoldenSpyHookType.Normal then
    self._mapNode.hookRoot:SetActive(true)
    self._mapNode.nethookRoot:SetActive(false)
    self._mapNode.hook_open:SetActive(false)
    self._mapNode.hook_normal:SetActive(false)
    self._mapNode.hook_catched:SetActive(true)
  elseif self.tempHookType == AllEnum.GoldenSpyHookType.FishingHook then
    self._mapNode.hookRoot:SetActive(false)
    self._mapNode.nethookRoot:SetActive(true)
    self._mapNode.nethook_normal:SetActive(not bIsCatched)
    self._mapNode.nethook_catched:SetActive(bIsCatched)
  end
  self._onRetractComplete = onComplete
  self._hookState = HookStage.STATE_RETRACTING
  local fromLen = self._hookLength
  local duration = fromLen / speed
  if duration <= 0 then
    self._hookLength = 0
    self:ApplyHookLength()
    self._hookState = 0
    if self._onRetractComplete then
      self._onRetractComplete()
      self._onRetractComplete = nil
    end
    return
  end
  self._retractTweener = DOTween.To(function()
    return self._hookLength
  end, function(v)
    self._hookLength = v
    self:ApplyHookLength()
  end, 0, duration):SetEase(self.HOOK_RETRACT_EASE):SetUpdate(true):OnComplete(function()
    self._retractTweener = nil
    self._hookState = 0
    if self._onRetractComplete then
      self._onRetractComplete()
      self._onRetractComplete = nil
    end
  end):OnKill(function()
    self._retractTweener = nil
    if self._hookState == HookStage.STATE_RETRACTING then
      self._hookState = 0
    end
  end)
end

function GoldenSpyHookCtrl:StopRetract()
  if self._retractTweener ~= nil then
    self._retractTweener:Kill()
    self._retractTweener = nil
  end
  if self._hookState == HookStage.STATE_RETRACTING then
    self._hookState = 0
  end
  self._onRetractComplete = nil
end

function GoldenSpyHookCtrl:SetRetractSpeed(newSpeed)
  if not self:IsRetracting() then
    return
  end
  local onComplete = self._onRetractComplete
  self:StopRetract()
  self:StartRetract(newSpeed, onComplete)
end

function GoldenSpyHookCtrl:PauseRetract()
  if self._retractTweener ~= nil then
    self._retractTweener:Pause()
  end
  if self._hookState == HookStage.STATE_RETRACTING then
  end
end

function GoldenSpyHookCtrl:ResumeRetract()
  if self._retractTweener ~= nil then
    self._retractTweener:Play()
  end
  if self._hookState == HookStage.STATE_RETRACTING then
  end
end

function GoldenSpyHookCtrl:GetHookAngle()
  local pivot = self._mapNode.trHookPivot
  if pivot == nil then
    return 0
  end
  return pivot.localEulerAngles.z
end

function GoldenSpyHookCtrl:GetMaxLengthForAngle(angleDeg)
  local rect = self._mapNode.rtMaxLengthArea
  local trLine = self._mapNode.trLine
  if rect == nil or rect:IsNull() or trLine == nil or trLine:IsNull() then
    return 0
  end
  local lineLocalPos = rect:InverseTransformPoint(trLine.position)
  local sx, sy = lineLocalPos.x, lineLocalPos.y
  local left = 0
  local bottom = 0
  local right = rect.sizeDelta.x
  local top = rect.sizeDelta.y
  local rad = math.rad(angleDeg)
  local worldDir = Vector3(math.sin(rad), -math.cos(rad), 0)
  local localDir = rect:InverseTransformDirection(worldDir)
  local dx, dy = localDir.x, localDir.y
  local lenSq = dx * dx + dy * dy
  if lenSq < 1.0E-12 then
    return 0
  end
  local invLen = 1 / math.sqrt(lenSq)
  dx, dy = dx * invLen, dy * invLen
  local tMin
  if math.abs(dx) > 1.0E-6 then
    local tL = (left - sx) / dx
    if 0 < tL then
      local y = sy + tL * dy
      if bottom <= y and top >= y then
        tMin = tMin == nil and tL or math.min(tMin, tL)
      end
    end
    local tR = (right - sx) / dx
    if 0 < tR then
      local y = sy + tR * dy
      if bottom <= y and top >= y then
        tMin = tMin == nil and tR or math.min(tMin, tR)
      end
    end
  end
  if math.abs(dy) > 1.0E-6 then
    local tB = (bottom - sy) / dy
    if 0 < tB then
      local x = sx + tB * dx
      if left <= x and right >= x then
        tMin = tMin == nil and tB or math.min(tMin, tB)
      end
    end
    local tT = (top - sy) / dy
    if 0 < tT then
      local x = sx + tT * dx
      if left <= x and right >= x then
        tMin = tMin == nil and tT or math.min(tMin, tT)
      end
    end
  end
  return math.max(0, tMin or 0)
end

function GoldenSpyHookCtrl:GetCurrentMaxLength()
  return self:GetMaxLengthForAngle(self:GetHookAngle())
end

function GoldenSpyHookCtrl:_CircleCircleIntersect(hx, hy, hookR, ix, iy, itemR)
  local dx, dy = ix - hx, iy - hy
  local dist2 = dx * dx + dy * dy
  local sumR = hookR + (itemR or 0)
  return dist2 <= sumR * sumR
end

function GoldenSpyHookCtrl:_CircleRectIntersect(hx, hy, hookR, cx, cy, width, height)
  local hw = (width or 0) * 0.5
  local hh = (height or 0) * 0.5
  local px = hx
  if px < cx - hw then
    px = cx - hw
  elseif px > cx + hw then
    px = cx + hw
  end
  local py = hy
  if py < cy - hh then
    py = cy - hh
  elseif py > cy + hh then
    py = cy + hh
  end
  local dx, dy = hx - px, hy - py
  local dist2 = dx * dx + dy * dy
  return dist2 <= hookR * hookR
end

function GoldenSpyHookCtrl:CheckCatchIntersect(hookWorldPos, hookRadius, item)
  if hookWorldPos == nil or not item then
    return false
  end
  local hx, hy = hookWorldPos.x, hookWorldPos.y
  local hitArea = item:GetHitArea()
  local ix, iy = hitArea.center.x, hitArea.center.y
  if hitArea.nType == AllEnum.GoldenSpyHitAreaType.Circle then
    return self:_CircleCircleIntersect(hx, hy, hookRadius, ix, iy, (hitArea.width or 0) / 2)
  elseif hitArea.nType == AllEnum.GoldenSpyHitAreaType.Rectangle then
    return self:_CircleRectIntersect(hx, hy, hookRadius, ix, iy, hitArea.width or 0, hitArea.height or 0)
  end
  return self:_CircleCircleIntersect(hx, hy, hookRadius, ix, iy, item.radius or 0)
end

function GoldenSpyHookCtrl:CheckCatchInRadius(hookWorldPos, radius, items)
  if not (hookWorldPos ~= nil and items) or #items == 0 then
    return nil
  end
  for i = 1, #items do
    local item = items[i]
    if self:CheckCatchIntersect(hookWorldPos, radius, item) then
      return item
    end
  end
  return nil
end

function GoldenSpyHookCtrl:GetHookLength()
  return self._hookLength
end

function GoldenSpyHookCtrl:GetState()
  return self._hookState
end

function GoldenSpyHookCtrl:IsSwinging()
  return self._hookState == HookStage.STATE_SWINGING
end

function GoldenSpyHookCtrl:IsExtending()
  return self._hookState == HookStage.STATE_EXTENDING
end

function GoldenSpyHookCtrl:IsRetracting()
  return self._hookState == HookStage.STATE_RETRACTING
end

function GoldenSpyHookCtrl:DropItem()
  self.tbCatchedItem = {}
end

function GoldenSpyHookCtrl:OnDestroy()
  self:StopSwing()
  self:StopExtend()
  self:StopRetract()
end

function GoldenSpyHookCtrl:GetBuffData()
  return self.levelData:GetBuffData()
end

function GoldenSpyHookCtrl:Pause()
  if self:IsSwinging() then
    self:PauseSwing()
  end
  if self:IsExtending() then
    self:PauseExtend()
  end
  if self:IsRetracting() then
    self:PauseRetract()
  end
  for _, v in ipairs(self.tbTimers) do
    if v ~= nil then
      v:Pause(true)
    end
  end
  SpineManager.Pause(self._mapNode.nethook_catched)
end

function GoldenSpyHookCtrl:Continue()
  if self:IsSwinging() then
    self:ResumeSwing(true)
  end
  if self:IsExtending() then
    self:ResumeExtend()
  end
  if self:IsRetracting() then
    self:ResumeRetract()
  end
  for _, v in ipairs(self.tbTimers) do
    if v ~= nil then
      v:Pause(false)
    end
  end
  SpineManager.Resume(self._mapNode.nethook_catched)
end

function GoldenSpyHookCtrl:Exit()
  self:StopSwing()
  self:StopExtend()
  self:StopRetract()
end

function GoldenSpyHookCtrl:OnEvent_GM_GoldenSpy_Show()
  self._mapNode.net_Hook:SetActive(true)
end

return GoldenSpyHookCtrl
