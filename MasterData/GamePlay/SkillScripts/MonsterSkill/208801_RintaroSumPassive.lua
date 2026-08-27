local bs_208801 = class("bs_208801", LuaSkillBase)
local base = LuaSkillBase
bs_208801.config = {
  buffFeature_ignoreDie = 6,
  standDie = 107604,
  buff_die = 103201,
  effectId = 107609
}

function bs_208801:ctor()
end

function bs_208801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_208801_1", 1, self.OnSetHurt, nil, nil, nil, self.caster.belongNum, nil, 1)
  self.arg1 = self.caster.recordTable.arg_1
  self.arg2 = self.caster.recordTable.arg_2
  self.arg3 = self.caster.recordTable.arg_3
  self.Mark = 0
  self.effect = nil
  self.timer = nil
end

function bs_208801:OnAfterBattleStart()
  LuaSkillCtrl:CallRoleAction(self.caster, 1045, 1)
  self.timer = LuaSkillCtrl:StartTimer(self, 15, function()
    if self.effect == nil and self.timer ~= nil then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      self.timer = nil
    end
  end)
  LuaSkillCtrl:StartTimer(self, self.arg1, function()
    local IfRoleIgnoreDie = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
    if IfRoleIgnoreDie == true then
      local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
      if buff_ignoreDie.Count > 0 then
        for i = 0, buff_ignoreDie.Count - 1 do
          LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0, true)
        end
        IfRoleIgnoreDie = false
      end
    end
    if 0 < self.caster.hp and IfRoleIgnoreDie == false then
      self.Mark = 1
      LuaSkillCtrl:StartTimer(self, 25, function()
        LuaSkillCtrl:CallEffect(self.caster, self.config.standDie, self)
        LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, false)
      end)
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
      LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, nil, nil, false, true, eHurtType.RealDmg, true)
    end
  end)
end

function bs_208801:OnSetHurt(context)
  if context.target.uid == self.arg2 and self.caster.hp > 0 and context.target.isDead == false then
    local num = context.hurt * self.arg3 // 1000
    context.hurt = context.hurt - num
    LuaSkillCtrl:RemoveLife(num, self, self.caster, true, nil, true)
  end
end

function bs_208801:OnCasterDie()
  if self.Mark == 1 then
    LuaSkillCtrl:CallRoleAction(self.caster, 1046, 1)
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:StartTimer(self, 30, function()
    base.OnCasterDie(self)
  end)
end

function bs_208801:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
  self.timer = nil
end

return bs_208801
