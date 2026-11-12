local HandbookDataBase = require("GameCore.Data.DataClass.HandBookData.HandbookDataBase")
local HandbookDiscData = class("HandbookDiscData", HandbookDataBase)

function HandbookDiscData:Init()
  self.nDiscId = self:GetId()
end

function HandbookDiscData:GetDiscId()
  return self.nDiscId
end

function HandbookDiscData:GetDiscCfgData()
  local discCfgData = ConfigTable.GetData("Disc", self.nDiscId)
  if nil == discCfgData then
    printError("Get disc data fail!!! id = " .. self.nDiscId)
    return
  end
  return discCfgData
end

function HandbookDiscData:GetDiscBg()
  local cfgData = self:GetDiscCfgData()
  if nil ~= cfgData then
    return cfgData.DiscBg .. AllEnum.DiscBgSurfix.Image
  end
end

function HandbookDiscData:GetDiscItemCfgData()
  local itemCfgData = ConfigTable.GetData_Item(self.nDiscId)
  if nil == itemCfgData then
    printError("Get item.disc data fail!!! id = " .. self.nDiscId)
    return
  end
  return itemCfgData
end

function HandbookDiscData:GetRarity()
  local discItemCfgData = self:GetDiscItemCfgData()
  if nil ~= discItemCfgData then
    return discItemCfgData.Rarity
  end
end

function HandbookDiscData:GetCreateTime()
  local createTime = 0
  local mapDiscData = PlayerData.Disc:GetDiscById(self.nDiscId)
  if nil ~= mapDiscData then
    createTime = mapDiscData.nCreateTime or 0
  end
  return createTime
end

function HandbookDiscData:CheckDiscL2D()
  return PlayerData.Disc:CheckDiscL2D(self.nDiscId)
end

return HandbookDiscData
