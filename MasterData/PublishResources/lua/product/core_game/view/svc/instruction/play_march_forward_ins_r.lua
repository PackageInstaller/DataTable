require("base_ins_r")
_class("PlayMarchForwardInstruction", BaseInstruction)
PlayMarchForwardInstruction = PlayMarchForwardInstruction

function PlayMarchForwardInstruction:Constructor(paramList)
  self._marchTime = tonumber(paramList.marchTime) or 1000
end

function PlayMarchForwardInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MarchForward)
  if not results then
    Log.fatal("no results")
    return
  end
  local result = results[1]
  self._world = casterEntity:GetOwnerWorld()
  local walkResultList = result:GetWalkResultList()
  local casterIsDead = result:IsCasterDead()
  local marchEnd = result:IsMarchEnd()
  self:_DoWalk(TT, casterEntity, walkResultList, casterIsDead, marchEnd)
end

function PlayMarchForwardInstruction:_DoWalk(TT, monsterEntity, walkResultList, casterIsDead, marchEnd)
  local boardSvcR = self._world:GetService("BoardRender")
  local hasWalkPoint = false
  local marchStep = #walkResultList
  if 0 < marchStep then
    hasWalkPoint = true
  end
  local moveSpeed = 1000 * marchStep / self._marchTime
  if hasWalkPoint then
    boardSvcR:RefreshPiece(monsterEntity, true, true)
  end
  local pieceSvc = self._world:GetService("Piece")
  for _, v in ipairs(walkResultList) do
    local walkRes = v
    local walkPos = walkRes:GetWalkPos()
    local boardSvcR = self._world:GetService("BoardRender")
    local curPos = boardSvcR:GetRealEntityGridPos(monsterEntity)
    monsterEntity:AddGridMove(moveSpeed, walkPos, curPos)
    local walkDir = walkPos - curPos
    monsterEntity:SetDirection(walkDir)
    for _, moveInfo in ipairs(walkRes:GetMoveEntities()) do
      local entity = self._world:GetEntityByID(moveInfo[1])
      local posTarget = moveInfo[3]
      local gridPos = boardSvcR:GetRealEntityGridPos(entity)
      entity:RemoveGridMove()
      entity:AddGridMove(moveSpeed, posTarget, gridPos)
      if entity:HasTeam() then
        local petList = entity:Team():GetTeamPetEntities()
        for _, pet in pairs(petList) do
          pet:RemoveGridMove()
          pet:AddGridMove(moveSpeed, posTarget, gridPos)
        end
      elseif entity:MonsterID() then
        local pos = gridPos - entity:GridLocation():GetGridOffset()
        local bodyArea = entity:BodyArea():GetArea()
        for _, area in ipairs(bodyArea) do
          local workPos = area + pos
          local curPieceAnim = pieceSvc:GetPieceAnimation(workPos)
          if curPieceAnim == "Down" then
            pieceSvc:SetPieceAnimUp(workPos)
          end
        end
      end
    end
    while monsterEntity:HasGridMove() do
      YIELD(TT)
    end
    local playSkillInstructionService = self._world:GetService("PlaySkillInstruction")
    local notRefreshPrism = true
    for _, convertInfo in ipairs(walkRes:GetConvertInfo()) do
      local pos = convertInfo[1]
      local elementType = convertInfo[2]
      playSkillInstructionService:GridConvert(TT, monsterEntity, pos, 0, elementType, notRefreshPrism)
    end
    self:_PlayArrivePos(TT, walkRes)
  end
  if hasWalkPoint then
    boardSvcR:RefreshPiece(monsterEntity, false, true)
  end
  if casterIsDead then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, monsterEntity)
  end
  if marchEnd then
    local nt = NTMarchEnd:New()
    local playBuffSvc = self._world:GetService("PlayBuff")
    playBuffSvc:PlayBuffView(TT, nt)
  end
end

function PlayMarchForwardInstruction:_PlayArrivePos(TT, walkRes)
  local trapResList = walkRes:GetTrapSkillResults()
  for _, v in ipairs(trapResList) do
    local trapEntity = self._world:GetEntityByID(v[1])
    local trapSkillRes = v[2]
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    local triggerEntity = self._world:GetEntityByID(v[3])
    local trapSvc = self._world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, triggerEntity)
  end
end
