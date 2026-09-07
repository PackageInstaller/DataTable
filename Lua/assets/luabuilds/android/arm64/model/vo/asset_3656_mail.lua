local Mail = class("Mail", import(".BaseMail"))

function Mail:Ctor(arg_1_1)
	Mail.super.Ctor(self, arg_1_1)

	self.readFlag = arg_1_1.read_flag == 2
	self.attachFlag = arg_1_1.attach_flag == 0 or arg_1_1.attach_flag == 2
	self.importantFlag = arg_1_1.imp_flag == 1

	return
end

function Mail:setReadFlag(arg_2_1)
	self.readFlag = arg_2_1

	return
end

function Mail:setImportantFlag(arg_3_1)
	self.importantFlag = arg_3_1

	return
end

function Mail:setAttachFlag(arg_4_1)
	self.attachFlag = arg_4_1

	return
end

return Mail
