require("base_ins_r")
_class("PlayReplaceTrapModelInstruction", BaseInstruction)
PlayReplaceTrapModelInstruction = PlayReplaceTrapModelInstruction

function PlayReplaceTrapModelInstruction:Constructor(paramList)
  local trapList = string.split(paramList.trapID, "|")
  self._trapIDList = {}
  for i, trapID in ipairs(trapList) do
    table.insert(self._trapIDList, tonumber(trapID))
  end
  self._replacePrefab = paramList.replacePrefab
  self._isPetModel = paramList.isPetModel
  self._needMaterial = paramList.needMaterial
end

function PlayReplaceTrapModelInstruction:GetCacheResource()
  local t = {}
  table.insert(t, {
    self._replacePrefab,
    1
  })
  return t
end

function PlayReplaceTrapModelInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local allTrapEntity = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for i, trapEntity in ipairs(allTrapEntity) do
    if not trapEntity:HasDeadMark() then
      local trapRenderCmpt = trapEntity:TrapRender()
      local trapID = trapRenderCmpt:GetTrapID()
      if table.icontains(self._trapIDList, trapID) then
        if self._isPetModel then
          local resServ = self._world.BW_Services.ResourcesPool
          resServ:DestroyView(trapEntity:View().ViewWrapper)
          local ancName = HelperProxy:GetInstance():GetPetAnimatorControllerName(self._replacePrefab, PetAnimatorControllerType.Battle)
          local ancRes = resServ:LoadGameObject(ancName)
          local resRequest = resServ:LoadGameObject(self._replacePrefab)
          local viewWrapper = UnityPetViewWrapper:New(resServ, resRequest, ancRes)
          viewWrapper:SetVisible(true)
          trapEntity:ReplaceView(viewWrapper)
          local tranRenderSvc = self._world:GetService("TransformRenderer")
          tranRenderSvc:SimpleSyncLocation(trapEntity)
        else
          trapEntity:ReplaceAsset(NativeUnityPrefabAsset:New(self._replacePrefab, true))
        end
        if self._needMaterial then
          local viewCmpt = trapEntity:View()
          local viewWrapper = viewCmpt:GetViewWrapper()
          local matAnimMonoCmpt = viewWrapper.GameObject:GetComponent(typeof(MaterialAnimation))
          if matAnimMonoCmpt then
            UnityEngine.Object.Destroy(matAnimMonoCmpt)
          end
          matAnimMonoCmpt = viewWrapper.GameObject:AddComponent(typeof(MaterialAnimation))
          trapEntity:RemoveMaterialAnimationComponent()
          local resServ = self._world.BW_Services.ResourcesPool
          local container = resServ:LoadAsset("globalShaderEffects.asset")
          assert(container)
          trapEntity:AddMaterialAnimationComponent(container, matAnimMonoCmpt)
        else
          local viewCmpt = trapEntity:View()
          local viewWrapper = viewCmpt:GetViewWrapper()
          local matAnimMonoCmpt = viewWrapper.GameObject:GetComponent(typeof(MaterialAnimation))
          if matAnimMonoCmpt then
            UnityEngine.Object.Destroy(matAnimMonoCmpt)
          end
          trapEntity:RemoveMaterialAnimationComponent()
        end
      end
    end
  end
end
