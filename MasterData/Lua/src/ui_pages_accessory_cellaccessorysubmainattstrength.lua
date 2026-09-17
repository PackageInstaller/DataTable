local this = class("cellAccessorySubMainAttStrength", G_UIModuleBase)
local elementTypeTpl = L_GameTpl:getElementTypeTpl()
local elementIconType = {
  main = 1,
  sub = 2,
  single = 3
}

function this.bind()
  return {
    img_mainAtt = nil,
    txt_mainAttName = "",
    txt_value = "",
    txt_newValue = "",
    go_newValue = false,
    go_elementIcon = false,
    img_elementIcon = "",
    go_arrow = true
  }
end

function this:open()
  self.bind.img_mainAtt = self.bind.mainAttIcon
  self.bind.txt_mainAttName = self.bind.mainAttName
  self.bind.go_elementIcon = self.bind.showEle
  if self.bind.showEle then
    local eleTpl = elementTypeTpl:getTplById(self.bind.elementType)
    self.bind.img_elementIcon = elementTypeTpl:getElementIcon(eleTpl, elementIconType.single)
  end
end

function this:changeValue()
  self.bind.txt_value = "+" .. tostring(self.bind.mainValue)
  self.bind.go_arrow = not self.bind.isMax
  self.bind.go_newValue = not self.bind.isMax
  self.bind.txt_newValue = not self.bind.isMax and "+" .. tostring(self.bind.mainNewValue) or ""
end

function this:onPlayAnim()
  self.bindComponents.anim:Play("anim_AStrength_pageAccessoryStrength_Att")
end

return this
