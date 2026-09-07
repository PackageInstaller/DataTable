local IslandMailPage = class("IslandMailPage", import(".IslandExternalBridgePage"))

function IslandMailPage:GetContext()
	return Context.New({
		mediator = MailMediator,
		viewComponent = IslandMailScene
	})
end

return IslandMailPage
