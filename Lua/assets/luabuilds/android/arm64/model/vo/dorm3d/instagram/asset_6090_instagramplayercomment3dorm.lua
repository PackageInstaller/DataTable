local InstagramPlayerComment3Dorm = class("InstagramPlayerComment3Dorm", import(".InstagramComment3Dorm"))

function InstagramPlayerComment3Dorm:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.id = arg_1_1
	self.index = arg_1_2

	InstagramPlayerComment3Dorm.super.Ctor(self, arg_1_3, arg_1_4, arg_1_5, arg_1_6)

	return
end

return InstagramPlayerComment3Dorm
