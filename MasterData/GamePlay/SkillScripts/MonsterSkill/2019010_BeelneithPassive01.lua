local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_2019010 = class("bs_2019010", bs_200001)
local base = bs_200001
bs_2019010.config = {
  buffIdSC = 186,
  buffIdSY = 187,
  buffSilence = 1159,
  timeDuration = 15
}
bs_2019010.config = setmetatable(bs_2019010.config, {
  __index = base.config
})

function bs_2019010:ctor()
end

function bs_2019010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["514_Roll"] = self.arglist[1]
  self.caster.recordTable["514_skill"] = true
  self.caster.recordTable["514_arg"] = self.arglist[2]
  self.caster.recordTable["514_buffarg"] = self.arglist[3]
  self:AddAfterHurtTrigger("bs_2019010_3", 1, self.OnAfterHurt, nil, self.caster)
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2019010:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_2019010:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
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

function bs_2019010:TimeUp()
  LuaSkillCtrl:ForceEndBattle(false)
end

function bs_2019010:OnCasterDie()
  base.OnCasterDie(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffIdSC, 10, true)
      LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffIdSY, 10, true)
    end
  end
end

return bs_2019010
