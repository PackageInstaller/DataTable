local this = class("petEggTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getEggTime(tpl)
  return tpl.eggTime
end

function this:getElement(tpl)
  return tpl.element
end

function this:getEggImgIcon(tpl)
  if string.isEmpty(tpl.eggImg[1]) then
    return "UI/Atlas/Item/tex_icon_petegg_default.png"
  end
  return tpl.eggImg[1]
end

function this:getEggSpineModel(tpl)
  return tpl.PetEggSpinePrefab
end

function this:getEggImgLong(tpl)
  if string.isEmpty(tpl.eggImg[2]) then
    return "UI/Texture/Drop/tex_icon_petegg_default.png"
  end
  return tpl.eggImg[2]
end

function this:getEggImgDrop(tpl)
  if string.isEmpty(tpl.eggImg[3]) then
    return "UI/Texture/Drop/tex_icon_petegg_default.png"
  end
  return tpl.eggImg[3]
end

function this:getIncubateGroup(tpl)
  return tpl.incubateGroup
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getSpecialDesc(tpl)
  return L_Config:provider(tpl.specialDesc)
end

function this:getUnitId(tpl)
  return tpl.unitId
end

function this:getEggScale(tpl)
  return tpl.eggScale / 10000
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getTag(tpl)
  local res = {}
  for i, v in ipairs(tpl.tag) do
    table.insert(res, L_Config:provider(v))
  end
  return res
end

function this:getUseType(tpl)
  return tpl.useType
end

function this:getProduct(tpl)
  return tpl.product
end

return this
