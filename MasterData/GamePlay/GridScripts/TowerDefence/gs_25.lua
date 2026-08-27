local gs_25 = class("gs_25", LuaGridBase)
gs_25.config = {buff285 = 285}

function gs_25:__InitGridInternal(cEffectGrid, x, y)
  LuaGridBase.__InitGridInternal(self, cEffectGrid, x, y)
  LuaSkillCtrl:MakeUpSceneData()
  if LuaSkillCtrl.sceneDummyExist then
    LuaSkillCtrl:ChangeSceneMap(x, y)
  end
end

function gs_25:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff285, 1, nil, true)
end

function gs_25:OnGridBattleEnd(role)
  LuaGridBase.OnGridBattleEnd(self, role)
  self:RecoverGridMap()
end

function gs_25:RecoverGridMap()
  if LuaSkillCtrl.sceneDummyExist then
    LuaSkillCtrl:RecoverSceneMap(self.x, self.y)
  end
end

return gs_25
