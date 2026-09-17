local this = class("homeTechnologyTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getExpUpperLimit(tpl)
  return tpl.expUpperLimit
end

function this:getCategroy(tpl)
  return tpl.categroy
end

function this:getTechnologyName(tpl)
  return L_Config:provider(tpl.technologyName)
end

function this:getExpEfficiency(tpl)
  return tpl.expEfficiency
end

function this:getTechnologyIcon(tpl)
  return tpl.technologyIcon
end

function this:getTechnologyCurrencyId(tpl)
  return tpl.technologyCurrencyId
end

function this:getEnglish(tpl)
  return tpl.english
end

function this:getEnglish(tpl)
  return tpl.english
end

function this:getTypeBg(tpl)
  return tpl.typeBg
end

function this:getNameBgColor(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(tpl.nameBgColor)
  return color
end

function this:getLvBgColor(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(tpl.lvBgColor)
  return color
end

function this:getIconBg(tpl)
  return tpl.iconBg
end

function this:getLineColor(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(tpl.lineColor)
  return color
end

function this:getCommentTabId(tpl)
  return tpl.technologyIcon
end

function this:getTabBgColor(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(tpl.tabBgColor)
  return color
end

function this:getStudySuccessBg(tpl)
  return tpl.studySuccessBg
end

function this:getTechnologyExpBarIcon(tpl)
  return tpl.technologyExpBarIcon
end

function this:getTechnologyCurrencyPageIcon(tpl)
  return tpl.technologyCurrencyPageIcon
end

return this
