local this = class("tipsGroupTpl")

function this:init(config)
  self.data = config
  self.groupDic = {}
  for _, v in pairs(config) do
    if self.groupDic[v.groupId] == nil then
      self.groupDic[v.groupId] = {}
    end
    table.insert(self.groupDic[v.groupId], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplListByGroupId(gId, useRandom)
  if useRandom == nil then
    useRandom = true
  end
  if table.isEmpty(self.groupDic) then
    return
  end
  local groupData = self.groupDic[gId]
  if table.isEmpty(groupData) then
    return
  end
  if not useRandom then
    return groupData
  end
  local ret = {}
  for k, v in pairs(groupData) do
    ret[k] = v
  end
  table.shuffle(ret)
  return ret
end

function this:getBgType(tpl)
  return tpl.bgType
end

function this:getTips(tpl)
  return L_Config:provider(tpl.tips)
end

function this:getBg(tpl)
  return tpl.bg
end

function this:getMaterial(tpl)
  return tpl.material
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getId(tpl)
  return tpl.id
end

return this
