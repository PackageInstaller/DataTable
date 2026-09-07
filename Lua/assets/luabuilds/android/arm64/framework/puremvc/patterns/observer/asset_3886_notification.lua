local Notification = class("Notification")

function Notification:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.name = arg_1_1
	self.body = arg_1_2
	self.type = arg_1_3

	return
end

function Notification:getName()
	return self.name
end

function Notification:setBody(arg_3_1)
	self.body = arg_3_1

	return
end

function Notification:getBody()
	return self.body
end

function Notification:setType(arg_5_1)
	self.type = arg_5_1

	return
end

function Notification:getType()
	return self.type
end

function Notification:toString()
	return (("Notification Name: " .. self:getName()) .. "\nBody: " .. tostring(self:getBody())) .. "\nType: " .. self:getType()
end

return Notification
