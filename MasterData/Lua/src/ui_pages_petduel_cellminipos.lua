local this = class("cellMiniPos", G_UIModuleBase)
local iconMap = {
  playerPet = 0,
  enemyPet = 1,
  player = 2,
  enemy = 3,
  playerTower = 4,
  enemyTower = 5,
  playerDefenceTower = 6,
  enemyDefenceTower = 7
}

function this.bind()
  return {selectTabId = 0}
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refresh()
  if not self.isBind then
    return
  end
  if self.bind.selectTabId == iconMap.player then
    self:refreshPlayerNodePos()
    return
  end
  if self.bind.selectTabId == iconMap.enemy then
    self:refreshEnemyNodePos()
    return
  end
  self:setPos()
end

function this:setPos()
  if not self.isBind then
    return
  end
  if not self.bindComponents or not L_CommonUtil.isValid(self.bindComponents.trans) then
    return
  end
  local l2w = self.bind.mapData:worldToLocal(self.bind.entityTans.position)
  L_Vector3.setAnchored(self.bindComponents.trans, l2w)
end

function this:refreshPlayerNodePos()
  if not self.isBind then
    return
  end
  if self.mainControl == nil then
    self.mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  end
  local mainControl = self.mainControl
  if mainControl == nil or mainControl.entity == nil then
    self:setTransActive(false)
    return
  end
  self:setTransActive(true)
  local posV3 = mainControl.entity.transform.position
  local rotV3 = mainControl.entity.transform.rotation.eulerAngles
  local pos = L_Vector3.UnityV3ToLua(posV3)
  local w2l = self.bind.mapData:worldToLocal(pos)
  L_Vector3.setAnchored(self.bindComponents.trans, w2l)
  L_Vector3.setLocalRot(self.bindComponents.playerDir, L_Vector3.getTemp(0, 0, -rotV3.y + self.bind.mapData.zRot))
end

function this:setTransActive(isActive)
  self.bindComponents.trans.gameObject:SetActive(isActive)
end

function this:refreshEnemyNodePos()
  if not self.isBind then
    return
  end
  if self.redPlayer == nil then
    self.redPlayer = C_KiboDuelSystemMgr:GetRedPlayerControllingEntity()
  end
  local redPlayer = self.redPlayer
  if redPlayer == nil then
    self:setTransActive(false)
    return
  end
  self:setTransActive(true)
  local pos = redPlayer.transform.position
  local rot = redPlayer.transform.rotation
  local w2l = self.bind.mapData:worldToLocal(pos)
  L_Vector3.setAnchored(self.bindComponents.trans, w2l)
  L_Vector3.setRot(self.bindComponents.enemyDir, L_Vector3.getTemp(0, 0, -rot.y + self.bind.mapData.zRot))
end

return this
