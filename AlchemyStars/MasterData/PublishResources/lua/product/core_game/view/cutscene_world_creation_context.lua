require("base_world_creation_context")
require("cutscene_pack_installer")
_class("CutsceneWorldCreationContext", BaseWorldCreationContext)
CutsceneWorldCreationContext = CutsceneWorldCreationContext

function CutsceneWorldCreationContext:Constructor()
  self.WCC_StartCreationIndex = 1
  self.WCC_EntityCreationProto = Entity
  local wEComponents = ComponentsLookup:New({})
  local wUniqueComponents = ComponentsLookup:New({})
  local wEMatchers = {}
  CutscenePackInstaller:InstallEntityComponentsLookup(wEComponents)
  CutscenePackInstaller:InstallUniqueComponentsLookup(wUniqueComponents)
  BasePackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  CombatPackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  CutscenePackInstaller:InstallEntityMatchers(wEMatchers, wEComponents)
  self.BWCC_EComponentsEnum = wEComponents
  self.BWCC_WUniqueComponentsEnum = wUniqueComponents
  self.BWCC_EMatchers = wEMatchers
  self.level_id = 0
  self.totalComponents = wEComponents.TotalComponents
end

function CutsceneWorldCreationContext:Destructor()
  self.players = nil
end
