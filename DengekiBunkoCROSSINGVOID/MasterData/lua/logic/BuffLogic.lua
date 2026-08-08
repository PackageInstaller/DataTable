local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local TLog = require("Common/TlogUtil")
local DEFINE = require("Logic/Define")
local TS = require("Logic/Statistic")

local function ChangeBuffRound(target, currentBuffData, onceForAll)
  local val = 0
  
  local function SelectBuff(buffData, currentBuffData)
    local param_list = buffData.paramInt
    local definition = {
      "Type&SubType",
      "Category"
    }
    if definition[param_list[1]] == "Type&SubType" then
      if currentBuffData.type == param_list[2] and (param_list[3] == nil or param_list[3] == 0 or currentBuffData.paramInt[1] == param_list[3]) then
        return true
      end
    elseif definition[param_list[1]] == "Category" and table.has(currentBuffData.categoryList, param_list[2]) then
      return true
    end
  end
  
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and (buffData.type == PB.enum.BuffFightType.BuffRoundChange or onceForAll) then
      if onceForAll then
        if SelectBuff(currentBuffData, buffData) then
          buff.round = buff.round + currentBuffData.paramInt[4]
        end
      elseif SelectBuff(buffData, currentBuffData) then
        val = val + buff.val
      end
    end
  end
  return val
end

local function SelectBuffInBuffListByCategory(buffList, targetCategory)
  local selectedBuff = table.select(buffList, function(v)
    if v.state == PB.enum.BuffFightState.Delete then
      return nil
    end
    local buffData = FH.getBuffData(v.buffKey.id, v.buffKey.owner)
    local map = {}
    for i = 1, #buffData.categoryList do
      map[buffData.categoryList[i]] = true
    end
    if map[targetCategory] ~= nil then
      return v
    end
  end)
  return table.distinct(selectedBuff)
end

local function hpChange(attack, buff, buffData, kind, val, childType, kindTable)
  local buffType = buffData.type
  local sign_type = 0
  if 0 <= val then
    sign_type = 1
  else
    sign_type = 2
  end
  local one_change_val = 0
  local base_change_val = 0
  attack = (kind == 6 or kind == 7) and kindTable.weaponUser or attack
  if kind == 1 then
    local temp_result = FH.getChangeBuffVal(buffType, childType, sign_type, attack, 1)
    if sign_type == 1 then
      one_change_val = math.max(0, val + temp_result)
    else
      one_change_val = math.min(0, val + temp_result)
    end
  elseif kind == 2 then
    base_change_val = attack.dynamicAttrs[PB.enum.AttrType.Hp].value
  elseif kind == 3 or kind == 6 then
    base_change_val = FH.getActorBaseAttr(attack, PB.enum.AttrType.Hp)
  elseif kind == 4 then
    local attackPercentVal = 0
    local attackChangeVal = 0
    for i = 1, #attack.buffList do
      local buff = attack.buffList[i]
      local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
      if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.AbHurt and buffData.paramInt[1] == 1 then
        local param = buffData.paramInt[3]
        local one_val = buff.val
        if param == 0 or param == nil then
          attackChangeVal = attackChangeVal + one_val
        else
          attackPercentVal = attackPercentVal + one_val / 10000
        end
      end
    end
    attackPercentVal = math.max(attackPercentVal, -0.8)
    base_change_val = attack.dynamicAttrs[PB.enum.AttrType.Attack].value * (1 + attackPercentVal) + attackChangeVal
  elseif (kind == 5 or kind == 7) and buffData.type == PB.enum.BuffFightType.HpChange then
    local baseHp = FH.getActorBaseAttr(attack, PB.enum.AttrType.Hp)
    local curHp = attack.dynamicAttrs[PB.enum.AttrType.Hp].value
    baseHp = baseHp * (buffData.paramInt[6] or 10000) / 10000
    base_change_val = math.min(curHp, baseHp)
  end
  if base_change_val ~= 0 then
    local temp_result = FH.getChangeBuffVal(buffType, childType, sign_type, attack, 0, buff.stack)
    if sign_type == 1 then
      one_change_val = math.max(0, base_change_val * (val + temp_result) / 10000)
    else
      one_change_val = math.min(0, base_change_val * (val + temp_result) / 10000)
    end
  end
  if 0 < one_change_val then
    one_change_val = math.max(math.floor(one_change_val + 0.5), 1)
    if (buffType == PB.enum.BuffFightType.HpImmeChange or buffType == PB.enum.BuffFightType.ActionFeedBack) and buffData.paramInt[3] and 0 < buffData.paramInt[3] then
      one_change_val = math.min(one_change_val, buffData.paramInt[3])
    end
  end
  if one_change_val < 0 then
    one_change_val = math.min(math.floor(one_change_val + 0.5), -1)
    if (buffType == PB.enum.BuffFightType.HpImmeChange or buffType == PB.enum.BuffFightType.ActionFeedBack) and buffData.paramInt[3] and 0 < buffData.paramInt[3] then
      one_change_val = math.max(one_change_val, -buffData.paramInt[3])
    end
  end
  buff.val = one_change_val * buff.stack
end

local function canAddBuff(buffInfo, target, id, owner)
  local result = true
  for i = 1, #target.buffList do
    if not result then
      break
    end
    local buff = target.buffList[i]
    local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.Immune then
      local buffDataNum = #buffData.paramInt
      if 0 < buffDataNum and buffDataNum % 2 == 0 then
        for i = 1, buffDataNum, 2 do
          local type = buffData.paramInt[i]
          local category = buffData.paramInt[i + 1]
          if buffInfo.type == type and table.has(buffInfo.categoryList, category) then
            info("GamePlay", "New buff is not added due to Immune")
            result = false
            break
          end
        end
      else
        error("GamePlay", "BuffData ParamInt for Immune must be paris: <type, category>")
      end
    end
  end
  return result
end

local function getBuffVal(buffType, param_list)
  local paramVal = 0
  if buffType == PB.enum.BuffFightType.AbHurt then
    paramVal = param_list[2]
  elseif buffType == PB.enum.BuffFightType.Attr then
    paramVal = param_list[3]
  elseif buffType == PB.enum.BuffFightType.Rebound then
    paramVal = param_list[2]
  elseif buffType == PB.enum.BuffFightType.KeepAlive then
    paramVal = param_list[2]
  elseif buffType == PB.enum.BuffFightType.HpAddChange then
    paramVal = param_list[1]
  elseif buffType == PB.enum.BuffFightType.MpOnceChange then
    paramVal = param_list[1]
  elseif buffType == PB.enum.BuffFightType.SpOnceChange then
    paramVal = param_list[1]
  elseif buffType == PB.enum.BuffFightType.CostChange then
    paramVal = param_list[1]
  elseif buffType == PB.enum.BuffFightType.SkillDamageChange then
    paramVal = param_list[3]
  elseif buffType == PB.enum.BuffFightType.SkillDamageAffect then
    paramVal = param_list[3]
  elseif buffType == PB.enum.BuffFightType.ChangeRoundAddMp then
    paramVal = param_list[1]
  elseif buffType == PB.enum.BuffFightType.SpRateChange then
    paramVal = param_list[2]
  elseif buffType == PB.enum.BuffFightType.SpToMp then
    paramVal = param_list[2]
  elseif buffType == PB.enum.BuffFightType.BuffValChange then
    paramVal = param_list[3]
  elseif buffType == PB.enum.BuffFightType.BuffRoundChange then
    paramVal = param_list[4]
  elseif buffType == PB.enum.BuffFightType.AttrTransmission then
    paramVal = param_list[3]
  end
  if paramVal == nil then
    warning("GamePlay", "error param type = " .. buffType .. " param = " .. table.dump(param_list))
    paramVal = 0
  end
  return paramVal
end

function addActorBuff(attack, target, id, owner, level, kindTable, mergestate, mergelist)
  local buffData = FH.getBuffData(id, owner)
  if buffData == nil then
    warning("GamePlay", "not find buff data    id = " .. id .. " owner = " .. owner)
    return nil
  end
  if canAddBuff(buffData, target, id, owner) == false then
    return nil
  end
  local continuesTrigger = false
  local attackid = 0
  local userUniqueId = 0
  local showid = 0
  if attack ~= nil then
    attackid = attack.uniqueID
    if kindTable[2] ~= DEFINE.TalentFlagDEF.IgnoreShowId then
      if DEFINE.IsWeapon(attack) then
        showid = -attack.actorInfo.id
        userUniqueId = kindTable.userUniqueId or 0
      else
        showid = attack.actorInfo.id
      end
    end
  end
  local indexid = 0
  if kindTable[3] ~= nil then
    indexid = kindTable[3]
  end
  local buff
  local isRefresh = false
  for i = 1, #target.buffList do
    if (target.buffList[i].indexId == indexid or buffData.ignoreAttacker) and (target.buffList[i].ownerUid == attackid or buffData.ignoreAttacker) and target.buffList[i].buffKey.id == id and target.buffList[i].buffKey.owner == owner then
      if target.buffList[i].state ~= PB.enum.BuffFightState.Delete then
        buff = target.buffList[i]
        isRefresh = true
        break
      end
      buff = target.buffList[i]
      buff.round = 0
      buff.stack = 0
      buff.val = 0
      buff.state = PB.enum.BuffFightState.Alive
      buff.exRound = 0
      buff.mergeState = mergestate
      buff.mergeList = {}
      buff.removeType = 0
      buff.ownerUid = attackid
      buff.userUniqueId = userUniqueId
      buff.sourceId = showid
      buff.indexId = indexid
      buff.contentVal = 0
      buff.rate = 0
      buff.isNewHit = false
      buff.level = level
      buff.talentFlag = kindTable[2]
      break
    end
  end
  if buff == nil then
    buff = {
      buffKey = {id = id, owner = owner},
      round = 0,
      stack = 0,
      val = 0,
      state = PB.enum.BuffFightState.Alive,
      exRound = 0,
      mergeState = mergestate,
      mergeList = {},
      removeType = 0,
      ownerUid = attackid,
      sourceId = showid,
      indexId = indexid,
      contentVal = 0,
      rate = 0,
      isNewHit = false,
      level = level,
      userUniqueId = userUniqueId,
      talentFlag = kindTable[2]
    }
    table.insert(target.buffList, buff)
  end
  if 0 < buffData.actionLogic then
    local inc = fif(isRefresh, 0, 1)
    local refCount = fif(target.buffAction.type == buffData.actionLogic, target.buffAction.refCount + inc, 1)
    target.buffAction = {
      type = buffData.actionLogic,
      refCount = refCount
    }
  end
  if mergelist ~= nil and #mergelist ~= 0 then
    for j = 1, #mergelist do
      local check_info = FH.getBuffData(mergelist[j].id, mergelist[j].owner)
      if check_info.maxRound ~= buffData.maxRound or check_info.endPoint ~= buffData.endPoint or check_info.maxStack ~= buffData.maxStack or check_info.lastRound ~= buffData.lastRound then
        warning("GamePlay", "merge buff error " .. check_info.id .. " " .. check_info.owner)
      end
    end
    buff.mergeList = mergelist
  end
  buff.isNewHit = true
  buff.round = buffData.maxRound
  if attackid == target.uniqueID or attackid - 3 == target.uniqueID then
    buff.exRound = buffData.lastRound
  end
  buff.stack = fif(buff.stack + 1 > buffData.maxStack, buffData.maxStack, buff.stack + 1)
  local param_list = buffData.paramInt
  local maxLevel = math.max(1, buffData.maxLevel - 1)
  local result_rate = 1 + (buffData.upRate - 10000) / 10000 * (level - 1) / maxLevel
  local buffType = buffData.type
  local child_type = 0
  if buffType == PB.enum.BuffFightType.AbHurt or buffType == PB.enum.BuffFightType.Attr then
    child_type = param_list[1]
  end
  local sign_type = 0
  if buffType == PB.enum.BuffFightType.Shield then
    if attack ~= nil then
      local val = param_list[3] * result_rate + FH.getChangeBuffVal(buffType, child_type, sign_type, attack, 1)
      local add_val = FH.getChangeBuffVal(buffType, child_type, sign_type, attack, 0) / 10000
      local add1 = param_list[4] / 10000 * result_rate
      local add2 = param_list[5] / 10000 * result_rate
      if add1 ~= 0 then
        val = val + (add1 + add_val) * attack.dynamicAttrs[PB.enum.AttrType.Attack].value
      end
      if add2 ~= 0 then
        val = val + (add2 + add_val) * FH.getActorBaseAttr(attack, PB.enum.AttrType.Hp)
      end
      local one_val = math.min(buff.val + val, val * buff.stack)
      buff.val = math.max(math.floor(one_val + 0.5), 1)
    end
  elseif buffType == PB.enum.BuffFightType.HpChange or buffType == PB.enum.BuffFightType.ActionFeedBack or buffType == PB.enum.BuffFightType.HpImmeChange or buffType == PB.enum.BuffFightType.HpImmeChangeMulti then
    if attack ~= nil then
      if buffType == PB.enum.BuffFightType.HpImmeChangeMulti and param_list[5] ~= PB.enum.IdentityCategory.Self then
        if kindTable.isContinues then
          hpChange(attack, buff, buffData, param_list[3], param_list[4] * result_rate, child_type, kindTable)
        else
          hpChange(attack, buff, buffData, param_list[1], param_list[2] * result_rate, child_type, kindTable)
          continuesTrigger = true
        end
      else
        hpChange(attack, buff, buffData, param_list[1], param_list[2] * result_rate, child_type, kindTable)
      end
    end
  elseif buffType == PB.enum.BuffFightType.Bomb then
    local selectedBuff = SelectBuffInBuffListByCategory(target.buffList, param_list[1])
    local one_change_val = 0
    for _, v in pairs(selectedBuff) do
      one_change_val = one_change_val + v.val * v.round
      if param_list[3] and param_list[3] ~= 0 then
        v.state = PB.enum.BuffFightState.Delete
      end
    end
    local rate = (param_list[2] or 0) / 10000 * result_rate
    if param_list[2] == nil then
      warning("GamePlay", "Bomb param_list -> parament 2 is nil??")
    end
    buff.val = math.floor(one_change_val * rate)
  elseif buffType == PB.enum.BuffFightType.LockCard then
    if buffData.endPoint ~= 2 then
      warning("GamePlay", "ERROR ENDPOINT " .. buffData.endPoint)
    end
  elseif buffType == PB.enum.BuffFightType.StackDelete then
    buff.val = param_list[1]
    if buff.val == buff.stack then
      triggerOneBuff(param_list[2], level, attack, target, kindTable)
    end
  elseif buffType == PB.enum.BuffFightType.SkillReset then
    buff.val = param_list[1]
  elseif buffType == PB.enum.BuffFightType.SpecialAttrChange then
    buff.val = level
    local definition = DEFINE.BuffFightType[buffType]
    if definition[param_list[2]] == "inDuration" then
      table.insert(target.dynamicTalent, {
        talentId = param_list[1],
        talentValue = level
      })
    end
  elseif buffType == PB.enum.BuffFightType.BuffRoundRefresh then
    FH.RefreshBuffRound(target, buffData)
  elseif buffType == PB.enum.BuffFightType.AttrTransAbHurt then
    local definition = DEFINE.BuffFightType[buffType]
    local valueForTrans = 0
    if definition[param_list[2]] == "CurrentHpDef" then
      valueForTrans = target.dynamicAttrs[PB.enum.AttrType.Hp].value
    else
      local attrs = target.dynamicAttrs[param_list[2]] or {}
      valueForTrans = attrs.value or 0
    end
    if valueForTrans == 0 then
      warning("GamePlay", "BuffFightType 39 paramInt[2] may be wrong.")
    end
    buff.val = math.floor(valueForTrans * (param_list[3] / 10000) * result_rate)
  elseif buffType == PB.enum.BuffFightType.Remove then
    local buffs = table.select(attack.buffList, function(v)
      local tmpBuffData = FH.getBuffData(v.buffKey.id, v.buffKey.owner)
      if tmpBuffData.type == PB.enum.BuffFightType.BuffType3Change and tmpBuffData.paramInt[1] == param_list[1] and tmpBuffData.paramInt[2] == param_list[2] then
        return v
      end
    end):toarray()
    local delNum = param_list[3] or 9999
    if 0 < #buffs then
      local tmp = buffs[#buffs]
      local tmpBuffData = FH.getBuffData(tmp.buffKey.id, tmp.buffKey.owner)
      delNum = tmpBuffData.paramInt[3] or 9999
    end
    buff.val = delNum
  elseif buffType == PB.enum.BuffFightType.RemoveStack then
    buff.val = param_list[3] or 9999
  elseif buffType == PB.enum.BuffFightType.Rebound and param_list[1] == 3 then
    local attackerAttackAttr = attack.dynamicAttrs[PB.enum.AttrType.Attack].value
    local val = attackerAttackAttr * param_list[2] / 10000 * result_rate
    buff.val = math.floor(val * buff.stack + 0.5)
  else
    local config_val = getBuffVal(buffType, param_list) * result_rate
    if buffType == PB.enum.BuffFightType.HpAddChange or buffType == PB.enum.BuffFightType.AbHurt then
      if 0 <= config_val then
        sign_type = 1
      else
        sign_type = 2
      end
      local temp_result = FH.getChangeBuffVal(buffType, child_type, sign_type, attack, 0)
      if sign_type == 1 then
        config_val = math.max(0, config_val + temp_result)
      else
        config_val = math.min(0, config_val + temp_result)
      end
    end
    buff.val = math.floor(config_val * buff.stack + 0.5)
  end
  buff.rate = result_rate
  if buffType ~= PB.enum.BuffFightType.BuffValChange then
    if 0 <= buff.val then
      sign_type = 1
    else
      sign_type = 2
    end
    local changeRate = FH.getChangeBuffVal(buffType, child_type, sign_type, attack, 2)
    if changeRate ~= 0 then
      changeRate = math.max(-10000, changeRate)
      buff.val = math.floor(buff.val * (1 + changeRate / 10000) + 0.5)
    end
  end
  if buffType ~= PB.enum.BuffFightType.BuffRoundChange then
    local changedVal = ChangeBuffRound(target, buffData)
    buff.round = buff.round + changedVal
  end
  if indexid == 9999 then
    if buffType == PB.enum.BuffFightType.SpToMp then
      local spVal = math.max(0, param_list[1])
      buff.contentVal = math.ceil(spVal * buff.val / 10000)
    elseif buffType == PB.enum.BuffFightType.MpOnceChange then
      buff.contentVal = buff.val
    elseif buffType == PB.enum.BuffFightType.SpOnceChange then
      buff.contentVal = buff.val
    end
  end
  TLog.CollectBuff({
    action = "add",
    buffInfo = buff,
    round = kindTable[1]
  })
  return buff, continuesTrigger
end

function triggerOneBuff(index, level, attack, target, paramTable)
  if index == 0 then
    return {}
  end
  local info = PB.get("BuffIndex", index)
  if info == nil then
    warning("GamePlay", "ERROR??????????????????? BuffIndex = " .. index)
    return {}
  end
  local result = {}
  local addRate = 0
  if attack ~= nil then
    local resistanceRate = 0
    if attack.team ~= target.team then
      resistanceRate = target.dynamicAttrs[PB.enum.AttrType.BuffResistanceRate].value
    end
    addRate = (attack.dynamicAttrs[PB.enum.AttrType.BuffAccuracyRate].value - resistanceRate) / 10000.0
  end
  local actorRate = math.max(1 + addRate, 0)
  local buff
  local continuesTrigger = false
  local newbuff = false
  local count = #info.buffId
  if info.isChanceIndependent == true then
    if info.merge == true then
      if FH.isRandomChanceMet(info.launchChance[1] * actorRate) then
        local mergeTable = {}
        for i = 2, count do
          local buffId = info.buffId[i]
          local buffOwner = info.owner[i]
          table.insert(mergeTable, {id = buffId, owner = buffOwner})
        end
        for i = 1, count do
          local buffId = info.buffId[i]
          local buffOwner = info.owner[i]
          local temp_state = 0
          local temp_table = {}
          if i ~= 1 then
            temp_state = 1
          else
            temp_table = mergeTable
          end
          if attack ~= nil then
            buff, continuesTrigger = addActorBuff(attack, target, buffId, buffOwner, level, paramTable, temp_state, temp_table)
            if buff ~= nil then
              newbuff = true
            end
          end
        end
      end
    else
      for i = 1, count do
        if FH.isRandomChanceMet(info.launchChance[i] * actorRate) then
          local buffId = info.buffId[i]
          local buffOwner = info.owner[i]
          if attack ~= nil then
            buff, continuesTrigger = addActorBuff(attack, target, buffId, buffOwner, level, paramTable, 0, {})
            if buff ~= nil then
              newbuff = true
            end
          end
        end
      end
    end
  else
    local proportionList = {}
    for i = 1, count do
      proportionList[i] = info.launchChance[i]
    end
    local proportionIndex = FH.getProportionRandomIndex(proportionList)
    if FH.isRandomChanceMet(10000 * actorRate) then
      local buffId = info.buffId[proportionIndex]
      local buffOwner = info.owner[proportionIndex]
      if attack ~= nil then
        buff, continuesTrigger = addActorBuff(attack, target, buffId, buffOwner, level, paramTable, 0, {})
        if buff ~= nil then
          newbuff = true
        end
      end
    end
  end
  if newbuff then
    result = FH.copyActorBuff(target)
  end
  return result, continuesTrigger
end

local function checkBuffTrigger(index, level, teamList, attack, target, paramTable)
  if target.dynamicAttrs[PB.enum.AttrType.Hp].value <= 0 then
    return {}
  end
  if target.isAssist then
    warning("GamePlay", "New Mode Can Not Add Buff To Assist")
    return {}
  end
  local result, continuesTrigger = triggerOneBuff(index, level, attack, target, paramTable)
  if 0 < #result then
    local teamInfo = FH.getTeamInfo(teamList, attack.team)
    if paramTable[2] > DEFINE.WeaponTalentFlagThreshold then
      local weaponId, position, phase = DEFINE.WeaponTalentFlag(paramTable[2])
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponId, phase)
      if uniqueWeaponSkill then
        local shouldHint = table.find(uniqueWeaponSkill.hintSpecials, function(_, v)
          return v == index
        end)
        if shouldHint then
          if teamInfo then
            TS.SpecialTriggerList(teamInfo, index, weaponId, paramTable[1], attack.uniqueID, position, paramTable[2])
          else
            warning("GamePlay", "teamList not find target.team : " .. tostring(target.team))
          end
        end
      end
    else
      TS.SpecialTriggerList(teamInfo, index, attack.actorInfo.id, paramTable[1], attack.uniqueID, 0, paramTable[2])
    end
    FH.refreshShowBuff(result)
    FH.updateAllBuff(target, teamList, paramTable[1])
  end
  return result, continuesTrigger
end

return checkBuffTrigger
