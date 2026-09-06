-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleFormationMO.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleFormationMO", package.seeall)

local CampScuffleFormationMO = class("CampScuffleFormationMO", FormationMO)

function CampScuffleFormationMO:_getPet(id)
	return CampScuffleModel.instance:getPet(id)
end

return CampScuffleFormationMO
