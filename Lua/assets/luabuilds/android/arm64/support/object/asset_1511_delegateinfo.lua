pg = pg or {}

local DelegateInfo = class("DelegateInfo")

pg.DelegateInfo = DelegateInfo
DelegateInfo.ClientsInfo = {}

function DelegateInfo:Ctor(arg_1_1)
	DelegateInfo.ClientsInfo[arg_1_1] = self
	self.events = {}

	return
end

function DelegateInfo:Add(arg_2_1)
	if self == nil then
		return
	end

	local var_2_0 = DelegateInfo.ClientsInfo[self]

	assert(DelegateInfo.ClientsInfo[self], "没有初始化委托处理" .. self.__cname)

	if var_2_0 then
		var_2_0:AddEventOb(arg_2_1)
	end

	return
end

function DelegateInfo:AddEventOb(arg_3_1)
	self.events[arg_3_1] = true

	return
end

function DelegateInfo:Dispose()
	assert(DelegateInfo.ClientsInfo[self], "没有初始化委托处理" .. self.__cname)

	if DelegateInfo.ClientsInfo[self] then
		DelegateInfo.ClientsInfo[self]:Clear()
	end

	DelegateInfo.ClientsInfo[self] = nil

	return
end

function DelegateInfo:Clear()
	for iter_5_0, iter_5_1 in pairs(self.events) do
		iter_5_0:RemoveAllListeners()
	end

	self.events = nil

	return
end

return
