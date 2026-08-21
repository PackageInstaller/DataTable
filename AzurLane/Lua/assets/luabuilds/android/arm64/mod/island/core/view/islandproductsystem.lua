local var_0_0 = class("IslandProductSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.scheduleList = {}

	return
end

function var_0_0.OnStart(arg_2_0)
	for iter_2_0, iter_2_1 in pairs((arg_2_0.data:GetDelegateSlotUnits())) do
		arg_2_0:StartDelegation({
			commissionSlotId = iter_2_0,
			unitIds = iter_2_1
		})
	end

	return
end

function var_0_0.StartDelegation(arg_3_0, arg_3_1)
	table.insert(arg_3_0.scheduleList, arg_3_1)

	return
end

function var_0_0.ExecuteDelegation(arg_4_0, arg_4_1)
	switch(arg_4_0.data.productPlaceId, {
		[IslandProductConst.FisheryPlaceId] = function()
			arg_4_0:ExecuteDelegateFish(arg_4_1)

			return
		end
	})

	return
end

function var_0_0.ExecuteDelegateFish(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.unitIds) do
		local var_6_0 = arg_6_0:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_DELEGATE_UNIT, iter_6_1)

		if var_6_0 then
			var_6_0:SetFishPonds(pg.island_production_commission[arg_6_1.commissionSlotId].performanceObjid)
			var_6_0:StartFishing()
		end
	end

	return
end

function var_0_0.EndDelegation(arg_7_0, arg_7_1)
	return
end

function var_0_0.OnUpdate(arg_8_0)
	if #arg_8_0.scheduleList <= 0 then
		return
	end

	local var_8_0 = arg_8_0:GetView()

	if not var_8_0:IsLoaded() then
		return
	end

	arg_8_0:ExecuteDelegation((table.remove(arg_8_0.scheduleList, 1)))

	return
end

function var_0_0.OnDestroy(arg_9_0)
	table.clear(arg_9_0.scheduleList)

	return
end

return var_0_0
