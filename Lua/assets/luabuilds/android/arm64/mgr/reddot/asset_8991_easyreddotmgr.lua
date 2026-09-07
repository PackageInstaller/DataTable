pg = pg or {}
pg.EasyRedDotMgr = singletonClass("EasyRedDotMgr")

function pg.EasyRedDotMgr.Init(arg_1_0, arg_1_1)
	arg_1_0.registerDic = {}
	arg_1_0.markDic = {}

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function pg.EasyRedDotMgr:RegisterRedDot(arg_2_1, arg_2_2, arg_2_3)
	if self.registerDic[arg_2_1] then
		self:UnRegisterRedDot(arg_2_1)
	end

	self.registerDic[arg_2_1] = {
		arg_2_2,
		arg_2_3
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
		self.markDic[iter_2_1] = self.markDic[iter_2_1] or {}
		self.markDic[iter_2_1][arg_2_1] = true
	end

	arg_2_3(arg_2_1)

	return
end

function pg.EasyRedDotMgr:UnRegisterRedDot(arg_3_1)
	if not self.registerDic[arg_3_1] then
		return
	end

	local var_3_0, var_3_1 = unpack(self.registerDic[arg_3_1])

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		self.markDic[iter_3_1][arg_3_1] = nil
	end

	self.registerDic[arg_3_1] = nil

	return
end

function pg.EasyRedDotMgr:TriggerMarks(...)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs({
		...
	}) do
		for iter_4_2, iter_4_3 in pairs(self.markDic[iter_4_1] or {}) do
			if IsNil(iter_4_2) then
				var_4_0[iter_4_2] = false
			elseif iter_4_3 then
				var_4_0[iter_4_2] = true
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_0) do
		if iter_4_5 then
			self.registerDic[iter_4_4][2](iter_4_4)
		else
			self:UnRegisterRedDot(iter_4_4)
		end
	end

	return
end

return
