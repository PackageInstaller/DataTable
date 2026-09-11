local var_0_0 = singletonClass("AutoChessActionRendererFactory")

function var_0_0.Init(arg_1_0)
	arg_1_0.poolDicByName = {}
	arg_1_0.cacheDataDic = {}
	arg_1_0.globalId = 0
end

function var_0_0:GetActionRenderer(arg_2_1)
	local var_2_0 = self:GetActionRendererByClassName((AutoChessTools.GetActionRendererClassName(arg_2_1)))

	var_2_0:Init(arg_2_1)

	return var_2_0
end

function var_0_0:GetActionRendererByClassName(arg_3_1)
	self.poolDicByName[arg_3_1] = self.poolDicByName[arg_3_1] or {}

	for iter_3_0, iter_3_1 in ipairs(self.poolDicByName[arg_3_1]) do
		if iter_3_1.isFree then
			iter_3_1.isFree = false

			return iter_3_1.target
		end
	end

	self.globalId = self.globalId + 1

	local var_3_0 = {
		isFree = false,
		target = _G[arg_3_1].New(self.globalId)
	}

	table.insert(self.poolDicByName[arg_3_1], var_3_0)

	self.cacheDataDic[self.globalId] = var_3_0

	return var_3_0.target
end

function var_0_0:RetureActionRenderer(arg_4_1)
	self.cacheDataDic[arg_4_1.id].isFree = true
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.poolDicByName = nil
	arg_5_0.cacheDataDic = nil
end

return var_0_0
