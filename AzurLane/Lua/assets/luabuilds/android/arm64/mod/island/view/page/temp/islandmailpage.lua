local var_0_0 = class("IslandMailPage", import(".IslandExternalBridgePage"))

function var_0_0.GetContext(arg_1_0)
	return Context.New({
		mediator = MailMediator,
		viewComponent = IslandMailScene
	})
end

return var_0_0
