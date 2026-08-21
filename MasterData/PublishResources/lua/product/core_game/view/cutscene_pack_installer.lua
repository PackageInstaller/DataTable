_staticClass("CutscenePackInstaller")

function CutscenePackInstaller:InstallEntityComponentsLookup(weComponents)
  weComponents:MergeLookup(CutsceneComponentsRegister)
end

function CutscenePackInstaller:InstallUniqueComponentsLookup(uniqueComponents)
  uniqueComponents:MergeLookup(CutsceneUniqueComponentsRegister)
end

function CutscenePackInstaller:InstallEntityMatchers(entityMatchers, weComponents)
  entityMatchers.CutsceneMonster = Matcher:New({
    weComponents.CutsceneMonster
  }, {}, {})
  entityMatchers.CutscenePlayer = Matcher:New({
    weComponents.CutscenePlayer
  }, {}, {})
  entityMatchers.AnimatorController = Matcher:New({
    weComponents.AnimatorController
  }, {}, {})
  entityMatchers.LegacyAnimation = Matcher:New({
    weComponents.LegacyAnimation
  }, {}, {})
  entityMatchers.MaterialAnimation = Matcher:New({
    weComponents.MaterialAnimation
  }, {}, {})
  entityMatchers.Hitback = Matcher:New({
    weComponents.Hitback
  }, {}, {})
  entityMatchers.GridMove = Matcher:New({
    weComponents.GridMove
  }, {}, {})
  entityMatchers.EntityType = Matcher:New({
    weComponents.EntityType
  }, {}, {})
end
