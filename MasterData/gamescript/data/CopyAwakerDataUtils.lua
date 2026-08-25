local baseSkillSlot = DT.GetConstant("AwakerSkillListNum")
local CopyAwakerDataUtils = {}

function CopyAwakerDataUtils.Get_battleAwakerMap()
  return DataCenter.copiesData.battleAwakerMap
end

function CopyAwakerDataUtils.GetBattleAwakerData(tid)
  if not tid then
    return
  end
  return DataCenter.copiesData.battleAwakerMap[tid]
end

function CopyAwakerDataUtils.GetBattleAwakerTidList(withoutSpecial, withAssist)
  local list = {}
  for tid, awaker in pairs(DataCenter.copiesData.battleAwakerMap) do
    if withoutSpecial and awaker.special then
    elseif awaker.isAssist and not withAssist then
    else
      table.insert(list, tid)
    end
  end
  return list
end

function CopyAwakerDataUtils.GetSkillDataBySlot(tid, slot)
  local awaker = CopyAwakerDataUtils.GetBattleAwakerData(tid)
  if awaker then
    return awaker.skills[slot]
  else
    return nil
  end
end

function CopyAwakerDataUtils.GetDbgSkillIdBySlot(tid, slot)
  local skillData = CopyAwakerDataUtils.GetSkillDataBySlot(tid, slot)
  if skillData then
    return skillData.tid
  end
end

function CopyAwakerDataUtils.GetWeapon(awaker, slotType)
  if awaker.isAssist then
    local weaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slotType)
    if weaponSlot.unlocked and weaponSlot.weaponUid > 0 then
      return DataCenter.copiesData.ItemDataMap[weaponSlot.weaponUid]
    end
  else
    do return AwakerDataUtils.GetWeapon, awaker end
    return AwakerDataUtils.GetWeapon, awaker, slotType
  end
end

function CopyAwakerDataUtils.GetWeaponConfig(awaker, slotType)
  local weaponItem
  if awaker.isAssist then
    weaponItem = CopyAwakerDataUtils.GetWeapon(awaker, slotType)
  else
    weaponItem = AwakerDataUtils.GetWeapon(awaker, slotType)
  end
  if weaponItem then
    return DT.Item[weaponItem.tid]
  end
end

function CopyAwakerDataUtils.UpdateAssistData(assistData)
  DataCenter.copiesData.ItemDataMap = {}
  DataCenter.copiesData.AssistAwakerTid = assistData.awakerTid
  DataCenter.copiesData.AssistPlayerUid = assistData.playerId
  for _, v in pairs(assistData.items) do
    DataCenter.copiesData.ItemDataMap[v.uid] = v
  end
end

function CopyAwakerDataUtils.UpdateBattleAwakerData(data)
  local awaker = DataCenter.copiesData.battleAwakerMap[data.tid]
  if not awaker then
    awaker = {}
    DataCenter.copiesData.battleAwakerMap[data.tid] = awaker
  end
  awaker.uid = data.uid
  awaker.tid = data.tid
  awaker.level = data.level or awaker.level
  awaker.lastLevel = awaker.level or nil
  awaker.special = data.special
  awaker.potency = data.potential or awaker.potency
  awaker.weaponSlots = data.weaponSlots or awaker.weaponSlots
  awaker.trinkets = data.trinkets or awaker.trinkets
  awaker.trinketSuitId = data.trinketSuitId or awaker.trinketSuitId
  awaker.potencyLevel = data.potencyLevel or awaker.potencyLevel
  awaker.isAssist = data.isAssist or awaker.isAssist
  awaker.currBreakthroughStar = data.breakLevel or awaker.currBreakthroughStar
  awaker.likeLevel = data.likeLevel or awaker.likeLevel
  awaker.descArgs = data.descArgs
  awaker.talents = data.talents
  awaker.curSkin = data.curSkin
  if data.slots then
    local skills = {}
    for _, v in ipairs(data.slots) do
      if v.slot <= baseSkillSlot then
        skills[v.slot] = v
      end
    end
    awaker.skills = skills
    awaker.breakSkillUnlock = data.breakSkillUnlock
    AwakerDataUtils._AddBreakthroughSkillInfo(awaker)
    AwakerDataUtils._AddSpecialSkillInfo(awaker)
  end
  if data.attrs then
    awaker.attrs = data.attrs
    AwakerDataUtils.UpdateClientAttrs(awaker, AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs))
  end
  return awaker
end

function CopyAwakerDataUtils.UpdateUltiArgs(tid, args)
  local awaker = DataCenter.copiesData.battleAwakerMap[tid]
  if not awaker then
    return
  end
  awaker.descArgs = args
end

function CopyAwakerDataUtils.UpdateAwakerAttrs(data)
  if not data then
    return
  end
  for tid, attrs in pairs(data) do
    local awaker = CopyAwakerDataUtils.GetBattleAwakerData(tid)
    if awaker then
      for k, v in pairs(attrs) do
        awaker.attrs[k] = v
      end
      AwakerDataUtils.UpdateClientAttrs(awaker, AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs))
    end
  end
end

function CopyAwakerDataUtils.GetAwakerAttrs(tid, attrName)
  local attrs = DataCenter.playerData.DRole.attrs or {}
  if "occupation_master" == attrName then
    local value = attrs[attrName] or 0
    local final_add = attrs.occupation_master_final_add or 0
    return value * (1 + final_add / 100)
  end
  return attrs[attrName] or 0
end

return CopyAwakerDataUtils
