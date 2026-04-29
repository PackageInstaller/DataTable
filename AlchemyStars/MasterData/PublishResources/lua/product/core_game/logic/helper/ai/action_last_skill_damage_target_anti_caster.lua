require("action_is_base")
_class("ActionLastSkillDamageTargetAntiCaster", ActionIsBase)
ActionLastSkillDamageTargetAntiCaster = ActionLastSkillDamageTargetAntiCaster

function ActionLastSkillDamageTargetAntiCaster:OnUpdate()
  local skillID = self:GetLogicData(-1)
  local targetChessClassID = self:GetLogicData(-2)
  local targetAISkillResult, targetEntity
  local recorderCmpt = self._world:GetBoardEntity():AIRecorder()
  local collection = recorderCmpt:GetAIResultCollection(self.m_entityOwn:GetID())
  if collection and collection:HasSpellResult() then
    local resList = collection:GetSpellResultList()
    for _, v in ipairs(resList) do
      local aiSkillResult = v
      local skillEffectResultContainer = aiSkillResult:GetResultContainer()
      local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
      if resultArray then
        for _, v in ipairs(resultArray) do
          local skillResult = v
          local targetID = skillResult:GetTargetID()
          local curTargetEntity = self._world:GetEntityByID(targetID)
          if curTargetEntity and not curTargetEntity:HasDeadMark() then
            local chessPetCmpt = curTargetEntity:ChessPet()
            if chessPetCmpt then
              local chessPetClassID = chessPetCmpt:GetChessPetClassID()
              if targetChessClassID == chessPetClassID then
                targetEntity = curTargetEntity
                targetAISkillResult = aiSkillResult
                break
              end
            end
          end
        end
      end
    end
  end
  if not targetEntity then
    return AINewNodeStatus.Failure
  end
  local buffCmpt = targetEntity:BuffComponent()
  local isStun = buffCmpt:HasFlag(BuffFlags.SkipTurn)
  if isStun then
    return AINewNodeStatus.Failure
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local selfPos = self.m_entityOwn:GetGridPosition()
  local curBodyArea = self.m_entityOwn:BodyArea():GetArea()
  local curBodyPosList = {}
  for _, pos in ipairs(curBodyArea) do
    local workPos = selfPos + pos
    table.insert(curBodyPosList, workPos)
  end
  local targetPos = targetEntity:GetGridPosition()
  local targetDir = targetEntity:GridLocation().Direction
  local targetBodyArea = targetEntity:BodyArea():GetArea()
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, targetPos, targetEntity, targetDir)
  local inRange = false
  for _, pos in ipairs(curBodyPosList) do
    if table.intable(scopeResult:GetAttackRange(), pos) then
      inRange = true
      break
    end
  end
  if inRange == false then
    return AINewNodeStatus.Failure
  end
  scopeResult:ClearTargetIDs()
  scopeResult:AddTargetID(self.m_entityOwn:GetID())
  scopeResult:AddTargetIDAndPos(self.m_entityOwn:GetID(), selfPos)
  local skillResult = targetEntity:SkillContext():GetResultContainer()
  skillResult:Clear()
  skillResult:SetSkillID(skillID)
  skillResult:SetScopeResult(scopeResult)
  local activeSkillCalculator = ActiveSkillCalculator:New(self._world)
  activeSkillCalculator:DoCalculateSkill(targetEntity)
  local result = targetEntity:SkillContext():GetResultContainer()
  targetEntity:ReplaceSkillContext()
  local antiChessResultList = {}
  table.insert(antiChessResultList, {
    entityID = targetEntity:GetID(),
    skillID = skillID,
    skillResult = skillResult
  })
  targetAISkillResult:SetAISkillResult_AntiChessResultList(antiChessResultList)
  return AINewNodeStatus.Success
end
