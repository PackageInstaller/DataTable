local var_0_0 = class("QWorldNpcMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.npcList = {}
end

function var_0_0.CreateEntityDataByConfigId(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.configId
	local var_2_1 = arg_2_1.mapId
	local var_2_2 = arg_2_1.position
	local var_2_3 = arg_2_1.rotation
	local var_2_4 = QWorldThingEntityData.New()

	var_2_4.name = "QWNpc"
	var_2_4.configId = var_2_0
	var_2_4.position = Vector3.New(var_2_2[0], var_2_2[1], var_2_2[2])
	var_2_4.rotation = Vector3.New(var_2_3[0], var_2_3[1], var_2_3[2])
end

function var_0_0.AddNpcAfterEnterMap(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:GetNpcListToMap(arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = QWorldSpawnPrefab("QWNpc", 0, iter_3_1.configId)
		local var_3_2 = arg_3_0:CreateEntityDataByConfigId(iter_3_1)

		var_3_1.entity:InitEntityData(var_3_2)
		arg_3_0:UpdateNpcState(var_3_1)
	end
end

function var_0_0.AddNpcToMap(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = QWorldNpcCfg[arg_4_1]

	if arg_4_2 == nil then
		arg_4_2 = var_4_0.mapId
	end

	if arg_4_3 == nil then
		arg_4_3 = var_4_0.position
	end

	if arg_4_4 == nil then
		arg_4_4 = arg_4_4.rotation
	end

	if arg_4_0.npcList[arg_4_2] == nil then
		arg_4_0.npcList[arg_4_2] = {}
	else
		local var_4_1 = arg_4_0.npcList[arg_4_2]

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if iter_4_1.configId == arg_4_1 then
				table.remove(var_4_1, iter_4_0)

				break
			end
		end
	end

	table.insert(arg_4_0.npcList[arg_4_2], {
		configId = arg_4_1,
		mapId = arg_4_2,
		position = arg_4_3,
		rotation = arg_4_4
	})
end

function var_0_0.RemoveNpcToMap(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.npcList) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			if iter_5_3.configId == arg_5_1 then
				table.remove(iter_5_1, iter_5_2)

				break
			end
		end
	end
end

function var_0_0.GetNpcListToMap(arg_6_0, arg_6_1)
	return arg_6_0.npcList[arg_6_1] or {}
end

function var_0_0.UpdateNpcState(arg_7_0, arg_7_1)
	return
end

return var_0_0
