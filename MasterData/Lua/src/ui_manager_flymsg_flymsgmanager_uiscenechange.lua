local this = {}
local uiLoadingPrefab = "UI/Pages/CutIn/pageCutInEntrust.prefab"

function this:showUISceneChange()
  if L_CommonUtil.isValid(self.uiSenceChangeObj) then
    L_TimerManager:stopTimer(self, "close")
  end
  if not L_CommonUtil.isValid(self.uiSenceChangeObj) then
    self.uiSenceChangeObj = C_UIMgr.uiLoader:Spawn(uiLoadingPrefab, self.normalRoot)
  end
  local trans = self.uiSenceChangeObj.transform
  trans:SetParent(self.normalRoot)
  self.animation = self.uiSenceChangeObj:GetComponent(typeof(C_Animation))
  self.isOpen = true
  self.uiSenceChangeObj:SetActive(true)
  if self.animation then
    self.animation:Stop()
    self.animation:Play("anim_cutin_entrust_show")
  end
end

function this:closeUISceneChange(force)
  if not self.isOpen then
    return
  end
  self.isOpen = false
  if not self.uiSenceChangeObj then
    return
  end
  if force then
    self:internalUiSceneClose()
    return
  end
  self.animation:Play("anim_cutin_entrust_hide")
  L_TimerManager:newOrResetTimer(self, "close", function()
    if not self.isOpen then
      self:internalUiSceneClose()
    end
  end, 1)
end

function this:internalUiSceneClose()
  if L_CommonUtil.isValid(self.uiSenceChangeObj) then
    C_PrefabManager:Destroy(self.uiSenceChangeObj)
    self.uiSenceChangeObj = nil
  end
end

function this:disposeUISceneChange()
  L_TimerManager:clearTimer(self)
  if L_CommonUtil.isValid(self.uiSenceChangeObj) then
    C_PrefabManager:Destroy(self.uiSenceChangeObj)
    self.uiSenceChangeObj = nil
  end
end

return this
