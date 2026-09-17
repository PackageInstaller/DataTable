local this = class("modColor")

function this:ctor()
  self.colorId = -1
  self.colorName = ""
  self.colorValue = ""
end

function this:copyData()
  local copyData = require(L_R.store .. "mod.data.modColor").new()
  copyData.colorId = self.colorId
  copyData.colorName = self.colorName
  copyData.colorValue = self.colorValue
  return copyData
end

return this
