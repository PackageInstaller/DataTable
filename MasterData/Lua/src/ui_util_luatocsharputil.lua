local util = {}

function util.parseLuaCfgList(cfgList)
  local result = {}
  for _, value in ipairs(cfgList) do
    table.insert(result, value)
  end
  return result
end

return util
