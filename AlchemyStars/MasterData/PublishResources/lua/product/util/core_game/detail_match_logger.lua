_class("DetailMatchLogger", Object)
DetailMatchLogger = DetailMatchLogger

function DetailMatchLogger:Constructor(world)
  self._logs = {}
  self._skills = {}
  self._buffs = {}
  self._world = world
  self._curPrefixStr = ""
  self._curTabCount = 0
  self._aiLogs = {}
  self._logDate = os.date("%y%m%d%H%M%S")
  if not StringTable then
    StringTable = {
      Get = function(name)
        return name
      end
    }
  end
end

function DetailMatchLogger:CheckEnabled()
  if self._world:GetRunningPosition() == WorldRunPostion.AtClient then
    if not self._world:IsDevelopEnv() then
      _G.ENABLE_DETAIL_MATCH_LOG = false
    end
  else
    _G.ENABLE_DETAIL_MATCH_LOG = false
  end
end

function DetailMatchLogger:GetLogs()
  return self._logs
end

function DetailMatchLogger:AddTab()
  self._curTabCount = self._curTabCount + 1
  self:_CalcPrefixStr()
end

function DetailMatchLogger:DelTab()
  self._curTabCount = self._curTabCount - 1
  self:_CalcPrefixStr()
end

function DetailMatchLogger:_CalcPrefixStr()
  self._curPrefixStr = string.rep("   ", self._curTabCount)
end

function DetailMatchLogger:AddMatchLog(logname, info, v)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  table.insert(self._logs, {name = logname, info = info})
end

function DetailMatchLogger:SaveDetailMatchLog(open)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local dir = EngineGameHelper.StoragePath .. "DetailMatchLog/"
  App.MakeDir(dir)
  local _filePath = dir .. "DetailMatchLog" .. self._logDate .. ".log"
  local file = io.open(_filePath, "w+")
  if file then
    for i, log in ipairs(self._logs) do
      file:write(log.info)
    end
    io.close(file)
    if EDITOR and open then
      SmokingTestHub.OpenLogFile(_filePath)
    end
  end
end

function DetailMatchLogger:SimpleLog(logStr)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local infoStr = string.format("%s%s\n", self._curPrefixStr, logStr)
  self:AddMatchLog("SimpleLog", infoStr)
end

function DetailMatchLogger:BeginSkill(attackerid, attackpos, skillid, range)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local cfgsvc = self._world:GetService("Config")
  local skillName = cfgsvc:GetSkillConfigData(skillid):GetSkillName()
  skillName = StringTable.Get(skillName)
  local titleStr = string.format("【技能】攻击者[%d] 攻击位置[%s] 技能ID[%d] 技能名称[%s]", attackerid, self:V2PosToString(attackpos), skillid, skillName)
  self:BeginBlock("SkillBegin", titleStr)
  local rangeCopy = {}
  table.appendArray(rangeCopy, range)
  local t = {
    desc = "攻击者[attackerid] 攻击位置[attackpos] 技能ID[skillid]",
    attackerid = attackerid,
    attackpos = attackpos,
    skillid = skillid,
    range = rangeCopy
  }
  self._skills[attackerid] = t
end

function DetailMatchLogger:EndSkill(attackerid)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local v = self._skills[attackerid]
  if v then
    local desc = self:SkillLogToString(v)
    self._skills[attackerid] = nil
    self:AddMatchLog("Skill", desc, v)
  end
  self:EndBlock("SkillEnd")
end

function DetailMatchLogger:BeginBuff(attackerid, buffid)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local t = {
    desc = "攻击者[attackerid] BUFFID[buffid]",
    attackerid = attackerid,
    buffid = buffid
  }
  self._buffs[attackerid] = t
end

function DetailMatchLogger:EndBuff(attackerid)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local v = self._buffs[attackerid]
  if v then
    local desc = self:BuffLogToString(v)
    self._buffs[attackerid] = nil
    self:AddMatchLog("Buff", desc, v)
  end
end

function DetailMatchLogger:BeginDamageLog(attackerid)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local t = self._buffs[attackerid] or self._skills[attackerid]
  if not t then
    return
  end
  if not t.calcDamage then
    t.calcDamage = {}
  end
  table.insert(t.calcDamage, {})
end

function DetailMatchLogger:AddDamageLog(attackerid, log)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local t = self._buffs[attackerid] or self._skills[attackerid]
  if not t then
    return
  end
  if not t.calcDamage then
    t.calcDamage = {}
    table.insert(t.calcDamage, {})
  end
  local damagelog = t.calcDamage
  local t = damagelog[#damagelog]
  table.insert(t, log)
end

function DetailMatchLogger:EndDamageLog(attackerid)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local attack = self._buffs[attackerid] or self._skills[attackerid]
  if not attack then
    return
  end
end

function DetailMatchLogger:AddBloodLog(attackerid, log)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local t = self._buffs[attackerid] or self._skills[attackerid]
  if not t then
    return
  end
  if not t.calcAddBlood then
    t.calcAddBlood = {}
  end
  table.insert(t.calcAddBlood, log)
end

function DetailMatchLogger:AddHPShieldLog(attackerid, log)
  self._world:GetSyncLogger():Trace(log)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local t = self._buffs[attackerid] or self._skills[attackerid]
  if not t then
    return
  end
  if not t.calcAddHPShield then
    t.calcAddHPShield = {}
  end
  table.insert(t.calcAddHPShield, log)
end

function DetailMatchLogger:SkillLogToString(t)
  local strList = {}
  local partStr
  local cfgsvc = self._world:GetService("Config")
  local skillName = cfgsvc:GetSkillConfigData(t.skillid):GetSkillName()
  skillName = StringTable.Get(skillName)
  partStr = string.format("%s[伤害日志] 技能[%d] 名字[%s]  %s {\n", self._curPrefixStr, t.skillid, skillName, self:LogToString(t))
  table.insert(strList, partStr)
  self:AddTab()
  if t.calcDamage then
    for i, v in ipairs(t.calcDamage) do
      for k, d in ipairs(v) do
        partStr = string.format("%s>>%s\n", self._curPrefixStr, self:LogToString(d))
        table.insert(strList, partStr)
      end
    end
  end
  if t.calcAddBlood then
    for i, v in ipairs(t.calcAddBlood) do
      partStr = string.format("%s>>%s\n", self._curPrefixStr, self:LogToString(v))
      table.insert(strList, partStr)
    end
  end
  if t.calcAddHPShield then
    for i, v in ipairs(t.calcAddHPShield) do
      partStr = string.format("%s>>%s\n", self._curPrefixStr, self:LogToString(v))
      table.insert(strList, partStr)
    end
  end
  self:DelTab()
  partStr = self:BlockEndStr()
  table.insert(strList, partStr)
  local s = table.concat(strList)
  return s
end

function DetailMatchLogger:BuffLogToString(t)
  local strList = {}
  local partStr
  local cfgsvc = self._world:GetService("Config")
  local buffName = cfgsvc:GetBuffConfigData(t.buffid):GetBuffName()
  buffName = StringTable.Get(buffName)
  partStr = string.format("%s[伤害日志] BUFF[%d] 名字[%s]  %s {\n", self._curPrefixStr, t.buffid, buffName, self:LogToString(t))
  table.insert(strList, partStr)
  self:AddTab()
  if t.calcDamage then
    for i, v in ipairs(t.calcDamage) do
      for k, d in ipairs(v) do
        partStr = string.format("%s>>%s\n", self._curPrefixStr, self:LogToString(d))
        table.insert(strList, partStr)
      end
    end
  end
  if t.calcAddBlood then
    for i, v in ipairs(t.calcAddBlood) do
      partStr = string.format("%s>>%s\n", self._curPrefixStr, self:LogToString(v))
      table.insert(strList, partStr)
    end
  end
  if t.calcAddHPShield then
    for i, v in ipairs(t.calcAddHPShield) do
      partStr = string.format("%s>>%s\n", self._curPrefixStr, self:LogToString(v))
      table.insert(strList, partStr)
    end
  end
  self:DelTab()
  partStr = self:BlockEndStr()
  table.insert(strList, partStr)
  local s = table.concat(strList)
  return s
end

local splitT

local function SplitToString(s)
  return "[" .. tostring(splitT[s]) .. "]"
end

function DetailMatchLogger:LogToString(t)
  splitT = t
  local desc = string.gsub(t.desc, "%[(%w+)%]", SplitToString)
  splitT = nil
  return desc
end

function DetailMatchLogger:BlockBeginStr(blockNameStr)
  local infoStr = string.format("%s%s{\n", self._curPrefixStr, blockNameStr)
  return infoStr
end

function DetailMatchLogger:BlockEndStr()
  local infoStr = string.format("%s}\n", self._curPrefixStr)
  return infoStr
end

function DetailMatchLogger:BeginBlock(logName, blockNameStr)
  local infoStr = self:BlockBeginStr(blockNameStr)
  self:AddMatchLog(logName, infoStr)
  self:AddTab()
end

function DetailMatchLogger:EndBlock(logName)
  self:DelTab()
  local infoStr = self:BlockEndStr()
  self:AddMatchLog(logName, infoStr)
end

function DetailMatchLogger:TakeSnapshotBegin()
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:BeginBlock("SnapBegin", "【快照】")
end

function DetailMatchLogger:TakeSnapshotEnd()
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:EndBlock("SnapEnd")
end

function DetailMatchLogger:TakeSnapshot(onlyFsm)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:TakeSnapshotBegin()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local fsmInfo = self:GetFSMInfo()
  self:AddMatchLog("FSMInfo", fsmInfo)
  if onlyFsm then
    self:TakeSnapshotEnd()
    return
  end
  if teamEntity then
    local teamInfo = self:GetTeamInfo(teamEntity)
    self:AddMatchLog("TeamInfo", teamInfo)
    self:BeginBlock("BeginPetInfo", "【光灵列表】")
    local petInfo = self:GetPetInfo(teamEntity)
    self:AddMatchLog("PetInfo", petInfo)
    self:EndBlock("EndPetInfo")
  end
  self:BeginBlock("BeginMonsterInfo", "【怪物列表】")
  local monsterInfo = self:GetMonsterInfo()
  self:AddMatchLog("MonsterInfo", monsterInfo)
  self:EndBlock("EndMonsterInfo")
  self:BeginBlock("BeginTrapInfo", "【机关列表】")
  local trapInfo = self:GetTrapInfo()
  self:EndBlock("EndTrapInfo")
  self:AddMatchLog("TrapInfo", trapInfo)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    teamEntity = self._world:Player():GetRemoteTeamEntity()
    local teamInfo = self:GetTeamInfo(teamEntity)
    local petInfo = self:GetPetInfo(teamEntity)
    self:AddMatchLog("EnemyTeamInfo", teamInfo)
    self:AddMatchLog("EnemyPetInfo", petInfo)
  end
  self:TakeSnapshotEnd()
end

function DetailMatchLogger:GetFSMInfo()
  local fsmState = self._world:GameFSM():CurStateID()
  local stateName = GetEnumKey("GameStateID", fsmState)
  local roundCount = self._world:BattleStat():GetLevelTotalRoundCount()
  local curWaveNum = self._world:BattleStat():GetCurWaveIndex()
  local infoStr = string.format("%s【状态】 %s 回合[%d] 波次[%d] \n", self._curPrefixStr, stateName, roundCount, curWaveNum)
  return infoStr
end

function DetailMatchLogger:_EntityAttrAndBuff(e)
  local strList = {}
  local partStr
  partStr = string.format("%s属性{\n", self._curPrefixStr)
  table.insert(strList, partStr)
  self:AddTab()
  partStr = self:GetAttributeInfo(e)
  table.insert(strList, partStr)
  self:DelTab()
  partStr = self:BlockEndStr()
  table.insert(strList, partStr)
  partStr = string.format("%sbuff{\n", self._curPrefixStr)
  table.insert(strList, partStr)
  self:AddTab()
  partStr = self:GetBuffInfo(e)
  table.insert(strList, partStr)
  self:DelTab()
  partStr = self:BlockEndStr()
  table.insert(strList, partStr)
  partStr = string.format("%s[Render] buff{\n", self._curPrefixStr)
  table.insert(strList, partStr)
  self:AddTab()
  partStr = self:GetEntityBuffViewInfo(e)
  table.insert(strList, partStr)
  self:DelTab()
  partStr = self:BlockEndStr()
  table.insert(strList, partStr)
  local s = table.concat(strList)
  return s
end

function DetailMatchLogger:GetTeamInfo(teamEntity)
  local e = teamEntity
  local pos = e:GridLocation():GetGridPos()
  local strList = {}
  local partStr
  partStr = string.format("%s【队伍】 ID[%d] 位置[%s]{\n", self._curPrefixStr, e:GetID(), self:V2PosToString(pos))
  table.insert(strList, partStr)
  self:AddTab()
  partStr = self:_EntityAttrAndBuff(e)
  table.insert(strList, partStr)
  self:DelTab()
  partStr = self:BlockEndStr()
  table.insert(strList, partStr)
  local s = table.concat(strList)
  return s
end

function DetailMatchLogger:GetPetInfo(teamEntity)
  local es = teamEntity:Team():GetTeamPetEntities()
  local totalStrList = {}
  local partStr
  local groupStrList = {}
  for i, e in ipairs(es) do
    local tid = e:PetPstID():GetTemplateID()
    local pos = e:GridLocation():GetGridPos()
    local name = StringTable.Get(Cfg.cfg_pet[tid].Name)
    local strList = {}
    partStr = string.format("%s【光灵】[%s] 实体ID[%d] 光灵ID[%d] 位置[%s]{\n", self._curPrefixStr, name, e:GetID(), tid, self:V2PosToString(pos))
    table.insert(strList, partStr)
    self:AddTab()
    partStr = self:_EntityAttrAndBuff(e)
    table.insert(strList, partStr)
    self:DelTab()
    partStr = self:BlockEndStr()
    table.insert(strList, partStr)
    local infoStr = table.concat(strList)
    table.insert(groupStrList, infoStr)
  end
  partStr = table.concat(groupStrList)
  table.insert(totalStrList, partStr)
  local s = table.concat(totalStrList)
  return s
end

function DetailMatchLogger:GetMonsterInfo()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local totalStrList = {}
  local partStr
  local groupStrList = {}
  for i, e in ipairs(group:GetEntities()) do
    local tid = e:MonsterID():GetMonsterID()
    local pos = e:GridLocation():GetGridPos()
    local dir = e:GridLocation():GetGridDir()
    local name = StringTable.Get(Cfg.cfg_monster_class[Cfg.cfg_monster[tid].ClassID].Name)
    local strList = {}
    partStr = string.format("%s【怪物】[%s] 实体ID[%d] 怪物ID[%d] 位置[%s]{\n", self._curPrefixStr, name, e:GetID(), tid, self:V2PosToString(pos))
    table.insert(strList, partStr)
    self:AddTab()
    partStr = self:_EntityAttrAndBuff(e)
    table.insert(strList, partStr)
    self:DelTab()
    partStr = self:BlockEndStr()
    table.insert(strList, partStr)
    local infoStr = table.concat(strList)
    table.insert(groupStrList, infoStr)
  end
  partStr = table.concat(groupStrList)
  table.insert(totalStrList, partStr)
  local s = table.concat(totalStrList)
  return s
end

function DetailMatchLogger:GetTrapInfo()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local totalStrList = {}
  local partStr
  local groupStrList = {}
  for i, e in ipairs(group:GetEntities()) do
    local tid = e:Trap():GetTrapID()
    local pos = e:GridLocation():GetGridPos()
    local dir = e:GridLocation():GetGridDir()
    local name = StringTable.Get(Cfg.cfg_trap[tid].NameStr)
    if name == nil then
      name = "null"
    end
    local strList = {}
    partStr = string.format("%s【机关】[%s] 实体ID[%d] 机关ID[%d] 位置[%s]{\n", self._curPrefixStr, name, e:GetID(), tid, self:V2PosToString(pos))
    table.insert(strList, partStr)
    self:AddTab()
    partStr = self:_EntityAttrAndBuff(e)
    table.insert(strList, partStr)
    self:DelTab()
    partStr = self:BlockEndStr()
    table.insert(strList, partStr)
    local infoStr = table.concat(strList)
    table.insert(groupStrList, infoStr)
  end
  partStr = table.concat(groupStrList)
  table.insert(totalStrList, partStr)
  local s = table.concat(totalStrList)
  return s
end

function DetailMatchLogger:GetBuffInfo(e)
  local buffCom = e:BuffComponent()
  if buffCom then
    if #buffCom:GetBuffArray() == 0 then
      return string.format("%s\n", self._curPrefixStr)
    end
    local buffStrList = {}
    for i, buff in ipairs(buffCom:GetBuffArray()) do
      local buffid = buff:BuffID()
      local buffEffectType = buff:GetBuffEffectType()
      local buffSeq = buff:BuffSeq()
      local layerCount = buff:GetLayerCount()
      local name = StringTable.Get(Cfg.cfg_buff[buffid].Name)
      local desc = string.format("%sbuffID[%d] 名称[%s] EffectType[%d] Seq[%d] 层数[%d]\n", self._curPrefixStr, buffid, name, buffEffectType, buffSeq, layerCount)
      table.insert(buffStrList, desc)
    end
    local buffListStr = table.concat(buffStrList)
    return buffListStr
  end
end

function DetailMatchLogger:GetEntityBuffViewInfo(e)
  local buffCom = e:BuffView()
  if buffCom then
    local viewInsArray = e:BuffView():GetBuffViewInstanceArray()
    if #viewInsArray == 0 then
      return string.format("%s\n", self._curPrefixStr)
    end
    local buffStrList = {}
    for _, inst in ipairs(viewInsArray) do
      local buff = inst
      local buffid = buff:BuffID()
      local buffEffectType = buff:GetBuffEffectType()
      local buffSeq = buff:BuffSeq()
      local layerCount = buff:GetLayerCount()
      local name = StringTable.Get(Cfg.cfg_buff[buffid].Name)
      local desc = string.format("%s[Render] buffID[%d] 名称[%s] EffectType[%d] Seq[%d] 层数[%d]\n", self._curPrefixStr, buffid, name, buffEffectType, buffSeq, layerCount)
      table.insert(buffStrList, desc)
    end
    local buffListStr = table.concat(buffStrList)
    return buffListStr
  end
end

function DetailMatchLogger:GetAttributeInfo(e)
  local attrCom = e:Attributes()
  local buffCom = e:BuffComponent()
  local attrStrList = {}
  for name, attr in pairs(attrCom.modifierDic) do
    local value = attr:Value()
    if type(value) == "number" then
      local buffIdListStr = ""
      if attr.valueModifyList then
        local buffIdStrList = {}
        for i, v in ipairs(attr.valueModifyList) do
          if v[1] > 1000 and buffCom then
            local buffInstance = buffCom:GetBuffBySeq(v[1])
            if buffInstance then
              local buffid = buffInstance:BuffID()
              table.insert(buffIdStrList, tostring(buffid))
            end
          end
        end
        buffIdListStr = table.concat(buffIdStrList, ",")
      end
      local desc
      if name == "HP" then
        desc = string.format("%s%s[%s] 修改BuffID[%s]\n%s灰血池积蓄[%s]\n", self._curPrefixStr, self:GetAttrCNName(name), tostring(value), buffIdListStr, self._curPrefixStr, tostring(buffCom:GetGreyHPValue(true)))
      else
        desc = string.format("%s%s[%s] 修改BuffID[%s]\n", self._curPrefixStr, self:GetAttrCNName(name), tostring(value), buffIdListStr)
      end
      table.insert(attrStrList, desc)
    end
  end
  local attrListStr = table.concat(attrStrList)
  return attrListStr
end

function DetailMatchLogger:GetAttrCNName(name)
  return AttrCN[name] or name
end

function DetailMatchLogger:GameFsmNodeEnter(stateID, stateName)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local roundCount = self._world:BattleStat():GetLevelTotalRoundCount()
  local curWaveNum = self._world:BattleStat():GetCurWaveIndex()
  local infoStr = string.format("%s【状态机】【进入】 %s  %02d. 回合[%d] 波次[%d]{\n", self._curPrefixStr, stateName, stateID, roundCount, curWaveNum)
  self:AddMatchLog("FsmNodeInfo", infoStr)
  self:AddTab()
end

function DetailMatchLogger:GameFsmNodeExit(stateID, stateName)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:DelTab()
  local infoStr = string.format("%s}【退出】 %s  %02d. \n\n", self._curPrefixStr, stateName, stateID)
  self:AddMatchLog("FsmNodeInfo", infoStr)
end

function DetailMatchLogger:V2PosToString(pos)
  local str = string.format("(%s,%s)", tostring(pos.x), tostring(pos.y))
  return str
end

function DetailMatchLogger:BeginNotify(notify)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.AddMatchLog then
    return
  end
  self:BeginBlock("BeginNotify", "【通知】")
  local notifyType = notify:GetNotifyType()
  local notifyTypeName = GetEnumKey("NotifyType", notifyType)
  local titleStr = string.format("通知[%s] 枚举值[%d] 成员:", notifyTypeName, notifyType)
  self:BeginBlock("BeginNotifyInfo", titleStr)
  local infoStr = self:GetNotifyInfo(notify)
  self:AddMatchLog("NotifyInfo", infoStr)
  self:EndBlock("EndNotifyInfo")
end

function DetailMatchLogger:GetNotifyInfo(notify)
  local notifyType = notify:GetNotifyType()
  local notifyTypeName = GetEnumKey("NotifyType", notifyType)
  local notifyEntity = notify:GetNotifyEntity()
  local notifyEntityID = 0
  if notifyEntity then
    notifyEntityID = notifyEntity:GetID()
  end
  local totalStrList = {}
  local notifyMemberStrList = {}
  local partStr
  for key, value in pairs(notify) do
    if key ~= "_className" then
      local eID, attackRange, attackRangeStr
      if type(value) == "table" and value._className then
        if value.GetID then
          eID = value:GetID()
        end
        if value.GetAttackRange then
          attackRange = value:GetAttackRange()
          local st = {}
          for i, v in ipairs(attackRange) do
            if v._className == "Vector2" then
              st[#st + 1] = Vector2.Pos2Index(v)
            end
          end
          attackRangeStr = table.concat(st, " ")
        end
      end
      if eID then
        partStr = string.format("%s%s : EntityID[%d]\n", self._curPrefixStr, tostring(key), eID)
      elseif attackRangeStr then
        partStr = string.format("%s%s : AttackRange[%s]\n", self._curPrefixStr, tostring(key), attackRangeStr)
      else
        partStr = string.format("%s%s : %s\n", self._curPrefixStr, tostring(key), self:_ToString(value))
      end
      table.insert(notifyMemberStrList, partStr)
    end
  end
  local memberListStr = table.concat(notifyMemberStrList)
  table.insert(totalStrList, memberListStr)
  local totalStr = table.concat(totalStrList)
  return totalStr
end

function DetailMatchLogger:EndNotify(notify)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.AddMatchLog then
    return
  end
  self:EndBlock("EndNotify")
end

function DetailMatchLogger:BeginTriggerSuccess(triggers)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:BeginBlock("BeginTriggerSuccess", "【触发】")
end

function DetailMatchLogger:GetTriggersInfo(triggers)
  local condStr
  local condStrList = {}
  for i, trigger in ipairs(triggers) do
    local combinedTrigger = trigger
    local triggerOwner = combinedTrigger:GetTriggerOwner()
    local ownerID = 0
    local ownerEntity = combinedTrigger:GetOwnerEntity()
    if ownerEntity then
      ownerID = ownerEntity:GetID()
    end
    local ownerBuffSeq = -1
    local ownerBuffID = -1
    local ownerBuffInstance = triggerOwner._buffInstance
    local triggerOwnerClassName = triggerOwner._className
    if triggerOwnerClassName then
      if triggerOwnerClassName == "BuffLoadHandler" then
        triggerOwnerClassName = "加载"
      elseif triggerOwnerClassName == "BuffActiveHandler" then
        triggerOwnerClassName = "激活条件"
      elseif triggerOwnerClassName == "BuffExecuteHandler" then
        triggerOwnerClassName = "执行条件"
      elseif triggerOwnerClassName == "BuffDeactiveHandler" then
        triggerOwnerClassName = "失活条件"
      elseif triggerOwnerClassName == "BuffUnloadHandler" then
        triggerOwnerClassName = "卸载"
      end
    end
    if ownerBuffInstance then
      ownerBuffSeq = ownerBuffInstance:BuffSeq()
      ownerBuffID = ownerBuffInstance:BuffID()
    end
    local triggerNotifyType = combinedTrigger:GetNotifyType()
    local notifyListStr = table.concat(triggerNotifyType, ",")
    local triggerList = combinedTrigger:GetTriggers()
    local triggerStr
    local triggerStrList = {}
    for _, trigger in ipairs(triggerList) do
      local triggerType = trigger:GetTriggerType()
      local triggerTypeName = GetEnumKey("TriggerType", triggerType)
      local triggerParams = trigger._param
      if 0 < #triggerParams then
        local paramStr = table.concat(triggerParams, ",")
        triggerStr = string.format("触发类型:%d[%s],参数列表:%s", triggerType, triggerTypeName, paramStr)
      else
        triggerStr = string.format("触发类型:%d[%s]", triggerType, triggerTypeName)
      end
      table.insert(triggerStrList, triggerStr)
    end
    local triggerListStr = table.concat(triggerStrList, " | ")
    condStr = string.format("%s宿主ID[%d] Buff序号[%d] BuffID[%d] [%s] 通知列表 %s|%s\n", self._curPrefixStr, ownerID, ownerBuffSeq, ownerBuffID, triggerOwnerClassName, notifyListStr, triggerListStr)
    table.insert(condStrList, condStr)
  end
  local condListStr = table.concat(condStrList)
  return condListStr
end

function DetailMatchLogger:RecordTriggerSuccess(trigger)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local condStr
  local condStrList = {}
  local combinedTrigger = trigger
  local triggerOwner = combinedTrigger:GetTriggerOwner()
  local ownerID = 0
  local ownerEntity = combinedTrigger:GetOwnerEntity()
  if ownerEntity then
    ownerID = ownerEntity:GetID()
  end
  local ownerBuffSeq = -1
  local ownerBuffID = -1
  local ownerBuffInstance = triggerOwner._buffInstance
  local triggerOwnerClassName = triggerOwner._className
  if triggerOwnerClassName then
    if triggerOwnerClassName == "BuffLoadHandler" then
      triggerOwnerClassName = "加载"
    elseif triggerOwnerClassName == "BuffActiveHandler" then
      triggerOwnerClassName = "激活条件"
    elseif triggerOwnerClassName == "BuffExecuteHandler" then
      triggerOwnerClassName = "执行条件"
    elseif triggerOwnerClassName == "BuffDeactiveHandler" then
      triggerOwnerClassName = "失活条件"
    elseif triggerOwnerClassName == "BuffUnloadHandler" then
      triggerOwnerClassName = "卸载"
    end
  end
  if ownerBuffInstance then
    ownerBuffSeq = ownerBuffInstance:BuffSeq()
    ownerBuffID = ownerBuffInstance:BuffID()
  end
  local triggerNotifyType = combinedTrigger:GetNotifyType()
  local notifyListStr = table.concat(triggerNotifyType, ",")
  local triggerList = combinedTrigger:GetTriggers()
  local triggerStr
  local triggerStrList = {}
  for _, trigger in ipairs(triggerList) do
    local triggerType = trigger:GetTriggerType()
    local triggerTypeName = GetEnumKey("TriggerType", triggerType)
    local triggerParams = trigger._param
    if 0 < #triggerParams then
      local paramStr = table.concat(triggerParams, ",")
      triggerStr = string.format("触发类型:%d[%s],参数列表:%s", triggerType, triggerTypeName, paramStr)
    else
      triggerStr = string.format("触发类型:%d[%s]", triggerType, triggerTypeName)
    end
    table.insert(triggerStrList, triggerStr)
  end
  local triggerListStr = table.concat(triggerStrList, " | ")
  condStr = string.format("%s宿主ID[%d] Buff序号[%d] BuffID[%d] [%s] 通知列表 %s|%s\n", self._curPrefixStr, ownerID, ownerBuffSeq, ownerBuffID, triggerOwnerClassName, notifyListStr, triggerListStr)
  local infoStr = condStr
  self:AddMatchLog("BeginTriggerSuccess", infoStr)
end

function DetailMatchLogger:EndTriggerSuccess()
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:EndBlock("EndTriggerSuccess")
end

function DetailMatchLogger:BeginTriggerLogic(TypeStr)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local blockNameStr = string.format("【执行】[%s]", TypeStr)
  local infoStr = self:BlockBeginStr(blockNameStr)
  self:AddMatchLog("BeginTriggerLogic", infoStr)
  self:AddTab()
end

function DetailMatchLogger:RecordBuffInstance(buffInstance, ownerEntityID)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local ownerBuffSeq = -1
  local ownerBuffID = -1
  if buffInstance then
    ownerBuffSeq = buffInstance:BuffSeq()
    ownerBuffID = buffInstance:BuffID()
  end
  local infoStr = string.format("%sBuff实例 宿主ID[%d] Buff序号[%d] BuffID[%d]\n", self._curPrefixStr, ownerEntityID, ownerBuffSeq, ownerBuffID)
  self:AddMatchLog("RecordBuffInstance", infoStr)
end

function DetailMatchLogger:RecordTriggerLogic(index, logic)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local infoStr = string.format("buff逻辑: 序号[%d] 逻辑[%s]", index, logic:GetLogicName())
  self:BeginBlock("BeginRecordTriggerLogic", infoStr)
end

function DetailMatchLogger:RecordBuffLogic(logic)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:BeginBlock("BeginRecordBuffLogic", "成员:")
  local infoStr = self:GetBuffLogicInfo(logic)
  self:AddMatchLog("RecordBuffLogic", infoStr)
  self:EndBlock("EndRecordBuffLogic")
end

function DetailMatchLogger:GetBuffLogicInfo(logic)
  local totalStrList = {}
  local memberStrList = {}
  local partStr
  for key, value in pairs(logic) do
    if key ~= "_className" and key ~= "_buffComponent" and key ~= "_buffLogicService" and key ~= "_buffInstance" and key ~= "_world" then
      local eID, attackRange, attackRangeStr
      if type(value) == "table" and value._className and value.GetID then
        eID = value:GetID()
      end
      if eID then
        partStr = string.format("%s%s : EntityID[%d]\n", self._curPrefixStr, tostring(key), eID)
      elseif attackRangeStr then
        partStr = string.format("%s%s : AttackRange[%s]\n", self._curPrefixStr, tostring(key), attackRangeStr)
      else
        partStr = string.format("%s%s : %s\n", self._curPrefixStr, tostring(key), self:_ToString(value))
      end
      table.insert(memberStrList, partStr)
    end
  end
  local memberListStr = table.concat(memberStrList)
  table.insert(totalStrList, memberListStr)
  local totalStr = table.concat(totalStrList)
  return totalStr
end

function DetailMatchLogger:_ToString(v)
  local retStr
  if type(v) == "table" then
    if v._className then
      local className = v._className
      if className == "Vector2" then
        retStr = string.format("(%f,%f)", v.x, v.y)
        return retStr
      elseif className == "Vector3" then
        retStr = string.format("(%f,%f,%f)", v.x, v.y, v.z)
        return retStr
      elseif className == "DamageInfo" then
      elseif className == "BuffViewInstance" then
        local buff = v
        local buffid = buff:BuffID()
        local buffEffectType = buff:GetBuffEffectType()
        local buffSeq = buff:BuffSeq()
        local layerCount = buff:GetLayerCount()
        local name = StringTable.Get(Cfg.cfg_buff[buffid].Name)
        retStr = string.format("对象:[BuffViewInstance] buffID[%d] 名称[%s] EffectType[%d] Seq[%d] 层数[%d]", buffid, name, buffEffectType, buffSeq, layerCount)
        return retStr
      elseif className == "Entity" then
        local entityID = v:GetID()
        retStr = string.format("实体 实体ID[%d]", entityID)
        return retStr
      elseif IsSubClassOf(className, "BuffResultBase") then
      else
        retStr = string.format("对象:类型[%s]", className)
        return retStr
      end
    end
    local partStr
    local partStrList = {}
    partStr = "{\n"
    table.insert(partStrList, partStr)
    self:AddTab()
    for key, value in pairs(v) do
      local valueStr = self:_ToString(value)
      partStr = string.format("%s%s : %s\n", self._curPrefixStr, tostring(key), valueStr)
      table.insert(partStrList, partStr)
    end
    self:DelTab()
    partStr = string.format("%s}", self._curPrefixStr)
    table.insert(partStrList, partStr)
    retStr = table.concat(partStrList)
  else
    retStr = tostring(v)
  end
  return retStr
end

function DetailMatchLogger:RecordBuffResult(result)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local className
  if result._className then
    className = result._className
  end
  local titleStr = string.format("Buff结果,类名[%s] 成员:", className)
  self:BeginBlock("BeginRecordBuffResult", titleStr)
  local infoStr = self:GetBuffResultInfo(result)
  self:AddMatchLog("RecordBuffResult", infoStr)
  self:EndBlock("EndRecordBuffResult")
end

function DetailMatchLogger:GetBuffResultInfo(result)
  local totalStrList = {}
  local memberStrList = {}
  local partStr, className
  if result._className then
    className = result._className
  end
  for key, value in pairs(result) do
    if key ~= "_className" then
      local eID, attackRange, attackRangeStr
      if type(value) == "table" and value._className and value.GetID then
        eID = value:GetID()
      end
      if eID then
        partStr = string.format("%s%s : EntityID[%d]\n", self._curPrefixStr, tostring(key), eID)
      elseif attackRangeStr then
        partStr = string.format("%s%s : AttackRange[%s]\n", self._curPrefixStr, tostring(key), attackRangeStr)
      else
        partStr = string.format("%s%s : %s\n", self._curPrefixStr, tostring(key), self:_ToString(value))
      end
      table.insert(memberStrList, partStr)
    end
  end
  local memberListStr = table.concat(memberStrList)
  table.insert(totalStrList, memberListStr)
  local totalStr = table.concat(totalStrList)
  return totalStr
end

function DetailMatchLogger:EndRecordTriggerLogic()
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:EndBlock("EndRecordTriggerLogic")
end

function DetailMatchLogger:EndTriggerLogic()
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:DelTab()
  local infoStr = self:BlockEndStr()
  self:AddMatchLog("EndTriggerLogic", infoStr)
end

function DetailMatchLogger:RecordAddBuffView(view)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local className
  if view._className then
    className = view._className
  end
  local titleStr = string.format("添加BuffView,类名[%s] 成员:", className)
  self:BeginBlock("BeginRecordBuffView", titleStr)
  local infoStr = self:GetBuffViewInfo(view)
  self:AddMatchLog("RecordBuffResult", infoStr)
  self:EndBlock("EndRecordBuffView")
end

function DetailMatchLogger:GetBuffViewInfo(view)
  local totalStrList = {}
  local memberStrList = {}
  local partStr, className
  if view._className then
    className = view._className
  end
  for key, value in pairs(view) do
    if key ~= "_className" then
      partStr = string.format("%s%s : %s\n", self._curPrefixStr, tostring(key), self:_ToString(value))
      table.insert(memberStrList, partStr)
    end
  end
  local memberListStr = table.concat(memberStrList)
  table.insert(totalStrList, memberListStr)
  local totalStr = table.concat(totalStrList)
  return totalStr
end

function DetailMatchLogger:BeginCalcSkillEffect(calculatorName, index, skillEffectParam)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local skillEffectType = skillEffectParam:GetEffectType()
  local effectName = GetEnumKey("SkillEffectType", skillEffectType)
  local titleStr = string.format("计算技能效果 序号[%d] 效果类型[%d] 效果名[%s]", index, skillEffectType, effectName)
  self:BeginBlock("BeginCalcSkillEffect", titleStr)
end

function DetailMatchLogger:EndCalcSkillEffect(calculatorName, index, skillEffectParam)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:EndBlock("EndCalcSkillEffect")
end

function DetailMatchLogger:BeginApplySkillEffect(casterEntity, skillEffectType, resultArray)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local casterEntityID = -1
  if casterEntity then
    casterEntityID = casterEntity:GetID()
  end
  local effectName = GetEnumKey("SkillEffectType", skillEffectType)
  local titleStr = string.format("应用技能效果,施法者[%d] 效果类型[%d] 效果名[%s]", casterEntityID, skillEffectType, effectName)
  self:BeginBlock("BeginApplySkillEffect", titleStr)
  local infoStr = self:GetSkillEffectResultsInfo(resultArray)
  self:AddMatchLog("BeginApplySkillEffect", infoStr)
end

function DetailMatchLogger:EndApplySkillEffect(casterEntity, skillEffectType, resultArray)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:EndBlock("EndCalcSkillEffect")
end

function DetailMatchLogger:GetSkillEffectResultsInfo(results)
  local totalStrList = {}
  local memberStrList = {}
  local partStr
  local tmpResults = results
  if type(results) == "table" then
  else
    tmpResults = {results}
  end
  for index, result in ipairs(tmpResults) do
    local resultClassName = ""
    if result._className then
      resultClassName = result._className
    end
    local blockTitleStr = string.format("技能效果结果序号[%d] 结果类型[%s]", index, resultClassName)
    partStr = self:BlockBeginStr(blockTitleStr)
    table.insert(totalStrList, partStr)
    self:AddTab()
    for key, value in pairs(result) do
      if key ~= "_className" then
        partStr = string.format("%s%s : %s\n", self._curPrefixStr, tostring(key), self:_ToString(value))
        table.insert(memberStrList, partStr)
      end
    end
    local memberListStr = table.concat(memberStrList)
    table.insert(totalStrList, memberListStr)
    self:DelTab()
    partStr = self:BlockEndStr()
    table.insert(totalStrList, partStr)
  end
  local totalStr = table.concat(totalStrList)
  return totalStr
end

function DetailMatchLogger:ViewBeginPlayBuffView(notify)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.AddMatchLog then
    return
  end
  self:BeginBlock("ViewBeginPlayBuffView", "【表现】【播放通知】")
  local notifyType = notify:GetNotifyType()
  local notifyTypeName = GetEnumKey("NotifyType", notifyType)
  local titleStr = string.format("通知[%s] 枚举值[%d] 成员:", notifyTypeName, notifyType)
  self:BeginBlock("viewNotifyInfo", titleStr)
  local infoStr = self:GetNotifyInfo(notify)
  self:AddMatchLog("ViewNotifyInfo", infoStr)
  self:EndBlock("EndviewNotifyInfo")
end

function DetailMatchLogger:ViewEndPlayBuffView(notify)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:EndBlock("ViewEndPlayBuffView")
end

function DetailMatchLogger:ViewRecordPlayBuffView(entity, notify, views)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local entityID
  if entity then
    entityID = entity:GetID()
  end
  local titleStr = string.format("实体播放buffView,实体ID[%d]:", entityID)
  self:BeginBlock("ViewRecordPlayBuffView", titleStr)
  for index, view in ipairs(views) do
    local className
    if view._className then
      className = view._className
    end
    titleStr = string.format("播放BuffView,类名[%s] 成员:", className)
    self:BeginBlock("ViewRecordPlayBuffView", titleStr)
    local infoStr = self:GetBuffViewInfo(view)
    self:AddMatchLog("ViewRecordPlayBuffView", infoStr)
    self:EndBlock("ViewRecordPlayBuffView")
  end
  self:EndBlock("EndRecordBuffView")
end

function DetailMatchLogger:AILogInitDataStruct(monsterID, entityID, round, runCount, aiConfigID)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local monster = string.format("%s.%s", tostring(monsterID), tostring(entityID))
  if not self._aiLogs[monster] then
    self._aiLogs[monster] = {}
  end
  if not self._aiLogs[monster][aiConfigID] then
    self._aiLogs[monster][aiConfigID] = {}
  end
  if not self._aiLogs[monster][aiConfigID][round] then
    self._aiLogs[monster][aiConfigID][round] = {}
  end
  if not self._aiLogs[monster][aiConfigID][round][runCount] then
    self._aiLogs[monster][aiConfigID][round][runCount] = {}
  end
end

function DetailMatchLogger:AddToLogFile(monsterID, entityID, round, runCount, aiConfigID, t)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  local monster = string.format("%s.%s", tostring(monsterID), tostring(entityID))
  table.insert(self._aiLogs[monster][aiConfigID][round][runCount], t)
end

function DetailMatchLogger:AddAIStreamLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, slotID)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:AILogInitDataStruct(monsterID, entityID, round, runCount, aiConfigID)
  local t = {
    Type = AILogDataType.AISteamLog,
    TreeID = aiTreeID,
    SlotID = slotID
  }
  self:AddToLogFile(monsterID, entityID, round, runCount, aiConfigID, t)
end

function DetailMatchLogger:AddAIDebugInfoLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, info)
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:AILogInitDataStruct(monsterID, entityID, round, runCount, aiConfigID)
  local t = {
    Type = AILogDataType.AIDebugLog,
    TreeID = aiTreeID,
    Info = info
  }
  self:AddToLogFile(monsterID, entityID, round, runCount, aiConfigID, t)
end

function DetailMatchLogger:SaveAILog()
  if not _G.ENABLE_DETAIL_MATCH_LOG then
    return
  end
  self:BeginBlock("SaveAILog", "AIDebugInfo=")
  local infoStr = self:GetAILogInfo()
  self:AddMatchLog("SaveAILog", infoStr)
  self:EndBlock("SaveAILog")
  self._aiLogs = {}
end

function DetailMatchLogger:GetAILogInfo()
  local totalStrList = {}
  local partStr
  for monsterID, i in pairs(self._aiLogs) do
    partStr = string.format("%s怪物ID.实体ID['%s'] = {\n", self._curPrefixStr, monsterID)
    table.insert(totalStrList, partStr)
    self:AddTab()
    for aiConfig, o in pairs(i) do
      partStr = string.format("%sAIConfig['%s'] = {\n", self._curPrefixStr, tostring(aiConfig))
      table.insert(totalStrList, partStr)
      self:AddTab()
      for round, q in pairs(o) do
        partStr = string.format("%sRound['%s'] = {\n", self._curPrefixStr, tostring(round))
        table.insert(totalStrList, partStr)
        self:AddTab()
        for runCount, x in pairs(q) do
          partStr = string.format("%sRunCount['%s'] = {\n", self._curPrefixStr, tostring(runCount))
          table.insert(totalStrList, partStr)
          self:AddTab()
          for index, t in ipairs(x) do
            partStr = string.format("%s[%s]={\n", self._curPrefixStr, tostring(index))
            table.insert(totalStrList, partStr)
            self:AddTab()
            partStr = string.format("%sTreeID=%s,\n", self._curPrefixStr, tostring(t.TreeID))
            table.insert(totalStrList, partStr)
            partStr = string.format("%sType=%s,\n", self._curPrefixStr, tostring(t.Type))
            table.insert(totalStrList, partStr)
            if t.SlotID then
              partStr = string.format("%sSlotID=%s,\n", self._curPrefixStr, tostring(t.SlotID))
              table.insert(totalStrList, partStr)
            end
            if t.Info then
              partStr = string.format("%sInfo='%s',\n", self._curPrefixStr, tostring(t.Info))
              table.insert(totalStrList, partStr)
            end
            self:DelTab()
            partStr = self:BlockEndStr()
            table.insert(totalStrList, partStr)
          end
          self:DelTab()
          partStr = self:BlockEndStr()
          table.insert(totalStrList, partStr)
        end
        self:DelTab()
        partStr = self:BlockEndStr()
        table.insert(totalStrList, partStr)
      end
      self:DelTab()
      partStr = self:BlockEndStr()
      table.insert(totalStrList, partStr)
    end
    self:DelTab()
    partStr = self:BlockEndStr()
    table.insert(totalStrList, partStr)
  end
  local totalStr = table.concat(totalStrList)
  return totalStr
end
