local gs_24 = class("gs_24", LuaGridBase)
gs_24.config = {buff285 = 285}

function gs_24:__InitGridInternal(cEffectGrid, x, y)
  LuaGridBase.__InitGridInternal(self, cEffectGrid, x, y)
  LuaSkillCtrl:MakeUpSceneData()
  if LuaSkillCtrl.sceneDummyExist then
    LuaSkillCtrl:ChangeSceneMap(x, y)
  end
end

function gs_24:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff285, 1, nil, true)
end

function gs_24:OnGridBattleEnd(role)
  LuaGridBase.OnGridBattleEnd(self, role)
  self:RecoverGridMap()
end

function gs_24:RecoverGridMap()
  if LuaSkillCtrl.sceneDummyExist then
    LuaSkillCtrl:RecoverSceneMap(self.x, self.y)
  end
end

return gs_24
