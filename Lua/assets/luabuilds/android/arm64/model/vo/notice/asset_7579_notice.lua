local Notice = class("Notice", import("..BaseVO"))

function Notice:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.title = arg_1_1.title
	self.content = arg_1_1.content
	self.isRead = PlayerPrefs.GetInt(self:prefKey()) == 1

	return
end

function Notice:prefKey()
	return "notice" .. self.id
end

function Notice:markAsRead()
	if not self.isRead then
		self.isRead = true

		PlayerPrefs.SetInt(self:prefKey(), 1)
		PlayerPrefs.Save()
	end

	return
end

function Notice:getUniqueCode()
	local var_4_1 = (self.title or "*") .. self.id .. (self.content or "*")
	local var_4_2 = string.len((self.title or "*") .. self.id .. (self.content or "*"))
	local var_4_3 = var_4_2

	for iter_4_0 = 1, var_4_2, math.floor(var_4_2 / math.min(10, var_4_2)) do
		var_4_3 = var_4_3 + string.byte(var_4_1, iter_4_0)
	end

	return var_4_3
end

return Notice
