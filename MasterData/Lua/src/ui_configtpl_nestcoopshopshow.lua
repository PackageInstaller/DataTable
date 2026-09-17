local this = class("nestcoopShopShow")

function this:init(config)
  self.data = config
end

function this:getData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTplByShopGroupId(id)
  for k, v in pairs(self.data) do
    if v and v.shopGroupId == id then
      return v
    end
  end
  return self.data[1]
end

function this:getActorId(tpl)
  return tpl.heroid
end

function this:getTimelineActor(tpl)
  return tpl.uiperform
end

function this:getShopBackGround(tpl)
  return tpl.shopUibackground
end

function this:getVoiceDict(tpl)
  return tpl.shopvoice
end

function this:getVoiveById(tpl, id)
  return tpl.shopvoice[id]
end

function this:getShopTimelinePos(tpl)
  return tpl.shopTimelinePos
end

function this:getShopTimelineRot(tpl)
  return tpl.shopTimelineRot
end

function this:getShopCharacterPos(tpl)
  return tpl.shopCharacterPos
end

function this:getShopCharacterRot(tpl)
  return tpl.shopCharacterRot
end

return this
