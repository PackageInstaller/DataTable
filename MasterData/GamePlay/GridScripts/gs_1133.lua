local gs_1133 = class("gs_1133", LuaGridBase)
local base = LuaGridBase
gs_1133.config = {
  dispelBuff_time = 15,
  chiyan_buff = 107101,
  life_time = 75,
  effect_dispel = 107305
}

function gs_1133:ctor()
end

function gs_1133:__OnGridSkillInit()
  base.__OnGridSkillInit(self)
end

function gs_1133:OnGridBattleStart(role)
end

function gs_1133:StartCreatGrid()
end

function gs_1133:OnGridEnterRole(role)
  if self.loop == nil then
    self.loop = LuaSkillCtrl:StartTimer(nil, self.config.dispelBuff_time, function()
      local buffs = LuaSkillCtrl:GetRoleBuffs(role)
      if role.belongNum ~= 1 then
        self.cskill = self.cEffectGrid.battleSkill
        self.caster = self.cskill.maker
      else
        return
      end
      LuaSkillCtrl:CallEffect(role, self.config.effect_dispel, self)
      if buffs ~= nil or 1 <= buffs.Count then
        for i = 0, buffs.Count - 1 do
          local Aimbuff = buffs[i]
          if Aimbuff.buffType == eBuffType.Beneficial then
            LuaSkillCtrl:DispelBuff(role, Aimbuff.dataId, 1, false)
            break
          end
        end
      end
      local skill_intensity = 0
      local role_skill_intensity_max
      local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if targetlist1.Count > 0 then
        for i = 0, targetlist1.Count - 1 do
          if skill_intensity <= targetlist1[i].skill_intensity then
            skill_intensity = targetlist1[i].skill_intensity
            role_skill_intensity_max = targetlist1[i]
          end
        end
      end
      if 0 < role:GetBuffTier(self.config.chiyan_buff) then
        local targetList = LuaSkillCtrl:FindAllRolesWithinRange(role, 1, true)
        if targetList.Count > 0 then
          for i = 0, targetList.Count - 1 do
            local role = targetList[i]
            if role.belongNum == eBattleRoleBelong.enemy or role.belongNum == eBattleRoleBelong.neutral then
              LuaSkillCtrl:CallBuff(self, targetList[i], self.config.chiyan_buff, 1, 120, nil, role_skill_intensity_max)
            end
          end
        end
      end
    end, self, -1, 5)
  end
end

function gs_1133:OnGridBeCorvered(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  if role ~= nil then
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(role, 1, true)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role.belongNum == eBattleRoleBelong.enemy or role.belongNum == eBattleRoleBelong.neutral then
          LuaSkillCtrl:CallBuff(self, role, self.config.chiyan_buff, 3, 120, nil)
        end
      end
    end
  end
  self:GridLoseEffect()
end

function gs_1133:OnGridExitRole(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridExitRole(self, role)
end

function gs_1133:OnGridBattleEnd(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridBattleEnd(self, role)
end

function gs_1133:OnGridRoleDead(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridRoleDead(self, role)
end

function gs_1133:LuaDispose()
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.LuaDispose(self)
end

return gs_1133
