require("pick_up_policy_base")
_class("PickUpPolicy_YiSiTaWanTrap", PickUpPolicy_Base)
PickUpPolicy_YiSiTaWanTrap = PickUpPolicy_YiSiTaWanTrap

function PickUpPolicy_YiSiTaWanTrap:CalcAutoFightPickUpPolicy(calcParam, petEntityIDList)
  local casterEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local teamPos
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  for i, id in ipairs(petEntityIDList) do
    local petEntity = self._world:GetEntityByID(id)
    if petEntity then
      local eTeam = petEntity:Pet():GetOwnerTeamEntity()
      teamPos = eTeam:GetGridPosition()
      targetIdList = {id}
      break
    end
  end
  local configService = self._world:GetService("Config")
  local autoFightSvc = self._world:GetService("AutoFight")
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(casterEntity, activeSkillID)
  local validResults = self:_CalcValidResultByPickUpType_PickUpPolicy(casterEntity, activeSkillID, validPosList)
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  local trapID = policyParam.trapID
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local pickUpType = skillConfigData:GetSkillPickType()
  if 0 < #validResults then
    table.sort(validResults, function(a, b)
      return #a[2] > #b[2]
    end)
    if pickUpType == SkillPickUpType.PickAndDirectionInstruction or pickUpType == SkillPickUpType.PickAndTeleportInst or pickUpType == SkillPickUpType.LineAndDirectionInstruction then
      local t = validResults[1]
      pickPosList = {
        t[1],
        t[4]
      }
      targetIdList = t[2]
      attackPosList = t[3]
    elseif pickUpType == SkillPickUpType.PickOnePosAndRotate then
      local t = validResults[1]
      for i = 1, t[4] do
        pickPosList[#pickPosList + 1] = t[1]
      end
      targetIdList = t[2]
      attackPosList = t[3]
    elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
      local t = validResults[1]
      pickPosList = {
        t[1]
      }
      targetIdList = t[2]
      attackPosList = t[3]
    elseif pickUpType == SkillPickUpType.PickDiffPowerInstruction then
      local t = validResults[1]
      pickPosList = {
        t[1]
      }
      targetIdList = t[2]
      attackPosList = t[3]
    else
      for i = 1, pickUpNum do
        local t = validResults[i]
        if not t then
          break
        end
        pickPosList[i] = t[1]
        table.appendArray(targetIdList, t[2])
        table.appendArray(attackPosList, t[3])
      end
    end
    return pickPosList, attackPosList, targetIdList
  else
    local monsterEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
    local nearestMonsterPos
    local monterDis = 9999
    for i, entity in ipairs(monsterEntities) do
      local disLen = Vector2.Distance(teamPos, entity:GetGridPosition())
      if monterDis > disLen then
        monterDis = disLen
        nearestMonsterPos = entity:GetGridPosition()
      end
    end
    if self._world:MatchType() == MatchType.MT_BlackFist then
      local team2 = self._world:Player():GetRemoteTeamEntity()
      nearestMonsterPos = team2:GetGridPosition()
    end
    Log.fatal("Pos ", nearestMonsterPos)
    local gridLen = 999
    local utilData = self._world:GetService("UtilData")
    for i, pos in ipairs(validPosList) do
      local disLen = Vector2.Distance(nearestMonsterPos, pos)
      if gridLen > disLen then
        local tTrapEntities = utilData:GetTrapsAtPos(pos)
        local hasTrap = false
        for _, e in ipairs(tTrapEntities) do
          if e:TrapID():GetTrapID() == trapID then
            hasTrap = true
            break
          end
        end
        if not hasTrap then
          gridLen = disLen
          pickPosList = {pos}
          attackPosList = {pos}
        end
      end
    end
  end
  if #pickPosList == 0 then
    pickPosList = {
      validPosList[#validPosList]
    }
    attackPosList = {
      validPosList[#validPosList]
    }
  end
  return pickPosList, attackPosList, targetIdList
end
