_class("L2RService_Server", BaseService)
L2RService_Server = L2RService_Server

function L2RService_Server:L2RBoardLogicData()
end

function L2RService_Server:L2RSyncPieceType()
end

function L2RService_Server:L2RLoadingData()
end

function L2RService_Server:L2RNormalAttackData(normalSkillCalcor, teamEntity)
end

function L2RService_Server:L2RChainAttackData(teamEntity)
end

function L2RService_Server:L2RActiveAttackData(casterEntity, skillID)
end

function L2RService_Server:L2RFeatureAttackData(casterEntity)
end

function L2RService_Server:L2RAILogicData()
end

function L2RService_Server:L2ROneSkillData(casterEntity, key)
end

function L2RService_Server:L2RChainPathData(teamEntity)
end

function L2RService_Server:L2RChessPathData()
end

function L2RService_Server:L2RChessAttackData(casterEntity)
end

function L2RService_Server:L2RSanRoundDecrease(curVal, oldVal, delVal)
end

function L2RService_Server:L2RDayNightRoundChange(curState, oldState, restRound)
end

function L2RService_Server:L2RSyncMoveData(entityID, syncMovePath)
end

function L2RService_Server:L2RAddPartnerData(partnerID, petInfo, matchPet, petRes, hp, maxHP)
end

function L2RService_Server:L2RAddRelicData(relicID, buffSeqs)
end

function L2RService_Server:L2RNTSelectRoundTeamNormalBefore()
end

function L2RService_Server:L2RMirageWalkData(mirageWalkRes)
end

function L2RService_Server:L2RMirageWarningData(warningPosList)
end

function L2RService_Server:L2RPickUpComponentData(entityID, pickUpGridList, directionPickupData, reflectDir, pickUpExtraParam)
end

function L2RService_Server:L2RStepPointRoundChange(curVal, oldVal)
end

function L2RService_Server:L2RStepPointMoveCost(curVal, oldVal)
end

function L2RService_Server:L2RAutoBeadkSkillData(teamEntity)
end

function L2RService_Server:L2RSyncColorPaletteData(entityID)
end
