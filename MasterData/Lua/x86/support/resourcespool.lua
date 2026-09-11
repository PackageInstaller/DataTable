local ResourcesPool = class("ResourcesPool")

ASSET_TYPE = {
	WEAPON = 3,
	TPOSE = 1,
	ASTROLABE = 4,
	SCENE = 2
}
MAX_TMP_NUM = {
	[ASSET_TYPE.TPOSE] = 5,
	[ASSET_TYPE.SCENE] = 2,
	[ASSET_TYPE.WEAPON] = 3,
	[ASSET_TYPE.ASTROLABE] = 6
}
MAX_TMP_NUM_DONT_DESTROY = {
	[ASSET_TYPE.TPOSE] = 4
}

function ResourcesPool:Ctor()
	if UnityEngine.SystemInfo.systemMemorySize < 4000 then
		MAX_TMP_NUM[ASSET_TYPE.TPOSE] = 2
	end

	self.assetsPool_ = {}
	self.asyncIndex_ = 0
	self.asyncIndexQueue_ = {}
	self.asyncLoadAssetInfo_ = {}

	for iter_1_0, iter_1_1 in pairs(ASSET_TYPE) do
		self.assetsPool_[iter_1_1] = {}
	end
end

function ResourcesPool:GetPooledAsset(arg_2_1, arg_2_2)
	self.assetsPool_[arg_2_2] = self.assetsPool_[arg_2_2] or {}

	for iter_2_0, iter_2_1 in ipairs(self.assetsPool_[arg_2_2]) do
		if iter_2_1.name == arg_2_1 and not iter_2_1.use then
			iter_2_1.use = true

			self:MoveResourceToEnd(self.assetsPool_[arg_2_2], iter_2_0)

			return iter_2_1, iter_2_0
		end
	end
end

function ResourcesPool:MoveResourceToEnd(arg_3_1, arg_3_2)
	if arg_3_1[arg_3_2] then
		table.insert(arg_3_1, arg_3_1[arg_3_2])
		table.remove(arg_3_1, arg_3_2)
	end
end

function ResourcesPool:AsyncLoad(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self:GetPooledAsset(arg_4_1, arg_4_2)

	if var_4_0 then
		SetActive(var_4_0.go, true)
		arg_4_3(var_4_0.go)

		return
	end

	local var_4_1 = self.asyncIndex_

	table.insert(self.asyncIndexQueue_, self.asyncIndex_)

	if self.asyncLoadAssetInfo_[arg_4_1] then
		self.asyncLoadAssetInfo_[arg_4_1][var_4_1] = arg_4_3
	else
		self.asyncLoadAssetInfo_[arg_4_1] = {}
		self.asyncLoadAssetInfo_[arg_4_1][var_4_1] = arg_4_3

		Asset.LoadAsync(arg_4_1, function(arg_5_0)
			local var_5_0 = 0

			for iter_5_0, iter_5_1 in pairs(self.asyncLoadAssetInfo_[arg_4_1]) do
				local var_5_1 = table.keyof(self.asyncIndexQueue_, iter_5_0)

				if var_5_1 then
					var_5_0 = var_5_0 + 1

					table.remove(self.asyncIndexQueue_, var_5_1)
				else
					self.asyncLoadAssetInfo_[arg_4_1][iter_5_0] = nil
				end
			end

			if var_5_0 == 0 then
				self.asyncLoadAssetInfo_[arg_4_1] = nil

				return
			end

			local var_5_2 = Object.Instantiate(arg_5_0)

			table.insert(self.assetsPool_[arg_4_2], {
				use = true,
				name = arg_4_1,
				go = var_5_2
			})

			if #self.assetsPool_[arg_4_2] > MAX_TMP_NUM[arg_4_2] then
				self:DestroyNoUse(arg_4_2, #self.assetsPool_[arg_4_2] - MAX_TMP_NUM[arg_4_2])
			end

			for iter_5_2, iter_5_3 in pairs(self.asyncLoadAssetInfo_[arg_4_1]) do
				iter_5_3(var_5_2)
			end

			self.asyncLoadAssetInfo_[arg_4_1] = nil
		end)
	end

	self.asyncIndex_ = var_4_1 + 1

	return var_4_1
end

function ResourcesPool:StopAsyncQuest(arg_6_1)
	if arg_6_1 == nil then
		return
	end

	local var_6_0 = table.keyof(self.asyncIndexQueue_, arg_6_1)

	if var_6_0 then
		table.remove(self.asyncIndexQueue_, var_6_0)
	end
end

function ResourcesPool:Get(arg_7_1, arg_7_2)
	local var_7_0 = self:GetPooledAsset(arg_7_1, arg_7_2)

	if var_7_0 then
		if arg_7_2 == ASSET_TYPE.TPOSE then
			self:ResetBlendShapes(var_7_0.go)
		end

		SetActive(var_7_0.go, true)

		return var_7_0.go
	end

	local var_7_1 = Object.Instantiate((Asset.Load(arg_7_1)))

	self.assetsPool_[arg_7_2] = self.assetsPool_[arg_7_2] or {}

	table.insert(self.assetsPool_[arg_7_2], {
		use = true,
		name = arg_7_1,
		go = var_7_1
	})

	if arg_7_2 == ASSET_TYPE.TPOSE then
		self:ResetBlendShapes(var_7_1)
	end

	return var_7_1
end

function ResourcesPool:DestroyOrReturn(arg_8_1, arg_8_2)
	if not self.assetsPool_[arg_8_2] then
		Object.DestroyImmediate(arg_8_1)

		return
	end

	self:ResetBlendShapes(arg_8_1)
	SetActive(arg_8_1, false)

	for iter_8_0 = #self.assetsPool_[arg_8_2], 1, -1 do
		if self.assetsPool_[arg_8_2][iter_8_0].go == arg_8_1 then
			self.assetsPool_[arg_8_2][iter_8_0].use = false
		end
	end

	if #self.assetsPool_[arg_8_2] > MAX_TMP_NUM[arg_8_2] then
		self:DestroyNoUse(arg_8_2, #self.assetsPool_[arg_8_2] - MAX_TMP_NUM[arg_8_2])
	end
end

function ResourcesPool:DestroyNoUse(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 or 1

	if self.assetsPool_[arg_9_1] then
		local var_9_1 = {}
		local var_9_2 = {}

		for iter_9_0 = 1, #self.assetsPool_[arg_9_1] do
			if not self.assetsPool_[arg_9_1][iter_9_0].use then
				if var_9_0 > 0 then
					table.insert(var_9_1, iter_9_0)
				end

				var_9_0 = var_9_0 - 1
			else
				local var_9_3 = self.assetsPool_[arg_9_1][iter_9_0].name or ""

				var_9_2[var_9_3] = (var_9_2[var_9_3] or 0) + 1
			end
		end

		for iter_9_1 = #var_9_1, 1, -1 do
			Object.DestroyImmediate(self.assetsPool_[arg_9_1][var_9_1[iter_9_1]].go)

			local var_9_4 = var_9_2[self.assetsPool_[arg_9_1][var_9_1[iter_9_1]].name] or 0

			if not var_9_4 or var_9_4 <= 0 then
				Asset.Unload(self.assetsPool_[arg_9_1][var_9_1[iter_9_1]].name)
				manager.gc:Collect()
			end

			table.remove(self.assetsPool_[arg_9_1], var_9_1[iter_9_1])
		end
	end
end

function ResourcesPool:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.assetsPool_) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			Object.Destroy(iter_10_3.go)
		end
	end

	self.assetsPool_ = {}

	for iter_10_4, iter_10_5 in pairs(ASSET_TYPE) do
		self.assetsPool_[iter_10_5] = {}
	end
end

function ResourcesPool:ResetBlendShapes(arg_11_1)
	local var_11_0 = arg_11_1:GetComponentsInChildren(typeof(UnityEngine.Transform), true)
	local var_11_1

	for iter_11_0, iter_11_1 in pairs(var_11_0:ToTable()) do
		local var_11_2 = iter_11_1:GetComponent(typeof(Animator))

		if var_11_2 then
			var_11_1 = var_11_2
			var_11_2.enabled = false

			break
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0:ToTable()) do
		if iter_11_3.name == "face" or iter_11_3.name == "Face" or iter_11_3.name == "Eye" then
			local var_11_3 = iter_11_3:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))

			if var_11_3 then
				if not isNil(var_11_3.sharedMesh) then
					for iter_11_4 = 0, var_11_3.sharedMesh.blendShapeCount - 1 do
						var_11_3:SetBlendShapeWeight(iter_11_4, 0)
					end
				end
			end
		end
	end

	if var_11_1 then
		var_11_1.enabled = true
	end
end

return ResourcesPool
