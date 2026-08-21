require("base_ins_r")
_class("PlayRobotSummonMeantimeLimitInstruction", BaseInstruction)
PlayRobotSummonMeantimeLimitInstruction = PlayRobotSummonMeantimeLimitInstruction

function PlayRobotSummonMeantimeLimitInstruction:Constructor(paramList)
  self._trapDieSkillID = tonumber(paramList.trapDieSkillID)
  self._materialAnim1 = paramList.materialAnim1 or "eff_15022811_atkult_mat01"
  self._materialAnim2 = paramList.materialAnim2 or "eff_15022811_atkult_move_mat03"
  self._moveStartTime = tonumber(paramList.moveStartTime) or 660
  self._startWait = tonumber(paramList.startWait) or 400
  self._trapMoveEffectID = tonumber(paramList.trapMoveEffectID) or 150228109
end

function PlayRobotSummonMeantimeLimitInstruction:GetCacheResource()
  local t = {}
  if self._trapMoveEffectID and self._trapMoveEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._trapMoveEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayRobotSummonMeantimeLimitInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonMeantimeLimit)
  if not resultArray then
    return
  end
  local trapServiceRender = world:GetService("TrapRender")
  local effectService = world:GetService("Effect")
  local utilDataSvc = world:GetService("UtilData")
  local playSkillSvc = world:GetService("PlaySkill")
  local configSvc = world:GetService("Config")
  local skillPhaseArray
  if self._trapDieSkillID then
    local skillConfigData = configSvc:GetSkillConfigData(self._trapDieSkillID, casterEntity)
    skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  end
  local trapEntity
  for _, result in ipairs(resultArray) do
    local destroyEntityID = result:GetDestroyEntityID()
    for i, entityID in ipairs(destroyEntityID) do
      local entity = world:GetEntityByID(entityID)
      if entity then
        local skillHolder = entity
        local skillResult = result:GetTrapDieSkillResult()[i]
        if skillResult then
          skillHolder:SkillRoutine():SetResultContainer(skillResult)
        end
        if self._trapDieSkillID then
          playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, self._trapDieSkillID)
        end
        trapServiceRender:PlayTrapDieSkill(TT, {entity})
      end
    end
    local trapIDList = result:GetTrapIDList()
    for i = 1, #trapIDList do
      trapEntity = world:GetEntityByID(trapIDList[i])
      trapServiceRender:CreateSingleTrapRender(TT, trapEntity, false)
    end
    trapServiceRender:UpdateAllTrapSummonIndex()
  end
  if not trapEntity then
    return
  end
  local trapShowPos = trapEntity:GetRenderGridPosition()
  local casterPos = casterEntity:GetRenderGridPosition()
  local aroundCasterOffsetList = {
    Vector2(0, 1),
    Vector2(0, -1),
    Vector2(1, 1),
    Vector2(1, -1),
    Vector2(-1, 1),
    Vector2(-1, -1),
    Vector2(-1, 0),
    Vector2(1, 0)
  }
  local aroundCasterPosList = {}
  for _, pos in ipairs(aroundCasterOffsetList) do
    local workPos = casterPos + pos
    if utilDataSvc:IsValidPiecePos(workPos) and not table.icontains(aroundCasterPosList, workPos) then
      table.insert(aroundCasterPosList, workPos)
    end
  end
  table.sort(aroundCasterPosList, function(a, b)
    local disA = Vector2.Distance(a, trapShowPos)
    local disB = Vector2.Distance(b, trapShowPos)
    return disA < disB
  end)
  local trapStartPos = aroundCasterPosList[1]
  local viewCmpt = trapEntity:View()
  local playerObj = viewCmpt:GetGameObject()
  local animator = playerObj.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
  local walkDir = trapStartPos - casterPos
  trapEntity:SetLocation(casterPos, walkDir)
  YIELD(TT)
  trapEntity:SetViewVisible(true)
  trapEntity:StopMaterialAnim(self._materialAnim2)
  trapEntity:StopMaterialAnim(self._materialAnim1)
  trapEntity:PlayMaterialAnim(self._materialAnim1)
  YIELD(TT, self._startWait)
  trapEntity:AddGridMove(BattleConst.MoveSpeed, trapStartPos, casterPos)
  YIELD(TT, self._moveStartTime)
  animator:SetBool("Move", true)
  trapEntity:AddGridMove(BattleConst.MoveSpeed, trapShowPos, trapStartPos)
  local effectTrapTrail = effectService:CreateEffect(self._trapMoveEffectID, trapEntity)
  trapEntity:PlayMaterialAnim(self._materialAnim2)
  while trapEntity:HasGridMove() do
    YIELD(TT)
  end
  trapEntity:StopMaterialAnim(self._materialAnim2)
  animator:SetBool("Move", false)
  world:DestroyEntity(effectTrapTrail)
  YIELD(TT)
end
