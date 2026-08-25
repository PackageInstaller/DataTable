local Instantiate = CS.UnityEngine.GameObject.Instantiate
local DestroyGameObject = CS.UnityEngine.GameObject.Destroy
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local DefaultBlessingUseEffectPath = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_B11_Support.prefab"
local DefaultBlessingUseAnimName = "UI_Vx_Battle_B11_Support"
local DefaultSfxDuration = 1.5
local CardBlessingUse = System.NewClass("CardBlessingUse", CardBaseAnimState)

function CardBlessingUse:_GetGameSpeed()
  local speed = bg.battleRender and bg.battleRender.gameSpeed
  if not speed or speed <= 0 then
    return 1
  end
  return speed
end

function CardBlessingUse:_GetAwaiterOverTime(srcHold, sfxDuration, dstHold)
  local playWallTime = math.max(3, (srcHold or 0) + (sfxDuration or 0) + (dstHold or 0) + 0.5)
  return playWallTime * self:_GetGameSpeed()
end

function CardBlessingUse:_DispatchAnimAwaiter(overTime)
  self:_CompleteAnimAwaiter()
  local uid = self:GetUid() or 0
  self.animAwaiter = Awaiter.Dispatch("CardBlessingUse_" .. tostring(uid), overTime or 3, true)
end

function CardBlessingUse:_CompleteAnimAwaiter()
  if self.animAwaiter then
    self.animAwaiter:SetCompleted()
    self.animAwaiter = nil
  end
end

function CardBlessingUse:_ClearStepTimer()
  if self.stepTimer then
    TimerManager.Instance:StopTimer(self.stepTimer)
    self.stepTimer = nil
  end
end

function CardBlessingUse:_CanContinue()
  if self.playFinished or not self.isEntered then
    return false
  end
  local cardItem = self.cardItem
  if not (cardItem and cardItem.binder) or cardItem.binder:isDestroyed() then
    return false
  end
  return true
end

function CardBlessingUse:_Delay(seconds, callback)
  self:_ClearStepTimer()
  if not seconds or seconds <= 0 then
    if callback and self:_CanContinue() then
      callback()
    end
    return
  end
  self.stepTimer = TimerManager.Instance:CreateTimer(seconds, 0, nil, function()
    self.stepTimer = nil
    if callback and self:_CanContinue() then
      callback()
    end
  end)
end

function CardBlessingUse:_MsToSec(ms)
  do return math.max, 0 end
  return math.max, 0, (tonumber(ms) or 0) / 1000, ms
end

function CardBlessingUse:_GetSfxDuration(sfxId)
  if not sfxId then
    return DefaultSfxDuration
  end
  local sfxCfg = DT.BattleSfxConfig and DT.BattleSfxConfig[sfxId]
  if sfxCfg and sfxCfg.Time and sfxCfg.Time > 0 then
    return sfxCfg.Time
  end
  return DefaultSfxDuration
end

function CardBlessingUse:_GetEffectPathAndAnim(sfxId)
  if not sfxId then
    return DefaultBlessingUseEffectPath, DefaultBlessingUseAnimName
  end
  local sfxCfg = DT.BattleSfxConfig and DT.BattleSfxConfig[sfxId]
  if not sfxCfg or not sfxCfg.FileName then
    return DefaultBlessingUseEffectPath, DefaultBlessingUseAnimName
  end
  local path = sfxCfg.FileName
  local animName = string.match(path, "([^/]+)%.prefab$") or DefaultBlessingUseAnimName
  return path, animName
end

function CardBlessingUse:DoEnter(...)
  if not self.cardItem then
    Logger.Warn("状态进入失败", self.__name)
    return
  end
  LinearFsmState.DoEnter(self, ...)
end

function CardBlessingUse:Enter(displayData)
  if self:IsPVPEnemySide() then
    self:SetFinish()
    self:FreeCardItem(true)
    return
  end
  self:ResetTwSequence()
  self.playFinished = false
  self.hardCutDone = false
  self.effectEnded = false
  self.displayData = displayData or {}
  local srcHold = self:_MsToSec(self.displayData.srcHoldTimeMs)
  local dstHold = self:_MsToSec(self.displayData.dstHoldTimeMs)
  local sfxDuration = self:_GetSfxDuration(self.displayData.sfxId)
  self:_DispatchAnimAwaiter(self:_GetAwaiterOverTime(srcHold, sfxDuration, dstHold))
  self.cardItem:SetShowLight(false)
  self.cardItem:SetVxChooseShow(false)
  self.cardItem:SetClickable(false)
  self.cardItem:SetIsNeedHighDescMode(false)
  if self.cardItem.cardBaseUI and self.cardItem.binder then
    self.cardItem.binder:SetActive(self.cardItem.cardBaseUI.uiNode, true)
  end
  local cardUI = self:GetCardUI()
  if cardUI then
    cardUI:MarkDetachAnimCardItem(self.cardItem)
    if cardUI.uiDelegate then
      self.cardItem.rootRectTransform:SetParent(cardUI.uiDelegate:GetTransform(), true)
    end
  end
  if not IsNil(self.cardItem.rootRectTransform) then
    self.cardItem.rootRectTransform.anchoredPosition = Vector2(0, 0)
    self.cardItem.rootRectTransform.localScale = Vector3(1, 1, 1)
    self.cardItem.rootRectTransform.localEulerAngles = Vector3(0, 0, 0)
  end
  self:_Delay(srcHold, function()
    if self.playFinished then
      return
    end
    self:_PlayChangeEffect()
  end)
end

function CardBlessingUse:_PlayChangeEffect()
  if not self:_CanContinue() then
    self:FinishPlay()
    return
  end
  local sfxId = self.displayData.sfxId
  local sfxDuration = self:_GetSfxDuration(sfxId)
  local cutDelay = math.min(0.35, sfxDuration * 0.4)
  local effectPath, animName = self:_GetEffectPathAndAnim(sfxId)
  local cardContent = self.cardItem.cardBaseUI and self.cardItem.cardBaseUI.Card_Content
  if not (cardContent and self.binder) or self.binder:isDestroyed() then
    self:_HardCutToTargetCard()
    self:_OnEffectEnded()
    return
  end
  local asset = self.binder:LoadAsset(effectPath)
  if not asset then
    self:_HardCutToTargetCard()
    self:_OnEffectEnded()
    return
  end
  self:DestroyEffectGo()
  self.effectGo = Instantiate(asset)
  self.effectGo.name = animName
  UIUtils.RemoveCloneName(self.effectGo)
  self.effectGo.transform:SetParent(cardContent.transform, false)
  self.effectGo.transform.localPosition = Vector3(0, 0, 0)
  self.effectGo.transform.localScale = Vector3(1, 1, 1)
  if sfxId then
    BattleAudioUtil.PlaySfxAudio(sfxId, self.cardItem.myCamp or bc.BattleCamp.Camp1, self.effectGo)
  end
  self:_Delay(cutDelay, function()
    self:_HardCutToTargetCard()
  end)
  self.cardItem:PlayState(animName, function()
    if self:_CanContinue() then
      self:_OnEffectEnded()
    end
  end)
  self:_ClearFinishDelayTimer()
  self.delayFinishTimer = TimerManager.Instance:CreateTimer(math.max(sfxDuration, 2), 0, nil, function()
    self.delayFinishTimer = nil
    if self:_CanContinue() then
      self:_OnEffectEnded()
    end
  end)
end

function CardBlessingUse:_HardCutToTargetCard()
  if self.hardCutDone or not self:_CanContinue() then
    return
  end
  self.hardCutDone = true
  local skillTid = self.displayData and self.displayData.skillTid
  if skillTid then
    self.cardItem:ApplyDisplaySkillTid(skillTid, self.displayData)
  end
end

function CardBlessingUse:_OnEffectEnded()
  if self.effectEnded or self.playFinished then
    return
  end
  if not self:_CanContinue() then
    self:FinishPlay()
    return
  end
  self.effectEnded = true
  if not self.hardCutDone then
    self:_HardCutToTargetCard()
  end
  local dstHold = self:_MsToSec(self.displayData and self.displayData.dstHoldTimeMs)
  self:_Delay(dstHold, function()
    self:FinishPlay()
  end)
end

function CardBlessingUse:_ClearDisplayFlags()
  local cardItem = self.cardItem
  if not cardItem then
    return
  end
  cardItem.isBlessingDisplay = nil
  cardItem._lockedDisplayDesc = nil
  local card = cardItem.card and cardItem.card.value
  if card and card.config then
    card.config.isDisplay = false
  end
end

function CardBlessingUse:FinishPlay()
  if self.playFinished then
    return
  end
  self.playFinished = true
  self:_ClearStepTimer()
  self:_ClearFinishDelayTimer()
  self:_CompleteAnimAwaiter()
  self:DestroyEffectGo()
  if self.cardItem then
    self.cardItem:StopAnim()
  end
  local cardUI = self:GetCardUI()
  if cardUI then
    cardUI:ClearDetachAnimCardItem(self.cardItem)
  end
  self:_ClearDisplayFlags()
  self:FreeCardItem()
end

function CardBlessingUse:DestroyEffectGo()
  if self.effectGo and not IsNil(self.effectGo) then
    DestroyGameObject(self.effectGo)
  end
  self.effectGo = nil
end

function CardBlessingUse:Exit()
  self.playFinished = true
  self:_ClearStepTimer()
  self:_ClearFinishDelayTimer()
  self:_CompleteAnimAwaiter()
  self:DestroyEffectGo()
  if self.cardItem then
    self.cardItem:StopAnim()
  end
  local cardUI = self:GetCardUI()
  if cardUI then
    cardUI:ClearDetachAnimCardItem(self.cardItem)
  end
  self:_ClearDisplayFlags()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
end

return CardBlessingUse
