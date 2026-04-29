_class("BuffViewShadowChain", BuffViewBase)
BuffViewShadowChain = BuffViewShadowChain

function BuffViewShadowChain:PlayView(TT)
  local result = self._buffResult
  local shadowPrefab = result:GetShadowPrefab()
  local shadowCreate = result:GetShadowCreate()
  local petPstID = result:GetPetPstID()
  local shadowEntityID = result:GetShadowEntityID()
  local bvcmpt = self._entity:BuffView()
  bvcmpt:SetBuffValue("ShadowChainEntityID", shadowEntityID)
  local shadowEntity = self._world:GetEntityByID(shadowEntityID)
  local petPrefab
  if shadowPrefab then
    petPrefab = shadowPrefab
  else
    local petData = self._world:GetPetData(petPstID)
    petPrefab = petData:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
  end
  if shadowCreate == 1 then
    shadowEntity:ReplaceAsset(NativeUnityPrefabAsset:New(petPrefab, false))
    local ancName = HelperProxy:GetPetAnimatorControllerName(petPrefab, PetAnimatorControllerType.Battle)
    if ancName then
      local req2 = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
      local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animator))
      if anim == nil then
        Log.fatal("找不到Animator组件，加载pet模型失败：", ancName)
        return nil
      end
      local pet = shadowEntity:View().ViewWrapper.GameObject
      local petAnim = pet:GetComponentInChildren(typeof(UnityEngine.Animator))
      petAnim.runtimeAnimatorController = anim.runtimeAnimatorController
    end
  end
  if shadowEntity then
    shadowEntity:AddPetShadowRender()
    local petShadowRenderComponent = shadowEntity:PetShadowRender()
    local ownerEntityID = result:GetOwnerEntityID()
    petShadowRenderComponent:SetOwnerEntityID(ownerEntityID)
  end
end
