local dialogTachieView = class("dialogTachieView", G_UIModuleBase)

function dialogTachieView.bind()
  return {
    tachiePath = "",
    tachieColor = C_Color(1, 1, 1, 1),
    faceName = ""
  }
end

function dialogTachieView.methods()
  return {}
end

function dialogTachieView:resetAll()
  self.bind.tachiePath = ""
end

return dialogTachieView
