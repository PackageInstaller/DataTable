local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_108 = class("sc_108", StorySkillBase)
local base = StorySkillBase
sc_108.config = {
  buff = 2305,
  trans_list = {
    {20041, 50010},
    {20088, 50011},
    {20089, 50012},
    {20091, 50013},
    {20084, 50014},
    {1001042, 50015}
  }
}
sc_108.config = setmetatable(sc_108.config, {
  __index = base.config
})

function sc_108:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_108:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local cb = BindCallback(self, self.CroodeRole)
  self.timer = LuaSkillCtrl:StartTimer(nil, 90, cb, nil, -1, 75)
  local pasika = self:GetRole(1071)
  if pasika ~= nil then
    LuaSkillCtrl:CallBuff(self, pasika, 2305, 10)
  end
end

function sc_108:CroodeRole()
  local eList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if eList == nil or eList.Count < 1 then
    return
  end
  local role
  for i = 0, eList.Count - 1 do
    local tempId = eList[i].roleDataId
    local transId = self:GetSummnonerId(tempId)
    if transId ~= nil then
      role = eList[i]
      break
    end
  end
  if role == nil then
    return
  end
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
  LuaSkillCtrl:CallEffect(role, 12048, self)
  LuaSkillCtrl:CallBuff(self, role, 66, 1, nil)
  LuaSkillCtrl:CallBuff(self, role, 88, 1, nil)
  local x, y = role.x, role.y
  local attr_table = {
    maxHp = role.maxHp * 100 // 1000,
    pow = role.pow * 100 // 1000,
    skill_intensity = role.skill_intensity * 100 // 1000,
    speed = role.speed,
    def = role.def * 100 // 1000,
    crit = role.crit,
    critDamage = role.critDamage,
    sunder = role.sunder,
    magic_res = role.magic_res,
    magic_pen = role.magic_pen
  }
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    LuaSkillCtrl:DispelBuff(role, 66, 0)
    LuaSkillCtrl:DispelBuff(role, 88, 0)
    LuaSkillCtrl:CallEffect(grid_target, 12118, self)
    self:DisableUndead(role)
    LuaSkillCtrl:RemoveLife(role.maxHp + 1, self, role, true)
  end)
  LuaSkillCtrl:StartTimer(nil, 34, function()
    local transId2 = self:GetSummnonerId(role.roleDataId)
    self:CastSummoner(x, y, transId2, eBattleRoleBelong.player, attr_table)
  end)
end

function sc_108:GetSummnonerId(Id)
  for _, v in ipairs(self.config.trans_list) do
    if v[1] == Id then
      return v[2]
    end
  end
  return nil
end

function sc_108:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_108
