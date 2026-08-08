local CO = require("Common/Coroutine")
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local TLog = require("Common/TlogUtil")
local hurtCalculate = require("Logic/HurtCalculate")
local buffLogic = require("Logic/BuffLogic")
local SA = require("Logic/SpecialAttrLogic")
local TS = require("Logic/Statistic")
local CombatDataRecorder = require("Logic/CombatDataRecorder")
local HP_INDEX = PB.enum.AttrType.Hp

function useCard(param, callback, activeData)
  if FH.isGameOver(activeData) then
    info("GamePlay", "game is over, can not process logic")
    activeData.useCardResult = 100
    if callback ~= nil then
      callback(activeData)
    end
    return activeData
  end
  local fightData = activeData
  info("GamePlay", "lua - useCard Team : " .. param.team .. " - round state : " .. fightData.roundState)
  fightData.useCardResult = 0
  if fightData.roundState ~= 0 then
    fightData.useCardResult = 1
    for i = 1, #fightData.teamList do
      local teamInfo = fightData.teamList[i]
      if teamInfo.team == param.team then
        teamInfo.useResult = 1
        break
      end
    end
    if not FH.isMultiPlayerMode(fightData) then
      warning("GamePlay", "ERROR " .. param.team)
    end
    if callback ~= nil then
      callback(fightData)
    end
    return fightData
  end
  fightData.roundState = 1
  local card = param.useCard
  local sCard = param.useSCard
  local linkID = param.linkID
  local uniqueId = param.actorID
  local inputTeam = param.team
  local teamList = fightData.teamList
  local activeTeam = fightData.activeTeam
  local gameRound = fightData.gameRound
  local skip = 1
  local useMp = 0
  local useSp = 0
  local skill_info
  if activeTeam ~= inputTeam then
    warning("GamePlay", "ERROR " .. activeTeam .. " != " .. inputTeam)
  end
  fightData.useCardTeam = inputTeam
  local otherTeam = 1
  if inputTeam == 1 then
    otherTeam = 2
  end
  FH.clearTeamUseCardData(teamList)
  local activeTeamInfo = FH.getTeamInfo(teamList, inputTeam)
  local otherTeamInfo = FH.getTeamInfo(teamList, otherTeam)
  local selfTeamType = activeTeamInfo.statistic.aliveCount
  local otherTeamType = otherTeamInfo.statistic.aliveCount
  activeTeamInfo.useLinkID = linkID
  activeTeamInfo.useCard = card
  activeTeamInfo.useSCard = sCard
  if 0 < linkID or 0 < uniqueId then
    skip = 0
    for j = 1, #param.cardList do
      table.insert(activeTeamInfo.useCardList, param.cardList[j])
    end
  end
  if not FH.isNetMode(fightData.dungeonType) then
    local recordInput = {
      useCard = param.useCard,
      useSCard = param.useSCard,
      linkID = param.linkID,
      actorID = param.actorID,
      team = param.team,
      cardList = {},
      buffList = {},
      actionList = {}
    }
    if 0 < linkID or 0 < uniqueId then
      for j = 1, #param.cardList do
        table.insert(recordInput.cardList, param.cardList[j])
      end
    end
    for b = 1, #param.buffList do
      local buff = param.buffList[b]
      local newBuffInfo = {}
      newBuffInfo.target = {
        team = buff.target.team,
        seat = buff.target.seat
      }
      newBuffInfo.infoList = {}
      for c = 1, #buff.infoList do
        local oneInfo = buff.infoList[c]
        local newInfoImpl = {}
        newInfoImpl.index = oneInfo.index
        newInfoImpl.level = oneInfo.level
        newInfoImpl.attack = {
          team = oneInfo.attack.team,
          seat = oneInfo.attack.seat
        }
        table.insert(newBuffInfo.infoList, newInfoImpl)
      end
      table.insert(recordInput.buffList, newBuffInfo)
    end
    table.insert(activeTeamInfo.statistic.inputList, recordInput)
  end
  FH.clearTeamRunTimeInfo(teamList)
  FH.clearAllNewHitBuff(teamList)
  FH.removeDeadCard(activeTeamInfo)
  local isWeaponSkill = false
  local weaponUser, weaponInfo
  if 0 < uniqueId then
    local roundActorInfo = FH.getActorByUid(activeTeamInfo, uniqueId)
    isWeaponSkill = DEFINE.IsWeapon(roundActorInfo)
    if isWeaponSkill then
      weaponUser = FH.getActorByUid(activeTeamInfo, fightData.sequenceActor)
      weaponInfo = roundActorInfo
    end
  end
  local cardLegal = true
  local legal_result = isUseCardLegal(activeTeamInfo, activeTeamInfo.useCardList, param.debugMode)
  if not legal_result then
    cardLegal = false
    activeTeamInfo.useCardList = {}
    activeTeamInfo.useActionList = {}
    if not FH.isInfiniteCard(activeTeamInfo.dungeonType, activeTeamInfo.team) then
      warning("GamePlay", "lua - card not Legal, Team " .. inputTeam)
      fightData.useCardResult = 99
    end
  end
  local targetTable = {}
  local hitTable = {}
  local attackTable = {}
  local orderTable = {}
  local actionTable = {}
  local skill_attack_table = {}
  local actionParamStart = {}
  local enemyNum = 0
  local selfNum = 0
  local cardInfo = {
    num = 0,
    isLinkSkill = false,
    isBigSkill = false,
    isAssistSkill = false
  }
  if cardLegal then
    if skip == 1 or 0 < linkID then
      for m = 1, #activeTeamInfo.activeList do
        local skipActor = FH.getActorByUid(activeTeamInfo, activeTeamInfo.activeList[m])
        if skipActor ~= nil then
          hitTable[skipActor] = {}
        end
      end
    end
    local selfSeat = 0
    local actorConfigID = 0
    local attackActor
    if 0 < linkID and 0 < #param.cardList then
      local link_list = activeTeamInfo.linkInfoList
      for l = 1, #link_list do
        if link_list[l].linkID == linkID then
          for m = 1, #link_list[l].uidList do
            attackActor = FH.getActorByUid(activeTeamInfo, link_list[l].uidList[m])
            if attackActor ~= nil and not attackActor.isAssist and attackActor.uniqueID == param.cardList[1].actorRuntimeID then
              selfSeat = attackActor.seat
              break
            end
          end
        end
      end
    end
    if 0 < uniqueId then
      attackActor = FH.getActorByUid(activeTeamInfo, uniqueId)
      if attackActor ~= nil then
        actorConfigID = attackActor.actorInfo.id
        if not attackActor.isAssist then
          selfSeat = attackActor.seat
        elseif isWeaponSkill then
        end
      end
    end
    if 0 < linkID and 0 < #param.cardList then
      local result_id_table = FH.getTeamLinkActorTable(activeTeamInfo, linkID, param.cardList[1].actorRuntimeID)
      for r = 1, #result_id_table do
        table.insert(activeTeamInfo.useActorList, result_id_table[r])
      end
      table.insert(activeTeamInfo.statistic.linkIdList, linkID)
      cardInfo.isLinkSkill = true
    end
    if 0 < uniqueId then
      table.insert(activeTeamInfo.useActorList, uniqueId)
      if 1 <= sCard then
        table.insert(activeTeamInfo.statistic.bigSkillList, actorConfigID)
        cardInfo.isBigSkill = true
      end
      cardInfo.num = FH.getCardPlace(actorConfigID, card, sCard)
      local skill_num = cardInfo.num
      if attackActor ~= nil then
        if sCard == 0 then
          attackActor.lastUseCard = skill_num
        end
        cardInfo.isAssistSkill = attackActor.isAssist
        if cardInfo.isAssistSkill then
          skill_num = cardInfo.num + 10
        end
      end
      local result_num = actorConfigID * 10000 + skill_num * 10 + otherTeamType
      table.insert(activeTeamInfo.statistic.cardNumList, result_num)
    end
    for b = 1, #param.actionList do
      local info = param.actionList[b]
      local buff_target = FH.getTeamActorsBySeat(teamList, info.target.team, info.target.seat)
      if buff_target ~= nil then
        if 0 >= buff_target.dynamicAttrs[HP_INDEX].value then
          warning("GamePlay", "ai add action error [hp]")
        else
          table.insert(activeTeamInfo.useActionList, info)
        end
      else
        warning("GamePlay", "ai add action error [target]")
      end
    end
    for b = 1, #param.buffList do
      local info = param.buffList[b]
      local buff_target = FH.getTeamActorsBySeat(teamList, info.target.team, info.target.seat)
      if buff_target ~= nil then
        for c = 1, #info.infoList do
          local oneInfo = info.infoList[c]
          if 0 >= buff_target.dynamicAttrs[HP_INDEX].value then
            warning("GamePlay", "ai add buff error [hp]")
          else
            local buff_attack = FH.getTeamActorsBySeat(teamList, oneInfo.attack.team, oneInfo.attack.seat)
            buffLogic(oneInfo.index, oneInfo.level, teamList, buff_attack, buff_target, {
              gameRound,
              0,
              0
            })
          end
        end
      else
        warning("GamePlay", "ai add buff error [target]")
      end
    end
    local indexID = actorConfigID
    if isWeaponSkill then
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", indexID, weaponInfo.actorInfo.uniqueWeaponPhase)
      if uniqueWeaponSkill then
        indexID = uniqueWeaponSkill.weaponSkillId
      else
        warning("GamePlay", "UniqueWeaponSkill.xlsx missing id " .. tostring(indexID) .. " phase " .. tostring(weaponInfo.actorInfo.uniqueWeaponPhase))
      end
    end
    local nCardID = card
    local sCardID = sCard
    if 0 < linkID then
      indexID = linkID
      nCardID = 0
      sCardID = 0
    end
    actionTable = getActionHitTable(indexID, nCardID, sCardID)
    CO.yield_return(nil)
    local hitResult = getSkillHitResult(indexID, nCardID, sCardID, selfSeat, selfTeamType, otherTeamType)
    for i = 1, DEFINE.ACTOR_NUM do
      local seat = i
      local team = 1
      if inputTeam == 2 then
        team = 2
      end
      if seat > DEFINE.HALF_ACTOR_NUM then
        team = 2
        if inputTeam == 2 then
          team = 1
        end
        seat = seat - DEFINE.HALF_ACTOR_NUM
      end
      local target = FH.getTeamActorsBySeat(teamList, team, seat)
      if target ~= nil and hitResult ~= nil then
        local hitStr = getHitString(hitResult.hitList[i])
        if hitStr ~= nil then
          if inputTeam ~= team then
            enemyNum = enemyNum + 1
          else
            selfNum = selfNum + 1
          end
          targetTable[target] = string.split(hitStr, ";")
        end
      end
    end
    for k, v in pairs(targetTable) do
      local str_Arr = v
      local target = k
      local hitCountTable = {}
      local newOrderTable = {}
      table.insert(activeTeamInfo.hitKeyList, k.team .. "," .. k.seat)
      local hitList = {}
      hitList.listInfo = {}
      table.insert(activeTeamInfo.hitResultList, hitList)
      local teamInfo = FH.getTeamInfo(teamList, k.team)
      for i = 1, #str_Arr do
        if str_Arr[i] ~= "" then
          local str_Arr2 = string.split(str_Arr[i], ",")
          local skillID = tonumber(str_Arr2[1])
          if skill_attack_table[skillID] == nil then
            if isWeaponSkill then
              skill_attack_table[skillID] = weaponInfo
            else
              skill_attack_table[skillID] = getAttackBySkillID(activeTeamInfo, param.cardList, skillID, linkID)
            end
          end
          local attack = skill_attack_table[skillID]
          if attack ~= nil then
            if hitTable[attack] == nil then
              hitTable[attack] = {target}
            else
              local list = hitTable[attack]
              local find = false
              for j = 1, #list do
                if list[j] == target then
                  find = true
                  break
                end
              end
              if find == false then
                table.insert(list, target)
              end
            end
            local inputCount = tonumber(str_Arr2[8])
            if hitCountTable[attack] == nil then
              hitCountTable[attack] = inputCount
            else
              hitCountTable[attack] = hitCountTable[attack] + inputCount
            end
            local index = tonumber(str_Arr2[9]) + 1
            if orderTable[index] == nil then
              newOrderTable[index] = {
                attack,
                target,
                str_Arr[i],
                1,
                teamInfo,
                hitList
              }
            else
              warning("GamePlay", str_Arr[i])
            end
          else
            warning("GamePlay", "not find attack by skillID " .. skillID)
          end
        end
      end
      for k, v in pairs(newOrderTable) do
        v[4] = hitCountTable[v[1]]
        orderTable[k] = v
      end
      CO.yield_return(nil)
    end
    local energyValStart = FH.getCurEnergy(activeTeamInfo, fightData.dungeonType, fightData.sequenceActor)
    local cost_sp = 0
    local cost_mp = 0
    if 0 < linkID then
      local link_info = PB.get("ActorLink", linkID)
      skill_info = link_info
      if link_info == nil then
        warning("GamePlay", "lua - not link info " .. linkID)
      else
        cost_sp = link_info.costSp
        cost_mp = link_info.costMp
      end
    end
    if 0 < uniqueId then
      if not isWeaponSkill then
        local combo_info = PB.get("ActorCombo", actorConfigID, card, sCard)
        skill_info = combo_info
        if combo_info == nil then
          warning("GamePlay", "lua - not combo info " .. actorConfigID)
        else
          cost_sp = combo_info.costSp
          cost_mp = combo_info.costMp
        end
      else
        local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", actorConfigID, weaponInfo.actorInfo.uniqueWeaponPhase)
        if uniqueWeaponSkill then
          skill_info = {
            uniqueWeaponSkill.weaponSkillId
          }
          if param.debugMode == 0 then
            weaponInfo.energyWP = weaponInfo.energyWP - uniqueWeaponSkill.costWP
            activeTeamInfo.weaponUseCount = activeTeamInfo.weaponUseCount - uniqueWeaponSkill.costUseCount or 1
          end
        else
          warning("GamePlay", "missing UniqueWeaponSkill id : " .. tostring(actorConfigID) .. " , phase : " .. tostring(weaponInfo.actorInfo.uniqueWeaponPhase))
        end
      end
    end
    local defineParams = DEFINE.GetDefineParams(fightData.stageID)
    if attackActor ~= nil then
      if cost_sp == 0 then
        local mp_change = FH.getCostChangeByBuff(attackActor, card, sCard, linkID, "mp")
        cost_mp = math.max(0, cost_mp + mp_change)
      elseif cost_mp == 0 then
        local sp_change = FH.getCostChangeByBuff(attackActor, card, sCard, linkID, "sp")
        cost_sp = math.max(0, cost_sp + sp_change)
      end
    end
    local rate_result = {0, 0}
    if attackActor ~= nil then
      rate_result = FH.getSpRateChangeByBuff(attackActor)
    end
    local addSp = cost_mp * defineParams.changeRate * (1 + rate_result[2]) + rate_result[1]
    addSp = math.max(0, math.ceil(addSp))
    local activeSeat = FH.getCurActiveSeat(activeTeamInfo, fightData.dungeonType, fightData.sequenceActor)
    TLog.CollectEnergy({
      action = "change",
      kind = 1,
      teamInfo = activeTeamInfo,
      val = -cost_mp,
      maxVal = defineParams.maxMp,
      source = 2
    })
    TLog.CollectEnergy({
      action = "change",
      kind = 2,
      teamInfo = activeTeamInfo,
      val = -cost_sp,
      maxVal = defineParams.maxSp,
      source = 2
    })
    useMp = cost_mp
    useSp = cost_sp
    FH.addTeamEnergy(2, activeTeamInfo, addSp, defineParams.maxSp, activeSeat, 2)
    local leftMp = FH.getTeamEnergy(1, activeTeamInfo, activeSeat) - cost_mp
    local leftSp = FH.getTeamEnergy(2, activeTeamInfo, activeSeat) - cost_sp
    FH.setTeamEnergy(1, activeTeamInfo, math.max(0, leftMp), activeSeat)
    FH.setTeamEnergy(2, activeTeamInfo, math.max(0, leftSp), activeSeat)
    if leftSp < 0 or leftMp < 0 then
      if FH.isInfiniteCard(fightData.dungeonType, inputTeam) then
        info("GamePlay", "ai can run here")
      else
        warning("GamePlay", "error leftSp = " .. leftSp .. " leftMp = " .. leftMp)
        fightData.useCardResult = 99
      end
    end
    actionParamStart = {
      gameRound,
      cardInfo,
      enemyNum,
      selfNum,
      skip,
      energyValStart[1],
      energyValStart[2],
      0,
      {},
      useMp,
      useSp,
      0,
      0,
      skill_info,
      weaponUser = weaponUser
    }
    if skip == 0 then
      for k, v in pairs(hitTable) do
        SA.SpecialAttrLogic(k, PB.enum.IdentityCategory.Self, v, teamList, PB.enum.Timing.ActionStart, actionParamStart)
        table.insert(attackTable, k)
      end
      local targetResult = FH.getTeamActors(teamList, otherTeam)
      for i = 1, #targetResult do
        SA.SpecialAttrLogic(targetResult[i], PB.enum.IdentityCategory.TargetTeam, attackTable, teamList, PB.enum.Timing.ActionStart, actionParamStart)
      end
    end
    if attackActor ~= nil then
      TLog.CollectSkillDamage({
        action = "start",
        team = attackActor.team,
        seat = attackActor.baseSeat,
        allinfo = actionParamStart,
        enemyNum = enemyNum
      })
    end
  end
  CombatDataRecorder.clearCurRoundHurtValue(inputTeam)
  local actorTable = FH.getAllActors(teamList, false)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    table.insert(activeTeamInfo.buffKeyList, actor.uniqueID)
    local listTable = {}
    listTable.listInfo = FH.copyActorBuff(actor)
    listTable.hpChange = FH.copyActorOnceHp(actor)
    table.insert(activeTeamInfo.buffResultList, listTable)
  end
  local hurtTable = {}
  local tempHurtTable = {}
  local cardParam = {
    card,
    sCard,
    linkID
  }
  local kill_table = {}
  local sortOrderTable = {}
  for order, parse in pairs(orderTable) do
    local insert_pos = #sortOrderTable + 1
    for s = 1, #sortOrderTable do
      if order <= sortOrderTable[s].orderInfo then
        insert_pos = s
        break
      end
    end
    table.insert(sortOrderTable, insert_pos, {parseInfo = parse, orderInfo = order})
  end
  for index = 1, #sortOrderTable do
    local parse = sortOrderTable[index].parseInfo
    local target = parse[2]
    FH.clearAllNewHitBuff(teamList)
    parseSkillDamage(kill_table, skill_attack_table, param.noDamage, activeTeamInfo, parse[5], teamList, parse[6].listInfo, {
      parse[3]
    }, target, actionParamStart, cardParam, actionTable, parse[4], fightData.dungeonType)
    if tempHurtTable[target] == nil then
      tempHurtTable[target] = index
      table.insert(hurtTable, target)
    end
    CO.yield_return(nil)
  end
  TLog.CollectSkillDamage({action = "end"})
  for i = 1, #hurtTable do
    local targetTeamInfo = FH.getTeamInfo(teamList, hurtTable[i].team)
    processActorDead(kill_table, hurtTable[i], targetTeamInfo, teamList, actionParamStart)
  end
  FH.refreshActionFeedBackBuff(teamList, PB.enum.BuffFightType.ActionFeedBack, hitTable)
  if isWeaponSkill then
    FH.clearAllActorHpChangeBuff(teamList, PB.enum.BuffFightType.HpChange)
  end
  fightData.curSupportActor = 0
  local triggerInfo = {}
  if weaponInfo == nil then
    table.append(triggerInfo, FH.removeActorBuff(teamList, PB.enum.BuffEndPoint.TargetEnd, inputTeam, fightData.sequenceActor, gameRound))
    table.append(triggerInfo, FH.removeActorBuff(teamList, PB.enum.BuffEndPoint.AttackEnd, 0, fightData.sequenceActor, gameRound))
    table.append(triggerInfo, FH.removeActorBuff(teamList, PB.enum.BuffEndPoint.WeaponUserEnd, 0, fightData.sequenceActor, gameRound))
  else
    activeTeamInfo.useSupportActor = weaponInfo.uniqueID
    fightData.curSupportActor = weaponInfo.uniqueID
  end
  local energyValEnd = FH.getCurEnergy(activeTeamInfo, fightData.dungeonType, fightData.sequenceActor)
  local actionParamEnd = {
    gameRound,
    cardInfo,
    enemyNum,
    selfNum,
    skip,
    energyValEnd[1],
    energyValEnd[2],
    0,
    {},
    useMp,
    useSp,
    0,
    0,
    skill_info,
    weaponUser = weaponUser
  }
  SA.TriggerEachSpecialAttr(triggerInfo, teamList, actionParamEnd)
  for k, v in pairs(hitTable) do
    SA.SpecialAttrLogic(k, PB.enum.IdentityCategory.Self, v, teamList, PB.enum.Timing.ActionEnd, actionParamEnd)
  end
  local targetResult = FH.getTeamActors(teamList, otherTeam)
  for i = 1, #targetResult do
    SA.SpecialAttrLogic(targetResult[i], PB.enum.IdentityCategory.TargetTeam, attackTable, teamList, PB.enum.Timing.ActionEnd, actionParamEnd)
  end
  local selfTeamResult = FH.getTeamActors(teamList, inputTeam)
  for i = 1, #selfTeamResult do
    SA.SpecialAttrLogic(selfTeamResult[i], PB.enum.IdentityCategory.SelfTeam, hurtTable, teamList, PB.enum.Timing.ActionEnd, actionParamEnd)
  end
  FH.refreshSequence(fightData)
  FH.fixGameSeat(teamList)
  TS.recordHpList(teamList)
  local result = FH.checkGameOver(fightData, activeTeamInfo, otherTeamInfo, 0)
  if result ~= 0 and fightData.nextDungeonId ~= 0 then
    actionParamEnd[1] = actionParamEnd[1] + 1
    SA.SpecialRoundNumberChange(teamList, activeTeam, actionParamEnd, fightData.dungeonType)
  end
  FH.refreshTeamEnergy(teamList)
  TLog.CollectHp({
    action = "start or end",
    win = fightData.winTeam,
    allTeam = teamList
  })
  TLog.CollectEnergy({
    action = "end",
    win = fightData.winTeam,
    allTeam = teamList
  })
  debugPrint(fightData)
  FH.getGlobalSeed(fightData)
  if callback ~= nil then
    callback(fightData)
  end
  TLog.CollectEnemySkillUsage(param, activeTeamInfo)
  return fightData
end

function debugPrint(fightData)
  local teamList = fightData.teamList
  local hp_str = ""
  local actorTable = FH.getAllActors(teamList, false)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if not actor.isAssist then
      hp_str = hp_str .. "  " .. actor.uniqueID .. " hp = " .. actor.dynamicAttrs[HP_INDEX].value
    end
  end
  info("GamePlay", hp_str)
end

function processBlendActorBuff(buffIndexTable, owner, identityCategory, targets, teamList, timing, params)
  local result, shouldBlendAllActors = SA.SpecialAttrLogic(owner, identityCategory, targets, teamList, timing, params)
  if shouldBlendAllActors then
    FH.blendAllActorBuff(buffIndexTable, teamList)
  else
    FH.blendActorBuff(buffIndexTable, result)
  end
end

function parseSkillDamage(kill_table, skill_attack_table, noDamage, activeTeamInfo, targetTeamInfo, teamList, hitList, str_Arr, target, actionParam, cardParam, actionTable, hitCount, dungeonType)
  local hitCountTable = {}
  for i = 1, #str_Arr do
    if str_Arr[i] ~= "" then
      local str_Arr2 = string.split(str_Arr[i], ",")
      local skillID = tonumber(str_Arr2[1])
      local action = str_Arr2[2]
      local attack = skill_attack_table[skillID]
      if attack == nil then
        warning("GamePlay", "ERROR : attack nil")
        break
      end
      if target == nil then
        warning("GamePlay", "ERROR : target nil")
        break
      end
      local key = getHitCountKey(str_Arr2)
      local totalHit = actionTable[key]
      if totalHit == nil then
        warning("GamePlay", "not find total count, key = " .. key)
      end
      if hitCount ~= nil then
        hitCountTable[attack] = hitCount
      end
      local skillLevel = 1
      local isWeaponSkill = DEFINE.IsWeapon(attack)
      if not isWeaponSkill then
        skillLevel = getSkillLevel(attack, skillID, activeTeamInfo, cardParam[3])
      else
        skillLevel = attack.actorInfo.uniqueWeaponPhase or 1
      end
      local newInput = {}
      newInput.attackId = attack.actorInfo.uid
      newInput.targetId = target.actorInfo.uid
      newInput.attackBaseAttrs = attack.actorInfo.attrs
      newInput.targetBaseAttrs = target.actorInfo.attrs
      if totalHit ~= nil then
        newInput.addroleCount = 1
        newInput.attackCount = totalHit
      else
        newInput.addroleCount = tonumber(str_Arr2[3])
        newInput.attackCount = tonumber(str_Arr2[4])
      end
      newInput.attackType = tonumber(str_Arr2[5])
      newInput.attackSkillAttrs = getActorTalentSkillDamage(attack, actionParam[2].num)
      newInput.skillId = skillID
      newInput.skillAction = action
      newInput.skillLevel = skillLevel
      newInput.totalHitCount = hitCountTable[attack]
      local inputCount = tonumber(str_Arr2[8])
      local buffIndexTable = {}
      local buffIndex = getActionBuff(skillID, action, str_Arr2[6], tonumber(str_Arr2[7]), attack.buffIndex)
      if buffIndex then
        local preBuff = collectActorBuff(target)
        local result, isContinuesTrigger = buffLogic(buffIndex, skillLevel, teamList, attack, target, {
          actionParam[1],
          0,
          9999
        })
        buffIndexTable[target.uniqueID] = result
        if isContinuesTrigger then
          SA.handlerContinuesTrigger(buffIndex, skillLevel, teamList, target, {
            actionParam[1],
            0,
            9999,
            isContinues = true
          })
          FH.blendAllActorBuff(buffIndexTable, teamList)
        end
        local curBuff = collectActorBuff(target)
        actionParam[9] = getRefreshBuff(curBuff, preBuff)
        local addBuffs, removeBuffs = getChangeBuff(curBuff, preBuff)
        curBuff = nil
        preBuff = nil
        if not table.empty(removeBuffs) or not table.empty(addBuffs) then
          actionParam.removeBuffs = removeBuffs
          actionParam.addBuffs = addBuffs
          processBlendActorBuff(buffIndexTable, attack, PB.enum.IdentityCategory.Self, {target}, teamList, PB.enum.Timing.BuffChange, actionParam)
          processBlendActorBuff(buffIndexTable, target, PB.enum.IdentityCategory.Targets, {attack}, teamList, PB.enum.Timing.BuffChange, actionParam)
        end
        processBlendActorBuff(buffIndexTable, attack, PB.enum.IdentityCategory.Self, {target}, teamList, PB.enum.Timing.BuffRefresh, actionParam)
        processBlendActorBuff(buffIndexTable, target, PB.enum.IdentityCategory.Targets, {attack}, teamList, PB.enum.Timing.BuffRefresh, actionParam)
      end
      local attIndex = tonumber(str_Arr2[9])
      if attIndex == 0 and not attack.rtAttBuffOnce then
        attack.rtAttBuffOnce = true
        processBlendActorBuff(buffIndexTable, attack, PB.enum.IdentityCategory.Self, {target}, teamList, PB.enum.Timing.FirstAttack, actionParam)
      end
      if not isActorHaveBuff(attack, target.uniqueID) then
        processBlendActorBuff(buffIndexTable, attack, PB.enum.IdentityCategory.Self, {target}, teamList, PB.enum.Timing.EveryAttack, actionParam)
      end
      if target.team ~= attack.team and not target.rtHurtBuffOnce then
        target.rtHurtBuffOnce = true
        processBlendActorBuff(buffIndexTable, target, PB.enum.IdentityCategory.Targets, {attack}, teamList, PB.enum.Timing.FirstAttack, actionParam)
      end
      newInput.attackAttrs = attack.dynamicAttrs
      newInput.targetAttrs = target.dynamicAttrs
      newInput.attackBuffAttrs = FH.getRuntimeAttrBuff(attack)
      newInput.targetBuffAttrs = FH.getRuntimeAttrBuff(target)
      local newInfo = {}
      newInfo.action = action
      newInfo.skillID = skillID
      if isWeaponSkill then
        newInfo.outPut = {
          result = 0,
          critical = false,
          boundVal = 0,
          physical = 0,
          magical = 0,
          showType = 0
        }
      else
        newInfo.outPut = hurtCalculate(newInput, dungeonType)
      end
      newInfo.hitCount = inputCount
      table.insert(hitList, newInfo)
      if noDamage then
        newInfo.outPut.physical = 0
        newInfo.outPut.magical = 0
        newInfo.outPut.result = 0
      end
      if 0 > newInfo.outPut.result then
        local physicalPer = newInfo.outPut.physical / newInfo.outPut.result
        newInfo.outPut.result = absoluteHurtByBuff(attack, target, newInfo.outPut.result, hitCountTable[attack], cardParam)
        newInfo.outPut.result = absoluteHurtBySkillDamageChange(attack, target, newInfo.outPut.result, hitCountTable[attack], cardParam)
        newInfo.outPut.physical = math.floor(newInfo.outPut.result * physicalPer)
        newInfo.outPut.magical = math.floor(newInfo.outPut.result * (1 - physicalPer))
        newInfo.outPut.result = newInfo.outPut.physical + newInfo.outPut.magical
        local shield_result = shieldHurtByBuff(attack, target, -newInfo.outPut.physical, -newInfo.outPut.magical, inputCount, actionParam[1])
        newInfo.outPut.physical = newInfo.outPut.physical + shield_result[1]
        newInfo.outPut.magical = newInfo.outPut.magical + shield_result[2]
        newInfo.outPut.result = newInfo.outPut.physical + newInfo.outPut.magical
        if 0 > newInfo.outPut.result then
          newInfo.outPut.boundVal = calcBoundHurtByBuff(attack, target, newInfo.outPut.result, hitCountTable[attack])
          if newInfo.outPut.boundVal ~= 0 then
            newInfo.boundID = attack.uniqueID
          end
        else
          newInfo.outPut.showType = 0
        end
        if shield_result[3] then
          if shield_result.isBroken then
            local triggerInfo = {}
            for i = 1, #target.buffList do
              local buff = target.buffList[i]
              local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
              if buffData.type == PB.enum.BuffFightType.SpecialAttrChange and buff.state ~= PB.enum.BuffFightState.Delete then
                local definition = DEFINE.BuffFightType[buffData.type]
                if definition[buffData.paramInt[2]] == "shieldBroked" then
                  table.insert(triggerInfo, {
                    attack = attack,
                    target = target,
                    buff = buff
                  })
                end
              end
            end
            SA.TriggerEachSpecialAttr(triggerInfo, teamList, actionParam)
            FH.blendAllActorBuff(buffIndexTable, teamList)
          else
            local shield_table = {}
            shield_table[target.uniqueID] = FH.copyActorBuff(target)
            FH.blendActorBuff(buffIndexTable, shield_table)
          end
        end
      end
      if 0 < newInfo.outPut.result then
        newInfo.outPut.result = FH.changeHpAddByBuff(target, newInfo.outPut.result)
      end
      actionParam[12] = newInfo.outPut.result
      if newInfo.outPut.critical then
        actionParam[13] = 1
      end
      if attIndex == 0 and not attack.rtAttBuffAfterOnce then
        attack.rtAttBuffAfterOnce = true
        processBlendActorBuff(buffIndexTable, attack, PB.enum.IdentityCategory.Self, {target}, teamList, PB.enum.Timing.FirstAttackAfter, actionParam)
      end
      if not isActorHaveBuffAfter(attack, target.uniqueID) then
        processBlendActorBuff(buffIndexTable, attack, PB.enum.IdentityCategory.Self, {target}, teamList, PB.enum.Timing.EveryAttackAfter, actionParam)
      end
      if not target.rtHurtBuffAfterOnce then
        target.rtHurtBuffAfterOnce = true
        processBlendActorBuff(buffIndexTable, target, PB.enum.IdentityCategory.Targets, {attack}, teamList, PB.enum.Timing.FirstAttackAfter, actionParam)
      end
      newInfo.buffKey = {}
      newInfo.buffResult = {}
      for k, v in pairs(buffIndexTable) do
        if 0 < #v then
          table.insert(newInfo.buffKey, k)
          local listTable = {}
          listTable.listInfo = v
          listTable.hpChange = FH.copyActorOnceHp(nil, teamList, k)
          table.insert(newInfo.buffResult, listTable)
        end
      end
      if 0 >= target.dynamicAttrs[HP_INDEX].value then
        newInfo.outPut.boundVal = 0
        newInfo.boundID = 0
      end
      local totalHurtVal = newInfo.outPut.result * inputCount
      if totalHurtVal < 0 then
        TS.damageList(activeTeamInfo, attack, -totalHurtVal)
        targetTeamInfo.statistic.totalDamage = targetTeamInfo.statistic.totalDamage - totalHurtVal
        TLog.CollectSkillDamage({
          action = "doing",
          allInfo = actionParam,
          hurtVal = totalHurtVal,
          hitNum = inputCount,
          isCritical = newInfo.outPut.critical
        })
      end
      FH.DynamicHpChange(target, totalHurtVal, true, 0)
      local totalBoundVal = newInfo.outPut.boundVal * inputCount
      if totalBoundVal < 0 then
        TS.damageList(targetTeamInfo, target, -totalBoundVal)
        activeTeamInfo.statistic.totalDamage = activeTeamInfo.statistic.totalDamage - totalBoundVal
      end
      FH.DynamicHpChange(attack, totalBoundVal, false, 0)
      CombatDataRecorder.setHurtData(attack.uniqueID, target.uniqueID, totalHurtVal, attack.team)
      if 0 >= target.dynamicAttrs[HP_INDEX].value and not target.rtDeadOnce then
        target.rtDeadOnce = true
        if kill_table[attack] == nil then
          kill_table[attack] = {target}
        else
          local list = kill_table[attack]
          local find = false
          for j = 1, #list do
            if list[j] == target then
              find = true
              break
            end
          end
          if not find then
            table.insert(list, target)
          end
        end
      end
    end
  end
  if hitCount == nil then
    processActorDead(target, targetTeamInfo, teamList, actionParam)
  end
end

function processActorDead(kill_table, target, targetTeamInfo, teamList, actionParam)
  if target.dynamicAttrs[HP_INDEX].value > 0 then
    return
  end
  local lifeVal = 0
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.KeepAlive and FH.isRandomChanceMet(buffData.paramInt[1]) then
      FH.deleteBuff(buff, actionParam[1], target)
      local percent = math.min(buff.val / 10000, 1)
      lifeVal = percent * FH.getActorBaseAttr(target, HP_INDEX)
      lifeVal = math.floor(math.max(lifeVal, 1))
      TLog.NotifyKeepAlive()
      break
    end
  end
  if lifeVal ~= 0 then
    target.dynamicAttrs[HP_INDEX].value = lifeVal
  else
    target.seat = 0
    for b = 1, #target.buffList do
      local buff = target.buffList[b]
      FH.deleteBuff(buff, actionParam[1], target)
    end
    targetTeamInfo.statistic.aliveCount = targetTeamInfo.statistic.aliveCount - 1
    local kill_id = 0
    for k, v in pairs(kill_table) do
      for j = 1, #v do
        if v[j] == target then
          kill_id = k.actorInfo.id
          break
        end
      end
    end
    local deadInfo = {}
    deadInfo.id = kill_id * 10000 + target.actorInfo.id
    deadInfo.seat = target.baseSeat
    local kind = 0
    local cardInfo = actionParam[2]
    if cardInfo.isBigSkill then
      kind = 1
    elseif cardInfo.isLinkSkill then
      kind = 2
    elseif not cardInfo.isAssistSkill then
      if cardInfo.num == 1 then
        kind = 3
      elseif cardInfo.num == 2 then
        kind = 4
      end
    else
      kind = 5
    end
    deadInfo.kind = kind
    table.insert(targetTeamInfo.statistic.deadInfo, deadInfo)
    local actorTable = FH.getAllActors(teamList, false)
    for k = 1, #actorTable do
      local ownerIdentityCategory = PB.enum.IdentityCategory.Self
      if actorTable[k] ~= target then
        if actorTable[k].team == target.team then
          ownerIdentityCategory = PB.enum.IdentityCategory.SelfTeam
        else
          ownerIdentityCategory = PB.enum.IdentityCategory.TargetTeam
        end
      end
      SA.SpecialAttrLogic(actorTable[k], ownerIdentityCategory, {}, teamList, PB.enum.Timing.Die, actionParam)
    end
  end
end

function collectActorBuff(actor)
  local buffList = FH.copyActorBuff(actor)
  local result = {}
  for i = 1, #buffList do
    if buffList[i].state ~= PB.enum.BuffFightState.Delete then
      table.insert(result, buffList[i])
    end
  end
  return result
end

function getChangeBuff(buff1, buff2)
  local buffKey = {}
  local shouldRemoveFromBuff1 = {}
  for i = 1, #buff1 do
    local buff = buff1[i]
    local key = tostring(buff.buffKey.id) .. tostring(buff.buffKey.owner) .. tostring(buff.indexId) .. tostring(buff.ownerUid)
    buffKey[key] = i
  end
  for i = #buff2, 1, -1 do
    local buff = buff2[i]
    local key = tostring(buff.buffKey.id) .. tostring(buff.buffKey.owner) .. tostring(buff.indexId) .. tostring(buff.ownerUid)
    if buffKey[key] then
      table.remove(buff2, i)
      table.insert(shouldRemoveFromBuff1, buffKey[key])
    end
  end
  table.sort(shouldRemoveFromBuff1, function(a, b)
    return b < a
  end)
  for i = 1, #shouldRemoveFromBuff1 do
    local rmi = shouldRemoveFromBuff1[i]
    table.remove(buff1, rmi)
  end
  return buff1, buff2
end

function getRefreshBuff(buff1, buff2)
  local result = {}
  for i = 1, #buff1 do
    local find = false
    for j = 1, #buff2 do
      if buff1[i].buffKey.id == buff2[j].buffKey.id and buff1[i].buffKey.owner == buff2[j].buffKey.owner and buff1[i].indexId == buff2[j].indexId and buff1[i].ownerUid == buff2[j].ownerUid and (buff1[i].round > buff2[j].round or buff1[i].stack > buff2[j].stack or buff1[i].exRound > buff2[j].exRound) then
        find = true
        break
      end
    end
    if find then
      table.insert(result, buff1[i])
    end
  end
  return result
end

function isActorHaveBuff(actor, uniqueID)
  for i = 1, #actor.rtAttBuffList do
    if actor.rtAttBuffList[i] == uniqueID then
      return true
    end
  end
  table.insert(actor.rtAttBuffList, uniqueID)
  return false
end

function isActorHaveBuffAfter(actor, uniqueID)
  for i = 1, #actor.rtAttBuffAfterList do
    if actor.rtAttBuffAfterList[i] == uniqueID then
      return true
    end
  end
  table.insert(actor.rtAttBuffAfterList, uniqueID)
  return false
end

function isTeamAssistHaveBuff(teamInfo, attack, index)
  local key = attack.uniqueID .. "_" .. index
  for i = 1, #teamInfo.rtAssistBuffList do
    if teamInfo.rtAssistBuffList[i] == key then
      return true
    end
  end
  table.insert(teamInfo.rtAssistBuffList, key)
  return false
end

function getAttackBySkillID(teamInfo, cardList, skillID, linkID)
  local find_actorID = FH.getIntPart(skillID / 1000)
  local actor
  for i = 1, #cardList do
    local checkCard = cardList[i]
    actor = FH.getActorByUid(teamInfo, checkCard.actorRuntimeID)
    if actor ~= nil then
      break
    end
  end
  if actor ~= nil then
    if linkID == 0 then
      if actor.actorInfo.id ~= find_actorID then
        warning("GamePlay", "ERROR Actor " .. actor.actorInfo.id)
        return nil
      elseif 0 >= actor.dynamicAttrs[HP_INDEX].value then
        warning("GamePlay", "ERROR HP " .. find_actorID)
        return nil
      else
        return actor
      end
    else
      local result_id_table = FH.getTeamLinkActorTable(teamInfo, linkID, actor.uniqueID)
      for i = 1, #result_id_table do
        local link_actor = FH.getActorByUid(teamInfo, result_id_table[i])
        if link_actor ~= nil and link_actor.actorInfo.id == find_actorID then
          return link_actor
        end
      end
    end
  end
  warning("GamePlay", "Not Find Skill Actor " .. find_actorID)
  return nil
end

function getActorTalentSkillDamage(actor, skillIndex)
  local total = {}
  for i = 1, #actor.dynamicTalent do
    local talent = actor.dynamicTalent[i]
    local result = getAddDamageResult(actor, skillIndex, talent.talentId, talent.talentValue)
    for k, v in pairs(result) do
      local base = total[k]
      if base == nil then
        base = 0
      end
      total[k] = base + v
    end
  end
  local attrList = {}
  for k, v in pairs(total) do
    local newAttr = {}
    newAttr.type = k
    newAttr.val = v
    table.insert(attrList, newAttr)
  end
  return attrList
end

function getAddDamageResult(actor, skillIndex, index, level)
  local result = {}
  local info = PB.get("SpecialAttrInfo", index)
  if info ~= nil and info.ownerIdentityCategory == 11 and info.targetIdentityCategory == skillIndex then
    local maxLevel = math.max(1, info.maxLevel - 1)
    local levelInfo = PB.get("SpecialLevelUpIndex", index)
    if levelInfo ~= nil then
      for i = 1, #levelInfo.attrs do
        local result_val = levelInfo.attrs[i].value * (1 + (levelInfo.upRate[i] - 10000) / 10000 * (level - 1) / maxLevel)
        result[levelInfo.attrs[i].type] = math.floor(result_val)
      end
    end
  end
  return result
end

function getActionBuff(skillID, action, logic, addrole, index)
  if index == nil then
    warning("GamePlay", skillID)
    index = 0
  end
  local buffinfo = PB.get("ActionBuff", skillID, action, addrole, logic)
  if buffinfo then
    return buffinfo.buffIndex[index + 1]
  end
  return nil
end

function getSkillLevel(actor, skillID, activeTeamInfo, linkID)
  if 0 < linkID then
    local link_list = activeTeamInfo.linkInfoList
    for l = 1, #link_list do
      if link_list[l].linkID == linkID then
        local result = link_list[l].uidList
        for j = 1, #result do
          if result[j] == actor.uniqueID then
            return link_list[l].totalStar
          end
        end
      end
    end
  end
  local level = 1
  for i = 1, #actor.actorInfo.skills do
    if actor.actorInfo.skills[i].id == skillID then
      return actor.actorInfo.skills[i].level
    end
  end
  warning("GamePlay", "ERROR " .. skillID)
  return level
end

function absoluteHurtByBuff(attack, target, hurt, hitCount, cardParam)
  local result = hurt
  local attackPercentVal = 0
  local attackChangeVal = 0
  local ignoreTargetAbHurtBuff = false
  local attrTransAbHurtDef = DEFINE.BuffFightType[PB.enum.BuffFightType.AttrTransAbHurt]
  for i = 1, #attack.buffList do
    local buff = attack.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete then
      if buffData.type == PB.enum.BuffFightType.AbHurt then
        if buffData.paramInt[1] == 1 then
          local param = buffData.paramInt[3]
          local val = buff.val
          if param == 0 or param == nil then
            attackChangeVal = attackChangeVal + val
          else
            attackPercentVal = attackPercentVal + val / 10000
          end
        end
      elseif buffData.type == PB.enum.BuffFightType.AttrTransAbHurt and attrTransAbHurtDef[buffData.paramInt[1]] == "attack" then
        attackPercentVal = attackPercentVal + buff.val / 10000
      elseif buffData.type == PB.enum.BuffFightType.Ignore and buffData.paramInt[1] == PB.enum.BuffFightType.AbHurt then
        ignoreTargetAbHurtBuff = true
      end
    end
  end
  local targetPercentVal = 0
  local targetChangeVal = 0
  local ignoreLimitation = false
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    ignoreTargetAbHurtBuff = ignoreTargetAbHurtBuff and (buffData.type ~= PB.enum.BuffFightType.AbHurt or buffData.paramInt[4] ~= 1)
    ignoreLimitation = ignoreLimitation or buffData.type == PB.enum.BuffFightType.AbHurt and buffData.paramInt[4] == 1
    if buff.state ~= PB.enum.BuffFightState.Delete and (0 <= buff.val or not ignoreTargetAbHurtBuff) then
      if buffData.type == PB.enum.BuffFightType.AbHurt and buffData.paramInt[1] == 2 then
        local param = buffData.paramInt[3]
        if param == 0 or param == nil then
          targetChangeVal = targetChangeVal + buff.val
        else
          targetPercentVal = targetPercentVal + buff.val / 10000
        end
      elseif buffData.type == PB.enum.BuffFightType.AttrTransAbHurt and attrTransAbHurtDef[buffData.paramInt[1]] == "target" then
        targetPercentVal = targetPercentVal + buff.val / 10000
      end
    end
  end
  attackPercentVal = math.max(attackPercentVal, -1)
  targetPercentVal = math.max(targetPercentVal, -1)
  if hitCount == nil or hitCount == 0 then
    hitCount = 1
  end
  local finalPer = attackPercentVal + targetPercentVal
  if not ignoreLimitation then
    finalPer = math.max(finalPer, -0.8)
  end
  result = hurt * (1 + finalPer) - attackChangeVal / hitCount - targetChangeVal / hitCount
  if 0 <= result then
    result = -1
  end
  return math.floor(result)
end

function absoluteHurtBySkillDamageChange(attack, target, hurt, hitCount, cardParam)
  local result = hurt
  local attackPercentVal = 0
  local attackChangeVal = 0
  for i = 1, #attack.buffList do
    local buff = attack.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.SkillDamageChange then
      local kind = buffData.paramInt[1]
      if FH.CheckSkillMatch(kind, attack.actorInfo.id, attack.isAssist, cardParam[1], cardParam[2], cardParam[3]) then
        local val = buff.val
        local param = buffData.paramInt[2]
        if param == 0 or param == nil then
          attackChangeVal = attackChangeVal + val
        else
          attackPercentVal = attackPercentVal + val / 10000
        end
      end
    end
  end
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.SkillDamageAffect then
      local kind = buffData.paramInt[1]
      if FH.CheckSkillMatch(kind, attack.actorInfo.id, attack.isAssist, cardParam[1], cardParam[2], cardParam[3]) then
        local val = buff.val
        local param = buffData.paramInt[2]
        if param == 0 or param == nil then
          attackChangeVal = attackChangeVal + val
        else
          attackPercentVal = attackPercentVal + val / 10000
        end
      end
    end
  end
  attackPercentVal = math.max(attackPercentVal, -1)
  if hitCount == nil or hitCount == 0 then
    hitCount = 1
  end
  local finalPer = math.max(attackPercentVal, -0.8)
  result = hurt * (1 + finalPer) - attackChangeVal / hitCount
  if 0 <= result then
    result = -1
  end
  return math.floor(result)
end

function calcBoundHurtByBuff(attack, target, hurt, hitCount)
  if attack.isAssist then
    return 0
  end
  if hitCount == nil or hitCount == 0 then
    hitCount = 1
  end
  local per_val = 0
  local change_val = 0
  local attack_val = 0
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.Rebound then
      local val = buffData.paramInt[1]
      if val == 1 then
        per_val = per_val + buff.val / 10000
      elseif val == 2 then
        change_val = change_val + buff.val / hitCount
      elseif val == 3 then
        attack_val = attack_val - buff.val / hitCount
      end
    end
  end
  local max_hurt = -math.min(target.dynamicAttrs[HP_INDEX].value, -hurt)
  local result = max_hurt * per_val
  return math.floor(result + change_val + attack_val)
end

function shieldHurtByBuff(attack, target, physical, magical, count, gameRound)
  local ignoreTargetBuff = false
  for i = 1, #attack.buffList do
    local buff = attack.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.Ignore and buffData.paramInt[1] == PB.enum.BuffFightType.Shield then
      ignoreTargetBuff = true
    end
  end
  if ignoreTargetBuff then
    return {
      0,
      0,
      false
    }
  end
  local leftPhysical = physical
  local leftMagical = magical
  local buff_change = false
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.Shield then
      local kind = buffData.paramInt[1]
      local physicalxishou = buffData.paramInt[2] / 10000
      local magicalxishou = buffData.paramInt[2] / 10000
      if kind == 1 then
        magicalxishou = 0
      elseif kind == 2 then
        physicalxishou = 0
      end
      physicalxishou = math.floor(physicalxishou * physical)
      magicalxishou = math.floor(magicalxishou * magical)
      if 0 < leftPhysical then
        if buff.val >= physicalxishou * count then
          leftPhysical = leftPhysical - physicalxishou
          buff.val = buff.val - physicalxishou * count
        else
          leftPhysical = leftPhysical - math.floor(buff.val / count)
          buff.val = 0
        end
      end
      if 0 < leftMagical then
        if buff.val >= magicalxishou * count then
          leftMagical = leftMagical - magicalxishou
          buff.val = buff.val - magicalxishou * count
        else
          leftMagical = leftMagical - math.floor(buff.val / count)
          buff.val = 0
        end
      end
      if buff.val == 0 then
        FH.deleteBuff(buff, gameRound, target)
        buff_change = true
      end
    end
  end
  leftPhysical = math.max(leftPhysical, 0)
  leftMagical = math.max(leftMagical, 0)
  local xishouPhysical = math.floor(physical - leftPhysical)
  local xishouMagical = math.floor(magical - leftMagical)
  return {
    xishouPhysical,
    xishouMagical,
    buff_change,
    isBroken = buff_change
  }
end

function isUseCardLegal(teamInfo, cardList, debugMode)
  for i = 1, #cardList do
    local checkCard = cardList[i]
    local uid = checkCard.actorRuntimeID
    if not isActorAlive(teamInfo, uid) then
      warning("GamePlay", "lua - actor is dead " .. uid)
      return false
    end
  end
  local delList = {}
  for i = 1, #cardList do
    local checkCard = cardList[i]
    for c = 1, #teamInfo.cardsInHand do
      local selfcard = teamInfo.cardsInHand[c]
      if selfcard.index == checkCard.index then
        if selfcard.lock then
          if not FH.isInfiniteCard(teamInfo.dungeonType, teamInfo.team) then
            warning("GamePlay", "card is lock or invalid " .. checkCard.actorRuntimeID)
          end
          return false
        else
          table.insert(delList, selfcard)
          break
        end
      end
    end
  end
  for i = 1, #delList do
    local card = delList[i]
    for k = 1, #teamInfo.cardsInHand do
      if teamInfo.cardsInHand[k] == card then
        local del = true
        if debugMode == 1 then
          del = false
        end
        if del then
          card.useCount = card.useCount - 1
          if card.useCount < 0 then
            card.useCount = 0
            warning("GamePlay", "error card count " .. card.actorRuntimeID)
            return false
          end
        end
        break
      end
    end
  end
  return true
end

function isActorAlive(teamInfo, id)
  for j = 1, #teamInfo.playerList do
    local actorList = teamInfo.playerList[j].actorList
    for k = 1, #actorList do
      if actorList[k].uniqueID == id then
        if actorList[k].dynamicAttrs[HP_INDEX].value > 0 then
          return true
        else
          return false
        end
      end
    end
  end
  warning("GamePlay", "actor not alive " .. id)
  return false
end

function getSkillHitResult(id, card, scard, selfSeat, teamtype1, teamtype2)
  if id == 0 then
    return nil
  end
  local info = PB.get("SkillHit", id, card, scard, selfSeat, teamtype1, teamtype2)
  if info ~= nil then
    return info
  end
  warning("GamePlay", "no skill hit info id = " .. id .. " card = " .. card .. " scard = " .. scard .. " selfSeat = " .. selfSeat .. " teamtype1 = " .. teamtype1 .. " teamtype2 = " .. teamtype2)
  return nil
end

function getHitString(result)
  if result == "" or result == "0" or result == "0.0" then
    result = nil
  end
  return result
end

function getHitCountKey(str)
  return str[1] .. "," .. str[2] .. "," .. str[5]
end

function getActionHitTable(indexID, nCardID, sCardID)
  local resultTable = {}
  if indexID == 0 then
    return resultTable
  end
  local max_count = 0
  local max_info = PB.get("SkillHitIndex", indexID, nCardID, sCardID)
  if max_info == nil then
    warning("GamePlay", "not find hit index " .. indexID .. " " .. nCardID .. " " .. sCardID)
    local hit_data = PB.all("SkillHit")
    for i = 1, #hit_data do
      local hit = hit_data[i]
      if hit.id == indexID and hit.card == nCardID and hit.sCard == sCardID then
        local one_count = 0
        for index = 1, DEFINE.ACTOR_NUM do
          local hitStr = getHitString(hit.hitList[index])
          if hitStr ~= nil then
            local str_Arr = string.split(hitStr, ";")
            for j = 1, #str_Arr do
              if str_Arr[j] ~= "" then
                local str_Arr2 = string.split(str_Arr[j], ",")
                local hitCount = tonumber(str_Arr2[8])
                one_count = one_count + hitCount
              end
            end
          end
        end
        if max_count < one_count then
          max_count = one_count
          max_info = hit
        end
      end
    end
  end
  if max_info ~= nil then
    for index = 1, DEFINE.ACTOR_NUM do
      local hitStr = getHitString(max_info.hitList[index])
      if hitStr ~= nil then
        local str_Arr = string.split(hitStr, ";")
        for j = 1, #str_Arr do
          if str_Arr[j] ~= "" then
            local str_Arr2 = string.split(str_Arr[j], ",")
            local hitCount = tonumber(str_Arr2[8])
            local key = getHitCountKey(str_Arr2)
            if resultTable[key] == nil then
              resultTable[key] = hitCount
            else
              resultTable[key] = resultTable[key] + hitCount
            end
          end
        end
      end
    end
  else
    warning("GamePlay", "not find max_info indexID = " .. indexID)
  end
  return resultTable
end

return useCard
