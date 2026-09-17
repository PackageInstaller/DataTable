local page = class("cellFiltrateInfoItem", G_UIModuleBase)
local tag = "page:cellFiltrateInfoItem"

function page.bind()
  return {
    name1 = "",
    name2 = "",
    pitchOn = false
  }
end

function page.methods()
  return {
    onClick = function(self)
      self.bind.pitchOn = not self.bind.pitchOn
    end
  }
end

return page
