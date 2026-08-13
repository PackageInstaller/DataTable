class = var_0_10000

local var_0_0 = "IslandSelfCardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandEmptyUI"
end

function var_0_1.NeedCache(arg_2_0)
	return false
end

function var_0_1.OnShow(arg_3_0)
	arg_3_0:AddSubLayers(arg_3_0:GetContext())

	return
end

function var_0_1.OnHide(arg_4_0)
	arg_4_0:RemoveSubLayers(arg_4_0:GetContext())

	return
end

function var_0_1.AddSubLayers(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_5_0 = var_1_10002(var_1_10004)
	local var_5_1 = var_2.getCurrentContext(var_5_0)
	local var_5_2 = var_3.getContextByMediator

	IslandMediator = var_1_10007

	local var_5_3 = var_5_2(var_5_1, var_1_10007)

	pg = var_5_0

	local var_5_4 = var_5_0.m02
	local var_5_5 = var_5.sendNotification

	GAME = var_1_10008

	var_5_5(var_5_4, var_1_10008.LOAD_LAYERS, {
		parentContext = var_5_3,
		context = arg_5_1
	})

	return
end

function var_0_1.RemoveSubLayers(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)
	local var_6_1 = var_2.getCurrentContext(var_6_0)

	if var_3.getContextByMediator(var_6_1, arg_6_1.mediator) then
		pg = var_6_0

		local var_6_2 = var_6_0.m02
		local var_6_3 = var_5.sendNotification

		GAME = var_1_10008

		var_6_3(var_6_2, var_1_10008.REMOVE_LAYERS, {
			context = var_4
		})
	end

	return
end

function var_0_1.GetContext(arg_7_0)
	Context = var_1_10001

	local var_7_0 = var_1_10001.New
	local var_7_1 = {}

	IslandSelfCardMediator = var_1_10004
	var_7_1.mediator = var_1_10004
	IslandSelfCardAttach = var_1_10004
	var_7_1.viewComponent = var_1_10004
	var_7_1.data = {
		isIslandPage = true,
		container = arg_7_0._tf,
		onClose = function()
			local var_8_0 = arg_7_0

			var_0.Hide(var_8_0)

			return
		end
	}

	return var_7_0(var_7_1)
end

return var_0_1
