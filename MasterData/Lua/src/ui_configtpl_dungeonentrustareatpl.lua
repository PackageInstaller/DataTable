local this = class("dungeonEntrustAreaTpl")

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

function this:getTplByAreaId(areaid)
  local key = 1
  for k, v in pairs(self.data) do
    if k > key then
      key = k
    end
    for j, i in pairs(v.areascope) do
      if i == areaid then
        return v
      end
    end
  end
  print("查找失败，返回：" .. key)
  return self.data[key]
end

function this:getTplByActorId(actorId)
  for k, v in pairs(self.data) do
    if v.uiperform == actorId then
      return v
    end
  end
end

function this:getActorId(tpl)
  return tpl.heroid
end

function this:getTimelineActor(tpl)
  return tpl.uiperform
end

function this:getTimelineBackGround(tpl)
  return tpl.uibackground
end

function this:getShopBackGround(tpl)
  return tpl.shopUibackground
end

function this:getTimelineOnEnter(tpl)
  return tpl.onrootenter
end

function this:getBanners(tpl)
  return tpl.permanententrance
end

function this:getBanner(tpl, entrustTypeId)
  return tpl.permanententrance[entrustTypeId]
end

function this:getBackGround(tpl)
  return tpl.basebackground
end

function this:getVoiceDict(tpl)
  return tpl.voice
end

function this:getVoiveById(tpl, id)
  return tpl.voice[id]
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

function this:getHeroPos(tpl)
  return tpl.heroposition
end

function this:getHeroRot(tpl)
  return tpl.herorotation
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getAreaScope(tpl)
  return tpl.areascope
end

return this
