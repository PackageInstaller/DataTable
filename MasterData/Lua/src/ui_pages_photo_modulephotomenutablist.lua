local this = class("modulePhotoMenuTabList", G_UIModuleBase)

function this.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/photo/cell/cellPhotoMenuTab"
    }
  }
end

function this.methods()
  return {
    list_tab = {
      onTabId = function(self, id)
        if self._callback then
          L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Switch")
          self._callback(id)
        end
        Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
      end
    }
  }
end

function this:setData(idList, callback, selectId, redKeys)
  self.bind.list_tab:clear()
  self._callback = nil
  if #idList <= 0 then
    return
  end
  local dataList = {}
  for i, id in ipairs(idList) do
    table.insert(dataList, {
      id = id,
      isLast = i == #idList,
      redKey = redKeys and redKeys[i]
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  self.bind.selectTab = idList[selectId or 1]
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function this:setSelectTabId(id)
  self.bind.selectTab = id
end

return this
