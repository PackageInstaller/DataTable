require("pick_up_policy_base")
_class("PickUpPolicy_PetBatiya", PickUpPolicy_Base)
PickUpPolicy_PetBatiya = PickUpPolicy_PetBatiya

function PickUpPolicy_PetBatiya:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local needLock = policyParam.needLock or false
  local targetPieceType = policyParam.targetPieceType or PieceType.Red
  local casterPos = petEntity:GridLocation().Position
  local curBodyArea = petEntity:BodyArea():GetArea()
  if needLock then
    local featureSvcL = self._world:GetService("FeatureLogic")
    local data = featureSvcL:GetFeatureData(FeatureType.TetrisGame)
    local maxMainColorCount = data:GetMainColorMaxCount()
    local tetrisIndex, tetrisLock, tetrisPower, tetrisMainColorCount, tetrisCostPower = FeatureServiceHelper.GetFeatureTetrisInfo()
    if not tetrisLock then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UITetrisOP, TetrisFeatureCmdOPType.Lock, true)
      YIELD(calcParam.TT, 200)
    end
    while tetrisCostPower <= tetrisPower and maxMainColorCount > tetrisMainColorCount do
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UITetrisOP, TetrisFeatureCmdOPType.ReRoll)
      YIELD(calcParam.TT, 200)
      tetrisIndex, tetrisLock, tetrisPower, tetrisMainColorCount, tetrisCostPower = FeatureServiceHelper.GetFeatureTetrisInfo()
    end
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local playerBodyArea = petEntity:BodyArea():GetArea()
  local casterDir = petEntity:GridLocation():GetGridDir()
  local targetType = skillConfigData:GetSkillTargetType()
  local tmpResult = scopeCalculator:ComputeScopeRange(SkillScopeType.FullScreen, scopeParam, casterPos, playerBodyArea, casterDir, targetType, casterPos, petEntity)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetIds = targetSelector:DoSelectSkillTarget(petEntity, SkillTargetType.NearestMonster, tmpResult, activeSkillID)
  local targetEntity = self._world:GetEntityByID(targetIds[1])
  local targetPos = targetEntity:GridLocation().Position
  local targetRing2 = ComputeScopeRange.ComputeRange_SquareRing(casterPos, 1, 2)
  local utilDataSvc = self._world:GetService("UtilData")
  local maxCount = -1
  local pickUPPos
  for i, pos in ipairs(targetRing2) do
    local centerPos = pos
    local result = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, centerPos, playerBodyArea, casterDir, targetType, casterPos, petEntity)
    local coverCount = 0
    local range = result:GetAttackRange()
    for _, rangePos in ipairs(range) do
      if not utilDataSvc:IsPosBlock(rangePos, BlockFlag.ChangeElement) and utilDataSvc:FindPieceElement(rangePos) ~= targetPieceType then
        coverCount = coverCount + 1
      end
    end
    if maxCount < coverCount then
      maxCount = coverCount
      pickUPPos = pos
    end
  end
  return {pickUPPos}, {pickUPPos}, targetIds
end
