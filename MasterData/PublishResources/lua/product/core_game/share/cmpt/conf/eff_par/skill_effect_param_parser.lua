_class("SkillEffectParamParser", Object)
SkillEffectParamParser = SkillEffectParamParser

function SkillEffectParamParser:Constructor()
  self._effectParamClassDict = {}
  self._effectParamClassDict[SkillEffectType.Damage] = SkillDamageEffectParam
  self._effectParamClassDict[SkillEffectType.HitBack] = SkillHitBackEffectParam
  self._effectParamClassDict[SkillEffectType.ConvertGridElement] = SkillConvertGridElementEffectParam
  self._effectParamClassDict[SkillEffectType.AddBuff] = SkillAddBuffEffectParam
  self._effectParamClassDict[SkillEffectType.AddGridEffect] = SkillAddGridEffectParam
  self._effectParamClassDict[SkillEffectType.LeaveEnterBattleField] = SkillLeaveEnterBattleFieldEffectParam
  self._effectParamClassDict[SkillEffectType.Teleport] = SkillEffectParam_Teleport
  self._effectParamClassDict[SkillEffectType.Escape] = SkillEffectParam_Escape
  self._effectParamClassDict[SkillEffectType.AbsorbPiece] = SkillAbsorbPieceEffectParam
  self._effectParamClassDict[SkillEffectType.SummonTrap] = SkillSummonTrapEffectParam
  self._effectParamClassDict[SkillEffectType.Rotate] = SkillRotateEffectParam
  self._effectParamClassDict[SkillEffectType.PullAround] = SkillPullAroundEffectParam
  self._effectParamClassDict[SkillEffectType.SerialKiller] = SkillSerialKillerEffectParam
  self._effectParamClassDict[SkillEffectType.CalEdgePos] = SkillEffectParamCalEdgePos
  self._effectParamClassDict[SkillEffectType.StampDamage] = SkillEffectParam_StampDamage
  self._effectParamClassDict[SkillEffectType.EachGridAddBuff] = SkillEffectParamEachGridAddBuff
  self._effectParamClassDict[SkillEffectType.AddCollectDropNum] = SkillEffectParamAddCollectDropNum
  self._effectParamClassDict[SkillEffectType.DimensionTransport] = SkillEffectParam_DimensionTransport
  self._effectParamClassDict[SkillEffectType.AddDimensionFlag] = SkillEffectParam_AddDimensionFlag
  self._effectParamClassDict[SkillEffectType.AddBloodOverFlow] = SkillEffectParam_AddBloodOverFlow
  self._effectParamClassDict[SkillEffectType.CreateDestroyGrid] = SkillEffectParam_CreateDestroyGrid
  self._effectParamClassDict[SkillEffectType.RandAttack] = SkillEffectParam_RandAttack
  self._effectParamClassDict[SkillEffectType.ShowWarningArea] = SkillEffectParam_ShowWarningArea
  self._effectParamClassDict[SkillEffectType.SummonEverything] = SkillEffectParam_SummonEverything
  self._effectParamClassDict[SkillEffectType.AddBlood] = SkillEffectParam_AddBlood
  self._effectParamClassDict[SkillEffectType.EachGridAddBlood] = SkillEffectParamEachGridAddBlood
  self._effectParamClassDict[SkillEffectType.ResetGridElement] = SkillEffectParam_ResetGridElement
  self._effectParamClassDict[SkillEffectType.ConvertOccupiedGridElement] = SkillEffectConvertOccupiedGridElementParam
  self._effectParamClassDict[SkillEffectType.SummonMultipleTrap] = SkillEffectSummonMultipleTrapParam
  self._effectParamClassDict[SkillEffectType.Transport] = SkillEffectTransportParam
  self._effectParamClassDict[SkillEffectType.MultiTraction] = SkillEffectMultiTractionParam
  self._effectParamClassDict[SkillEffectType.SummonOnHitbackPosition] = SkillEffectSummonOnHitbackParam
  self._effectParamClassDict[SkillEffectType.MakePhantom] = SkillMakePhantomParam
  self._effectParamClassDict[SkillEffectType.AbsorbPhantom] = SkillAbsorbPhantomParam
  self._effectParamClassDict[SkillEffectType.Transformation] = SkillTransformationParam
  self._effectParamClassDict[SkillEffectType.SacrificeTrapsAndDamage] = SkillEffectSacrificeTrapsAndDamageParam
  self._effectParamClassDict[SkillEffectType.AddRoundCount] = SkillEffectParamAddRound
  self._effectParamClassDict[SkillEffectType.ResetSelectGridElement] = SkillEffectParam_ResetSelectGridElement
  self._effectParamClassDict[SkillEffectType.ModifyBuffValue] = SkillEffectParam_ModifyBuffValue
  self._effectParamClassDict[SkillEffectType.DamageOnTargetCount] = SkillEffectDamageOnTargetCountParam
  self._effectParamClassDict[SkillEffectType.DestroyTrap] = SkillEffectDestroyTrapParam
  self._effectParamClassDict[SkillEffectType.SplashDamage] = SkillEffectParamSplashDamage
  self._effectParamClassDict[SkillEffectType.AngleFreeLineDamage] = SkillEffectParamAngleFreeDamage
  self._effectParamClassDict[SkillEffectType.IslandConvert] = SkillEffectParamIslandConvert
  self._effectParamClassDict[SkillEffectType.EnhanceOccupiedGrid] = SkillEffectParamEnhanceOccupiedGrid
  self._effectParamClassDict[SkillEffectType.ResetSingleColorGridElement] = SkillEffectParamResetSingleColorGridElement
  self._effectParamClassDict[SkillEffectType.Suicide] = SkillEffectParamSuicide
  self._effectParamClassDict[SkillEffectType.CostCasterHP] = SkillEffectCostCasterHPParam
  self._effectParamClassDict[SkillEffectType.ExChangeGridColor] = SkillEffectExchangeGridColorParam
  self._effectParamClassDict[SkillEffectType.ChangeElement] = SkillEffectChangeElementParam
  self._effectParamClassDict[SkillEffectType.IsolateConvert] = SkillEffectParam_IsolateConvert
  self._effectParamClassDict[SkillEffectType.RandDamageSameHalf] = SkillEffectParamRandDamageSameHalf
  self._effectParamClassDict[SkillEffectType.DamageBasedOnTargetAttribute] = SkillDamageBasedOnTargetAttributeEffectParam
  self._effectParamClassDict[SkillEffectType.DamageBasedOnPickUpRect] = SkillDamageBasedOnPickUpRectEffectParam
  self._effectParamClassDict[SkillEffectType.AddComboNum] = SkillAddComboNumEffectParam
  self._effectParamClassDict[SkillEffectType.DeathBomb] = SkillEffectParamDeathBomb
  self._effectParamClassDict[SkillEffectType.ConductDamage] = SkillEffectParam_ConductDamage
  self._effectParamClassDict[SkillEffectType.AttachMonster] = SkillEffectAttachMonsterParam
  self._effectParamClassDict[SkillEffectType.DetachMonster] = SkillEffectDetachMonsterParam
  self._effectParamClassDict[SkillEffectType.MultipleScopesDealMultipleDamage] = SkillMultipleScopesDealMultipleDamageEffectParam
  self._effectParamClassDict[SkillEffectType.RotateToPickup] = SkillEffectParamRotateToPickup
  self._effectParamClassDict[SkillEffectType.HighFrequencyDamage] = SkillEffectParam_HighFrequencyDamage
  self._effectParamClassDict[SkillEffectType.ForceMovement] = SkillEffectParam_ForceMovement
  self._effectParamClassDict[SkillEffectType.ChangeBlockData] = SkillChangeBlockDataParam
  self._effectParamClassDict[SkillEffectType.ChangeGridPrism] = SkillChangeGridPrismParam
  self._effectParamClassDict[SkillEffectType.SchummerHitback] = SkillEffectParam_SchummerHitback
  self._effectParamClassDict[SkillEffectType.StickerLeave] = SkillEffectParam_StickerLeave
  self._effectParamClassDict[SkillEffectType.GridPurify] = SkillEffectParam_GridPurify
  self._effectParamClassDict[SkillEffectType.DegressiveDirectionalDamage] = SkillEffectParam_DegressiveDirectionalDamage
  self._effectParamClassDict[SkillEffectType.ConvertWithTrapRecord] = SkillEffectParamConvertWithTrapRecord
  self._effectParamClassDict[SkillEffectType.FrontExtendDegressiveDamage] = SkillEffectParamFrontExtendDegressiveDamage
  self._effectParamClassDict[SkillEffectType.TeleportAndSummonTrap] = SkillEffectParamTeleportAndSummonTrap
  self._effectParamClassDict[SkillEffectType.MarkGridInScope] = SkillEffectParam_MarkGridInScope
  self._effectParamClassDict[SkillEffectType.ChangeBuffLayer] = SkillEffectParamChangeBuffLayer
  self._effectParamClassDict[SkillEffectType.SummonMeantimeLimit] = SkillEffectParamSummonMeantimeLimit
  self._effectParamClassDict[SkillEffectType.MoveTrap] = SkillEffectParamMoveTrap
  self._effectParamClassDict[SkillEffectType.MultipleDamageWithBuffLayer] = SkillEffectParamMultipleDamageWithBuffLayer
  self._effectParamClassDict[SkillEffectType.DestroyMonster] = SkillEffectDestroyMonsterParam
  self._effectParamClassDict[SkillEffectType.SealedCurse] = SkillEffectParam_SealedCurse
  self._effectParamClassDict[SkillEffectType.DamageReflectDistance] = SkillEffectParam_DamageReflectDistance
  self._effectParamClassDict[SkillEffectType.MonsterMoveGrid] = SkillEffectMonsterMoveGridParam
  self._effectParamClassDict[SkillEffectType.KillPlayer] = SkillEffectKillPlayerParam
  self._effectParamClassDict[SkillEffectType.DamageOnTargetDistance] = SkillDamageOnTargetDistanceEffectParam
  self._effectParamClassDict[SkillEffectType.AddBloodOverFlowForDamage] = SkillEffectParam_AddBloodOverFlowForDamage
  self._effectParamClassDict[SkillEffectType.DamageBasedOnSectorAngle] = SkillEffectParam_DamageBasedOnSectorAngle
  self._effectParamClassDict[SkillEffectType.SplashPreDamage] = SkillEffectParamSplashPreDamage
  self._effectParamClassDict[SkillEffectType.RotateByPickSector] = SkillEffectParamRotateByPickSector
  self._effectParamClassDict[SkillEffectType.SummonOnFixPosLimit] = SkillEffectParamSummonOnFixPosLimit
  self._effectParamClassDict[SkillEffectType.SwitchBodyPart] = SkillEffectParamSwitchBodyPart
  self._effectParamClassDict[SkillEffectType.ChangePetTeamOrder] = SkillEffectParam_ChangePetTeamOrder
  self._effectParamClassDict[SkillEffectType.ShufflePetTeamOrder] = SkillEffectParam_ShuffleTeamOrder
  self._effectParamClassDict[SkillEffectType.SwapPetTeamOrder] = SkillEffectParam_SwapPetTeamOrder
  self._effectParamClassDict[SkillEffectType.VictoriaSuckBlood] = SkillEffectParam_VictoriaSuckBlood
  self._effectParamClassDict[SkillEffectType.GatherThrowDamage] = SkillEffectParam_GatherThrowDamage
  self._effectParamClassDict[SkillEffectType.TriggerTrap] = SkillEffectParamTriggerTrap
  self._effectParamClassDict[SkillEffectType.AbsorbTrapsAndDamageByPickupTarget] = SkillEffectAbsorbTrapsAndDamageByPickupTargetParam
  self._effectParamClassDict[SkillEffectType.MoveBoard] = SkillEffectParamMoveBoard
  self._effectParamClassDict[SkillEffectType.MonsterMoveGridByMonsterElement] = SkillEffectMonsterMoveGridByElementParam
  self._effectParamClassDict[SkillEffectType.EachTrapAddBlood] = SkillEffectParamEachTrapAddBlood
  self._effectParamClassDict[SkillEffectType.AddBuffByPickupTarget] = SkillEffectAddBuffByPickupTargetParam
  self._effectParamClassDict[SkillEffectType.SwitchBodyAreaByTargetPos] = SkillEffectSwitchBodyAreaByTargetPosParam
  self._effectParamClassDict[SkillEffectType.RecoverFromGreyHP] = SkillEffectParam_RecoverFromGreyHP
  self._effectParamClassDict[SkillEffectType.DecreaseSanByScope] = SkillEffectParam_DecreaseSanByScope
  self._effectParamClassDict[SkillEffectType.SingleGridFullDamage] = SkillEffectParam_SingleGridFullDamage
  self._effectParamClassDict[SkillEffectType.IncreaseSan] = SkillEffectParam_IncreaseSan
  self._effectParamClassDict[SkillEffectType.TransferTarget] = SkillEffectTransferTargetParam
  self._effectParamClassDict[SkillEffectType.MonsterMoveGridToSkillRangeFar] = SkillEffectMonsterMoveGridToSkillRangeFar
  self._effectParamClassDict[SkillEffectType.MonsterMoveLongestGrid] = SkillEffectMonsterMoveLongestGridParam
  self._effectParamClassDict[SkillEffectType.SacrificeTraps] = SkillEffectSacrificeTrapsParam
  self._effectParamClassDict[SkillEffectType.DamageBySacrificeTraps] = SkillEffectDamageBySacrificeTrapsParam
  self._effectParamClassDict[SkillEffectType.AlphaThrowTrap] = SkillEffectAlphaThrowTrapParam
  self._effectParamClassDict[SkillEffectType.AlphaBlinkAttack] = SkillEffectAlphaBlinkAttackParam
  self._effectParamClassDict[SkillEffectType.RideOn] = SkillEffectRideOnParam
  self._effectParamClassDict[SkillEffectType.DamageSamePosReduce] = SkillEffectParamDamageSamePosReduce
  self._effectParamClassDict[SkillEffectType.MultiplyBuffLayer] = SkillEffectParam_MultiplyBuffLayer
  self._effectParamClassDict[SkillEffectType.MonsterMoveGridFarthest] = SkillEffectParam_MonsterMoveGridFarthest
  self._effectParamClassDict[SkillEffectType.RubikCube] = SkillEffectParamRubikCube
  self._effectParamClassDict[SkillEffectType.ChangeBodyArea] = SkillEffectParamChangeBodyArea
  self._effectParamClassDict[SkillEffectType.TrapSummonMonster] = SkillEffectTrapSummonMonsterParam
  self._effectParamClassDict[SkillEffectType.DrawCard] = SkillEffectParamDrawCard
  self._effectParamClassDict[SkillEffectType.MonsterMoveFrontAttack] = SkillEffectParamMonsterMoveFrontAttack
  self._effectParamClassDict[SkillEffectType.PickUpTrapAndBuffDamage] = SkillEffectParamPickUpTrapAndBuffDamage
  self._effectParamClassDict[SkillEffectType.AddBuffByPickupBuffLayer] = SkillEffectParamAddBuffByPickupBuffLayer
  self._effectParamClassDict[SkillEffectType.DamageTargetCanRepeat] = SkillDamageCanRepeatEffectParam
  self._effectParamClassDict[SkillEffectType.LevelTrapAbsortSummon] = SkillEffectParamLevelTrapAbsortSummon
  self._effectParamClassDict[SkillEffectType.LevelTrapUpLevel] = SkillEffectParamLevelTrapUpLevel
  self._effectParamClassDict[SkillEffectType.LevelTrapSummonOrUpLevel] = SkillEffectParamLevelTrapSummonOrUpLevel
  self._effectParamClassDict[SkillEffectType.TransportByRange] = SkillEffectParamTransportByRange
  self._effectParamClassDict[SkillEffectType.ModifyAntiAttackParam] = SkillEffectParamModifyAntiAttackParam
  self._effectParamClassDict[SkillEffectType.RandomCountDamageSameHalf] = SkillEffectParamRandomCountDamageSameHalf
  self._effectParamClassDict[SkillEffectType.PetSacrificeSuperGridTraps] = SkillEffectPetSacrificeSuperGridTrapsParam
  self._effectParamClassDict[SkillEffectType.PetMinosGhostDamage] = SkillEffectPetMinosGhostDamageParam
  self._effectParamClassDict[SkillEffectType.CoffinMusumeCandle] = SkillEffectParam_CoffinMusumeCandle
  self._effectParamClassDict[SkillEffectType.DamageAndAddBuffByHitBack] = SkillEffectDamageAndAddBuffByHitBackParam
  self._effectParamClassDict[SkillEffectType.CoffinMusumeSetCandleLight] = SkillEffectParam_CoffinMusumeSetCandleLight
  self._effectParamClassDict[SkillEffectType.Transposition] = SkillEffectParamTransposition
  self._effectParamClassDict[SkillEffectType.SummonScanTrap] = SkillEffectParam_SummonScanTrap
  self._effectParamClassDict[SkillEffectType.SnakeBodyMoveAndGrowth] = SkillEffectParamSnakeBodyMoveAndGrowth
  self._effectParamClassDict[SkillEffectType.SnakeTailMove] = SkillEffectParamSnakeTailMove
  self._effectParamClassDict[SkillEffectType.SnakeHeadMove] = SkillEffectParamSnakeHeadMove
  self._effectParamClassDict[SkillEffectType.SummonTrapByCasterPos] = SkillEffectParamSummonTrapByCasterPos
  self._effectParamClassDict[SkillEffectType.SummonTrapOrHealByTrapBuffLayer] = SkillEffectParam_SummonTrapOrHealByTrapBuffLayer
  self._effectParamClassDict[SkillEffectType.KillTargets] = SkillEffectParamKillTargets
  self._effectParamClassDict[SkillEffectType.WeikeNotify] = SkillEffectParam_WeikeNotify
  self._effectParamClassDict[SkillEffectType.SetMonsterOffBoard] = SkillEffectParamSetMonsterOffBoard
  self._effectParamClassDict[SkillEffectType.MonsterMoveGridByParam] = SkillEffectParam_MonsterMoveGridByParam
  self._effectParamClassDict[SkillEffectType.SplashDamageAndAddBuff] = SkillEffectParamSplashDamageAndAddBuff
  self._effectParamClassDict[SkillEffectType.DynamicCenterDamage] = SkillEffectParam_DynamicCenterDamage
  self._effectParamClassDict[SkillEffectType.EnterMirage] = SkillEffectEnterMirageParam
  self._effectParamClassDict[SkillEffectType.TrapMoveAndDamage] = SkillEffectTrapMoveAndDamageParam
  self._effectParamClassDict[SkillEffectType.AddMoveScopeRecordCmpt] = SkillEffectParam_AddMoveScopeRecordCmpt
  self._effectParamClassDict[SkillEffectType.ThrowMonsterAndDamage] = SkillEffectThrowMonsterAndDamageParam
  self._effectParamClassDict[SkillEffectType.DamageByBuffLayer] = SkillEffectDamageByBuffLayerParam
  self._effectParamClassDict[SkillEffectType.TeleportTeamAroundAndSummonTrapLine] = SkillEffectParamTeleportTeamAroundAndSummonTrapLine
  self._effectParamClassDict[SkillEffectType.TurnToTargetChangeBodyAreaAndDir] = SkillEffectParamTurnToTargetChangeBodyAreaAndDir
  self._effectParamClassDict[SkillEffectType.ControlMonsterMove] = SkillEffectParamControlMonsterMove
  self._effectParamClassDict[SkillEffectType.ConvertAndDamageByLinkLine] = SkillEffectConvertAndDamageByLinkLineParam
  self._effectParamClassDict[SkillEffectType.PetTrapMove] = SkillEffectParamPetTrapMove
  self._effectParamClassDict[SkillEffectType.SacrificeTargetNearestTrapsAndDamage] = SkillEffectSacrificeTargetNearestTrapsAndDamageParam
  self._effectParamClassDict[SkillEffectType.DynamicScopeChainDamage] = SkillEffectParam_DynamicScopeChainDamage
  self._effectParamClassDict[SkillEffectType.NightKingTeleportPathDamage] = SkillEffectParamNightKingTeleportPathDamage
  self._effectParamClassDict[SkillEffectType.RefreshGridByBoardID] = SkillEffectRefreshGridByBoardIDParam
  self._effectParamClassDict[SkillEffectType.SpliceBoard] = SkillEffectParamSpliceBoard
  self._effectParamClassDict[SkillEffectType.DamageBySelectPieceCount] = SkillEffectParamDamageBySelectPieceCount
  self._effectParamClassDict[SkillEffectType.HighFrequencyDamage2] = SkillEffectParam_HighFrequencyDamage2
  self._effectParamClassDict[SkillEffectType.PopStar] = SkillEffectPopStarParam
  self._effectParamClassDict[SkillEffectType.SummonFourAreaMonsterOnBoardEdge] = SkillEffectParamSummonFourAreaMonsterOnBoardEdge
  self._effectParamClassDict[SkillEffectType.PickUpGridTogether] = SkillEffectParam_PickUpGridTogether
  self._effectParamClassDict[SkillEffectType.ButterflySummon] = SkillEffectParam_ButterflySummon
  self._effectParamClassDict[SkillEffectType.TankRushPerGrid] = SkillEffectParam_TankRushPerGrid
  self._effectParamClassDict[SkillEffectType.DamageByConvertGridCount] = SkillEffectParamByConvertGridCount
  self._effectParamClassDict[SkillEffectType.DamageCountByBuffLayer] = SkillEffectDamageCountByBuffLayerParam
  self._effectParamClassDict[SkillEffectType.DamageCountByBuffLayer2] = SkillEffectDamageCountByBuffLayer2Param
  self._effectParamClassDict[SkillEffectType.ControlMonsterCastHitBackTeam] = SkillEffectParamControlMonsterCastHitBackTeam
  self._effectParamClassDict[SkillEffectType.SummonMonster] = SkillEffectParam_SummonMonster
  self._effectParamClassDict[SkillEffectType.PushBoard] = SkillEffectPushBoardParam
  self._effectParamClassDict[SkillEffectType.MarchForward] = SkillEffectMarchForwardParam
  self._effectParamClassDict[SkillEffectType.Puzzle] = SkillEffectPuzzleParam
  self._effectParamClassDict[SkillEffectType.HitBackAndDamage] = SkillEffectHitBackAndDamageParam
  self._effectParamClassDict[SkillEffectType.TeleportAndTurnBodyArea] = SkillEffectParam_TeleportAndTurnBodyArea
  self._effectParamClassDict[SkillEffectType.FixTrapWall] = SkillEffectParamFixTrapWall
  self._effectParamClassDict[SkillEffectType.SetGridMaintainColorForSupply] = SkillEffectParamSetGridMaintainColorForSupply
  self._effectParamClassDict[SkillEffectType.CreateAurasTrapByPickUp] = SkillCreateAurasTrapByPickUpEffectParam
  self._effectParamClassDict[SkillEffectType.CrabMoveAndAttack] = SkillEffectParamCrabMoveAndAttack
  self._effectParamClassDict[SkillEffectType.AppointCastChain] = SkillEffectParamAppointChain
  self._effectParamClassDict[SkillEffectType.Switch2GridTrap] = SkillEffectParamSwitch2GridTrap
  self._effectParamClassDict[SkillEffectType.SkillCostFeatureStepPoint] = SkillEffectParam_SkillCostFeatureStepPoint
  self._effectParamClassDict[SkillEffectType.AddMonsterWeak] = SkillEffectParamAddMonsterWeak
  self._effectParamClassDict[SkillEffectType.DetonateMonsterWeak] = SkillEffectParamDetonateMonsterWeak
  self._effectParamClassDict[SkillEffectType.TransferMonsterWeak] = SkillEffectParamTransferMonsterWeak
  self._effectParamClassDict[SkillEffectType.ClingySummon] = SkillEffectParamClingySummon
  self._effectParamClassDict[SkillEffectType.TeleportAndReplaceBodyArea] = SkillEffectParam_TeleportAndReplaceBodyArea
  self._effectParamClassDict[SkillEffectType.DamageAfterHitBack] = SkillEffectParamDamageAfterHitBack
  self._effectParamClassDict[SkillEffectType.PetAbsorbMaintainColorGrid] = SkillEffectPetAbsorbMaintainColorGridParam
  self._effectParamClassDict[SkillEffectType.ColorPaletteCharge] = SkillEffectParamColorPaletteCharge
  self._effectParamClassDict[SkillEffectType.RobotBomb] = SkillEffectParamRobotBomb
  self._effectParamClassDict[SkillEffectType.ScorpionSummon] = SkillEffectParamScorpionSummon
  self._effectParamClassDict[SkillEffectType.ScorpionHitBack] = SkillEffectParamScorpionHitBack
  self._effectParamClassDict[SkillEffectType.ChangeSanMax] = SkillEffectParamChangeSanMax
  self._effectParamClassDict[SkillEffectType.SwapSan2TeamHp] = SkillEffectParamSwapSan2TeamHp
  self._effectParamClassDict[SkillEffectType.SummonWithCasterAttribute] = SkillEffectParamSummonWithCasterAttribute
  self._effectParamClassDict[SkillEffectType.SummonTrapByTargetPos] = SkillEffectParamSummonTrapByTargetPos
  self._effectParamClassDict[SkillEffectType.MoyeMove] = SkillEffectParamMoyeMove
  self._effectParamClassDict[SkillEffectType.ControlMonsterTeleportAndAttack] = SkillEffectParamControlMonsterTeleportAndAttack
end

function SkillEffectParamParser:ParseSkillEffectList(effect_table, petId, skillType, grade, awaking)
  local effectParamList = {}
  local effectIndexList = {}
  for k, v in pairs(effect_table) do
    effectIndexList[#effectIndexList + 1] = k
  end
  table.sort(effectIndexList)
  for _, v in ipairs(effectIndexList) do
    local effectParam = effect_table[v]
    local effectType = effectParam.effectType
    local classType = self._effectParamClassDict[effectType]
    if classType == nil then
      Log.exception("ParseSkillEffectList cant find effectype ", effectType)
      return effectParamList
    end
    local paramDataObj = classType:New(effectParam, petId, #effectParamList + 1, skillType, grade, awaking)
    effectParamList[#effectParamList + 1] = paramDataObj
  end
  return effectParamList
end

function SkillEffectParamParser:ParseSkillEffectParam(effectType, effectParam, petId, effectIndex, skillType, grade, awaking)
  local classType = self._effectParamClassDict[effectType]
  if classType == nil then
    Log.error("ParseSkillEffectParam cant find effectype ", effectType)
  end
  local paramDataObj = classType:New(effectParam, petId, effectIndex, skillType, grade, awaking)
  return paramDataObj
end
