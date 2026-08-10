local var_0_0 = singletonClass("RollTipsMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.viewGo_ = nil
	arg_1_0.viewLua_ = nil
	arg_1_0.cachePop_ = false
end

function var_0_0.CreatTips(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.viewGo_ == nil then
		arg_2_0.viewGo_ = Object.Instantiate(Asset.Load("UI/BulletinBoardTips"), manager.ui.dontDestroyCanvas.transform)
		arg_2_0.viewLua_ = RollTipsView.New(arg_2_0.viewGo_)

		arg_2_0.viewLua_:Play(arg_2_1)
	else
		SetActive(arg_2_0.viewGo_, true)
		arg_2_0.viewLua_:Play(arg_2_1)
	end
end

function var_0_0.CreateTimer(arg_3_0)
	if arg_3_0.timer_ == nil then
		arg_3_0.timer_ = Timer.New(function()
			local var_4_0, var_4_1 = BulletinData.GetCurCacheStringAndID()

			arg_3_0:CountTipsAndCreateWithoutTimer(var_4_0, var_4_1)
		end, 300, 2)

		arg_3_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end
end

function var_0_0.SetCachePop(arg_6_0, arg_6_1)
	arg_6_0.cachePop_ = arg_6_1
end

function var_0_0.OnLogout(arg_7_0)
	arg_7_0:StopTimer()
	arg_7_0:Dispose()
end

function var_0_0.CountTipsAndCreate(arg_8_0, arg_8_1, arg_8_2)
	if BulletinData.GetCacheStringIsShowByID(arg_8_2) == false then
		arg_8_0:CreatTips(arg_8_1, arg_8_2)
		BulletinData.SetCacheStringIsShowByID(arg_8_2)
		arg_8_0:CreateTimer()
	end
end

function var_0_0.CountTipsAndCreateWithoutTimer(arg_9_0, arg_9_1, arg_9_2)
	if BulletinData.GetCacheStringIsShowByID(arg_9_2) == false then
		arg_9_0:CreatTips(arg_9_1, arg_9_2)
		BulletinData.SetCacheStringIsShowByID(arg_9_2)
	end
end

function var_0_0.TryToCreatTips(arg_10_0)
	if arg_10_0.cachePop_ == true and BulletinData.GetIslogin() then
		local var_10_0, var_10_1 = BulletinData.GetCurCacheStringAndID()

		if var_10_0 then
			arg_10_0:SetCachePop(false)
			arg_10_0:CountTipsAndCreate(var_10_0, var_10_1)
		end
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.cachePop_ = false

	if arg_11_0.viewGo_ then
		Object.Destroy(arg_11_0.viewGo_)

		arg_11_0.viewGo_ = nil
	end

	if arg_11_0.viewLua_ then
		arg_11_0.viewLua_:Dispose()

		arg_11_0.viewLua_ = nil
	end
end

return var_0_0
