local module = class("modulePamiTalkTypeCell", G_UIModuleBase)

function module.bind()
  return {
    btnTitleText = "",
    redDotActive = false,
    selectedActive = false
  }
end

function module.methods()
  return {
    onClick_type = function(self)
      self:emit("onClick_talkTypeList", self.bind.typeIndex)
    end
  }
end

function module:refresh()
  local pamiLetterCategoryTpl = L_GameTpl:getPamiLetterCategoryTpl()
  self.bind.btnTitleText = L_Config:provider(pamiLetterCategoryTpl:getName(self.bind.categroyTpl))
  L_ReddotManager:registerReddot(self.bindComponents.categoryDot, string.format(L_ReddotManager.DotDef.PamiTalkCategory, self.bind.typeIndex))
end

return module
