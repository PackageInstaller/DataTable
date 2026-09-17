local this = class("modWardrobe")

function this:ctor()
  self.avatarId = -1
  self.type = -1
  self.colorIds = {}
end

function this:copyData()
  local copyData = require(L_R.store .. "mod.data.modWardrobe").new()
  copyData.avatarId = self.avatarId
  copyData.type = self.type
  copyData.colorIds = {}
  for i, v in ipairs(self.colorIds) do
    copyData.colorIds[i] = v
  end
  return copyData
end

function this:getWardrobeName()
  C_MJLog.LogInfo("modWardrobe getWardrobeName 废弃")
end

function this:getColorNames()
end

return this
