local QWorldNpcMgr = class("QWorldNpcMgr")

function QWorldNpcMgr:Ctor()
	self.npcList = {}
end

function QWorldNpcMgr:CreateEntityDataByConfigId(arg_2_1)
	local var_2_1 = QWorldThingEntityData.New()

	var_2_1.name = "QWNpc"
	var_2_1.configId = arg_2_1.configId
	var_2_1.position = Vector3.New(arg_2_1.position[0], arg_2_1.position[1], arg_2_1.position[2])
	var_2_1.rotation = Vector3.New(arg_2_1.rotation[0], arg_2_1.rotation[1], arg_2_1.rotation[2])
end

function QWorldNpcMgr:AddNpcAfterEnterMap(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs((self:GetNpcListToMap(arg_3_1))) do
		local var_3_0 = QWorldSpawnPrefab("QWNpc", 0, iter_3_1.configId)

		var_3_0.entity:InitEntityData((self:CreateEntityDataByConfigId(iter_3_1)))
		self:UpdateNpcState(var_3_0)
	end
end

function QWorldNpcMgr:AddNpcToMap(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_2 == nil then
		arg_4_2 = QWorldNpcCfg[arg_4_1].mapId
	end

	if arg_4_3 == nil then
		arg_4_3 = QWorldNpcCfg[arg_4_1].position
	end

	if arg_4_4 == nil then
		arg_4_4 = arg_4_4.rotation
	end

	if self.npcList[arg_4_2] == nil then
		self.npcList[arg_4_2] = {}
	else
		local var_4_0 = self.npcList[arg_4_2]

		for iter_4_0, iter_4_1 in ipairs(self.npcList[arg_4_2]) do
			if iter_4_1.configId == arg_4_1 then
				table.remove(var_4_0, iter_4_0)

				break
			end
		end
	end

	table.insert(self.npcList[arg_4_2], {
		configId = arg_4_1,
		mapId = arg_4_2,
		position = arg_4_3,
		rotation = arg_4_4
	})
end

function QWorldNpcMgr:RemoveNpcToMap(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.npcList) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			if iter_5_3.configId == arg_5_1 then
				table.remove(iter_5_1, iter_5_2)

				break
			end
		end
	end
end

function QWorldNpcMgr:GetNpcListToMap(arg_6_1)
	return self.npcList[arg_6_1] or {}
end

function QWorldNpcMgr:UpdateNpcState(arg_7_1)
	return
end

return QWorldNpcMgr
