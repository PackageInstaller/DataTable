local WarChessAreaData = class("WarChessAreaData")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WCAreaEntity = require("Game.WarChess.Entity.WCAreaEntity")

function WarChessAreaData:ctor(areaPos, areaData)
  local areaUID = areaData.id
  local rotation = areaData.rotation
  local x, y = WarChessHelper.Coordination2Pos(areaPos)
  self.areaUID = areaUID
  self.logicCoordination = areaPos
  self.sizeX = areaData.sizeX
  self.sizeY = areaData.sizeY
  self.logicPos = Vector2.New(x, y)
  self.towards = rotation
  self.areaEntity = nil
end

function WarChessAreaData:GetWCAreaId()
  return self.areaUID
end

function WarChessAreaData:LoadWCArea(isReuse)
  self.areaEntity = WCAreaEntity.New(self)
  return self.areaEntity:WCAreaEntityPreLoad(isReuse)
end

function WarChessAreaData:GetWCAreaLogicToward()
  return self.towards
end

function WarChessAreaData:GetWCAreaLogicPosXY()
  return self.logicPos.x, self.logicPos.y
end

function WarChessAreaData:GetWCAreaSizeXY()
  return self.sizeX, self.sizeY
end

function WarChessAreaData:GetWCAreaId()
  return self.areaUID
end

function WarChessAreaData:GetWCAreaResName()
  return tostring(self.areaUID)
end

function WarChessAreaData:GenWcAreaGridPosDic(destDic)
  for x = self.logicPos.x, self.logicPos.x + self.sizeX do
    for y = self.logicPos.y, self.logicPos.y + self.sizeY do
      local gridPos = WarChessHelper.PosXy2Coordination(x, y)
      destDic[gridPos] = self.logicCoordination
    end
  end
end

function WarChessAreaData:GetWCAreaGo(x, y)
  return self.areaEntity:WCAreaEnityGetGoByXY(x, y)
end

function WarChessAreaData:GetWCAreaGroundGo(x, y)
  return self.areaEntity:WCAreaEnityGetGroundGoByXY(x, y)
end

return WarChessAreaData
