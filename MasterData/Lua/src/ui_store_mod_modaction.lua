local this = {}

function this:colorString2Int(color)
  if not color or color == "" then
    return 0
  end
  local hex = color:match("^#?(.+)$")
  if not hex then
    return 0
  end
  local len = #hex
  if len == 3 then
    hex = hex:gsub(".", function(c)
      return c .. c
    end)
    len = 6
  end
  local result = tonumber(hex, 16)
  return result or 0
end

return this
