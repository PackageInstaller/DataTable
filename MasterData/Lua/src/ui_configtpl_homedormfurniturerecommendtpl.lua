local this = class("homeDormFurnitureRecommendTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPic(tpl)
  return tpl.pic
end

function this:getCurRecommendData()
  local res = {}
  for key, value in pairs(self.data) do
    local startTime = L_TimeUtil.getDateTimeStamp(value.startTime)
    local endTime = L_TimeUtil.getDateTimeStamp(value.endTime)
    if startTime <= L_TimeUtil.getServerTime() and endTime >= L_TimeUtil.getServerTime() then
      table.insert(res, {
        key = value.id,
        showId = value.showId
      })
    end
  end
  table.sort(res, function(a, b)
    return a.showId < b.showId
  end)
  return res
end

return this
