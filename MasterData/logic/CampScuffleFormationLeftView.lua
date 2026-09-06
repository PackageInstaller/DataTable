-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleFormationLeftView.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleFormationLeftView", package.seeall)

local CampScuffleFormationLeftView = class("CampScuffleFormationLeftView", FormationLeftView)

function CampScuffleFormationLeftView:onEnter()
	CampScuffleFormationLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:setBtnFormActive(false)
	self:setBtnContractActive(false)
end

function CampScuffleFormationLeftView:_isShowBtnEvaluate()
	return false
end

function CampScuffleFormationLeftView:_getCurFormId()
	return CampScuffleModel.instance:getCurFormationId()
end

function CampScuffleFormationLeftView:_getCurFormation()
	return CampScuffleModel.instance:getFormation()
end

function CampScuffleFormationLeftView:_getPet(id)
	return CampScuffleModel.instance:getPet(id)
end

function CampScuffleFormationLeftView:_getCurBonds(isGetPetIdList)
	local racesInCurFormation = {}
	local positions = self:_getCurFormation():GetPositions()
	local petIdList = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local raceId = self:_getPet(petId).raceId

			table.insert(racesInCurFormation, raceId)
			table.insert(petIdList, petId)
		end
	end

	return {}, petIdList
end

function CampScuffleFormationLeftView:_changeTeamId(id)
	printError("test 切换了阵型？")
end

function CampScuffleFormationLeftView:_getCurrTeamId()
	return CampScuffleModel.instance:getTeamId()
end

function CampScuffleFormationLeftView:_saveCurrFmt()
	return
end

function CampScuffleFormationLeftView:_getItemSeatCls()
	return CampScuffleItemSeat
end

return CampScuffleFormationLeftView
