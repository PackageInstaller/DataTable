local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookDormFurnitureData = class("HandbookDormFurnitureData", HandbookDataBase)

function HandbookDormFurnitureData:Init()
  self.nFurnitureId = self.tbCfgData.SkinId
end

function HandbookDormFurnitureData:GetFurnitureId()
  return self.nFurnitureId
end

function HandbookDormFurnitureData:GetFurnitureCfgData()
  local cfgData = ConfigTable.GetData("DormFurniture", self.nFurnitureId)
  if nil == cfgData then
    printError("Get Furniture cfg fail!!! Furniture = " .. self.nFurnitureId)
    return
  end
  return cfgData
end

return HandbookDormFurnitureData
