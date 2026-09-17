local module = class("moduleAccessoryTabBtnList", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function module.bind()
  return {
    active_bg = false,
    list_tab = {
      moduleName = "pages/product/cellAccessoryTabBtn"
    }
  }
end

function module.methods()
  return {}
end

function module:initModule(buildGuid)
  self._buildingGuid = buildGuid
  local buildingInfo = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
  local buildProductionTpl = _homeBuildingProductionTpl:getTplById(buildingInfo.build_id)
  local tabs = _homeBuildingProductionTpl:getTab(buildProductionTpl)
  if 0 < #tabs then
    self.bind.active_bg = true
  end
  local datas = {}
  for i, tabId in ipairs(tabs) do
    table.insert(datas, {
      active_line = i ~= 1,
      tabId = tabId,
      buildGuid = buildGuid
    })
  end
  self.bind.list_tab:clear()
  self.bind.list_tab:insert_array(datas)
end

return module
