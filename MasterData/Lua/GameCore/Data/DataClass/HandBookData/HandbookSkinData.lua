local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookSkinData = class("HandbookSkinData", HandbookDataBase)

function HandbookSkinData:Init()
  self.nSkinId = self.tbCfgData.SkinId
  self.nCharId = self.tbCfgData.CharId
end

function HandbookSkinData:GetSkinId()
  return self.nSkinId
end

function HandbookSkinData:GetSkinCfgData()
  local cfgData = ConfigTable.GetData_CharacterSkin(self.nSkinId)
  if nil == cfgData then
    printError("Get skin cfg fail!!! charId = " .. self.nSkinId)
    return
  end
  return cfgData
end

function HandbookSkinData:GetCharId()
  return self.nCharId
end

function HandbookSkinData:GetCharCfgData()
  local cfgData = ConfigTable.GetData_Character(self.nCharId)
  if nil == cfgData then
    printError("Get char cfg fail!!! charId = " .. self.nCharId)
    return
  end
  return cfgData
end

function HandbookSkinData:CheckDefaultSkin()
  return self.tbCfgData.Cond == GameEnum.handBookCond.CharacterAcquire or self.tbCfgData.Cond == GameEnum.handBookCond.CharacterSpecific
end

function HandbookSkinData:CheckFavorCG()
  local skinData = PlayerData.CharSkin:GetSkinDataBySkinId(self.nSkinId)
  if nil ~= skinData then
    return skinData:CheckFavorCG()
  end
  return false
end

function HandbookSkinData:GetCharAffinityLevel()
  local nLevel = 0
  if self.nCharId ~= 0 then
    local mapData = PlayerData.Char:GetCharAffinityData(self.nCharId)
    if mapData ~= nil then
      nLevel = mapData.Level
    end
  end
  return nLevel
end

return HandbookSkinData
