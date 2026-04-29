_class("AircraftPetRequestBase", Object)
AircraftPetRequestBase = AircraftPetRequestBase

function AircraftPetRequestBase:Constructor(petID, pstID, assetName, clickAnimClip)
  self._petID = petID
  self._pstID = pstID
  self._assetName = assetName
  self._clickAnimClip = clickAnimClip
  self._petGameObject = nil
  self._petAnimation = nil
end

function AircraftPetRequestBase:PetGameObject()
  return self._petGameObject
end

function AircraftPetRequestBase:Dispose()
  AirError("子类需要重写该方法")
end

function AircraftPetRequestBase:ClickAnimClip()
  return self._clickAnimClip
end

function AircraftPetRequestBase:makePet()
  local anim = self._petAnimation
  if anim == nil then
    Log.fatal("找不到Animation组件，加载pet模型失败：", self._assetName)
    return
  end
  if anim.clip == nil then
    Log.exception("星灵没有默认的Stand动作：", self._assetName)
    return
  end
  local petGo = self._petGameObject
  local root = petGo.transform:Find("Root").gameObject
  local animator = root:GetComponent(typeof(UnityEngine.Animator))
  if animator then
    UnityEngine.Object.Destroy(animator)
  end
  local petAnim = root:AddComponent(typeof(UnityEngine.Animation))
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(anim)
  for i = 0, clips.Length - 1 do
    local clip = clips[i]
    if clip == nil then
      Log.exception("星灵动作为空:", self._assetName, "，索引：", i)
    else
      petAnim:AddClip(clip, clip.name)
    end
  end
  petAnim.clip = anim.clip
end
