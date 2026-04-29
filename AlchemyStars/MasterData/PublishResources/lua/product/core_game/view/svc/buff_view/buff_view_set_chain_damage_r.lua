_class("BuffViewSetChainDamage", BuffViewBase)
BuffViewSetChainDamage = BuffViewSetChainDamage

function BuffViewSetChainDamage:PlayView(TT, notify)
  local result = self._buffResult
  local attackerID = result:GetAttackerID()
  local defenderID = result:GetDefenderID()
  local lineEffectID = result:GetLineEffectID()
  local isRemove = result:GetIsRemove()
  local removeEffectID = result:GetRemoveEffectID()
  local removeLineEntityList = result:GetRemoveLineEntityList()
  local attacker = self._world:GetEntityByID(attackerID)
  local defender = self._world:GetEntityByID(defenderID)
  local effectService = self._world:GetService("Effect")
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams() or {}
  if isRemove == 1 then
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:_RemoveEntityLineEffect(TT, attackerID, lineEffectID, removeEffectID, true)
      if removeLineEntityList and table.count(removeLineEntityList) > 0 then
        for _, entityID in ipairs(removeLineEntityList) do
          self:_RemoveEntityLineEffect(TT, entityID, lineEffectID, removeEffectID, false)
          self:_RemoveEntityLineEffect(TT, entityID, lineEffectID, removeEffectID, true)
        end
      end
    end)
  else
    if attacker:HasSuperEntity() then
      attacker = attacker:GetSuperEntity()
    end
    if attacker:HasTeam() then
      attacker = defender:GetTeamLeaderPetEntity()
    end
    if defender:HasSuperEntity() then
      defender = defender:GetSuperEntity()
    end
    if defender:HasTeam() then
      defender = defender:GetTeamLeaderPetEntity()
    end
    local effectLineRenderer = attacker:EffectLineRenderer()
    if not effectLineRenderer then
      attacker:AddEffectLineRenderer()
      effectLineRenderer = attacker:EffectLineRenderer()
    end
    local effectHolderCmpt = attacker:EffectHolder()
    if not effectHolderCmpt then
      attacker:AddEffectHolder()
      effectHolderCmpt = attacker:EffectHolder()
    end
    if lineEffectID then
      local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[lineEffectID]
      local effect
      if effectEntityIdList then
        effect = self._world:GetEntityByID(effectEntityIdList[1])
      end
      if not effect then
        effect = effectService:CreateEffect(lineEffectID, attacker)
        effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      end
      local go = effect:View():GetGameObject()
      local renderers
      renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      local attackerViewRoot = attacker:View().ViewWrapper.GameObject.transform
      local attackRoot = GameObjectHelper.FindChild(attackerViewRoot, "Hit")
      attackRoot = attackRoot or GameObjectHelper.FindChild(attackerViewRoot, "Root")
      local defenderViewRoot = defender:View().ViewWrapper.GameObject.transform
      local defenderRoot = GameObjectHelper.FindChild(defenderViewRoot, "Hit")
      defenderRoot = defenderRoot or GameObjectHelper.FindChild(defenderViewRoot, "Root")
      effectLineRenderer:InitEffectLineRenderer(attackerID, attackRoot, defenderRoot, attackerViewRoot, renderers, effect:GetID())
      effectLineRenderer:SetEffectLineRendererShow(attackerID, true)
      effectLineRenderer:SetTargetEntityID(defenderID)
    end
  end
  local targetPermanentEffectID = viewParams.targetPermanentEffectID
  if targetPermanentEffectID then
    if attackerID == defenderID and removeLineEntityList and table.count(removeLineEntityList) > 0 then
      defender = self._world:GetEntityByID(removeLineEntityList[1])
    end
    if defender:HasSuperEntity() then
      defender = defender:GetSuperEntity()
    end
    if defender:HasTeam() then
      defender = defender:GetTeamLeaderPetEntity()
    end
    local defenderEffectHolderCmpt = defender:EffectHolder()
    if not defenderEffectHolderCmpt then
      defender:AddEffectHolder()
      defenderEffectHolderCmpt = defender:EffectHolder()
    end
    if isRemove == 1 then
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        local lineEffect
        local effectEntityIdList = defenderEffectHolderCmpt:GetEffectIDEntityDic()[targetPermanentEffectID]
        if effectEntityIdList then
          lineEffect = self._world:GetEntityByID(effectEntityIdList[1])
        end
        if not lineEffect then
          return
        end
        local go = lineEffect:View():GetGameObject()
        local targetPermanentEffectRemoveAnim = viewParams.targetPermanentEffectRemoveAnim
        local removeAnimTime = viewParams.removeAnimTime
        local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
        if anim and anim.clip then
          anim:Play(targetPermanentEffectRemoveAnim)
          YIELD(TT, removeAnimTime)
        end
        self._world:DestroyEntity(lineEffect)
        defenderEffectHolderCmpt:GetEffectIDEntityDic()[targetPermanentEffectID][1] = nil
      end)
    else
      if notify and notify:GetNotifyType() == NotifyType.ChangeTeamLeader then
        local oldTeamLeader = notify:GetOldTeamLeader()
        local oldTeamLeaderEffectHolderCmpt = oldTeamLeader:EffectHolder()
        local lineEffect
        local oldTeamLeaderEffectEntityIdList = oldTeamLeaderEffectHolderCmpt:GetEffectIDEntityDic()[targetPermanentEffectID]
        if oldTeamLeaderEffectEntityIdList then
          lineEffect = self._world:GetEntityByID(oldTeamLeaderEffectEntityIdList[1])
        end
        if lineEffect then
          self._world:DestroyEntity(lineEffect)
          oldTeamLeaderEffectHolderCmpt:GetEffectIDEntityDic()[targetPermanentEffectID][1] = nil
        end
      end
      do
        local lineEffect
        local defenderEffectEntityIdList = defenderEffectHolderCmpt:GetEffectIDEntityDic()[targetPermanentEffectID]
        if defenderEffectEntityIdList then
          lineEffect = self._world:GetEntityByID(defenderEffectEntityIdList[1])
        end
        if not lineEffect then
          local permanentEffectEntity = effectService:CreateEffect(targetPermanentEffectID, defender)
          defenderEffectHolderCmpt:AttachPermanentEffect(permanentEffectEntity:GetID())
        end
      end
    end
  end
  local notOpenLineEffectObjName = viewParams.NotOpenLineEffectObjName
  if notOpenLineEffectObjName then
    local buffView = attacker:BuffView()
    buffView:SetBuffValue("NotOpenLineEffectObjName", notOpenLineEffectObjName)
  end
end

function BuffViewSetChainDamage:IsNotifyMatch(notify)
  local result = self._buffResult
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.BuffLoad then
    local attackerID = result:GetAttackerID()
    local casterID = notify:GetCasterEntityID()
    if attackerID ~= casterID then
      return false
    end
  end
  if notify and notifyType == NotifyType.MonsterMoveOneFinish then
    local monsterMoveEntityID = result:GetMonsterMoveOneFinishEntityID()
    local monsterMoveWalkPos = result:GetMonsterMoveOneFinishWalkPos()
    return monsterMoveEntityID == notify:GetNotifyEntity():GetID() and monsterMoveWalkPos == notify:GetWalkPos()
  end
  if notify and notifyType == NotifyType.TeamLeaderEachMoveEnd then
    local walkPos = result:GetTeamLeaderEachMoveEnd()
    return walkPos == notify:GetPos()
  end
  return true
end

function BuffViewSetChainDamage:_RemoveEntityLineEffect(TT, entityID, lineEffectID, removeEffectID, isCaster)
  local entity = self._world:GetEntityByID(entityID)
  if not entity then
    return
  end
  if entity:HasSuperEntity() then
    entity = entity:GetSuperEntity()
  end
  if entity:HasTeam() then
    entity = entity:GetTeamLeaderPetEntity()
  end
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local effectService = self._world:GetService("Effect")
  if removeEffectID then
    local curPos = entity:GetPosition()
    local attackerViewRoot = entity:View().ViewWrapper.GameObject.transform
    local attackRoot = GameObjectHelper.FindChild(attackerViewRoot, "Hit")
    if attackRoot then
      local attackHit = attackRoot.position
      effectService:CreateWorldPositionEffect(removeEffectID, attackHit)
    end
  end
  local effectLineRenderer = entity:EffectLineRenderer()
  if not effectLineRenderer then
    return
  end
  local defenderID = effectLineRenderer:GetTargetEntityID()
  local casterEntityID = effectLineRenderer:GetCasterEntityID()
  if isCaster == false and casterEntityID == entityID and defenderID ~= entity:GetID() then
    return
  end
  if lineEffectID then
    local lineEffect
    local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[lineEffectID]
    if effectEntityIdList then
      lineEffect = self._world:GetEntityByID(effectEntityIdList[1])
    end
    if not lineEffect then
      return
    end
    local go = lineEffect:View():GetGameObject()
    local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
    if anim and anim.clip then
      anim:Play()
      YIELD(TT, anim.clip.length * 1000)
    end
    self._world:DestroyEntity(lineEffect)
    effectHolderCmpt:GetEffectIDEntityDic()[lineEffectID][1] = nil
    effectLineRenderer:SetEffectLineRendererShow(entityID, false)
  end
end
