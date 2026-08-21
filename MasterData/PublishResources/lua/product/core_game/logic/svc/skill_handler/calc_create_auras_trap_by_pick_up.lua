_class("SkillEffectCalc_CreateAurasTrapByPickUp", Object)
SkillEffectCalc_CreateAurasTrapByPickUp = SkillEffectCalc_CreateAurasTrapByPickUp

function SkillEffectCalc_CreateAurasTrapByPickUp:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
end

function SkillEffectCalc_CreateAurasTrapByPickUp:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  if not casterEntity then
    return
  end
  local startPos
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  if activeSkillPickUpComponent then
    startPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
  end
  if not startPos then
    return
  end
  local param = skillEffectCalcParam.skillEffectParam
  local squareRingNum = param:GetSquareRingNum()
  local minX = startPos.x - squareRingNum
  local maxX = startPos.x + squareRingNum
  local minY = startPos.y - squareRingNum
  local maxY = startPos.y + squareRingNum
  local bodyArea = {}
  for curX = minX, maxX do
    for curY = minY, maxY do
      local offset = Vector2(curX, curY) - startPos
      table.insert(bodyArea, offset)
    end
  end
  local trapID = param:GetTrapID()
  local trapDir = Vector2.up
  local trapSvc = self._world:GetService("TrapLogic")
  local infoData = {BodyArea = bodyArea}
  local trapEntity = trapSvc:CreateTrap(trapID, startPos, trapDir, true, nil, casterEntity, nil, nil, infoData)
  if not trapEntity then
    return
  end
  local result = SkillCreateAurasTrapByPickUpEffectResult:New(trapEntity:GetID(), startPos, squareRingNum)
  return {result}
end
