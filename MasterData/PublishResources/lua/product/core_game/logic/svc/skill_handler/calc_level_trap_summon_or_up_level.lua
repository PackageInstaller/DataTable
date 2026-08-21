require("calc_base")
_class("SkillEffectCalc_LevelTrapSummonOrUpLevel", SkillEffectCalc_Base)
SkillEffectCalc_LevelTrapSummonOrUpLevel = SkillEffectCalc_LevelTrapSummonOrUpLevel

function SkillEffectCalc_LevelTrapSummonOrUpLevel:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  if param then
    local centerPos = skillEffectCalcParam.skillRange[1]
    local checkTrapIDs = param:GetCheckTrapIDs()
    local tarTrapID = param:GetSummonTrapID()
    local block = param:GetBlock()
    local boardCmpt = self._world:GetBoardEntity():Board()
    local hostEntityID = skillEffectCalcParam.casterEntityID
    local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
    if casterEntity and casterEntity:HasSuperEntity() then
      local superEntity = casterEntity:GetSuperEntity()
      if superEntity then
        local superEntityID = superEntity:GetID()
        hostEntityID = superEntityID
      end
    end
    local checkTraps = boardCmpt:GetPieceEntities(centerPos, function(e)
      local isOwner = false
      if e:HasSummoner() then
        if e:Summoner():GetSummonerEntityID() == hostEntityID then
          isOwner = true
        else
          local summonEntity = e:GetSummonerEntity()
          if summonEntity and summonEntity:HasSuperEntity() then
            local superEntity = summonEntity:GetSuperEntity()
            if superEntity then
              local summonEntityID = superEntity:GetID()
              if summonEntityID == hostEntityID then
                isOwner = true
              end
            end
          end
        end
      else
        isOwner = true
      end
      return isOwner and e:HasTrap() and table.icontains(checkTrapIDs, e:Trap():GetTrapID()) and not e:HasDeadMark()
    end)
    if 0 < #checkTraps then
      local tarLevel = 1
      local desTrapLevel = 1
      local desTrap = checkTraps[1]
      if desTrap then
        local desTrapID = desTrap:Trap():GetTrapID()
        desTrapLevel = param:GetTrapModelLevel(desTrapID)
      end
      tarLevel = desTrapLevel + 1
      local tarTrapID = 0
      local isTarTrapMaxLevel = false
      local modelLevelDic = param:GetModelLevels()
      if modelLevelDic then
        tarTrapID = modelLevelDic[tarLevel] or modelLevelDic[#modelLevelDic]
        if tarLevel >= #modelLevelDic then
          isTarTrapMaxLevel = true
        end
      end
      if tarTrapID and 0 < tarTrapID then
        local summonList = {}
        local destroyList = {}
        local summonTrapResult = SkillSummonTrapEffectResult:New(tarTrapID, centerPos, param:IsTransferDisabled(), param:GetSkillEffectDamageStageIndex())
        table.insert(summonList, summonTrapResult)
        local desTrapEntityID = desTrap:GetID()
        local cTrap = desTrap:Trap()
        local desTrapID = cTrap:GetTrapID()
        local destroyTrapResult = SkillEffectDestroyTrapResult:New(desTrapEntityID, desTrapID)
        table.insert(destroyList, destroyTrapResult)
        return SkillEffectResultLevelTrapSummonOrUpLevel:New(summonList, destroyList, isTarTrapMaxLevel)
      end
    else
      do
        local isTarTrapMaxLevel = false
        local trapSvc = self._world:GetService("TrapLogic")
        if block == 0 or trapSvc:CanSummonTrapOnPos(centerPos, tarTrapID) then
          local summonList = {}
          local destroyList = {}
          local summonTrapResult = SkillSummonTrapEffectResult:New(tarTrapID, centerPos, param:IsTransferDisabled(), param:GetSkillEffectDamageStageIndex())
          table.insert(summonList, summonTrapResult)
          return SkillEffectResultLevelTrapSummonOrUpLevel:New(summonList, destroyList, isTarTrapMaxLevel)
        end
      end
    end
  end
end
