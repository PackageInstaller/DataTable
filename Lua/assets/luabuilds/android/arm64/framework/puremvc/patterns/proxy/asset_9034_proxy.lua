local Proxy = class("Proxy", (import("..observer.Notifier")))

function Proxy:Ctor(arg_1_1, arg_1_2)
	if arg_1_1 ~= nil then
		self:setData(arg_1_1)
	end

	local var_1_0

	if not arg_1_2 then
		::label_1_0::

		var_1_0 = self.__cname or Proxy.NAME
	end

	self.proxyName = var_1_0

	return
end

Proxy.NAME = "Proxy"

function Proxy:getProxyName()
	return self.proxyName
end

function Proxy:setData(arg_3_1)
	self.data = arg_3_1

	return
end

function Proxy:getData()
	return self.data
end

function Proxy:onRegister()
	return
end

function Proxy:onRemove()
	return
end

return Proxy
