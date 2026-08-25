local ColorUtils = System.NewClass("ColorUtils")

function ColorUtils.ParseHtmlStringToUnityColor(htmlString, alpha)
  if not htmlString then
    return
  end
  local list = string.split(htmlString, "#")
  if #list > 1 then
    local idx = 1
    local colorInfo = list[2]
    local temp = {}
    while idx < string.len(colorInfo) do
      local colorNum = tonumber(string.sub(colorInfo, idx, idx + 1), 16)
      table.insert(temp, colorNum)
      idx = idx + 2
    end
    if 3 == #temp then
      do return CS.UnityEngine.Color, temp[1] / 255, temp[2] / 255, temp[3] / 255 end
      return CS.UnityEngine.Color, temp[1] / 255, temp[2] / 255, temp[3] / 255, alpha and alpha or 1.0
    else
      do return CS.UnityEngine.Color, temp[1] / 255, temp[2] / 255, temp[3] / 255 end
      return CS.UnityEngine.Color, temp[1] / 255, temp[2] / 255, temp[3] / 255, temp[4] / 255
    end
  end
end

function ColorUtils.ColorToColor32(color)
  local function toByte01(v)
    v = math.max(0, math.min(1, v or 0))
    
    do return math.floor end
    return math.floor, v * 255 + 0.5, math.min(1, v or 0)
  end
  
  do return CS.UnityEngine.Color32, toByte01(color.r), toByte01(color.g), toByte01(color.b), toByte01(color.a) end
  return CS.UnityEngine.Color32, toByte01(color.r), toByte01(color.g), toByte01(color.b), toByte01(color.a)
end

function ColorUtils.GetColorConfig(tid)
  if not tid then
    return
  end
  return DT.ColorConfig[tid]
end

function ColorUtils.GetColorHexCode(tid, colorType)
  local config = ColorUtils.GetColorConfig(tid)
  if not config then
    return
  end
  colorType = colorType or CommonDefine.ColorType.Normal
  return config[colorType]
end

function ColorUtils.SetRankTitleColor(binder, iconPath, ...)
  if not iconPath or "" == iconPath then
    return
  end
  local quality = string.match(iconPath, "Quality_Tab_(%w+)")
  local colorStr = quality and CommonDefine.RankTitleColor[quality]
  if not colorStr then
    return
  end
  local texts = {
    ...
  }
  for i = 1, #texts do
    if texts[i] then
      binder:SetTextColorByHtml(texts[i], colorStr)
    end
  end
end

return ColorUtils
