local bs_50000 = class("bs_50000", LuaSkillBase)
local base = LuaSkillBase
bs_50000.config = {
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 4,
    aoe_range = 10
  },
  buffId = 1025,
  buffTier = 1
}

function bs_50000:ctor()
end

function bs_50000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if isMidwaySkill then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role.intensity ~= 0 then
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1, 75)
        end
      end
    end
  end
end

function bs_50000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50000
