local this = class("heroDetailModeComtroller", require("ui.pages.heroPanel.controller.heroOwnModeControllerBase"))

function this:checkCanChangeHero()
  return false
end

return this
