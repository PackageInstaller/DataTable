require("world_creation_context")
_class("BaseWorldCreationContext", WorldCreationContext)
BaseWorldCreationContext = BaseWorldCreationContext

function BaseWorldCreationContext:Constructor()
  self.BWCC_EComponentsEnum = {TotalComponents = 0}
  self.BWCC_EMatchers = {}
  self.BWCC_WUniqueComponentsEnum = {TotalComponents = 0}
end

function BaseWorldCreationContext:WCC_EntityTotalComponents()
  return self.BWCC_EComponentsEnum.TotalComponents
end
