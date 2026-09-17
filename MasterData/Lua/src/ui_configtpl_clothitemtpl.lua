local this = class("clothItemTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  if self.data[id] == nil then
    if id == nil then
      errorf("clothItemTpl  is Null 配置不符合传值为空")
    else
      errorf("clothItemTpl  is Null 配置不符合 id" .. id)
    end
  end
  return self.data[id]
end

function this:getName(tpl)
  if L_PlayerStore:getSex() == L_Const.sexType.male then
    return tpl.nameM
  else
    return tpl.nameF
  end
end

function this:getIcon(tpl)
  if L_PlayerStore:getSex() == L_Const.sexType.male then
    return tpl.iconM
  else
    return tpl.iconF
  end
end

function this:getQuality(tpl)
  return tpl.rarity
end

function this:getDesc(tpl)
  if L_PlayerStore:getSex() == L_Const.sexType.male then
    return L_Config:provider(tpl.funcDescM)
  else
    return L_Config:provider(tpl.funcDescF)
  end
end

function this:getSpecialDesc(tpl)
  if L_PlayerStore:getSex() == L_Const.sexType.male then
    return L_Config:provider(tpl.DescM)
  else
    return L_Config:provider(tpl.DescF)
  end
end

function this:getWayList(tpl)
  local res = {}
  if tpl.way then
    for i, v in ipairs(tpl.way) do
      res[i] = {
        id = v,
        desc = L_Config:provider(tpl.wayDesc[i])
      }
    end
  end
  return res
end

return this
