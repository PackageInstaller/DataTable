local AgoraMouldBuilder = class("AgoraMouldBuilder", import("Mod.Island.Core.Builder.IslandGenericBuilder"))

function AgoraMouldBuilder:Ctor(arg_1_1, arg_1_2)
	AgoraMouldBuilder.super.Ctor(self, arg_1_1, arg_1_2)

	self.root = arg_1_1.furnitureRoot

	return
end

function AgoraMouldBuilder:Build(arg_2_1, arg_2_2)
	local var_2_0 = self:GetPoolMgr():GetAgoraRoot()

	setParent(var_2_0, self.root)

	local var_2_1 = self:GetModule(var_2_0, arg_2_1)

	assert(self.unitListType)
	var_2_1:SetUnitType(self.unitListType)

	local var_2_2

	seriesAsync({
		function(arg_3_0)
			self:Load(arg_2_1, function(arg_4_0)
				var_2_2 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			self:SetupBT(var_2_0, arg_2_1:GetBt(), arg_5_0)

			return
		end
	}, function()
		self:AddTypeAndID(var_2_0, var_2_1)
		self:AddComponents(var_2_0, arg_2_1)
		self:SetTag(var_2_0)
		var_2_1:Init(var_2_2, self)
		existCall(arg_2_2, var_2_1)

		return
	end)

	return var_2_1
end

function AgoraMouldBuilder:GetModule(arg_7_1, arg_7_2)
	return AgoraFurnitrueMould.New(self.view, arg_7_1, arg_7_2)
end

function AgoraMouldBuilder:Load(arg_8_1, arg_8_2)
	self:GetPoolMgr():GetAgoraObj(arg_8_1:GetResPath(), arg_8_2)

	return
end

function AgoraMouldBuilder:Recycle(arg_9_1, arg_9_2)
	if arg_9_2 then
		self:GetPoolMgr():ReturnAgoraObj(arg_9_1:GetResPath(), arg_9_2)
	end

	return
end

function AgoraMouldBuilder:RecycleRoot(arg_10_1)
	self:GetPoolMgr():ReturnAgoraRoot(arg_10_1)

	return
end

return AgoraMouldBuilder
