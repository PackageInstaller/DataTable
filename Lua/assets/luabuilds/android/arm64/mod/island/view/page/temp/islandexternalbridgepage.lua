local var_0_0 = class("IslandExternalBridgePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandEmptyUI"
end

function var_0_0.NeedCache(arg_2_0)
	return false
end

function var_0_0.OnShow(arg_3_0)
	arg_3_0:AddSubLayers(arg_3_0:GetContext())

	return
end

function var_0_0.OnHide(arg_4_0)
	arg_4_0:RemoveSubLayers(arg_4_0:GetContext())

	return
end

function var_0_0.AddSubLayers(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1.data = {
		container = arg_5_0._tf,
		onClose = function()
			arg_5_0:Hide()

			return
		end,
		params = arg_5_2
	}

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_5_1
	})

	return
end

function var_0_0.RemoveSubLayers(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_7_1.mediator)

	if var_7_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_7_0
		})
	end

	return
end

function var_0_0.GetContext(arg_8_0)
	assert(false, "overwrite me")

	return
end

return var_0_0
