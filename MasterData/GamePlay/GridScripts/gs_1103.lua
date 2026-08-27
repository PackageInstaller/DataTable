local gs_1103 = class("gs_1103", LuaGridBase)
local base = LuaGridBase
gs_1103.config = {
  BuffId = 110001,
  BuffDistance = 2,
  effectId = 12020
}

function gs_1103:ctor()
end

function gs_1103:OnGridBattleStart(role)
  self.gridEffect = nil
end

function gs_1103:OnGridEnterRole(role)
  if self.buffAdd ~= nil then
    self.buffAdd:Stop()
    self.buffAdd = nil
  end
  if role ~= nil then
    local gridTarget = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
    self.gridEffect = LuaSkillCtrl:CallEffect(gridTarget, self.config.effectId, self)
    local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(role, 2, true)
    if targetlist ~= nil then
      local collisionTrigger = BindCallback(self, self.AddBuffToRole, role)
      self.buffAdd = LuaSkillCtrl:StartTimer(nil, 10, collisionTrigger, -1, 10)
    end
  end
end

function gs_1103:AddBuffToRole(role)
  local AddBuffList = LuaSkillCtrl:FindAllRolesWithinRange(role, 2, true)
  if AddBuffList ~= nil and AddBuffList.Count > 0 then
    for i = 0, AddBuffList.Count - 1 do
      local buffTier = AddBuffList[i]:GetBuffTier(self.config.BuffId)
      if buffTier == 0 then
        LuaSkillCtrl:CallBuff(self, AddBuffList[i], self.config.BuffId, 1, 10)
      end
    end
  end
end

function gs_1103:OnGridExitRole(role)
  if self.buffAdd ~= nil then
    self.buffAdd:Stop()
    self.buffAdd = nil
  end
  if self.gridEffect ~= nil then
    self.gridEffect:Die()
    self.gridEffect = nil
  end
  local RemoveBuffList = LuaSkillCtrl:FindAllRolesWithinRange(role, self.config.BuffDistance, true)
  if RemoveBuffList ~= nil and RemoveBuffList.Count > 0 then
    for i = 0, RemoveBuffList.Count - 1 do
      local buffTier = RemoveBuffList[i]:GetBuffTier(self.config.BuffId)
      if 0 < buffTier then
        LuaSkillCtrl:DispelBuff(RemoveBuffList[i].targetrole, self.config.BuffId, buffTier)
      end
    end
  end
end

function gs_1103:OnGridBeCorvered(role)
  if self.buffAdd ~= nil then
    self.buffAdd:Stop()
    self.buffAdd = nil
  end
end

function gs_1103:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_1103:LuaDispose()
  if self.buffAdd ~= nil then
    self.buffAdd:Stop()
    self.buffAdd = nil
  end
  base.LuaDispose(self)
end

function gs_1103:OnGridRoleDead(role)
  if self.buffAdd ~= nil then
    self.buffAdd:Stop()
    self.buffAdd = nil
  end
end

return gs_1103
