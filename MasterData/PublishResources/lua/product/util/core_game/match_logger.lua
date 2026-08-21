_class("MatchLogger", Object)
MatchLogger = MatchLogger

function MatchLogger:Constructor(world)
  self._logs = {}
  self._skills = {}
  self._buffs = {}
  self._world = world
  if not StringTable then
    StringTable = {
      Get = function(name)
        return name
      end
    }
  end
end

function MatchLogger:CheckEnabled()
  if self._world:GetRunningPosition() == WorldRunPostion.AtClient then
    _G.ENABLE_MATCH_LOG = self._world:IsDevelopEnv()
  else
    _G.ENABLE_MATCH_LOG = false
  end
end

function MatchLogger:GetLogs()
  return self._logs
end

function MatchLogger:AddMatchLog(logname, info, v)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  table.insert(self._logs, {name = logname, info = info})
  if v then
    self._world:GetService("Trigger"):Notify(NTAddMatchLog:New(v))
  end
end

function MatchLogger:SaveMatchLog(open)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local dir = EngineGameHelper.StoragePath .. "MatchLog/"
  App.MakeDir(dir)
  local _filePath = dir .. "MatchLog" .. os.date("%y%m%d%H%M%S") .. ".log"
  local file = io.open(_filePath, "w")
  for i, log in ipairs(self._logs) do
    file:write(log.info)
    file:write("\n")
  end
  io.close(file)
  if EDITOR and open then
    SmokingTestHub.OpenLogFile(_filePath)
  end
end

function MatchLogger:BeginSkill(attackerid, attackpos, skillid, range)
  self._world:GetDetailMatchLogger():BeginSkill(attackerid, attackpos, skillid, range)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
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

function MatchLogger:EndSkill(attackerid)
  self._world:GetDetailMatchLogger():EndSkill(attackerid)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local v = self._skills[attackerid]
  if v then
    local desc = self:SkillLogToString(v)
    self._skills[attackerid] = nil
    self:AddMatchLog("Skill", desc, v)
  end
  if EDITOR then
    self._world:EventDispatcher():Dispatch(GameEventType.SkillEndForEditor, attackerid)
  end
end

function MatchLogger:BeginBuff(attackerid, buffid)
  self._world:GetDetailMatchLogger():BeginBuff(attackerid, buffid)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local t = {
    desc = "攻击者[attackerid] BUFFID[buffid]",
    attackerid = attackerid,
    buffid = buffid
  }
  self._buffs[attackerid] = t
end

function MatchLogger:EndBuff(attackerid)
  self._world:GetDetailMatchLogger():EndBuff(attackerid)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local v = self._buffs[attackerid]
  if v then
    local desc = self:BuffLogToString(v)
    self._buffs[attackerid] = nil
    self:AddMatchLog("Buff", desc, v)
  end
end

function MatchLogger:BeginDamageLog(attackerid)
  self._world:GetDetailMatchLogger():BeginDamageLog(attackerid)
  if not _G.ENABLE_MATCH_LOG then
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

function MatchLogger:AddDamageLog(attackerid, log)
  self._world:GetDetailMatchLogger():AddDamageLog(attackerid, log)
  self._world:GetSyncLogger():Trace(log)
  if not _G.ENABLE_MATCH_LOG then
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

function MatchLogger:EndDamageLog(attackerid)
  self._world:GetDetailMatchLogger():EndDamageLog(attackerid)
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local attack = self._buffs[attackerid] or self._skills[attackerid]
  if not attack then
    return
  end
end

function MatchLogger:AddBloodLog(attackerid, log)
  self._world:GetDetailMatchLogger():AddBloodLog(attackerid, log)
  self._world:GetSyncLogger():Trace(log)
  if not _G.ENABLE_MATCH_LOG then
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

function MatchLogger:AddHPShieldLog(attackerid, log)
  self._world:GetDetailMatchLogger():AddHPShieldLog(attackerid, log)
  self._world:GetSyncLogger():Trace(log)
  if not _G.ENABLE_MATCH_LOG then
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

function MatchLogger:SkillLogToString(t)
  local cfgsvc = self._world:GetService("Config")
  local skillName = cfgsvc:GetSkillConfigData(t.skillid):GetSkillName()
  skillName = StringTable.Get(skillName)
  local s = "技能[" .. t.skillid .. "] 名字[" .. skillName .. "]\n"
  s = s .. self:LogToString(t) .. "\n"
  if t.calcDamage then
    for i, v in ipairs(t.calcDamage) do
      for k, d in ipairs(v) do
        s = s .. ">> " .. self:LogToString(d) .. "\n"
      end
    end
  end
  if t.calcAddBlood then
    for i, v in ipairs(t.calcAddBlood) do
      s = s .. ">>" .. self:LogToString(v) .. "\n"
    end
  end
  if t.calcAddHPShield then
    for i, v in ipairs(t.calcAddHPShield) do
      s = s .. ">>" .. self:LogToString(v) .. "\n"
    end
  end
  return s
end

function MatchLogger:BuffLogToString(t)
  local cfgsvc = self._world:GetService("Config")
  local buffName = cfgsvc:GetBuffConfigData(t.buffid):GetBuffName()
  buffName = StringTable.Get(buffName)
  local s = "BUFF[" .. t.buffid .. "] 名字[" .. buffName .. "]\n"
  s = s .. self:LogToString(t) .. "\n"
  if t.calcDamage then
    for i, v in ipairs(t.calcDamage) do
      for k, d in ipairs(v) do
        s = s .. ">> " .. self:LogToString(d) .. "\n"
      end
    end
  end
  if t.calcAddBlood then
    for i, v in ipairs(t.calcAddBlood) do
      s = s .. ">>" .. self:LogToString(v) .. "\n"
    end
  end
  if t.calcAddHPShield then
    for i, v in ipairs(t.calcAddHPShield) do
      s = s .. ">>" .. self:LogToString(v) .. "\n"
    end
  end
  return s
end

local splitT

local function SplitToString(s)
  return "[" .. tostring(splitT[s]) .. "]"
end

function MatchLogger:LogToString(t)
  splitT = t
  local desc = string.gsub(t.desc, "%[(%w+)%]", SplitToString)
  splitT = nil
  return desc
end

function MatchLogger:TakeSnapshot()
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local fsmInfo = self:GetFSMInfo()
  self:AddMatchLog("FSMInfo", fsmInfo)
  if teamEntity then
    local teamInfo = self:GetTeamInfo(teamEntity)
    self:AddMatchLog("TeamInfo", teamInfo)
    local petInfo = self:GetPetInfo(teamEntity)
    self:AddMatchLog("PetInfo", petInfo)
  end
  local monsterInfo = self:GetMonsterInfo()
  local trapInfo = self:GetTrapInfo()
  self:AddMatchLog("MonsterInfo", monsterInfo)
  self:AddMatchLog("TrapInfo", trapInfo)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    teamEntity = self._world:Player():GetRemoteTeamEntity()
    local teamInfo = self:GetTeamInfo(teamEntity)
    local petInfo = self:GetPetInfo(teamEntity)
    self:AddMatchLog("EnemyTeamInfo", teamInfo)
    self:AddMatchLog("EnemyPetInfo", petInfo)
  end
end

function MatchLogger:GetFSMInfo()
  local fsmState = self._world:GameFSM():CurStateID()
  local stateName = GetEnumKey("GameStateID", fsmState)
  local roundCount = self._world:BattleStat():GetLevelTotalRoundCount()
  local curWaveNum = self._world:BattleStat():GetCurWaveIndex()
  local desc = "状态机[" .. stateName .. "] 回合数[" .. roundCount .. "] 波次[" .. curWaveNum .. "]\n"
  return desc
end

function MatchLogger:GetTeamInfo(teamEntity)
  local e = teamEntity
  local pos = e:GridLocation():GetGridPos()
  local attr = self:GetAttributeInfo(e)
  local buff = self:GetBuffInfo(e)
  local s = "队伍[" .. e:GetID() .. "]  位置[" .. tostring(pos) .. "] 属性[" .. attr .. "] buff[" .. buff .. "]\n"
  return s
end

function MatchLogger:GetPetInfo(teamEntity)
  local s = ""
  local es = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(es) do
    local tid = e:PetPstID():GetTemplateID()
    local pos = e:GridLocation():GetGridPos()
    local attr = self:GetAttributeInfo(e)
    local buff = self:GetBuffInfo(e)
    local name = StringTable.Get(Cfg.cfg_pet[tid].Name)
    local desc = "星灵[" .. e:GetID() .. "|" .. tid .. "] 名字[" .. name .. "] 位置[" .. tostring(pos) .. "] 属性[" .. attr .. "] buff[" .. buff .. "]\n"
    s = s .. desc
  end
  return s
end

function MatchLogger:GetMonsterInfo()
  local s = ""
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local cnt = 0
  for i, e in ipairs(group:GetEntities()) do
    local tid = e:MonsterID():GetMonsterID()
    local pos = e:GridLocation():GetGridPos()
    local dir = e:GridLocation():GetGridDir()
    local attr = self:GetAttributeInfo(e)
    local buff = self:GetBuffInfo(e)
    local name = StringTable.Get(Cfg.cfg_monster_class[Cfg.cfg_monster[tid].ClassID].Name)
    local desc = "怪物[" .. e:GetID() .. "|" .. tid .. "] 名字[" .. name .. "] 位置[" .. tostring(pos) .. "] 属性[" .. attr .. "] buff[" .. buff .. "]\n"
    s = s .. desc
    cnt = cnt + 1
    if 5 < cnt then
      self:AddMatchLog("MonsterInfo" .. i, s)
      cnt = 0
      s = ""
    end
  end
  return s
end

function MatchLogger:GetTrapInfo()
  local s = ""
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local cnt = 0
  for i, e in ipairs(group:GetEntities()) do
    local tid = e:Trap():GetTrapID()
    local pos = e:GridLocation():GetGridPos()
    local dir = e:GridLocation():GetGridDir()
    local attr = self:GetAttributeInfo(e)
    local buff = self:GetBuffInfo(e)
    local name = StringTable.Get(Cfg.cfg_trap[tid].NameStr)
    if name == nil then
      name = "null"
    end
    local desc = "机关[" .. e:GetID() .. "|" .. tid .. "] 名字[" .. name .. "] 位置[" .. tostring(pos) .. "] 属性[" .. attr .. "] buff[" .. buff .. "]\n"
    s = s .. desc
    cnt = cnt + 1
    if 5 < i then
      self:AddMatchLog("TrapInfo" .. i, s)
      s = ""
      cnt = 0
    end
  end
  return s
end

function MatchLogger:GetBuffInfo(e)
  local buffCom = e:BuffComponent()
  if buffCom then
    if #buffCom:GetBuffArray() == 0 then
      return ""
    end
    local s = "\n"
    for i, buff in ipairs(buffCom:GetBuffArray()) do
      local buffid = buff:BuffID()
      local name = StringTable.Get(Cfg.cfg_buff[buffid].Name)
      s = s .. "\t buffID[" .. buffid .. "] 名称[" .. name .. "]\n"
    end
    return s
  end
end

function MatchLogger:GetAttributeInfo(e)
  local attrCom = e:Attributes()
  local buffCom = e:BuffComponent()
  local s = "\n"
  for name, attr in pairs(attrCom.modifierDic) do
    local value = attr:Value()
    if type(value) == "number" then
      local desc = self:GetAttrCNName(name) .. "[" .. value .. "]"
      if attr.valueModifyList then
        desc = desc .. " 修改BuffID["
        for i, v in ipairs(attr.valueModifyList) do
          if v[1] > 1000 and buffCom then
            local buffInstance = buffCom:GetBuffBySeq(v[1])
            if buffInstance then
              local buffid = buffInstance:BuffID()
              desc = desc .. buffid .. " "
            end
          end
        end
        desc = desc .. "] "
      end
      s = s .. "\t " .. desc .. "\n"
      if name == "HP" then
        local t = {
          "\t 灰血池积蓄[",
          buffCom:GetGreyHPValue(true),
          "]\n"
        }
        s = s .. table.concat(t)
      end
    end
  end
  return s
end

AttrCN = {
  Ready = "大招就绪",
  Defense = "防御",
  HP = "当前血量",
  Power = "大招剩余CD",
  MaxHP = "血量上限",
  MaxPower = "大招CD上限",
  Attack = "攻击",
  Element = "元素属性",
  NormalSkillParam = "普攻伤害系数",
  ChainSkillParam = "连锁技伤害系数",
  ActiveSkillParam = "主动技技能系数",
  MonsterSkillParam = "怪物技能系数",
  NormalSkillFinalParam = "普攻最终系数",
  ActiveSkillFinalParam = "主动技最终系数",
  ChainSkillFinalParam = "连锁技最终系数",
  MonsterSkillFinalParam = "怪物最终系数",
  ChainSkillIncreaseParam = "连锁技提升系数",
  ActiveSkillIncreaseParam = "主动技提升系数",
  NormalSkillIncreaseParam = "普攻提升系数",
  MonsterSkillIncreaseParam = "怪物技能提升系数",
  TrapSkillIncreaseParam = "机关技能提升系数",
  PrimarySecondaryParam = "主副属性系数",
  FinalBehitDamageParam = "被击者最终伤害系数",
  ExElementParam = "额外属性系数",
  MonsterSkillFinalParam = "怪物技能最终系数",
  MonsterSkillIncreaseParam = "怪物技能提升",
  AttackPercentage = "攻击力百分比加成",
  AttackConstantFix = "攻击力固定值加成",
  DefencePercentage = "防御力百分比加成",
  DefenceConstantFix = "防御力固定加成",
  MaxHPPercentage = "血量上限百分比加成",
  MaxHPConstantFix = "血量上限固定值加成",
  AddBloodRate = "回血系数",
  AbsorbNormal = "普攻吸收系数",
  AbsorbChain = "连锁技吸收系数",
  AbsorbActive = "主动技吸收系数",
  SecondaryAttackParam = "副属性攻击系数",
  AllAttackParam = "主副属性相同攻击系数"
}

function MatchLogger:GetAttrCNName(name)
  return AttrCN[name] or name
end
