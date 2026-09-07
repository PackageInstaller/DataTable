local NetProxy = class("NetProxy", pm.Proxy)

function NetProxy:onRegister()
	self.event = {}

	self:register()

	return
end

function NetProxy:register()
	return
end

function NetProxy:on(arg_3_1, arg_3_2)
	pg.ConnectionMgr.GetInstance():On(arg_3_1, function(arg_4_0)
		arg_3_2(arg_4_0)

		return
	end)
	table.insert(self.event, arg_3_1)

	return
end

function NetProxy:onRemove()
	self:remove()

	for iter_5_0, iter_5_1 in ipairs(self.event) do
		pg.ConnectionMgr.GetInstance():Off(iter_5_1)
	end

	return
end

function NetProxy:remove()
	return
end

function NetProxy:getRawData()
	return self.data
end

function NetProxy:getData()
	return Clone(self.data)
end

function NetProxy:timeCall()
	return {}
end

return NetProxy
