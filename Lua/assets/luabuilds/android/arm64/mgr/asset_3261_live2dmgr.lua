pg = pg or {}
pg.Live2DMgr = singletonClass("Live2DMgr")

function pg.Live2DMgr.Ctor(arg_1_0)
	arg_1_0.loadingDic = {}
	arg_1_0.nameList = {}

	return
end

function pg.Live2DMgr:GetLive2DModelAsync(arg_2_1, arg_2_2)
	table.insert(self.nameList, arg_2_1)

	local var_2_0 = #self.nameList

	self.loadingDic[arg_2_1] = #self.nameList

	PoolMgr.GetInstance():GetLive2D(arg_2_1, true, function(arg_3_0)
		if self.loadingDic[arg_2_1] ~= var_2_0 then
			warning("l2d loaded dispose return  " .. arg_2_1)
			PoolMgr.GetInstance():ReturnLive2D(arg_2_1, arg_3_0)
		end

		self.loadingDic[arg_2_1] = nil

		existCall(arg_2_2, arg_3_0)

		return
	end)

	return
end

function pg.Live2DMgr.ReturnLive2DModel(arg_4_0, arg_4_1, arg_4_2)
	PoolMgr.GetInstance():ReturnLive2D(arg_4_1, arg_4_2)

	return
end

function pg.Live2DMgr:StopLoadingLive2d(arg_5_1)
	if self.loadingDic[self.nameList[arg_5_1]] == arg_5_1 then
		self.loadingDic[self.nameList[arg_5_1]] = nil
	end

	return
end

return
