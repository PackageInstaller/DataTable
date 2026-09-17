local this = class("playerItem")

function this:ctor()
  self.playerUid = nil
  self.mark = nil
  self.time = nil
  self.isShield = false
  self.isTarShield = false
end

function this:getPlayerUid()
  return self.playerUid
end

function this:getFriendMark()
  return self.mark
end

function this:getInsertTime()
  return self.time
end

function this:getIsShield()
  if self.isShield == nil then
    self.isShield = false
  end
  return self.isShield
end

function this:getIsTarShield()
  return self.isTarShield
end

return this
