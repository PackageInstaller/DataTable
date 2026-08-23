local Entry = class("Entry")

function Entry:ctor(arg_1_1)
	self.__isEntry = true
	self._autoRelease = arg_1_1 ~= false
	self._pause = false
	self._pauseFrame = 0

	self:initEntry()
end

function Entry:initEntry()
	self._queueList = {}
	self._parallelList = {}
end

function Entry:addEntryToQueue(arg_3_1, arg_3_2)
	assert(type(arg_3_2) == "function", "stepFunc must be function ")

	self._queueList[#self._queueList + 1] = {
		entry = arg_3_1,
		stepFunc = arg_3_2
	}
end

function Entry:addEntryToNewQueue(arg_4_1, arg_4_2)
	assert(type(arg_4_2) == "function", "stepFunc must be function")

	local var_4_0 = false

	for iter_4_0 = 1, #self._parallelList do
		if self._parallelList[iter_4_0].entry == arg_4_1 and arg_4_2 == self._parallelList[iter_4_0].stepFunc then
			var_4_0 = true

			break
		end
	end

	if var_4_0 == true then
		return
	end

	self._parallelList[#self._parallelList + 1] = {
		entry = arg_4_1,
		stepFunc = arg_4_2
	}
end

function Entry:updateEntry()
	if self:isDone() then
		if self._autoRelease then
			self:destroyEntry()
		end

		return true
	end

	if self._pause then
		return false
	end

	if self._pauseFrame > 0 then
		self._pauseFrame = self._pauseFrame - 1

		return false
	end

	local var_5_0

	for iter_5_0 = 1, #self._parallelList do
		if self._parallelList[iter_5_0].stepFunc(self._parallelList[iter_5_0].entry) == true then
			var_5_0 = var_5_0 or {}
			var_5_0[#var_5_0 + 1] = iter_5_0
		end
	end

	if var_5_0 ~= nil then
		for iter_5_1 = #var_5_0, 1, -1 do
			table.remove(self._parallelList, var_5_0[iter_5_1])
		end
	end

	local var_5_1 = self._queueList[1]

	while var_5_1 ~= nil and not var_5_1.entry do
		var_5_1.stepFunc()
		table.remove(self._queueList, 1)

		var_5_1 = self._queueList[1]
	end

	if var_5_1 ~= nil and var_5_1.stepFunc(var_5_1.entry) == true then
		table.remove(self._queueList, 1)

		local var_5_2 = self._queueList[1]

		while var_5_2 ~= nil and not var_5_2.entry do
			var_5_2.stepFunc()
			table.remove(self._queueList, 1)

			var_5_2 = self._queueList[1]
		end
	end

	local var_5_3 = self:isDone()

	if var_5_3 and self._autoRelease then
		self:destroyEntry()
	end

	return var_5_3
end

function Entry:isDone()
	return (self._queueList == nil or #self._queueList < 1) and (self._parallelList == nil or #self._parallelList < 1)
end

function Entry:pause()
	self._pause = true
end

function Entry:resume()
	self._pause = false
end

function Entry:pauseFrames(arg_9_1)
	self._pauseFrame = arg_9_1 or 0
end

function Entry:clearAll()
	local var_10_0 = {}

	local function var_10_1(arg_11_0)
		if arg_11_0 == nil or #arg_11_0 < 1 then
			return
		end

		for iter_11_0 = #arg_11_0, 1, -1 do
			if arg_11_0[iter_11_0].entry ~= nil and arg_11_0[iter_11_0].entry.__isEntry and table.indexof(var_10_0, arg_11_0[iter_11_0].entry) == false then
				var_10_0[#var_10_0 + 1] = arg_11_0[iter_11_0].entry
			end

			table.remove(arg_11_0, iter_11_0)
		end
	end

	var_10_1(self._queueList)
	var_10_1(self._parallelList)

	for iter_10_0 = #var_10_0, 1, -1 do
		var_10_0[iter_10_0]:destroyEntry()
		table.remove(var_10_0, iter_10_0)
	end

	var_10_0 = nil
end

function Entry:destroyEntry()
	self:clearAll()

	self._queueList = nil
	self._parallelList = nil
end

function Entry:forceClear()
	self._queueList = {}
	self._parallelList = {}
end

return Entry
