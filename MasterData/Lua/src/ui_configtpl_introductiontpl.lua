local this = class("introductionTpl")

function this:init(config)
  self.data = config
  self.groups = {}
  for _, v in pairs(config) do
    if not self.groups[v.groupId] then
      self.groups[v.groupId] = {}
    end
    table.insert(self.groups[v.groupId], v)
  end
  for _, v in pairs(self.groups) do
    table.sort(v, function(a, b)
      return a.page < b.page
    end)
  end
end

function this:getPages(groupId)
  return self.groups[groupId] or {}
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPicture(tpl)
  local picture = L_Config:getPathByHash(tpl.picture)
  return picture
end

function this:getContent(tpl)
  return L_Config:provider(tpl.content)
end

function this:getPage(tpl)
  return tpl.page
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:getId(tpl)
  return tpl.id
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getIsPictureIntroduction(tpl)
  return tpl.isPictureIntroduction
end

return this
