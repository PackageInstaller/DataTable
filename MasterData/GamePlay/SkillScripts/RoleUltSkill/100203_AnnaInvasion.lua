local bs_100203 = class("bs_100203", LuaSkillBase)
local base = LuaSkillBase
bs_100203.config = {
  effectId_start = 100210,
  effectId_self = 100213,
  effectId_AnnaDizzy = 100211,
  effect_speed = 1,
  action_start = 1005,
  movieEndRoleActionId = 1006,
  buffId_annadizzy = 100201,
  buffId_annadizzy_cha = 100202,
  buffId_muma = 3010,
  tier = 1,
  fronttime = 13,
  audioIdStart = 100204,
  audioIdMovie = 100205,
  audioIdEnd = 100206,
  selectId = 9,
  select_range = 10,
  centerPosX = 3,
  centerPosY = 2
}

function bs_100203:ctor()
end

function bs_100203:InitSkill(isMidwaySkill)
end

function bs_100203:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.select_range)
  if targetList.Count <= 0 then
    return
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(self.config.centerPosX, self.config.centerPosY)
  LuaSkillCtrl:CallEffect(effectTarget, self.config.effectId_start, self, nil, nil, self.config.effect_speed)
  for i = 0, targetList.Count - 1 do
    local time = targetList[i].targetRole.x * 2
    LuaSkillCtrl:StartTimer(nil, time, function()
      if LuaSkillCtrl:CheckReletionWithRoleBelong(self.caster, targetList[i].targetRole, eBelongReletionType.Enemy) then
        local Skin_ID = LuaSkillCtrl:GetCasterSkinId(self.caster)
        if Skin_ID == 300203 or Skin_ID == 300208 or Skin_ID == 300210 then
          LuaSkillCtrl:CallBuffLifeEvent(self, targetList[i].targetRole, self.config.buffId_annadizzy, self.config.tier, self.arglist[1], BindCallback(self, self.OnBuffLifeEvent, targetList[i].targetRole))
        else
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_annadizzy, self.config.tier, self.arglist[1], false)
        end
      end
    end, nil)
    LuaSkillCtrl:StartTimer(nil, time + self.arglist[1], function()
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.caster.recordTable.cockBuffId, self.arglist[2], nil, false)
    end)
  end
  if self.startEffect ~= nil then
    self.startEffect:Die()
    self.startEffect = nil
  end
end

function bs_100203:OnBuffLifeEvent(role, lifeType, arg)
  if lifeType == eBuffLifeEvent.NewAdd then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(0.1, 0.9, 0.1), 0.1)
  elseif lifeType == eBuffLifeEvent.Remove then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(1, 1, 1), 0.1)
  end
end

function bs_100203:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, self.config.fronttime, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_start)
end

function bs_100203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_100203:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100203:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100203:LuaDispose()
  base.LuaDispose(self)
  self.startEffect = nil
end

return bs_100203
