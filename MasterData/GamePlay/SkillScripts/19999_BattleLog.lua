local bs_19999 = class("bs_19999", LuaSkillBase)
local base = LuaSkillBase
bs_19999.config = {
  logPath = "D:/Project3/BattleLog.txt",
  logNum = 10
}

function bs_19999:ctor()
end

function bs_19999:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_19999_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_19999_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_19999_5", 1, self.OnAfterHeal)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_19999_7", 1, self.OnAfterAddBuff)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_19999_10", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_19999_12", 1, self.OnAfterPlaySkill)
  file = io.open(self.config.logPath, "a")
end

function bs_19999:OnAfterBattleStart()
  file:write("战斗开始。。。。" .. "\n")
  file:write("分类 " .. "角色 " .. "技能id " .. "数值 " .. "闪避 " .. "暴击\n")
end

function bs_19999:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == 1 and target.belongNum == 2 then
    file:write("伤害 " .. sender.name .. " " .. tostring(skill.dataId) .. " " .. tostring(hurt) .. " " .. tostring(isMiss) .. " " .. tostring(isCrit) .. "\n")
  end
end

function bs_19999:OnAfterHeal(sender, target, skill, heal)
  if sender.belongNum == 1 and target.belongNum == 1 then
    file:write("治疗 " .. sender.name .. " " .. tostring(skill.dataId) .. " " .. tostring(heal) .. "\n")
  end
end

function bs_19999:OnAfterAddBuff(buff, target)
  file:write("buff " .. target.name .. " " .. tostring(buff.dataId) .. "\n")
end

function bs_19999:OnRoleDie(killer, role)
  if role.belongNum == 1 then
    file:write("死亡 " .. role.name .. tostring(LuaSkillCtrl.battleCtrl.frame) .. "\n")
  end
end

function bs_19999:OnAfterPlaySkill(skill, role)
  file:write("放技能 " .. role.name .. tostring(skill.dataId) .. "\n")
end

function bs_19999:OnCasterDie()
end

return bs_19999
