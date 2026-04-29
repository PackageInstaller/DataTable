_class("SeasonSceneGiantLizard", SeasonSceneEnvironmentBase)
SeasonSceneGiantLizard = SeasonSceneGiantLizard

function SeasonSceneGiantLizard:Constructor(sceneRoot)
  self._transform = sceneRoot.transform:Find(SeasonSceneLayer.Building .. "/zone2/S1_pfb_daxiyi")
  if not self._transform then
    Log.error("SeasonSceneGiantLizard S1_pfb_daxiyi not exist.")
    return
  end
  self._gameObject = self._transform.gameObject
  self._materialAnimation = self._gameObject:GetComponentInChildren(typeof(MaterialAnimation))
  self._effect = sceneRoot.transform:Find(SeasonSceneLayer.Building .. "/zone2/eff_Scene_daxiyi_penqi")
  if not self._effect then
    Log.error("SeasonSceneGiantLizard eff_Scene_daxiyi_penqi not exist.")
  end
  self._effectGO = self._effect.gameObject
  self._effectGO:SetActive(false)
  self._animator = self._gameObject:GetComponent(typeof(UnityEngine.Animator))
  self._curAnim = nil
  self._randomAnims = {
    [1] = {name = "idle", length = 6000},
    [2] = {name = "haqi", length = 4000},
    [3] = {name = "shou", length = 3333}
  }
  self._isUnLock = false
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self:RandomAnimation()
end

function SeasonSceneGiantLizard:Update(deltaTime)
  if self._transform then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._time = 0
      self:RandomAnimation()
    end
  end
  self._seasonManager:SeasonAudioManager():GetSeasonAudio():SetLizardVolume()
end

function SeasonSceneGiantLizard:Dispose()
end

function SeasonSceneGiantLizard:UnLock(unlock)
  self._isUnLock = unlock
end

function SeasonSceneGiantLizard:RandomAnimation()
  if not self._curAnim or self._curAnim.name ~= self._randomAnims[1].name or not self._isUnLock then
    self._curAnim = self._randomAnims[1]
  else
    self._curAnim = self._randomAnims[math.random(2, 3)]
  end
  self._time = self._curAnim.length
  self._animator:SetTrigger(self._curAnim.name)
  if self._seasonManager:SeasonAudioManager():GetSeasonAudio() then
    self._seasonManager:SeasonAudioManager():GetSeasonAudio():PlayLizardAudio(self._curAnim.name)
  end
  if self._curAnim.name == self._randomAnims[1].name then
    self._effectGO:SetActive(false)
    if self._materialAnimation then
      self._materialAnimation:Stop()
    end
  elseif self._curAnim.name == self._randomAnims[2].name then
    self._effectGO:SetActive(true)
    if self._materialAnimation then
      self._materialAnimation:Play()
    end
  else
    self._effectGO:SetActive(false)
    if self._materialAnimation then
      self._materialAnimation:Stop()
    end
  end
end
