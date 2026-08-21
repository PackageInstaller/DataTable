require("base_ins_r")
_class("RobotBombInstruction", BaseInstruction)
RobotBombInstruction = RobotBombInstruction

function RobotBombInstruction:Constructor(paramList)
  self._robotEffectID = tonumber(paramList.effectID) or 150228110
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._donotPlayDie = paramList.donotPlayDie or false
  self._materialAnim1 = paramList.materialAnim1 or "eff_15022811_atkult_mat01"
  self._materialAnim2 = paramList.materialAnim2 or "eff_15022811_atkult_move_mat03"
  self._materialAnim3 = paramList.materialAnim2 or "eff_15022811_atkult_mat02"
  self._moveStartTime = tonumber(paramList.moveStartTime) or 660
  self._startWait = tonumber(paramList.startWait) or 400
  self._trapMoveEffectID = tonumber(paramList.trapMoveEffectID) or 150228109
  self._colorPaletteEffectID = tonumber(paramList["colorPaletteEffectID "]) or 150228107
  self._bombEffectID = tonumber(paramList["bombEffectID "]) or 150228108
end

function RobotBombInstruction:GetCacheResource()
  local t = {}
  if self._robotEffectID and self._robotEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._robotEffectID].ResPath,
      1
    })
  end
  if self._bombEffectID and 0 < self._bombEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._bombEffectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._trapMoveEffectID and 0 < self._trapMoveEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapMoveEffectID].ResPath,
      4
    })
  end
  return t
end

function RobotBombInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not casterEntity:HasPetPstID() then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.RobotBomb)
  self._world = casterEntity:GetOwnerWorld()
  self._effectService = self._world:GetService("Effect")
  local resourcesPoolService = self._world.BW_Services.ResourcesPool
  local shaderEffect = resourcesPoolService:LoadAsset("15022811_shader_effects.asset")
  local casterPosition = casterEntity:GetRenderGridPosition()
  for _, value in ipairs(resultArray) do
    local result = value
    if result.trapEntityID then
      local trapEntity = self._world:GetEntityByID(result.trapEntityID)
      GameGlobal.TaskManager():CoreGameStartTask(self._PlayRobot, self, trapEntity, casterEntity, result, phaseContext, 1)
    else
      local robot = self._effectService:CreateEffect(self._robotEffectID, casterEntity)
      local viewComponent = robot:View()
      local robotObj = viewComponent:GetGameObject()
      local materialAnimation = robotObj:GetComponent(typeof(MaterialAnimation))
      if materialAnimation then
        UnityEngine.Object.Destroy(materialAnimation)
      end
      materialAnimation = robotObj:AddComponent(typeof(MaterialAnimation))
      robot:RemoveMaterialAnimationComponent()
      if shaderEffect then
        robot:AddMaterialAnimationComponent(shaderEffect, materialAnimation)
      end
      robot:PlayMaterialAnim(self._materialAnim1)
      if result.path[2] then
        local walkDir = result.path[2] - casterPosition
        robot:SetLocation(casterPosition, walkDir)
      end
      YIELD(TT, self._startWait)
      if result.path[2] then
        robot:AddGridMove(BattleConst.MoveSpeed, result.path[2], casterPosition)
      end
      YIELD(TT, self._moveStartTime)
      GameGlobal.TaskManager():CoreGameStartTask(self._PlayRobot, self, robot, casterEntity, result, phaseContext, 2)
    end
  end
end

function RobotBombInstruction:_PlayRobot(TT, robot, casterEntity, result, phaseContext, pathStartIndex)
  self:_Move(TT, robot, result, pathStartIndex)
  self:_PlayExplodeEffect(result.path[#result.path])
  self:_PlayHit(TT, casterEntity, result)
  self:_RechargeColorPalette(TT, casterEntity, result)
  if result.trapEntityID then
    local trapServiceRender = self._world:GetService("TrapRender")
    local dieTaskID = TaskManager:GetInstance():CoreGameStartTask(trapServiceRender.PlayTrapDieSkill, trapServiceRender, {robot}, self._donotPlayDie)
    phaseContext:AddPhaseTask(dieTaskID)
  else
    self._world:DestroyEntity(robot)
  end
end

function RobotBombInstruction:_RechargeColorPalette(TT, casterEntity, result)
  local pieceTypes = {}
  for _, pieceType in ipairs(result.pieceTypes) do
    if pieceType ~= PieceType.None then
      table.insert(pieceTypes, pieceType)
    end
  end
  if not casterEntity:HasColorPaletteRender() then
    casterEntity:AddColorPaletteRender()
  end
  local renderComponent = casterEntity:ColorPaletteRender()
  local isNotSatisfy = not renderComponent:IsSatisfy()
  renderComponent:AddPieceTypes(pieceTypes)
  self._world:EventDispatcher():Dispatch(GameEventType.ColorPaletteRefresh, casterEntity:PetPstID():GetPstID(), renderComponent:GetPieceTypes())
  if isNotSatisfy and renderComponent:IsSatisfy() then
    self:_RefreshExtraActiveSkillReady(casterEntity)
    local playBuffSvc = self._world:GetService("PlayBuff")
    playBuffSvc:PlayBuffView(TT, NTColorPaletteChargeComplete:New(casterEntity, renderComponent:GetPieceTypes()))
  end
end

function RobotBombInstruction:_Move(TT, robot, result, pathStartIndex)
  if #result.path >= 3 then
    local viewComponent = robot:View()
    local robotObj = viewComponent:GetGameObject()
    local animator = robotObj.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
    animator:SetBool("Move", true)
    local effectTrailEntity = self._effectService:CreateEffect(self._trapMoveEffectID, robot)
    robot:PlayMaterialAnim(self._materialAnim2)
    for i = pathStartIndex, #result.path do
      local curPosition = result.path[i]
      local nextPosition = result.path[i + 1]
      if nextPosition then
        robot:AddGridMove(BattleConst.MoveSpeed, nextPosition, curPosition)
        while robot:HasGridMove() do
          YIELD(TT)
        end
      end
    end
    robot:StopMaterialAnim(self._materialAnim2)
    animator:SetBool("Move", false)
    self._world:DestroyEntity(effectTrailEntity)
  end
end

function RobotBombInstruction:_PlayExplodeEffect(position)
  local effectService = self._world:GetService("Effect")
  effectService:CreateWorldPositionDirectionEffect(self._bombEffectID, position)
end

function RobotBombInstruction:_PlayHit(TT, casterEntity, result)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local playSkillService = self._world:GetService("PlaySkill")
  local damageResults = result.damageResult
  for _, damageResult in ipairs(damageResults) do
    local targetEntity = self._world:GetEntityByID(damageResult:GetTargetID())
    local damageInfo = damageResult:GetDamageInfo(1)
    local damageGridPos = damageResult:GetGridPos()
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    playSkillService:HandleBeHit(TT, beHitParam)
  end
end

function RobotBombInstruction:_RefreshExtraActiveSkillReady(entity)
  local world = entity:GetOwnerWorld()
  local configService = world:GetService("Config")
  local extraSkillList = entity:SkillInfo():GetExtraActiveSkillIDList()
  if extraSkillList then
    for _, extraSkillID in ipairs(extraSkillList) do
      local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
      if extraSkillConfigData and extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, entity:PetPstID():GetPstID(), extraSkillID, true)
      end
    end
  end
end
