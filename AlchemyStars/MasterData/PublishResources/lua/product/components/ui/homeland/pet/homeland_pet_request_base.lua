_class("HomelandPetRequestBase", Object)
HomelandPetRequestBase = HomelandPetRequestBase

function HomelandPetRequestBase:Constructor(petID, pstID, assetName, clickAnimClip)
  self._petID = petID
  self._pstID = pstID
  self._assetName = assetName
  self._clickAnimClip = clickAnimClip
  self._petGameObject = nil
  self._aircraftAnimation = nil
  self._homelandAnimation = nil
  self._petAnim = nil
end

function HomelandPetRequestBase:PetGameObject()
  return self._petGameObject
end

function HomelandPetRequestBase:PetAnimation()
  return self._petAnim
end

function HomelandPetRequestBase:Dispose()
end

function HomelandPetRequestBase:ClickAnimClip()
  return self._clickAnimClip
end

function HomelandPetRequestBase:MakePet()
  if self._aircraftAnimation == nil then
    Log.error("Can not find animation component, load pet module fail.", self._petID)
    return
  end
  if self._aircraftAnimation.clip == nil then
    Log.error("Pet have not Stand animation.", self._petID)
    return
  end
  local root = self._petGameObject.transform:Find("Root").gameObject
  local animator = root:GetComponent(typeof(UnityEngine.Animator))
  if animator then
    UnityEngine.Object.Destroy(animator)
  end
  local petAnim = root:AddComponent(typeof(UnityEngine.Animation))
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(self._aircraftAnimation)
  for i = 0, clips.Length - 1 do
    if clips[i] == nil then
      Log.error("Pet animation is null:", self._petID, ", index:", i)
    else
      petAnim:AddClip(clips[i], clips[i].name)
    end
  end
  if self._homelandAnimation ~= nil then
    clips = HelperProxy:GetInstance():GetAllAnimationClip(self._homelandAnimation)
    for i = 0, clips.Length - 1 do
      if clips[i] == nil then
        Log.error("Pet animation is null:", self._petID, ", index:", i)
      else
        petAnim:AddClip(clips[i], clips[i].name)
      end
    end
  end
  petAnim.clip = self._aircraftAnimation.clip
  self._petAnim = petAnim
end
