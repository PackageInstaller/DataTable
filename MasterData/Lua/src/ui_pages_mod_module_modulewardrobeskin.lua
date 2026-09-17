local module = class("moduleWardrobeSkin", G_UIModuleBase)

function module.bind()
  return {
    colorList = {
      moduleName = "pages/MOD/Module/moduleWardrobeSkinSelect"
    }
  }
end

function module.methods()
  return {}
end

function module:refreshColorListUI()
  self.bind.colorList:clear()
  self.bind.colorList:insert(1, {
    colorText = L_WordsTpl:getValue("ui_surface_07"),
    colorIndex = 1
  })
  if self.isBind then
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.Content)
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.ColorButtonList)
  end
end

function module:refreshUI()
  self:refreshColorListUI()
end

function module:open()
  L_ModStore:listenCallFunc(L_ModStore.event.refreshUI, self.refreshUI, self)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.Content)
end

function module:close()
  L_ModStore:unListenCallFunc(L_ModStore.event.refreshUI, self.refreshUI)
end

function module:setModuleData(wardrobeType)
  self.wardrobeType = wardrobeType
  self:refreshUI()
end

return module
