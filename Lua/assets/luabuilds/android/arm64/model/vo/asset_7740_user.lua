local User = class("User", import(".BaseVO"))

function User:Ctor(arg_1_1)
	self.type = arg_1_1.type
	self.arg1 = arg_1_1.arg1
	self.arg2 = arg_1_1.arg2
	self.arg3 = arg_1_1.arg3
	self.arg4 = arg_1_1.arg4
	self.id = arg_1_1.uid
	self.uid = arg_1_1.uid
	self.token = arg_1_1.token
	self.server = arg_1_1.server

	return
end

function User:isLogin()
	return tobool(self.uid and self.server and self.token)
end

function User:clear()
	self.id = nil
	self.uid = nil
	self.token = nil
	self.server = nil

	return
end

return User
