local GameContext = class("GameContext", (import("library.router.VueRouter")))

function GameContext:Ctor(...)
	GameContext.super.Ctor(self, ...)

	self.waitLoadUrlList_ = {}
end

function GameContext:Go(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	GameContext.super.Open(self, arg_2_1, {
		params = arg_2_2,
		isReplace = arg_2_3,
		isAsync = arg_2_4,
		isBack = arg_2_5,
		extraContext = extraContext
	})
end

function GameContext:OnLoadAndUnloadAssert()
	if self.preLoadFunc_ then
		self.preLoadFunc_(self.routes_, self.oldRoutes_, self:GetCoincideRoutesIndex(self.oldRoutes_, self.routes_), self.curArgs_.isAsync)
	end

	GameContext.super.OnLoadAndUnloadAssert(self)
end

function GameContext:OnPlayExitAnimationAndCommonAnimation()
	self:PlayExitAnimation(true)
end

function GameContext:OnPlayExitAnimation()
	self:PlayExitAnimation(false)
end

function GameContext:PlayExitAnimation(arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = #self.oldRoutes_, self:GetCoincideRoutesIndex(self.oldRoutes_, self.routes_) + 1, -1 do
		if self.recordMap_[self.oldRoutes_[iter_6_0]] then
			local var_6_1, var_6_2 = self.recordMap_[self.oldRoutes_[iter_6_0]]:GetPlayBackwardsAnimator()

			if var_6_2 then
				var_6_2()
			end

			for iter_6_1, iter_6_2 in ipairs(var_6_1) do
				table.insert(var_6_0, iter_6_2)

				if iter_6_2[3] == true then
					iter_6_2[1]:Play(iter_6_2[2], 0, 1)
				else
					iter_6_2[1]:Play(iter_6_2[2], 0, 0)
				end
			end
		end
	end

	local var_6_3 = false
	local var_6_4 = false

	if #var_6_0 > 0 then
		local var_6_5

		var_6_5 = FrameTimer.New(function()
			for iter_7_0, iter_7_1 in ipairs(var_6_0) do
				if iter_7_1[1] == nil then
					var_6_4 = true

					self:FinishExitAnimation(var_6_3, var_6_4)

					return
				end

				local var_7_0 = iter_7_1[1]:GetCurrentAnimatorStateInfo(0)

				if iter_7_1[3] == true then
					if var_7_0.normalizedTime > 0 then
						return
					end
				elseif var_7_0.normalizedTime < 1 then
					return
				end

				var_6_4 = true

				self:FinishExitAnimation(var_6_3, var_6_4, arg_6_1)
				var_6_5:Stop()
			end
		end, 1, -1)

		;(nil):Start()
	else
		var_6_4 = true
	end

	manager.ui:UIEventEnabledByUI(false, true)

	if arg_6_1 then
		self.preExitAction_(function()
			var_6_3 = true

			self:FinishExitAnimation(var_6_3, var_6_4, arg_6_1)
		end, self.curArgs_.isAsync, self.curArgs_.isRootUrl)
	else
		var_6_3 = true

		self:FinishExitAnimation(true, var_6_4, arg_6_1)
	end
end

function GameContext:FinishExitAnimation(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 and arg_9_2 then
		manager.ui:UIEventEnabledByUI(true, false)

		if arg_9_3 then
			GameContext.super.OnPlayExitAnimationAndCommonAnimation(self)
		else
			GameContext.super.OnPlayExitAnimation(self)
		end
	end
end

function GameContext:OnPlayEnterAnimation()
	manager.ui:UIEventEnabledByUI(false, true)
	self.afterStartAction_(function()
		GameContext.super.OnPlayEnterAnimation(self)
		manager.ui:UIEventEnabledByUI(true, false)
	end, self.curArgs_.isAsync, self.curArgs_.isRootUrl)
end

function GameContext:OnEnterNewRoutes()
	if ViewAnimationManager.isReturnFromBattle == true or self.curArgs_.isBack then
		ViewAnimationManager.SetIsReturnFromBattle(self.routes_[#self.routes_], true)
	end

	GameContext.super.OnEnterNewRoutes(self)
end

function GameContext:DoFinalize()
	GlobalCall.call("AfterGo")
	GameContext.super.DoFinalize(self)
end

function GameContext:ExitRoute(arg_14_1)
	if self.recordMap_[arg_14_1] == nil then
		return
	end

	OperationRecorder.RecordStayView(self.recordMap_[arg_14_1].class.__cname, (self.recordMap_[arg_14_1]:GetStayTime()))
	GameContext.super.ExitRoute(self, arg_14_1)
end

function GameContext:NeedBackNextUrl(arg_15_1, arg_15_2)
	if ViewConst.NEED_CHECK_ACTIVITY[arg_15_1[1]] then
		return ActivityTools.GetActivityStatus(arg_15_2.params[ViewConst.NEED_CHECK_ACTIVITY[arg_15_1[1]]]) ~= 1
	else
		return false
	end
end

function GameContext:IsReplaceUrl(arg_16_1)
	if #self.history_ > 0 and ViewTools.GetIsSkipRecord((self:GetRoutesFromUrl(self.history_[#self.history_].url))) then
		return true
	end

	return false
end

local function var_0_1(arg_17_0)
	if arg_17_0 then
		arg_17_0()
	end
end

function GameContext:SetActions(arg_18_1, arg_18_2)
	self.preExitAction_ = arg_18_1 or var_0_1
	self.afterStartAction_ = arg_18_2 or var_0_1
end

function GameContext:PlayPreExitTransition(arg_19_1, arg_19_2, arg_19_3)
	self.preExitAction_(arg_19_1, arg_19_2, arg_19_3)
end

function GameContext:PlayAfterStartTransition(arg_20_1, arg_20_2)
	self.afterStartAction_(arg_20_1, arg_20_2)
end

function GameContext:RegistPreLoadFunc(arg_21_1)
	self.preLoadFunc_ = arg_21_1
end

function GameContext:ClearHistory()
	self:SetSystemLayer("home")

	self.history_ = {
		{
			url = "/home",
			args = {}
		}
	}
end

function GameContext:GetLastHistoryAndParams()
	return self.history_[#self.history_].url, self.history_[#self.history_].args.params
end

function GameContext:ClearHistoryByName(arg_24_1)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(self.history_) do
		if iter_24_1.url and string.find(iter_24_1.url, arg_24_1) then
			var_24_0 = iter_24_0
		end
	end

	if var_24_0 > 0 then
		table.remove(self.history_, var_24_0)
	end
end

function GameContext:GetUrl()
	return self.url_
end

function GameContext:GetAllOpenRoute()
	local var_26_0 = {}

	if self.routes_ == nil then
		return var_26_0
	end

	for iter_26_0, iter_26_1 in ipairs(self.routes_) do
		table.insert(var_26_0, iter_26_1)
	end

	return var_26_0
end

function GameContext:GetAllOpenPage()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(self.routes_) do
		table.insert(var_27_0, self.recordMap_[iter_27_1])
	end

	return var_27_0
end

function GameContext:GetLastOpenPage()
	if self.routes_ == nil then
		return ""
	end

	return self.routes_[#self.routes_] or ""
end

function GameContext:GetLastOpenPageHandler()
	if self.routes_ == nil or next(self.routes_) == nil then
		return nil
	end

	return nullable(self.recordMap_, self.routes_[#self.routes_]), self.routes_[#self.routes_]
end

function GameContext:IsOpenRoute(arg_30_1)
	if self.routes_ == nil then
		return nil
	end

	for iter_30_0, iter_30_1 in ipairs(self.routes_) do
		if iter_30_1 == arg_30_1 then
			return iter_30_0
		end
	end

	return nil
end

function GameContext:GetFirstRoutePage()
	return self.routes_[1]
end

function GameContext:GetCmdEnqueueCount()
	return (self.cmdEnqueue_ or nil) and (#self.cmdEnqueue_ or 0)
end

function GameContext:SetUrlAndParams(arg_33_1, arg_33_2)
	if self.curLayer_ == nil then
		table.insert(self.waitLoadUrlList_, {
			url = arg_33_1,
			params = arg_33_2
		})
	else
		self:UpdateUrlHistory(arg_33_1, {
			params = arg_33_2
		})
	end
end

function GameContext:GetOpenPageHandler(arg_34_1)
	local var_34_0 = self:IsOpenRoute(arg_34_1)

	if var_34_0 and var_34_0 > 0 then
		return self.recordMap_[self.routes_[var_34_0]]
	end
end

function GameContext:OverrideUrl(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = whereami == arg_35_4 and self.history_ or self.cacheHistory_[arg_35_4] or {}
	local var_35_1 = self:GetIndexFromHistory(var_35_0, arg_35_2)
	local var_35_2 = self:GetIndexFromHistory(var_35_0, arg_35_1)

	if var_35_2 > 0 then
		var_35_0[var_35_2] = {
			url = arg_35_2,
			args = {
				params = arg_35_3
			}
		}
	end

	if var_35_1 <= 0 or var_35_2 <= 0 then
		return
	elseif var_35_2 < var_35_1 then
		table.remove(var_35_0, var_35_1)
	elseif var_35_1 < var_35_2 then
		table.remove(var_35_0, var_35_2)
	end
end

function GameContext:IsBack(arg_36_1)
	return self:GetIndexFromHistory(self.history_, arg_36_1)
end

function GameContext:SetSystemLayer(arg_37_1)
	if whereami ~= arg_37_1 then
		self:SaveCacheHistory(arg_37_1)
	end

	for iter_37_0, iter_37_1 in ipairs((clone(self.waitLoadUrlList_))) do
		self:SetUrlAndParams(iter_37_1.url, iter_37_1.params)
	end

	self.waitLoadUrlList_ = {}
	whereami = arg_37_1
end

return GameContext
