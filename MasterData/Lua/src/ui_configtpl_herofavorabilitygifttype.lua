local this = class("heroFavorabilityGiftType")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTabKey()
  local res = {}
  for key, value in pairs(self.data) do
    table.insert(res, value.commonTab)
  end
  table.sort(res)
  return res
end

return this
