local RouteComponent = class("RouteComponent")

function RouteComponent:Ctor(arg_1_1)
	self.vueRoute_ = arg_1_1
end

function RouteComponent:AsyncInit()
	return
end

function RouteComponent:Init()
	return
end

function RouteComponent:OnEnter()
	return
end

function RouteComponent:OnExit()
	return
end

function RouteComponent:OnUpdate()
	return
end

function RouteComponent:OnTop()
	return
end

function RouteComponent:OnBehind()
	return
end

function RouteComponent:Dispose()
	return
end

function RouteComponent:AdaptScreen()
	return
end

function RouteComponent:Go(arg_11_1)
	self.vueRoute_:Go(arg_11_1)
end

function RouteComponent:Back()
	self.vueRoute_:Back()
end

return RouteComponent
