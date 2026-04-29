require("enum_lookup")
CutsceneComponentsRegister = ComponentsLookup:New({
  "RenderStartIndex",
  "EntityType",
  "CutscenePlayer",
  "CutsceneMonster",
  "Asset",
  "View",
  "Location",
  "GridMove",
  "BodyArea",
  "Hitback",
  "RenderBoard",
  "AnimatorController",
  "LegacyAnimation",
  "MaterialAnimation",
  "TrailEffectEx",
  "ArchivedEffect",
  "EffectController",
  "EffectHolder",
  "GridEffect",
  "TotalRenderComponents"
})
CutsceneUniqueComponentsRegister = ComponentsLookup:New({
  "RenderUniqueStartIndex",
  "LocalPlayer",
  "TotalRenderUniqueComponents"
})
