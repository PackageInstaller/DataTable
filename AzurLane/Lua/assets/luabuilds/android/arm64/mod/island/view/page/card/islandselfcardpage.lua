local var_0_0 = class("IslandSelfCardPage", import("...base.IslandBasePage"))

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

function var_0_0.AddSubLayers(arg_5_0, arg_5_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_5_1
	})

	return
end

function var_0_0.RemoveSubLayers(arg_6_0, arg_6_1)
	local var_6_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_6_1.mediator)

	if var_6_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_6_0
		})
	end

	return
end

function var_0_0.GetContext(arg_7_0)
	return Context.New({
		mediator = IslandSelfCardMediator,
		viewComponent = IslandSelfCardAttach,
		data = {
			isIslandPage = true,
			container = arg_7_0._tf,
			onClose = function()
				arg_7_0:Hide()

				return
			end
		}
	})
end

return var_0_0
