local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    starGiftDic = {}
  }
end

function this:getAllStarGift()
  return self.data.starGiftDic
end

function this:getStarGiftItem(uid, isCreate)
  local entity = self.data.starGiftDic[uid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "starGift.starGiftItem").new()
    self.data.starGiftDic[uid] = entity
  end
  return entity
end

function this:getStarGiftNum(uid)
  local entity = self.data.starGiftDic[uid]
  if entity == nil then
    return 0
  end
  return entity.starGiftNum
end

return this
