local this = class("tutorialTpl")

function this:init(config)
  self.data = config
  self.initData = {}
  for i, v in pairs(self.data) do
    if self:getIsDefault(v) == true then
      table.insert(self.initData, v)
    end
  end
  table.sort(self.initData, function(a, b)
    return a.id < b.id
  end)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getGuidePicId(tpl)
  return tpl.guidePicId
end

function this:getTutorialName(tpl)
  return L_Config:provider(tpl.tutorialName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getIsDefault(tpl)
  return tpl.isDefault
end

function this:getTutorialTypeId(tpl)
  return tpl.tutorialTypeId
end

function this:getInitTutorialData()
  return self.initData
end

return this
