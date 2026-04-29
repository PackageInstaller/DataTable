require("ai_node_new")
_class("ActionTurnToTarget", AINewNode)
ActionTurnToTarget = ActionTurnToTarget

function ActionTurnToTarget:OnBegin()
  local nTargetType = self:GetLogicData(-1)
  self:TurnToTarget(self._world, self.m_entityOwn, nTargetType)
end

function ActionTurnToTarget:TurnToTarget(world, entityWork, nTargetType)
  local aiComponent = entityWork:AI()
  if false == aiComponent:CanTurn() then
    self:PrintLog("转向: 转向玩家方向<不允许>")
    self:PrintDebugLog("转向: 转向<不允许>")
    return
  end
  local targetEntity
  if nTargetType and 0 < nTargetType then
    local nSkillID = self:GetLogicData(1)
    if nSkillID == 0 then
      self:PrintLog("转向: 转向使用的技能ID为0<不允许>")
      return
    end
    targetEntity = self:_GetTargetPosBySkillID(world, entityWork, nSkillID)
  else
    targetEntity = aiComponent:GetTargetEntity()
  end
  if not targetEntity or not entityWork:HasBodyArea() then
    self:PrintLog("转向: 转向玩家方向<允许>，目标没有BodyArea")
    self:PrintDebugLog("转向: 转向玩家方向<允许>，目标没有BodyArea")
    return
  end
  self:PrintLog("转向: 转向玩家方向<允许>")
  local posSelf = entityWork:GetGridPosition()
  local posTarget = self:_GetAITargetDamageCenter(targetEntity)
  local posDir = GameHelper.ComputeLogicDir(posTarget - posSelf)
  local nBodyAreaCount = entityWork:BodyArea():GetAreaCount()
  if 1 ~= nBodyAreaCount then
    posDir = self:GetDir(posTarget, entityWork)
  else
    local useAlign = self:GetLogicData("alignAxis")
    if useAlign == true then
      local attackPos = self:GetNeareastPos(targetEntity, entityWork)
      posDir = self:GetDir(attackPos, entityWork)
    end
  end
  self:PrintDebugLog("转向: <允许>，我的位置 = ", posSelf, " 目标ID = ", targetEntity:GetID(), " 目标位置=", posTarget, " 转向方向：", posDir)
  entityWork:SetGridDirection(posDir)
end

function ActionTurnToTarget:GetNeareastPos(targetEntity, entityWork)
  local selfGridLocCmpt = entityWork:GridLocation()
  local selfPos = selfGridLocCmpt:GetGridPos()
  local posTarget = self:_GetAITargetDamageCenter(targetEntity)
  local targetBodyAreaCmpt = targetEntity:BodyArea()
  local targetAreaCount = targetBodyAreaCmpt:GetAreaCount()
  if 1 < targetAreaCount then
    local bodyAreaList = targetBodyAreaCmpt:GetArea()
    local gridLocCmpt = targetEntity:GridLocation()
    local gridPos = gridLocCmpt:GetGridPos()
    local neareastBodyPos = posTarget
    local curNearestDis = 100
    for _, bodyArea in ipairs(bodyAreaList) do
      local bodyPos = gridPos + bodyArea
      local distance = Vector2.Distance(bodyPos, selfPos)
      if curNearestDis > distance then
        curNearestDis = distance
        neareastBodyPos = bodyPos
      end
    end
    posTarget = neareastBodyPos
  end
  return posTarget
end

function ActionTurnToTarget:GetDir(targetPos, entity)
  local gridLoc = entity:GridLocation()
  local center = gridLoc:Center()
  local vectors = {
    Vector2(-1, 0),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(0, 1)
  }
  local minIdx, minAngle = 1, 180
  local vec = targetPos - center
  for i, v in ipairs(vectors) do
    local angle = Vector2.Angle(vec, v)
    if minAngle > angle then
      minAngle = angle
      minIdx = i
    end
  end
  return vectors[minIdx]
end

function ActionTurnToTarget:_GetTargetPosBySkillID(world, castEntity, nSkillID)
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(nSkillID)
  local targetType = skillConfigData:GetSkillTargetType()
  local casterPos = castEntity:GetGridPosition()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, castEntity)
  local targetSelector = world:GetSkillScopeTargetSelector()
  local targetEntityIDArray = targetSelector:DoSelectSkillTarget(castEntity, targetType, scopeResult, nSkillID)
  if table.count(targetEntityIDArray) <= 0 then
    return nil
  end
  local nTargetID = targetEntityIDArray[1]
  return world:GetEntityByID(nTargetID)
end

function ActionTurnToTarget:_GetAITargetDamageCenter(targetEntity)
  local gridCmpt = targetEntity:GridLocation()
  if gridCmpt == nil then
    return
  end
  local gridPos = gridCmpt:GetGridPos()
  local posReturn
  local posOffSet = gridCmpt:GetDamageOffset()
  posReturn = gridPos + posOffSet
  return posReturn
end
