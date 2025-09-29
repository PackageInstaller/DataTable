-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/model/BattleCampCollectionMO.lua

module("logic.battle.battleflow.component.model.BattleCampCollectionMO", package.seeall)

local BattleCampCollectionMO = class("BattleCampCollectionMO")

function BattleCampCollectionMO:ctor()
	self._campMOTable = {}
end

function BattleCampCollectionMO:clear()
	BattleTableUtil.clearTable(self._campMOTable)
end

function BattleCampCollectionMO:buildFromCampInfos(campInfos)
	self:clear()

	for _, campInfo in pairs(campInfos) do
		local campMO = BattleCampCollectionMO.Camp.New(campInfo.campId, campInfo.stageId)

		self._campMOTable[campMO.campId] = campMO
	end
end

function BattleCampCollectionMO:getRelationType(aCampId, bCampId)
	if aCampId == bCampId then
		return BattleEnum.CampRelation.SAME
	end

	local model = BattleMgr.instance:getModel()
	local npcCampId = model:getNpcCampId()

	if aCampId == npcCampId or bCampId == npcCampId then
		return BattleEnum.CampRelation.NORMAL
	end

	local aCampMO = self._campMOTable[aCampId]
	local bCampMO = self._campMOTable[bCampId]

	if not aCampMO or not bCampMO then
		return BattleEnum.CampRelation.ENEMY
	end

	if aCampMO:isSameStage(bCampMO) then
		return BattleEnum.CampRelation.FRIEND
	end

	return BattleEnum.CampRelation.ENEMY
end

function BattleCampCollectionMO:getCampStageId(campId)
	local campMO = self._campMOTable[campId]

	return campMO and campMO.stageId or -1
end

BattleCampCollectionMO.Camp = class("BattleCampCollectionMO.Camp")

function BattleCampCollectionMO.Camp:ctor(campId, stageId)
	self.campId = campId
	self.stageId = stageId
end

function BattleCampCollectionMO.Camp:isSameStage(campMO)
	return self.stageId == campMO.stageId
end

return BattleCampCollectionMO
