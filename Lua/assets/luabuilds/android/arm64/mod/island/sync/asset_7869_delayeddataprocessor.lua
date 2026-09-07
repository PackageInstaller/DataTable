local DelayedDataProcesseor = class("DelayedDataProcesseor")

function DelayedDataProcesseor:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.delayedDataDic = {}
	self.preTimeStampDic = {}
	self.delayedTime = arg_1_1
	self.intervalTime = arg_1_2
	self.func = arg_1_3

	return
end

function DelayedDataProcesseor:Add(arg_2_1, arg_2_2)
	local var_2_0

	if self.preTimeStampDic[arg_2_1] then
		var_2_0 = math.min(self.preTimeStampDic[arg_2_1] + self.intervalTime, pg.TimeMgr.GetInstance():GetServerTimeMs() + self.delayedTime)
	else
		self.delayedDataDic[arg_2_1] = {}
		var_2_0 = pg.TimeMgr.GetInstance():GetServerTimeMs() + self.delayedTime
	end

	table.insert(self.delayedDataDic[arg_2_1], {
		data = arg_2_2,
		timeStamp = var_2_0
	})

	self.preTimeStampDic[arg_2_1] = var_2_0

	return
end

function DelayedDataProcesseor:Update()
	local var_3_0 = pg.TimeMgr.GetInstance():GetServerTimeMs()

	for iter_3_0, iter_3_1 in pairs(self.delayedDataDic) do
		if #iter_3_1 > 0 and var_3_0 >= iter_3_1[1].timeStamp then
			xpcall(function()
				self.func(iter_3_1[1].data)

				return
			end, function(...)
				errorMsg(debug.traceback(...))

				return
			end)
			table.remove(iter_3_1, 1)
		end
	end

	return
end

function DelayedDataProcesseor:RemoveDataById(arg_6_1)
	if self.delayedDataDic[arg_6_1] then
		self.delayedDataDic[arg_6_1] = nil
	end

	if self.preTimeStampDic[arg_6_1] then
		self.preTimeStampDic[arg_6_1] = nil
	end

	return
end

function DelayedDataProcesseor:Dispose()
	return
end

return DelayedDataProcesseor
