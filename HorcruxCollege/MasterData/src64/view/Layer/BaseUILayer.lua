local BaseUILayer = class("BaseUILayer", function()
	return cc.Layer:create()
end)

function BaseUILayer:ctor()
	self.manager = nil
	self.autoAdapt = false

	self:onNodeEvent()
end

function BaseUILayer:associatedManager(arg_3_1)
	self.manager = self.manager or arg_3_1
end

function BaseUILayer:setAutoAdapt(arg_4_1)
	self.autoAdapt = arg_4_1
end

function BaseUILayer:getAutoAdapt()
	return self.autoAdapt
end

function BaseUILayer:create()
	return (BaseUILayer.new())
end

function BaseUILayer:onUpdate(arg_7_1)
	self:scheduleUpdateWithPriorityLua(arg_7_1, 0)

	return self
end

BaseUILayer.scheduleUpdate = BaseUILayer.onUpdate

function BaseUILayer:onNodeEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "enter" then
		self.onEnterCallback_ = arg_8_2
	elseif arg_8_1 == "exit" then
		self.onExitCallback_ = arg_8_2
	elseif arg_8_1 == "enterTransitionFinish" then
		self.onEnterTransitionFinishCallback_ = arg_8_2
	elseif arg_8_1 == "exitTransitionStart" then
		self.onExitTransitionStartCallback_ = arg_8_2
	elseif arg_8_1 == "cleanup" then
		self.onCleanupCallback_ = arg_8_2
	end

	self:enableNodeEvents()
end

function BaseUILayer:enableNodeEvents()
	if self.isNodeEventEnabled_ then
		return self
	end

	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "enter" then
			self:onEnter_()
		elseif arg_10_0 == "exit" then
			self:onExit_()
		elseif arg_10_0 == "enterTransitionFinish" then
			self:onEnterTransitionFinish_()
		elseif arg_10_0 == "exitTransitionStart" then
			self:onExitTransitionStart_()
		elseif arg_10_0 == "cleanup" then
			self:onCleanup_()
		end
	end)

	self.isNodeEventEnabled_ = true

	return self
end

function BaseUILayer:disableNodeEvents()
	self:unregisterScriptHandler()

	self.isNodeEventEnabled_ = false

	return self
end

function BaseUILayer:onEnter()
	if self.autoAdapt then
		self:moveBottom()
	end

	if self.manager and self.manager.layerOnEnter then
		self.manager:layerOnEnter(self)
	end
end

function BaseUILayer:onExit()
	if self.manager and self.manager.layerOnExit then
		self.manager:layerOnExit()
	end
end

function BaseUILayer:onEnterTransitionFinish()
	return
end

function BaseUILayer:onExitTransitionStart()
	return
end

function BaseUILayer:onCleanup()
	return
end

function BaseUILayer:onEnter_()
	self:onEnter()

	if not self.onEnterCallback_ then
		return
	end

	self:onEnterCallback_()
end

function BaseUILayer:onExit_()
	self:onExit()

	if not self.onExitCallback_ then
		return
	end

	self:onExitCallback_()
end

function BaseUILayer:onEnterTransitionFinish_()
	self:onEnterTransitionFinish()

	if not self.onEnterTransitionFinishCallback_ then
		return
	end

	self:onEnterTransitionFinishCallback_()
end

function BaseUILayer:onExitTransitionStart_()
	self:onExitTransitionStart()

	if not self.onExitTransitionStartCallback_ then
		return
	end

	self:onExitTransitionStartCallback_()
end

function BaseUILayer:onCleanup_()
	self:onCleanup()

	if not self.onCleanupCallback_ then
		return
	end

	self:onCleanupCallback_()
end

function BaseUILayer:moveBottom()
	local var_22_0 = self:getParent()

	if var_22_0 then
		local var_22_1 = var_22_0:convertToWorldSpace((cc.p(self:getPosition())))

		self:setPosition(cc.p(var_22_1.x, -var_22_1.y))
	end
end

return BaseUILayer
