local sixtower_shanxian = class("sixtower_shanxian", LuaSkillBase)
local base = LuaSkillBase
sixtower_shanxian.config = {
  effectId1 = 12203,
  effectId2 = 12204,
  buffId = 2241
}

function sixtower_shanxian:ctor()
end

function sixtower_shanxian:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local callback = BindCallback(self, self.TimerCallBack)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], callback, nil, -1, self.arglist[1] - 1)
end

function sixtower_shanxian:TimerCallBack()
  local times = self.arglist[2]
  local p_list = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  local select_list = {}
  local target_list = {}
  for i = 0, p_list.Count - 1 do
    target_list[#target_list + 1] = p_list[i]
  end
  for i = 0, times - 1 do
    if #target_list < 1 then
      break
    end
    local rand = LuaSkillCtrl:CallRange(1, #target_list)
    local target_x, target_y = target_list[rand].x, target_list[rand].y
    table.remove(target_list, rand)
    local grid_taget = LuaSkillCtrl:GetTargetWithGrid(target_x, target_y)
    select_list[#select_list + 1] = grid_taget
  end
  for _, target_grid in ipairs(select_list) do
    LuaSkillCtrl:CallEffect(target_grid, self.config.effectId1, self, self.SkillFunc)
  end
end

function sixtower_shanxian:SkillFunc(effect, eventId, target)
  if eventId ~= eBattleEffectEvent.Die then
    return
  end
  local role = LuaSkillCtrl:GetRoleWithPos(target.x, target.y)
  if role ~= nil then
    self:CastEffect(role)
  else
    self:RandomCast()
  end
end

function sixtower_shanxian:RandomCast()
  local e_lsit = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if e_lsit.Count < 1 then
    return
  end
  local rand = LuaSkillCtrl:CallRange(0, e_lsit.Count - 1)
  local role = e_lsit[rand]
  self:CastEffect(role)
end

function sixtower_shanxian:CastEffect(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[5], true, nil, true)
end

function sixtower_shanxian:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return sixtower_shanxian
