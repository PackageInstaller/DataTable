PetObtainHelper = {}

function PetObtainHelper.Init()
end

local function chsize(char)
  if not char then
    return 0
  elseif 240 < char then
    return 4
  elseif 225 < char then
    return 3
  elseif 192 < char then
    return 2
  else
    return 1
  end
end

function PetObtainHelper.InsertChar(str, char)
  if str == nil then
    return
  end
  local text = ""
  local currentIndex = 1
  while currentIndex <= #str do
    local byte = string.byte(str, currentIndex)
    local len = chsize(byte)
    local s = string.sub(str, currentIndex, currentIndex + len - 1)
    text = text .. s .. char
    currentIndex = currentIndex + len
  end
  return text
end
