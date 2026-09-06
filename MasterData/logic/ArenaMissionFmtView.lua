-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaMissionFmtView.lua

module("logic.extensions.arena.view.ArenaMissionFmtView", package.seeall)

local ArenaMissionFmtView = class("ArenaMissionFmtView", MissionFmtView)

function ArenaMissionFmtView:onEnter()
	self:onEnterInherit()

	local isDataInited = self._viewPresentor._openParam[4]

	self._needSetSkillEffect = false

	if isDataInited then
		self:_refreshFromation()
	else
		self._needSetSkillEffect = true
		self._zdl = self._viewPresentor._openParam[3]

		ArenaController.instance:registerLocalNotify("RefreshOtherForm", self._refreshFromation, self)
		ArenaAgent.instance:sendGetOtherArenaFormationReq(self._viewPresentor._openParam[1])
	end

	GlobalDispatcher:removeListener(GlobalNotify.UpdateStartOrder, self._updateStartOrder, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDragBegin, self._onBagBeginDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDropBag, self._onBagEndDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)
end

function ArenaMissionFmtView:onExit()
	ArenaMissionFmtView.super.onExit(self)
	ArenaController.instance:unregisterLocalNotify("RefreshOtherForm", self._refreshFromation, self)
end

function ArenaMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
	self:_setHeroSkillEffect()
end

function ArenaMissionFmtView:getTeamAndFormation(creepCfg)
	local from = ArenaModel.instance:getOtherPlayerForm()
	local teams = {}
	local formations = {}
	local pets = {}

	self._tempMasterId = 0
	self._tempSummonId = 0

	for i, v in ipairs(from) do
		if v > 0 then
			local pet = ArenaModel.instance:getOtherPetMo(v)

			table.insert(pets, pet)
		end
	end

	for i, v in ipairs(from) do
		if v > 0 then
			local pet = ArenaModel.instance:getOtherPetMo(v)
			local fPetMo = pet:toFightingPowerPetMo(pets)

			fPetMo.petId = v

			table.insert(teams, fPetMo)

			formations[i] = fPetMo

			if checknumber(fPetMo.summonMasterId) > 0 then
				self._tempSummonId = checknumber(fPetMo.petId)
			end

			if checknumber(fPetMo.summonedPetId) > 0 then
				self._tempMasterId = checknumber(fPetMo.petId)
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function ArenaMissionFmtView:_createExtParams(formations)
	self:setExtParams(ArenaModel.instance:getCurExtParams())

	if self._summonMasterPetId == 0 and self._summonedPetId == 0 and checknumber(self._tempMasterId) > 0 and checknumber(self._tempSummonId) > 0 then
		self._summonMasterPetId = checknumber(self._tempMasterId)
		self._summonedPetId = checknumber(self._tempSummonId)
	end
end

function ArenaMissionFmtView:getheroSkillId(monsterCo, teams)
	return (ArenaModel.instance:getOtherHeroSkillId())
end

return ArenaMissionFmtView
