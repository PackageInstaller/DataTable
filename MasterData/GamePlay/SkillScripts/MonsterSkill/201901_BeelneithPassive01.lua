local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_201901 = class("bs_201901", bs_200001)
local base = bs_200001
bs_201901.config = {
  buffIdSC = 186,
  buffIdSY = 187,
  buffSilence = 1159
}
bs_201901.config = setmetatable(bs_201901.config, {
  __index = base.config
})

function bs_201901:ctor()
end

function bs_201901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["514_Roll"] = self.arglist[1]
  self.caster.recordTable["514_skill"] = true
  self.caster.recordTable["514_arg"] = self.arglist[2]
  self.caster.recordTable["514_buffarg"] = self.arglist[3]
  self:AddAfterHurtTrigger("bs_201901_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_201901:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.roleDataId == 30004 and skill.dataId == 202003 and not self.caster.recordTable.SkillFlag and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffSilence, 0)
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          if skills[j].dataId == 201905 then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_201901:OnCasterDie()
  base.OnCasterDie(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffIdSC, 10, true)
      LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffIdSY, 10, true)
    end
  end
end

return bs_201901
