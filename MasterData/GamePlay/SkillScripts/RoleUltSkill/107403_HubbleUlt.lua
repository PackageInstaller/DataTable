local bs_107403 = class("bs_107403", LuaSkillBase)
local base = LuaSkillBase
bs_107403.config = {
  HurtConfigID = 17,
  gridId = 1136,
  effectId_hit = 107415,
  audioIdStart = 107413,
  audioIdMovie = 107414,
  audioIdEnd = 107415
}

function bs_107403:ctor()
end

function bs_107403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107403:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_hit, self, nil, nil, nil, true)
    local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
    if targetlist ~= nil and targetlist.Count > 0 then
      for i = 0, targetlist.Count - 1 do
        local role = targetlist[i]
        if role.belongNum ~= eBattleRoleBelong.player then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[1]
          })
          skillResult:EndResult()
        end
      end
    end
    local gridlist = LuaSkillCtrl:FindAllGridsWithinRange(targetGrid, 1, true)
    if gridlist ~= nil and gridlist.Count > 0 then
      for i = 0, gridlist.Count - 1 do
        local grid = gridlist[i]
        local EfcGrid = LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, self.config.gridId)
        if EfcGrid ~= nil then
          EfcGrid:BindNeutralBattleSkill(self.cskill)
        end
      end
    end
  end
end

function bs_107403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107403:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107403:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107403:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107403:OnCasterDie()
  self:CancleCasterWait()
  base.OnCasterDie(self)
end

function bs_107403:LuaDispose()
  base.LuaDispose(self)
end

return bs_107403
