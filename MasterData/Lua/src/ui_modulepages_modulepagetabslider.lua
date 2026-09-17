local this = class("modulePageTabSlider", G_UIModuleBase)

function this.bind()
  return {localPos_tab = nil}
end

function this.methods()
  return {}
end

function this:setPageIndex(curIndex, totalPageCount)
  local posX = self.bindComponents.rect_modulePageTabSlider.sizeDelta.x * ((curIndex - 0.5) / totalPageCount)
  self.bind.localPos_tab = L_Vector3.new(posX, 0, 0)
end

return this
