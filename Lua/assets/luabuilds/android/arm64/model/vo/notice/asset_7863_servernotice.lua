local ServerNotice = class("ServerNotice", import(".Notice"))

function ServerNotice:Ctor(arg_1_1)
	ServerNotice.super.Ctor(self, arg_1_1)

	self.version = arg_1_1.version
	self.btnTitle = arg_1_1.btn_title
	self.titleImage = arg_1_1.title_image
	self.timeDes = arg_1_1.time_desc
	self.type = arg_1_1.tag_type
	self.icon = arg_1_1.icon
	self.track = arg_1_1.track
	self.priority = arg_1_1.priority
	self.need_level = arg_1_1.need_level

	local var_1_0 = string.split(self.title, "&")

	if #var_1_0 > 1 then
		self.title = var_1_0[1]
		self.pageTitle = var_1_0[2]
	else
		self.title = var_1_0[1]
		self.pageTitle = var_1_0[1]
	end

	local var_1_1 = string.match(self.titleImage, "<config.*/>")

	self.paramType = var_1_1 and tonumber(string.match(var_1_1, "type%s*=%s*(%d+)")) or nil

	if self.paramType then
		if self.paramType == 1 then
			self.param = string.match(var_1_1, "param%s*=%s*'(.*)'")
		elseif self.paramType == 2 then
			self.param = string.match(var_1_1, "param%s*=%s*'(.*)'")
		elseif self.paramType == 3 then
			self.param = string.match(var_1_1, "param%s*=%s*(%d+)")
			self.param = self.param and tonumber(self.param) or self.param
		elseif self.paramType == 4 then
			self.param = string.match(var_1_1, "param%s*=%s*(%d+)")
			self.param = self.param and tonumber(self.param) or self.param
		end
	end

	if var_1_1 then
		local var_1_2, var_1_3 = string.find(self.titleImage, var_1_1, 1, true)

		self.titleImage = string.sub(self.titleImage, var_1_3 + 1, -1)
	end

	self.code = self:prefKey()

	return
end

function ServerNotice:ShouldShow()
	return getProxy(PlayerProxy):getRawData().level > self.need_level
end

function ServerNotice:prefKey()
	return "ServerNotice" .. self.id
end

return ServerNotice
