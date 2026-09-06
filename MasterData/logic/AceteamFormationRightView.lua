-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/AceteamFormationRightView.lua

module("logic.extensions.formation.view.AceteamFormationRightView", package.seeall)

local AceteamFormationRightView = class("AceteamFormationRightView", FormationRightView)

function AceteamFormationRightView:onEnter()
	AceteamFormationRightView.super.onEnter(self)
end

function AceteamFormationRightView:onExit()
	AceteamFormationRightView.super.onExit(self)
end

function AceteamFormationRightView:getAllShowPetList()
	return AceTeamModel.instance:getPetList()
end

function AceteamFormationRightView:_getCurFormation()
	return AceTeamModel.instance:GetCurFormation()
end

function AceteamFormationRightView:_updateCell(view, cell, data)
	AceteamFormationRightView.super._updateCell(self, view, cell, data)

	local component = ItemPet.AddOnce(cell.gameObject)

	component:setSupportPet(false)
end

return AceteamFormationRightView
