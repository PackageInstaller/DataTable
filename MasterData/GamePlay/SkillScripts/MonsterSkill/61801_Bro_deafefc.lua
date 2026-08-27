local bs_61801 = class("bs_61801", LuaSkillBase)
local base = LuaSkillBase
bs_61801.config = {
  buffId_power = 210801,
  buffId_atrr1 = 210803,
  buffId_atrr2 = 210804,
  effectId = 210808
}

function bs_61801:ctor()
end

function bs_61801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_61801", 99, self.OnSetDeadHurt, nil, self.caster)
end

function bs_61801:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if context.target == self.caster and NoDeath == false then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
    if targetList ~= nil and targetList.Count > 0 then
      for i = targetList.Count - 1, 0, -1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.belongNum == self.caster.belongNum then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_atrr1, 1)
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_atrr2, self.caster.recordTable.buff_num)
        end
      end
    end
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    if grid ~= nil then
      LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, 1129)
    end
  end
end

function bs_61801:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_61801
