local this = class("smeltReturnTpl")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getHomeConindumpItemDic()
  local res = {}
  for k, v in pairs(self.data) do
    if v.homeCoindumpNumber ~= nil and v.homeCoindumpNumber ~= string.empty and #v.homeCoindumpNumber ~= 0 then
      if res[v.type] == nil then
        res[v.type] = {}
      end
      table.insert(res[v.type], v.itemId)
    end
  end
  return res
end

return this
