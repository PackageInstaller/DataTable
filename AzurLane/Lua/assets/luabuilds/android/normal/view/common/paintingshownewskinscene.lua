class = var_0_10000

local var_0_0 = "PaintingShowNewSkinScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.common.PaintingShowScene"))

function var_0_1.AddSubLayers(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = var_2.getCurrentContext(var_1_0)
	local var_1_2 = var_3.getContextByMediator

	LatestSkinShopMediator = var_1_10006

	local var_1_3 = var_1_2(var_1_1, var_1_10006)

	pg = var_1_1

	local var_1_4 = var_1_1.m02
	local var_1_5 = var_5.sendNotification

	GAME = var_1_10007

	var_1_5(var_1_4, var_1_10007.LOAD_LAYERS, {
		parentContext = var_1_3,
		context = arg_1_1
	})

	return
end

function var_0_1.closeView(arg_2_0)
	if arg_2_0.loading then
		return
	end

	local var_2_1

	if not arg_2_0.skinLayerAdded then
		arg_2_0.skinLayerAdded = true

		local var_2_0 = arg_2_0

		var_2_1 = arg_2_0.AddSubLayers
		Context = var_1_10003

		local var_2_2 = var_1_10003.New
		local var_2_3 = {}

		NewSkinMediator = var_1_10005
		var_2_3.mediator = var_1_10005
		NewSkinLayer = var_1_10005
		var_2_3.viewComponent = var_1_10005
		var_2_3.data = {
			skinId = arg_2_0.contextData.skinId,
			timeLimit = arg_2_0.contextData.timeLimit
		}

		var_2_1(var_2_0, var_2_2(var_2_3))
	end

	seriesAsync = var_2_1

	var_2_1({
		function(arg_3_0)
			onDelayTick = var_2_10001

			var_2_10001(arg_3_0, 1)

			return
		end
	}, function()
		var_0_1.super.closeView(arg_2_0)

		return
	end)

	return
end

return var_0_1
