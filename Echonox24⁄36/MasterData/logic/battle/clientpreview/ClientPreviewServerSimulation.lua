-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/clientpreview/ClientPreviewServerSimulation.lua

module("logic.battle.clientpreview.ClientPreviewServerSimulation", package.seeall)

local ClientPreviewServerSimulation = class("ClientPreviewServerSimulation", IBattleFlowComp)

function ClientPreviewServerSimulation:onStart()
	self._unitMgr = self.flow.unitMgr or false
	self._model = self.flow.model or false
	self._campIds = {}
	self._currentCampIndex = 0
end

function ClientPreviewServerSimulation:onClear()
	self._unitMgr = false
	self._model = false
	self._campIds = false
	self._currentCampIndex = false
end

function ClientPreviewServerSimulation:simulateReady()
	local battleFieldInfo = self._model:getBattleFieldInfo()
	local campInfos = battleFieldInfo.campInfos

	for _, campInfo in pairs(campInfos) do
		table.insert(self._campIds, campInfo.campId)
	end

	self:_nextCamp()
end

function ClientPreviewServerSimulation:simulateEndStage()
	self:_nextCamp()
end

function ClientPreviewServerSimulation:simulateStepRequest(entityId, pathUnionIndexs, skillId, targetUnionIndex)
	local unit = self._unitMgr:getUnit(entityId)

	if pathUnionIndexs then
		local movedEvent = BattleExtension_pb.EventNO()
		local movedNO = movedEvent.moved

		movedNO.entity = entityId

		for _, unionIndex in pairs(pathUnionIndexs) do
			local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
			local cellNO = BattleExtension_pb.CellNO()

			cellNO.x = x
			cellNO.z = z

			table.insert(movedNO.movement, cellNO)
		end

		ClientPreviewBattleNetAgent.instance:pushEventNO(movedEvent)
	end

	if skillId > 0 then
		local defenderUnit = self._unitMgr:getUnitOnUnionIndex(targetUnionIndex)
		local twoEntityBattledEvent = BattleExtension_pb.EventNO()
		local twoEntityBattled = twoEntityBattledEvent.twoEntityBattled

		twoEntityBattled.attacker = entityId
		twoEntityBattled.defender = defenderUnit.property:getEntityId()

		local attackedEvent = BattleExtension_pb.EventNO()
		local attackedNO = attackedEvent.attacked

		attackedNO.direction = 1
		attackedNO.skill = skillId
		attackedNO.critical = math.random() > 0.5 and true or false
		attackedNO.damage = unit.property:getAttribute(BattleExtension_pb.Attribute.ATK_PHY) - unit.property:getAttribute(BattleExtension_pb.Attribute.DEF_PHY)

		table.insert(twoEntityBattled.procedure, attackedEvent)
		ClientPreviewBattleNetAgent.instance:pushEventNO(twoEntityBattledEvent)
	end
end

function ClientPreviewServerSimulation:_nextCamp()
	local preCampId = self._campIds[self._currentCampIndex]

	if preCampId then
		local stageEndedEvent = BattleExtension_pb.EventNO()

		stageEndedEvent.stageEnded = preCampId

		ClientPreviewBattleNetAgent.instance:pushEventNO(stageEndedEvent)
	end

	self._currentCampIndex = self._currentCampIndex + 1

	local campCount = #self._campIds

	if campCount < self._currentCampIndex then
		self._currentCampIndex = self._currentCampIndex - campCount
	end

	local campId = self._campIds[self._currentCampIndex]
	local stageStartedEvent = BattleExtension_pb.EventNO()

	stageStartedEvent.stageStarted = campId

	ClientPreviewBattleNetAgent.instance:pushEventNO(stageStartedEvent)
	self:_checkAI(campId)
end

function ClientPreviewServerSimulation:_checkAI(campId)
	if self._model:getOperateCampId() ~= campId then
		settimer(1, self._nextCamp, self, false)
	end
end

return ClientPreviewServerSimulation
