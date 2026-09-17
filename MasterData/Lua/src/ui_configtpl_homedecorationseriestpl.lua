local this = class("homeDecorationSeriesTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getId(tpl)
  return tpl.id
end

function this:getBannerPc(tpl)
  return tpl.bannerPC
end

function this:getBannerPortable(tpl)
  return tpl.bannerPortable
end

function this:getName(tpl)
  return tpl.name
end

return this
