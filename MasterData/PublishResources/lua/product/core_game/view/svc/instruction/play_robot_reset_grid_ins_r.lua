require("base_ins_r")
_class("PlayRobotResetGridInstruction", BaseInstruction)
PlayRobotResetGridInstruction = PlayRobotResetGridInstruction

function PlayRobotResetGridInstruction:Constructor(paramList)
  self._effectTrapID = tonumber(paramList.effectTrapID) or 150228110
  self._materialAnim1 = paramList.materialAnim1 or "eff_15022811_atkult_mat01"
  self._materialAnim2 = paramList.materialAnim2 or "eff_15022811_atkult_move_mat03"
  self._materialAnim3 = paramList.materialAnim2 or "eff_15022811_atkult_mat02"
  self._moveStartTime = tonumber(paramList.moveStartTime) or 660
  self._startWait = tonumber(paramList.startWait) or 400
  self._trapMoveEffectID = tonumber(paramList.trapMoveEffectID) or 150228109
  self._colorPaletteEffectID = tonumber(paramList["colorPaletteEffectID "]) or 150228107
  self._bombEffectID = tonumber(paramList["bombEffectID "]) or 150228108
  self._colorPaletteAudioID = tonumber(paramList.colorPaletteAudioID) or 150228103
  self._bombAudioID = tonumber(paramList.bombAudioID) or 150228104
  self._colorPaletteTime = tonumber(paramList.colorPaletteTime) or 1100
  self._destroyWaitTime = tonumber(paramList.destroyWaitTime) or 400
end

function PlayRobotResetGridInstruction:GetCacheResource()
  local t = {}
  if self._effectTrapID and self._effectTrapID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectTrapID].ResPath,
      4
    })
  end
  if self._trapMoveEffectID and 0 < self._trapMoveEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapMoveEffectID].ResPath,
      4
    })
  end
  if self._colorPaletteEffectID and 0 < self._colorPaletteEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._colorPaletteEffectID].ResPath,
      4
    })
  end
  if self._bombEffectID and 0 < self._bombEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._bombEffectID].ResPath,
      4
    })
  end
  return t
end

function PlayRobotResetGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
  local hasColorPaletteChargeResult = false
  local colorPaletteChargeResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ColorPaletteCharge)
  if colorPaletteChargeResultArray and table.count(colorPaletteChargeResultArray) > 0 then
    hasColorPaletteChargeResult = true
  end
  local pieceService = world:GetService("Piece")
  local svcPlayBuff = world:GetService("PlayBuff")
  local trapServiceRender = world:GetService("TrapRender")
  local effectService = world:GetService("Effect")
  local utilDataSvc = world:GetService("UtilData")
  local boardGridPosList = utilDataSvc:GetCloneBoardGridPos()
  local casterPos = casterEntity:GetRenderGridPosition()
  local startPosList = {}
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
  local aroundCasterOffsetListNew = {}
  local aroundCasterPosList = {}
  for _, pos in ipairs(aroundCasterOffsetList) do
    local workPos = casterPos + pos
    table.insert(aroundCasterOffsetListNew, workPos)
    if utilDataSvc:IsValidPiecePos(workPos) and not table.icontains(aroundCasterPosList, workPos) then
      table.insert(aroundCasterPosList, workPos)
    end
  end
  local scopeResult = skillResultArray:GetSkillEffectScopeResult()
  local attackRange = scopeResult:GetAttackRange()
  for _, v in pairs(attackRange) do
    if table.count(aroundCasterPosList) > 0 then
      table.sort(aroundCasterPosList, function(a, b)
        local disA = Vector2.Distance(a, v)
        local disB = Vector2.Distance(b, v)
        return disA < disB
      end)
      table.insert(startPosList, aroundCasterPosList[1])
      table.removev(aroundCasterPosList, aroundCasterPosList[1])
    end
  end
  while table.count(startPosList) < table.count(attackRange) do
    local randomIndex = math.random(1, table.count(aroundCasterOffsetListNew))
    local randomPos = aroundCasterOffsetListNew[randomIndex]
    if not table.icontains(startPosList, randomPos) then
      table.insert(startPosList, aroundCasterOffsetListNew[randomIndex])
      table.removev(aroundCasterOffsetListNew, aroundCasterOffsetListNew[randomIndex])
    end
  end
  local effectTrapList = {}
  local effectTrapEntityIDList = {}
  local resServ = world.BW_Services.ResourcesPool
  local containerShaderEffect = resServ:LoadAsset("15022811_shader_effects.asset")
  for _, v in pairs(attackRange) do
    local effectTrap = effectService:CreateEffect(self._effectTrapID, casterEntity)
    table.insert(effectTrapList, effectTrap)
    table.insert(effectTrapEntityIDList, effectTrap:GetID())
    local viewCmpt = effectTrap:View()
    local playerObj = viewCmpt:GetGameObject()
    local animator = playerObj.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
    local matAnimMonoCmpt = playerObj:GetComponent(typeof(MaterialAnimation))
    if matAnimMonoCmpt then
      UnityEngine.Object.Destroy(matAnimMonoCmpt)
    end
    matAnimMonoCmpt = playerObj:AddComponent(typeof(MaterialAnimation))
    effectTrap:RemoveMaterialAnimationComponent()
    if containerShaderEffect then
      effectTrap:AddMaterialAnimationComponent(containerShaderEffect, matAnimMonoCmpt)
    end
    effectTrap:PlayMaterialAnim(self._materialAnim1)
    local walkDir = v - casterPos
    effectTrap:SetLocation(casterPos, walkDir)
  end
  YIELD(TT, self._startWait)
  for i, v in pairs(startPosList) do
    local effectTrap = effectTrapList[i]
    effectTrap:AddGridMove(BattleConst.MoveSpeed, v, casterPos)
  end
  YIELD(TT, self._moveStartTime)
  for _, effectTrap in pairs(effectTrapList) do
    local viewCmpt = effectTrap:View()
    local playerObj = viewCmpt:GetGameObject()
    local animator = playerObj.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
    animator:SetBool("Move", true)
  end
  local moveTrapIDList = {}
  local trapMoveEffectEntityIDList = {}
  local moveCount = 0
  for i, endPos in pairs(attackRange) do
    local startPos = startPosList[i]
    if startPos ~= endPos then
      local effectTrap = effectTrapList[i]
      effectTrap:AddGridMove(BattleConst.MoveSpeed, endPos, startPos)
      moveCount = moveCount + 1
      table.insert(moveTrapIDList, effectTrap:GetID())
      local effectTrapTrail = effectService:CreateEffect(self._trapMoveEffectID, effectTrap)
      effectTrap:PlayMaterialAnim(self._materialAnim2)
      table.insert(trapMoveEffectEntityIDList, effectTrapTrail:GetID())
    end
  end
  if moveCount == 0 then
  else
  end
  while moveCount ~= 0 do
    YIELD(TT)
    moveCount = 0
    for _, effectTrap in pairs(effectTrapList) do
      if effectTrap:HasGridMove() then
        moveCount = moveCount + 1
      elseif table.icontains(moveTrapIDList, effectTrap:GetID()) then
        table.removev(moveTrapIDList, effectTrap:GetID())
        effectTrap:StopMaterialAnim(self._materialAnim2)
        local viewCmpt = effectTrap:View()
        local playerObj = viewCmpt:GetGameObject()
        local animator = playerObj.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
        animator:SetBool("Move", false)
      end
    end
  end
  for _, entityID in pairs(trapMoveEffectEntityIDList) do
    local effectEntity = world:GetEntityByID(entityID)
    world:DestroyEntity(effectEntity)
  end
  local effectCpmt = casterEntity:EffectHolder()
  if not effectCpmt then
    casterEntity:AddEffectHolder()
    effectCpmt = casterEntity:EffectHolder()
  end
  if hasColorPaletteChargeResult == true then
    for _, effectTrap in pairs(effectTrapList) do
      effectTrap:PlayMaterialAnim(self._materialAnim3)
      effectService:CreateEffect(self._colorPaletteEffectID, effectTrap)
    end
    local playingID = AudioHelperController.PlayInnerGameSfx(self._colorPaletteAudioID)
    effectCpmt:AttachAudioID(self._colorPaletteAudioID, playingID)
    YIELD(TT, self._colorPaletteTime)
  end
  for _, v in pairs(attackRange) do
    effectService:CreateWorldPositionDirectionEffect(self._bombEffectID, v)
  end
  local playingID = AudioHelperController.PlayInnerGameSfx(self._bombAudioID)
  effectCpmt:AttachAudioID(self._bombAudioID, playingID)
  YIELD(TT, self._destroyWaitTime)
  for _, effectTrapID in pairs(effectTrapEntityIDList) do
    local effectTrap = world:GetEntityByID(effectTrapID)
    world:DestroyEntity(effectTrap)
  end
  YIELD(TT)
end
