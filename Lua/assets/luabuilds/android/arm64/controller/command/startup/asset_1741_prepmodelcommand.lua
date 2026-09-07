local PrepModelCommand = class("PrepModelCommand", pm.SimpleCommand)

function PrepModelCommand:execute(arg_1_1)
	self.facade:registerProxy(ContextProxy.New({}))
	self.facade:registerProxy(ServerProxy.New({}))
	self.facade:registerProxy(UserProxy.New())
	self.facade:registerProxy(GatewayNoticeProxy.New())
	self.facade:registerProxy(SettingsProxy.New())

	return
end

return PrepModelCommand
