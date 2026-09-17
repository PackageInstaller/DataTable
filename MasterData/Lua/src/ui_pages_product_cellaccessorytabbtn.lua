local module = class("cellAccessoryTabBtn", G_UIModuleBase)
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _TabTpl = L_GameTpl:getCommonTabTpl()

function module.bind()
  return {
    active_line = true,
    txt_tabName = "",
    img_tab = ""
  }
end

function module.methods()
  return {
    onClick = function(self)
      L_UI:open("pageProductAccessory", {
        buildingGuid = self.bind.buildGuid,
        selectTabId = self.bind.tabId
      })
    end
  }
end

function module:open()
  local tabId = self.bind.tabId
  local tpl = _TabTpl:getTplById(tabId)
  self.bind.txt_tabName = L_Lang:get(_TabTpl:getName(tpl))
  self.bind.img_tab = _TabTpl:getIconSmall(tpl)
end

return module
