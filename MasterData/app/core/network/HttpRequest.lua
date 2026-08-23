local HttpRequest = class("HttpRequest")

HttpRequest.SEND_NONE = 0
HttpRequest.SEND_PROCESSING = 1
HttpRequest.SEND_SUCCESS = 2
HttpRequest.SEND_FAIL = 3
HttpRequest.SEND_ABORT = 4

function HttpRequest:ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	assert(type(arg_1_1) == "string" and string.find(arg_1_1, "http"), "Invalid url: " .. tostring(arg_1_1))
	assert(not arg_1_2 or arg_1_2 == "GET" or arg_1_2 == "POST", "Invalid http request type: " .. tostring(arg_1_2))
	assert(type(arg_1_3) == "table", "Invalid response handler: " .. tostring(arg_1_3))

	self._url = arg_1_1
	self._reqType = arg_1_2 or "GET"
	self._responseHandler = arg_1_3
	self._timeout = 15
	self._isAborted = false
	self._state = HttpRequest.SEND_NONE

	local var_1_0 = cc.XMLHttpRequest:new()

	var_1_0.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	var_1_0:open(self._reqType, self._url)

	if arg_1_4 then
		if arg_1_4.headers ~= nil then
			print("headers:")
			dump(arg_1_4.headers)

			for iter_1_0, iter_1_1 in pairs(arg_1_4.headers) do
				var_1_0:setRequestHeader(iter_1_0, iter_1_1)
			end
		end

		local var_1_1 = arg_1_4.jsonBody

		if arg_1_4.jsonBody ~= nil then
			print("jsonBody : " .. var_1_1)
			var_1_0:send(var_1_1)
		end
	end

	self._reqInstance = var_1_0

	var_1_0:registerScriptHandler(handler(self, self._onReadyStateChanged))
end

function HttpRequest:abort()
	if self._reqInstance then
		self._reqInstance:abort()
	end

	self._state = HttpRequest.SEND_ABORT

	if self._responseHandler and self._responseHandler.cancel then
		self._responseHandler.cancel(nil, nil, self)
	end
end

function HttpRequest:setTimeout(arg_3_1)
	self._timeout = arg_3_1
end

function HttpRequest:send(arg_4_1)
	if not self._reqInstance then
		return
	end

	if self._state == HttpRequest.SEND_PROCESSING or self._state == HttpRequest.SEND_ABORT then
		return
	end

	self._reqInstance:send(arg_4_1)

	self._state = HttpRequest.SEND_PROCESSING

	self:_countdown()
end

function HttpRequest:isDone()
	return self._state == HttpRequest.SEND_SUCCESS or self._state == HttpRequest.SEND_FAIL or self._state == HttpRequest.SEND_ABORT
end

function HttpRequest:_onReadyStateChanged()
	if not self._reqInstance then
		return
	end

	self:_cancelCountdown()

	if self._reqInstance.readyState == 4 and self._reqInstance.status >= 200 and self._reqInstance.status < 207 then
		self._state = HttpRequest.SEND_SUCCESS

		if self._responseHandler and self._responseHandler.success then
			self._responseHandler.success(self._reqInstance.response, {
				readyState = self._reqInstance.readyState,
				status = self._reqInstance.status
			}, self)
		end
	else
		self._state = HttpRequest.SEND_FAIL

		if self._responseHandler.fail then
			self._responseHandler.fail(nil, {
				readyState = self._reqInstance.readyState,
				status = self._reqInstance.status
			}, self)
		end
	end
end

function HttpRequest:_countdown()
	self:_cancelCountdown()

	self._scheduleHandler = g.core.common.Scheduler:newScheduleOnce(function()
		self:abort()
	end, self._timeout)
end

function HttpRequest:_cancelCountdown()
	if self._scheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

return HttpRequest
