local IslandProductSystem = class("IslandProductSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function IslandProductSystem:Ctor(arg_1_1, arg_1_2)
	IslandProductSystem.super.Ctor(self, arg_1_1, arg_1_2)

	self.scheduleList = {}

	return
end

function IslandProductSystem:OnStart()
	for iter_2_0, iter_2_1 in pairs((self.data:GetDelegateSlotUnits())) do
		self:StartDelegation({
			commissionSlotId = iter_2_0,
			unitIds = iter_2_1
		})
	end

	return
end

function IslandProductSystem:StartDelegation(arg_3_1)
	table.insert(self.scheduleList, arg_3_1)

	return
end

function IslandProductSystem:ExecuteDelegation(arg_4_1)
	switch(self.data.productPlaceId, {
		[IslandProductConst.FisheryPlaceId] = function()
			self:ExecuteDelegateFish(arg_4_1)

			return
		end
	})

	return
end

function IslandProductSystem:ExecuteDelegateFish(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.unitIds) do
		local var_6_0 = self:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_DELEGATE_UNIT, iter_6_1)

		if var_6_0 then
			var_6_0:SetFishPonds(pg.island_production_commission[arg_6_1.commissionSlotId].performanceObjid)
			var_6_0:StartFishing()
		end
	end

	return
end

function IslandProductSystem:EndDelegation(arg_7_1)
	return
end

function IslandProductSystem:OnUpdate()
	if #self.scheduleList <= 0 then
		return
	end

	if not self:GetView():IsLoaded() then
		return
	end

	self:ExecuteDelegation((table.remove(self.scheduleList, 1)))

	return
end

function IslandProductSystem:OnDestroy()
	table.clear(self.scheduleList)

	return
end

return IslandProductSystem
