local bs_109203 = class("bs_109203", LuaSkillBase)
local base = LuaSkillBase
bs_109203.config = {
  HurtConfigId = 17,
  effectId_hit = 109208,
  buffid_huyou = 109201,
  audioIdStart = 109206,
  audioIdMovie = 109207,
  audioIdEnd = 109208
}

function bs_109203:ctor()
end

function bs_109203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109203:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_hit, self)
    local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
    if targetlist ~= nil and targetlist.Count > 0 then
      for i = 0, targetlist.Count - 1 do
        local role = targetlist[i]
        if role.belongNum ~= eBattleRoleBelong.player then
          local self_pow = 0
          local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
          if targetList.Count > 0 then
            for i = targetList.Count - 1, 0, -1 do
              if i < targetList.Count and 0 <= i and targetList[i] ~= nil and 0 < targetList[i].hp then
                self_pow = self_pow + targetList[i].skill_intensity
              end
            end
          end
          local tar_pow = role.skill_intensity
          local value = (self_pow / tar_pow - 1) * 1000
          if value > self.arglist[2] * 1000 then
            value = self.arglist[2] * 1000
          elseif value < 0 then
            value = 0
          end
          for i = 0, self.arglist[3] - 1 do
            LuaSkillCtrl:CallBuff(self, role, self.config.buffid_huyou, 1)
          end
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
            self.arglist[1] + self.arglist[1] * value // 1000
          })
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_109203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.8)
end

function bs_109203:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_109203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_109203:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_109203:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109203:LuaDispose()
  base.LuaDispose(self)
end

return bs_109203
