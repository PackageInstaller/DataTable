local IslandBaseBuilder = class("IslandBaseBuilder")

function IslandBaseBuilder:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_1

	assert(arg_1_2)

	self.unitListType = arg_1_2
	self.loadingIdList = {}
	self.insIdList = {}

	return
end

function IslandBaseBuilder:Build(arg_2_1, arg_2_2)
	local var_2_0 = self:GetModule(self.view, arg_2_1)

	assert(self.unitListType)
	var_2_0:SetUnitType(self.unitListType)

	local var_2_1

	seriesAsync({
		function(arg_3_0)
			self:Load(arg_2_1, function(arg_4_0)
				var_2_1 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			self:LoadTimeline(var_2_1, var_2_0, arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			self:LoadOtherPart(var_2_1, var_2_0, arg_2_1, arg_6_0)

			return
		end
	}, function()
		self:AddTypeAndID(var_2_1, var_2_0)
		self:AddComponents(var_2_1, arg_2_1)
		self:SetTag(var_2_1)
		var_2_0:Init(var_2_1, self)
		existCall(arg_2_2, var_2_0)

		return
	end)

	return var_2_0
end

function IslandBaseBuilder:AddTypeAndID(arg_8_1, arg_8_2)
	local var_8_0 = GetOrAddComponent(arg_8_1, typeof(WorldObjectItem))

	var_8_0.type = arg_8_2:GetUnitType()
	var_8_0.id = arg_8_2.id

	return
end

function IslandBaseBuilder:GetView()
	return self.view
end

function IslandBaseBuilder:GetPoolMgr()
	return self.view:GetPoolMgr()
end

function IslandBaseBuilder:AddLoadingID(arg_11_1)
	table.insert(self.loadingIdList, arg_11_1)

	return
end

function IslandBaseBuilder:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.insIdList) do
		FrameAsyncInstantiateManager.Instance:Cancel(iter_12_1)
	end

	self.insIdList = nil

	for iter_12_2, iter_12_3 in ipairs(self.loadingIdList) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_12_3)
	end

	self.loadingIdList = nil

	return
end

function IslandBaseBuilder:Load(arg_13_1, arg_13_2)
	assert(false, "overwrite !!!")

	return
end

function IslandBaseBuilder:Recycle(arg_14_1, arg_14_2)
	assert(false, "overwrite !!!")

	return
end

function IslandBaseBuilder:GetModule(arg_15_1, arg_15_2)
	assert(false, "overwrite !!!")

	return
end

function IslandBaseBuilder:SetTag(arg_16_1)
	return
end

function IslandBaseBuilder:AddComponents(arg_17_1)
	return
end

function IslandBaseBuilder:LoadTimeline(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_4()

	return
end

function IslandBaseBuilder:LoadOtherPart(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_4()

	return
end

function IslandBaseBuilder:OnDispose()
	return
end

return IslandBaseBuilder
