local SmashingPenguinsMapBlock = class("SmashingPenguinsMapBlock", UIBaseNode)
local base = UIBaseNode

function SmashingPenguinsMapBlock:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.cannonEntities = {}
  self.bombEntities = {}
  self.windEntities = {}
  self.upWallEntities = {}
  self.midWallEntities = {}
  self.downWallEntities = {}
end

function SmashingPenguinsMapBlock:InitSmashingPenguinsMapBlock(characterEntity, controller, pos)
  self.transform.localPosition = pos
  self.characterEntity = characterEntity
  self.mainController = controller
  self:ShowMapBlock(characterEntity, controller)
end

function SmashingPenguinsMapBlock:ShowMapBlock(characterEntity, controller)
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  for iCannonIndex = 1, #self.ui.array_cannons do
    local cannon = mainUI.cannonPool:GetOne()
    local fakePos = self.ui.array_cannons[iCannonIndex].position
    cannon:InitEntityData(characterEntity, controller)
    cannon.transform.position = fakePos
    cannon:LookAtDir(Vector3.left)
    self.cannonEntities[iCannonIndex] = cannon
  end
  for iBombIndex = 1, #self.ui.array_bombs do
    local bomb = mainUI.bombPool:GetOne()
    local fakePos = self.ui.array_bombs[iBombIndex].position
    bomb:InitEntityData(characterEntity, controller)
    bomb.transform.position = fakePos
    self.bombEntities[iBombIndex] = bomb
  end
  for iWindIndex = 1, #self.ui.array_winds do
    local wind = mainUI.windPool:GetOne()
    local fakePos = self.ui.array_winds[iWindIndex].position
    wind:InitEntityData(characterEntity, controller)
    wind.transform.position = fakePos
    self.windEntities[iWindIndex] = wind
  end
  for iUpWallIndex = 1, #self.ui.array_upWall do
    local upWall = mainUI.upWallPool:GetOne()
    local fakePos = self.ui.array_upWall[iUpWallIndex].position
    upWall:InitEntityData(characterEntity, controller)
    upWall.transform.position = fakePos
    self.upWallEntities[iUpWallIndex] = upWall
  end
  for iMidWallIndex = 1, #self.ui.array_midWall do
    local midWall = mainUI.midWallPool:GetOne()
    local fakePos = self.ui.array_midWall[iMidWallIndex].position
    midWall:InitEntityData(characterEntity, controller)
    midWall.transform.position = fakePos
    self.midWallEntities[iMidWallIndex] = midWall
  end
  for iDownWallIndex = 1, #self.ui.array_downWall do
    local downWall = mainUI.downWallPool:GetOne()
    local fakePos = self.ui.array_downWall[iDownWallIndex].position
    downWall:InitEntityData(characterEntity, controller)
    downWall.transform.position = fakePos
    self.downWallEntities[iDownWallIndex] = downWall
  end
  base.Show(self)
end

function SmashingPenguinsMapBlock:HideMapBlock()
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  for iCannonIndex = 1, #self.cannonEntities do
    mainUI.cannonPool:HideOne(self.cannonEntities[iCannonIndex])
  end
  for iBombIndex = 1, #self.ui.array_bombs do
    mainUI.bombPool:HideOne(self.bombEntities[iBombIndex])
  end
  for iWindIndex = 1, #self.ui.array_winds do
    mainUI.windPool:HideOne(self.windEntities[iWindIndex])
  end
  for iUpWallIndex = 1, #self.ui.array_upWall do
    mainUI.upWallPool:HideOne(self.upWallEntities[iUpWallIndex])
  end
  for iMidWallIndex = 1, #self.ui.array_midWall do
    mainUI.midWallPool:HideOne(self.midWallEntities[iMidWallIndex])
  end
  for iDownWallIndex = 1, #self.ui.array_downWall do
    mainUI.downWallPool:HideOne(self.downWallEntities[iDownWallIndex])
  end
  base.Hide(self)
end

return SmashingPenguinsMapBlock
