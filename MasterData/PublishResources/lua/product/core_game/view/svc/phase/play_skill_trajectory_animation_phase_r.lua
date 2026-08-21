require("play_skill_phase_base_r")
_class("PlaySkillTrajectoryAnimationPhase", PlaySkillPhaseBase)
PlaySkillTrajectoryAnimationPhase = PlaySkillTrajectoryAnimationPhase

function PlaySkillTrajectoryAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local trajectoryParam = phaseParam
  local boardServiceRender = self._world:GetService("BoardRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local castPos = casterEntity:Location().Position
  local absorbResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.AbsorbPiece)
  if not absorbResult then
    return
  end
  local absorbPieceList = absorbResult:GetAbsorbPieceList()
  if not absorbPieceList or #absorbPieceList == 0 then
    return
  end
  local effectService = self._world:GetService("Effect")
  local gridEffectID = trajectoryParam:GetGridEffectID()
  local effectEntityList = {}
  for k, v in pairs(absorbPieceList) do
    local renderPos = boardServiceRender:GridPos2RenderPos(v)
    local effectEntity = effectService:CreatePositionEffect(gridEffectID, renderPos)
    table.insert(effectEntityList, {entity = effectEntity, position = renderPos})
  end
  local ballHigh = trajectoryParam:GetBallHigh()
  YIELD(TT)
  local flyTime = trajectoryParam:GetUpTime()
  for k, v in pairs(effectEntityList) do
    local view = v.entity:View()
    local go = view:GetGameObject()
    self:_CalcTrajectory(v.entity, go, flyTime, casterEntity, ballHigh, trajectoryParam)
  end
end

function PlaySkillTrajectoryAnimationPhase:_CalcTrajectory(effectEntity, go, flyTime, casterEntity, ballHigh, phaseParam)
  local transform = go.transform
  transform:DOMoveY(ballHigh, flyTime / 1000):OnComplete(function()
    GameGlobal.TaskManager():CoreGameStartTask(self._BallFly, self, effectEntity, casterEntity, phaseParam)
  end)
end

function PlaySkillTrajectoryAnimationPhase:_BallFly(TT, effectEntity, casterEntity, phaseParam)
  local effectService = self._world:GetService("Effect")
  local effectBallID = phaseParam:GetGridEffectID()
  local config = Cfg.cfg_effect[effectBallID]
  local casterTranform = casterEntity:View():GetGameObject().transform
  local bindTf = GameObjectHelper.FindChild(casterEntity:View():GetGameObject().transform, config.BindPos)
  local destPoint = bindTf.position
  destPoint.y = phaseParam:GetBallHigh()
  local effectTransFrom = effectEntity:View():GetGameObject().transform
  local ballPos = effectTransFrom.position
  local distance = Vector3.Distance(ballPos, destPoint)
  local flyTime = 2000
  local a = distance
  local b = phaseParam:GetFlyRadius()
  local t = self:_GetRadian(ballPos, destPoint)
  local s = distance / flyTime / 1000
  local maxPoint = flyTime
  local pointList = {}
  local i = 1
  local ballPoint = effectTransFrom.position
  while Vector3.Distance(ballPoint, destPoint) > phaseParam:GetHideDistance() do
    local x = (a + b * t) * Mathf.Cos(t)
    local y = (a + b * t) * Mathf.Sin(t)
    t = t + i * s
    b = b - i * s
    local deltaPos = Vector3(x, 0, y)
    ballPoint = destPoint + deltaPos
    if maxPoint < i then
      break
    end
    table.insert(pointList, ballPoint)
    i = i + 1
  end
  table.insert(pointList, destPoint)
  local beginTime = self._timeService:GetCurrentTimeMs()
  while Vector3.Distance(effectTransFrom.position, destPoint) > phaseParam:GetHideDistance() do
    local now = self._timeService:GetCurrentTimeMs()
    local deltaTime = now - beginTime
    deltaTime = math.floor(deltaTime)
    if deltaTime < #pointList then
      if deltaTime ~= 0 then
        effectTransFrom.position = pointList[deltaTime]
      end
    else
      effectTransFrom.position = pointList[#pointList]
      break
    end
    YIELD(TT)
  end
  effectEntity:View():GetGameObject():SetActive(false)
  self._world:DestroyEntity(effectEntity)
end

function PlaySkillTrajectoryAnimationPhase:_GetRadian(from, to)
  local subVector = from - to
  local deltaAngle = 0
  local radian = Mathf.Atan(subVector.z, subVector.x)
  local angle = radian * Mathf.Rad2Deg
  return radian
end
