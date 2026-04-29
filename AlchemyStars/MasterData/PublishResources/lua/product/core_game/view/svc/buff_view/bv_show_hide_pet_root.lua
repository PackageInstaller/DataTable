_class("BuffViewShowHidePetRoot", BuffViewBase)
BuffViewShowHidePetRoot = BuffViewShowHidePetRoot

function BuffViewShowHidePetRoot:IsNotifyMatch(notify)
  if notify:GetNotifyType() == NotifyType.Benumbed then
    return self:GetBuffResult().notifyEntityID == notify:GetNotifyEntity():GetID()
  end
  return true
end

function BuffViewShowHidePetRoot:_ShowHideRootRenderer(renderEnabled)
  local cView = self._entity:View()
  local CSGameObject = cView:GetGameObject()
  local CSGameObjectRoot = CSGameObject.transform:Find("Root")
  local tSkinnedMeshRender = CSGameObjectRoot.transform:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  for i = 0, tSkinnedMeshRender.Length - 1 do
    tSkinnedMeshRender[i].enabled = renderEnabled
  end
end

function BuffViewShowHidePetRoot:PlayView(TT)
  local result = self._buffResult
  local renderEnabled = result.state == 1
  local fxsvc = self._world:GetService("Effect")
  local buffOwnerEntity = self._entity
  if not renderEnabled then
    buffOwnerEntity:SetAnimatorControllerBools({Move = false})
    YIELD(TT)
    buffOwnerEntity:SetAnimatorControllerTriggers({
      result.hideAnimatorTrigger
    })
    fxsvc:CreatePositionEffect(result.hideEffectID, buffOwnerEntity:GetRenderGridPosition())
    YIELD(TT, result.hideTime)
    self:_ShowHideRootRenderer(false)
    if result.showModelAtLinkageEnd then
      local effectHolder = self._entity:EffectHolder()
      if not effectHolder then
        self._entity:AddEffectHolder()
        effectHolder = self._entity:EffectHolder()
      end
      local tEffect = effectHolder:GetEffectList("BuffViewShowHidePetRoot") or {}
      local avatarEffectEntity = tEffect[1]
      if not avatarEffectEntity then
        avatarEffectEntity = fxsvc:CreateEffectEntity()
        local petPstIDCmpt = self._entity:PetPstID()
        local petPstID = petPstIDCmpt:GetPstID()
        local petData = self._world:GetPetData(petPstID)
        local prefabResPath = petData:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
        avatarEffectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(prefabResPath, true))
        effectHolder:AttachEffect("BuffViewShowHidePetRoot", avatarEffectEntity)
        local ancName = HelperProxy:GetPetAnimatorControllerName(prefabResPath, PetAnimatorControllerType.Battle)
        if ancName then
          local req2 = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
          local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animator))
          if anim then
            local pet = avatarEffectEntity:View().ViewWrapper.GameObject
            local petAnim = pet:GetComponentInChildren(typeof(UnityEngine.Animator))
            petAnim.runtimeAnimatorController = anim.runtimeAnimatorController
          end
        end
      end
      local cPet = self._entity:Pet()
      if cPet then
        local eTeam = cPet:GetOwnerTeamEntity()
        local cLogicChainPath = eTeam:LogicChainPath()
        local chainPath = cLogicChainPath:GetLogicChainPath()
        local v2LastPos = chainPath[#chainPath]
        avatarEffectEntity:SetLocation(v2LastPos, Vector2.down)
        avatarEffectEntity:SetGridLocationAndOffset(v2LastPos, Vector2.down)
        avatarEffectEntity:CloneOffsetAndDamageOffset(self._entity)
      end
      local nul = avatarEffectEntity:HasEffectHolder() or avatarEffectEntity:AddEffectHolder()
      local cAvatarEffectHolder = avatarEffectEntity:EffectHolder()
      local teidPermanentEffect = effectHolder:GetPermanentEffect()
      for _, eid in ipairs(teidPermanentEffect) do
        local e = self._world:GetEntityByID(eid)
        if e then
          local isSuccess = self:_TransplantEffect(avatarEffectEntity, e)
          if isSuccess then
            cAvatarEffectHolder:AttachEffect("EffectHolderReplacedByAvatar", e)
          end
        end
      end
      YIELD(TT)
      avatarEffectEntity:SetViewVisible(true)
      avatarEffectEntity:SetAnimatorControllerTriggers({
        result.avatarShowAnimatorTrigger
      })
      if result.avatarShowEffectID then
        fxsvc:CreatePositionEffect(result.avatarShowEffectID, avatarEffectEntity:GetRenderGridPosition())
      end
      if buffOwnerEntity:HasPet() then
        local renderBattleService = self._world:GetService("RenderBattle")
        local eTeam = buffOwnerEntity:Pet():GetOwnerTeamEntity()
        if buffOwnerEntity:GetID() == eTeam:Team():GetTeamLeaderEntityID() then
          local teamHPBarEntityID = eTeam:HP():GetHPSliderEntityID()
          local eTeamHPBar = self._world:GetEntityByID(teamHPBarEntityID)
          if eTeamHPBar then
            eTeam:HP():SetLockPos(true)
            local renderHPBarPos = renderBattleService:CalcHPBarPos(avatarEffectEntity:View().ViewWrapper, eTeam:HP():GetHPOffset())
            local canvasTrans = eTeamHPBar:View().ViewWrapper:FindChild("Root")
            canvasTrans.position = renderHPBarPos
          end
        end
        local buffOwnerHPBarEntityID = buffOwnerEntity:HP():GetHPSliderEntityID()
        local eBuffOwnerHPBar = self._world:GetEntityByID(buffOwnerHPBarEntityID)
        if eBuffOwnerHPBar then
          buffOwnerEntity:HP():SetLockPos(true)
          local canvasTrans = eBuffOwnerHPBar:View().ViewWrapper:FindChild("Root")
          local renderHPBarPos = renderBattleService:CalcHPBarPos(avatarEffectEntity:View().ViewWrapper, buffOwnerEntity:HP():GetHPOffset())
          canvasTrans.position = renderHPBarPos
        end
      end
    end
  else
    if result.showModelAtLinkageEnd then
      local effectHolder = self._entity:EffectHolder()
      if not effectHolder then
        self._entity:AddEffectHolder()
        effectHolder = self._entity:EffectHolder()
      end
      local tEffect = effectHolder:GetEffectList("BuffViewShowHidePetRoot") or {}
      local avatarEffectEntity = tEffect[1]
      if avatarEffectEntity then
        avatarEffectEntity:SetAnimatorControllerTriggers({
          result.avatarHideAnimatorTrigger
        })
        YIELD(TT, result.avatarHideTime)
        avatarEffectEntity:SetViewVisible(false)
        if buffOwnerEntity:HasPet() then
          local eTeam = buffOwnerEntity:Pet():GetOwnerTeamEntity()
          if buffOwnerEntity:GetID() == eTeam:Team():GetTeamLeaderEntityID() then
            local cTeamHP = eTeam:HP()
            cTeamHP:SetLockPos(false)
            cTeamHP:SetHPPosDirty(true)
          end
        end
        local cBuffOwnerHP = buffOwnerEntity:HP()
        cBuffOwnerHP:SetLockPos(false)
        cBuffOwnerHP:SetHPPosDirty(true)
        local cAvatarEffectHolder = avatarEffectEntity:EffectHolder()
        if cAvatarEffectHolder then
          local otherEffects = cAvatarEffectHolder:GetEffectList("EffectHolderReplacedByAvatar") or {}
          local cView = self._entity:View()
          local go = cView:GetGameObject()
          for _, effectEntity in ipairs(otherEffects) do
            self:_TransplantEffect(self._entity, effectEntity)
          end
        end
        self._world:DestroyEntity(avatarEffectEntity)
        effectHolder:ClearEffectList("BuffViewShowHidePetRoot")
      end
    end
    self:_ShowHideRootRenderer(true)
  end
end

local function isCSGameObjectInvalid(go)
  return not go or tostring(go) == "null"
end

function BuffViewShowHidePetRoot:_TransplantEffect(eTarget, eFx)
  if not eFx:HasView() or not eTarget:HasView() then
    return
  end
  local csgoFx = eFx:View():GetGameObject()
  local csgoTarget = eTarget:View():GetGameObject()
  if isCSGameObjectInvalid(csgoFx) or isCSGameObjectInvalid(csgoTarget) then
    return
  end
  local parentNodeName = csgoFx.transform.parent.name
  local csTransformNewParent = csgoTarget.transform:Find(parentNodeName)
  if csTransformNewParent then
    csgoFx.transform:SetParent(csTransformNewParent, false)
  end
  return true
end
