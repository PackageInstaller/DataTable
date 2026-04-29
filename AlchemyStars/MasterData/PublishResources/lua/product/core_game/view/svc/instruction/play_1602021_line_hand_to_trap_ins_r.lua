_class("Play1602021LineHandToTrapInstruction", BaseInstruction)
Play1602021LineHandToTrapInstruction = Play1602021LineHandToTrapInstruction

function Play1602021LineHandToTrapInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._handObjectName = paramList.handObjectName
  self._knifeHandleObjectName = paramList.knifeHandleObjectName
  self._p1YOffset = tonumber(paramList.p1YOffset)
  self._p2YOffset = tonumber(paramList.p2YOffset)
  self._p3YOffset = tonumber(paramList.p3YOffset)
end

function Play1602021LineHandToTrapInstruction:GetCacheResource()
  return {
    self:GetEffectResCacheInfo(self._effectID)
  }
end

function Play1602021LineHandToTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  GameGlobal.TaskManager():CoreGameStartTask(self._TaskFixLine, self, casterEntity, phaseContext)
end

function Play1602021LineHandToTrapInstruction:_TaskFixLine(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  if not routineCmpt then
    return
  end
  local resultArray = routineCmpt:GetEffectResultsAsArray(SkillEffectType.DestroyTrap)
  if not resultArray then
    return
  end
  local result = resultArray[1]
  if not result then
    return
  end
  local eID = result:GetEntityID()
  local eTrap = world:GetEntityByID(eID)
  if not eTrap then
    return
  end
  if not (eTrap:HasView() and eTrap:View():GetGameObject()) or tostring(eTrap:View():GetGameObject()) == "null" then
    return
  end
  local fxsvc = world:GetService("Effect")
  local fx = fxsvc:CreateWorldPositionDirectionEffect(self._effectID, casterEntity:GetGridPosition(), result:GetTrapPos() - casterEntity:GetGridPosition())
  local csgo = fx:View():GetGameObject()
  local renderers = csgo:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
  local csCasterGO = casterEntity:View():GetGameObject()
  local csHandTransform = GameObjectHelper.FindChild(csCasterGO.transform, self._handObjectName)
  local csTrapGO = eTrap:View():GetGameObject()
  local csKnifeHandleTransform = GameObjectHelper.FindChild(csTrapGO.transform, self._knifeHandleObjectName)
  local boardServiceRender = world:GetService("BoardRender")
  local v3GridPos = boardServiceRender:GridPos2RenderPos(result:GetTrapPos())
  local ctrl = fx:EffectController()
  while ctrl.CurrentTime < ctrl.Duration do
    local p1 = Vector3.New(csHandTransform.position.x, self._p1YOffset, csHandTransform.position.z)
    local p2 = Vector3.New(csKnifeHandleTransform.position.x, self._p2YOffset, csKnifeHandleTransform.position.z)
    local p3 = Vector3.New(v3GridPos.x, self._p3YOffset, v3GridPos.z)
    local invp1 = csgo.transform:InverseTransformPoint(p1)
    local invp2 = csgo.transform:InverseTransformPoint(p2)
    local invp3 = csgo.transform:InverseTransformPoint(p3)
    for i = 0, renderers.Length - 1 do
      local line = renderers[i]
      line:SetPosition(0, invp1)
      line:SetPosition(1, invp2)
      line:SetPosition(2, invp3)
    end
    YIELD(TT)
  end
end
