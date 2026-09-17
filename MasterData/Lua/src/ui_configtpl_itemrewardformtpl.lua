local this = class("itemRewardFormTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getType(tpl)
  return tpl.type
end

function this:getSubtype(tpl)
  return tpl.subtype
end

function this:getForm(tpl)
  return tpl.form
end

function this:getId(tpl)
  return tpl.id
end

function this:build()
  if self.isBuild then
    return
  end
  if not self.itemTypeDict then
    self.itemTypeDict = {}
  end
  self.cacheDict = {}
  self.isBuild = true
  for i, v in pairs(self.data) do
    local itemType = v.type
    local subtypeList = v.subtype
    local form = v.form
    local t = self.itemTypeDict[itemType]
    if not t then
      t = {}
      self.itemTypeDict[itemType] = t
    end
    if subtypeList == nil or #subtypeList == 0 then
      t.form = form
    else
      local subtypeDict = t.subtypeDict
      if not subtypeDict then
        subtypeDict = {}
        t.subtypeDict = subtypeDict
      end
      for j, k in pairs(subtypeList) do
        subtypeDict[k] = form
      end
    end
  end
end

function this:getFormType(itemType, subtype)
  self:build()
  local t = self.itemTypeDict[itemType]
  if not t then
    return L_Const.rewardShowType.full
  end
  local subtypeDict = t.subtypeDict
  if not subtypeDict or not subtype then
    return t.form
  end
  local form = subtypeDict[subtype]
  if not form then
    return t.form
  end
  return form
end

return this
