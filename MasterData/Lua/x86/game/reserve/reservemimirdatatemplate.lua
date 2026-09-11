local ReserveMimirDataTemplate = class("ReserveMimirDataTemplate")

function ReserveMimirDataTemplate:Ctor()
	self.mimir_id = 0
	self.chip_list = {}
end

function ReserveMimirDataTemplate:UpdateServerData(arg_2_1)
	self.mimir_id = arg_2_1.mimir_id
	self.chip_list = cleanProtoTable(arg_2_1.chip_list)
end

function ReserveMimirDataTemplate:ConvertToSendData()
	return {
		mimir_id = self.mimir_id,
		chip_list = clone(self.chip_list)
	}
end

function ReserveMimirDataTemplate:Reset()
	self.mimir_id = 0
	self.chip_list = {}
end

return ReserveMimirDataTemplate
