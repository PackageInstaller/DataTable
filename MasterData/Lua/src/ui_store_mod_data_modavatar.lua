local this = class("modAvatar")
local _WardrobeTpl = L_GameTpl:getWardrobeTpl()
local EAnimancerType = {World = 0, Battle = 1}
this.event = {
  CharacterUpdated = 1,
  WardrobeUpdated = 2,
  EyeLModelUpdated = 3,
  EyeRModelUpdated = 4
}

function this:ctor()
  self.sex = 2
  self.modPartData = {}
  self.modObj = nil
  self.avatar = nil
  self.height = 100
  self.skinId = 0
  self.expressionResource = "Character/Expression/Prefab/pre_common_common_face.prefab"
  self.headImgUrl = nil
  self.halfBodyUrl = nil
  self.battleHeadUrl = nil
  self.halfsHeadUrl = nil
  self.circleHeadUrl = nil
  self.paintUrl = nil
  self.isTryOn = false
end

function this:copyData()
  local copyData = require(L_R.store .. "mod.data.modAvatar").new()
  copyData.sex = self.sex
  copyData.modPartData = {}
  copyData.height = self.height
  copyData.skinId = self.skinId
  copyData.expressionResource = self.expressionResource
  copyData.headImgUrl = self.headImgUrl
  copyData.halfBodyUrl = self.halfBodyUrl
  copyData.battleHeadUrl = self.battleHeadUrl
  copyData.halfsHeadUrl = self.halfsHeadUrl
  copyData.circleHeadUrl = self.circleHeadUrl
  copyData.isTryOn = self.isTryOn
  for i, v in pairs(self.modPartData) do
    copyData.modPartData[i] = v:copyData()
  end
  return copyData
end

function this:dispose()
end

return this
