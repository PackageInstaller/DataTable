local var_0_0 = class("IslandOtherCardPage", import(".IslandSelfCardPage"))

function var_0_0.OnShow(arg_1_0, arg_1_1)
	arg_1_0.userId = arg_1_1

	var_0_0.super.OnShow(arg_1_0)

	return
end

function var_0_0.GetContext(arg_2_0)
	return Context.New({
		mediator = IslandOtherCardMediator,
		viewComponent = IslandOtherCardAttach,
		data = {
			isIslandPage = true,
			container = arg_2_0._tf,
			onClose = function()
				arg_2_0:Hide()

				return
			end,
			userId = arg_2_0.userId
		}
	})
end

return var_0_0
