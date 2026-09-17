local this = {}

function this:rsp_syncReputationInfo(data)
  if data.infos == nil then
    return
  end
  for k, v in pairs(data.infos) do
    local item = self:getDataById(v.rep_id)
    if item == nil then
      item = require(L_R.store .. "reputation.reputationItem").new()
      item.forceId = v.rep_id
      item.value = v.value
      item.level = v.level
      table.insert(self.data.forceDic, item)
    else
      item.forceId = v.rep_id
      item.value = v.value
      item.level = v.level
    end
  end
  self:call(self.event.reputationChange)
end

return this
