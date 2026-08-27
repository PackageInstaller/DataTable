local bs_20262 = class("bs_20262", LuaSkillBase)
local base = LuaSkillBase
bs_20262.config = {
  AvgList = {
    "23summer_s05_4",
    "23summer_s05_4",
    "23summer_s05_4",
    "23summer_s05_4",
    "23summer_s05_4",
    "23summer_s05_4",
    "23summer_s05_4"
  }
}

function bs_20262:ctor()
end

function bs_20262:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local herolist = LuaSkillCtrl:GetAllFriendRoles()
  self.hero = herolist[0]
  self.nextAVG = 1
end

function bs_20262:ControlRole()
  local grid = LuaSkillCtrl:GetGridWithPos(5, 2)
  LuaSkillCtrl:MoveRoleToTarget(self, grid, self.hero, true, self.PlayAVG)
  LuaSkillCtrl:ShowCameraEffectFunction(3)
end

function bs_20262:PlayAVG(cb)
  if self.nextAVG > #self.config.AvgList then
    return
  end
  LuaSkillCtrl:StartAvgWithPauseGame(self.config.AvgList[self.nextAVG], nil, cb)
  self.nextAVG = self.nextAVG + 1
end

function bs_20262:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20262
