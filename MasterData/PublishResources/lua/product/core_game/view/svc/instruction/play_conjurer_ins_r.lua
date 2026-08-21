_class("PlayConjurerInstruction", BaseInstruction)
PlayConjurerInstruction = PlayConjurerInstruction

function PlayConjurerInstruction:Constructor(paramList)
  self._monsterClassID = tonumber(paramList.monsterClassID)
  self._casterEffectID = tonumber(paramList.casterEffectID)
  self._targetEffectID = tonumber(paramList.targetEffectID)
  self._animName = paramList.animName
  self._nodeName = paramList.nodeName
  self._materialaAnimName = paramList.materialaAnimName
  self._waitHitBackTime = tonumber(paramList.waitHitBackTime)
  self._time = tonumber(paramList.time)
  self._speed = {}
  local strSpeed = paramList.speed
  if strSpeed then
    local arrDelta = string.split(strSpeed, "|")
    for i = 1, table.count(arrDelta) do
      local speed = tonumber(arrDelta[i])
      table.insert(self._speed, speed)
    end
  end
end

function PlayConjurerInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayConjurerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillEffectResultControlMonsterCastHitBackTeam = resultContainer:GetEffectResultByArray(SkillEffectType.ControlMonsterCastHitBackTeam)
  if not skillEffectResultControlMonsterCastHitBackTeam then
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local effectService = self._world:GetService("Effect")
  local bodyArea = casterEntity:BodyArea():GetArea()
  local casterPos = casterEntity:GetRenderGridPosition()
  local monsterEntityIDs = skillEffectResultControlMonsterCastHitBackTeam:GetMonsterEntityIDs()
  for _, targetEntityID in ipairs(monsterEntityIDs) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    targetEntity:PlayMaterialAnim(self._materialaAnimName)
    targetEntity:SetAnimatorControllerTriggers({
      self._animName
    })
  end
  local resultList = resultContainer:GetEffectResultsAsArray(SkillEffectType.HitBack)
  local hitBackSpeed = 10
  if table.count(self._speed) > 0 and resultList and table.count(resultList) > 0 then
    hitBackSpeed = self._speed[#resultList]
    hitBackSpeed = hitBackSpeed or self._speed[#self._speed]
  end
  YIELD(TT, self._waitHitBackTime)
  for _, targetEntityID in ipairs(monsterEntityIDs) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local effect = effectService:CreateEffect(self._casterEffectID, targetEntity)
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamLeader = teamEntity:GetTeamLeaderPetEntity()
  local effect = effectService:CreateEffect(self._targetEffectID, teamLeader)
  if resultList and table.count(resultList) > 0 then
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      for _, v in ipairs(resultList) do
        local hitBackResult = v
        local targetID = hitBackResult:GetTargetID()
        local targetEntity = self._world:GetEntityByID(targetID)
        hitBackResult:SetHadPlay(true)
        local processHitTaskID = playSkillService:ProcessHit(casterEntity, targetEntity, hitBackResult, hitBackSpeed)
        if processHitTaskID then
          while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
            YIELD(TT)
          end
        end
        YIELD(TT)
        if hitBackResult then
          local pieceService = self._world:GetService("Piece")
          pieceService:RemovePrismAt(hitBackResult:GetPosTarget())
        end
      end
    end)
  end
  YIELD(TT, self._time - self._waitHitBackTime)
end
