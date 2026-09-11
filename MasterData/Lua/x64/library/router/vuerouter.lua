local VueRouter = class("VueRouter")
local FiniteStateMechine = import(".fsm.FiniteStateMechine")
local FiniteStateMechineState = import(".fsm.FiniteStateMechineState")
local LinkMethod = import(".linkMethod.LinkMethod")
local var_0_4 = {
	{
		to = "working",
		name = "work",
		from = "wait"
	},
	{
		to = "wait",
		name = "wait",
		from = "working"
	}
}

VueRouter.JUMP_TYPE = {
	GO = "go",
	BACK = "back"
}

function VueRouter:Ctor(arg_1_1, arg_1_2)
	self.cmdEnqueue_ = {}
	self.routesCfg_ = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		self.routesCfg_[iter_1_1.name] = iter_1_1
	end

	self.routes_ = {}
	self.oldRoutes_ = {}
	self.curLayer_ = "login"
	self.history_ = {}
	self.cacheHistory_ = {}
	self.saveHistoryLaylerList_ = arg_1_2 or {}
	self.recordMap_ = {}
	self.fsm_ = FiniteStateMechine.New()

	for iter_1_2, iter_1_3 in pairs(var_0_4) do
		self.fsm_:AddState(FiniteStateMechineState.New(iter_1_3))
	end

	self.fsm_:SetInitState("wait")

	self.linkMethod_ = LinkMethod.New()

	self.linkMethod_:AddMethodList({
		handler(self, self.OnLoadAndUnloadAssert),
		handler(self, self.OnPlayExitAnimationAndCommonAnimation),
		handler(self, self.OnExitOldRoutes),
		handler(self, self.OnUpdateCoincideRoutes),
		handler(self, self.OnEnterNewRoutes),
		handler(self, self.OnPlayEnterAnimation),
		handler(self, self.OnOpenOver)
	})

	self.backLinkMethod_ = LinkMethod.New()

	self.backLinkMethod_:AddMethodList({
		handler(self, self.OnPlayExitAnimation),
		handler(self, self.OnExitOldRoutes),
		handler(self, self.OnUpdateCoincideRoutes),
		handler(self, self.OnEnterNewRoutes),
		handler(self, self.OnBackOver)
	})
end

function VueRouter:Open(arg_2_1, arg_2_2)
	if not self.fsm_:CanTransition("work") then
		table.insert(self.cmdEnqueue_, {
			type = VueRouter.JUMP_TYPE.GO,
			url = arg_2_1,
			args = arg_2_2
		})

		return
	end

	self.fsm_:Trigger("work")

	local var_2_0, var_2_1, var_2_2 = self:ParseUrl(arg_2_1)

	self.routes_ = var_2_1
	self.url_ = var_2_2

	local var_2_3
	local var_2_4

	if self.curArgs_ then
		var_2_3 = self.curArgs_.params
		var_2_4 = self.curArgs_.context
	end

	if var_2_0 then
		var_2_3 = {}
		var_2_4 = {}
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_2.params or {}) do
		var_2_3[iter_2_0] = iter_2_1
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_2.extraContext or {}) do
		var_2_4[iter_2_2] = iter_2_3
	end

	local var_2_5 = {
		params = var_2_3,
		isBack = arg_2_2.isBack,
		isReplace = arg_2_2.isReplace
	}

	var_2_5.isAsync = arg_2_2.isAsync or false
	var_2_5.isRootUrl = var_2_0
	var_2_5.coincideRouteIndex = self:GetCoincideRoutesIndex(self.oldRoutes_, self.routes_)
	var_2_5.extraContext = var_2_4
	self.curArgs_ = var_2_5

	if self.curLinkMethod_ and not self.curLinkMethod_:IsFree() then
		-- block empty
	else
		self.curLinkMethod_ = self.linkMethod_

		self.curLinkMethod_:StartNext()
	end
end

function VueRouter:Back(arg_3_1, arg_3_2)
	if not self.curLinkMethod_:IsFree() then
		table.insert(self.cmdEnqueue_, {
			type = VueRouter.JUMP_TYPE.BACK,
			cnt = arg_3_1,
			params = arg_3_2
		})

		return
	end

	arg_3_1 = self:GetBackStepCnt(arg_3_1)

	if arg_3_1 < #self.routes_ then
		self.oldRoutes_ = self.routes_

		local var_3_0 = {}

		for iter_3_0 = #self.routes_, #self.routes_ - arg_3_1 + 1, -1 do
			self.history_[#self.history_].url = string.sub(self.history_[#self.history_].url, 0, strrchr(self.history_[#self.history_].url, self.routes_[iter_3_0]) - 2)
		end

		if arg_3_2 then
			for iter_3_1, iter_3_2 in pairs(arg_3_2) do
				self.history_[#self.history_].args.params[iter_3_1] = iter_3_2
			end
		end

		for iter_3_3 = 1, #self.routes_ - arg_3_1 do
			table.insert(var_3_0, self.routes_[iter_3_3])
		end

		self.routes_ = var_3_0

		if self.curLinkMethod_:IsFree() then
			self.fsm_:Trigger("work")

			self.curLinkMethod_ = self.backLinkMethod_

			self.backLinkMethod_:StartNext()
		end
	else
		if #self.history_ <= 1 then
			return
		end

		self.history_[#self.history_] = nil

		local var_3_1 = self.history_[#self.history_]

		if arg_3_2 then
			for iter_3_4, iter_3_5 in pairs(arg_3_2) do
				var_3_1.args.params[iter_3_4] = iter_3_5
			end
		end

		while self:NeedBackNextUrl(self:GetRoutesFromUrl(var_3_1.url), var_3_1.args) do
			self.history_[#self.history_] = nil
			var_3_1 = self.history_[#self.history_]

			local var_3_2 = self:GetRoutesFromUrl(self.history_[#self.history_].url)
		end

		var_3_1.args.isBack = true

		self:Open(var_3_1.url, var_3_1.args)
	end
end

function VueRouter:IsRouteBack()
	return self.isBackFlag_
end

function VueRouter:GetBackStepCnt(arg_5_1)
	if type(arg_5_1) ~= "number" then
		arg_5_1 = self.routes_[#self.routes_] and self.recordMap_[self.routes_[#self.routes_]] and self.recordMap_[self.routes_[#self.routes_]]:UIBackCount() or 1
	else
		local var_5_0 = 0

		for iter_5_0 = 1, arg_5_1 do
			if self.routes_[#self.routes_ - var_5_0] and self.recordMap_[self.routes_[#self.routes_ - var_5_0]] then
				var_5_0 = var_5_0 + self.recordMap_[self.routes_[#self.routes_ - var_5_0]]:UIBackCount()
			else
				break
			end
		end

		arg_5_1 = var_5_0
	end

	return arg_5_1
end

function VueRouter:NeedBackNextUrl(arg_6_1, arg_6_2)
	return false
end

function VueRouter:OnLoadAndUnloadAssert()
	self.curLinkMethod_:DoNext()
end

function VueRouter:OnPlayEnterAnimation()
	self.curLinkMethod_:DoNext()
end

function VueRouter:OnPlayExitAnimationAndCommonAnimation()
	self.curLinkMethod_:DoNext()
end

function VueRouter:OnPlayExitAnimation()
	self.curLinkMethod_:DoNext()
end

function VueRouter:OnExitOldRoutes()
	if self.recordMap_[self.oldRoutes_[#self.oldRoutes_]] then
		self.recordMap_[self.oldRoutes_[#self.oldRoutes_]]:HideWeakGuide()
		self.recordMap_[self.oldRoutes_[#self.oldRoutes_]]:OnPreBehind()
		self.recordMap_[self.oldRoutes_[#self.oldRoutes_]]:OnBehind()
	end

	for iter_11_0 = #self.oldRoutes_, self:GetCoincideRoutesIndex(self.oldRoutes_, self.routes_) + 1, -1 do
		self:ExitRoute(self.oldRoutes_[iter_11_0])

		self.oldRoutes_[iter_11_0] = nil
	end

	self.curLinkMethod_:DoNext()
end

function VueRouter:UpdateUrlHistory(arg_12_1, arg_12_2)
	local var_12_0 = self:GetIndexFromHistory(self.history_, arg_12_1, true)

	if var_12_0 > 0 then
		for iter_12_0 = #self.history_, var_12_0, -1 do
			self.history_[iter_12_0] = nil
		end

		self.history_[var_12_0] = {
			url = arg_12_1,
			args = arg_12_2
		}
	elseif self:IsReplaceUrl(arg_12_1) then
		self.history_[#self.history_] = {
			url = arg_12_1,
			args = arg_12_2
		}
	else
		table.insert(self.history_, {
			url = arg_12_1,
			args = arg_12_2
		})
	end
end

function VueRouter:IsReplaceUrl(arg_13_1)
	return false
end

function VueRouter:GetIndexFromHistory(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self:GetRoutesFromUrl(arg_14_2)

	if self.routesCfg_[var_14_0[1]].precedenceMerge == true then
		for iter_14_0 = 1, #arg_14_1 do
			if self:GetCoincideRoutesIndex(self:GetRoutesFromUrl(arg_14_1[iter_14_0].url), var_14_0) > 0 then
				return iter_14_0
			end
		end

		return 0
	end

	for iter_14_1 = #arg_14_1, 1, -1 do
		local var_14_1 = self:GetRoutesFromUrl(arg_14_1[iter_14_1].url)

		if arg_14_3 and self.routesCfg_[var_14_1[1]].ignoreMerge and var_14_1[1] ~= var_14_0[1] then
			return 0
		end

		if self:GetCoincideRoutesIndex(var_14_1, var_14_0) > 0 then
			return iter_14_1
		end
	end

	return 0
end

function VueRouter:GetRoutesFromUrl(arg_15_1)
	return string.split(string.sub(arg_15_1, 2, #arg_15_1), "/")
end

function VueRouter:GetRouteCfgFromRouteName(arg_16_1)
	if not arg_16_1 then
		return nil
	end

	return self.routesCfg_[arg_16_1]
end

function VueRouter:OnEnterNewRoutes()
	local var_17_0 = {}

	self.newEnterRecords_ = self.newEnterRecords_ or {}

	local var_17_1 = false

	for iter_17_0 = self:GetCoincideRoutesIndex(self.oldRoutes_, self.routes_) + 1, #self.routes_ do
		local var_17_2 = self.routes_[iter_17_0]

		if not self.routesCfg_[self.routes_[iter_17_0]] then
			break
		end

		local var_17_3, var_17_4 = ReduxFactory.GetInstance():GetReduxView(var_17_2, self.routesCfg_[self.routes_[iter_17_0]])

		self.curArgs_.params.isBack = self.curArgs_.isBack
		self.isBackFlag_ = self.curArgs_.isBack

		if var_17_4 then
			var_17_3:SyncInit(var_17_2, self.curArgs_.params)
			LuaHidTools.EnsureHasInputPage(var_17_3)
		else
			var_17_3.params_ = self.curArgs_.params
		end

		var_17_3:UpdateLastOpenTime()

		local var_17_5 = {
			preRouteName = self.routes_[iter_17_0 - 1],
			curRouteName = var_17_2,
			isBack = self.curArgs_.isBack,
			routeLayer = self.curLayer_,
			extraContext = {
				self.curArgs_.extraContext
			}
		}

		var_17_1 = true

		manager.heroRaiseTrack:SetCustomScene((var_17_3:GetCustomScene()))
		var_17_3:CameraEnter(self.curArgs_.isRootUrl)
		var_17_3:ReserveCameraEnter(self.curArgs_.isRootUrl)
		var_17_3:OnPreEnter()
		var_17_3:OnEnter(var_17_5)
		var_17_3:AdaptScreen()
		LuaHidTools.EnterInputPage(var_17_3)

		if iter_17_0 ~= #self.routes_ then
			table.insert(var_17_0, var_17_3)
		end

		if self.routes_[iter_17_0] then
			self.recordMap_[var_17_2] = var_17_3
		end

		table.insert(self.newEnterRecords_, var_17_3)
	end

	self.oldRoutes_ = self.routes_

	if self.recordMap_[self.routes_[#self.routes_]] then
		if not var_17_1 then
			manager.heroRaiseTrack:SetCustomScene((self.recordMap_[self.routes_[#self.routes_]]:GetCustomScene()))
		end

		self.recordMap_[self.routes_[#self.routes_]]:OnPreTop()
		self.recordMap_[self.routes_[#self.routes_]]:OnTop()
		self.recordMap_[self.routes_[#self.routes_]]:CheckWeakGuide()
		self:SendToUITimeMgr(self.recordMap_[self.routes_[#self.routes_]], self.routes_[#self.routes_], true)
	end

	for iter_17_1 = 1, #var_17_0 do
		var_17_0[iter_17_1]:OnUpdate()
	end

	self.curLinkMethod_:DoNext()
end

function VueRouter:OnUpdateCoincideRoutes()
	local var_18_0 = self:GetCoincideRoutesIndex(self.oldRoutes_, self.routes_)

	for iter_18_0 = 1, var_18_0 do
		if self.recordMap_[self.oldRoutes_[iter_18_0]] then
			if self.curArgs_.params then
				self.recordMap_[self.oldRoutes_[iter_18_0]]:SetParams(self.curArgs_.params)
			end

			self.recordMap_[self.oldRoutes_[iter_18_0]]:OnUpdate()
		end
	end

	if self.recordMap_[self.oldRoutes_[var_18_0]] then
		self.recordMap_[self.oldRoutes_[var_18_0]]:OnOverlapped()
	end

	self.curLinkMethod_:DoNext()
end

function VueRouter:OnOpenOver()
	local var_19_0 = #self.history_

	var_19_0 = #self.history_ > 0 and var_19_0 or 1

	if self.curArgs_.isReplace then
		self.curArgs_.isReplace = false
		self.history_[var_19_0] = {
			url = self.url_,
			args = self.curArgs_
		}
	elseif self.curArgs_.isRootUrl and self.curArgs_.coincideRouteIndex == 0 then
		self:UpdateUrlHistory(self.url_, self.curArgs_)
	else
		self.history_[var_19_0] = {
			url = self.url_,
			args = self.curArgs_
		}
	end

	self.fsm_:Trigger("wait")
	self.curLinkMethod_:DoNext()
	self:DoNextCommand()
end

function VueRouter:OnBackOver()
	self.fsm_:Trigger("wait")
	self.curLinkMethod_:DoNext()
	self:DoNextCommand()
end

function VueRouter:DoNextCommand()
	if #self.cmdEnqueue_ > 0 then
		self.cmdEnqueue_[#self.cmdEnqueue_] = nil

		if self.cmdEnqueue_[#self.cmdEnqueue_].type == VueRouter.JUMP_TYPE.GO then
			self:Open(self.cmdEnqueue_[#self.cmdEnqueue_].url, self.cmdEnqueue_[#self.cmdEnqueue_].args)
		else
			self:Back(self.cmdEnqueue_[#self.cmdEnqueue_].backCnt, self.cmdEnqueue_[#self.cmdEnqueue_].params)
		end
	else
		self:DoFinalize()
	end
end

function VueRouter:DoFinalize()
	local var_22_1

	var_22_1, self.newEnterRecords_ = self.newEnterRecords_

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		iter_22_1:OnEnterOver()
	end
end

function VueRouter:ExitRoute(arg_23_1)
	if self.recordMap_[arg_23_1] == nil then
		return
	end

	self.recordMap_[arg_23_1]:HideWeakGuide()
	self.recordMap_[arg_23_1]:OnPreExit()
	self.recordMap_[arg_23_1]:OnExit()
	LuaHidTools.ExitInputPage(self.recordMap_[arg_23_1])
	ReduxFactory.GetInstance():CacheReduxView(self.recordMap_[arg_23_1])
	self:SendToUITimeMgr(self.recordMap_[arg_23_1], arg_23_1, false)

	self.recordMap_[arg_23_1] = nil
end

function VueRouter:SendToUITimeMgr(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3 then
		if not arg_24_1.EnterSendMgr then
			manager.uiTime:OnEnterRoute(arg_24_2)
		end
	elseif not arg_24_1.ExitSendMgr then
		manager.uiTime:OnExitRoute(arg_24_2)
	end
end

function VueRouter:ParseUrl(arg_25_1)
	local var_25_1 = {}
	local var_25_2 = string.char(string.byte(arg_25_1)) == "/"

	if var_25_2 then
		arg_25_1 = string.sub(arg_25_1, 2, #arg_25_1)
	end

	local var_25_3 = string.split(arg_25_1, "/")
	local var_25_5 = ""

	if not var_25_2 then
		var_25_1, var_25_5 = self:UmergeRoutes(self.routes_, var_25_3)
	else
		var_25_1, var_25_5 = self:AppendRoutes(self.routes_, var_25_3)
	end

	return var_25_2, var_25_1, var_25_5
end

function VueRouter:UmergeRoutes(arg_26_1, arg_26_2)
	local var_26_0 = {}
	local var_26_1 = ""
	local var_26_2 = #arg_26_1

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		if iter_26_1 == arg_26_2[1] then
			var_26_2 = iter_26_0 - 1

			break
		end
	end

	for iter_26_2 = 1, var_26_2 do
		table.insert(var_26_0, arg_26_1[iter_26_2])

		var_26_1 = string.format("%s/%s", var_26_1, arg_26_1[iter_26_2])
	end

	for iter_26_3 = 1, #arg_26_2 do
		table.insert(var_26_0, arg_26_2[iter_26_3])

		var_26_1 = string.format("%s/%s", var_26_1, arg_26_2[iter_26_3])
	end

	return var_26_0, var_26_1
end

function VueRouter:AppendRoutes(arg_27_1, arg_27_2)
	local var_27_0 = {}
	local var_27_1 = ""

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		if iter_27_1 == arg_27_1[iter_27_0] then
			table.insert(var_27_0, iter_27_1)

			var_27_1 = string.format("%s/%s", var_27_1, iter_27_1)
		else
			break
		end
	end

	for iter_27_2 = #var_27_0 + 1, #arg_27_2 do
		table.insert(var_27_0, arg_27_2[iter_27_2])

		var_27_1 = string.format("%s/%s", var_27_1, arg_27_2[iter_27_2])
	end

	return var_27_0, var_27_1
end

function VueRouter:GetCoincideRoutesIndex(arg_28_1, arg_28_2)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_2) do
		if not arg_28_1[iter_28_0] or iter_28_1 ~= arg_28_1[iter_28_0] then
			return iter_28_0 - 1
		end

		var_28_0 = iter_28_0
	end

	return var_28_0
end

function VueRouter:RevertRoutes()
	self.oldRoutes_ = {}

	if #self.history_ <= 0 then
		return
	end

	local var_29_0 = self.history_[#self.history_]

	GlobalCall.register("AfterGo", function()
		JumpTools.RefreshGaussianBg()
	end)
	self:Open(var_29_0.url, var_29_0.args)
end

function VueRouter:DestroyCurRoutes()
	for iter_31_0 = #self.routes_, 1, -1 do
		self:ExitRoute(self.routes_[iter_31_0])
	end

	self.routes_ = {}
	self.oldRoutes_ = {}
end

function VueRouter:GetCurHistory()
	return self.history_
end

function VueRouter:SaveCacheHistory(arg_33_1)
	if self.curLayer_ and table.keyof(self.saveHistoryLaylerList_, self.curLayer_) then
		self.cacheHistory_[self.curLayer_] = clone(self.history_)
	end

	self.curLayer_ = arg_33_1
	self.history_ = arg_33_1 and (clone(self.cacheHistory_[arg_33_1]) or {}) or {}
end

return VueRouter
