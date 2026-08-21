require("enum_lookup")
WEComponents_Combat = ComponentsLookup:New({
  "Abilities",
  "Attributes",
  "Location",
  "MainFSM",
  "Movement"
})
WUniqueComponents_Combat = ComponentsLookup:New({})
_staticClass("CombatPackInstaller")

function CombatPackInstaller:InstallEntityComponentsLookup(weComponents)
  weComponents:MergeLookup(WEComponents_Combat)
end

function CombatPackInstaller:InstallUniqueComponentsLookup(uniqueComponents)
  local lookup = WUniqueComponents_Combat
  uniqueComponents:MergeLookup(lookup)
end

function CombatPackInstaller:InstallEntityMatchers(entityMatchers, weComponents)
  entityMatchers.Location = Matcher:New({
    weComponents.Location
  }, {}, {})
  entityMatchers.CanMove = Matcher:New({
    weComponents.Movement,
    weComponents.Location
  }, {}, {})
  entityMatchers.MainFSM = Matcher:New({
    weComponents.MainFSM
  }, {}, {})
  entityMatchers.Abilities = Matcher:New({
    weComponents.Abilities
  }, {}, {})
  entityMatchers.Attributes = Matcher:New({
    weComponents.Attributes
  }, {}, {})
end
