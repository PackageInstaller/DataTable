local bs_70037 = class("bs_70037", LuaSkillBase)
local base = LuaSkillBase
bs_70037.config = {
  nanaka_buffId = 102603,
  buffId_live = 3009,
  buffId_invincibility = 60503,
  campNotBeSelectBuff = 50
}

function bs_70037:ctor()
end

function bs_70037:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_70035_8", 999, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.player)
  self.caster.recordTable.RebornTime = self.arglist[1]
  self.caster.recordTable.InvincibleTime = self.arglist[2]
  local pfList = LuaSkillCtrl:CallTargetSelect(self, 75, 10)
  if pfList[0].targetRole ~= nil then
    self.pf_x, self.pf_y = pfList[0].x, pfList[0].y
  else
    self.pf_x, self.pf_y = 0, 0
  end
end

function bs_70037:OnSetDeadHurt(context)
  local RebornTime = self.caster.recordTable.RebornTime
  local InvincibleTime = self.caster.recordTable.InvincibleTime
  if RebornTime == nil then
    local RebornTime = self.arglist[1]
  end
  if InvincibleTime == nil then
    InvincibleTime = self.arglist[2]
  end
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  local target = context.target
  if target.belongNum == eBattleRoleBelong.player and target.roleType == 1 and target ~= context.sender and target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false then
    if not LuaSkillCtrl.IsInVerify then
      local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
      if window ~= nil then
        window:DisableHeroUltSkill(target.roleDataId, true)
        window:ShowHeroReturnCD(target.roleDataId, RebornTime)
      end
    end
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, RebornTime, true)
    LuaSkillCtrl:CallBuff(self, context.target, self.config.campNotBeSelectBuff, 1, RebornTime, true)
    LuaSkillCtrl:DisactiveCharacter(target, context.sender, context.skill, true, 50)
    LuaSkillCtrl:StartTimer(nil, RebornTime, function(target)
      local grid
      local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(self.pf_x, self.pf_y, 11)
      if grids.Count > 0 then
        grid = grids[0]
      else
        grid = LuaSkillCtrl:FindEmptyGrid()
      end
      if grid == nil then
        return
      end
      LuaSkillCtrl:DispelBuff(target, self.config.buffId_live)
      LuaSkillCtrl:DispelBuff(target, self.config.campNotBeSelectBuff)
      LuaSkillCtrl:ResurrectionCharacter(target, grid.coord, 10000, 50)
      LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_invincibility, 1, InvincibleTime, true)
      if not LuaSkillCtrl.IsInVerify then
        local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
        if window ~= nil then
          window:DisableHeroUltSkill(target.roleDataId, false)
        end
      end
    end, target)
  end
end

function bs_70037:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70037
