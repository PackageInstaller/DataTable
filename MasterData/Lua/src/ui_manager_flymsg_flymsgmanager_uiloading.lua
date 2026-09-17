local this = {}
local uiLoadingPrefab = "Program/FlyMsg/pre_uiLoading.prefab"

function this:showUILoading(data)
  if L_CommonUtil.isValid(self.uiLoadingObj) then
    if self.tween then
      self.tween:Kill()
      self.tween = nil
    end
    if self.secondTween then
      self.secondTween:Kill()
      self.secondTween = nil
    end
    L_TimerManager:stopTimer(self, "close")
  end
  if not L_CommonUtil.isValid(self.uiLoadingObj) then
    self.uiLoadingObj = C_UIMgr.uiLoader:Spawn(uiLoadingPrefab, self.normalRoot)
  end
  local trans = self.uiLoadingObj.transform
  local uibinding = self.uiLoadingObj:GetComponent(typeof(C_UIBinding))
  trans:SetParent(self.normalRoot)
  self.uiLoadingTxt = uibinding:GetBindComponent("Text")
  self.fillImage = uibinding:GetBindComponent("fill")
  self.animation = uibinding:GetBindComponent("root")
  self.isOpen = true
  self.uiLoadingObj:SetActive(true)
  if self.uiLoadingTxt and data then
    self.animation:Stop()
    self.animation:Play("anim_battle_leavewall_in")
    self.fillImage.fillAmount = 0
    self.uiLoadingTxt.text = data.text or "Loading..."
    
    local function getter()
      if self.uiLoadingObj then
        return self.fillImage.fillAmount
      else
        return 0
      end
    end
    
    local function setter(r)
      if self.uiLoadingObj then
        self.fillImage.fillAmount = r
      end
    end
    
    local time = data.time or 2
    self.tween = DOTween.To(getter, setter, 0.9, time):SetEase(Tweening.Ease.InOutQuart):OnComplete(function()
      if self.tween then
        self.secondTween = DOTween.To(getter, setter, 1, 4):SetEase(Tweening.Ease.Linear)
      end
    end)
  end
end

function this:closeUILoading(force)
  if not self.isOpen then
    return
  end
  self.isOpen = false
  if not self.uiLoadingObj then
    return
  end
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
  if self.secondTween then
    self.secondTween:Kill()
    self.secondTween = nil
  end
  if force then
    self:internalClose()
    return
  end
  self.animation:Play("anim_battle_leavewall_out")
  self.fillImage.fillAmount = 1
  L_TimerManager:newOrResetTimer(self, "close", function()
    if not self.isOpen then
      self:internalClose()
    end
  end, 1)
end

function this:internalClose()
  if L_CommonUtil.isValid(self.uiLoadingObj) then
    C_PrefabManager:Destroy(self.uiLoadingObj)
    self.uiLoadingObj = nil
  end
end

function this:disposeUILoading()
  L_TimerManager:clearTimer(self)
  if L_CommonUtil.isValid(self.uiLoadingObj) then
    C_PrefabManager:Destroy(self.uiLoadingObj)
    self.uiLoadingObj = nil
  end
end

return this
