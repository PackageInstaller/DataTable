local var_0_0 = singletonClass("AutoChessRenderControllerFactory")

function var_0_0.Init(arg_1_0)
	arg_1_0.poolDicByName = {}
	arg_1_0.cacheDataDic = {}
	arg_1_0.globalId = 0
end

function var_0_0.GetRenderController(arg_2_0, arg_2_1)
	local var_2_0 = AutoChessConst.ACTION_RENDER_CONTROLLER_CONFIG[arg_2_1].controllerClassName
	local var_2_1 = arg_2_0:GetRenderControllerByClassName(var_2_0)

	var_2_1:Init(AutoChessBattleRenderer.GetInstance():GetSpeed())

	return var_2_1
end

function var_0_0.GetRenderControllerByClassName(arg_3_0, arg_3_1)
	arg_3_0.poolDicByName[arg_3_1] = arg_3_0.poolDicByName[arg_3_1] or {}

	local var_3_0 = arg_3_0.poolDicByName[arg_3_1]

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1.isFree then
			iter_3_1.isFree = false

			return iter_3_1.target
		end
	end

	arg_3_0.globalId = arg_3_0.globalId + 1

	local var_3_1 = arg_3_0.globalId
	local var_3_2 = _G[arg_3_1].New(var_3_1)
	local var_3_3 = {
		isFree = false,
		target = var_3_2
	}

	table.insert(var_3_0, var_3_3)

	arg_3_0.cacheDataDic[var_3_1] = var_3_3

	return var_3_3.target
end

function var_0_0.RetureRenderController(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.id

	arg_4_0.cacheDataDic[var_4_0].isFree = true
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.poolDicByName = {}
	arg_5_0.cacheDataDic = {}
	arg_5_0.globalId = 0
end

return var_0_0
