_class("SkillEffectResult_ShowWarningArea", SkillEffectResultBase)
SkillEffectResult_ShowWarningArea = SkillEffectResult_ShowWarningArea

function SkillEffectResult_ShowWarningArea:Constructor()
  self.m_listPosWarning = {}
end

function SkillEffectResult_ShowWarningArea:GetEffectType()
  return SkillEffectType.ShowWarningArea
end

function SkillEffectResult_ShowWarningArea:GetWarningPosList()
  return self.m_listPosWarning
end

function SkillEffectResult_ShowWarningArea:GetCenterList()
  return self.m_Centerlist
end

function SkillEffectResult_ShowWarningArea:ComputeWarningArea(world, casterEntity, effectParam)
  local centerType = effectParam:GetWarningCenterType()
  local posCaster = casterEntity:GridLocation().Position
  local casterArea = {}
  self.m_Centerlist = {}
  if centerType == ShowWarningCenterType.CanUseCenterArray then
    local centerArray = effectParam:GetCanUseCenterArray()
    local area = casterEntity:BodyArea():GetArea()
    local location = casterEntity:GridLocation().Position
    for i = 1, #centerArray do
      local pos = centerArray[i]
      local canUse = true
      for i, p in ipairs(area) do
        if location.x + p.x == pos.x and location.y + p.y == pos.y then
          canUse = false
          break
        end
      end
      if canUse then
        posCaster = Vector2(pos.x, pos.y)
        break
      end
    end
    for i, p in ipairs(area) do
      casterArea[#casterArea + 1] = Vector2(posCaster.x + p.x, posCaster.y + p.y)
    end
    self.m_Centerlist[#self.m_Centerlist + 1] = posCaster
  elseif centerType == ShowWarningCenterType.Self then
    posCaster = casterEntity:GridLocation().Position
  end
  local warningSkillID = effectParam:GetWarningSkillID()
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(warningSkillID)
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scapeResult = utilScopeSvc:CalcSkillScope(skillConfigData, posCaster, casterEntity)
  if effectParam:GetValidArea() then
    self.m_listPosWarning = scapeResult:GetAttackRange()
  else
    self.m_listPosWarning = scapeResult:GetWholeGridRange()
  end
  warningSkillID = effectParam:GetWarningSkillID2()
  if warningSkillID then
    local scapeResult = utilScopeSvc:CalcSkillScope(skillConfigData, posCaster, casterEntity)
    local additionalArea = {}
    if effectParam:GetValidArea() then
      additionalArea = scapeResult:GetAttackRange()
    else
      additionalArea = scapeResult:GetWholeGridRange()
    end
    for i = 1, #additionalArea do
      table.insert(self.m_listPosWarning, additionalArea[i])
    end
  end
  local isContainCasterArea = effectParam:IsContainCasterArea()
  if isContainCasterArea then
    for _, pos in ipairs(casterArea) do
      table.insert(self.m_listPosWarning, pos)
    end
  end
  local isValidPiecePosList = {}
  local boardServiceLogic = world:GetService("BoardLogic")
  local utilData = world:GetService("UtilData")
  for _, pos in ipairs(self.m_listPosWarning) do
    if utilData:IsValidPiecePos(pos) and not boardServiceLogic:IsPosBlock(pos, BlockFlag.Skill | BlockFlag.SkillSkip) then
      table.insert(isValidPiecePosList, pos)
    end
  end
  self.m_listPosWarning = isValidPiecePosList
end
