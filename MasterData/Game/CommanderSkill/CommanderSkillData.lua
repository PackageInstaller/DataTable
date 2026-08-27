local CommanderSkillData = class("CommanderSkillData")
local cs_GameData_ins = CS.GameData.instance
CommanderSkillData.skillType = {
  active = 1,
  passive = 2,
  master = 3
}

function CommanderSkillData:ctor(dataId, skillCfg)
  self.dataId = dataId
  self.skillCfg = skillCfg
  self.levelIconList = skillCfg.levelIconList
  self.type = CommanderSkillData.skillType.passive
  self.place = 0
  self.isNewUnlock = false
  if skillCfg.unlockPreConditionList ~= nil then
    self.unlockCondition = skillCfg.unlockPreConditionList[1]
  end
  local battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(self.dataId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(self.dataId))
    return
  end
  self.battleSkillCfg = battleSkillCfg
  self.mpCost = self.battleSkillCfg.PlayerMpCost
  self.cdTime = BattleUtil.FrameToTime(self.battleSkillCfg.CdTime)
end

function CommanderSkillData:InitCmdSkillData(type, place)
  self.type = type
  self.place = place
end

function CommanderSkillData:GetName()
  return self.battleSkillCfg.Name
end

function CommanderSkillData:GetIcon()
  return self.battleSkillCfg.Icon
end

function CommanderSkillData:GetDescribe()
  local des = self.battleSkillCfg:GetLevelDescribe(1)
  if des == "" then
    des = self.battleSkillCfg.Describe
  end
  return des
end

function CommanderSkillData:GetID()
  return self.dataId
end

function CommanderSkillData:IsCmdSkillUnlock()
  if self.unlockCondition == nil then
    return true
  end
  return CheckCondition.CheckLua(self.unlockCondition.pre_condition, self.unlockCondition.pre_para1, self.unlockCondition.pre_para2)
end

function CommanderSkillData:SetCmdSkillSlotDefault()
  self.isSlotDefault = true
end

function CommanderSkillData:CmdSkillIsSlotDefault()
  return self.isSlotDefault
end

function CommanderSkillData:CmdSkillIsManualMode()
  return self.battleSkillCfg.ManualMode
end

function CommanderSkillData:GetUnlockDes()
  if self.unlockCondition == nil then
    return nil
  end
  return CheckCondition.GetUnlockInfoLua(self.unlockCondition.pre_condition, self.unlockCondition.pre_para1, self.unlockCondition.pre_para2)
end

function CommanderSkillData.GetCmdSkillIconById(skillId)
  local battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(skillId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(skillId))
    return
  end
  return battleSkillCfg.Icon
end

return CommanderSkillData
