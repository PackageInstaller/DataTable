local this = class("librarySeriesTpl")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIcon(tpl)
  return L_Config:getPathByHash(tpl.icon)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.intro)
end

function this:getIdBySubId(subId)
  for k, v in pairs(self.data) do
    for k2, v2 in pairs(v.subId) do
      if v2 == subId then
        return v
      end
    end
  end
  return nil
end

function this:getSubId(id)
  return self.data[id].subId
end

return this
