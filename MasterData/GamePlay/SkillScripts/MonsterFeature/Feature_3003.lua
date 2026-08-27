local bs_3003 = class("bs_3003", LuaSkillBase)
local base = LuaSkillBase
bs_3003.config = {}

function bs_3003:ctor()
end

function bs_3003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.StoryEvent, "SteinGate_PowerSheepBorn")
  self:ChangeSize()
end

function bs_3003:ChangeSize()
  if self.caster.roleDataId == 50208 then
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3(3.5, 3.5, 3.5), 0.4)
  else
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3(2, 2, 2), 0.9)
  end
end

function bs_3003:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.StoryEvent, "SteinGate_PowerSheepDie")
end

return bs_3003
