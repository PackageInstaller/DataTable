local M = {}

function M.merge(target, source)
  if type(target) ~= "table" then
    return source
  end
  if type(source) ~= "table" then
    return target
  end
  local result = {}
  for key, value in pairs(target) do
    result[key] = value
  end
  for key, value in pairs(source) do
    if type(value) == "table" and type(result[key]) == "table" then
      result[key] = M.merge(result[key], value)
    else
      result[key] = value
    end
  end
  return result
end

return M
