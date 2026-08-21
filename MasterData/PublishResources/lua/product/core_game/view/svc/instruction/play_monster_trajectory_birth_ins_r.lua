_class("PlayMonsterTrajectoryBirthInstruction", BaseInstruction)
PlayMonsterTrajectoryBirthInstruction = PlayMonsterTrajectoryBirthInstruction

function PlayMonsterTrajectoryBirthInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  local strPos = paramList.pos
  if strPos then
    local arrPos = string.split(strPos, "|")
    self._pos = Vector2(tonumber(arrPos[1]), tonumber(arrPos[2]))
  else
    self._pos = BattleConst.BoardCenterPos
  end
  local strOffset = paramList.offset
  if strOffset then
    local arr = string.split(strOffset, "|")
    self._offset = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
  else
    self._offset = Vector3.zero
  end
  self._flyTime = tonumber(paramList.flyTime)
  self._block = tonumber(paramList.block) or 0
end

function PlayMonsterTrajectoryBirthInstruction:GetCacheResource()
  local t = {}
  if self.effectID and self.effectIDeftID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.effectID].ResPath,
      2
    })
  end
  return t
end

function PlayMonsterTrajectoryBirthInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._block == 1 then
    self:_OnPlayBezier(TT, casterEntity)
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:_OnPlayBezier(TT, casterEntity)
    end)
  end
end

function PlayMonsterTrajectoryBirthInstruction:_OnPlayBezier(TT, casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local boardServiceRender = world:GetService("BoardRender")
  local casterPos = boardServiceRender:GridPos2RenderPos(self._pos)
  casterPos = Vector3(casterPos.x, casterPos.y, casterPos.z) + self._offset
  local effectEntity = effectService:CreatePositionEffect(self._effectID, casterPos)
  local go = effectEntity:View():GetGameObject()
  local targetPos = casterEntity:GetPosition()
  local path = {}
  table.insert(path, go.transform.position)
  local pathFirstPos = Vector3.Lerp(casterPos, targetPos, 0.25)
  pathFirstPos = Vector3(pathFirstPos.x, -0.5, pathFirstPos.z)
  table.insert(path, pathFirstPos)
  local pathSecondPos = Vector3.Lerp(casterPos, targetPos, 0.5)
  table.insert(path, pathSecondPos)
  local pathThirdPos = Vector3.Lerp(casterPos, targetPos, 0.75)
  pathThirdPos = Vector3(pathThirdPos.x, 3, pathThirdPos.z)
  table.insert(path, pathThirdPos)
  table.insert(path, targetPos)
  local pathBezier = {}
  for i = 0, 1, 0.1 do
    table.insert(pathBezier, self:_BezierMethod(i, path))
  end
  table.insert(pathBezier, targetPos)
  local curve = DG.Tweening.Ease.InQuad
  local animationCurveHolder = go.gameObject:GetComponent(typeof(AnimationCurveHolder))
  if animationCurveHolder then
    local curveList = animationCurveHolder.acurveList
    if curveList and 0 < curveList.Length then
      curve = curveList[0]
    end
  end
  go.transform:DOLocalPath(pathBezier, self._flyTime / 1000, DG.Tweening.PathType.CatmullRom, DG.Tweening.PathMode.Full3D):SetEase(curve):OnComplete(function()
    world:DestroyEntity(effectEntity)
  end)
  YIELD(TT, self._flyTime)
end

function PlayMonsterTrajectoryBirthInstruction:_BezierMethod(t, foceList)
  if table.count(foceList) < 2 then
    return foceList[1]
  end
  local temp = {}
  for i = 1, table.count(foceList) - 1 do
    local proportion = Vector3((1 - t) * foceList[i].x + t * foceList[i + 1].x, (1 - t) * foceList[i].y + t * foceList[i + 1].y, (1 - t) * foceList[i].z + t * foceList[i + 1].z)
    table.insert(temp, proportion)
  end
  return self:_BezierMethod(t, temp)
end
