_class("UIStyleHelper", Object)
UIStyleHelper = UIStyleHelper

function UIStyleHelper._Type2Func(styleInfo)
  local assembler_map = {
    GameObject = UIStyleHelper.FitStyle_Widget_Active,
    Image = UIStyleHelper.FitStyle_Widget_Image,
    RawImage = UIStyleHelper.FitStyle_Widget_RawImage,
    LocalizationText = UIStyleHelper.FitStyle_Widget_LocalizationText
  }
  local tb_out = {}
  local type = styleInfo and styleInfo.type or ""
  local assembler = assembler_map[type]
  if assembler ~= nil then
    table.insert(tb_out, assembler)
  else
    tb_out = table.values(assembler_map)
  end
  return tb_out
end

function UIStyleHelper._Log(styleInfo, uiView, widgetName)
  local uiName = uiView and uiView:GetName() or ""
  local name = styleInfo and styleInfo.name or ""
  local type = styleInfo and styleInfo.type or ""
  local fmt = "uiView=%s, widgetName=%s, name=%s, type=%s"
  local str = string.format(fmt, uiName, widgetName, name, type)
  Log.debug("UIStyleHelper.FitStyle_Widget() ", str)
end

function UIStyleHelper.FitStyle_Widget(styleInfo, uiView, widgetName)
  if styleInfo then
    UIStyleHelper._Log(styleInfo, uiView, widgetName)
    local funcs = UIStyleHelper._Type2Func(styleInfo)
    for _, func in pairs(funcs) do
      func(styleInfo, uiView, widgetName)
    end
  end
end

function UIStyleHelper.FitStyle_Widget_Active(styleInfo, uiView, widgetName)
  local active = styleInfo.active
  if active ~= nil then
    uiView:GetGameObject(widgetName):SetActive(active)
  end
end

function UIStyleHelper.FitStyle_Widget_Image(styleInfo, uiView, widgetName)
  local atlasName, spriteName = styleInfo.atlasName, styleInfo.spriteName
  if atlasName and spriteName then
    UIWidgetHelper.SetImageSprite(uiView, widgetName, atlasName, spriteName)
  end
  local imageColor = styleInfo.imageColor
  if imageColor then
    local obj = uiView:GetUIComponent("Image", widgetName)
    local c = UIStyleHelper._GetColorByHex(imageColor)
    obj.color = c
  end
end

function UIStyleHelper.FitStyle_Widget_RawImage(styleInfo, uiView, widgetName)
  local rawImageName = styleInfo.rawImageName
  if rawImageName then
    UIWidgetHelper.SetRawImage(uiView, widgetName, rawImageName)
  end
end

function UIStyleHelper.FitStyle_Widget_LocalizationText(styleInfo, uiView, widgetName)
  local color = styleInfo.color
  if color then
    local obj = uiView:GetUIComponent("UILocalizationText", widgetName)
    local c = UIStyleHelper._GetColorByHex(color)
    obj.color = c
  end
  local textColor = styleInfo.textColor
  local textStrId = styleInfo.textStrId
  if textColor or textStrId then
    local obj = uiView:GetUIComponent("UILocalizationText", widgetName)
    if textColor then
      local c = UIStyleHelper._GetColorByHex(textColor)
      obj.color = c
    end
    if textStrId then
      obj:SetText(StringTable.Get(textStrId))
    end
  end
  local outlineColor = styleInfo.outlineColor
  if outlineColor then
    local obj = uiView:GetUIComponent("H3D.UGUI.CircleOutline", widgetName)
    if obj == nil then
      obj = uiView:GetUIComponent("Outline", widgetName)
    end
    if obj ~= nil then
      local c = UIStyleHelper._GetColorByHex(outlineColor)
      obj.effectColor = c
    end
  end
end

function UIStyleHelper._GetColorByHex(text)
  local tb = {}
  for i = 2, 8, 2 do
    local j = i + 1
    local str = j <= #text and string.sub(text, i, j) or "FF"
    local num = tonumber(string.format("%d", "0x" .. str))
    table.insert(tb, num)
  end
  local r, g, b, a = tb[1], tb[2], tb[3], tb[4]
  return Color(r / 255, g / 255, b / 255, a / 255)
end

function UIStyleHelper.FitStyle_RichText(styleInfo, text)
  if styleInfo then
    return UIActivityHelper.GetRichText(styleInfo, text)
  end
  return text
end

function UIStyleHelper.ChangeColorStr_Style(styleColor, colorNormal, colorRed, change, a, b)
  local normal = styleColor or colorNormal
  local red = colorRed
  local c = change and red or normal
  local str = UIActivityHelper.GetColorText(c, a, normal, "/" .. b)
  return str
end
