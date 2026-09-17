local this = {}
local C_TechnologyStore = CS.Lens.Gameplay.UI.TechnologyStore

function this:req_homeTechnologyTypeInfo(type)
  C_TechnologyStore.GetStore():req_homeTechnologyTypeInfo(type)
end

function this:req_homeTechnologyLevelUp(type, subType, callback)
  C_TechnologyStore.GetStore():req_homeTechnologyLevelUp(type, subType, callback)
end

return this
