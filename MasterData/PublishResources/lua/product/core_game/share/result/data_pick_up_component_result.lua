_class("DataPickUpComponentResult", Object)
DataPickUpComponentResult = DataPickUpComponentResult

function DataPickUpComponentResult:Constructor(entityID, pickUpGridList, directionPickupData, reflectDir, pickUpExtraParam)
  self.entityID = entityID
  self.pickUpGridList = pickUpGridList
  self.directionPickupData = directionPickupData
  self.reflectDir = reflectDir
  self.pickUpExtraParam = pickUpExtraParam
end

function DataPickUpComponentResult:GetEntityID()
  return self.entityID
end

function DataPickUpComponentResult:GetPickUpGridList()
  return self.pickUpGridList
end

function DataPickUpComponentResult:GetDirectionPickupData()
  return self.directionPickupData
end

function DataPickUpComponentResult:GetReflectDir()
  return self.reflectDir
end

function DataPickUpComponentResult:GetPickUpExtraParam()
  return self.pickUpExtraParam
end
