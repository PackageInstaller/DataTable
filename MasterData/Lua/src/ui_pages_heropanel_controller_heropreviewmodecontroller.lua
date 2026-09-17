local this = class("heroPreviewModeController", require("ui.pages.heroPanel.controller.heroPreviewModeControllerBase"))
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()

function this:getHomeName()
  local tpl_uiTopBar = uiTopBarTpl:getTplByPageName("pageHero")
  local name = uiTopBarTpl:getBackTxt(tpl_uiTopBar, 3)
  local resource = uiTopBarTpl:getResourceBar(tpl_uiTopBar, 3)
  local tb = L_LuaToCSharpUtil.parseLuaCfgList(resource)
  C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList(tb)
  return name
end

function this:setCurrentProperty(b)
  self.currentProperty = b
end

function this:showCurrentProperty()
  return self.currentProperty
end

function this:checkShowFavorabilityInfo()
  return false
end

return this
