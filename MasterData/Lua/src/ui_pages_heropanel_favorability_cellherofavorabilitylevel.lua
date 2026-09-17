local module = class("cellHeroFavorabilityLevel", G_UIModuleBase)

function module.bind()
  return {
    normalActive = true,
    selectedActive = false,
    selectedLevel = "0",
    normalLevel = "0",
    rightLineActive = true
  }
end

function module.methods()
  return {
    onClick_selectLevel = function(self)
      self:emit("selectLevel", self.bind.level)
    end
  }
end

function module:refresh()
  self.bind.selectedActive = self.bind.selected
  self.bind.normalActive = not self.bind.selected
  self.bind.selectedLevel = tostring(self.bind.level)
  self.bind.normalLevel = tostring(self.bind.level)
  self.bind.rightLineActive = not self.bind.hideRight
end

return module
