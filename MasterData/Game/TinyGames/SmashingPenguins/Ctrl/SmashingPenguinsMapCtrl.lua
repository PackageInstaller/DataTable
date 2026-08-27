local SmashingPenguinsCtrlBase = require("Game.TinyGames.SmashingPenguins.Ctrl.SmashingPenguinsCtrlBase")
local SmashingPenguinsMapCtrl = class("SmashingPenguinsMapCtrl", SmashingPenguinsCtrlBase)
local base = SmashingPenguinsCtrlBase
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local CharacterAnimState = SmashingPenguinsEnum.eCharacterAnimState
local GameState = SmashingPenguinsEnum.eGameState

function SmashingPenguinsMapCtrl:OnInit()
  self.forwardMapBlock = nil
  self.currentMapBlock = nil
  self.backMapBlock = nil
end

function SmashingPenguinsMapCtrl:OnGamePrepare()
  self.forwardMapBlock = nil
  self.currentMapBlock = nil
  self.backMapBlock = nil
end

function SmashingPenguinsMapCtrl:GetStartMapBlock(characterEntity, controller)
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) or IsNull(characterEntity) then
    return
  end
  local mapBlock = self:GetNewMapBlock(characterEntity, controller, 1)
  local pos = Vector3.zero
  pos.x = SmashingPenguinsConfig.MaxXPos - mapBlock.transform.rect.width * 0.5
  mapBlock:InitSmashingPenguinsMapBlock(characterEntity, controller, pos)
  self.currentMapBlock = mapBlock
  local cannon = mapBlock.cannonEntities[1]
  characterEntity.transform.position = cannon.transform.position
  characterEntity:SetSmashingPenguinsAnimState(CharacterAnimState.Cry)
  local characterLocalPosition = mainUI.mapBlockHolder.transform:InverseTransformPoint(characterEntity.transform.position)
  self.prefLocalPosition = characterLocalPosition
end

function SmashingPenguinsMapCtrl:GetNewMapBlock(characterEntity, controller, newBlockIndex)
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  local index = newBlockIndex
  if index < 0 then
    return nil
  end
  if index <= #mainUI.startMapBlocks then
    local mapBlock = mainUI.startMapBlocks[index]
    if mapBlock.active then
      mapBlock:HideMapBlock()
    end
    mapBlock.index = newBlockIndex
    return mapBlock
  else
    index = (index - #mainUI.startMapBlocks) % #mainUI.loopMapBlocks
    if index == 0 then
      index = #mainUI.loopMapBlocks
    end
    local mapBlock = mainUI.loopMapBlocks[index]
    if mapBlock.active then
      mapBlock:HideMapBlock()
    end
    mapBlock.index = newBlockIndex
    return mapBlock
  end
end

function SmashingPenguinsMapCtrl:UpdateSmashingPenguinsMapBlocks(characterEntity, controller)
  if controller:GetSmashingPenguinsGameState() ~= GameState.Fly then
    return
  end
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) or IsNull(characterEntity) then
    return
  end
  local characterLocalPosition = mainUI.mapBlockHolder.transform:InverseTransformPoint(characterEntity.transform.position)
  if characterLocalPosition.x >= SmashingPenguinsConfig.MaxXPos then
    return
  end
  local isNeed, dirMultiple = self:CheckIsNeedNewMapBlock(characterLocalPosition)
  if isNeed then
    local mapBlock = self:GetNewMapBlock(characterEntity, controller, self.currentMapBlock.index - dirMultiple)
    if mapBlock == nil then
      return
    end
    local pos = self.currentMapBlock.transform.localPosition
    pos.x = pos.x + dirMultiple * self.currentMapBlock.transform.rect.width * 0.5 + dirMultiple * mapBlock.transform.rect.width * 0.5
    mapBlock:InitSmashingPenguinsMapBlock(characterEntity, controller, pos)
    if dirMultiple < 0 then
      self.forwardMapBlock = mapBlock
    else
      self.backMapBlock = mapBlock
    end
  end
  local isNeedReset, dirResetMultiple = self:CheckIsNeedResetMapBlocks(characterLocalPosition)
  if isNeedReset then
    self:ResetMapBlocks(dirResetMultiple)
  end
  self.prefLocalPosition = characterLocalPosition
end

function SmashingPenguinsMapCtrl:CheckIsNeedNewMapBlock(characterLocalPosition)
  local mapBlockLocalPos = self.currentMapBlock.transform.localPosition
  if (mapBlockLocalPos.x - characterLocalPosition.x) * (mapBlockLocalPos.x - self.prefLocalPosition.x) <= 0 then
    local moveDirX = characterLocalPosition.x - self.prefLocalPosition.x
    if moveDirX < 0 then
      return true, -1
    else
      return self.currentMapBlock.index > 1, 1
    end
  end
  return false, 0
end

function SmashingPenguinsMapCtrl:CheckIsNeedResetMapBlocks(characterLocalPosition)
  local mapBlockLocalPosXL = self.currentMapBlock.transform.localPosition.x - self.currentMapBlock.transform.rect.width * 0.5
  local mapBlockLocalPosXR = self.currentMapBlock.transform.localPosition.x + self.currentMapBlock.transform.rect.width * 0.5
  local moveDirX = characterLocalPosition.x - self.prefLocalPosition.x
  if (mapBlockLocalPosXL - characterLocalPosition.x) * (mapBlockLocalPosXL - self.prefLocalPosition.x) <= 0 and moveDirX < 0 then
    return true, -1
  end
  if (mapBlockLocalPosXR - characterLocalPosition.x) * (mapBlockLocalPosXR - self.prefLocalPosition.x) <= 0 and 0 < moveDirX then
    return self.currentMapBlock.index > 1, 1
  end
  return false, 0
end

function SmashingPenguinsMapCtrl:ResetMapBlocks(dirMultiple)
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  if 0 < dirMultiple then
    if not IsNull(self.forwardMapBlock) then
      self.forwardMapBlock:HideMapBlock()
    end
    self.forwardMapBlock = self.currentMapBlock
    self.currentMapBlock = self.backMapBlock
    self.backMapBlock = nil
  else
    if not IsNull(self.backMapBlock) then
      self.backMapBlock:HideMapBlock()
    end
    self.backMapBlock = self.currentMapBlock
    self.currentMapBlock = self.forwardMapBlock
    self.forwardMapBlock = nil
  end
end

return SmashingPenguinsMapCtrl
