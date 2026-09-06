-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleFormationRightView.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleFormationRightView", package.seeall)

local CampScuffleFormationRightView = class("CampScuffleFormationRightView", FormationRightView)

function CampScuffleFormationRightView:getPetMoById(petId)
	return (CampScuffleModel.instance:getPet(petId))
end

function CampScuffleFormationRightView:getAllShowPetList()
	return CampScuffleModel.instance:getAllPets()
end

function CampScuffleFormationRightView:_getCurFormation()
	return CampScuffleModel.instance:getFormation()
end

return CampScuffleFormationRightView
