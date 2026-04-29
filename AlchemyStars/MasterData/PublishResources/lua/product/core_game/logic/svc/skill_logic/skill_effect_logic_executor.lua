require("notify_extends")
_class("SkillEffectLogicExecutor", Object)
SkillEffectLogicExecutor = SkillEffectLogicExecutor

function SkillEffectLogicExecutor:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._trapServiceLogic = self._world:GetService("TrapLogic")
  self._battleServiceLogic = self._world:GetService("Battle")
  self._applyFuncDic = {}
  self._applyFuncDic[SkillEffectType.Damage] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.AddBlood] = self._ApplyAddBlood
  self._applyFuncDic[SkillEffectType.SummonTrap] = self._ApplySummonTrap
  self._applyFuncDic[SkillEffectType.Escape] = self._ApplyEscape
  self._applyFuncDic[SkillEffectType.Rotate] = self._ApplyRotate
  self._applyFuncDic[SkillEffectType.EachGridAddBlood] = self._ApplyEachGridAddBlood
  self._applyFuncDic[SkillEffectType.SummonEverything] = self._ApplySummonEverything
  self._applyFuncDic[SkillEffectType.Teleport] = self._ApplyTeleport
  self._applyFuncDic[SkillEffectType.SummonMultipleTrap] = self._ApplySummonTrap
  self._applyFuncDic[SkillEffectType.SummonOnHitbackPosition] = self._ApplySummonTrap
  self._applyFuncDic[SkillEffectType.SacrificeTrapsAndDamage] = self._ApplySacrificeTrapsAndDamage
  self._applyFuncDic[SkillEffectType.DamageOnTargetCount] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.AbsorbPhantom] = self._ApplyAbsorbPhantom
  self._applyFuncDic[SkillEffectType.AddCollectDropNum] = self._ApplyAddCollectDropNum
  self._applyFuncDic[SkillEffectType.DimensionTransport] = self._ApplyDimensionTransport
  self._applyFuncDic[SkillEffectType.AddDimensionFlag] = self._ApplyAddDimensionFlag
  self._applyFuncDic[SkillEffectType.AddBloodOverFlow] = self._ApplyAddBloodOverFlow
  self._applyFuncDic[SkillEffectType.CreateDestroyGrid] = self._ApplyCreateDestroyGrid
  self._applyFuncDic[SkillEffectType.MultiTraction] = self._ApplyMultiTraction
  self._applyFuncDic[SkillEffectType.ResetGridElement] = self._ApplyResetGridElement
  self._applyFuncDic[SkillEffectType.ConvertGridElement] = self._ApplyConvertGridElement
  self._applyFuncDic[SkillEffectType.ConvertOccupiedGridElement] = self._ApplyConvertOccupiedGridElement
  self._applyFuncDic[SkillEffectType.AbsorbPiece] = self._ApplyAbsorbPiece
  self._applyFuncDic[SkillEffectType.PullAround] = self._ApplyPullAround
  self._applyFuncDic[SkillEffectType.MakePhantom] = self._ApplyMakePhantom
  self._applyFuncDic[SkillEffectType.Transformation] = self._ApplyTransformation
  self._applyFuncDic[SkillEffectType.DestroyTrap] = self._ApplyDestroyTrap
  self._applyFuncDic[SkillEffectType.AngleFreeLineDamage] = self._ApplyAngleFreeLineDamage
  self._applyFuncDic[SkillEffectType.SplashDamage] = self._ApplySplashDamage
  self._applyFuncDic[SkillEffectType.IslandConvert] = self._ApplyIslandConvert
  self._applyFuncDic[SkillEffectType.ResetSingleColorGridElement] = self._ApplyResetSingleColorGridElement
  self._applyFuncDic[SkillEffectType.StampDamage] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.EnhanceOccupiedGrid] = self._ApplySummonTrap
  self._applyFuncDic[SkillEffectType.CostCasterHP] = self._ApplyCostCasterHP
  self._applyFuncDic[SkillEffectType.ExChangeGridColor] = self._ApplyExChangeGridColor
  self._applyFuncDic[SkillEffectType.ChangeElement] = self._ApplyChangeElement
  self._applyFuncDic[SkillEffectType.IsolateConvert] = self._ApplyIsolateConvert
  self._applyFuncDic[SkillEffectType.DamageBasedOnTargetAttribute] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.DamageBasedOnPickUpRect] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.MultipleScopesDealMultipleDamage] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.RotateToPickup] = self._ApplyRotateToPickup
  self._applyFuncDic[SkillEffectType.DamageToBuffTarget] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.StickerLeave] = self._ApplyConvertGridElement
  self._applyFuncDic[SkillEffectType.ConvertWithTrapRecord] = self._ApplyConvertGridElement
  self._applyFuncDic[SkillEffectType.FrontExtendDegressiveDamage] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.TeleportAndSummonTrap] = self._ApplyTeleportAndSummonTrap
  self._applyFuncDic[SkillEffectType.ChangeBuffLayer] = self._ApplyChangeBuffLayer
  self._applyFuncDic[SkillEffectType.SummonMeantimeLimit] = self._ApplySummonMeantimeLimit
  self._applyFuncDic[SkillEffectType.MultipleDamageWithBuffLayer] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.DestroyMonster] = self._ApplyDestroyMonster
  self._applyFuncDic[SkillEffectType.SealedCurse] = self._ApplySealedCurse
  self._applyFuncDic[SkillEffectType.DamageOnTargetDistance] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.AddBloodOverFlowForDamage] = self._ApplyAddBloodOverFlowForDamage
  self._applyFuncDic[SkillEffectType.DamageBasedOnSectorAngle] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.SplashPreDamage] = self._ApplySplashDamage
  self._applyFuncDic[SkillEffectType.RotateByPickSector] = self._ApplyRotateByPickSector
  self._applyFuncDic[SkillEffectType.SummonOnFixPosLimit] = self._ApplySummonOnFixPosLimit
  self._applyFuncDic[SkillEffectType.SwitchBodyPart] = self._ApplySwitchBodyPart
  self._applyFuncDic[SkillEffectType.ChangePetTeamOrder] = self._ApplyChangePetTeamOrder
  self._applyFuncDic[SkillEffectType.SwapPetTeamOrder] = self._ApplySwapPetTeamOrder
  self._applyFuncDic[SkillEffectType.GatherThrowDamage] = self._ApplyGatherThrowDamage
  self._applyFuncDic[SkillEffectType.TriggerTrap] = self._ApplyTriggerTrapResult
  self._applyFuncDic[SkillEffectType.AbsorbTrapsAndDamageByPickupTarget] = self._ApplyAbsorbTrapsAndDamageByPickupTarget
  self._applyFuncDic[SkillEffectType.MoveBoard] = self._ApplyMoveBoard
  self._applyFuncDic[SkillEffectType.EachTrapAddBlood] = self._ApplyEachTrapAddBlood
  self._applyFuncDic[SkillEffectType.RecoverFromGreyHP] = self._ApplyRecoverFromGreyHP
  self._applyFuncDic[SkillEffectType.DecreaseSanByScope] = self._ApplyDecreaseSanByScope
  self._applyFuncDic[SkillEffectType.IncreaseSan] = self._ApplyIncreaseSan
  self._applyFuncDic[SkillEffectType.AlphaThrowTrap] = self._ApplyAlphaThrowTrap
  self._applyFuncDic[SkillEffectType.AlphaBlinkAttack] = self._ApplyAlphaBlinkAttack
  self._applyFuncDic[SkillEffectType.RideOn] = self._ApplyRideOn
  self._applyFuncDic[SkillEffectType.DamageSamePosReduce] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.SacrificeTraps] = self._ApplySacrificeTraps
  self._applyFuncDic[SkillEffectType.DamageBySacrificeTraps] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.SerialKiller] = self._ApplySerialKiller
  self._applyFuncDic[SkillEffectType.RandAttack] = self._ApplyRandAttack
  self._applyFuncDic[SkillEffectType.HighFrequencyDamage] = self._ApplyHighFrequencyDamage
  self._applyFuncDic[SkillEffectType.HighFrequencyDamage2] = self._ApplyHighFrequencyDamage
  self._applyFuncDic[SkillEffectType.DegressiveDirectionalDamage] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.DamageReflectDistance] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.RubikCube] = self._ApplyRubikCube
  self._applyFuncDic[SkillEffectType.ChangeBodyArea] = self._ApplyChangeBodyArea
  self._applyFuncDic[SkillEffectType.DrawCard] = self._ApplyDrawCard
  self._applyFuncDic[SkillEffectType.TransportByRange] = self._ApplyTransportByRange
  self._applyFuncDic[SkillEffectType.LevelTrapAbsortSummon] = self._ApplyLevelTrapAbsortSummon
  self._applyFuncDic[SkillEffectType.LevelTrapUpLevel] = self._ApplyLevelTrapUpLevel
  self._applyFuncDic[SkillEffectType.LevelTrapSummonOrUpLevel] = self._ApplyLevelTrapSummonOrUpLevel
  self._applyFuncDic[SkillEffectType.ModifyAntiAttackParam] = self._ApplyModifyAntiAttackParam
  self._applyFuncDic[SkillEffectType.PetSacrificeSuperGridTraps] = self._ApplyPetSacrificeSuperGridTraps
  self._applyFuncDic[SkillEffectType.PetMinosGhostDamage] = self._ApplyPetMinosGhostDamage
  self._applyFuncDic[SkillEffectType.CoffinMusumeCandle] = self._ApplyCoffinMusumeCandle
  self._applyFuncDic[SkillEffectType.CoffinMusumeSetCandleLight] = self._ApplyCoffinMusumeSetCandleLight
  self._applyFuncDic[SkillEffectType.Transposition] = self._ApplyTransposition
  self._applyFuncDic[SkillEffectType.SnakeHeadMove] = self._ApplySnakeHeadMove
  self._applyFuncDic[SkillEffectType.SnakeBodyMoveAndGrowth] = self._ApplySnakeBodyMoveAndGrowth
  self._applyFuncDic[SkillEffectType.SnakeTailMove] = self._ApplySnakeTailMove
  self._applyFuncDic[SkillEffectType.SummonTrapByCasterPos] = self._ApplySummonTrap
  self._applyFuncDic[SkillEffectType.SummonTrapOrHealByTrapBuffLayer] = self._ApplySummonTrapOrHealByTrapBuffLayer
  self._applyFuncDic[SkillEffectType.WeikeNotify] = self._ApplyWeikeNotify
  self._applyFuncDic[SkillEffectType.SetMonsterOffBoard] = self._ApplySetMonsterOffBoard
  self._applyFuncDic[SkillEffectType.SplashDamageAndAddBuff] = self._ApplySplashDamageAndAddBuff
  self._applyFuncDic[SkillEffectType.DynamicCenterDamage] = self._ApplyDynamicCenterDamage
  self._applyFuncDic[SkillEffectType.AddMoveScopeRecordCmpt] = self._ApplyAddMoveScopeRecordCmpt
  self._applyFuncDic[SkillEffectType.TrapMoveAndDamage] = self._ApplyTrapMoveAndDamage
  self._applyFuncDic[SkillEffectType.ThrowMonsterAndDamage] = self._ApplyThrowMonsterAndDamage
  self._applyFuncDic[SkillEffectType.DamageByBuffLayer] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.TeleportTeamAroundAndSummonTrapLine] = self._ApplyTeleportTeamAroundAndSummonTrapLine
  self._applyFuncDic[SkillEffectType.TurnToTargetChangeBodyAreaAndDir] = self._ApplyTurnToTargetChangeBodyAreaAndDir
  self._applyFuncDic[SkillEffectType.ControlMonsterMove] = self._ApplyControlMonsterMove
  self._applyFuncDic[SkillEffectType.ConvertAndDamageByLinkLine] = self._ApplyConvertAndDamageByLinkLine
  self._applyFuncDic[SkillEffectType.PetTrapMove] = self._ApplyPetTrapMove
  self._applyFuncDic[SkillEffectType.SacrificeTargetNearestTrapsAndDamage] = self._ApplySacrificeTargetNearestTrapsAndDamage
  self._applyFuncDic[SkillEffectType.DynamicScopeChainDamage] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.AttachMonster] = self._ApplyAttachMonster
  self._applyFuncDic[SkillEffectType.DetachMonster] = self._ApplyDetachMonster
  self._applyFuncDic[SkillEffectType.NightKingTeleportPathDamage] = self._ApplyNightKingTeleportPathDamage
  self._applyFuncDic[SkillEffectType.SpliceBoard] = self._ApplySpliceBoard
  self._applyFuncDic[SkillEffectType.DamageBySelectPieceCount] = self._ApplyDamage
  self._applyFuncDic[SkillEffectType.SummonFourAreaMonsterOnBoardEdge] = self._ApplySummonEverything
  self._applyFuncDic[SkillEffectType.ButterflySummon] = self._ApplySummonEverything
  self._applyFuncDic[SkillEffectType.PickUpGridTogether] = self._ApplyPickUpGridTogether
  self._applyFuncDic[SkillEffectType.ControlMonsterCastHitBackTeam] = self._ApplyControlMonsterCastHitBackTeam
  self._applyFuncDic[SkillEffectType.TeleportAndTurnBodyArea] = self._ApplyTeleportAndChangeBodyArea
  self._applyFuncDic[SkillEffectType.FixTrapWall] = self._ApplyFixTrapWall
  self._applyFuncDic[SkillEffectType.SetGridMaintainColorForSupply] = self._ApplySetGridMaintainColorForSupply
  self._applyFuncDic[SkillEffectType.CrabMoveAndAttack] = self._ApplyCrabMoveAndAttack
  self._applyFuncDic[SkillEffectType.SkillCostFeatureStepPoint] = self._ApplySkillCostFeatureStepPoint
  self._applyFuncDic[SkillEffectType.AddMonsterWeak] = self._ApplyAddMonsterWeak
  self._applyFuncDic[SkillEffectType.DetonateMonsterWeak] = self._ApplyDetonateMonsterWeak
  self._applyFuncDic[SkillEffectType.TransferMonsterWeak] = self._ApplyAddMonsterWeak
  self._applyFuncDic[SkillEffectType.ClingySummon] = self._ApplySummonEverything
  self._applyFuncDic[SkillEffectType.TeleportAndReplaceBodyArea] = self._ApplyTeleportAndChangeBodyArea
  self._applyFuncDic[SkillEffectType.ColorPaletteCharge] = self._ApplyColorPaletteCharge
  self._applyFuncDic[SkillEffectType.RobotBomb] = self._ApplyRobotBomb
  self._applyFuncDic[SkillEffectType.ScorpionSummon] = self._ApplyScorpionSummon
  self._applyFuncDic[SkillEffectType.ScorpionHitBack] = self._ApplyScorpionHitBack
  self._applyFuncDic[SkillEffectType.ChangeSanMax] = self._ApplyChangeSanMax
  self._applyFuncDic[SkillEffectType.SwapSan2TeamHp] = self._ApplySwapSan2TeamHp
  self._applyFuncDic[SkillEffectType.SummonWithCasterAttribute] = self._ApplySummonEverything
  self._applyFuncDic[SkillEffectType.SummonTrapByTargetPos] = self._ApplySummonTrap
  self._applyFuncDic[SkillEffectType.MoyeMove] = self._ApplyMoyeMove
  self._applyFuncDic[SkillEffectType.ControlMonsterTeleportAndAttack] = self._ApplyControlMonsterTeleportAndAttack
end

function SkillEffectLogicExecutor:IsEnemyEntitySoulCollectable(e, collectedMonster)
  local eid = e:GetID()
  if self._world:MatchType() ~= MatchType.MT_BlackFist then
    if e:HasMonsterID() and e:Attributes():GetCurrentHP() == 0 and not collectedMonster[eid] then
      return true
    end
  elseif e:HasTeam() and e:Attributes():GetCurrentHP() == 0 and not collectedMonster[eid] then
    return true
  end
end

function SkillEffectLogicExecutor:ApplySkillEffect(casterEntity, skillEffectParam, resultArray)
  local detailLogger = self._world:GetDetailMatchLogger()
  local skillEffectType = skillEffectParam:GetEffectType()
  local applyFunc = self._applyFuncDic[skillEffectType]
  if applyFunc ~= nil then
    detailLogger:BeginApplySkillEffect(casterEntity, skillEffectType, resultArray)
    applyFunc(self, casterEntity, skillEffectParam, resultArray)
    detailLogger:EndApplySkillEffect(casterEntity, skillEffectType, resultArray)
  end
end

function SkillEffectLogicExecutor:_ApplyDamage(casterEntity, skillEffectParam, resultArray)
  local collectedMonster = {}
  local collectedMonsterCount = 0
  local deadMonsterList = {}
  for _, v in ipairs(resultArray) do
    local skillResult = v
    local targetID = skillResult:GetTargetID()
    if 0 < targetID then
      local targetEntity = self._world:GetEntityByID(targetID)
      if self:IsEnemyEntitySoulCollectable(targetEntity, collectedMonster) then
        collectedMonster[targetID] = true
        collectedMonsterCount = collectedMonsterCount + 1
        table.insert(deadMonsterList, targetEntity)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAddBlood(casterEntity, skillEffectParam, resultArray)
  for _, v in ipairs(resultArray) do
    local addBloodRes = v
    self:EachApplyAddBlood(casterEntity, addBloodRes, skillEffectParam:GetSkillType())
  end
end

function SkillEffectLogicExecutor:_ApplyEachGridAddBlood(casterEntity, skillEffectParam, resultArray)
  for _, v in ipairs(resultArray) do
    local addBloodRes = v
    self:EachApplyAddBlood(casterEntity, addBloodRes, skillEffectParam:GetSkillType())
  end
end

function SkillEffectLogicExecutor:EachApplyAddBlood(attacker, addBloodResult, skillType)
  local targetID = addBloodResult:GetTargetID()
  local healValue = addBloodResult:GetAddValue()
  local damageInfo = DamageInfo:New(healValue, DamageType.Recover)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  calcDamageSvc:AddTargetHP(targetID, damageInfo)
  addBloodResult:SetDamageInfo(damageInfo)
  local target = self._world:GetEntityByID(targetID)
  if target:HasPetPstID() or target:HasTeam() then
    self._world:GetDataLogger():AddDataLog("OnSkillAddBlood", skillType, target, healValue)
  end
end

function SkillEffectLogicExecutor:_ApplyEachTrapAddBlood(casterEntity, skillEffectParam, resultArray)
  for _, v in ipairs(resultArray) do
    local addBloodRes = v
    self:EachApplyAddBlood(casterEntity, addBloodRes, skillEffectParam:GetSkillType())
  end
end

function SkillEffectLogicExecutor:_ApplySummonTrap(casterEntity, skillEffectParam, resultArray)
  for _, v in ipairs(resultArray) do
    if v._className == "SkillEffectResultMoveTrap" then
      local result = v
      local entityID = result:GetEntityID()
      local entity = self._world:GetEntityByID(entityID)
      local posOld = result:GetPosOld()
      local posNew = result:GetPosNew()
      entity:SetGridLocation(posNew)
      local sBoard = self._world:GetService("BoardLogic")
      sBoard:UpdateEntityBlockFlag(entity, posOld, posNew)
      local triggerSvc = self._world:GetService("Trigger")
      local NTMoveTrap = NTMoveTrap:New(entity, casterEntity, posNew, entity:BodyArea():GetArea())
      triggerSvc:Notify(NTMoveTrap)
    else
      local summonTrapRes = v
      local trapID = summonTrapRes:GetTrapID()
      local pos = summonTrapRes:GetPos()
      local dir = summonTrapRes:GetDir() or Vector2(0, 1)
      local trapEntity = self._trapServiceLogic:CreateTrap(trapID, pos, dir, true, nil, casterEntity, summonTrapRes:IsTransferDisabled(), summonTrapRes:GetTrapAIOrder())
      if trapEntity then
        summonTrapRes:SetTrapIDList({
          trapEntity:GetID()
        })
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyEscape(casterEntity, skillEffectParam, resultArray)
  if 0 < #resultArray then
    local cBattleStat = self._world:BattleStat()
    for _, v in ipairs(resultArray) do
      local result = v
      local eId = result:GetTargetID()
      local targetEntity = self._world:GetEntityByID(eId)
      local disappear = result:GetDisappear()
      local addNum = result:GetAddNum()
      if targetEntity then
        targetEntity:AddMonsterEscape(true)
        if disappear then
          local posOld = targetEntity:GetGridPosition()
          local posNew = Vector2(99, 99)
          local boardServiceLogic = self._world:GetService("BoardLogic")
          boardServiceLogic:UpdateEntityBlockFlag(targetEntity, posOld, posNew)
          targetEntity:SetGridPosition(posNew)
          result:SetPosNew(posNew)
        end
        if addNum then
          cBattleStat:AddMonsterEscapeNum(1)
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyRotate(casterEntity, skillEffectParam, resultArray)
  for _, v in ipairs(resultArray) do
    local result = v
    local eId = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(eId)
    local dirNew = result:GetDirNew()
    targetEntity:SetGridDirection(dirNew)
  end
end

function SkillEffectLogicExecutor:_ApplySummonEverything(casterEntity, skillEffectParam, resultArray)
  if skillEffectParam:GetInitCasterBornBuff() == 1 then
    local monsterIDCmpt = casterEntity:MonsterID()
    if monsterIDCmpt then
      local buffLogicService = self._world:GetService("BuffLogic")
      buffLogicService:RemoveAllBuffInstance(casterEntity)
      local monsterBornBuffContext = {isMonsterBornBuff = true}
      local buffLogic = self._world:GetService("BuffLogic")
      local monsterConfigData = self._configService:GetMonsterConfigData()
      local buffList = monsterConfigData:GetBornBuffList(monsterIDCmpt:GetMonsterID())
      if 0 < #buffList then
        if not casterEntity:HasBuff() then
          casterEntity:AddBuffComponent()
        end
        for _, buffId in ipairs(buffList) do
          buffLogic:AddBuff(buffId, casterEntity, monsterBornBuffContext)
        end
      end
    end
  end
  for _, v in ipairs(resultArray) do
    local summonRes = v
    local summonType = summonRes:GetSummonType()
    if summonType == SkillEffectEnum_SummonType.Monster then
      self:_SummonMonster(casterEntity, summonRes, skillEffectParam)
    elseif summonType == SkillEffectEnum_SummonType.Trap then
      self:_SummonTrap(casterEntity, summonRes, skillEffectParam)
    end
  end
end

function SkillEffectLogicExecutor:_GetADHByCaster(casterEntity, skillEffectParam)
end

function SkillEffectLogicExecutor:_SummonMonster(casterEntity, summonEffectResult, skillEffectParam)
  if nil == summonEffectResult then
    return
  end
  local posCenter = summonEffectResult:GetPosCenter()
  local summonPos = summonEffectResult:GetSummonPos()
  local summonMonsterID = summonEffectResult:GetSummonID()
  local direction = summonPos - posCenter
  local summonUseCasterDir = skillEffectParam:GetSummonUseCasterDir()
  if summonUseCasterDir == 1 then
    direction = casterEntity:GetGridDirection():Clone()
  end
  local dirParam = skillEffectParam:GetDirection()
  if dirParam then
    direction = dirParam
  end
  local useRandomDir = skillEffectParam:GetUseRandomDirection()
  if useRandomDir then
    local randomDir = self:_GetRandomFourDir()
    if randomDir then
      direction = randomDir
    end
  end
  local monsterTransformParam = MonsterTransformParam:New(summonMonsterID)
  monsterTransformParam:SetPosition(summonPos)
  monsterTransformParam:SetRotation(direction)
  Log.debug("[Phase_Summon] 召唤对象: Monster, ID = " .. summonMonsterID .. ", Pos = (" .. summonPos.x .. "," .. summonPos.y .. ")")
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local modifyMonsterBodyAreaByDir = skillEffectParam:GetModifyMonsterBodyAreaByDir()
  if modifyMonsterBodyAreaByDir then
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local oriBodyArea = monsterConfigData:GetMonsterArea(summonMonsterID)
    local newBodyArea = monsterCreationSvc:_RotateBodyArea(oriBodyArea, direction)
    monsterTransformParam:SetBodyArea(newBodyArea)
  end
  local eMonster = 0
  local eHP = 0
  local monsterId = 0
  local initAttributes = {}
  local l_InherAttribute = skillEffectParam:GetInheritAttribute()
  local isUseAttribute = skillEffectParam:GetUseAttribute()
  local isInheritCheckSuperEntity = skillEffectParam:GetInheritCheckSuperEntity()
  local nInherCount = l_InherAttribute == nil and -1 or table.count(l_InherAttribute)
  local inherAttrEntity = casterEntity
  if isInheritCheckSuperEntity and casterEntity:HasSuperEntity() then
    local superEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
    if superEntity then
      inherAttrEntity = superEntity
    end
  end
  local attributeCmpt = inherAttrEntity:Attributes()
  local bHasMonsterId = inherAttrEntity:HasMonsterID()
  local inherEntityMonsterIDCmpt
  if bHasMonsterId then
    inherEntityMonsterIDCmpt = inherAttrEntity:MonsterID()
  end
  local initRedHPUseCurHP = false
  if 0 < nInherCount and (bHasMonsterId or attributeCmpt ~= nil) then
    local nAttack = attributeCmpt:GetAttribute("Attack")
    local nDefense = attributeCmpt:GetAttribute("Defense")
    local nMaxHP = attributeCmpt:CalcMaxHp()
    local nCurHP = attributeCmpt:GetCurrentHP()
    local curHPPercent = nCurHP / nMaxHP
    if bHasMonsterId and isUseAttribute == SkillEffectEnum_SummonUseAttributeType.MonsterCfg then
      local nCasterMonsterId = inherEntityMonsterIDCmpt:GetMonsterID()
      nAttack, nDefense, nMaxHP = monsterCreationSvc:GetCreateADH(nCasterMonsterId)
      nCurHP = math.ceil(nMaxHP * curHPPercent)
    end
    if isUseAttribute == SkillEffectEnum_SummonUseAttributeType.CasterAttribute then
      nAttack = attributeCmpt:GetAttack()
      nDefense = attributeCmpt:GetDefence()
    elseif isUseAttribute == SkillEffectEnum_SummonUseAttributeType.WorldBossCurStageCfg and bHasMonsterId then
      local curWorldBossStage = inherEntityMonsterIDCmpt:GetCurStage()
      local newAttrData = inherEntityMonsterIDCmpt:GetWorldBossStageAttrData(curWorldBossStage)
      if newAttrData then
        nAttack = newAttrData.atk
        nDefense = newAttrData.def
        local stageHP = inherEntityMonsterIDCmpt:GetWorldBossStageHPData(curWorldBossStage)
        if stageHP then
          nMaxHP = stageHP
        end
        nCurHP = nMaxHP
      end
    end
    if l_InherAttribute.Attack and nAttack ~= nil then
      initAttributes.attack = nAttack * l_InherAttribute.Attack
    end
    if l_InherAttribute.Defense and nDefense ~= nil then
      initAttributes.defense = nDefense * l_InherAttribute.Defense
    end
    if l_InherAttribute.MaxHP and nMaxHP ~= nil then
      initAttributes.maxhp = nMaxHP * l_InherAttribute.MaxHP
    end
    if l_InherAttribute.CurHP and nCurHP ~= nil then
      initAttributes.curhp = nCurHP * l_InherAttribute.CurHP
      initRedHPUseCurHP = true
    end
  end
  local inheritElement = skillEffectParam:GetInheritElement()
  if inheritElement then
    local oriEntity = casterEntity
    if casterEntity:HasSuperEntity() then
      oriEntity = casterEntity:GetSuperEntity()
    end
    if oriEntity:HasAttributes() then
      local attrCmpt = oriEntity:Attributes()
      initAttributes.elementType = attrCmpt:GetAttribute("Element")
    end
  end
  if 0 < table.count(initAttributes) then
    eMonster, monsterId = monsterCreationSvc:CreateMonsterWithInitADH(monsterTransformParam, initAttributes)
  else
    eMonster, monsterId = monsterCreationSvc:CreateMonster(monsterTransformParam)
  end
  if skillEffectParam:IsRecordCasterCfgID() then
    local cBuff = eMonster:BuffComponent()
    if cBuff then
      local summonerCfgID = 0
      local cMonsterID = casterEntity:MonsterID()
      if cMonsterID then
        summonerCfgID = cMonsterID:GetMonsterID()
      end
      local cTrapID = casterEntity:TrapID()
      if cTrapID then
        summonerCfgID = cTrapID:GetTrapID()
      end
      if 0 < summonerCfgID then
        cBuff:SetBuffValue("RecordSummonerCfgID", summonerCfgID)
      end
    end
  end
  if initRedHPUseCurHP then
    local attrCmpt = eMonster:Attributes()
    attrCmpt:SetSimpleAttribute("InitRedHPUseCurHP", 1)
  end
  eMonster:AddSummoner(casterEntity:GetID())
  summonEffectResult:SetMonsterData(monsterId, eMonster:GetID(), eHP, monsterTransformParam)
  return eMonster
end

function SkillEffectLogicExecutor:_SummonTrap(casterEntity, summonEffectResult, skillEffectParam)
  if nil == summonEffectResult then
    return nil
  end
  local trapID = summonEffectResult:GetSummonID()
  local position = summonEffectResult:GetSummonPos()
  local l_InherAttribute = skillEffectParam:GetInheritAttribute()
  local nInherCount = l_InherAttribute == nil and -1 or table.count(l_InherAttribute)
  local attributeCmpt = casterEntity:Attributes()
  local inheritAttrParam = {}
  if 0 < nInherCount then
    local nAttack, nDefense, nMaxHP
    nAttack = attributeCmpt:GetAttribute("Attack")
    nDefense = attributeCmpt:GetAttribute("Defense")
    nMaxHP = attributeCmpt:CalcMaxHp()
    if l_InherAttribute.Attack and nAttack ~= nil then
      nAttack = nAttack * l_InherAttribute.Attack
      inheritAttrParam.Attack = nAttack
    end
    if l_InherAttribute.Defense and nDefense ~= nil then
      nDefense = nDefense * l_InherAttribute.Defense
      inheritAttrParam.Defense = nDefense
    end
    if l_InherAttribute.MaxHP and nMaxHP ~= nil then
      nMaxHP = nMaxHP * l_InherAttribute.MaxHP
      inheritAttrParam.HP = nMaxHP
      inheritAttrParam.MaxHP = nMaxHP
    end
  end
  local direction = skillEffectParam:GetDirection()
  local summonUseCasterDir = skillEffectParam:GetSummonUseCasterDir()
  if summonUseCasterDir == 1 then
    direction = casterEntity:GetGridDirection():Clone()
  end
  local useRandomDir = skillEffectParam:GetUseRandomDirection()
  if useRandomDir then
    local randomDir = self:_GetRandomFourDir()
    if randomDir then
      direction = randomDir
    end
  end
  local trapEntity = self._trapServiceLogic:CreateTrap(trapID, position, direction, true, inheritAttrParam, casterEntity)
  if trapEntity then
    if skillEffectParam:IsRecordCasterCfgID() then
      local cBuff = trapEntity:BuffComponent()
      if cBuff then
        local summonerCfgID = 0
        local cMonsterID = casterEntity:MonsterID()
        if cMonsterID then
          summonerCfgID = cMonsterID:GetMonsterID()
        end
        local cTrapID = casterEntity:TrapID()
        if cTrapID then
          summonerCfgID = cTrapID:GetTrapID()
        end
        if 0 < summonerCfgID then
          cBuff:SetBuffValue("RecordSummonerCfgID", summonerCfgID)
        end
      end
    end
    trapEntity:SetViewVisible(false)
    Log.debug("[Phase_Summon] 召唤对象: Trap, ID = " .. trapID .. ", Pos = (" .. position.x .. "," .. position.y .. ")")
    summonEffectResult:SetTrapData(trapID, trapEntity:GetID())
  end
  return trapEntity
end

function SkillEffectLogicExecutor:_GetRandomFourDir()
  local randomSvc = self._world:GetService("RandomLogic")
  local dirTypeList = {
    DirectionType.Up,
    DirectionType.Right,
    DirectionType.Down,
    DirectionType.Left
  }
  local index = randomSvc:LogicRand(1, #dirTypeList)
  local utilScopeCalcSvc = self._world:GetService("UtilScopeCalc")
  local randomDir = utilScopeCalcSvc:GetDirByDirType(dirTypeList[index])
  return randomDir
end

function SkillEffectLogicExecutor:_SendNTGridConvert(pos, pieceType, effectType, skillType)
  local boardEntity = self._world:GetBoardEntity()
  local tConvertInfo = {}
  local convertInfo = NTGridConvert_ConvertInfo:New(Vector2(pos.x, pos.y), PieceType.None, pieceType)
  table.insert(tConvertInfo, convertInfo)
  local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  ntGridConvert:SetConvertEffectType(effectType)
  ntGridConvert:SetSkillType(skillType)
  self._world:GetService("Trigger"):Notify(ntGridConvert)
end

function SkillEffectLogicExecutor:_ApplyTeleport(casterEntity, skillEffectParam, resultArray)
  local sBoard = self._world:GetService("BoardLogic")
  local sTrapLogic = self._world:GetService("TrapLogic")
  local skillLogic = self._world:GetService("SkillLogic")
  for _, teleportRes in ipairs(resultArray) do
    local targetID = teleportRes:GetTargetID()
    local posOld = teleportRes:GetPosOld()
    local posNew = teleportRes:GetPosNew()
    local targetDir = teleportRes:GetDirNew()
    local targetEntity = self._world:GetEntityByID(targetID)
    local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(targetEntity, posOld)
    local delTrapEntityIDs = teleportRes:GetNeedDelTrapEntityIDs()
    if 0 < #delTrapEntityIDs then
      for _, entityID in ipairs(delTrapEntityIDs) do
        local trapEntity = self._world:GetEntityByID(entityID)
        local cAttr = trapEntity:Attributes()
        if cAttr:GetCurrentHP() then
          cAttr:Modify("HP", 0)
          Log.debug("_ApplyTeleport delete trap ModifyHP = 0, trapID =", trapEntity:GetID())
        end
        sTrapLogic:AddTrapDeadMark(trapEntity, true)
      end
    end
    if targetEntity:HasTeam() or targetEntity:HasPetPstID() then
      local teamEntity = targetEntity
      if targetEntity:HasPet() then
        teamEntity = targetEntity:Pet():GetOwnerTeamEntity()
      end
      local pets = teamEntity:Team():GetTeamPetEntities()
      for _, entity in ipairs(pets) do
        entity:SetGridLocation(posNew, targetDir)
        entity:GridLocation():SetMoveLastPosition(posNew)
      end
      teamEntity:SetGridLocation(posNew, targetDir)
      teamEntity:GridLocation():SetMoveLastPosition(posNew)
      local boardEntity = self._world:GetBoardEntity()
      sBoard:SetPieceTypeLogic(teleportRes:GetColorOld(), posOld)
      self:_SendNTGridConvert(posOld, teleportRes:GetColorOld(), SkillEffectType.Teleport, skillEffectParam:GetSkillType())
      local es = boardEntity:Board():GetPieceEntities(posNew, function(e)
        return e:Trap() and e:Trap():IsDimensionDoor()
      end)
      local onDemensionDoor = 0 < #es
      local colorNew = sBoard:GetPieceType(posNew)
      if onDemensionDoor then
      elseif sBoard:GetCanConvertGridElementForTeamPos(posNew) then
        colorNew = PieceType.None
      end
      teleportRes:SetColorNew(colorNew)
      sBoard:SetPieceTypeLogic(colorNew, posNew)
      sBoard:UpdateEntityBlockFlag(teamEntity, posOld, posNew)
      sBoard:SetEntityBlockFlag(teamEntity, posNew, blockFlag)
      if self._world:MatchType() == MatchType.MT_BlackFist and casterEntity:HasPet() then
        local casterTeamEntity = casterEntity:Pet():GetOwnerTeamEntity()
        if casterTeamEntity and casterTeamEntity:GetID() ~= teamEntity:GetID() then
          local listTrapTrigger = sTrapLogic:TriggerTrapByTeleport(targetEntity, teleportRes:IsEnableTriggerEddy())
          local trapIDList = {}
          for _, v in ipairs(listTrapTrigger) do
            local trapEntityID = v:GetID()
            trapIDList[#trapIDList + 1] = trapEntityID
          end
          teleportRes:SetTriggerTrapList(trapIDList)
        end
      end
    else
      targetEntity:SetGridLocation(posNew, targetDir)
      if targetEntity:HasMonsterID() then
        local listTrapTrigger = sTrapLogic:TriggerTrapByTeleport(targetEntity, teleportRes:IsEnableTriggerEddy())
        local trapIDList = {}
        for _, v in ipairs(listTrapTrigger) do
          local trapEntityID = v:GetID()
          trapIDList[#trapIDList + 1] = trapEntityID
        end
        teleportRes:SetTriggerTrapList(trapIDList)
      end
      if not teleportRes:IsOnlyDeleteBlock() then
        sBoard:SetEntityBlockFlag(targetEntity, posNew, blockFlag)
      end
    end
    if targetEntity:HasMonsterID() and posNew.x ~= posOld.x then
      local battleFlags = self._world:BattleFlags()
      local dirObliqueOffset = Vector2(posNew.x - posOld.x, 0)
      battleFlags:SetFrontAndObliqueOffsetData(targetEntity:GetID(), dirObliqueOffset)
    end
    local delTrapEntityID = teleportRes:GetNeedDelTrapEntityID()
    if delTrapEntityID ~= 0 then
      local trapEntity = self._world:GetEntityByID(delTrapEntityID)
      local cAttr = trapEntity:Attributes()
      if cAttr:GetCurrentHP() then
        cAttr:Modify("HP", 0)
        Log.debug("_ApplyTeleport delete trap ModifyHP = 0, trapID =", trapEntity:GetID())
      end
      sTrapLogic:AddTrapDeadMark(trapEntity, true)
    end
    self._world:GetService("Trigger"):Notify(NTTeleport:New(targetEntity, posOld, posNew))
    if posOld ~= posNew and posNew then
      local utilData = self._world:GetService("UtilData")
      local cTeleportRecord = casterEntity:TeleportRecord() or casterEntity:AddTeleportRecord()
      cTeleportRecord:AddSingleTeleportRecord(utilData:GetStatCurWaveRoundNum(), posOld, posNew, casterEntity:GetID())
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAbsorbPhantom(casterEntity, param, resultArray)
  local skillLogic = self._world:GetService("SkillLogic")
  for _, result in ipairs(resultArray) do
    skillLogic:ApplyAbsorbPhantom(result)
  end
end

function SkillEffectLogicExecutor:_ApplyAddCollectDropNum(casterEntity, param, resultArray)
  if resultArray then
    local cBattleStat = self._world:BattleStat()
    for index, value in ipairs(resultArray) do
      if value then
        cBattleStat:CollectDrop()
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyDimensionTransport(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  local boardService = self._world:GetService("BoardLogic")
  for index, value in ipairs(resultArray) do
    if value then
      local targetID = value:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetID)
      if targetEntity then
        local posOld = value:GetPosOld()
        local posNew = value:GetPosNew()
        local targetDir = value:GetDirNew()
        local es = targetEntity:Team():GetTeamPetEntities()
        for _, e in ipairs(es) do
          e:SetGridLocation(posNew, targetDir)
          e:GridLocation():SetMoveLastPosition(posNew)
        end
        boardService:UpdateEntityBlockFlag(targetEntity, posOld, posNew)
        targetEntity:SetGridLocation(posNew, targetDir)
        targetEntity:GridLocation():SetMoveLastPosition(posNew)
        local boardEntity = self._world:GetBoardEntity()
        boardService:SetPieceTypeLogic(PieceType.Any, posOld)
        boardService:SetPieceTypeLogic(PieceType.None, posNew)
        value:SetColorNew(PieceType.None)
        self._world:GetService("Trigger"):Notify(NTDimensionTransport:New(targetEntity, posOld, posNew))
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAddDimensionFlag(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  for index, value in ipairs(resultArray) do
    if value then
      local eTeam = self._world:GetEntityByID(value:GetTeamEntityId())
      if eTeam then
        eTeam:AddDimensionFlag()
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAddBloodOverFlow(casterEntity, param, resultArray)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local resAddBlood = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
  if resAddBlood then
    self:_ApplyAddBlood(casterEntity, param, resAddBlood)
  end
  local resSummonTrap = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
  if resSummonTrap then
    self:_ApplySummonTrap(casterEntity, param, resSummonTrap)
  end
end

function SkillEffectLogicExecutor:_ApplyAddBloodOverFlowForDamage(casterEntity, param, resultArray)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local resAddBlood = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
  if resAddBlood then
    self:_ApplyAddBlood(casterEntity, param, resAddBlood)
  end
  local resSummonTrap = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if resSummonTrap then
    self:_ApplyDamage(casterEntity, param, resSummonTrap)
  end
end

function SkillEffectLogicExecutor:_ApplyCreat2eDestroyGrid(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  local board = self._world:GetBoardEntity():Board()
  for index, result in ipairs(resultArray) do
    local isCreate = result:GetIsCreate()
    local range = result:GetScopeRange()
    for _, pos in ipairs(range) do
      local x = pos.x
      local y = pos.y
      if isCreate then
        if board:GetPieceType(pos) == PieceType.None then
          board.Pieces[x][y] = PieceType.None
        end
      else
        board:RemovePiece(x, y)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyMultiTraction(casterEntity, param, resultArray)
  if resultArray then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local utilData = self._world:GetService("UtilData")
    local triggerSvc = self._world:GetService("Trigger")
    for index, value in ipairs(resultArray) do
      local array = value:GetResultArray()
      for _, v in ipairs(array) do
        local targetEntity = self._world:GetEntityByID(v.entityID)
        local posOld = v.beginPos
        local posNew = v.finalPos
        if targetEntity:HasTeam() then
          local entityList = targetEntity:Team():GetTeamPetEntities()
          for k, entity in ipairs(entityList) do
            entity:SetGridPosition(posNew)
            entity:GridLocation():SetMoveLastPosition(posNew)
          end
          local bodyArea, blockFlag = boardServiceLogic:RemoveEntityBlockFlag(targetEntity, posOld)
          if posOld ~= posNew and boardServiceLogic:GetCanConvertGridElement(posOld) then
            local tSupplyOld = boardServiceLogic:SupplyPieceList({posOld})
            local supplyOld = tSupplyOld[1]
            if supplyOld and supplyOld.color ~= PieceType.None then
              boardServiceLogic:SetPieceTypeLogic(supplyOld.color, posOld)
              value:SetSupplyPlayerPiece(supplyOld)
              self:_SendNTGridConvert(posOld, supplyOld.color, SkillEffectType.MultiTraction, param:GetSkillType())
            end
          end
          targetEntity:SetGridLocation(posNew)
          targetEntity:GridLocation():SetMoveLastPosition(posNew)
          if posOld ~= posNew then
            local triggerTraps = self:_ApplyTriggerTrap(targetEntity, TrapTriggerOrigin.Hitback)
            v:SetTriggerTraps(triggerTraps)
          end
          local colorNew = utilData:FindPieceElement(posNew)
          if boardServiceLogic:GetCanConvertGridElementForTeamPos(posNew) then
            colorNew = PieceType.None
          end
          boardServiceLogic:SetPieceTypeLogic(colorNew, posNew)
          value:SetColorNew(colorNew)
          boardServiceLogic:SetPosBlock(targetEntity, posNew, blockFlag)
        else
          boardServiceLogic:UpdateEntityBlockFlag(targetEntity, posOld, posNew)
          targetEntity:SetGridPosition(posNew)
          if posOld ~= posNew then
            local triggerTraps = self:_ApplyTriggerTrap(targetEntity, TrapTriggerOrigin.Hitback)
            v:SetTriggerTraps(triggerTraps)
          end
        end
        local entity = self._world:GetEntityByID(v.entityID)
        local nt = NTTractionEnd:New(casterEntity, entity, posOld, posNew, v.Path or {})
        triggerSvc:Notify(nt)
      end
      local damageIncreaseRate = value:GetDamageIncreaseRate()
      if damageIncreaseRate then
        local cSkillContext = casterEntity:SkillContext()
        for _, data in ipairs(value:GetGridPossessorMap().array) do
          if data.beginPos ~= data.finalPos then
            local beginX = data.beginPos.x
            local beginY = data.beginPos.y
            local finalX = data.finalPos.x
            local finalY = data.finalPos.y
            local dis = math.abs(beginX - finalX) + math.abs(beginY - finalY)
            cSkillContext:AddFinalDamageFix(data.entityID, dis * damageIncreaseRate)
          end
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyConvertGridElement(casterEntity, param, resultArray, effectType)
  if resultArray then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local utilData = self._world:GetService("UtilData")
    local convertInfoArray = {}
    local notifyBuff = true
    for index, value in ipairs(resultArray) do
      local newGridList = value:GetTargetGridArray()
      local targetElementType = value:GetTargetElementType()
      notifyBuff = value:GetNotifyBuff()
      for _, grid in ipairs(newGridList) do
        if boardServiceLogic:GetCanConvertGridElement(grid) then
          local before = utilData:FindPieceElement(grid)
          boardServiceLogic:SetPieceTypeLogic(targetElementType, grid)
          local convertInfo = NTGridConvert_ConvertInfo:New(grid, before, targetElementType)
          table.insert(convertInfoArray, convertInfo)
        end
      end
    end
    if 0 < #convertInfoArray and notifyBuff then
      local triggerSvc = self._world:GetService("Trigger")
      local ntConvertGrid = NTGridConvert:New(casterEntity, convertInfoArray)
      ntConvertGrid:SetConvertEffectType(effectType or SkillEffectType.ConvertGridElement)
      ntConvertGrid:SetSkillType(param:GetSkillType())
      triggerSvc:Notify(ntConvertGrid)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyConvertOccupiedGridElement(casterEntity, param, resultArray)
  if resultArray then
    self:_ApplyConvertGridElement(casterEntity, param, resultArray, SkillEffectType.ConvertOccupiedGridElement)
    for _, result in ipairs(resultArray) do
      local trapResults = result:GetTrapResults()
      if 0 < #trapResults then
        self:_ApplySummonTrap(casterEntity, nil, trapResults)
      end
    end
  end
end

function SkillEffectLogicExecutor:ApplyFlushTrap(trapEntity)
  trapEntity:Attributes():Modify("HP", 0)
  self._trapServiceLogic:AddTrapDeadMark(trapEntity, true)
end

function SkillEffectLogicExecutor:_ApplyResetGridElement(casterEntity, param, resultArray)
  if resultArray then
    local triggerService = self._world:GetService("Trigger")
    local boardService = self._world:GetService("BoardLogic")
    local pieceService = self._world:GetService("Piece")
    local board = self._world:GetBoardEntity():Board()
    local utilData = self._world:GetService("UtilData")
    local tConvertInfo = {}
    for index, value in ipairs(resultArray) do
      if value then
        local convertArray = value:GetResetGridData()
        triggerService:Notify(NTResetGridElement:New(convertArray, casterEntity))
        triggerService:Notify(NTResetGridFlushTrap:New(value:GetAllFlushTraps()))
        for _, convertData in ipairs(convertArray) do
          local nNewColor = convertData.m_nNewElementType
          local pos = Vector2(convertData.m_nX, convertData.m_nY)
          local nOldColor = utilData:FindPieceElement(pos)
          local convertInfo = NTGridConvert_ConvertInfo:New(pos, nOldColor, nNewColor)
          table.insert(tConvertInfo, convertInfo)
          boardService:SetPieceTypeLogic(nNewColor, pos)
        end
        local summonTrapList = value:GetSummonTrapList()
        if summonTrapList then
          local sortedDic = SortedDictionary:New(Algorithm.COMPARE_CUSTOM, Algorithm.LessVectorXYComparer)
          for pos, trapID in pairs(summonTrapList) do
            sortedDic:Insert(pos, trapID)
          end
          local count = sortedDic:Size()
          for i = 1, count do
            local trapPos, trapId = sortedDic:GetPairAt(i)
            local direction = Vector2(0, 1)
            local trapEntity = self._trapServiceLogic:CreateTrap(trapId, trapPos, direction, true, nil, casterEntity)
            if trapEntity then
              trapEntity:SetViewVisible(false)
              value:AddSummonTrapEntityID(trapPos, trapEntity:GetID())
            end
          end
        end
      end
    end
    local nt = NTGridConvert:New(casterEntity, tConvertInfo)
    nt:SetConvertEffectType(SkillEffectType.ResetGridElement)
    nt:SetSkillType(param:GetSkillType())
    triggerService:Notify(nt)
  end
end

function SkillEffectLogicExecutor:_ApplyAbsorbPiece(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      local newGridList = result:GetNewPieceList()
      for _, grid in ipairs(newGridList) do
        boardService:SetPieceTypeLogic(grid.color, Vector2(grid.x, grid.y))
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyPullAround(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      local beHitbackEntityID = result:GetTargetID()
      local targetEntity = self._world:GetEntityByID(beHitbackEntityID)
      local targetPos = result:GetGridPos()
      if targetEntity:HasTeam() then
        local pets = targetEntity:Team():GetTeamPetEntities()
        for _, e in ipairs(pets) do
          e:SetGridLocation(targetPos)
          e:GridLocation():SetMoveLastPosition(targetPos)
        end
      end
      boardService:UpdateEntityBlockFlag(targetEntity, targetEntity:GetGridPosition(), targetPos)
      targetEntity:SetGridLocation(targetPos)
    end
  end
end

function SkillEffectLogicExecutor:_ApplySacrificeTrapsAndDamage(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResultArray())
      local trapEntityIDArray = result:GetTrapIDArray()
      local trapEntityArray = {}
      for _, trapEntityID in ipairs(trapEntityIDArray) do
        table.insert(trapEntityArray, self._world:GetEntityByID(trapEntityID))
      end
      local trapServiceLogic = self._world:GetService("TrapLogic")
      for _, trapEntity in ipairs(trapEntityArray) do
        local cAttr = trapEntity:Attributes()
        if cAttr:GetCurrentHP() then
          cAttr:Modify("HP", 0)
          Log.debug("_ApplySacrificeTrapsAndDamage ModifyHP =0 defender=", trapEntity:GetID())
        end
        trapServiceLogic:AddTrapDeadMark(trapEntity, true)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyMakePhantom(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
      local entity = monsterCreationSvc:MakePhantomLogic(result)
      result:SetTargetEntityID(entity:GetID())
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTransformation(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
      sMonsterShowLogic:Transformation(result, param)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyDestroyTrap(casterEntity, param, resultArray)
  if resultArray then
    local trapServiceLogic = self._world:GetService("TrapLogic")
    for _, result in ipairs(resultArray) do
      local entity = self._world:GetEntityByID(result:GetEntityID())
      if entity then
        entity:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(entity, param:GetDisableDieSkill())
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTriggerTrap(targetEntity, origin)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local traps = trapServiceLogic:TriggerTrapByEntity(targetEntity, origin)
  return traps
end

function SkillEffectLogicExecutor:_ApplyAngleFreeLineDamage(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResults())
    end
  end
end

function SkillEffectLogicExecutor:_ApplySplashDamage(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResults())
    end
  end
end

function SkillEffectLogicExecutor:_ApplyRotateByPickSector(casterEntity, param, resultArray)
  for _, v in ipairs(resultArray) do
    local result = v
    local dirNew = result:GetDirNew()
    casterEntity:SetGridDirection(dirNew)
  end
end

function SkillEffectLogicExecutor:_ApplyIslandConvert(casterEntity, param, resultArray)
  if false == type(resultArray) or 0 == #resultArray then
    return
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local boardService = self._world:GetService("BoardLogic")
  local utilData = self._world:GetService("UtilData")
  local convertInfoArray = {}
  for _, result in ipairs(resultArray) do
    local tAtomicData = result:GetAtomicDataArray()
    for _, atomicData in ipairs(tAtomicData) do
      local trapArray = atomicData:GetDestroyedTrapArray()
      for _, eID in ipairs(trapArray) do
        local eTrap = self._world:GetEntityByID(eID)
        if eTrap then
          local trapCmpt = eTrap:Trap()
          eTrap:Attributes():Modify("HP", 0)
          trapServiceLogic:AddTrapDeadMark(eTrap)
        end
      end
      local targetPieceType = atomicData:GetTargetPieceType()
      local gridPos = atomicData:GetPosition()
      local before = utilData:FindPieceElement(gridPos)
      boardService:SetPieceTypeLogic(targetPieceType, gridPos)
      local convertInfo = NTGridConvert_ConvertInfo:New(gridPos, before, targetPieceType)
      table.insert(convertInfoArray, convertInfo)
    end
  end
  local triggerSvc = self._world:GetService("Trigger")
  if 0 < #convertInfoArray then
    local nt = NTGridConvert:New(casterEntity, convertInfoArray)
    nt:SetConvertEffectType(SkillEffectType.IslandConvert)
    nt:SetSkillType(param:GetSkillType())
    triggerSvc:Notify(nt)
  end
end

function SkillEffectLogicExecutor:_ApplyResetSingleColorGridElement(casterEntity, param, resultArray)
  local boardService = self._world:GetService("BoardLogic")
  local board = self._world:GetBoardEntity():Board()
  for _, result in ipairs(resultArray) do
    local newGridDatList = result:GetNewGridDataList()
    for k, data in ipairs(newGridDatList) do
      boardService:SetPieceTypeLogic(data.m_nNewElementType, Vector2(data.m_nX, data.m_nY))
    end
    local trapIDList = result:GetFlushTrapIDList()
    for _, entityID in ipairs(trapIDList) do
      local trapEntity = self._world:GetEntityByID(entityID)
      self:ApplyFlushTrap(trapEntity)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyCostCasterHP(casterEntity, param, resultArray)
  local calcDamageService = self._world:GetService("CalcDamage")
  for _, result in ipairs(resultArray) do
    local percent = result:GetPercent()
    local costType = result:GetCostType()
    local ignoreShield = result:GetIgnoreShield()
    local leastHP = result:GetLeastHP()
    local byMaxHP = false
    if costType == SkillEffectCostCasterHPType.MaxHPPercent then
      byMaxHP = true
    end
    local damageInfo = calcDamageService:SubTargetHPPercent(casterEntity, casterEntity, percent, byMaxHP, ignoreShield, leastHP)
    result:SetDamageInfo(damageInfo)
    if damageInfo then
      casterEntity:SkillContext():SetSacrificedHP(math.abs(damageInfo:GetChangeHP()))
    end
  end
end

function SkillEffectLogicExecutor:_ApplyExChangeGridColor(casterEntity, param, resultArray)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  for _, result in ipairs(resultArray) do
    local newGridList = result:GetNewGridList()
    for gridPos, gridType in pairs(newGridList) do
      boardServiceLogic:SetPieceTypeLogic(gridType, gridPos)
    end
    local triggerSvc = self._world:GetService("Trigger")
    triggerSvc:Notify(NTExChangeGridColor:New(newGridList))
    local trapList = result:GetSummonTrapList()
    local trapIDList = {}
    for gridPos, trapID in pairs(trapList) do
      local trapEntity = self._trapServiceLogic:CreateTrap(trapID, gridPos, Vector2(0, 1), true, nil, casterEntity)
      if trapEntity then
        trapIDList[gridPos] = trapEntity:GetID()
      end
    end
    result:SetTrapIDList(trapIDList)
  end
end

function SkillEffectLogicExecutor:_ApplyChangeElement(casterEntity, param, resultArray)
  if resultArray then
    for index, result in ipairs(resultArray) do
      local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
      local elementType = sMonsterShowLogic:ChangeElement(result)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyIsolateConvert(casterEntity, param, resultArray)
  if false == type(resultArray) or 0 == #resultArray then
    return
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local boardService = self._world:GetService("BoardLogic")
  local utilData = self._world:GetService("UtilData")
  local convertInfoArray = {}
  for _, result in ipairs(resultArray) do
    local tAtomicData = result:GetAtomicDataArray()
    for _, atomicData in ipairs(tAtomicData) do
      local trapArray = atomicData:GetDestroyedTrapArray()
      for _, eID in ipairs(trapArray) do
        local eTrap = self._world:GetEntityByID(eID)
        if eTrap then
          local trapCmpt = eTrap:Trap()
          eTrap:Attributes():Modify("HP", 0)
          trapServiceLogic:AddTrapDeadMark(eTrap)
        end
      end
      local targetPieceType = atomicData:GetTargetPieceType()
      local gridPos = atomicData:GetPosition()
      local before = utilData:FindPieceElement(gridPos)
      boardService:SetPieceTypeLogic(targetPieceType, gridPos)
      local convertInfo = NTGridConvert_ConvertInfo:New(gridPos, before, targetPieceType)
      table.insert(convertInfoArray, convertInfo)
    end
  end
  local triggerSvc = self._world:GetService("Trigger")
  if 0 < #convertInfoArray then
    local nt = NTGridConvert:New(casterEntity, convertInfoArray)
    nt:SetConvertEffectType(SkillEffectType.IsolateConvert)
    nt:SetSkillType(param:GetSkillType())
    triggerSvc:Notify(nt)
  end
end

function SkillEffectLogicExecutor:_ApplyRotateToPickup(casterEntity, param, resultArray)
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  for _, result in ipairs(resultArray) do
    local dir = result:GetNewDir()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for _, entity in ipairs(pets) do
      entity:SetGridDirection(dir)
    end
    teamEntity:SetGridDirection(dir)
  end
end

function SkillEffectLogicExecutor:_ApplyTeleportAndSummonTrap(casterEntity, param, resultArray)
  local trapID = param:GetTrapID()
  for _, result in ipairs(resultArray) do
    local trapPosList = result:GetTrapPosList()
    local direction = Vector2(0, 0)
    for i, pos in ipairs(trapPosList) do
      local trapEntity = self._trapServiceLogic:CreateTrap(trapID, pos, direction, true, nil, casterEntity)
      result:AddTrapEntityID(trapEntity:GetID())
    end
  end
end

function SkillEffectLogicExecutor:_ApplyChangeBuffLayer(casterEntity, param, resultArray)
  local buffLogicService = self._world:GetService("BuffLogic")
  for _, result in ipairs(resultArray) do
    local entityID = result:GetEntityID()
    local entity = self._world:GetEntityByID(entityID)
    local buffEffectType = result:GetTargetBuffEffectType()
    local layerCount = result:GetLayer()
    buffLogicService:SetBuffLayer(entity, buffEffectType, layerCount)
    if result:GetIsUnload() and layerCount == 0 then
      local targetBuff = entity:BuffComponent():GetSingleBuffByBuffEffect(buffEffectType)
      if targetBuff then
        targetBuff:Unload(NTBuffUnload:New())
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplySummonMeantimeLimit(casterEntity, param, resultArray)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local battleFlags = self._world:BattleFlags()
  for _, result in ipairs(resultArray) do
    local trapID = result:GetTrapID()
    local replaceAttr = result:GetReplaceAttr()
    local destroyEntityID = result:GetDestroyEntityID()
    for _, entityID in ipairs(destroyEntityID) do
      local entity = self._world:GetEntityByID(entityID)
      if entity then
        local trapCmpt = entity:Trap()
        entity:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(entity)
      end
    end
    local entityIDList = battleFlags:GetSummonMeantimeLimitEntityID(trapID)
    local summonPosList = result:GetSummonPosList()
    local summonTrapEntityIDList = {}
    for _, pos in ipairs(summonPosList) do
      local trapEntity = self._trapServiceLogic:CreateTrap(trapID, pos, Vector2(0, 1), true, nil, casterEntity)
      if trapEntity then
        local attr = trapEntity:Attributes()
        for key, value in pairs(replaceAttr) do
          attr:Modify(key, value)
        end
        table.insert(summonTrapEntityIDList, trapEntity:GetID())
        table.insert(entityIDList, trapEntity:GetID())
      end
    end
    battleFlags:SetSummonMeantimeLimitEntityID(trapID, entityIDList)
    result:SetTrapIDList(summonTrapEntityIDList)
  end
end

function SkillEffectLogicExecutor:_ApplyDestroyMonster(casterEntity, param, resultArray)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  for i, result in ipairs(resultArray) do
    local e = self._world:GetEntityByID(result:GetEntityID())
    if e then
      e:Attributes():Modify("HP", 0)
      sMonsterShowLogic:AddMonsterDeadMark(e)
    end
  end
  sMonsterShowLogic:DoAllMonsterDeadLogic()
end

function SkillEffectLogicExecutor:_ApplySealedCurse(casterEntity, param, resultArray)
  local bsvc = self._world:GetService("Battle")
  for _, result in ipairs(resultArray) do
    local newTeamLeaderPstID = result:GetNewLeaderPstID()
    bsvc:ChangeLocalTeamLeader(newTeamLeaderPstID)
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local teamOrderBefore = result:GetOldTeamOrder()
    local teamOrderAfter = result:GetNewTeamOrder()
    local cTeam = teamEntity:Team()
    cTeam:SetTeamOrder(teamOrderAfter)
    self._world:GetService("Trigger"):Notify(NTTeamOrderChange:New(teamEntity, teamOrderBefore, teamOrderAfter))
  end
end

function SkillEffectLogicExecutor:_ApplySummonOnFixPosLimit(casterEntity, param, resultArray)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local battleFlags = self._world:BattleFlags()
  for _, result in ipairs(resultArray) do
    local trapID = result:GetTrapID()
    local destroyEntityIDList = result:GetDestroyEntityIDList()
    for _, entityID in ipairs(destroyEntityIDList) do
      local entity = self._world:GetEntityByID(entityID)
      if entity then
        local trapCmpt = entity:Trap()
        entity:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(entity)
      end
    end
    local entityIDList = battleFlags:GetSummonOnFixPosLimitEntityID(trapID)
    local summonPosList = result:GetSummonPosList()
    local summonTrapEntityIDList = {}
    for _, pos in ipairs(summonPosList) do
      local trapEntity = self._trapServiceLogic:CreateTrap(trapID, pos, Vector2(0, 1), true, nil, casterEntity)
      if trapEntity then
        table.insert(summonTrapEntityIDList, trapEntity:GetID())
        table.insert(entityIDList, trapEntity:GetID())
      end
    end
    battleFlags:SetSummonOnFixPosLimitEntityID(trapID, entityIDList)
    result:SetTrapIDList(summonTrapEntityIDList)
  end
end

function SkillEffectLogicExecutor:_ApplySwitchBodyPart(casterEntity, param, resultArray)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  for _, result in ipairs(resultArray) do
  end
end

function SkillEffectLogicExecutor:_ApplyChangePetTeamOrder(casterEntity, param, resultArray)
  for _, result in ipairs(resultArray) do
    local eTarget = self._world:GetEntityByID(result:GetTargetEntityID())
    local eTeam = eTarget:Pet():GetOwnerTeamEntity()
    local cTeam = eTeam:Team()
    local teamOrderBeforeTmp = cTeam:GetTeamOrder()
    local teamOrderBefore = table.cloneconf(teamOrderBeforeTmp)
    local teamOrderAfterTmp = result:GetNewTeamOrder()
    local teamOrderAfter = table.cloneconf(teamOrderAfterTmp)
    local nCasterPstID = eTarget:PetPstID():GetPstID()
    if teamOrderBefore[1] ~= teamOrderAfter[1] then
      local bsvc = self._world:GetService("Battle")
      bsvc:ChangeLocalTeamLeader(teamOrderAfter[1])
    end
    cTeam:SetTeamOrder(table.cloneconf(teamOrderAfter))
    self._world:GetService("Trigger"):Notify(NTTeamOrderChange:New(eTeam, teamOrderBefore, teamOrderAfterTmp))
  end
end

function SkillEffectLogicExecutor:_ApplySwapPetTeamOrder(casterEntity, param, resultArray)
  for _, result in ipairs(resultArray) do
    local eTarget = self._world:GetEntityByID(result:GetTargetEntityID())
    local eTeam = eTarget:Pet():GetOwnerTeamEntity()
    local cTeam = eTeam:Team()
    local teamOrderBeforeTmp = cTeam:GetTeamOrder()
    local teamOrderBefore = table.cloneconf(teamOrderBeforeTmp)
    local teamOrderAfter = result:GetNewTeamOrder()
    if teamOrderBefore[1] ~= teamOrderAfter[1] then
      local bsvc = self._world:GetService("Battle")
      bsvc:ChangeLocalTeamLeader(teamOrderAfter[1])
      self._world:GetService("Trigger"):Notify(NTTeamOrderChange:New(eTeam, teamOrderBefore, teamOrderAfter))
    else
      cTeam:SetTeamOrder(teamOrderAfter)
      self._world:GetService("Trigger"):Notify(NTTeamOrderChange:New(eTeam, teamOrderBefore, teamOrderAfter))
    end
  end
end

function SkillEffectLogicExecutor:_ApplyGatherThrowDamage(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      self:_ApplyTeleport(casterEntity, param, result:GetTeleportResultArray())
      self:_ApplyDamage(casterEntity, param, result:GetDamageResultArray())
      local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
      local monsterEntityIDArray = result:GetMonsterIDArray()
      for i, monsterEntiryId in ipairs(monsterEntityIDArray) do
        local e = self._world:GetEntityByID(monsterEntiryId)
        e:Attributes():Modify("HP", 0)
        sMonsterShowLogic:AddMonsterDeadMark(e)
      end
      local teleKillEntityIDArray = result:GetTeleportKillMonster()
      for i, monsterEntiryId in ipairs(teleKillEntityIDArray) do
        local e = self._world:GetEntityByID(monsterEntiryId)
        e:Attributes():Modify("HP", 0)
        sMonsterShowLogic:AddMonsterDeadMark(e)
      end
      sMonsterShowLogic:DoAllMonsterDeadLogic()
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTriggerTrapResult(casterEntity, param, resultArray)
  if resultArray then
    local trapServiceLogic = self._world:GetService("TrapLogic")
    local triggerService = self._world:GetService("Trigger")
    if casterEntity and casterEntity:EntityType():IsAutoBeadSkillHolder() then
      casterEntity = self._world:Player():GetCurrentTeamEntity()
    end
    for _, result in ipairs(resultArray) do
      local entity = self._world:GetEntityByID(result:GetEntityID())
      if entity then
        local triggerTraps, triggerResults = trapServiceLogic:CalcTrapTriggerSkill(entity, casterEntity)
        entity:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(entity)
        local defenderPos = entity:GetGridPosition()
        local notifyTrapAction = NTTrapAction:New(nil, defenderPos)
        triggerService:Notify(notifyTrapAction)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAbsorbTrapsAndDamageByPickupTarget(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResultArray())
      local trapEntityIDArray = result:GetTrapEntityIDs()
      local trapEntityArray = {}
      for _, trapEntityID in ipairs(trapEntityIDArray) do
        table.insert(trapEntityArray, self._world:GetEntityByID(trapEntityID))
      end
      local trapServiceLogic = self._world:GetService("TrapLogic")
      for _, trapEntity in ipairs(trapEntityArray) do
        local cAttr = trapEntity:Attributes()
        if cAttr:GetCurrentHP() then
          cAttr:Modify("HP", 0)
          Log.debug("_ApplyAbsorbTrapsAndDamageByPickupTarget ModifyHP = 0, defender = ", trapEntity:GetID())
        end
        trapServiceLogic:AddTrapDeadMark(trapEntity, true)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyMoveBoard(casterEntity, param, resultArray)
  if resultArray then
  end
end

function SkillEffectLogicExecutor:_ApplyRecoverFromGreyHP(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  for _, result in ipairs(resultArray) do
    local eid = result:GetEntityID()
    local e = self._world:GetEntityByID(eid)
    local damageInfo = result:GetDamageInfo()
    local calcDamageSvc = self._world:GetService("CalcDamage")
    calcDamageSvc:AddTargetHP(e:GetID(), damageInfo)
    local consumedGreyVal = damageInfo:GetDamageValue()
    local lsvcBuff = self._world:GetService("BuffLogic")
    lsvcBuff:ChangeGreyHP(e, consumedGreyVal * -1)
    result:SetCurrentGreyVal(e:BuffComponent():GetGreyHPValue(true))
  end
end

function SkillEffectLogicExecutor:_ApplyDecreaseSanByScope(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  local sansvc = self._world:GetService("FeatureLogic")
  for _, result in ipairs(resultArray) do
    local curVal, oldVal, realModifyValue, debtVal, modifyTimes = sansvc:DecreaseSanValue(result:GetVal())
    result:SetOldSanValue(oldVal)
    result:SetNewSanValue(curVal)
    result:SetNewSanValue(curVal)
    result:SetDebtValue(debtVal)
    result:SetModifyTimes(modifyTimes)
    local nt = NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes)
    self._world:GetService("Trigger"):Notify(nt)
  end
end

function SkillEffectLogicExecutor:_ApplyIncreaseSan(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  local sansvc = self._world:GetService("FeatureLogic")
  for _, result in ipairs(resultArray) do
    local curVal, oldVal, realModifyValue, debtVal, modifyTimes = sansvc:IncreaseSanValue(result:GetVal())
    result:SetOldSanValue(oldVal)
    result:SetNewSanValue(curVal)
    result:SetDebtValue(debtVal)
    result:SetModifyTimes(modifyTimes)
    local nt = NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes)
    self._world:GetService("Trigger"):Notify(nt)
  end
end

function SkillEffectLogicExecutor:_ApplyAlphaThrowTrap(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, {
        result:GetDamageResult()
      })
      local trapEntityIDArray = result:GetTrapEntityIDs()
      local trapEntityArray = {}
      for _, trapEntityID in ipairs(trapEntityIDArray) do
        table.insert(trapEntityArray, self._world:GetEntityByID(trapEntityID))
      end
      local trapServiceLogic = self._world:GetService("TrapLogic")
      for _, trapEntity in ipairs(trapEntityArray) do
        local cAttr = trapEntity:Attributes()
        if cAttr:GetCurrentHP() then
          cAttr:Modify("HP", 0)
          Log.debug("_ApplyAlphaThrowTrap ModifyHP = 0, defender = ", trapEntity:GetID())
        end
        trapServiceLogic:AddTrapDeadMark(trapEntity, true)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAlphaBlinkAttack(casterEntity, param, resultArray)
  local ridSvc = self._world:GetService("RideLogic")
  for _, result in ipairs(resultArray) do
    local trapID = result:GetTrapID()
    local teleportPos = result:GetTeleportPos()
    local height = result:GetHeight()
    local dir = result:GetAttackDir()
    local newMountID
    local summonPosList = result:GetSummonPosList()
    local summonTrapEntityIDList = {}
    for _, pos in ipairs(summonPosList) do
      local trapEntity = self._trapServiceLogic:CreateTrap(trapID, pos, Vector2(0, 1), true, nil, casterEntity)
      if trapEntity then
        table.insert(summonTrapEntityIDList, trapEntity:GetID())
        if teleportPos == pos then
          newMountID = trapEntity:GetID()
        end
      end
    end
    result:SetTrapIDList(summonTrapEntityIDList)
    if not newMountID then
      local utilDataSvc = self._world:GetService("UtilData")
      newMountID = utilDataSvc:GetTrapAtPosByTrapID(teleportPos, trapID)
    end
    casterEntity:SetGridDirection(dir)
    ridSvc:ReplaceRide(casterEntity:GetID(), newMountID, height)
  end
end

function SkillEffectLogicExecutor:_ApplyRideOn(casterEntity, param, resultArray)
  local ridSvc = self._world:GetService("RideLogic")
  for _, result in ipairs(resultArray) do
    local monsterMountID = result:GetMonsterMountID()
    local height = result:GetHeight()
    local centerOffset = result:GetCenterOffset()
    local trapMountID = result:GetTrapMountID()
    local summonPosList = result:GetSummonPosList()
    if monsterMountID then
      ridSvc:ReplaceRide(casterEntity:GetID(), monsterMountID, height, centerOffset, true, true)
    elseif trapMountID then
      ridSvc:ReplaceRide(casterEntity:GetID(), trapMountID, height)
    elseif 0 < #summonPosList then
      local trapID = result:GetTrapID()
      local newMountID
      local summonTrapEntityIDList = {}
      for _, pos in ipairs(summonPosList) do
        local trapEntity = self._trapServiceLogic:CreateTrap(trapID, pos, Vector2(0, 1), true, nil, casterEntity)
        if trapEntity then
          table.insert(summonTrapEntityIDList, trapEntity:GetID())
          newMountID = trapEntity:GetID()
        end
      end
      result:SetTrapIDList(summonTrapEntityIDList)
      ridSvc:ReplaceRide(casterEntity:GetID(), newMountID, height)
    end
  end
end

function SkillEffectLogicExecutor:_ApplySacrificeTraps(casterEntity, param, resultArray)
  for i, result in ipairs(resultArray) do
    local trapIDs = result:GetTrapIDs()
    local trapEntityArray = {}
    local trapServiceLogic = self._world:GetService("TrapLogic")
    for _, trapEntityID in ipairs(trapIDs) do
      local trapEntity = self._world:GetEntityByID(trapEntityID)
      local cAttr = trapEntity:Attributes()
      if cAttr:GetCurrentHP() then
        cAttr:Modify("HP", 0)
        Log.debug("_ApplySacrificeTraps ModifyHP =0 defender=", trapEntity:GetID())
      end
      trapServiceLogic:AddTrapDeadMark(trapEntity, true)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyPetSacrificeSuperGridTraps(casterEntity, param, resultArray)
  for i, result in ipairs(resultArray) do
    local trapIDs = result:GetTrapIDs()
    local trapEntityArray = {}
    local trapServiceLogic = self._world:GetService("TrapLogic")
    for _, trapEntityID in ipairs(trapIDs) do
      local trapEntity = self._world:GetEntityByID(trapEntityID)
      local cAttr = trapEntity:Attributes()
      if cAttr:GetCurrentHP() then
        cAttr:Modify("HP", 0)
        Log.debug("_ApplyPetSacrificeSuperGridTraps ModifyHP =0 defender=", trapEntity:GetID())
      end
      trapServiceLogic:AddTrapDeadMark(trapEntity, true)
    end
  end
end

function SkillEffectLogicExecutor:_ApplySerialKiller(casterEntity, param, resultArray)
  local collectedMonster = {}
  local collectedMonsterCount = 0
  local deadMonsterList = {}
  for resultIndex, result in ipairs(resultArray) do
    local tDamageResults = result:GetKilledArray()
    for damageResultIndex, damageResult in ipairs(tDamageResults) do
      local targetID = damageResult:GetTargetID()
      if 0 < targetID then
        local targetEntity = self._world:GetEntityByID(targetID)
        if self:IsEnemyEntitySoulCollectable(targetEntity, collectedMonster) then
          collectedMonster[targetID] = true
          collectedMonsterCount = collectedMonsterCount + 1
          table.insert(deadMonsterList, targetEntity)
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyRandAttack(casterEntity, param, resultArray)
  local collectedMonster = {}
  local collectedMonsterCount = 0
  local deadMonsterList = {}
  for resultIndex, result in ipairs(resultArray) do
    local tRandAttackData = result:GetListDefender()
    for randAttackDataIndex, randAttackData in ipairs(tRandAttackData) do
      local targetID = randAttackData.m_entityDefenter
      local targetEntity = self._world:GetEntityByID(targetID)
      if self:IsEnemyEntitySoulCollectable(targetEntity, collectedMonster) then
        collectedMonster[targetID] = true
        collectedMonsterCount = collectedMonsterCount + 1
        table.insert(deadMonsterList, targetEntity)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyHighFrequencyDamage(casterEntity, param, resultArray)
  local collectedMonster = {}
  local collectedMonsterCount = 0
  local deadMonsterList = {}
  for resultIndex, result in ipairs(resultArray) do
    local tDamageResults = result:GetDamageResultArray()
    for damageResultIndex, damageResult in ipairs(tDamageResults) do
      local targetID = damageResult:GetTargetID()
      if 0 < targetID then
        local targetEntity = self._world:GetEntityByID(targetID)
        if self:IsEnemyEntitySoulCollectable(targetEntity, collectedMonster) then
          collectedMonster[targetID] = true
          collectedMonsterCount = collectedMonsterCount + 1
          table.insert(deadMonsterList, targetEntity)
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyRubikCube(casterEntity, param, resultArray)
  if resultArray then
  end
end

function SkillEffectLogicExecutor:_ApplyChangeBodyArea(casterEntity, param, resultArray)
  if resultArray then
    local sBoard = self._world:GetService("BoardLogic")
    local triggerSvc = self._world:GetService("Trigger")
    for resultIndex, result in ipairs(resultArray) do
      local entityID = result:GetChangeBodyAreaEntityID()
      local entity = self._world:GetEntityByID(entityID)
      local pos = entity:GetGridPosition()
      local newBodyArea = result:GetNewBodyArea()
      local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(entity, pos)
      entity:BodyArea():SetArea(newBodyArea)
      triggerSvc:Notify(NTBodyAreaChange:New(entity))
      sBoard:SetEntityBlockFlag(entity, pos, blockFlag)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyDrawCard(casterEntity, param, resultArray)
  if resultArray then
    for resultIndex, result in ipairs(resultArray) do
      local cardType = result:GetCardType()
      local lsvcFeature = self._world:GetService("FeatureLogic")
      if not lsvcFeature:HasFeatureType(FeatureType.Card) then
        return
      end
      if not lsvcFeature:CanAddCard() then
        return
      end
      lsvcFeature:AddCard(cardType)
      if casterEntity and casterEntity:HasPet() then
        local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
        if teamEntity then
          local teamEntityID = teamEntity:GetID()
          local curRound = self._world:BattleStat():GetLevelTotalRoundCount()
          lsvcFeature:RecordDrawCard(teamEntityID, curRound, cardType)
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTransportByRange(casterEntity, param, resultArray)
  if resultArray then
    local sBoard = self._world:GetService("BoardLogic")
    for _, result in ipairs(resultArray) do
      local pieceDataList = result:GetPieceDataList()
      for i, data in ipairs(pieceDataList) do
        local sourcePos = data:GetPiecePos()
        local pos = data:GetNextPos()
        local pieceType = data:GetPieceType()
        if pos and sBoard:IsValidPiecePos(pos) then
          sBoard:SetPieceTypeLogic(pieceType, pos)
          Log.debug("TransportByRange SourcePos:", sourcePos, " SetPos:", pos, "PieceType:", pieceType)
        end
      end
      local targetID, targetOldPos, targetPos = result:GetTargetData()
      if targetID then
        local targetEntity = self._world:GetEntityByID(targetID)
        local type = sBoard:GetPieceType(targetOldPos)
        if type == PieceType.None then
          sBoard:SetPieceTypeLogic(PieceType.Yellow, targetOldPos)
        end
        targetEntity:SetGridPosition(targetPos)
        Log.debug("TargetID:", targetID, "OldPos:", targetOldPos, "NewPos:", targetPos)
        sBoard:UpdateEntityBlockFlag(targetEntity, targetOldPos, targetPos)
      end
      local resetPosList = result:GetResetGridPosList()
      if resetPosList then
        local boardEntity = self._world:GetBoardEntity()
        local tConvertInfo = {}
        local dataPosList = {}
        local resetArray = {}
        local supplyRes = sBoard:SupplyPieceList(resetPosList)
        for i = 1, #supplyRes do
          local res = supplyRes[i]
          local pos = Vector2(res.x, res.y)
          local pieceData = TransportByRangePieceData:New(pos, res.color, pos)
          table.insert(dataPosList, pieceData)
          Log.debug("TransportByRange ResetPos SetPos:", pos, "PieceType:", res.color)
          local convertInfo = NTGridConvert_ConvertInfo:New(Vector2(res.x, res.y), PieceType.None, res.color)
          table.insert(tConvertInfo, convertInfo)
          local resetInfo = SkillEffectResult_ResetGridData:New(res.x, res.y, res.color)
          table.insert(resetArray, resetInfo)
        end
        local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
        ntGridConvert:SetConvertEffectType(SkillEffectType.TransportByRange)
        ntGridConvert:SetSkillType(param:GetSkillType())
        self._world:GetService("Trigger"):Notify(ntGridConvert)
        result:SetResetGridPieceDataList(dataPosList)
        self._world:GetService("Trigger"):Notify(NTResetGridElement:New(resetArray, casterEntity))
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyLevelTrapAbsortSummon(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      local destroyTrapList = result:GetDestroyList()
      for _, destroyResult in ipairs(destroyTrapList) do
        local entity = self._world:GetEntityByID(destroyResult:GetEntityID())
        if entity then
          local trapCmpt = entity:Trap()
          entity:Attributes():Modify("HP", 0)
          self._trapServiceLogic:AddTrapDeadMark(entity)
        end
      end
      local summonTrapList = result:GetSummonList()
      if summonTrapList then
        for _, summonResult in ipairs(summonTrapList) do
          local trapPos = summonResult:GetPos()
          local trapID = summonResult:GetTrapID()
          local direction = Vector2(0, 1)
          local trapEntity = self._trapServiceLogic:CreateTrap(trapID, trapPos, direction, true, nil, casterEntity)
          if trapEntity and trapEntity then
            summonResult:SetTrapIDList({
              trapEntity:GetID()
            })
          end
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyLevelTrapUpLevel(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      local destroyTrapList = result:GetDestroyList()
      for _, destroyResult in ipairs(destroyTrapList) do
        local entity = self._world:GetEntityByID(destroyResult:GetEntityID())
        if entity then
          local trapCmpt = entity:Trap()
          entity:Attributes():Modify("HP", 0)
          self._trapServiceLogic:AddTrapDeadMark(entity)
        end
      end
      local summonTrapList = result:GetSummonList()
      if summonTrapList then
        for _, summonResult in ipairs(summonTrapList) do
          local trapPos = summonResult:GetPos()
          local trapID = summonResult:GetTrapID()
          local direction = Vector2(0, 1)
          local trapEntity = self._trapServiceLogic:CreateTrap(trapID, trapPos, direction, true, nil, casterEntity)
          if trapEntity and trapEntity then
            summonResult:SetTrapIDList({
              trapEntity:GetID()
            })
          end
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyLevelTrapSummonOrUpLevel(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      local destroyTrapList = result:GetDestroyList()
      for _, destroyResult in ipairs(destroyTrapList) do
        local entity = self._world:GetEntityByID(destroyResult:GetEntityID())
        if entity then
          local trapCmpt = entity:Trap()
          entity:Attributes():Modify("HP", 0)
          self._trapServiceLogic:AddTrapDeadMark(entity)
        end
      end
      local summonTrapList = result:GetSummonList()
      if summonTrapList then
        for _, summonResult in ipairs(summonTrapList) do
          local trapPos = summonResult:GetPos()
          local trapID = summonResult:GetTrapID()
          local direction = Vector2(0, 1)
          local trapEntity = self._trapServiceLogic:CreateTrap(trapID, trapPos, direction, true, nil, casterEntity)
          if trapEntity and trapEntity then
            summonResult:SetTrapIDList({
              trapEntity:GetID()
            })
          end
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyModifyAntiAttackParam(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      local entity = self._world:GetEntityByID(result:GetCasterEntityID())
      if entity then
        local modifyType = result:GetModifyType()
        local newValue = result:GetNewValue()
        local attributeCmpt = entity:Attributes()
        attributeCmpt:Modify(modifyType, newValue)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyPetMinosGhostDamage(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResults())
    end
  end
end

function SkillEffectLogicExecutor:_ApplyCoffinMusumeCandle(casterEntity, param, resultArray)
  if not resultArray or #resultArray == 0 then
    return
  end
  for _, result in ipairs(resultArray) do
    local selectedLights = result:GetSelectedLights()
    for _, eid in ipairs(selectedLights) do
      local e = self._world:GetEntityByID(eid)
      if e then
        e:BuffComponent():SetBuffValue(BattleConst.CandleLightKey, 1)
      end
    end
    if 0 < #selectedLights then
      self._world:GetService("Trigger"):Notify(NTCoffinMusumeSkillChangeLight:New(selectedLights))
    end
    local addHPResult = result:GetAddHPResult()
    if addHPResult then
      self:_ApplyAddBlood(casterEntity, param, {addHPResult})
    end
    local damageResult = result:GetDamageResult()
    local damageParam = result:GetDamageParam()
    if damageResult and damageParam then
      self:_ApplyDamage(casterEntity, damageParam, {damageResult})
    end
  end
end

function SkillEffectLogicExecutor:_ApplyCoffinMusumeSetCandleLight(casterEntity, param, resultArray)
  if not resultArray or #resultArray == 0 then
    return
  end
  for _, result in ipairs(resultArray) do
    local e = self._world:GetEntityByID(result:GetEntityID())
    e:BuffComponent():SetBuffValue(BattleConst.CandleLightKey, result:IsLight() and 1 or 0)
    self._world:GetService("Trigger"):Notify(NTCoffinMusumeSkillChangeLight:New(selectedLights))
  end
end

function SkillEffectLogicExecutor:_ApplyTransposition(casterEntity, param, resultArray)
  if resultArray then
    local sBoard = self._world:GetService("BoardLogic")
    local sTrapLogic = self._world:GetService("TrapLogic")
    for _, teleportRes in ipairs(resultArray) do
      local targetID = teleportRes:GetTargetID()
      local posOld = teleportRes:GetPosOld()
      local posNew = teleportRes:GetPosNew()
      local targetDir = teleportRes:GetDirNew()
      local targetEntity = self._world:GetEntityByID(targetID)
      local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(targetEntity, posOld)
      targetEntity:SetGridLocation(posNew, targetDir)
      if targetEntity:HasMonsterID() then
        local listTrapTrigger = sTrapLogic:TriggerTrapByTeleport(targetEntity, teleportRes:IsEnableTriggerEddy())
        local trapIDList = {}
        for _, v in ipairs(listTrapTrigger) do
          local trapEntityID = v:GetID()
          trapIDList[#trapIDList + 1] = trapEntityID
        end
        teleportRes:SetTriggerTrapList(trapIDList)
      end
      sBoard:SetEntityBlockFlag(targetEntity, posNew, blockFlag)
      self._world:GetService("Trigger"):Notify(NTTeleport:New(targetEntity, posOld, posNew))
    end
  end
end

function SkillEffectLogicExecutor:_ApplySnakeHeadMove(casterEntity, param, resultArray)
  if resultArray then
    local sBoard = self._world:GetService("BoardLogic")
    local skillEffectService = self._world:GetService("SkillEffectCalc")
    for resultIndex, result in ipairs(resultArray) do
      local oldPos = result:GetOldPos()
      local newPos = result:GetNewPos()
      local casterIsDead = result:GetCasterIsDead()
      if not casterIsDead then
        local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(casterEntity, oldPos)
        local dir = newPos - oldPos
        casterEntity:SetGridPosition(newPos)
        casterEntity:SetGridDirection(dir)
        sBoard:SetEntityBlockFlag(casterEntity, newPos, blockFlag)
        skillEffectService:TriggerTrap(casterEntity, result)
        local notify = NTSnakeHeadMoved:New(casterEntity, newPos, oldPos)
        self._world:GetService("Trigger"):Notify(notify)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplySnakeBodyMoveAndGrowth(casterEntity, param, resultArray)
  if resultArray then
    local sBoard = self._world:GetService("BoardLogic")
    for resultIndex, result in ipairs(resultArray) do
      local newBodyArea = result:GetNewBodyArea()
      local oldBodyArea = result:GetOldBodyArea()
      local bodyOldPos = result:GetBodyOldPos()
      local bodyNewPos = result:GetBodyNewPos()
      local casterIsDead = result:IsCasterDead()
      if not casterIsDead then
        local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(casterEntity, bodyOldPos)
        local headNewPos = result:GetHeadNewPos()
        local dir = headNewPos - bodyNewPos
        casterEntity:SetGridPosition(bodyNewPos)
        casterEntity:SetGridDirection(dir)
        casterEntity:BodyArea():SetArea(newBodyArea)
        sBoard:SetEntityBlockFlag(casterEntity, bodyNewPos, blockFlag)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplySnakeTailMove(casterEntity, param, resultArray)
  if resultArray then
    local sBoard = self._world:GetService("BoardLogic")
    local skillEffectService = self._world:GetService("SkillEffectCalc")
    local casterPos = casterEntity:GetGridPosition()
    for resultIndex, result in ipairs(resultArray) do
      local casterIsDead = result:IsCasterDead()
      local newPos = result:GetNewPos()
      if not casterIsDead and newPos then
        local oldPos = casterPos
        local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(casterEntity, casterPos)
        casterEntity:SetGridPosition(newPos)
        local lastBodyArea = result:GetLastBodyPos()
        local dir = lastBodyArea - newPos
        casterEntity:SetGridDirection(dir)
        Log.fatal("Logic NewPos:", newPos, "lastBodyArea：", lastBodyArea, " Dir:", dir)
        sBoard:SetEntityBlockFlag(casterEntity, newPos, blockFlag)
        skillEffectService:TriggerTrap(casterEntity, result)
        local notify = NTSnakeTailMoved:New(casterEntity, newPos, oldPos)
        self._world:GetService("Trigger"):Notify(notify)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplySummonTrapOrHealByTrapBuffLayer(casterEntity, param, resultArray)
  if not resultArray then
    return
  end
  for _, result in ipairs(resultArray) do
    if SkillSummonTrapEffectResult:IsInstanceOfType(result) then
      self:_ApplySummonTrap(casterEntity, param, {result})
    elseif SkillEffectResult_AddBlood:IsInstanceOfType(result) then
      self:_ApplyAddBlood(casterEntity, param, {result})
    elseif SkillEffectDestroyTrapResult:IsInstanceOfType(result) then
      self:_ApplyDestroyTrap(casterEntity, param, {result})
    else
      Log.fatal("unrecognized result type for SummonTrapOrHealByTrapBuffLayer: ", tostring(result:GetEffectType()))
    end
  end
end

local notifyClsDic = {
  [NotifyType.Pet1601781SkillHolder1] = NTPet1601781SkillHolder1,
  [NotifyType.Pet1601781SkillHolder2] = NTPet1601781SkillHolder2,
  [NotifyType.Pet1601781SkillHolder3] = NTPet1601781SkillHolder3
}

function SkillEffectLogicExecutor:_ApplyWeikeNotify(casterEntity, param, resultArray)
  if not resultArray or #resultArray == 0 then
    return
  end
  for resultIndex, result in ipairs(resultArray) do
    local notifyType = result:GetNotifyType()
    local skillType = result:GetSkillType()
    local casterPos = result:GetCasterPos()
    local multiCastCount = result:GetMultiCastCount()
    local notifyCls = notifyClsDic[notifyType]
    if notifyCls then
      local notify = notifyCls:New(skillType, casterPos, multiCastCount)
      self._world:GetService("Trigger"):Notify(notify)
    end
  end
end

function SkillEffectLogicExecutor:_ApplySetMonsterOffBoard(casterEntity, param, resultArray)
  if not resultArray or #resultArray == 0 then
    return
  end
end

function SkillEffectLogicExecutor:_ApplySplashDamageAndAddBuff(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResults())
    end
  end
end

function SkillEffectLogicExecutor:_ApplyDynamicCenterDamage(casterEntity, param, resultArray)
  if not resultArray or #resultArray == 0 then
    return
  end
  for _, result in ipairs(resultArray) do
    local damageResults = result:GetDamageResults()
    self:_ApplyDamage(casterEntity, param, damageResults)
  end
end

function SkillEffectLogicExecutor:_ApplyAddMoveScopeRecordCmpt(casterEntity, param, resultArray)
  if not resultArray or #resultArray == 0 then
    return
  end
  for _, result in ipairs(resultArray) do
    local hostEntityID = result:GetHostEntityID()
    local offSet = result:GetOffSet()
    local hostEntity = self._world:GetEntityByID(hostEntityID)
    if hostEntity then
      if hostEntity:HasMoveScopeRecord() then
        hostEntity:RemoveMoveScopeRecord()
      end
      hostEntity:AddMoveScopeRecord(offSet)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTrapMoveAndDamage(casterEntity, param, resultArray)
  if resultArray then
    local trapServiceLogic = self._world:GetService("TrapLogic")
    for _, result in ipairs(resultArray) do
      local damageResult = result:GetDamageResult()
      self:_ApplyDamage(casterEntity, param, {damageResult})
      local isOut = result:IsOutBoard()
      if isOut or damageResult then
        casterEntity:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(casterEntity, true)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyThrowMonsterAndDamage(casterEntity, param, resultArray)
  if resultArray then
    for index, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, {
        result:GetDamageResult()
      })
      local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
      local monsterEntityIDArray = result:GetMonsterEntityIDs()
      for i, entityID in ipairs(monsterEntityIDArray) do
        local e = self._world:GetEntityByID(entityID)
        e:Attributes():Modify("HP", 0)
        sMonsterShowLogic:AddMonsterDeadMark(e)
      end
      sMonsterShowLogic:DoAllMonsterDeadLogic()
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTeleportTeamAroundAndSummonTrapLine(casterEntity, param, resultArray)
  if resultArray then
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    local stageIndex = param:GetSkillEffectDamageStageIndex()
    local skillEffectResult_Teleport = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport, stageIndex)
    if skillEffectResult_Teleport then
      self:_ApplyTeleport(casterEntity, param, skillEffectResult_Teleport)
    end
    local skillEffectResultChangeBodyArea = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ChangeBodyArea)
    if skillEffectResultChangeBodyArea then
      self:_ApplyChangeBodyArea(casterEntity, param, skillEffectResultChangeBodyArea)
    end
    local skillRotateEffectResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Rotate)
    if skillRotateEffectResult then
      self:_ApplyRotate(casterEntity, param, skillRotateEffectResult)
    end
    local resSummonTrap = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap, stageIndex)
    if resSummonTrap then
      self:_ApplySummonTrap(casterEntity, param, resSummonTrap)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyTurnToTargetChangeBodyAreaAndDir(casterEntity, param, resultArray)
  if resultArray then
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    local skillEffectResult_Teleport = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport)
    if skillEffectResult_Teleport then
      self:_ApplyTeleport(casterEntity, param, skillEffectResult_Teleport)
    end
    local skillEffectResultChangeBodyArea = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ChangeBodyArea)
    if skillEffectResultChangeBodyArea then
      self:_ApplyChangeBodyArea(casterEntity, param, skillEffectResultChangeBodyArea)
    end
    local skillRotateEffectResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Rotate)
    if skillRotateEffectResult then
      self:_ApplyRotate(casterEntity, param, skillRotateEffectResult)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyControlMonsterMove(casterEntity, param, resultArray)
  if resultArray then
    local stageIndex = param:GetSkillEffectDamageStageIndex()
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    local skillEffectResult_Teleport = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport, stageIndex)
    if skillEffectResult_Teleport then
      self:_ApplyTeleport(casterEntity, param, skillEffectResult_Teleport)
    end
    local resSummonTrap = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap, stageIndex)
    if resSummonTrap then
      self:_ApplySummonTrap(casterEntity, param, resSummonTrap)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyConvertAndDamageByLinkLine(casterEntity, param, resultArray)
  if resultArray then
    for index, result in ipairs(resultArray) do
      local convertResult = result:GetConvertResult()
      if convertResult then
        self:_ApplyConvertGridElement(casterEntity, param, {convertResult}, SkillEffectType.ConvertAndDamageByLinkLine)
      end
      local damageResult = result:GetDamageResult()
      if damageResult then
        self:_ApplyDamage(casterEntity, param, {damageResult})
      end
      local needTeleport = param:NeedTelePort()
      if needTeleport ~= false then
        local teleportResult = result:GetTeleportResult()
        if teleportResult then
          self:_ApplyTeleport(casterEntity, param, {teleportResult})
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyPetTrapMove(casterEntity, param, resultArray)
  if resultArray then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      local targetEntityID = result:GetEntityID()
      local posOld = result:GetPosOld()
      local posNew = result:GetPosNew()
      local targetDir = result:GetDirNew()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      local bodyArea, blockFlag = boardServiceLogic:RemoveEntityBlockFlag(targetEntity, posOld)
      targetEntity:SetGridLocation(posNew, targetDir)
      local triggerTraps = self:_ApplyTriggerTrap(targetEntity, TrapTriggerOrigin.Move)
      local trapIDList = {}
      for _, v in ipairs(triggerTraps) do
        local trapEntityID = v:GetID()
        trapIDList[#trapIDList + 1] = trapEntityID
      end
      result:SetTriggerTrapList(trapIDList)
      boardServiceLogic:SetEntityBlockFlag(targetEntity, posNew, blockFlag)
    end
  end
end

function SkillEffectLogicExecutor:_ApplySacrificeTargetNearestTrapsAndDamage(casterEntity, param, resultArray)
  if resultArray then
    local boardService = self._world:GetService("BoardLogic")
    for index, result in ipairs(resultArray) do
      self:_ApplyDamage(casterEntity, param, result:GetDamageResultArray())
      local trapEntityIDArray = result:GetTrapIDArray()
      local trapEntityArray = {}
      for _, trapEntityID in ipairs(trapEntityIDArray) do
        table.insert(trapEntityArray, self._world:GetEntityByID(trapEntityID))
      end
      local trapServiceLogic = self._world:GetService("TrapLogic")
      for _, trapEntity in ipairs(trapEntityArray) do
        local cAttr = trapEntity:Attributes()
        if cAttr:GetCurrentHP() then
          cAttr:Modify("HP", 0)
          Log.debug("_ApplySacrificeTargetNearestTrapsAndDamage ModifyHP =0 defender=", trapEntity:GetID())
        end
        trapServiceLogic:AddTrapDeadMark(trapEntity, true)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAttachMonster(casterEntity, param, resultArray)
  if resultArray then
    local buffLogicSvc = self._world:GetService("BuffLogic")
    for _, result in ipairs(resultArray) do
      local addEliteIDArray = result:GetEliteIDArray()
      if 0 < #addEliteIDArray then
        local targetID = result:GetTargetID()
        local targetEntity = self._world:GetEntityByID(targetID)
        local monsterIDCmpt = targetEntity:MonsterID()
        if monsterIDCmpt then
          monsterIDCmpt:SetEliteIDArrayAttach(addEliteIDArray)
          for _, eliteID in ipairs(addEliteIDArray) do
            local c = Cfg.cfg_monster_elite[eliteID]
            if not c then
              Log.error("[ATTACH_ELITE]", "invalid eliteID: ", eliteID)
            elseif c.Buff and #c.Buff ~= 0 then
              for _, buffID in ipairs(c.Buff) do
                Log.debug("[ATTACH_ELITE]", "entityID: ", targetID, "elite ID: ", eliteID, ", buffID: ", buffID)
                local buffIns = buffLogicSvc:AddBuff(buffID, targetEntity, {})
                if buffIns then
                  result:AddBuffSeq(buffIns:BuffSeq())
                end
              end
            end
          end
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyDetachMonster(casterEntity, param, resultArray)
  if not param:IsRemoveElite() then
    return
  end
  if resultArray then
    for _, result in ipairs(resultArray) do
      local targetID = result:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetID)
      if targetEntity and not targetEntity:HasDeadMark() then
        local monsterIDCmpt = targetEntity:MonsterID()
        if monsterIDCmpt then
          local addEliteIDArray = monsterIDCmpt:GetEliteIDArrayAttach()
          if 0 < #addEliteIDArray then
            local buffCmpt = targetEntity:BuffComponent()
            for _, eliteID in ipairs(addEliteIDArray) do
              local c = Cfg.cfg_monster_elite[eliteID]
              if not c then
                Log.error("[DETACH_ELITE]", "invalid eliteID: ", eliteID)
              elseif c.Buff and #c.Buff ~= 0 then
                for _, buffID in ipairs(c.Buff) do
                  Log.debug("[DETACH_ELITE]", "entityID: ", targetID, "elite ID: ", eliteID, ", buffID: ", buffID)
                  local buffIns = buffCmpt:GetBuffById(buffID)
                  if buffIns then
                    result:AddRemoveBuffSeq(buffIns:BuffSeq())
                    buffIns:Unload(NTBuffUnload:New())
                  end
                end
              end
            end
            monsterIDCmpt:ClearEliteIDArrayAttach()
          end
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyNightKingTeleportPathDamage(casterEntity, param, resultArray)
  self:_ApplyDamage(casterEntity, param, resultArray)
end

function SkillEffectLogicExecutor:_ApplyPickUpGridTogether(casterEntity, param, resultArray)
  local boardSvc = self._world:GetService("BoardLogic")
  for i, result in ipairs(resultArray) do
    local gridList = result:GetNewGridDataList()
    for i, v in ipairs(gridList) do
      boardSvc:SetPieceTypeLogic(v:GetGridType(), v:GetGridPos())
    end
  end
end

function SkillEffectLogicExecutor:_ApplySpliceBoard(casterEntity, param, resultArray)
  if resultArray then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local boardEntity = self._world:GetBoardEntity()
    local boardComponent = boardEntity:Board()
    local boardSpliceComponent = boardEntity:BoardSplice()
    local trapServiceLogic = self._world:GetService("TrapLogic")
    for i, v in ipairs(resultArray) do
      local result = v
      local destroyTrapList = result:GetDestroyTrapList()
      for _, entityID in ipairs(destroyTrapList) do
        local tarpEntity = self._world:GetEntityByID(entityID)
        tarpEntity:Attributes():Modify("HP", 0)
        local isDieSkillDisabled = true
        if tarpEntity:Trap():GetTrapType() == TrapType.BadGrid then
          isDieSkillDisabled = false
        end
        trapServiceLogic:AddTrapDeadMark(tarpEntity, isDieSkillDisabled)
      end
      local pieceTable = result:GetPieceTable()
      if pieceTable and 0 < table.count(pieceTable) then
        boardComponent:InitGridEdgeDistance(pieceTable)
      end
      local cfgId = BattleConst.BlockFlagCfgIDGapTile
      local blockFlag = boardServiceLogic:GetBlockFlagByBlockId(cfgId)
      local convertResult = result:GetConvertColors()
      for _, r in ipairs(convertResult) do
        local oldPos, newPos, pieceType, isAddGrid, isRemoveGrid = r[1], r[2], r[3], r[4], r[5]
        if isAddGrid then
          self:_AddSpliceBoardGrid(newPos, pieceType)
        end
        if isRemoveGrid then
          self:_RemoveSpliceBoardGrid(oldPos)
        end
        boardServiceLogic:SetPieceTypeLogic(pieceType, newPos)
      end
      local moveEntities = result:GetMoveEntities()
      for _, r in ipairs(moveEntities) do
        local entityID, oldPos, newPos = r[1], r[2], r[3]
        local e = self._world:GetEntityByID(entityID)
        boardServiceLogic:UpdateEntityBlockFlag(e, oldPos, newPos)
        e:SetGridPosition(newPos)
        if e:HasTeam() then
          local pets = e:Team():GetTeamPetEntities()
          for i, e in ipairs(pets) do
            e:SetGridPosition(newPos)
          end
        end
      end
      local prismResult = result:GetSpliceBoardPrisms()
      for _, r in ipairs(prismResult) do
        local oldPos, newPos = r[1], r[2]
        boardComponent:RemoveBoardPieceEffectType(oldPos)
        local prismEntityID = boardComponent:GetPrismEntityIDAtPos(oldPos)
        local pieceEffectType = r[3]
        boardComponent:SetBoardPieceEffectType(newPos, pieceEffectType, prismEntityID)
      end
      local spliceResult = result:GetSpliceBoardGrid()
      for _, r in ipairs(spliceResult) do
        local pos, isAddGrid, isRemoveGrid, pieceType, isPrism, pieceEffectType = r[1], r[2], r[3], r[4], r[5], r[6]
        if isAddGrid then
          if isPrism then
            local prismEntityID = boardSpliceComponent:GetPrismEntityIDAtPos(pos)
            boardSpliceComponent:RemoveBoardPieceEffectType(pos)
            boardComponent:SetBoardPieceEffectType(pos, pieceEffectType, prismEntityID)
          end
          self:_AddSpliceBoardGrid(pos, pieceType)
        end
        if isRemoveGrid then
          pieceType = boardServiceLogic:GetPieceType(pos)
          if pieceType ~= r[4] then
            r[4] = pieceType
          end
          boardSpliceComponent:SetPieceElement(pos, pieceType)
          if isPrism then
            local prismEntityID = boardComponent:GetPrismEntityIDAtPos(pos)
            boardComponent:RemoveBoardPieceEffectType(pos)
            boardSpliceComponent:SetBoardPieceEffectType(pos, pieceEffectType, prismEntityID)
          end
          self:_RemoveSpliceBoardGrid(pos)
        end
      end
      local notifyStartTrapEntityID = result:GetNotifyStartTrapEntityID()
      local notifyStartTrapEntity = self._world:GetEntityByID(notifyStartTrapEntityID)
      local notifyEndTrapEntityID = result:GetNotifyEndTrapEntityID()
      local notifyEndTrapEntity = self._world:GetEntityByID(notifyEndTrapEntityID)
      local triggerSvc = self._world:GetService("Trigger")
      if notifyStartTrapEntity then
        local ntSpliceBoard = NTSpliceBoardBegin:New(notifyStartTrapEntity)
        triggerSvc:Notify(ntSpliceBoard)
      end
      if notifyEndTrapEntity then
        local ntSpliceBoard = NTSpliceBoardEnd:New(notifyEndTrapEntity)
        triggerSvc:Notify(ntSpliceBoard)
        local notifyEndTrapEntityPos = notifyEndTrapEntity:GetGridPosition()
        local notifyEndTrapEntityBlockFlag = boardServiceLogic:GetBlockFlag(notifyEndTrapEntity)
        boardServiceLogic:SetPosBlock(notifyEndTrapEntity, notifyEndTrapEntityPos, notifyEndTrapEntityBlockFlag)
      end
    end
  end
end

function SkillEffectLogicExecutor:_AddSpliceBoardGrid(pos, pieceType)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local offset = math.abs(pos.x - teamPos.x) + math.abs(pos.y - teamPos.y)
  local val = BattleConst.BoardGenConnectRateParamTable[offset]
  if val == nil then
    val = BattleConst.BoardGenConnectRateParamTable[1]
  end
  local gapTiles = boardServiceLogic:GetGapTiles()
  for _, gapTile in ipairs(gapTiles) do
    if gapTile[1] == pos.x and gapTile[2] == pos.y then
      table.removev(gapTiles, gapTile)
      break
    end
  end
  boardServiceLogic:ChangeGapTiles(gapTiles)
  local gridTiles = boardServiceLogic:GetGridTiles()
  if not gridTiles[pos.x] then
    gridTiles[pos.x] = {}
  end
  gridTiles[pos.x][pos.y] = {
    x = pos.x,
    y = pos.y,
    color = pieceType,
    connect = 0,
    connvalue = val
  }
  local pieceBlockData = PieceBlockData:New(pos.x, pos.y)
  boardComponent:SetBlockFlags(pos, pieceBlockData)
  boardComponent:OnlySetPieceType(pos, pieceType)
  boardComponent:AddGridEntityData(pos, pieceType)
end

function SkillEffectLogicExecutor:_RemoveSpliceBoardGrid(oldPos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local cfgId = BattleConst.BlockFlagCfgIDGapTile
  local blockFlag = boardServiceLogic:GetBlockFlagByBlockId(cfgId)
  local pieceBlockData = PieceBlockData:New(oldPos.x, oldPos.y)
  pieceBlockData:AddBlock(-cfgId, blockFlag)
  boardComponent:SetBlockFlags(oldPos, pieceBlockData)
  local gapTiles = boardServiceLogic:GetGapTiles()
  local posValue = {
    oldPos.x,
    oldPos.y
  }
  if not table.icontains(gapTiles, posValue) then
    table.insert(gapTiles, posValue)
  end
  boardServiceLogic:ChangeGapTiles(gapTiles)
  local gridTiles = boardServiceLogic:GetGridTiles()
  gridTiles[oldPos.x][oldPos.y] = nil
  boardComponent:OnlySetPieceType(oldPos, nil)
  boardComponent:AddGridEntityData(oldPos, nil)
end

function SkillEffectLogicExecutor:_ApplyControlMonsterCastHitBackTeam(casterEntity, param, resultArray)
end

function SkillEffectLogicExecutor:_ApplyTeleportAndChangeBodyArea(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      if result:GetEffectType() == SkillEffectType.Teleport then
        self:_ApplyTeleport(casterEntity, param, {result})
      elseif result:GetEffectType() == SkillEffectType.ChangeBodyArea then
        self:_ApplyChangeBodyArea(casterEntity, param, {result})
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyFixTrapWall(casterEntity, param, resultArray)
  if resultArray then
    local boardEntity = self._world:GetBoardEntity()
    local logicTrapWallComponent = boardEntity:LogicTrapWall()
    logicTrapWallComponent = logicTrapWallComponent or boardEntity:AddLogicTrapWall()
    for i, v in ipairs(resultArray) do
      local result = v
      local isAdd = result:GetIsAdd()
      local trapWallPosList = result:GetFixTrapWallPosList()
      for _, pos in ipairs(trapWallPosList) do
        local trapWall = logicTrapWallComponent:GetTrapWall(pos)
        if isAdd then
          if not trapWall then
            logicTrapWallComponent:AddTrapWall(casterEntity:GetID(), pos)
          end
        elseif trapWall then
          logicTrapWallComponent:RemoveTrapWall(pos)
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplySetGridMaintainColorForSupply(casterEntity, param, resultArray)
  if resultArray then
    local boardCmpt = self._world:GetBoardEntity():Board()
    for i, v in ipairs(resultArray) do
      local res = v
      local posList = res:GetPosList()
      local maintainColor = res:GetMaintainColor()
      for index, pos in ipairs(posList) do
        local posIndex = Vector2.Pos2Index(pos)
        boardCmpt:SetMaintainColorForSupply(posIndex, maintainColor)
        Log.debug("Apply SetGridMaintainColorForSupply posIndex: ", posIndex, " maintainColor: ", maintainColor)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyCrabMoveAndAttack(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      if result:GetEffectType() == SkillEffectType.Teleport then
        self:_ApplyTeleport(casterEntity, param, {result})
      elseif result:GetEffectType() == SkillEffectType.Damage then
        self:_ApplyDamage(casterEntity, param, {result})
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplySkillCostFeatureStepPoint(casterEntity, param, resultArray)
  if resultArray then
    local featureSvc = self._world:GetService("FeatureLogic")
    for _, result in ipairs(resultArray) do
      local costVal = result:GetCostVal()
      local oldVal = featureSvc:GetCurStepPoint()
      featureSvc:ChangeCurStepPoint(-1 * costVal)
      local curVal = featureSvc:GetCurStepPoint()
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      local triggerSvc = self._world:GetService("Trigger")
      local ntCost = NTFeatureStepPointSkillCost:New(teamEntity, curVal, oldVal, costVal)
      triggerSvc:Notify(ntCost)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyAddMonsterWeak(casterEntity, param, resultArray)
  if resultArray then
    for i, v in ipairs(resultArray) do
      local res = v
      local entityID = res:GetEntityID()
      local weakResult = res:GetWeakResult()
      local damageResult = res:GetDamageResult()
      local targetEntity = self._world:GetEntityByID(entityID)
      local monsterWeakComponent = targetEntity:MonsterWeak()
      if not monsterWeakComponent then
        targetEntity:AddMonsterWeak()
        monsterWeakComponent = targetEntity:MonsterWeak()
      end
      for _, weak in ipairs(weakResult) do
        local monsterWeakData = weak
        local key = monsterWeakData:GetKey()
        monsterWeakComponent:SetMonsterWeakData(key, weak)
      end
      self:_ApplyDamage(casterEntity, param, damageResult)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyDetonateMonsterWeak(casterEntity, param, resultArray)
  if resultArray then
    for i, v in ipairs(resultArray) do
      local res = v
      local entityID = res:GetEntityID()
      local weakResult = res:GetWeakResult()
      local damageResult = res:GetDamageResult()
      local targetEntity = self._world:GetEntityByID(entityID)
      local monsterWeakComponent = targetEntity:MonsterWeak()
      if not monsterWeakComponent then
        targetEntity:AddMonsterWeak()
        monsterWeakComponent = targetEntity:MonsterWeak()
      end
      for _, weak in ipairs(weakResult) do
        local monsterWeakData = weak
        local key = monsterWeakData:GetKey()
        monsterWeakComponent:RemoveMonsterWeakData(key)
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyColorPaletteCharge(casterEntity, param, resultArray)
  if resultArray then
    local pieceTypes = {}
    for _, _result in ipairs(resultArray) do
      local result = _result
      if result:GetPieceType() ~= PieceType.None then
        table.insert(pieceTypes, result:GetPieceType())
      end
    end
    local entity = self._world:GetEntityByID(casterEntity:GetID())
    if not entity:HasColorPalette() then
      entity:AddColorPalette()
    end
    local component = entity:ColorPalette()
    local isNotSatisfy = not component:IsSatisfy()
    component:AddPieceTypes(pieceTypes)
    if isNotSatisfy and component:IsSatisfy() then
      local configService = self._world:GetService("Config")
      local utilData = self._world:GetService("UtilData")
      local extraSkillList = entity:SkillInfo():GetExtraActiveSkillIDList()
      if extraSkillList then
        for _, extraSkillID in ipairs(extraSkillList) do
          local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
          if extraSkillConfigData and extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
            utilData:SetPetSkillReadyAttr(entity, 1, extraSkillID)
          end
        end
      end
      local triggerSvc = self._world:GetService("Trigger")
      local notify = NTColorPaletteChargeComplete:New(entity, component:GetPieceTypes())
      triggerSvc:Notify(notify)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyRobotBomb(casterEntity, param, resultArray)
  if resultArray then
    for _, _robotBomb in ipairs(resultArray) do
      local robotBomb = _robotBomb
      self:_ApplyDamage(casterEntity, param, robotBomb.damageResult)
      if #robotBomb.pieceTypes > 0 then
        local entity = self._world:GetEntityByID(casterEntity:GetID())
        if not entity:HasColorPalette() then
          entity:AddColorPalette()
        end
        local component = entity:ColorPalette()
        local isNotSatisfy = not component:IsSatisfy()
        component:AddPieceTypes(robotBomb.pieceTypes)
        if isNotSatisfy and component:IsSatisfy() then
          local configService = self._world:GetService("Config")
          local utilData = self._world:GetService("UtilData")
          local extraSkillList = entity:SkillInfo():GetExtraActiveSkillIDList()
          if extraSkillList then
            for _, extraSkillID in ipairs(extraSkillList) do
              local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
              if extraSkillConfigData and extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
                utilData:SetPetSkillReadyAttr(entity, 1, extraSkillID)
              end
            end
          end
          local triggerSvc = self._world:GetService("Trigger")
          local notify = NTColorPaletteChargeComplete:New(entity, component:GetPieceTypes())
          triggerSvc:Notify(notify)
        end
      end
      if robotBomb.trapEntityID then
        local trapEntity = self._world:GetEntityByID(robotBomb.trapEntityID)
        if trapEntity then
          local trapServiceLogic = self._world:GetService("TrapLogic")
          trapEntity:Attributes():Modify("HP", 0)
          trapServiceLogic:AddTrapDeadMark(trapEntity)
        end
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyScorpionSummon(casterEntity, skillEffectParam, resultArray)
  if skillEffectParam:GetInitCasterBornBuff() == 1 then
    local monsterIDCmpt = casterEntity:MonsterID()
    if monsterIDCmpt then
      local buffLogicService = self._world:GetService("BuffLogic")
      buffLogicService:RemoveAllBuffInstance(casterEntity)
      local monsterBornBuffContext = {isMonsterBornBuff = true}
      local buffLogic = self._world:GetService("BuffLogic")
      local monsterConfigData = self._configService:GetMonsterConfigData()
      local buffList = monsterConfigData:GetBornBuffList(monsterIDCmpt:GetMonsterID())
      if 0 < #buffList then
        if not casterEntity:HasBuff() then
          casterEntity:AddBuffComponent()
        end
        for _, buffId in ipairs(buffList) do
          buffLogic:AddBuff(buffId, casterEntity, monsterBornBuffContext)
        end
      end
    end
  end
  for _, _result in ipairs(resultArray) do
    local result = _result
    local summonType = result:GetSummonType()
    if summonType == SkillEffectEnum_SummonType.Monster then
      local positionArray = result:GetSummonPositions()
      local monsterID = result:GetSummonID()
      local monsters = {}
      local length = #positionArray
      for _, position in ipairs(positionArray) do
        local summonEffectResult = SkillEffectResult_SummonEverything:New(summonType, monsterID, position, position)
        local monsterEntity = self:_SummonMonster(casterEntity, summonEffectResult, skillEffectParam)
        if monsterEntity then
          local attributeCmpt = monsterEntity:Attributes()
          if length == 2 then
            attributeCmpt:Modify("Mobility", 3, 1, MultModifyOperator.PLUS)
          elseif length == 3 then
            attributeCmpt:Modify("Mobility", 2, 1, MultModifyOperator.PLUS)
          end
          table.insert(monsters, monsterEntity)
        end
        result:AddSummonResult(summonEffectResult)
      end
      local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
      local groupID = monsterCreationSvc:BuildMoveGroup(monsters)
      result:SetGroupID(groupID)
      local triggerSvc = self._world:GetService("Trigger")
      local nt = NTScorpionSummonEnd:New(groupID)
      triggerSvc:Notify(nt)
    end
  end
end

function SkillEffectLogicExecutor:_ApplyScorpionHitBack(casterEntity, skillEffectParam, resultArray)
end

function SkillEffectLogicExecutor:_ApplyChangeSanMax(casterEntity, skillEffectParam, resultArray)
  if not resultArray then
    return
  end
  local sansvc = self._world:GetService("FeatureLogic")
  for _, result in ipairs(resultArray) do
    local deltaMax = result:GetDeltaMax()
    local curMax = sansvc:GetSanMaxValue()
    local finalMax = curMax + deltaMax
    sansvc:SetSanMaxValue(finalMax)
    result:SetOldSanMaxValue(curMax)
    result:SetNewSanMaxValue(finalMax)
    local deltaSan = result:GetDeltaVal()
    if 0 <= deltaSan then
      local curVal, oldVal, realModifyValue, debtVal, modifyTimes = sansvc:IncreaseSanValue(deltaSan)
      result:SetOldSanValue(oldVal)
      result:SetNewSanValue(curVal)
      result:SetDebtValue(debtVal)
      result:SetModifyTimes(modifyTimes)
      if deltaSan ~= 0 then
        local nt = NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes)
        self._world:GetService("Trigger"):Notify(nt)
      end
    elseif deltaSan < 0 then
      local curVal, oldVal, realModifyValue, debtVal, modifyTimes = sansvc:DecreaseSanValue(-deltaSan)
      result:SetOldSanValue(oldVal)
      result:SetNewSanValue(curVal)
      result:SetNewSanValue(curVal)
      result:SetDebtValue(debtVal)
      result:SetModifyTimes(modifyTimes)
      local nt = NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes)
      self._world:GetService("Trigger"):Notify(nt)
    end
  end
end

function SkillEffectLogicExecutor:_ApplySwapSan2TeamHp(casterEntity, skillEffectParam, resultArray)
  local sanSvc = self._world:GetService("FeatureLogic")
  for _, _result in ipairs(resultArray) do
    local result = _result
    local sanPercent = result:GetSanPercent()
    local oldSan = sanSvc:GetSanValue()
    local maxSan = sanSvc:GetSanMaxValue()
    local newSan = sanPercent * maxSan
    local increaseSan = newSan - oldSan
    local curVal, oldVal, realModifyValue, debtVal, modifyTimes = sanSvc:ModifySanValue(increaseSan)
    result:SetCurSan(curVal)
    result:SetOldSan(oldVal)
    result:SetDeltaSan(debtVal)
    result:SetModifyTimes(modifyTimes)
    local notify = NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes)
    self._world:GetService("Trigger"):Notify(notify)
    local teamHpPercent = result:GetTeamHpPercent()
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for _, petEntity in ipairs(pets) do
      local attributeCmpt = petEntity:Attributes()
      local curHp = attributeCmpt:GetCurrentHP()
      local maxHP = attributeCmpt:CalcMaxHp()
      local newHp = math.floor(teamHpPercent * maxHP)
      if self._world:MatchType() == MatchType.MT_Maze then
        attributeCmpt:Modify("HP", newHp)
      end
      result:AddMazeDamage(petEntity:GetID(), newHp - curHp)
    end
    local teamAttrConmpt = teamEntity:Attributes()
    local teamMaxHP = teamAttrConmpt:CalcMaxHp()
    local newTeamHp = math.floor(teamHpPercent * teamMaxHP)
    teamAttrConmpt:Modify("HP", newTeamHp)
  end
end

function SkillEffectLogicExecutor:_ApplySummonWithCasterAttribute(casterEntity, skillEffectParam, resultArray)
end

function SkillEffectLogicExecutor:_ApplyMoyeMove(casterEntity, param, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      local teleportResult = result:GetTeleportResult()
      if teleportResult then
        self:_ApplyTeleport(casterEntity, param, {teleportResult})
      end
    end
  end
end

function SkillEffectLogicExecutor:_ApplyControlMonsterTeleportAndAttack(casterEntity, skillEffectParam, resultArray)
  if resultArray then
    for _, result in ipairs(resultArray) do
      if result:GetEffectType() == SkillEffectType.Teleport then
        self:_ApplyTeleport(casterEntity, skillEffectParam, {result})
      elseif result:GetEffectType() == SkillEffectType.Damage then
        self:_ApplyDamage(casterEntity, skillEffectParam, {result})
      end
    end
  end
end
