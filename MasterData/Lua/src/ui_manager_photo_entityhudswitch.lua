local this = class("entityHudSwitch")
local C_ETransmitType = CS.Lens.Gameplay.Modules.BigWorld.ETransmitType

function this:ctor()
  self.hudShowFlag = {}
  self.entityType2WorldNode = {
    [C_EEntityType.Monster] = L_Const.WorldNode.ENEMY,
    [C_EEntityType.NPC] = L_Const.WorldNode.NPC
  }
  self.onEntityBirthHandle = handler(self, self.OnEntityBirth)
  C_EntityManager.entityBirthHandler:Add(self.onEntityBirthHandle)
end

function this:destroy()
  C_EntityManager.entityBirthHandler:Remove(self.onEntityBirthHandle)
  for k, v in pairs(self.hudShowFlag) do
    if not v then
      self:SetHudShow(k, true)
    end
  end
end

function this:GetHudShow(entityType)
  return self.hudShowFlag[entityType] == nil or self.hudShowFlag[entityType]
end

function this:SetHudShow(worldNode, show)
  if self:GetHudShow(worldNode) == show then
    return
  end
  self.hudShowFlag[worldNode] = show
  if worldNode == L_Const.WorldNode.ENEMY then
    C_EntityManager.ShowOrHideAllMonsterHud(show)
  else
    local nodeTrans = AzurWorldInstance:GetWorldNode(worldNode)
    local childCount = nodeTrans.childCount
    for i = 0, childCount - 1 do
      local child = nodeTrans:GetChild(i)
      local modelCtrl = child.gameObject:GetComponent(typeof(C_ModelControl))
      if modelCtrl then
        local entityId = modelCtrl.EntityId
        local entity = C_EntityManager.GetEntity(entityId)
        if entity then
          local transmitType = show and C_ETransmitType.ShowAllHud or C_ETransmitType.HideAllHud
          entity:Transmit(transmitType, nil)
        end
      end
    end
  end
end

function this:OnEntityBirth(entity)
  local node = self.entityType2WorldNode[entity.data.entityType]
  if node and self.hudShowFlag[node] == false then
    entity:Transmit(CS.Lens.Gameplay.Modules.BigWorld.ETransmitType.HideHud, nil)
  end
end

return this
