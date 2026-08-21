require("base_ins_r")
_class("PlayHorsemanIntroInstruction", BaseInstruction)
PlayHorsemanIntroInstruction = PlayHorsemanIntroInstruction

function PlayHorsemanIntroInstruction:Constructor(paramList)
  self._introModelAssetName = paramList.introModel
  self._introAnimateTrigger = paramList.introAnimateTrigger
  self._introMaterialAnimateName = paramList.introMaterialAnimateName
  self._introEffectID = tonumber(paramList.introEffectID)
  self._introShaderEffectAssetName = paramList.introShaderEffectAssetName or "2904901_shader_effects.asset"
  self._introStateTimeMs = tonumber(paramList.introStateTimeMs)
  self._realIntroEffectID = tonumber(paramList.realIntroEffectID)
  self._realMaterialAnimateName = paramList.realMaterialAnimateName
  self._realStateTimeMs = tonumber(paramList.realStateTimeMs)
end

function PlayHorsemanIntroInstruction:GetCacheResource()
  return {
    self:GetEffectResCacheInfo(self._introEffectID),
    self:GetEffectResCacheInfo(self._realIntroEffectID),
    {
      self._introModelAssetName,
      1
    }
  }
end

function PlayHorsemanIntroInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local env = self:CreateInstructionEnv(casterEntity)
  self:_ShowHideRootRenderer(casterEntity, false)
  env.nul = casterEntity:HasEffectHolder() or casterEntity:AddEffectHolder()
  local cEffectHolder = casterEntity:EffectHolder()
  local introModelEntity = env.effectService:CreateEffectEntity()
  cEffectHolder:AttachPermanentEffect(introModelEntity:GetID())
  introModelEntity:ReplaceAsset(NativeUnityPrefabAsset:New(self._introModelAssetName))
  introModelEntity:SetViewVisible(true)
  introModelEntity:SetLocation(casterEntity:GetRenderGridPosition(), casterEntity:GetRenderGridDirection())
  introModelEntity:SetAnimatorControllerTriggers({
    self._introAnimateTrigger
  })
  env.effectService:CreateEffect(self._introEffectID, introModelEntity)
  local csgoIntroModel = introModelEntity:View():GetGameObject()
  local resServ = env.world.BW_Services.ResourcesPool
  local container = resServ:LoadAsset("globalShaderEffects.asset")
  local csMaterialAnimation = csgoIntroModel:GetComponent(typeof(MaterialAnimation))
  if not csMaterialAnimation or tostring(csMaterialAnimation) == "null" then
    csMaterialAnimation = csgoIntroModel:AddComponent(typeof(MaterialAnimation))
  end
  local shaderEffectAsset = resServ:LoadAsset(self._introShaderEffectAssetName)
  introModelEntity:AddMaterialAnimationComponent(container, csMaterialAnimation)
  introModelEntity:MaterialAnimationComponent():LoadContainer(shaderEffectAsset)
  introModelEntity:MaterialAnimationComponent():Play(self._introMaterialAnimateName)
  YIELD(TT, self._introStateTimeMs)
  env.effectService:CreateEffect(self._realIntroEffectID, casterEntity)
  YIELD(TT, self._realStateTimeMs)
  introModelEntity:SetViewVisible(false)
  self:_ShowHideRootRenderer(casterEntity, true)
  casterEntity:MaterialAnimationComponent():Play(self._realMaterialAnimateName)
end

function PlayHorsemanIntroInstruction:_ShowHideRootRenderer(entity, renderEnabled)
  local cView = entity:View()
  local CSGameObject = cView:GetGameObject()
  local CSGameObjectRoot = CSGameObject.transform:Find("Root")
  local tSkinnedMeshRender = CSGameObjectRoot.transform:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  for i = 0, tSkinnedMeshRender.Length - 1 do
    tSkinnedMeshRender[i].enabled = renderEnabled
  end
end
