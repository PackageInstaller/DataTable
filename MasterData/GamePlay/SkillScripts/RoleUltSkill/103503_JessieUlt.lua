local bs_103503 = class("bs_103503", LuaSkillBase)
local base = LuaSkillBase
bs_103503.config = {
  startEffect1 = 10518,
  startEffect2 = 10519,
  heal_config = {baseheal_formula = 3021},
  heal_configF = {baseheal_formula = 3028},
  select_ally = 6,
  audioIdStart = 280,
  audioIdMovie = 281,
  audioIdEnd = 282,
  buffId_Ult = 103501,
  movieEndRoleActionId = 1006
}

function bs_103503:ctor()
end

function bs_103503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103503:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(5)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_ally, 10)
  if targetList.Count <= 0 then
    return
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  local map = LuaSkillCtrl:GetMapBorder()
  if map.x == 6 then
    LuaSkillCtrl:CallEffect(effectTarget, self.config.startEffect1, self, nil, nil, 1)
  else
    LuaSkillCtrl:CallEffect(effectTarget, self.config.startEffect2, self, nil, nil, 1)
  end
  LuaSkillCtrl:StartTimer(nil, 5, function()
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role.belongNum == self.caster.belongNum then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        local healCfg
        if self:IsConsumeSkill() then
          healCfg = self.config.heal_configF
        else
          healCfg = self.config.heal_config
        end
        LuaSkillCtrl:HealResult(skillResult, healCfg, {
          self.arglist[1]
        })
        skillResult:EndResult()
        local debuffs = LuaSkillCtrl:GetRoleBuffs(role)
        if debuffs ~= nil and 0 < debuffs.Count then
          for i = 0, debuffs.Count - 1 do
            if debuffs[i].buffType == 2 then
              LuaSkillCtrl:DispelBuff(role, debuffs[i].dataId, 0)
            end
          end
        end
      end
    end
  end)
end

function bs_103503:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103503:OnUltRoleAction()
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_103503:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103503:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_103503:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103503
