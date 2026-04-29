require("base_ins_r")
_class("Play1502201FangDaJingInstruction", BaseInstruction)
Play1502201FangDaJingInstruction = Play1502201FangDaJingInstruction

function Play1502201FangDaJingInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._effectWaitInTime = tonumber(paramList.effectWaitInTime)
  self._effectInAnim = paramList.effectInAnim
  self._effectLoopAnim = paramList.effectLoopAnim
  self._effectOutWaitTime = tonumber(paramList.effectOutWaitTime)
  self._effectOutAnim = paramList.effectOutAnim
  self._effectMoveWaitTime = tonumber(paramList.effectMoveWaitTime)
  self._effectMoveTimeLen = tonumber(paramList.effectMoveWaitTimeLen)
  self._gridEffect1ID = tonumber(paramList.gridEffect1ID)
  self._gridEffect2ID = tonumber(paramList.gridEffect2ID)
  self._gridEffectWaitTime1 = tonumber(paramList.gridEffectWaitTime1)
  self._gridEffectWaitTime2 = tonumber(paramList.gridEffectWaitTime2)
  self._effectOutAnim2 = paramList.effectOutAnim2
  self._effectOutWaitTime2 = tonumber(paramList.effectOutWaitTime2)
  self._maxMoveCount = tonumber(paramList.maxMoveCount) or 2
  self._effectOutBeginWaitTime = tonumber(paramList.effectOutBeginWaitTime)
end

function Play1502201FangDaJingInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._gridEffect1ID and 0 < self._gridEffect1ID then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffect1ID].ResPath,
      1
    })
  end
  if self._gridEffect2ID and 0 < self._gridEffect2ID then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffect2ID].ResPath,
      1
    })
  end
  return t
end

function Play1502201FangDaJingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ConvertGridElement)
  if not results then
    Log.fatal("no results")
    return
  end
  local result = results[1]
  local totalGridArray = result:GetTargetGridArray()
  if #totalGridArray < 1 then
    return
  end
  local gridArray = self:FindFarestGridPos(totalGridArray)
  self._world = casterEntity:GetOwnerWorld()
  local taskIDList = {}
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(self.FangDaJingEffect, self, gridArray)
  table.insert(taskIDList, taskID)
  taskID = GameGlobal.TaskManager():CoreGameStartTask(self.GridEffect, self, gridArray)
  table.insert(taskIDList, taskID)
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function Play1502201FangDaJingInstruction:GridEffect(TT, totalGridArray)
  local effectService = self._world:GetService("Effect")
  local firstPos = totalGridArray[1]
  YIELD(TT, self._gridEffectWaitTime1)
  local gridEffect1 = effectService:CreateCommonGridEffect(self._gridEffect1ID, firstPos)
  if 1 < #totalGridArray then
    YIELD(TT, self._gridEffectWaitTime2)
    local secondePos = totalGridArray[2]
    local gridEffect2 = effectService:CreateCommonGridEffect(self._gridEffect2ID, secondePos)
  end
end

function Play1502201FangDaJingInstruction:FindFarestGridPos(totalGridArray)
  if #totalGridArray == 1 then
    return totalGridArray
  end
  local ret = {}
  local dis = 0
  for i, p1 in ipairs(totalGridArray) do
    for j, p2 in ipairs(totalGridArray) do
      if j ~= i then
        local disLen = Vector2.Distance(p1, p2)
        if dis < disLen then
          dis = disLen
          ret = {p1, p2}
        end
      end
    end
  end
  return ret
end

function Play1502201FangDaJingInstruction:PlayAnimation(entity, animName)
  if not entity:HasView() then
    return
  end
  local go = entity:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim == nil then
    Log.fatal("Cant play legacy animation, animation not found in ", go.name)
    return
  end
  anim:Play(animName)
end

function Play1502201FangDaJingInstruction:FangDaJingEffect(TT, totalGridArray)
  local effectService = self._world:GetService("Effect")
  local firstPos = totalGridArray[1]
  local effectEntity = effectService:CreateCommonGridEffect(self._effectID, firstPos)
  local go = effectEntity:View():GetGameObject()
  local renderers = go:GetComponentsInChildren(typeof(UnityEngine.Renderer))
  local material
  if renderers.Length > 0 then
    for i = 0, renderers.Length - 1 do
      local render = renderers[i]
      for j = 0, render.materials.Length - 1 do
        local tmpMaterial = render.materials[j]
        if tmpMaterial.shader.name == "H3D/FX/Other/Fangdajing" then
          material = tmpMaterial
          break
        end
      end
    end
  end
  local worldPos = go.transform.position
  local mainCamera = self._world:MainCamera():Camera()
  local screenPos = mainCamera:WorldToScreenPoint(worldPos)
  local viewPos = mainCamera:WorldToViewportPoint(worldPos)
  local pos = material:GetVector("_Position")
  local v4 = Vector4.zero
  v4.x = pos.x
  v4.y = pos.y
  v4.z = viewPos.x
  v4.w = viewPos.y
  material:SetVector("_Position", v4)
  self:PlayAnimation(effectEntity, self._effectInAnim)
  if self._effectWaitInTime then
    YIELD(TT, self._effectWaitInTime)
  end
  self:PlayAnimation(effectEntity, self._effectLoopAnim)
  if self._effectMoveWaitTime then
    YIELD(TT, self._effectMoveWaitTime)
  end
  local boardSvcR = self._world:GetService("BoardRender")
  if 1 < #totalGridArray then
    local secondPos = boardSvcR:GridPos2RenderPos(totalGridArray[2])
    local dotween = go.transform:DOMove(secondPos, self._effectMoveTimeLen / 1000.0):OnUpdate(function()
      worldPos = go.transform.position
      screenPos = mainCamera:WorldToScreenPoint(worldPos)
      viewPos = mainCamera:WorldToViewportPoint(worldPos)
      pos = material:GetVector("_Position")
      local v4 = Vector4.zero
      v4.x = pos.x
      v4.y = pos.y
      v4.z = viewPos.x
      v4.w = viewPos.y
      material:SetVector("_Position", v4)
    end)
    YIELD(TT, self._effectMoveTimeLen)
    YIELD(TT, self._effectOutBeginWaitTime)
    self:PlayAnimation(effectEntity, self._effectOutAnim)
    if self._effectOutWaitTime then
      YIELD(TT, self._effectOutWaitTime)
    end
  else
    self:PlayAnimation(effectEntity, self._effectOutAnim2)
    if self._effectOutWaitTime2 then
      YIELD(TT, self._effectOutWaitTime2)
    end
  end
  YIELD(TT)
  v4 = material:GetVector("_Position")
  v4.z = 0
  v4.w = 0
  material:SetVector("_Position", v4)
  self._world:DestroyEntity(effectEntity)
end
