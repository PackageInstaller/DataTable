_class("SkillEffectCalc_Transport", Object)
SkillEffectCalc_Transport = SkillEffectCalc_Transport

function SkillEffectCalc_Transport:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_Transport:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local paramSkillEffect = skillEffectCalcParam.skillEffectParam
  local times = paramSkillEffect:GetTimes()
  local isLoop = paramSkillEffect:GetIsLoop()
  local offsetPos = paramSkillEffect:GetOffsetPos()
  local offsetBodyAreaTimes = paramSkillEffect:GetOffsetBodyAreaTimes()
  local transportor = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  for i = 1, times do
    local result = SkillEffectTransportResult:New()
    for j = 1, offsetBodyAreaTimes do
      local offsetWorkPos = offsetPos * (j - 1)
      local envList = self:_CalcTransportEnvList(transportor, offsetWorkPos)
      self:_TransportOneStep(result, envList, isLoop)
    end
    results[#results + 1] = result
  end
  return results
end

function SkillEffectCalc_Transport:_CalcTransportEnvList(transportor, offsetWorkPos)
  local posTransportor = transportor:GetGridPosition()
  local bodyAreaTransportor = transportor:BodyArea():GetArea()
  local boardCmpt = self._world:GetBoardEntity():Board()
  
  local function filter(e)
    return e ~= transportor and e:HasBlockFlag() and not e:HasDeadMark()
  end
  
  local envList = {}
  for i, area in ipairs(bodyAreaTransportor) do
    local pos = posTransportor + area + offsetWorkPos
    local posIdx = Vector2.Pos2Index(pos)
    local pieceType = boardCmpt:GetPieceType(pos)
    local es = boardCmpt:GetPieceEntities(pos, filter)
    local isPieceEffect = boardCmpt:IsSpecialPieceEffect(pos)
    local prismEntityID = boardCmpt:GetPrismEntityIDAtPos(pos)
    local pieceEffectType = boardCmpt:GetBoardPieceEffectType(pos)
    local isTeam = false
    local FixBlock = {}
    local FixNoBlock = {}
    local FloatBlock = {}
    local FloatNoBlock = {}
    for _, e in ipairs(es) do
      local blockFlag = e:BlockFlag():GetBlockFlag()
      if blockFlag & BlockFlag.Transport ~= 0 then
        if blockFlag & BlockFlag.LinkLine ~= 0 then
          FixBlock[#FixBlock + 1] = e
        else
          FixNoBlock[#FixNoBlock + 1] = e
        end
      elseif e:HasTeam() or blockFlag & BlockFlag.LinkLine ~= 0 then
        FloatBlock[#FloatBlock + 1] = e
      else
        FloatNoBlock[#FloatNoBlock + 1] = e
      end
      if e:HasTeam() then
        isTeam = true
      end
    end
    local envIndex = #envList + 1
    envList[envIndex] = {
      index = envIndex,
      pos = pos,
      pieceType = pieceType,
      FixBlock = FixBlock,
      FixNoBlock = FixNoBlock,
      FloatBlock = FloatBlock,
      FloatNoBlock = FloatNoBlock,
      isPieceEffect = isPieceEffect,
      prismEntityID = prismEntityID,
      pieceEffectType = pieceEffectType,
      isTeam = isTeam,
      isBlock = 0 < #FixBlock
    }
  end
  return envList
end

function SkillEffectCalc_Transport:_TransportOneStep(result, envList, isLoop)
  local sBoard = self._world:GetService("BoardLogic")
  local cBoard = self._world:GetBoardEntity():Board()
  local sRandom = self._world:GetService("RandomLogic")
  local sTrigger = self._world:GetService("Trigger")
  local lastTransportDir
  local toTriggerTraps = {}
  for i, env in ipairs(envList) do
    local nextEnv = self:_GetNeighboringEnv(envList, env, 1, isLoop)
    if not nextEnv then
      break
    end
    result:AddTransportPiece(env.pos, nextEnv.pos)
    lastTransportDir = nextEnv.pos - env.pos
    local pieceType = env.pieceType
    if self:_CheckNextBlock(env, envList, isLoop, env) then
      if env.isTeam then
        pieceType = sRandom:LogicRand(1, 4)
      end
      if nextEnv.isTeam then
        pieceType = PieceType.None
      end
    end
    result:AddConvertColor(nextEnv.pos, nextEnv.pieceType, pieceType)
    sBoard:SetPieceTypeLogic(pieceType, nextEnv.pos)
    if env.isPieceEffect then
      if self:_CheckNextBlock(env, envList, isLoop, env) and nextEnv.isTeam then
        result:AddTransportPrism(env.pos, nil, env.prismEntityID, env.pieceEffectType)
      else
        result:AddTransportPrism(env.pos, nextEnv.pos, env.prismEntityID, env.pieceEffectType)
      end
    end
    local efb = env.FloatBlock[1]
    if efb and not self:_CheckNextBlock(env, envList, isLoop, env) then
      result:AddTransportEntity(efb:GetID(), env.pos, nextEnv.pos)
      efb:SetGridPosition(nextEnv.pos)
      sBoard:UpdateEntityBlockFlag(efb, env.pos, nextEnv.pos)
      if efb:HasTeam() then
        local pets = efb:Team():GetTeamPetEntities()
        for i, e in ipairs(pets) do
          e:SetGridPosition(nextEnv.pos)
        end
      end
      sTrigger:Notify(NTTransportEachMoveEnd:New(efb, env.pos, nextEnv.pos))
      if #nextEnv.FixNoBlock > 0 then
        toTriggerTraps[#toTriggerTraps + 1] = {
          nextEnv.FixNoBlock,
          efb
        }
      end
    end
    local es = env.FloatNoBlock
    if 0 < #es then
      for i, e in ipairs(es) do
        result:AddTransportEntity(e:GetID(), env.pos, nextEnv.pos)
        e:SetGridPosition(nextEnv.pos)
        sBoard:UpdateEntityBlockFlag(e, env.pos, nextEnv.pos)
      end
      if nextEnv.isBlock then
        local ne = nextEnv.FixBlock[1] or nextEnv.FloatBlock[1]
        if ne then
          toTriggerTraps[#toTriggerTraps + 1] = {es, ne}
        end
      end
    end
  end
  for i, v in ipairs(result:GetTransportPrisms()) do
    cBoard:RemoveBoardPieceEffectType(v[1])
  end
  for i, v in ipairs(result:GetTransportPrisms()) do
    local newPos = v[2]
    local prismEntityID = v[3]
    local pieceEffectType = v[4]
    if newPos then
      cBoard:SetBoardPieceEffectType(newPos, pieceEffectType, prismEntityID)
    end
  end
  result:SetIsLoop(isLoop)
  if isLoop == 0 then
    local envIndexFirst = envList[1]
    local envIndexSecond = envList[2]
    local moveDir = envIndexSecond.pos - envIndexFirst.pos
    local envIndexZeroPos = envIndexFirst.pos - moveDir
    local pieceFillTable = sBoard:SupplyPieceList({
      envIndexFirst.pos
    })
    local pieceType = pieceFillTable[1].color
    if pieceType ~= envIndexFirst.pieceType then
      result:AddConvertColor(envIndexFirst.pos, envIndexFirst.pieceType, pieceType)
      sBoard:SetPieceTypeLogic(pieceType, envIndexFirst.pos)
    end
  end
  for i, v in ipairs(toTriggerTraps) do
    self:_TriggerTraps(result, v[1], v[2])
  end
end

function SkillEffectCalc_Transport:_TriggerTraps(result, traps, triggerEntity)
  if triggerEntity:HasTrapID() then
    return
  end
  local trapSvc = self._world:GetService("TrapLogic")
  for _, e in ipairs(traps) do
    if e:HasTrapID() then
      local triggerTraps, triggerResults = trapSvc:CalcTrapTriggerSkill(e, triggerEntity)
      if triggerTraps then
        for i, trap in ipairs(triggerTraps) do
          local skillResult = triggerResults[i]
          result:AddTrapSkillResult(trap:GetID(), skillResult, triggerEntity:GetID())
        end
      end
    end
  end
end

function SkillEffectCalc_Transport:_CheckNextBlock(env, envList, isLoop, start)
  local nextEnv = self:_GetNeighboringEnv(envList, env, 1, isLoop)
  if not nextEnv then
    return true
  end
  if nextEnv == start then
    return false
  end
  if nextEnv.isBlock then
    if #env.FloatBlock > 0 then
      env.isBlock = true
    end
    return true
  end
  if #nextEnv.FloatBlock > 0 then
    return self:_CheckNextBlock(nextEnv, envList, isLoop, start)
  end
  return false
end

function SkillEffectCalc_Transport:_GetNeighboringEnv(envList, env, offset, isLoop)
  local total = #envList
  local envIdx = env.index
  local idx = envIdx + offset
  if total < idx and isLoop == 1 then
    idx = 1
  end
  local neighboringEnv = envList[idx]
  return neighboringEnv
end
