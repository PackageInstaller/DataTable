local this = class("conditionNode_1", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
end

function this:setMainControl(en)
  if L_PlayerStore:getPlayerStatus() == L_Const.WorldMapPlayerStatusType.WMPST_MOUNT then
    local entityType = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).data.entityType
    if entityType == C_EEntityType.Pet then
      self:refresh()
    end
  else
    self:refresh()
  end
end

function this:onDestroy()
  this.super.onDestroy(self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
end

function this.checkFunc(codData)
  return AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false) ~= nil
end

return this
