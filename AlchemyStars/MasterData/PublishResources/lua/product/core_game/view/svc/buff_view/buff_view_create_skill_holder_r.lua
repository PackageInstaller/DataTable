_class("BuffViewCreateSkillHolder", BuffViewBase)
BuffViewCreateSkillHolder = BuffViewCreateSkillHolder

function BuffViewCreateSkillHolder:PlayView(TT)
  local eid = self._buffResult:GetSkillHolderID()
  local skillHolder = self._world:GetEntityByID(eid)
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  if not viewParams then
    return
  end
  skillHolder:ReplaceAsset(NativeUnityPrefabAsset:New(viewParams.SkillHolderPrefab, true))
  if viewParams.LoadBattleAnimator then
    local respool = self._world.BW_Services.ResourcesPool
    local ancName = HelperProxy:GetPetAnimatorControllerName(viewParams.SkillHolderPrefab, PetAnimatorControllerType.Battle)
    if ancName then
      respool:Cache(ancName, 1)
      local req2 = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
      local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animator))
      local skillHolderAnim = skillHolder:View().ViewWrapper.GameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
      skillHolderAnim.runtimeAnimatorController = anim.runtimeAnimatorController
      skillHolderAnim:Play("idle")
    else
      Log.error(self._className, "ancName", ancName, "load failed")
    end
  end
  if self._buffResult:GetAbsolutePositionMode() == BuffLogicCreateSkillHolder_AbsolutePositionMode.BoardCenter then
    skillHolder:SetGridLocation(BattleConst.BoardCenterPos, Vector2.down)
  end
  if self._buffResult:GetHideOnDefault() then
    skillHolder:SetLocation(Vector3(0, 1000, 0), skillHolder:GetGridDirection())
  end
  if not self._buffResult:GetAbsolutePositionMode() then
    skillHolder:AddEffectController(self._entity, "Root", -1, EffectType.Bind)
  end
  local teamEntity
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPetPstID() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  if teamEntity then
    local cEffectAttached = teamEntity:EffectAttached()
    cEffectAttached:AddAttachedEntityID(skillHolder:GetID())
  end
end

_class("BuffViewRemoveSkillHolder", BuffViewBase)
BuffViewRemoveSkillHolder = BuffViewRemoveSkillHolder

function BuffViewRemoveSkillHolder:PlayView(TT)
  local holderID = self._buffResult:GetSkillHolderID()
  local holder = self._world:GetEntityByID(holderID)
  if holder then
    self._world:DestroyEntity(holder)
  end
end
