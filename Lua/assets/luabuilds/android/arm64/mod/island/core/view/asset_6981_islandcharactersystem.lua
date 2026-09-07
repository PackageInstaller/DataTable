local IslandCharacterSystem = class("IslandCharacterSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function IslandCharacterSystem:Ctor(arg_1_1, arg_1_2)
	IslandCharacterSystem.super.Ctor(self, arg_1_1, arg_1_2)

	self.scheduleList = {}
	self.workerCnt = self.data:GetWorkerCnt()

	return
end

function IslandCharacterSystem:OnStart()
	if self.behaviourTreeOwner then
		LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "worker", self.workerCnt)

		local var_2_0 = {
			IslandProductConst.FarmlandPlaceId,
			IslandProductConst.OrchardPlaceId,
			IslandProductConst.GardenPlaceId
		}
		local var_2_1 = self.data:GetWorkerList() or {}

		if self.data.id == IslandProductConst.MinePlaceId then
			return
		end

		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			iter_2_1.nextIn = table.contains(var_2_0, self.data.id)

			self:StartDelegation(iter_2_1)
		end
	end

	return
end

function IslandCharacterSystem:StartDelegation(arg_3_1)
	if not self.behaviourTreeOwner then
		return
	end

	table.insert(self.scheduleList, arg_3_1)

	return
end

function IslandCharacterSystem:ExecuteDelegation(arg_4_1)
	self.workerCnt = self.workerCnt + 1

	local var_4_0 = self.data:GetUnitShipIdBySlotId(arg_4_1.ship_id, arg_4_1.area_id)
	local var_4_1 = System.Collections.Generic.List_IslandUnitNode()

	if self:GetView():GetSystemUnitModule(var_4_0) then
		local var_4_2 = IslandUnitNode.New()

		var_4_2.unitId = var_4_0
		var_4_2.unitType = IslandConst.UNIT_LIST_DELEGATION

		var_4_1:Add(var_4_2)
	end

	for iter_4_0, iter_4_1 in ipairs((self.data:GetperformanceObjidList(arg_4_1.area_id))) do
		local var_4_3 = IslandUnitNode.New()

		var_4_3.unitId = iter_4_1.unitId
		var_4_3.unitType = iter_4_1.unitType

		var_4_1:Add(var_4_3)
	end

	if arg_4_1.nextIn then
		self.behaviourTreeOwner:SendEvent("system_unit_add_nextIn", var_4_1, nil)
	else
		self.behaviourTreeOwner:SendEvent("system_unit_add", var_4_1, nil)
	end

	return
end

function IslandCharacterSystem:EndDelegation(arg_5_1)
	if not self.behaviourTreeOwner then
		return
	end

	self.workerCnt = self.workerCnt - 1

	LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "worker", self.workerCnt)

	local var_5_0 = IslandUnitNode.New()

	var_5_0.unitId = arg_5_1.ship_id
	var_5_0.unitType = IslandConst.UNIT_LIST_DELEGATION

	self.behaviourTreeOwner:SendEvent("system_unit_remove", var_5_0, nil)

	return
end

function IslandCharacterSystem:OnUpdate()
	if #self.scheduleList <= 0 then
		return
	end

	if not self:GetView():IsLoaded() then
		return
	end

	if not self._go:GetComponent(typeof(ParadoxNotion.Services.EventRouter)) then
		return
	end

	self:ExecuteDelegation((table.remove(self.scheduleList, 1)))

	return
end

function IslandCharacterSystem:OnDestroy()
	table.clear(self.scheduleList)

	return
end

return IslandCharacterSystem
