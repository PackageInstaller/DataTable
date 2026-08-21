_class("UISerialAutoFightStyleHelper", Object)
UISerialAutoFightStyleHelper = UISerialAutoFightStyleHelper

function UISerialAutoFightStyleHelper.GetStyleInfo(name, key)
  if string.isnullorempty(name) or string.isnullorempty(key) then
    return
  end
  local style = {}
  local dark = {
    bg_di01 = {
      rawImageName = "fight_saodang_di02"
    },
    bg_di04 = {
      rawImageName = "fight_saodang_di06"
    },
    bg_di05 = {
      rawImageName = "fight_saodang_di07"
    },
    line01 = {
      atlasName = "UIAutoFightSweep.spriteatlas",
      spriteName = "fight_saodang_line02"
    },
    line03 = {
      atlasName = "UIAutoFightSweep.spriteatlas",
      spriteName = "fight_saodang_line04"
    },
    kuang01 = {
      atlasName = "UIAutoFightSweep.spriteatlas",
      spriteName = "fight_saodang_kuang02"
    },
    kuang03 = {
      atlasName = "UIAutoFightSweep.spriteatlas",
      spriteName = "fight_saodang_kuang04"
    },
    di08 = {
      atlasName = "UIAutoFightSweep.spriteatlas",
      spriteName = "fight_saodang_di09"
    },
    titleColor = {color = "#FFFFFF"},
    optionTitleColorOff = {color = "#F4F4F4"},
    optionTitleColorOn = {color = "#F4F4F4"},
    optionColor = {color = "#F4F4F4"},
    optionColor2 = {color = "#3E3D3D"},
    optionTabBtnOff1 = {},
    optionTabBtnOn1 = {},
    optionTabBtnOff2 = {},
    optionTabBtnOn2 = {},
    optionFightBtnBg = {},
    optionFightBtnImg = {}
  }
  style.dark = dark
  local season = UISeasonHelper.GetCurSeasonAutoFightStyle()
  style.season = season
  local styleInfo = style[name] and style[name][key]
  if styleInfo == nil then
    Log.exception("UISerialAutoFightStyleHelper.GetStyle(", name, ", ", key, ") return nil")
  end
  return styleInfo
end

function UISerialAutoFightStyleHelper.FitStyle_RichText(styleName, styleKey, text)
  local info = UISerialAutoFightStyleHelper.GetStyleInfo(styleName, styleKey)
  return UIStyleHelper.FitStyle_RichText(info, text)
end

function UISerialAutoFightStyleHelper.FitStyle_Widget(styleName, styleKey, uiView, widgetName)
  local info = UISerialAutoFightStyleHelper.GetStyleInfo(styleName, styleKey)
  return UIStyleHelper.FitStyle_Widget(info, uiView, widgetName)
end
