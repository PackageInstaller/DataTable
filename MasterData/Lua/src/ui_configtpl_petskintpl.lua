local this = class("petSkinTpl")
local _mountTpl = L_GameTpl:getMountTpl()

function this:init(config)
  self.data = config
  local countIconographyshow = 0
  for k, v in pairs(self.data) do
    if v.iconographyshow == 1 then
      countIconographyshow = countIconographyshow + 1
    end
  end
  self.totalIconographyshow = countIconographyshow
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAllTpl()
  return self.data
end

function this:getName(tpl)
  return tpl.name
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getKiboId(tpl)
  return tpl.kiboId
end

function this:getDesc(tpl)
  return tpl.itemDesc
end

function this:getSpecialDesc(tpl)
  return tpl.desc
end

function this:getWayList(tpl)
  local res = {}
  if not tpl then
    return res
  end
  return res
end

function this:getUnitSuffix(tpl)
  return tpl.unitSuffix
end

function this:getAnimatorSuffix(tpl)
  return tpl.animatorSuffix
end

return this
