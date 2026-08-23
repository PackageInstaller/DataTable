local SubElem = class("SubElem")

function SubElem:ctor(arg_1_1)
	self._startIndex = arg_1_1
end

function SubElem:getTitle()
	return g.core.lang:get(100024, {
		startIndex = self._startIndex,
		endIndex = self._startIndex + 9
	})
end

function SubElem:getTemplate()
	return "ui://login/LoginSubTabCell"
end

function SubElem:buildServers()
	local var_4_0 = g.core.platform.ServerListProxy:getServerList() or {}

	return (g.core.platform.ServerListProxy:getRangeServer({
		math.max(0, #var_4_0 - self._startIndex - 8),
		#var_4_0 - self._startIndex + 1
	}))
end

function SubElem:getServerTemplate()
	return "ui://login/LoginServerCell"
end

return SubElem
