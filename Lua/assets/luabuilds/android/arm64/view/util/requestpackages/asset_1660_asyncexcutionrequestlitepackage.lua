local AsyncExcutionRequestLitePackage = class("AsyncExcutionRequestLitePackage", import(".RequestPackage"))

AsyncExcutionRequestLitePackage.STATUS = {
	SUSPEND = 2,
	RUNNING = 3,
	READY = 1
}

function AsyncExcutionRequestLitePackage:__call(...)
	if self.stopped then
		return
	end

	if not self.funcs or #self.funcs == 0 then
		return
	end

	self:Excute()

	return
end

function AsyncExcutionRequestLitePackage:Resume()
	self.targetStatus = AsyncExcutionRequestLitePackage.STATUS.READY

	if self.status == AsyncExcutionRequestLitePackage.STATUS.SUSPEND then
		self:Excute()
	end

	return
end

function AsyncExcutionRequestLitePackage:Suspend()
	self.targetStatus = AsyncExcutionRequestLitePackage.STATUS.SUSPEND

	return
end

function AsyncExcutionRequestLitePackage:Ctor(arg_4_1)
	self.funcs = arg_4_1 or {}
	self.status = AsyncExcutionRequestLitePackage.STATUS.READY
	self.targetStatus = AsyncExcutionRequestLitePackage.STATUS.READY

	return
end

function AsyncExcutionRequestLitePackage:Insert(arg_5_1)
	table.insert(self.funcs, arg_5_1)

	return
end

function AsyncExcutionRequestLitePackage:Excute()
	assert(self.ready)

	if not self.ready then
		return
	end

	local function var_6_1(...)
		if self.stopped then
			return
		end

		if self.suspended or not self.funcs or #self.funcs <= 0 then
			self.ready = true

			return
		end

		self.ready = nil

		table.remove(self.funcs, 1)(var_6_1, ...)

		return
	end

	;(nil)()

	return
end

return AsyncExcutionRequestLitePackage
