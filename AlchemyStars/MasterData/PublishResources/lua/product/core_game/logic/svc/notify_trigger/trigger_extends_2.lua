_class("TTRoundFirstActiveSkill", TriggerBase)
TTRoundFirstActiveSkill = TTRoundFirstActiveSkill

function TTRoundFirstActiveSkill:IsSatisfied(notify)
  local attacker = notify:GetAttackerEntity()
  local petPstID = attacker:PetPstID():GetPstID()
  local battleStatComponent = self._world:BattleStat()
  local curRound = battleStatComponent:GetLevelTotalRoundCount()
  local curRoundRecord = battleStatComponent:GetPetDoActiveSkillRecord(petPstID, curRound)
  if not curRoundRecord or #curRoundRecord == 1 then
    return true
  end
  return false
end

_class("TTPetSex", TriggerBase)
TTPetSex = TTPetSex

function TTPetSex:IsSatisfied()
  local battleSvc = self._world:GetService("Battle")
  local owner = self:GetOwnerEntity()
  local petSexType = battleSvc:GetPetSexType(owner)
  return self._x == petSexType
end

_class("TTPetSexUpAndDown", TriggerBase)
TTPetSexUpAndDown = TTPetSexUpAndDown

function TTPetSexUpAndDown:IsSatisfied(notify)
  local battleSvc = self._world:GetService("Battle")
  local owner = self:GetOwnerEntity()
  local ownerPetPstID = owner:PetPstID():GetPstID()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamCmpt = teamEntity:Team()
  local teamOrder = teamCmpt:GetTeamOrder()
  if #teamOrder < 3 or ownerPetPstID == teamOrder[1] or ownerPetPstID == teamOrder[#teamOrder] then
    return false
  end
  local ownerIndex = teamCmpt:GetTeamIndexByPetPstID(ownerPetPstID)
  local upPet = teamCmpt:GetPetEntityByTeamIndex(ownerIndex - 1)
  local downPet = teamCmpt:GetPetEntityByTeamIndex(ownerIndex + 1)
  return battleSvc:GetPetSexType(upPet) == self._x and battleSvc:GetPetSexType(downPet) == self._x
end

_class("TTAllMonsterHaveCampType", TriggerBase)
TTAllMonsterHaveCampType = TTAllMonsterHaveCampType

function TTAllMonsterHaveCampType:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local onwerID = owner:GetID()
  local battleSvc = self._world:GetService("Battle")
  local MonsterEntityArray = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local liveCount = 0
  for k, entity in ipairs(MonsterEntityArray) do
    if not entity:HasDeadMark() and entity:GetID() ~= onwerID and table.icontains(self._param, entity:MonsterID():GetCampType()) then
      return true
    end
  end
  return false
end

_class("TTAllMonsterNotHaveCampType", TriggerBase)
TTAllMonsterNotHaveCampType = TTAllMonsterNotHaveCampType

function TTAllMonsterNotHaveCampType:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local onwerID = owner:GetID()
  local battleSvc = self._world:GetService("Battle")
  local MonsterEntityArray = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local liveCount = 0
  for k, entity in ipairs(MonsterEntityArray) do
    if not entity:HasDeadMark() and entity:GetID() ~= onwerID and table.icontains(self._param, entity:MonsterID():GetCampType()) then
      return false
    end
  end
  return true
end

_class("TTCheckConvertGridSkillType", TriggerBase)
TTCheckConvertGridSkillType = TTCheckConvertGridSkillType

function TTCheckConvertGridSkillType:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.GridConvert then
    return false
  end
  if not notify:GetSkillType() or notify:GetSkillType() == nil then
    return false
  end
  return table.icontains(self._param, notify:GetSkillType())
end

_class("TTCheckConvertGridHasGridType", TriggerBase)
TTCheckConvertGridHasGridType = TTCheckConvertGridHasGridType

function TTCheckConvertGridHasGridType:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.GridConvert then
    return false
  end
  local convertInfoList = notify:GetConvertInfoArray()
  for i, v in ipairs(convertInfoList) do
    local pieceType = v:GetAfterPieceType()
    if table.icontains(self._param, pieceType) then
      return true
    end
  end
  return false
end

_class("TTNotifyMeOrSuperMe", TriggerBase)
TTNotifyMeOrSuperMe = TTNotifyMeOrSuperMe

function TTNotifyMeOrSuperMe:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  if entity:HasSuperEntity() then
    local super = entity:GetSuperEntity()
    return super:GetID() == owner:GetID()
  else
    return owner:GetID() == entity:GetID()
  end
end

_class("TTMultiHPStage", TriggerBase)
TTMultiHPStage = TTMultiHPStage

function TTMultiHPStage:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.MultiHPSwitch then
    return false
  end
  return notify:GetMultiHPStage() == self._x
end

_class("TTCompareComboCount", TriggerBase)
TTCompareComboCount = TTCompareComboCount

function TTCompareComboCount:IsSatisfied(notify)
  local battleSvc = self._world:GetService("Battle")
  local comboNum = battleSvc:GetLogicComboNum()
  local comboExpect = self:GetTriggerParamByIndex(1)
  local compareFlag = self:GetTriggerParamByIndex(2)
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = comboNum == comboExpect
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = comboNum ~= comboExpect
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = comboNum > comboExpect
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = comboNum >= comboExpect
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = comboNum < comboExpect
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = comboNum <= comboExpect
  end
  return satisfied
end

_class("TTUnscaledCountDownIsFinish", TriggerBase)
TTUnscaledCountDownIsFinish = TTUnscaledCountDownIsFinish

function TTUnscaledCountDownIsFinish:IsSatisfied(notify)
  local flagID = self:GetTriggerParamByIndex(1)
  local group = self._world:GetGroupEntities(self._world.BW_WEMatchers.UnscaledCountDownLogic)
  for k, entity in ipairs(group) do
    local cmpt = entity:UnscaledCountDownLogic()
    if cmpt:GetFlagID() == flagID then
      local isActive = cmpt:GetIsActive()
      local isWaitTrigger = cmpt:GetIsWaitTrigger()
      if isActive and isWaitTrigger then
        return true
      end
      break
    end
  end
  return false
end

_class("TTHitBackEdge", TriggerBase)
TTHitBackEdge = TTHitBackEdge

function TTHitBackEdge:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.HitBackEnd then
    return false
  end
  local hitbackDir = notify:GetHitBackDir()
  local defenderID = notify:GetDefenderId()
  local defendeEntity = self._world:GetEntityByID(defenderID)
  local bodyArea = defendeEntity:BodyArea():GetArea()
  local startPos = notify:GetPosStart()
  local endPos = notify:GetPosEnd()
  local boardSvc = self._world:GetService("BoardLogic")
  local isEdge = false
  for _, body in ipairs(bodyArea) do
    local bodyPos = endPos + body
    if not boardSvc:IsValidPiecePos(Vector2(bodyPos.x + hitbackDir.x, bodyPos.y + hitbackDir.y)) then
      isEdge = true
      break
    end
  end
  if startPos == endPos then
    if isEdge and self._x == 1 then
      return true
    else
      return false
    end
  end
  return isEdge
end

_class("TTComparePopGridCount", TriggerBase)
TTComparePopGridCount = TTComparePopGridCount

function TTComparePopGridCount:IsSatisfied(notify)
  local popStarSvc = self._world:GetService("PopStarProLogic")
  local popNum = popStarSvc:GetLastPopGridNum()
  local modifyCount
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local buffComp = teamEntity:BuffComponent()
  local keyVal = buffComp:GetBuffValue(PopStarConst.ModifyPopGridCountKey)
  if keyVal then
    modifyCount = keyVal
  end
  local popMin = self:GetTriggerParamByIndex(1)
  local popMax = self:GetTriggerParamByIndex(2)
  local level = self:GetTriggerParamByIndex(3)
  if modifyCount and level and modifyCount[level] then
    popMin = popMin + modifyCount[level]
    popMax = popMax + modifyCount[level]
    if popMin < 0 then
      popMin = 0
    end
    if popMax < 0 then
      popMax = 0
    end
  end
  if popNum >= popMin and popNum < popMax then
    return true
  end
  return false
end

_class("TTRealOwnerGridPosChange", TriggerBase)
TTRealOwnerGridPosChange = TTRealOwnerGridPosChange

function TTRealOwnerGridPosChange:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pos
  if notify:GetNotifyType() == NotifyType.Teleport then
    pos = notify:GetPosNew()
    local oldPos = notify:GetPosOld()
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:GetID() == ownerEntity:GetID() and pos ~= oldPos then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.HitBackEnd then
    pos = notify:GetPosEnd()
    local oldPos = notify:GetPosStart()
    local defenderID = notify:GetDefenderId()
    if defenderID == ownerEntity:GetID() and pos ~= oldPos then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.TractionEnd then
    pos = notify:GetPosEnd()
    local oldPos = notify:GetPosStart()
    local defenderID = notify:GetDefenderId()
    if defenderID == ownerEntity:GetID() and pos ~= oldPos then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.ForceMovement then
    pos = notify:GetPosNew()
    local oldPos = notify:GetPosOld()
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:GetID() == ownerEntity:GetID() and pos ~= oldPos then
      return true
    end
  end
  return false
end

_class("TTCumulativeTriggerByPopNum", TriggerCount)
TTCumulativeTriggerByPopNum = TTCumulativeTriggerByPopNum

function TTCumulativeTriggerByPopNum:OnNotify(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarScoreChange then
    return
  end
  local changeNum = notify:GetPopChangeNum() or 0
  self:AddCount(changeNum)
end

function TTCumulativeTriggerByPopNum:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarScoreChange then
    return false
  end
  local expectNum = self:GetTriggerParamByIndex(1)
  local satisfied = expectNum <= self._count
  if satisfied then
    local count = math.fmod(self._count, expectNum)
    local cumulativeNum = math.floor(self._count / expectNum)
    self:SetCount(count)
    notify:SetCumulativeTriggerNum(cumulativeNum)
  end
  return satisfied
end

_class("TTMyPosInAuraRange", TriggerBase)
TTMyPosInAuraRange = TTMyPosInAuraRange

function TTMyPosInAuraRange:IsSatisfied(notify)
  local auraGroupID = self._param[1]
  local layerCount = self._param[2]
  local inSide = self._param[3] or 1
  local compareType = self._param[4] or 1
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasDeadMark() then
    return false
  end
  local posSelf = ownerEntity:GridLocation():GetGridPos()
  local bodyArea = ownerEntity:BodyArea():GetArea()
  local curMovePos = posSelf
  local battleSvc = self._world:GetService("Battle")
  local match = false
  for _, value in ipairs(bodyArea) do
    local newPos = curMovePos + value
    local count = battleSvc:GetAuraSuperposedCount(auraGroupID, newPos)
    count = count or -1
    if compareType == 1 then
      if layerCount <= count then
        match = true
        break
      end
    elseif compareType == 0 and count == layerCount then
      match = true
      break
    end
  end
  if inSide == 1 then
    return match
  elseif inSide == 0 then
    return not match
  end
  return false
end

_class("TTNotPetNotify", TriggerBase)
TTNotPetNotify = TTNotPetNotify

function TTNotPetNotify:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity then
    return true
  end
  if notifyEntity:PetPstID() then
    return false
  end
  if notifyEntity:HasSuperEntity() and notifyEntity:EntityType():IsSkillHolder() then
    return not notifyEntity:GetSuperEntity():HasPetPstID()
  end
  return true
end

_class("TTOwnerIsDead", TriggerBase)
TTOwnerIsDead = TTOwnerIsDead

function TTOwnerIsDead:IsSatisfied()
  local owner = self:GetOwnerEntity()
  local param = self._x
  if param == 1 then
    return not owner:HasDeadMark()
  else
    return owner:HasDeadMark()
  end
end

_class("TTCumulativeTriggerByOwnerCostHP", TriggerCount)
TTCumulativeTriggerByOwnerCostHP = TTCumulativeTriggerByOwnerCostHP

function TTCumulativeTriggerByOwnerCostHP:OnNotify(notify)
  if notify:GetNotifyType() ~= NotifyType.MonsterHPCChange then
    return
  end
  local owner = self:GetOwnerEntity()
  local onwerID = owner:GetID()
  local notifyEntity = notify:GetNotifyEntity()
  local notifyEntityID = 0
  if notifyEntity then
    notifyEntityID = notifyEntity:GetID()
  end
  if onwerID ~= notifyEntityID then
    return
  end
  local changeNum = 0
  local notifyChangeHP = notify:GetChangeHP()
  if notifyChangeHP and notifyChangeHP < 0 then
    changeNum = notifyChangeHP * -1
    changeNum = math.floor(changeNum)
  end
  self:AddCount(changeNum)
end

function TTCumulativeTriggerByOwnerCostHP:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.MonsterHPCChange then
    return false
  end
  local owner = self:GetOwnerEntity()
  local expectNum = self:GetTriggerParamByIndex(1)
  local recordKey = self:GetTriggerParamByIndex(2)
  local usePercent = self:GetTriggerParamByIndex(3)
  if usePercent and usePercent == 1 and owner then
    local attrCmpt = owner:Attributes()
    if attrCmpt then
      local maxHP = attrCmpt:CalcMaxHp()
      if 0 < maxHP then
        expectNum = math.floor(maxHP * expectNum)
      end
    end
  end
  local satisfied = expectNum <= self._count
  if satisfied then
    local count = math.fmod(self._count, expectNum)
    local cumulativeNum = math.floor(self._count / expectNum)
    self:SetCount(count)
    local key = recordKey
    notify:SetCumulativeTriggerNum(cumulativeNum, key)
  end
  return satisfied
end

_class("TTCheckNotifyPosHasTargetTrap", TriggerBase)
TTCheckNotifyPosHasTargetTrap = TTCheckNotifyPosHasTargetTrap

function TTCheckNotifyPosHasTargetTrap:IsSatisfied(notify)
  local trapID = self._param[1]
  local checkHas = self._param[2] or 0
  local ownerEntity = self:GetOwnerEntity()
  local checkPosList = {
    ownerEntity:GetGridPosition()
  }
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    checkPosList = notify:GetCreateTrapGrids()
  end
  for _, checkPos in ipairs(checkPosList) do
    local boardCmpt = self._world:GetBoardEntity():Board()
    local es = boardCmpt:GetPieceEntities(checkPos, function(e)
      return e:HasTrapID() and e:TrapID():GetTrapID() == trapID and not e:HasDeadMark()
    end)
    if 0 < #es and checkHas == 0 then
      return false
    elseif #es == 0 and checkHas == 1 then
      return false
    end
  end
  return true
end

_class("TTCumulativeTriggerByEnergy", TriggerCount)
TTCumulativeTriggerByEnergy = TTCumulativeTriggerByEnergy

function TTCumulativeTriggerByEnergy:OnNotify(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarProAddFeatureEnergy then
    return
  end
  local num = notify:GetAddNum() or 0
  self:AddCount(num)
end

function TTCumulativeTriggerByEnergy:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarProAddFeatureEnergy then
    return false
  end
  local expectNum = self:GetTriggerParamByIndex(1)
  local satisfied = expectNum <= self._count
  if satisfied then
    local count = math.fmod(self._count, expectNum)
    local cumulativeNum = math.floor(self._count / expectNum)
    self:SetCount(count)
    notify:SetCumulativeTriggerNum(cumulativeNum)
  end
  return satisfied
end

function TTCumulativeTriggerByEnergy:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarProAddFeatureEnergy then
    return false
  end
  local expectNum = self:GetTriggerParamByIndex(1)
  local satisfied = expectNum <= self._count
  if satisfied then
    local count = math.fmod(self._count, expectNum)
    local cumulativeNum = math.floor(self._count / expectNum)
    self:SetCount(count)
    notify:SetCumulativeTriggerNum(cumulativeNum)
  end
  return satisfied
end

_class("TTPetFetters", TriggerBase)
TTPetFetters = TTPetFetters

function TTPetFetters:IsSatisfied(notify)
  local fettersCmpt = self:GetOwnerEntity():Fetters()
  if fettersCmpt then
    return true
  end
  return false
end

_class("TTIsCampSkill", TriggerBase)
TTIsCampSkill = TTIsCampSkill

function TTIsCampSkill:IsSatisfied(notify)
  local id = notify:GetSkillID()
  if id then
    local cfg = Cfg.cfg_camp_skill({SkillID = id})
    if cfg and cfg[1] then
      return true
    end
  end
  return false
end

_class("TTCheckConvertGridSkillTypeOrLinkLine", TriggerBase)
TTCheckConvertGridSkillTypeOrLinkLine = TTCheckConvertGridSkillTypeOrLinkLine

function TTCheckConvertGridSkillTypeOrLinkLine:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.GridConvert then
    return false
  end
  if (not notify:GetSkillType() or notify:GetSkillType() == nil) and not notify:IsLinkLine() then
    return false
  end
  return table.icontains(self._param, notify:GetSkillType()) or notify:IsLinkLine()
end

_class("TTPetJobMatch", TriggerBase)
TTPetJobMatch = TTPetJobMatch

function TTPetJobMatch:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PetCreate then
    return false
  end
  return table.icontains(self._param, notify:GetPetJob())
end

_class("TTIsFeatureAUOEValueMax", TriggerBase)
TTIsFeatureAUOEValueMax = TTIsFeatureAUOEValueMax

function TTIsFeatureAUOEValueMax:IsSatisfied(notify)
  local featureLSvc = self._world:GetService("FeatureLogic")
  if featureLSvc and featureLSvc:HasFeatureType(FeatureType.AlgorithmUpgrade) then
    local maxValue = featureLSvc:GetMaxAUOEValue()
    local curValue = featureLSvc:GetAUOEValue()
    if maxValue == curValue then
      return true
    end
  end
  return false
end

_class("TTNotifySkillEffectTypeMatch", TriggerBase)
TTNotifySkillEffectTypeMatch = TTNotifySkillEffectTypeMatch

function TTNotifySkillEffectTypeMatch:IsSatisfied(notify)
  if notify.GetSkillID and notify:GetSkillID() and #self._param > 0 then
    local casterEntity = notify:GetAttackerEntity()
    local skillID = notify:GetSkillID()
    local configSvc = self._world:GetService("Config")
    local skillConfigData = configSvc:GetSkillConfigData(skillID, casterEntity)
    local svcCfgDeco = self._world:GetService("ConfigDecoration")
    local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(casterEntity:GetID(), skillID)
    for _, v in ipairs(skillEffectArray) do
      local skillEffectParam = v
      local skillEffectType = skillEffectParam:GetEffectType()
      if table.intable(self._param, skillEffectType) then
        return true
      end
    end
  end
  return false
end

_class("TTNormalAttackCanDetonateMonsterWeak", TriggerBase)
TTNormalAttackCanDetonateMonsterWeak = TTNormalAttackCanDetonateMonsterWeak

function TTNormalAttackCanDetonateMonsterWeak:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.NormalAttackCalcEnd then
    return false
  end
  local attacker = notify:GetAttackerEntity()
  local defender = notify:GetDefenderEntity()
  local attackPos = notify:GetAttackPos()
  local targetPos = notify:GetTargetPos()
  local defenderGridPosition = defender:GetGridPosition()
  local monsterWeakComponent = defender:MonsterWeak()
  if not monsterWeakComponent then
    return false
  end
  local activeWeakList = monsterWeakComponent:GetMonsterWeakDataList()
  if table.count(activeWeakList) == 0 then
    return false
  end
  local targetWeakKey
  local attakDir = Vector2(attackPos.x - targetPos.x, attackPos.y - targetPos.y)
  if attakDir == Vector2(0, 1) then
    targetWeakKey = WeakEdgeType.WeakUp
  elseif attakDir == Vector2(0, -1) then
    targetWeakKey = WeakEdgeType.WeakDown
  elseif attakDir == Vector2(1, 0) then
    targetWeakKey = WeakEdgeType.WeakRight
  elseif attakDir == Vector2(-1, 0) then
    targetWeakKey = WeakEdgeType.WeakLeft
  end
  local bodyAreaPos = targetPos - defenderGridPosition
  local targetWeakData = monsterWeakComponent:GetMonsterWeakDataByKeyAndBodyPos(targetWeakKey, bodyAreaPos)
  if not targetWeakData then
    return false
  end
  return true
end

_class("TTNotifyAutoBeadTagMatch", TriggerBase)
TTNotifyAutoBeadTagMatch = TTNotifyAutoBeadTagMatch

function TTNotifyAutoBeadTagMatch:IsSatisfied(notify)
  if notify.GetAutoBeadID and notify:GetAutoBeadID() and #self._param > 0 then
    local casterEntity = notify:GetAttackerEntity()
    local autoBeadID = notify:GetAutoBeadID()
    local autoBeadCmpt = casterEntity:LogicAutoBead()
    if autoBeadCmpt then
      local autoBeadAttackDataCmpt = casterEntity:SkillAutoBeadAttackData()
      if autoBeadAttackDataCmpt and autoBeadID and 0 < autoBeadID then
        local autoBeadData = autoBeadCmpt:GetAutoBeadInnerDataByID(autoBeadID)
        if autoBeadData then
          local autoBeadTag = autoBeadData:GetAutoBeadTag()
          if autoBeadTag then
            for index, checkTag in ipairs(self._param) do
              if table.icontains(autoBeadTag, checkTag) then
                return true
              end
            end
          end
        end
      end
    end
  end
  return false
end

_class("TTMovePieceTypeMatchToTeamLeader", TriggerBase)
TTMovePieceTypeMatchToTeamLeader = TTMovePieceTypeMatchToTeamLeader

function TTMovePieceTypeMatchToTeamLeader:IsSatisfied(notify)
  local entityID = notify:GetEntityID()
  local entity = self._world:GetEntityByID(entityID)
  if entity and entity:HasPet() then
  else
    return false
  end
  local teamEntity = entity:Pet():GetOwnerTeamEntity()
  if not teamEntity then
    return false
  end
  local teamEntityLeader = teamEntity:GetTeamLeaderPetEntity()
  if not teamEntityLeader then
    return false
  end
  local elementCmpt = teamEntityLeader:Element()
  if not elementCmpt then
    return false
  end
  local teamLeaderElementType = elementCmpt:GetPrimaryType()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPieceType = logicChainPathCmpt:GetLogicPieceType()
  if chainPieceType then
    local pieceType = notify:GetPosPieceType()
    if chainPieceType == PieceType.Any then
      if pieceType == PieceType.Any then
        return true
      end
    elseif chainPieceType == teamLeaderElementType then
      if pieceType == teamLeaderElementType or pieceType == PieceType.Any then
        return true
      end
    elseif pieceType == teamLeaderElementType then
      return true
    end
  end
  return false
end

_class("TTNotifyMeOrTeamPetOrTeam", TriggerBase)
TTNotifyMeOrTeamPetOrTeam = TTNotifyMeOrTeamPetOrTeam

function TTNotifyMeOrTeamPetOrTeam:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:GetID() == notifyEntity:GetID() then
    return true
  end
  if ownerEntity:HasPet() and notifyEntity:GetID() == ownerEntity:Pet():GetOwnerTeamEntity():GetID() then
    return true
  end
  if ownerEntity:HasPet() and notifyEntity:HasPet() and notifyEntity:Pet():GetOwnerTeamEntity():GetID() == ownerEntity:Pet():GetOwnerTeamEntity():GetID() then
    return true
  end
  if ownerEntity:HasTeam() and notifyEntity:HasPet() and ownerEntity:GetID() and ownerEntity:GetID() == notifyEntity:Pet():GetOwnerTeamEntity():GetID() then
    return true
  end
  return false
end

_class("TTInPetSkillScope", TriggerBase)
TTInPetSkillScope = TTInPetSkillScope

function TTInPetSkillScope:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity:HasPet() then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasDeadMark() then
    return false
  end
  local skillID = notify:GetSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local skillEffectTypes = self._param
  if skillEffectTypes then
    local vaild = false
    local skillEffects = skillConfigData:GetSkillEffect()
    for _, effectParam in ipairs(skillEffects) do
      if table.icontains(skillEffectTypes, effectParam:GetEffectType()) then
        vaild = true
        break
      end
    end
    if not vaild then
      return false
    end
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local petPosition = notifyEntity:GridLocation():GetGridPos()
  local petBodyArea = notifyEntity:BodyArea():GetArea()
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, petPosition, Vector2(0, 1), petBodyArea)
  local ownerPosition = ownerEntity:GridLocation():GetGridPos()
  local inScope = table.icontains(skillResult:GetAttackRange(), ownerPosition)
  return inScope
end

_class("TTAbsorbTrapElementMatch", TriggerBase)
TTAbsorbTrapElementMatch = TTAbsorbTrapElementMatch

function TTAbsorbTrapElementMatch:IsSatisfied(notify)
  local pos = notify:GetNotifyPos()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local pieceType = boardServiceLogic:GetPieceType(pos)
  return table.insert(self._param, pieceType)
end

_class("TTNotifyEntitySameMoveGroupID", TriggerBase)
TTNotifyEntitySameMoveGroupID = TTNotifyEntitySameMoveGroupID

function TTNotifyEntitySameMoveGroupID:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local ownerEntity = self:GetOwnerEntity()
  if not notifyEntity:MonsterID() or not ownerEntity:MonsterID() then
    return false
  end
  local notifyEntityMonsterIDCmpt = notifyEntity:MonsterID()
  local ownerEntityMonsterIDCmpt = ownerEntity:MonsterID()
  if not ownerEntityMonsterIDCmpt:GetMoveGroupID() or not notifyEntityMonsterIDCmpt:GetMoveGroupID() then
    return false
  end
  return ownerEntityMonsterIDCmpt:GetMoveGroupID() == notifyEntityMonsterIDCmpt:GetMoveGroupID()
end

_class("TTSummonSameMoveGroupID", TriggerBase)
TTSummonSameMoveGroupID = TTSummonSameMoveGroupID

function TTSummonSameMoveGroupID:IsSatisfied(notify)
  local groupID = notify:GetGroupID()
  local ownerEntity = self:GetOwnerEntity()
  if not ownerEntity:MonsterID() then
    return false
  end
  local ownerEntityMonsterIDCmpt = ownerEntity:MonsterID()
  if not ownerEntityMonsterIDCmpt:GetMoveGroupID() or not groupID then
    return false
  end
  return ownerEntityMonsterIDCmpt:GetMoveGroupID() == groupID
end

_class("TTSanValueInversion", TriggerBase)
TTSanValueInversion = TTSanValueInversion

function TTSanValueInversion:IsSatisfied(notify)
  local midValue = self._param[1]
  local curValue = notify:GetCurValue()
  local oldValue = notify:GetOldValue()
  if midValue <= oldValue and midValue > curValue or midValue > oldValue and midValue <= curValue then
    return true
  end
  return false
end

_class("TTAttackerHaveBuff", TriggerBase)
TTAttackerHaveBuff = TTAttackerHaveBuff

function TTAttackerHaveBuff:IsSatisfied(notify)
  local attacker = notify:GetAttackerEntity()
  if attacker:HasDeadMark() then
    return false
  end
  local buffCmp = attacker:BuffComponent()
  if buffCmp then
    for _, buffEffect in ipairs(self._param) do
      if buffCmp:HasBuffEffect(buffEffect) then
        return true
      end
    end
  end
  return false
end

_class("TTCompareLegendEnergy", TriggerBase)
TTCompareLegendEnergy = TTCompareLegendEnergy

function TTCompareLegendEnergy:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  if not ownerEntity:HasPet() then
    return false
  end
  local legendPower = ownerEntity:Attributes():GetAttribute("LegendPower")
  local compareFlag = self:GetTriggerParamByIndex(1)
  local comboExpect = self:GetTriggerParamByIndex(2)
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = legendPower == comboExpect
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = legendPower ~= comboExpect
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = legendPower > comboExpect
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = legendPower >= comboExpect
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = legendPower < comboExpect
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = legendPower <= comboExpect
  end
  return satisfied
end

_class("TTBloodLessEqualThan", TriggerBase)
TTBloodLessEqualThan = TTBloodLessEqualThan

function TTBloodLessEqualThan:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  local battleSvc = self._world:GetService("Battle")
  if not self._y then
    curhp, maxhp = battleSvc:GetCasterHP(owner)
  elseif owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cAttr = teamEntity:Attributes()
    curhp = cAttr:GetCurrentHP()
    maxhp = cAttr:CalcMaxHp()
  end
  local isOwnerAndNotifierPlayer = not (owner:HasTeam() or entity:HasTeam()) or owner:HasPetPstID() or entity:HasPetPstID()
  local blood = curhp / maxhp
  return blood <= self._x and (owner:GetID() == entity:GetID() or isOwnerAndNotifierPlayer)
end

_class("TTBloodMoreEqualThan", TriggerBase)
TTBloodMoreEqualThan = TTBloodMoreEqualThan

function TTBloodMoreEqualThan:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  local battleSvc = self._world:GetService("Battle")
  if not self._y then
    curhp, maxhp = battleSvc:GetCasterHP(owner)
  elseif owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cAttr = teamEntity:Attributes()
    curhp = cAttr:GetCurrentHP()
    maxhp = cAttr:CalcMaxHp()
  end
  if notify:GetNotifyType() == NotifyType.PlayerMoveStart then
    local curBlood = curhp / maxhp
    return curBlood > self._x
  end
  local isOwnerAndNotifierPlayer = not (owner:HasTeam() or entity:HasTeam()) or owner:HasPetPstID() or entity:HasPetPstID()
  local blood = curhp / maxhp
  return blood >= self._x and (owner:GetID() == entity:GetID() or isOwnerAndNotifierPlayer)
end

_class("TTCheckIsPetActiveLinkLine", TriggerBase)
TTCheckIsPetActiveLinkLine = TTCheckIsPetActiveLinkLine

function TTCheckIsPetActiveLinkLine:IsSatisfied(notify)
  if not notify.IsPetActiveLinkLine then
    return false
  end
  local flag = self:GetTriggerParamByIndex(1)
  if flag == 1 then
    return notify:IsPetActiveLinkLine() == true
  elseif flag == 0 then
    return notify:IsPetActiveLinkLine() ~= true
  end
end

_class("TTCheckTeamAlivePetCount", TriggerBase)
TTCheckTeamAlivePetCount = TTCheckTeamAlivePetCount

function TTCheckTeamAlivePetCount:IsSatisfied(notify)
  local battleSvc = self._world:GetService("Battle")
  local count = battleSvc:GetAlivePetCount()
  local compareFlag = self:GetTriggerParamByIndex(1)
  local comboExpect = self:GetTriggerParamByIndex(2)
  return battleSvc:Compare2Num(count, comboExpect, compareFlag)
end
