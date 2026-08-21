_autoEnum("WEComponents_Test", {
  "CommandReceiver",
  "CommandSender",
  "Attributes",
  "Location",
  "Movement",
  "Spawn",
  "MainFSM",
  "Abilities",
  "Asset",
  "View",
  "TotalComponents"
})
_autoEnum("WUniqueComponentsEnum_Test", {
  "SpawnMng",
  "TotalComponents"
})
_enum("BW_WEMatchers_Test", {
  Asset = Matcher:New({
    WEComponents_Test.Asset
  }, {}, {}),
  Location = Matcher:New({
    WEComponents_Test.Location
  }, {}, {}),
  Spawn = Matcher:New({
    WEComponents_Test.Spawn
  }, {}, {}),
  View = Matcher:New({
    WEComponents_Test.View
  }, {}, {}),
  CanMove = Matcher:New({
    WEComponents_Test.Movement,
    WEComponents_Test.Location
  }, {}, {}),
  CommandReceiver = Matcher:New({
    WEComponents_Test.CommandReceiver
  }, {}, {}),
  CommandSender = Matcher:New({
    WEComponents_Test.CommandSender
  }, {}, {}),
  MainFSM = Matcher:New({
    WEComponents_Test.MainFSM
  }, {}, {})
})
