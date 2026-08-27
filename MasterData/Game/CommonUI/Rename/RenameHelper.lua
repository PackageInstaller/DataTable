local RenameHelper = {}

function RenameHelper:GetNameLength(targetString)
  if targetString == nil then
    return nil
  end
  if string.IsNullOrEmpty(targetString) then
    return 0
  end
  local length = 0
  local iByte = 1
  while true do
    local currentByte = string.byte(targetString, iByte)
    local byteCount = 1
    local lengthCount = 2
    if 239 < currentByte then
      byteCount = 4
    elseif 223 < currentByte then
      byteCount = 3
    elseif 127 < currentByte then
      byteCount = 2
    else
      byteCount = 1
      lengthCount = 1
    end
    iByte = iByte + byteCount
    length = length + lengthCount
    if iByte > #targetString then
      break
    end
  end
  return length
end

function RenameHelper:ClampNameInLength(targetString, lengthLimit)
  if targetString == nil or type(lengthLimit) ~= "number" then
    return nil
  end
  if string.IsNullOrEmpty(targetString) or lengthLimit == 0 then
    return ""
  end
  local length = 0
  local iByte = 1
  while true do
    local currentByte = string.byte(targetString, iByte)
    local byteCount = 1
    local lengthCount = 2
    if 239 < currentByte then
      byteCount = 4
    elseif 223 < currentByte then
      byteCount = 3
    elseif 127 < currentByte then
      byteCount = 2
    else
      byteCount = 1
      lengthCount = 1
    end
    length = length + lengthCount
    if lengthLimit < length then
      return string.sub(targetString, 1, iByte - 1)
    end
    iByte = iByte + byteCount
    if iByte > #targetString then
      break
    end
  end
  return length
end

return RenameHelper
