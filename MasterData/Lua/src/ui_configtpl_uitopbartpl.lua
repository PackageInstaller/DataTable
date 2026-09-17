local this = class("uiTopBarTpl")

function this:init(config)
  self.data = config
  self.pageMap = {}
  for k, v in pairs(config) do
    self.pageMap[v.viewName] = v
  end
end

function this:getTplByPageName(pageName)
  return self.pageMap[pageName]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getNavigationButton(tpl)
  return tpl.navigationButton
end

function this:getIntroductionGroupId(tpl)
  return tpl.introductionGroupId
end

function this:getBackTxt(tpl, index)
  if not index then
    return L_Config:provider(tpl.backTxt[1])
  else
    return L_Config:provider(tpl.backTxt[index])
  end
end

function this:getResourceBar(tpl, index)
  if not index then
    return tpl.resourceBar[1]
  else
    return tpl.resourceBar[index]
  end
end

function this:getViewName(tpl)
  return tpl.viewName
end

function this:getHelpButton(tpl)
  return tpl.helpButton
end

function this:getCloseButton(tpl)
  return tpl.backButton
end

return this
