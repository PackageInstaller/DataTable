local module = class("cellGuideDotItem", G_UIModuleBase)

function module.bind()
  return {blackActive = true, whiteActive = false}
end

function module:open(...)
end

function module:refresh()
  self.bind.blackActive = self.bind.currentIndex ~= self.bind.index
  self.bind.whiteActive = not self.bind.blackActive
end

return module
