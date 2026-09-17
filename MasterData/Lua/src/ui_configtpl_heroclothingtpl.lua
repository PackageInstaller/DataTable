local this = class("heroClothingTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  if self.data[id] == nil then
    if id == nil then
      errorf("heroClothingTpl  is Null 配置不符合传值为空")
    else
      errorf("heroClothingTpl  is Null 配置不符合 id" .. id)
    end
  end
  return self.data[id]
end

function this:getUnitId(tpl)
  if tpl == nil then
    return
  end
  return tpl.unitId
end

function this:getAvatarTexture(tpl, index)
  if tpl == nil then
    return
  end
  return tpl.avatarTexture[index]
end

function this:getHero(tpl)
  return tpl.hero
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getQuality(tpl)
  return tpl.rarity
end

function this:getDesc(tpl)
  return tpl.funcDesc
end

function this:getSpecialDesc(tpl)
  return tpl.Desc
end

function this:getWayList(tpl)
  local res = {}
  if tpl.way then
    for i, v in ipairs(tpl.way) do
      res[i] = {
        id = v,
        desc = tpl.wayDesc and tpl.wayDesc[i]
      }
    end
  end
  return res
end

return this
