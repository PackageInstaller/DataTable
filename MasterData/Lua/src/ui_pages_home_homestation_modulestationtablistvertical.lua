local module = class("moduleStationTabListVertical", G_UIModuleBase)

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/home/homeStation/cellStationTabItemVertical"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      if self._callback then
        local petGuid, laborType, laborId
        for i = 1, #self.bind.list_tab do
          laborId = self.bind.list_tab:getValue(i, "laborId")
          if laborId == id then
            petGuid = self.bind.list_tab:getValue(i, "guid")
            laborType = self.bind.list_tab:getValue(i, "laborType")
            laborId = self.bind.list_tab:getValue(i, "laborId")
            self._callback(laborId, petGuid, laborType)
          end
        end
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function module:setData(idList, autoData, callback, selectId, redKeys)
  self.bind.list_tab:clear()
  self._callback = nil
  if #idList <= 0 then
    return
  end
  local dataList = {}
  self.petGuid = nil
  self.laborId = nil
  self.laborType = nil
  for i, id in ipairs(idList) do
    if id == 1001 then
      self.petGuid = autoData.plantPetGuid
      self.laborId = L_HomeConst.homeLaborType.PLANT
      self.laborType = L_HomeConst.HomeLaborId.GENG_ZUO
    elseif id == 1002 then
      self.petGuid = autoData.waterPetGuid
      self.laborId = L_HomeConst.homeLaborType.WATER
      self.laborType = L_HomeConst.HomeLaborId.JIAO_SHUI
    elseif id == 1003 then
      self.petGuid = autoData.harvestPetGuid
      self.laborId = L_HomeConst.homeLaborType.HARVEST
      self.laborType = L_HomeConst.HomeLaborId.GENG_ZUO
    end
    table.insert(dataList, {
      id = id,
      guid = self.petGuid,
      laborId = self.laborId,
      laborType = self.laborType,
      isLast = i == #idList,
      redKey = redKeys and redKeys[i]
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  self.bind.selectTab = idList[selectId or 1]
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

function module:open()
end

return module
