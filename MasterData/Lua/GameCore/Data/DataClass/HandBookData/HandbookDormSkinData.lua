local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookDormSkinData = class("HandbookDormSkinData", HandbookDataBase)

function HandbookDormSkinData:Init()
  self.nSkinId = self.tbCfgData.SkinId
  self.nCharId = self.tbCfgData.CharId
end

function HandbookDormSkinData:GetSkinId()
  return self.nSkinId
end

function HandbookDormSkinData:GetSkinCfgData()
  local cfgData = ConfigTable.GetData("DormRoleSkin", self.nSkinId)
  if nil == cfgData then
    printError("Get skin cfg fail!!! charId = " .. self.nSkinId)
    return
  end
  return cfgData
end

function HandbookDormSkinData:GetCharId()
  return self.nCharId
end

function HandbookDormSkinData:GetCharCfgData()
  local cfgData = ConfigTable.GetData_Character(self.nCharId)
  if nil == cfgData then
    printError("Get char cfg fail!!! charId = " .. self.nCharId)
    return
  end
  return cfgData
end

return HandbookDormSkinData
