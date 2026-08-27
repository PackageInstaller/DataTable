local CSTSkillData = class("CSTSkillData")
local cs_GameData_ins = CS.GameData.instance
local CSTUtil = require("Game.CommanderSkill.CSTUtil")

function CSTSkillData:ctor(cstSkillId, level)
  self.cstSkillId = cstSkillId
  self.cstSkillLevel = level or 1
  self.cstId = ConfigData.commander_skill_unlock.cstSkillId2cstId[cstSkillId]
  if self.cstId == nil then
    error("CST Skill Cfg is null,Id:" .. tostring(cstSkillId))
    return
  end
  self.cstSkillCfg = ConfigData.commander_skill_unlock[self.cstId][cstSkillId]
  if self.cstSkillCfg == nil then
    error("CST Skill Cfg is null,Id:" .. tostring(cstSkillId))
    return
  end
  self.realSkillId = self.cstSkillCfg.skill_id
  local battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(self.realSkillId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(self.realSkillId))
    return
  end
  self.battleSkillCfg = battleSkillCfg
  self.mpCost = self.battleSkillCfg.PlayerMpCost
  self.cdTime = BattleUtil.FrameToTime(self.battleSkillCfg.CdTime)
end

function CSTSkillData:GetCSTSId()
  return self.cstSkillId
end

function CSTSkillData:GetCSTSkillRealSkilllId()
  return self.realSkillId
end

function CSTSkillData:GetCSTSkillLevel()
  return self.cstSkillLevel
end

function CSTSkillData:GetCSTSkillSlot()
  return self.cstSkillCfg.place
end

function CSTSkillData:IsFairyReplaceSKill()
  return self.cstSkillCfg.fairy_skill
end

function CSTSkillData:IsCmdSkillUnlock()
  return CSTUtil.IsCSTSkillUnlock(self.cstSkillId)
end

function CSTSkillData:GetCSTSkillUnlockDes()
  return CSTUtil.GetCSTSkillUnlockDes(self.cstSkillId)
end

function CSTSkillData:GetCSTSkillName()
  return LanguageUtil.GetLocaleText(self.battleSkillCfg.Name)
end

function CSTSkillData:GetCSTSkillDescribe()
  local des = self.battleSkillCfg:GetLevelDescribe(self.cstSkillLevel)
  if des == "" then
    des = self.battleSkillCfg.Describe
  end
  return des
end

function CSTSkillData:GetCSTSkillIcon()
  return self.battleSkillCfg.Icon
end

function CSTSkillData:CmdSkillIsManualMode()
  return self.battleSkillCfg.ManualMode
end

function CSTSkillData:GetSCTSkillMpCostNum()
  return self.battleSkillCfg.PlayerMpCost
end

function CSTSkillData:GetCSTSkillCD()
  return self.cdTime
end

return CSTSkillData
