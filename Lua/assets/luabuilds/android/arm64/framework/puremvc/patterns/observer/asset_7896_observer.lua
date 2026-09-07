local Observer = class("Observer")

function Observer:Ctor(arg_1_1, arg_1_2)
	self:setNotifyMethod(arg_1_1)
	self:setNotifyContext(arg_1_2)

	return
end

function Observer:setNotifyMethod(arg_2_1)
	self.notify = arg_2_1

	return
end

function Observer:setNotifyContext(arg_3_1)
	self.context = arg_3_1

	return
end

function Observer:getNotifyMethod()
	return self.notify
end

function Observer:getNotifyContext()
	return self.context
end

function Observer:notifyObserver(arg_6_1)
	self.notify(self.context, arg_6_1)

	return
end

function Observer:compareNotifyContext(arg_7_1)
	return arg_7_1 == self.context
end

return Observer
