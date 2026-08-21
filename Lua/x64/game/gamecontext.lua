local var_0_0 = import("library.router.VueRouter")
local var_0_1 = class("GameContext", var_0_0)

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.waitLoadUrlList_ = {}
end

function var_0_1.Go(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_1.super.Open(arg_2_0, arg_2_1, {
		params = arg_2_2,
		isReplace = arg_2_3,
		isAsync = arg_2_4,
		isBack = arg_2_5,
		extraContext = extraContext
	})
end

function var_0_1.OnLoadAndUnloadAssert(arg_3_0)
	if arg_3_0.preLoadFunc_ then
		local var_3_0 = arg_3_0:GetCoincideRoutesIndex(arg_3_0.oldRoutes_, arg_3_0.routes_)

		arg_3_0.preLoadFunc_(arg_3_0.routes_, arg_3_0.oldRoutes_, var_3_0, arg_3_0.curArgs_.isAsync)
	end

	var_0_1.super.OnLoadAndUnloadAssert(arg_3_0)
end

function var_0_1.OnPlayExitAnimationAndCommonAnimation(arg_4_0)
	arg_4_0:PlayExitAnimation(true)
end

function var_0_1.OnPlayExitAnimation(arg_5_0)
	arg_5_0:PlayExitAnimation(false)
end

function var_0_1.PlayExitAnimation(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetCoincideRoutesIndex(arg_6_0.oldRoutes_, arg_6_0.routes_)
	local var_6_1 = {}

	for iter_6_0 = #arg_6_0.oldRoutes_, var_6_0 + 1, -1 do
		local var_6_2 = arg_6_0.recordMap_[arg_6_0.oldRoutes_[iter_6_0]]

		if var_6_2 then
			local var_6_3, var_6_4 = var_6_2:GetPlayBackwardsAnimator()

			if var_6_4 then
				var_6_4()
			end

			for iter_6_1, iter_6_2 in ipairs(var_6_3) do
				table.insert(var_6_1, iter_6_2)

				if iter_6_2[3] == true then
					iter_6_2[1]:Play(iter_6_2[2], 0, 1)
				else
					iter_6_2[1]:Play(iter_6_2[2], 0, 0)
				end
			end
		end
	end

	local var_6_5 = false
	local var_6_6 = false

	if #var_6_1 > 0 then
		local var_6_7

		var_6_7 = FrameTimer.New(function()
			for iter_7_0, iter_7_1 in ipairs(var_6_1) do
				if iter_7_1[1] == nil then
					var_6_6 = true

					arg_6_0:FinishExitAnimation(var_6_5, var_6_6)

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

				var_6_6 = true

				arg_6_0:FinishExitAnimation(var_6_5, var_6_6, arg_6_1)
				var_6_7:Stop()
			end
		end, 1, -1)

		var_6_7:Start()
	else
		var_6_6 = true
	end

	manager.ui:UIEventEnabledByUI(false, true)

	if arg_6_1 then
		arg_6_0.preExitAction_(function()
			var_6_5 = true

			arg_6_0:FinishExitAnimation(var_6_5, var_6_6, arg_6_1)
		end, arg_6_0.curArgs_.isAsync, arg_6_0.curArgs_.isRootUrl)
	else
		var_6_5 = true

		arg_6_0:FinishExitAnimation(var_6_5, var_6_6, arg_6_1)
	end
end

function var_0_1.FinishExitAnimation(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 and arg_9_2 then
		manager.ui:UIEventEnabledByUI(true, false)

		if arg_9_3 then
			var_0_1.super.OnPlayExitAnimationAndCommonAnimation(arg_9_0)
		else
			var_0_1.super.OnPlayExitAnimation(arg_9_0)
		end
	end
end

function var_0_1.OnPlayEnterAnimation(arg_10_0)
	manager.ui:UIEventEnabledByUI(false, true)
	arg_10_0.afterStartAction_(function()
		var_0_1.super.OnPlayEnterAnimation(arg_10_0)
		manager.ui:UIEventEnabledByUI(true, false)
	end, arg_10_0.curArgs_.isAsync, arg_10_0.curArgs_.isRootUrl)
end

function var_0_1.OnEnterNewRoutes(arg_12_0)
	if ViewAnimationManager.isReturnFromBattle == true or arg_12_0.curArgs_.isBack then
		ViewAnimationManager.SetIsReturnFromBattle(arg_12_0.routes_[#arg_12_0.routes_], true)
	end

	var_0_1.super.OnEnterNewRoutes(arg_12_0)
end

function var_0_1.DoFinalize(arg_13_0)
	GlobalCall.call("AfterGo")
	var_0_1.super.DoFinalize(arg_13_0)
end

function var_0_1.ExitRoute(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.recordMap_[arg_14_1]

	if var_14_0 == nil then
		return
	end

	local var_14_1 = var_14_0:GetStayTime()

	OperationRecorder.RecordStayView(var_14_0.class.__cname, var_14_1)
	var_0_1.super.ExitRoute(arg_14_0, arg_14_1)
end

function var_0_1.NeedBackNextUrl(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ViewConst.NEED_CHECK_ACTIVITY[arg_15_1[1]]

	if var_15_0 then
		return ActivityTools.GetActivityStatus(arg_15_2.params[var_15_0]) ~= 1
	else
		return false
	end
end

function var_0_1.IsReplaceUrl(arg_16_0, arg_16_1)
	if #arg_16_0.history_ > 0 then
		local var_16_0 = arg_16_0.history_[#arg_16_0.history_].url
		local var_16_1 = arg_16_0:GetRoutesFromUrl(var_16_0)

		if ViewTools.GetIsSkipRecord(var_16_1) then
			return true
		end
	end

	return false
end

local function var_0_2(arg_17_0)
	if arg_17_0 then
		arg_17_0()
	end
end

function var_0_1.SetActions(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.preExitAction_ = arg_18_1 or var_0_2
	arg_18_0.afterStartAction_ = arg_18_2 or var_0_2
end

function var_0_1.PlayPreExitTransition(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0.preExitAction_(arg_19_1, arg_19_2, arg_19_3)
end

function var_0_1.PlayAfterStartTransition(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.afterStartAction_(arg_20_1, arg_20_2)
end

function var_0_1.RegistPreLoadFunc(arg_21_0, arg_21_1)
	arg_21_0.preLoadFunc_ = arg_21_1
end

function var_0_1.ClearHistory(arg_22_0)
	arg_22_0:SetSystemLayer("home")

	arg_22_0.history_ = {
		{
			url = "/home",
			args = {}
		}
	}
end

function var_0_1.GetLastHistoryAndParams(arg_23_0)
	return arg_23_0.history_[#arg_23_0.history_].url, arg_23_0.history_[#arg_23_0.history_].args.params
end

function var_0_1.ClearHistoryByName(arg_24_0, arg_24_1)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.history_) do
		if iter_24_1.url and string.find(iter_24_1.url, arg_24_1) then
			var_24_0 = iter_24_0
		end
	end

	if var_24_0 > 0 then
		table.remove(arg_24_0.history_, var_24_0)
	end
end

function var_0_1.GetUrl(arg_25_0)
	return arg_25_0.url_
end

function var_0_1.GetAllOpenRoute(arg_26_0)
	local var_26_0 = {}

	if arg_26_0.routes_ == nil then
		return var_26_0
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.routes_) do
		table.insert(var_26_0, iter_26_1)
	end

	return var_26_0
end

function var_0_1.GetAllOpenPage(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.routes_) do
		local var_27_1 = arg_27_0.recordMap_[iter_27_1]

		table.insert(var_27_0, var_27_1)
	end

	return var_27_0
end

function var_0_1.GetLastOpenPage(arg_28_0)
	if arg_28_0.routes_ == nil then
		return ""
	end

	return arg_28_0.routes_[#arg_28_0.routes_] or ""
end

function var_0_1.GetLastOpenPageHandler(arg_29_0)
	if arg_29_0.routes_ == nil or next(arg_29_0.routes_) == nil then
		return nil
	end

	return nullable(arg_29_0.recordMap_, arg_29_0.routes_[#arg_29_0.routes_]), arg_29_0.routes_[#arg_29_0.routes_]
end

function var_0_1.IsOpenRoute(arg_30_0, arg_30_1)
	if arg_30_0.routes_ == nil then
		return nil
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.routes_) do
		if iter_30_1 == arg_30_1 then
			return iter_30_0
		end
	end

	return nil
end

function var_0_1.GetFirstRoutePage(arg_31_0)
	return arg_31_0.routes_[1]
end

function var_0_1.GetCmdEnqueueCount(arg_32_0)
	return arg_32_0.cmdEnqueue_ and #arg_32_0.cmdEnqueue_ or 0
end

function var_0_1.SetUrlAndParams(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0.curLayer_ == nil then
		table.insert(arg_33_0.waitLoadUrlList_, {
			url = arg_33_1,
			params = arg_33_2
		})
	else
		arg_33_0:UpdateUrlHistory(arg_33_1, {
			params = arg_33_2
		})
	end
end

function var_0_1.GetOpenPageHandler(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:IsOpenRoute(arg_34_1)

	if var_34_0 and var_34_0 > 0 then
		return arg_34_0.recordMap_[arg_34_0.routes_[var_34_0]]
	end
end

function var_0_1.OverrideUrl(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0

	if whereami == arg_35_4 then
		var_35_0 = arg_35_0.history_
	else
		var_35_0 = arg_35_0.cacheHistory_[arg_35_4] or {}
	end

	local var_35_1 = arg_35_0:GetIndexFromHistory(var_35_0, arg_35_2)
	local var_35_2 = arg_35_0:GetIndexFromHistory(var_35_0, arg_35_1)

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

function var_0_1.IsBack(arg_36_0, arg_36_1)
	return arg_36_0:GetIndexFromHistory(arg_36_0.history_, arg_36_1)
end

function var_0_1.SetSystemLayer(arg_37_0, arg_37_1)
	if whereami ~= arg_37_1 then
		arg_37_0:SaveCacheHistory(arg_37_1)
	end

	local var_37_0 = clone(arg_37_0.waitLoadUrlList_)

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		arg_37_0:SetUrlAndParams(iter_37_1.url, iter_37_1.params)
	end

	arg_37_0.waitLoadUrlList_ = {}
	whereami = arg_37_1
end

return var_0_1
