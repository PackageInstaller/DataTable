local this = class("heroHandBookPreviewModeController", require("ui.pages.heroPanel.controller.heroPreviewModeControllerBase"))

function this:checkModuleIsShowCustom(moduleType)
  local heroId = self:getSelectConfigId()
  if moduleType == L_Const.heroModuleType.Data then
    return L_HeroStore:getHasHero(heroId)
  end
  return nil
end

function this:checkShowUnLook()
  return true
end

return this
