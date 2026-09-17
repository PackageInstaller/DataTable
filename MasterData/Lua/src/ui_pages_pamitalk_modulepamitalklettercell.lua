local module = class("modulePamiTalkLetterCell", G_UIModuleBase)

function module.bind()
  return {
    letteTitleText = "",
    redDotActive = false,
    selectedActive = false,
    normalActive = true
  }
end

function module.methods()
  return {
    onClick_letter = function(self)
      self:emit("onClick_letterList", self.bind.letterId)
    end
  }
end

function module:refresh()
  local pamiLetterListTpl = L_GameTpl:getPamiLetterListTpl()
  self.bind.letteTitleText = L_Config:provider(pamiLetterListTpl:getTitle(self.bind.letterTpl))
  L_ReddotManager:registerReddot(self.bindComponents.letterDot, string.format(L_ReddotManager.DotDef.PamiTalkLetter, self.bind.letterId))
end

return module
