local this = class("timelineDynamicBindInfo")

function this:ctor()
  self.actor = nil
  self.onFixGetAniname = nil
end

function this:setGameObject(gameObject)
  self.actor = gameObject
end

function this:getGameObject()
  return self.actor
end

function this:dispose()
  self.actor = nil
end

function this:getAniname(aniName)
  local tmpName
  if self.onFixGetAniname then
    tmpName = self.onFixGetAniname(aniName)
  end
  if tmpName ~= nil then
    return tmpName
  end
  return aniName
end

return this
