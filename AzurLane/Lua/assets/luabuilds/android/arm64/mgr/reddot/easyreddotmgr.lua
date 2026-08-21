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

function pg.EasyRedDotMgr.RegisterRedDot(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.registerDic[arg_2_1] then
		arg_2_0:UnRegisterRedDot(arg_2_1)
	end

	arg_2_0.registerDic[arg_2_1] = {
		arg_2_2,
		arg_2_3
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
		arg_2_0.markDic[iter_2_1] = arg_2_0.markDic[iter_2_1] or {}
		arg_2_0.markDic[iter_2_1][arg_2_1] = true
	end

	arg_2_3(arg_2_1)

	return
end

function pg.EasyRedDotMgr.UnRegisterRedDot(arg_3_0, arg_3_1)
	if not arg_3_0.registerDic[arg_3_1] then
		return
	end

	local var_3_0, var_3_1 = unpack(arg_3_0.registerDic[arg_3_1])

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		arg_3_0.markDic[iter_3_1][arg_3_1] = nil
	end

	arg_3_0.registerDic[arg_3_1] = nil

	return
end

function pg.EasyRedDotMgr.TriggerMarks(arg_4_0, ...)
	for iter_4_0, iter_4_1 in ipairs({
		...
	}) do
		local var_4_0 = arg_4_0.markDic[iter_4_1] or {}

		for iter_4_2, iter_4_3 in pairs(var_4_0) do
			if IsNil(iter_4_2) then
				({})[iter_4_2] = false
			elseif iter_4_3 then
				({})[iter_4_2] = true
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs({}) do
		if iter_4_5 then
			arg_4_0.registerDic[iter_4_4][2](iter_4_4)
		else
			arg_4_0:UnRegisterRedDot(iter_4_4)
		end
	end

	return
end

return
