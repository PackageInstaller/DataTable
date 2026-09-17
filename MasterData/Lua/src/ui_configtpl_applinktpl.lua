local this = class("appLinkTpl")

function this:init(config)
  self.data = config
end

function this:getAllTpl(isPhoto)
  local result = {}
  for k, v in pairs(self.data) do
    if isPhoto then
      if v.appSort ~= 0 then
        table.insert(result, v)
      end
    elseif v.appSortMoive ~= 0 then
      table.insert(result, v)
    end
  end
  return result
end

function this:tryGetTplById(id, isPhoto)
  if id == nil then
    errorf("appLinkTpl is Null 配置不符合传值为空")
  end
  local c = self.data[id]
  if c then
    if isPhoto then
      if c.appSort == 0 then
        return nil
      end
    elseif c.appSortMoive == 0 then
      return nil
    end
  end
  return c
end

return this
