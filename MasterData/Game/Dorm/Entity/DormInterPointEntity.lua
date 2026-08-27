local DormInterPointEntity = class("DormInterPointEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local cs_RenderManager = CS.RenderManager

function DormInterPointEntity:ctor()
end

function DormInterPointEntity:InitInterPointEntity(interPoint, interStartPos, interEndPos, fntEntity)
  self.__interPoint = interPoint
  self:RefreshInterPointEntity(interStartPos, interEndPos, fntEntity)
end

function DormInterPointEntity:RefreshInterPointEntity(interStartPos, interEndPos, fntEntity)
  self.__interStartPos = interStartPos
  self.__interEndPos = interEndPos
  self.__fntEntity = fntEntity
end

function DormInterPointEntity:GetInterPointData()
  return self.__interPoint
end

function DormInterPointEntity:GetPointStartPos()
  return self.__interStartPos
end

function DormInterPointEntity:GetPointEndPos()
  return self.__interEndPos
end

function DormInterPointEntity:GetPointFromFntEntity()
  return self.__fntEntity
end

function DormInterPointEntity:ClearPointEntityData()
  self.__fntEntity = nil
end

function DormInterPointEntity:AddPointFntHighlight()
  DormUtil.AddHighLightTarget(self.__fntEntity.gameObject)
end

function DormInterPointEntity:RemovePointFntHighlight()
  DormUtil.RemovePointFntHighlight(self.__fntEntity.gameObject)
end

function DormInterPointEntity:GetSqrDistanceToScreenTouch(screenPos)
  local pos = UIManager:GetMainCamera():WorldToScreenPoint(self.__interEndPos) / cs_RenderManager.SceneCameraResolutionRatio
  return Vector2.Distance(pos, screenPos)
end

return DormInterPointEntity
