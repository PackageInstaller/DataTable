local var_0_0 = class("VueRouter")
local var_0_1 = import(".fsm.FiniteStateMechine")
local var_0_2 = import(".fsm.FiniteStateMechineState")
local var_0_3 = import(".linkMethod.LinkMethod")
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

var_0_0.JUMP_TYPE = {
	GO = "go",
	BACK = "back"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.cmdEnqueue_ = {}
	arg_1_0.routesCfg_ = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		arg_1_0.routesCfg_[iter_1_1.name] = iter_1_1
	end

	arg_1_0.routes_ = {}
	arg_1_0.oldRoutes_ = {}
	arg_1_0.curLayer_ = "login"
	arg_1_0.history_ = {}
	arg_1_0.cacheHistory_ = {}
	arg_1_0.saveHistoryLaylerList_ = arg_1_2 or {}
	arg_1_0.recordMap_ = {}
	arg_1_0.fsm_ = var_0_1.New()

	for iter_1_2, iter_1_3 in pairs(var_0_4) do
		arg_1_0.fsm_:AddState(var_0_2.New(iter_1_3))
	end

	arg_1_0.fsm_:SetInitState("wait")

	arg_1_0.linkMethod_ = var_0_3.New()

	arg_1_0.linkMethod_:AddMethodList({
		handler(arg_1_0, arg_1_0.OnLoadAndUnloadAssert),
		handler(arg_1_0, arg_1_0.OnPlayExitAnimationAndCommonAnimation),
		handler(arg_1_0, arg_1_0.OnExitOldRoutes),
		handler(arg_1_0, arg_1_0.OnUpdateCoincideRoutes),
		handler(arg_1_0, arg_1_0.OnEnterNewRoutes),
		handler(arg_1_0, arg_1_0.OnPlayEnterAnimation),
		handler(arg_1_0, arg_1_0.OnOpenOver)
	})

	arg_1_0.backLinkMethod_ = var_0_3.New()

	arg_1_0.backLinkMethod_:AddMethodList({
		handler(arg_1_0, arg_1_0.OnPlayExitAnimation),
		handler(arg_1_0, arg_1_0.OnExitOldRoutes),
		handler(arg_1_0, arg_1_0.OnUpdateCoincideRoutes),
		handler(arg_1_0, arg_1_0.OnEnterNewRoutes),
		handler(arg_1_0, arg_1_0.OnBackOver)
	})
end

function var_0_0.Open(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0.fsm_:CanTransition("work") then
		table.insert(arg_2_0.cmdEnqueue_, {
			type = var_0_0.JUMP_TYPE.GO,
			url = arg_2_1,
			args = arg_2_2
		})

		return
	end

	arg_2_0.fsm_:Trigger("work")

	local var_2_0, var_2_1, var_2_2 = arg_2_0:ParseUrl(arg_2_1)

	arg_2_0.routes_ = var_2_1
	arg_2_0.url_ = var_2_2

	local var_2_3
	local var_2_4

	if arg_2_0.curArgs_ then
		var_2_3 = arg_2_0.curArgs_.params
		var_2_4 = arg_2_0.curArgs_.context
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

	local var_2_5 = arg_2_0:GetCoincideRoutesIndex(arg_2_0.oldRoutes_, arg_2_0.routes_)

	arg_2_0.curArgs_ = {
		params = var_2_3,
		isBack = arg_2_2.isBack,
		isReplace = arg_2_2.isReplace,
		isAsync = arg_2_2.isAsync or false,
		isRootUrl = var_2_0,
		coincideRouteIndex = var_2_5,
		extraContext = var_2_4
	}

	if arg_2_0.curLinkMethod_ and not arg_2_0.curLinkMethod_:IsFree() then
		-- block empty
	else
		arg_2_0.curLinkMethod_ = arg_2_0.linkMethod_

		arg_2_0.curLinkMethod_:StartNext()
	end
end

function var_0_0.Back(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.curLinkMethod_:IsFree() then
		table.insert(arg_3_0.cmdEnqueue_, {
			type = var_0_0.JUMP_TYPE.BACK,
			cnt = arg_3_1,
			params = arg_3_2
		})

		return
	end

	arg_3_1 = arg_3_0:GetBackStepCnt(arg_3_1)

	local var_3_0 = #arg_3_0.routes_

	if arg_3_1 < var_3_0 then
		arg_3_0.oldRoutes_ = arg_3_0.routes_

		local var_3_1 = {}

		for iter_3_0 = var_3_0, var_3_0 - arg_3_1 + 1, -1 do
			local var_3_2 = arg_3_0.history_[#arg_3_0.history_].url
			local var_3_3 = strrchr(var_3_2, arg_3_0.routes_[iter_3_0])

			arg_3_0.history_[#arg_3_0.history_].url = string.sub(var_3_2, 0, var_3_3 - 2)
		end

		local var_3_4 = arg_3_0.history_[#arg_3_0.history_]

		if arg_3_2 then
			for iter_3_1, iter_3_2 in pairs(arg_3_2) do
				var_3_4.args.params[iter_3_1] = iter_3_2
			end
		end

		for iter_3_3 = 1, var_3_0 - arg_3_1 do
			table.insert(var_3_1, arg_3_0.routes_[iter_3_3])
		end

		arg_3_0.routes_ = var_3_1

		if arg_3_0.curLinkMethod_:IsFree() then
			arg_3_0.fsm_:Trigger("work")

			arg_3_0.curLinkMethod_ = arg_3_0.backLinkMethod_

			arg_3_0.backLinkMethod_:StartNext()
		end
	else
		if #arg_3_0.history_ <= 1 then
			return
		end

		arg_3_0.history_[#arg_3_0.history_] = nil

		local var_3_5 = arg_3_0.history_[#arg_3_0.history_]

		if arg_3_2 then
			for iter_3_4, iter_3_5 in pairs(arg_3_2) do
				var_3_5.args.params[iter_3_4] = iter_3_5
			end
		end

		local var_3_6 = arg_3_0:GetRoutesFromUrl(var_3_5.url)

		while arg_3_0:NeedBackNextUrl(var_3_6, var_3_5.args) do
			arg_3_0.history_[#arg_3_0.history_] = nil
			var_3_5 = arg_3_0.history_[#arg_3_0.history_]
			var_3_6 = arg_3_0:GetRoutesFromUrl(var_3_5.url)
		end

		var_3_5.args.isBack = true

		arg_3_0:Open(var_3_5.url, var_3_5.args)
	end
end

function var_0_0.IsRouteBack(arg_4_0)
	return arg_4_0.isBackFlag_
end

function var_0_0.GetBackStepCnt(arg_5_0, arg_5_1)
	local var_5_0 = #arg_5_0.routes_

	if type(arg_5_1) ~= "number" then
		local var_5_1 = arg_5_0.routes_[var_5_0]

		if var_5_1 and arg_5_0.recordMap_[var_5_1] then
			arg_5_1 = arg_5_0.recordMap_[var_5_1]:UIBackCount()
		else
			arg_5_1 = 1
		end
	else
		local var_5_2 = 0

		for iter_5_0 = 1, arg_5_1 do
			local var_5_3 = arg_5_0.routes_[var_5_0 - var_5_2]

			if var_5_3 and arg_5_0.recordMap_[var_5_3] then
				var_5_2 = var_5_2 + arg_5_0.recordMap_[var_5_3]:UIBackCount()
			else
				break
			end
		end

		arg_5_1 = var_5_2
	end

	return arg_5_1
end

function var_0_0.NeedBackNextUrl(arg_6_0, arg_6_1, arg_6_2)
	return false
end

function var_0_0.OnLoadAndUnloadAssert(arg_7_0)
	arg_7_0.curLinkMethod_:DoNext()
end

function var_0_0.OnPlayEnterAnimation(arg_8_0)
	arg_8_0.curLinkMethod_:DoNext()
end

function var_0_0.OnPlayExitAnimationAndCommonAnimation(arg_9_0)
	arg_9_0.curLinkMethod_:DoNext()
end

function var_0_0.OnPlayExitAnimation(arg_10_0)
	arg_10_0.curLinkMethod_:DoNext()
end

function var_0_0.OnExitOldRoutes(arg_11_0)
	local var_11_0 = arg_11_0:GetCoincideRoutesIndex(arg_11_0.oldRoutes_, arg_11_0.routes_)
	local var_11_1 = arg_11_0.recordMap_[arg_11_0.oldRoutes_[#arg_11_0.oldRoutes_]]

	if var_11_1 then
		var_11_1:HideWeakGuide()
		var_11_1:OnPreBehind()
		var_11_1:OnBehind()
	end

	for iter_11_0 = #arg_11_0.oldRoutes_, var_11_0 + 1, -1 do
		arg_11_0:ExitRoute(arg_11_0.oldRoutes_[iter_11_0])

		arg_11_0.oldRoutes_[iter_11_0] = nil
	end

	arg_11_0.curLinkMethod_:DoNext()
end

function var_0_0.UpdateUrlHistory(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = true
	local var_12_1 = arg_12_0:GetIndexFromHistory(arg_12_0.history_, arg_12_1, var_12_0)

	if var_12_1 > 0 then
		for iter_12_0 = #arg_12_0.history_, var_12_1, -1 do
			arg_12_0.history_[iter_12_0] = nil
		end

		arg_12_0.history_[var_12_1] = {
			url = arg_12_1,
			args = arg_12_2
		}
	elseif arg_12_0:IsReplaceUrl(arg_12_1) then
		arg_12_0.history_[#arg_12_0.history_] = {
			url = arg_12_1,
			args = arg_12_2
		}
	else
		table.insert(arg_12_0.history_, {
			url = arg_12_1,
			args = arg_12_2
		})
	end
end

function var_0_0.IsReplaceUrl(arg_13_0, arg_13_1)
	return false
end

function var_0_0.GetIndexFromHistory(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:GetRoutesFromUrl(arg_14_2)

	if arg_14_0.routesCfg_[var_14_0[1]].precedenceMerge == true then
		for iter_14_0 = 1, #arg_14_1 do
			local var_14_1 = arg_14_0:GetRoutesFromUrl(arg_14_1[iter_14_0].url)

			if arg_14_0:GetCoincideRoutesIndex(var_14_1, var_14_0) > 0 then
				return iter_14_0
			end
		end

		return 0
	end

	for iter_14_1 = #arg_14_1, 1, -1 do
		local var_14_2 = arg_14_0:GetRoutesFromUrl(arg_14_1[iter_14_1].url)

		if arg_14_3 and arg_14_0.routesCfg_[var_14_2[1]].ignoreMerge and var_14_2[1] ~= var_14_0[1] then
			return 0
		end

		if arg_14_0:GetCoincideRoutesIndex(var_14_2, var_14_0) > 0 then
			return iter_14_1
		end
	end

	return 0
end

function var_0_0.GetRoutesFromUrl(arg_15_0, arg_15_1)
	local var_15_0 = string.sub(arg_15_1, 2, #arg_15_1)

	return string.split(var_15_0, "/")
end

function var_0_0.GetRouteCfgFromRouteName(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return nil
	end

	return arg_16_0.routesCfg_[arg_16_1]
end

function var_0_0.OnEnterNewRoutes(arg_17_0)
	local var_17_0 = arg_17_0:GetCoincideRoutesIndex(arg_17_0.oldRoutes_, arg_17_0.routes_)
	local var_17_1 = {}

	arg_17_0.newEnterRecords_ = arg_17_0.newEnterRecords_ or {}

	local var_17_2 = false

	for iter_17_0 = var_17_0 + 1, #arg_17_0.routes_ do
		local var_17_3 = arg_17_0.routes_[iter_17_0]
		local var_17_4 = arg_17_0.routesCfg_[var_17_3]

		if not var_17_4 then
			break
		end

		local var_17_5, var_17_6 = ReduxFactory.GetInstance():GetReduxView(var_17_3, var_17_4)
		local var_17_7 = arg_17_0.curArgs_.params

		var_17_7.isBack = arg_17_0.curArgs_.isBack
		arg_17_0.isBackFlag_ = arg_17_0.curArgs_.isBack

		if var_17_6 then
			var_17_5:SyncInit(var_17_3, var_17_7)
			LuaHidTools.EnsureHasInputPage(var_17_5)
		else
			var_17_5.params_ = var_17_7
		end

		var_17_5:UpdateLastOpenTime()

		local var_17_8 = {
			preRouteName = arg_17_0.routes_[iter_17_0 - 1],
			curRouteName = var_17_3,
			isBack = arg_17_0.curArgs_.isBack,
			routeLayer = arg_17_0.curLayer_,
			extraContext = {
				arg_17_0.curArgs_.extraContext
			}
		}

		var_17_2 = true

		local var_17_9 = var_17_5:GetCustomScene()

		manager.heroRaiseTrack:SetCustomScene(var_17_9)
		var_17_5:CameraEnter(arg_17_0.curArgs_.isRootUrl)
		var_17_5:ReserveCameraEnter(arg_17_0.curArgs_.isRootUrl)
		var_17_5:OnPreEnter()
		var_17_5:OnEnter(var_17_8)
		var_17_5:AdaptScreen()
		LuaHidTools.EnterInputPage(var_17_5)

		if iter_17_0 ~= #arg_17_0.routes_ then
			table.insert(var_17_1, var_17_5)
		end

		if arg_17_0.routes_[iter_17_0] then
			arg_17_0.recordMap_[var_17_3] = var_17_5
		end

		table.insert(arg_17_0.newEnterRecords_, var_17_5)
	end

	arg_17_0.oldRoutes_ = arg_17_0.routes_

	local var_17_10 = arg_17_0.recordMap_[arg_17_0.routes_[#arg_17_0.routes_]]

	if var_17_10 then
		if not var_17_2 then
			local var_17_11 = true
			local var_17_12 = var_17_10:GetCustomScene()

			manager.heroRaiseTrack:SetCustomScene(var_17_12)
		end

		var_17_10:OnPreTop()
		var_17_10:OnTop()
		var_17_10:CheckWeakGuide()
		arg_17_0:SendToUITimeMgr(var_17_10, arg_17_0.routes_[#arg_17_0.routes_], true)
	end

	for iter_17_1 = 1, #var_17_1 do
		var_17_1[iter_17_1]:OnUpdate()
	end

	arg_17_0.curLinkMethod_:DoNext()
end

function var_0_0.OnUpdateCoincideRoutes(arg_18_0)
	local var_18_0 = arg_18_0:GetCoincideRoutesIndex(arg_18_0.oldRoutes_, arg_18_0.routes_)

	for iter_18_0 = 1, var_18_0 do
		local var_18_1 = arg_18_0.recordMap_[arg_18_0.oldRoutes_[iter_18_0]]

		if var_18_1 then
			if arg_18_0.curArgs_.params then
				var_18_1:SetParams(arg_18_0.curArgs_.params)
			end

			var_18_1:OnUpdate()
		end
	end

	local var_18_2 = arg_18_0.recordMap_[arg_18_0.oldRoutes_[var_18_0]]

	if var_18_2 then
		var_18_2:OnOverlapped()
	end

	arg_18_0.curLinkMethod_:DoNext()
end

function var_0_0.OnOpenOver(arg_19_0)
	local var_19_0 = #arg_19_0.history_

	var_19_0 = var_19_0 > 0 and var_19_0 or 1

	if arg_19_0.curArgs_.isReplace then
		arg_19_0.curArgs_.isReplace = false
		arg_19_0.history_[var_19_0] = {
			url = arg_19_0.url_,
			args = arg_19_0.curArgs_
		}
	elseif arg_19_0.curArgs_.isRootUrl and arg_19_0.curArgs_.coincideRouteIndex == 0 then
		arg_19_0:UpdateUrlHistory(arg_19_0.url_, arg_19_0.curArgs_)
	else
		arg_19_0.history_[var_19_0] = {
			url = arg_19_0.url_,
			args = arg_19_0.curArgs_
		}
	end

	arg_19_0.fsm_:Trigger("wait")
	arg_19_0.curLinkMethod_:DoNext()
	arg_19_0:DoNextCommand()
end

function var_0_0.OnBackOver(arg_20_0)
	arg_20_0.fsm_:Trigger("wait")
	arg_20_0.curLinkMethod_:DoNext()
	arg_20_0:DoNextCommand()
end

function var_0_0.DoNextCommand(arg_21_0)
	if #arg_21_0.cmdEnqueue_ > 0 then
		local var_21_0 = arg_21_0.cmdEnqueue_[#arg_21_0.cmdEnqueue_]

		arg_21_0.cmdEnqueue_[#arg_21_0.cmdEnqueue_] = nil

		if var_21_0.type == var_0_0.JUMP_TYPE.GO then
			arg_21_0:Open(var_21_0.url, var_21_0.args)
		else
			arg_21_0:Back(var_21_0.backCnt, var_21_0.params)
		end
	else
		arg_21_0:DoFinalize()
	end
end

function var_0_0.DoFinalize(arg_22_0)
	local var_22_0
	local var_22_1

	var_22_1, arg_22_0.newEnterRecords_ = arg_22_0.newEnterRecords_

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		iter_22_1:OnEnterOver()
	end
end

function var_0_0.ExitRoute(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.recordMap_[arg_23_1]

	if var_23_0 == nil then
		return
	end

	var_23_0:HideWeakGuide()
	var_23_0:OnPreExit()
	var_23_0:OnExit()
	LuaHidTools.ExitInputPage(var_23_0)
	ReduxFactory.GetInstance():CacheReduxView(var_23_0)
	arg_23_0:SendToUITimeMgr(var_23_0, arg_23_1, false)

	arg_23_0.recordMap_[arg_23_1] = nil
end

function var_0_0.SendToUITimeMgr(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3 then
		if not arg_24_1.EnterSendMgr then
			manager.uiTime:OnEnterRoute(arg_24_2)
		end
	elseif not arg_24_1.ExitSendMgr then
		manager.uiTime:OnExitRoute(arg_24_2)
	end
end

function var_0_0.ParseUrl(arg_25_0, arg_25_1)
	local var_25_0 = ""
	local var_25_1 = {}
	local var_25_2 = string.char(string.byte(arg_25_1)) == "/"

	if var_25_2 then
		arg_25_1 = string.sub(arg_25_1, 2, #arg_25_1)
	end

	local var_25_3 = string.split(arg_25_1, "/")
	local var_25_4 = {}
	local var_25_5 = ""

	if not var_25_2 then
		var_25_1, var_25_5 = arg_25_0:UmergeRoutes(arg_25_0.routes_, var_25_3)
	else
		var_25_1, var_25_5 = arg_25_0:AppendRoutes(arg_25_0.routes_, var_25_3)
	end

	return var_25_2, var_25_1, var_25_5
end

function var_0_0.UmergeRoutes(arg_26_0, arg_26_1, arg_26_2)
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
		local var_26_3 = arg_26_2[iter_26_3]

		table.insert(var_26_0, var_26_3)

		var_26_1 = string.format("%s/%s", var_26_1, var_26_3)
	end

	return var_26_0, var_26_1
end

function var_0_0.AppendRoutes(arg_27_0, arg_27_1, arg_27_2)
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

function var_0_0.GetCoincideRoutesIndex(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_2) do
		if not arg_28_1[iter_28_0] or iter_28_1 ~= arg_28_1[iter_28_0] then
			return iter_28_0 - 1
		end

		var_28_0 = iter_28_0
	end

	return var_28_0
end

function var_0_0.RevertRoutes(arg_29_0)
	arg_29_0.oldRoutes_ = {}

	if #arg_29_0.history_ <= 0 then
		return
	end

	local var_29_0 = arg_29_0.history_[#arg_29_0.history_]

	GlobalCall.register("AfterGo", function()
		JumpTools.RefreshGaussianBg()
	end)
	arg_29_0:Open(var_29_0.url, var_29_0.args)
end

function var_0_0.DestroyCurRoutes(arg_31_0)
	for iter_31_0 = #arg_31_0.routes_, 1, -1 do
		arg_31_0:ExitRoute(arg_31_0.routes_[iter_31_0])
	end

	arg_31_0.routes_ = {}
	arg_31_0.oldRoutes_ = {}
end

function var_0_0.GetCurHistory(arg_32_0)
	return arg_32_0.history_
end

function var_0_0.SaveCacheHistory(arg_33_0, arg_33_1)
	if arg_33_0.curLayer_ and table.keyof(arg_33_0.saveHistoryLaylerList_, arg_33_0.curLayer_) then
		arg_33_0.cacheHistory_[arg_33_0.curLayer_] = clone(arg_33_0.history_)
	end

	arg_33_0.curLayer_ = arg_33_1

	if arg_33_1 then
		arg_33_0.history_ = clone(arg_33_0.cacheHistory_[arg_33_1]) or {}
	else
		arg_33_0.history_ = {}
	end
end

return var_0_0
