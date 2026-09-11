local EventListener = class("EventListener")

function EventListener:Ctor()
	self.listeners = {}
end

function EventListener:Register(arg_2_1, arg_2_2)
	self:Remove(arg_2_1)

	self.listeners[arg_2_1] = arg_2_2

	manager.notify:RegistListener(arg_2_1, arg_2_2)
end

function EventListener:Remove(arg_3_1)
	if self.listeners[arg_3_1] then
		manager.notify:RemoveListener(arg_3_1, self.listeners[arg_3_1])
	end
end

function EventListener:RemoveAll()
	for iter_4_0, iter_4_1 in pairs(self.listeners) do
		manager.notify:RemoveListener(iter_4_0, iter_4_1)

		self.listeners[iter_4_0] = nil
	end
end

return EventListener
