require("enum_lookup")
WEComponents_Base = ComponentsLookup:New({
  "CommandReceiver",
  "CommandSender",
  "Asset",
  "View"
})
WUniqueComponents_Base = ComponentsLookup:New({})
_staticClass("BasePackInstaller")

function BasePackInstaller:InstallEntityComponentsLookup(weComponents)
  weComponents:MergeLookup(WEComponents_Base)
end

function BasePackInstaller:InstallUniqueComponentsLookup(uniqueComponents)
  local lookup = WUniqueComponents_Base
  uniqueComponents:MergeLookup(lookup)
end

function BasePackInstaller:InstallEntityMatchers(entityMatchers, weComponents)
  entityMatchers.Asset = Matcher:New({
    weComponents.Asset
  }, {}, {})
  entityMatchers.View = Matcher:New({
    weComponents.View
  }, {}, {})
  entityMatchers.CommandReceiver = Matcher:New({
    weComponents.CommandReceiver
  }, {}, {})
  entityMatchers.CommandSender = Matcher:New({
    weComponents.CommandSender
  }, {}, {})
end
