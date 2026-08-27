local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_17326 = class("bs_17326", QiuSkillBase)
local base = QiuSkillBase
bs_17326.config = {is_reducable = false}
bs_17326.config = setmetatable(bs_17326.config, {
  __index = base.config
})

function bs_17326:ctor()
end

function bs_17326:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local timerCallback = BindCallback(self, self.eventFunc)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], timerCallback, nil, -1)
end

function bs_17326:eventFunc()
  local role = self:findMaxMagic()
  self:MakeRoleCollectQiu(role)
end

function bs_17326:findMaxMagic()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local max_target = list[0]
  for i = 0, list.Count - 1 do
    if max_target.skill_intensity < list[i].skill_intensity then
      max_target = list[i]
    end
  end
  return max_target
end

function bs_17326:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17326
