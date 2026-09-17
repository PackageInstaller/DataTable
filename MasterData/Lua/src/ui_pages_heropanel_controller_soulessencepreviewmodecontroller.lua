local this = class("soulEssencePreviewModeController", require("ui.pages.heroPanel.controller.heroPreviewModeControllerBase"))
local previewShowModuleTypes = {
  [L_Const.heroModuleType.Property] = false,
  [L_Const.heroModuleType.Skill] = false,
  [L_Const.heroModuleType.Star] = false,
  [L_Const.heroModuleType.SoulEssence] = true,
  [L_Const.heroModuleType.Accessory] = false
}

function this:checkCanShowDownBG()
  return false
end

function this:getShowModuleTypes()
  return previewShowModuleTypes
end

function this:checkShowPreviewLevel(moduleType)
  if moduleType == L_Const.heroModuleType.SoulEssence then
    return true
  end
  return false
end

function this:getHomeName()
  return L_WordsTpl:getValue("residual_code_soulessencepreviewmodecontroller_01")
end

function this:showTimeline()
  return false
end

return this
