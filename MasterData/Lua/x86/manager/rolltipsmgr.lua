local var_0_0 = singletonClass("RollTipsMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.viewGo_ = nil
	arg_1_0.viewLua_ = nil
	arg_1_0.cachePop_ = false
end

function var_0_0:CreatTips(arg_2_1, arg_2_2)
	if self.viewGo_ == nil then
		self.viewGo_ = Object.Instantiate(Asset.Load("UI/BulletinBoardTips"), manager.ui.dontDestroyCanvas.transform)
		self.viewLua_ = RollTipsView.New(self.viewGo_)

		self.viewLua_:Play(arg_2_1)
	else
		SetActive(self.viewGo_, true)
		self.viewLua_:Play(arg_2_1)
	end
end

function var_0_0:CreateTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			local var_4_0, var_4_1 = BulletinData.GetCurCacheStringAndID()

			self:CountTipsAndCreateWithoutTimer(var_4_0, var_4_1)
		end, 300, 2)

		self.timer_:Start()
	end
end

function var_0_0:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function var_0_0.SetCachePop(arg_6_0, arg_6_1)
	arg_6_0.cachePop_ = arg_6_1
end

function var_0_0:OnLogout()
	self:StopTimer()
	self:Dispose()
end

function var_0_0:CountTipsAndCreate(arg_8_1, arg_8_2)
	if BulletinData.GetCacheStringIsShowByID(arg_8_2) == false then
		self:CreatTips(arg_8_1, arg_8_2)
		BulletinData.SetCacheStringIsShowByID(arg_8_2)
		self:CreateTimer()
	end
end

function var_0_0:CountTipsAndCreateWithoutTimer(arg_9_1, arg_9_2)
	if BulletinData.GetCacheStringIsShowByID(arg_9_2) == false then
		self:CreatTips(arg_9_1, arg_9_2)
		BulletinData.SetCacheStringIsShowByID(arg_9_2)
	end
end

function var_0_0:TryToCreatTips()
	if self.cachePop_ == true and BulletinData.GetIslogin() then
		local var_10_0, var_10_1 = BulletinData.GetCurCacheStringAndID()

		if var_10_0 then
			self:SetCachePop(false)
			self:CountTipsAndCreate(var_10_0, var_10_1)
		end
	end
end

function var_0_0:Dispose()
	self.cachePop_ = false

	if self.viewGo_ then
		Object.Destroy(self.viewGo_)

		self.viewGo_ = nil
	end

	if self.viewLua_ then
		self.viewLua_:Dispose()

		self.viewLua_ = nil
	end
end

return var_0_0
