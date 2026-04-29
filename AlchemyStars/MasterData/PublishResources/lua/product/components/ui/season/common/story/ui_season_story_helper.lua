_class("SeasonStoryHelper", Object)
SeasonStoryHelper = SeasonStoryHelper

function SeasonStoryHelper.GetContentInfo(str, splitChar)
  splitChar = splitChar or "|"
  local plainStr = string.gsub(str, "<size=%d*>", "")
  plainStr = string.gsub(plainStr, "</size>", "")
  plainStr = string.gsub(plainStr, "<color=#%x*>", "")
  plainStr = string.gsub(plainStr, "</color>", "")
  plainStr = string.gsub(plainStr, "<sprite.*/>", "a")
  local finalStr = string.gsub(str, splitChar, "")
  local breakIndexList = {}
  local charCount = 0
  for uchar in string.gmatch(plainStr, "[%z\001-\127Â-ô][€-¿]*") do
    if uchar == splitChar then
      breakIndexList[#breakIndexList + 1] = charCount
    else
      charCount = charCount + 1
    end
  end
  breakIndexList[#breakIndexList + 1] = charCount
  local hideTextAnim = SeasonStoryHelper.CheckHideTextAnim(str)
  return finalStr, breakIndexList, charCount, hideTextAnim
end

function SeasonStoryHelper.CheckHideTextAnim(str)
  local hide = HelperProxy:GetInstance():CheckTextIncludeImg(str)
  return hide
end

function SeasonStoryHelper.SubStringUTF8(str, startIndex, endIndex)
  if startIndex < 0 then
    startIndex = SeasonStoryHelper.SubStringGetTotalIndex(str) + startIndex + 1
  end
  if endIndex ~= nil and endIndex < 0 then
    endIndex = SeasonStoryHelper.SubStringGetTotalIndex(str) + endIndex + 1
  end
  if endIndex == nil then
    return string.sub(str, SeasonStoryHelper.SubStringGetTrueIndex(str, startIndex))
  else
    return string.sub(str, SeasonStoryHelper.SubStringGetTrueIndex(str, startIndex), SeasonStoryHelper.SubStringGetTrueIndex(str, endIndex + 1) - 1)
  end
end

function SeasonStoryHelper.SubStringGetTotalIndex(str)
  local curIndex = 0
  local i = 1
  local lastCount = 1
  repeat
    lastCount = SeasonStoryHelper.SubStringGetByteCount(str, i)
    i = i + lastCount
    curIndex = curIndex + 1
  until lastCount == 0
  return curIndex - 1
end

function SeasonStoryHelper.SubStringGetTrueIndex(str, index)
  local curIndex = 0
  local i = 1
  local lastCount = 1
  repeat
    lastCount = SeasonStoryHelper.SubStringGetByteCount(str, i)
    i = i + lastCount
    curIndex = curIndex + 1
  until index <= curIndex
  return i - lastCount
end

function SeasonStoryHelper.SubStringGetByteCount(str, index)
  local curByte = string.byte(str, index)
  local byteCount = 1
  if curByte == nil then
    byteCount = 0
  elseif 0 < curByte and curByte <= 127 then
    byteCount = 1
  elseif 192 <= curByte and curByte <= 223 then
    byteCount = 2
  elseif 224 <= curByte and curByte <= 239 then
    byteCount = 3
  elseif 240 <= curByte and curByte <= 247 then
    byteCount = 4
  end
  return byteCount
end

function SeasonStoryHelper.DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end
