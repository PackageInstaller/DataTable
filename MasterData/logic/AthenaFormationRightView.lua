-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaFormationRightView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaFormationRightView", package.seeall)

local AthenaFormationRightView = class("AthenaFormationRightView", FormationRightView)

function AthenaFormationRightView:_initAllPetList()
	local openParam = self:getOpenParam()
	local supportPlan = openParam[3]

	self._allPetList = supportPlan and AthenaModel.instance:getAllHelpPets(supportPlan) or BagPetsController.instance:getFightBagPet()
end

function AthenaFormationRightView:_getCurFormation()
	local openParam = self:getOpenParam()

	self._challengeId = openParam[1]
	self._supportPlan = openParam[3]

	if self._supportPlan then
		return AthenaModel.instance:getWitFormation(self._challengeId)
	else
		return AthenaFormationRightView.super._getCurFormation(self)
	end
end

return AthenaFormationRightView
