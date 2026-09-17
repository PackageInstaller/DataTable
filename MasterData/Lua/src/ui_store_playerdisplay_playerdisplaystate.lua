local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    allItem = {},
    setHasInitSync = false
  }
end

function this:getItem(id, isCreate)
  local item = self.data.allItem[id]
  if item == nil and isCreate then
    item = require("ui.store.playerDisplay.playerDressItem").new()
    self.data.allItem[id] = item
  end
  return item
end

function this:getItemListByType(dressType)
  local list = {}
  for i, v in pairs(self.data.allItem) do
    if v.tpl and v.tpl.type == dressType then
      table.insert(list, v)
    end
  end
  return list
end

function this:fillEmptyCustom()
  for i, v in pairs(self._playerCardDressTpl.data) do
    if v.type == L_Const.playerDressType.hero and v.customize == 1 and not self:hasItem(v.id) then
      local item = self:getItem(v.id, true)
      item.id = v.id
      item.url = ""
      item.tpl = v
    end
  end
end

function this:getCurStandeeInfo()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  return baseInfo.stand_plates
end

function this:getCurbackground()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  return baseInfo.stand_plates.backboard
end

function this:getCurbase()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  return baseInfo.stand_plates.baseboard
end

function this:getcurHero()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  return baseInfo.stand_plates.role
end

function this:getcurPet()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  return baseInfo.stand_plates.pet_accessory
end

function this:getCurHead()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  if baseInfo.stand_plates.profile == nil or baseInfo.stand_plates.profile == 0 then
    return self:getDefaultHead()
  end
  return baseInfo.stand_plates.profile
end

function this:getCurHeadFrame()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  if baseInfo.stand_plates.profile_frame == nil or baseInfo.stand_plates.profile_frame == 0 then
    local _, id = self:getDefaultFrame()
    return id
  end
  return baseInfo.stand_plates.profile_frame
end

function this:clear()
  self.data.allItem = {}
  self.data.setHasInitSync = false
  self.redDotRootNode = nil
end

return this
