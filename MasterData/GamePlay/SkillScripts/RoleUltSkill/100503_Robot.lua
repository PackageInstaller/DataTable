local bs_100503 = class("bs_100503", LuaSkillBase)
local base = LuaSkillBase
bs_100503.config = {
  effectId_Ult = 100516,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 100502,
    returndamage_formula = 0
  },
  hurt_configF = {
    hit_formula = 0,
    basehurt_formula = 100503,
    returndamage_formula = 0
  },
  series_0 = {
    1,
    3,
    9,
    15,
    18
  },
  series_1 = {
    2,
    5,
    8,
    14,
    17
  },
  series_2 = {
    4,
    7,
    10,
    13,
    19
  },
  series_3 = {
    1,
    6,
    10,
    15,
    21
  },
  series_4 = {
    5,
    8,
    12,
    20,
    22
  },
  aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  },
  audioIdStart = 100507,
  audioIdMovie = 100508,
  audioIdEnd = 100509,
  buffId_maim = 3001,
  buffId_stun = 3006,
  selectId = 9,
  select_Range = 10,
  skill_times = 5,
  movieEndRoleActionId = 1006,
  buffId_Super = 3003
}

function bs_100503:ctor()
end

function bs_100503:InitSkill(isMidwaySkill)
  self.hurt_config = {}
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
end

function bs_100503:PlaySkill()
  self:CallCasterWait(20)
  local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  if self.MapBorder.x > 7 then
    effectGrid = LuaSkillCtrl:GetTargetWithGrid(5, 3)
  end
  LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_Ult, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe)
  if skillResult.roleList.Count <= 0 then
    return
  end
  for i = 0, skillResult.roleList.Count - 1 do
    if LuaSkillCtrl:CheckReletionWithRoleBelong(skillResult.roleList[i], self.caster, eBelongReletionType.Enemy) then
      LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_stun, 1, 1, true)
      LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_maim, self.arglist[3], self.arglist[2])
    end
    local series = i % 5
    for n = 1, self.config.skill_times do
      LuaSkillCtrl:StartTimer(self, self.config["series_" .. tostring(series)][n], function()
        self:RealPlaySkill(skillResult.roleList[i])
      end, nil)
    end
  end
end

function bs_100503:RealPlaySkill(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  local hurtCfg
  if self:IsConsumeSkill() then
    hurtCfg = self.config.hurt_configF
  else
    hurtCfg = self.config.hurt_config
  end
  LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
  skillResult:EndResult()
end

function bs_100503:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100503:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_100503:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_100503:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100503:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100503:LuaDispose()
  base.LuaDispose(self)
end

return bs_100503
