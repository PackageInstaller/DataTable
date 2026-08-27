local bs_22002 = class("bs_22002", LuaSkillBase)
local base = LuaSkillBase
bs_22002.config = {buffId = 110040}

function bs_22002:ctor()
end

function bs_22002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_22002_1", 1, self.OnAfterBattleStart)
end

function bs_22002:OnAfterBattleStart()
  local table = {
    1016,
    1028,
    1033,
    1044,
    1043
  }
  local selfRole = self.caster.roleDataId
  local listNum = #table
  if listNum ~= 0 then
    for i = 1, listNum do
      local roleIdNow = table[i]
      if roleIdNow == selfRole then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, false)
        LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.3, 1.3, 1.3), 0.2)
        break
      end
    end
  end
end

function bs_22002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_22002
