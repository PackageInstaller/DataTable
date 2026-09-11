local var_0_0 = {}

manager.net:Bind(72001, function(arg_1_0)
	if not var_0_0.inited then
		MoonCakeTools.InitConst()
		var_0_0.InitRedPoint()

		var_0_0.inited = true
	end

	MoonCakeData:InitCakeData(arg_1_0)
	var_0_0.UpdateFillingMakeRedPoint(arg_1_0.activity_id)
	var_0_0.UpdateCakeMakeRedPoint(arg_1_0.activity_id)
	var_0_0.UpdateCakeCollectTaskPoint(arg_1_0.activity_id)
	var_0_0.UpdateDelegateDispatchPoint(arg_1_0.activity_id)
	var_0_0.UpdateDelegateRewardPoint(arg_1_0.activity_id)
end)
manager.net:Bind(72013, function(arg_2_0)
	MoonCakeData:UpdateOwnDelegate(arg_2_0)
	var_0_0.UpdateDelegateRewardPoint(arg_2_0.activity_id)
	manager.notify:Invoke(MOON_DELEGATE_UPDATE)
end)
manager.net:Bind(72101, function(arg_3_0)
	if not var_0_0.inited then
		MoonCakeTools.InitConst()
		var_0_0.InitRedPoint()

		var_0_0.inited = true
	end

	MoonCakeData:InitPartyData(arg_3_0)
	var_0_0.UpdatePartyOpenPoint(arg_3_0.activity_id)
	var_0_0.UpdatePartyRewardPoint(arg_3_0.activity_id)
	manager.notify:CallUpdateFunc(MOON_PARTY_RESET)
end)
manager.net:Bind(72111, function(arg_4_0)
	MoonCakeData:ResetPartyData(arg_4_0)
	var_0_0.UpdatePartyOpenPoint(arg_4_0.activity_id)
	var_0_0.UpdatePartyRewardPoint(arg_4_0.activity_id)
end)

function var_0_0.MakeFilling(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(72002, {
		activity_id = arg_5_0,
		patties_id = arg_5_1,
		num = arg_5_2
	}, 72003, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			getReward2(arg_6_0.item_list)
			var_0_0.UpdateFillingMakeRedPoint(arg_5_0)
			var_0_0.UpdateCakeMakeRedPoint(arg_5_0)
			manager.notify:CallUpdateFunc(MOON_FILLING_MADE)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.MoonCakeMakeResult(arg_7_0, arg_7_1, arg_7_2)
	manager.net:SendWithLoadingNew(72004, {
		activity_id = arg_7_0,
		moon_cakes_id = arg_7_1,
		qte = arg_7_2 == true and 1 or 0
	}, 72005, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			if arg_7_2 == true then
				MoonCakeData:SetUnlockCake(arg_7_0, arg_7_1)
			end

			var_0_0.UpdateCakeMakeRedPoint(arg_7_0)
			var_0_0.UpdateCakeCollectTaskPoint(arg_7_0)
			manager.notify:CallUpdateFunc(MOON_CAKE_MAKE_RESULT, arg_8_0.item_id)
		else
			ShowTips(arg_8_0.result)
		end
	end)
end

function var_0_0.RefreshRecommendDelegate(arg_9_0, arg_9_1)
	manager.net:SendWithLoadingNew(72020, {
		activity_id = arg_9_0
	}, 72021, function(arg_10_0)
		if isSuccess(arg_10_0.result) then
			MoonCakeData:SetRecommendDelegate(arg_9_0, arg_10_0.recommend_list)
			manager.notify:Invoke(MOON_RECOMMEND_DELEGATE_UPDATE)

			if arg_9_1 then
				arg_9_1()
			end
		else
			ShowTips(arg_10_0.result)
		end
	end)
end

function var_0_0.QueryRecommendDelegate(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(72014, {
		activity_id = arg_11_0
	}, 72015, function(arg_12_0)
		if isSuccess(arg_12_0.result) then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_SUCCESS")
			MoonCakeData:SetLastRefreshDelegateTime(arg_11_0, arg_12_0.timestamp)
			MoonCakeData:SetRecommendDelegate(arg_11_0, arg_12_0.recommend_list)

			if arg_11_1 then
				arg_11_1()
			end

			manager.notify:Invoke(MOON_RECOMMEND_DELEGATE_UPDATE)
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.SubmitDelegate(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	manager.net:SendWithLoadingNew(72010, {
		activity_id = arg_13_0,
		receive_id = arg_13_1,
		entrust_id = arg_13_2
	}, 72011, function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_GIFT_SUCCESS")
			MoonCakeData:SubmitDelegate(arg_13_0, arg_13_1, arg_13_2)

			if arg_13_3 then
				arg_13_3()
			end

			manager.notify:Invoke(MOON_DELEGATE_SUBMIT)
		else
			ShowTips(arg_14_0.result)

			if arg_14_0.result == 24201 then
				var_0_0.RefreshRecommendDelegate(arg_13_0)
			end
		end
	end)
end

function var_0_0.DispatchDelegate(arg_15_0, arg_15_1, arg_15_2)
	manager.net:SendWithLoadingNew(72008, {
		activity_id = arg_15_0,
		moon_cakes_id = arg_15_1
	}, 72009, function(arg_16_0)
		if isSuccess(arg_16_0.result) then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_PUBLISH_TASK")

			if arg_15_2 then
				arg_15_2()
			end
		else
			ShowTips(arg_16_0.result)
		end
	end)
end

function var_0_0.CancelDelegate(arg_17_0, arg_17_1, arg_17_2)
	manager.net:SendWithLoadingNew(72016, {
		activity_id = arg_17_0,
		entrust_id = arg_17_1
	}, 72017, function(arg_18_0)
		if isSuccess(arg_18_0.result) then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_CANCEL_TASK")
			MoonCakeData:CancelDelegate(arg_17_0, arg_17_1)
			var_0_0.UpdateDelegateDispatchPoint(arg_17_0)

			if arg_17_2 then
				arg_17_2()
			end
		else
			ShowTips(arg_18_0.result)
		end

		manager.notify:Invoke(MOON_DELEGATE_CALCEL)
	end)
end

function var_0_0.ReceiveDelegateReward(arg_19_0, arg_19_1)
	manager.net:SendWithLoadingNew(72018, {
		activity_id = arg_19_0,
		entrust_id = arg_19_1
	}, 72019, function(arg_20_0)
		if isSuccess(arg_20_0.result) then
			MoonCakeData:ReceivedDelegateReward(arg_19_0, arg_19_1)
			getReward2(arg_20_0.item_list)
			var_0_0.UpdateDelegateRewardPoint(arg_19_0)
			var_0_0.UpdateDelegateDispatchPoint(arg_19_0)
			var_0_0.UpdateCakeCollectTaskPoint(arg_19_0)
			manager.notify:Invoke(MOON_DELEGATE_REWARD_RECEIVE)
		else
			ShowTips(arg_20_0.result)
		end
	end)
end

function var_0_0.ReceiveCakeCollectReward(arg_21_0, arg_21_1)
	manager.net:SendWithLoadingNew(72006, {
		activity_id = arg_21_0,
		group_id = arg_21_1
	}, 72007, function(arg_22_0)
		if isSuccess(arg_22_0.result) then
			MoonCakeData:SetReceivedGroup(arg_21_0, arg_21_1)
			getReward2(arg_22_0.item_list)
			var_0_0.UpdateCakeCollectTaskPoint(arg_21_0)
			manager.notify:CallUpdateFunc(MOON_CAKE_COLLECT_RECEIVE)
		else
			ShowTips(arg_22_0.result)
		end
	end)
end

function var_0_0.OpenParty(arg_23_0, arg_23_1)
	manager.net:SendWithLoadingNew(72102, {
		open_type = arg_23_1,
		activity_id = arg_23_0
	}, 72103, function(arg_24_0)
		if isSuccess(arg_24_0.result) then
			MoonCakeData:OpenParty(arg_23_0, arg_23_1)
			var_0_0.UpdatePartyOpenPoint(arg_23_0)
			manager.notify:CallUpdateFunc(MOON_PARTY_OPEN)
		else
			ShowTips(arg_24_0.result)
		end
	end)
end

function var_0_0.TryQueryRecommendParty(arg_25_0)
	if not MoonCakeData:IsRefreshedRecommend(arg_25_0) then
		var_0_0.RefreshRecommendParty(arg_25_0, function()
			JumpTools.OpenPageByJump("moonPartyVisit", {
				activityID = arg_25_0
			})
		end)
	else
		JumpTools.OpenPageByJump("moonPartyVisit", {
			activityID = arg_25_0
		})
	end
end

function var_0_0.RefreshRecommendParty(arg_27_0, arg_27_1)
	manager.net:SendWithLoadingNew(72104, {
		activity_id = arg_27_0
	}, 72105, function(arg_28_0)
		if isSuccess(arg_28_0.result) then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_SUCCESS")
			MoonCakeData:UpdateRecommendParty(arg_27_0, arg_28_0.recommend_list, arg_28_0.timestamp)
			manager.notify:CallUpdateFunc(MOOD_PARTY_RECOMMEND_UPDATE)

			if arg_27_1 then
				arg_27_1()
			end
		else
			ShowTips(arg_28_0.result)
		end
	end)
end

function var_0_0.RequirePartyOwnerData(arg_29_0, arg_29_1, arg_29_2)
	manager.net:SendWithLoadingNew(72112, {
		activity_id = arg_29_0,
		user_id = arg_29_1
	}, 72113, function(arg_30_0)
		if isSuccess(arg_30_0.result) then
			MoonCakeData:SaveVisitPartyOwnerData(arg_29_0, arg_30_0.user_info)

			if arg_29_2 then
				arg_29_2()
			end
		else
			ShowTips(arg_30_0.result)
		end
	end)
end

function var_0_0.VisitParty(arg_31_0, arg_31_1, arg_31_2)
	manager.net:SendWithLoadingNew(72106, {
		user_id = arg_31_1,
		activity_id = arg_31_0
	}, 72107, function(arg_32_0)
		if isSuccess(arg_32_0.result) then
			MoonCakeData:SaveVisitPartyData(arg_31_0, arg_32_0.banquet, arg_31_1)
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = arg_31_0,
				mainActivityID = MoonCakeTools.GetMainActivityID(arg_31_0),
				partyOwnerUID = arg_31_1,
				visitWay = arg_31_2
			})
			var_0_0.UpdatePartyOpenPoint(arg_31_0)
			SDKTools.SendMessageToSDK("activity_mid_autumn_phase2_party_visit", {
				activity_id = arg_31_0,
				host_player_uid = arg_31_1,
				way = arg_31_2
			})
		else
			ShowTips(arg_32_0.result)
		end
	end)
end

function var_0_0.VisitNextParty(arg_33_0)
	local var_33_0 = MoonCakeData:GetTempVisitIndex(arg_33_0)
	local var_33_1 = var_33_0.type
	local var_33_2 = var_33_0.index
	local var_33_3 = {}

	if var_33_0.type == MoonCakeConst.VISIT_TYPE.ALL then
		var_33_3 = MoonCakeData:GetSortedRecommendPartyList(arg_33_0)
	elseif var_33_1 == MoonCakeConst.VISIT_TYPE.FRIEND then
		var_33_3 = MoonCakeData:GetSortedFriendPartyList(arg_33_0)
	end

	local var_33_4 = var_33_2 + 1

	if var_33_2 + 1 > #var_33_3 then
		return
	end

	visitData = var_33_3[var_33_4]

	MoonCakeData:SetTempVisitIndex(arg_33_0, var_33_1, var_33_4)
	var_0_0.VisitParty(arg_33_0, visitData.uid, MoonCakeConst.VISIT_WAY.NEXT_BTN)
end

function var_0_0.ReceiveVisitReward(arg_34_0, arg_34_1)
	manager.net:SendWithLoadingNew(72108, {
		user_id = arg_34_1,
		activity_id = arg_34_0
	}, 72109, function(arg_35_0)
		if isSuccess(arg_35_0.result) then
			MoonCakeData:ReceivedVisitReward(arg_34_0, arg_34_1)
			getReward2(arg_35_0.item_list)
			var_0_0.UpdatePartyRewardPoint(arg_34_0)
			manager.notify:CallUpdateFunc(MOON_PARTY_VISIT_REWARD_RECEIVED)
		else
			ShowTips(arg_35_0.result)
		end
	end)
end

function var_0_0.OnOpenGift(arg_36_0, arg_36_1)
	if not ActivityData:GetActivityIsOpen(arg_36_0) then
		return
	end

	if ActivityData:GetActivityIsOpen(arg_36_0) then
		local var_36_0 = MoonCakeTools.GetCakeIdDicByCakeItemID()

		for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
			if ItemCfg[iter_36_1.id].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE then
				if var_36_0[iter_36_1.id] ~= nil then
					MoonCakeData:SetUnlockCake(arg_36_0, var_36_0[iter_36_1.id])
				end
			end
		end

		MoonCakeAction.UpdateFillingMakeRedPoint(arg_36_0)
		MoonCakeAction.UpdateCakeCollectTaskPoint(arg_36_0)
	end
end

function var_0_0.InitRedPoint()
	for iter_37_0, iter_37_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.MOON_CAKE]) do
		local var_37_0
		local var_37_1

		for iter_37_2, iter_37_3 in ipairs(ActivityCfg[iter_37_1].sub_activity_list) do
			local var_37_2 = {}

			for iter_37_4, iter_37_5 in ipairs(ActivityCfg[iter_37_3].sub_activity_list) do
				if ActivityCfg[iter_37_5].activity_template == ActivityTemplateConst.TASK then
					var_37_2[#var_37_2 + 1] = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, iter_37_5)
				end
			end

			local var_37_3 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, iter_37_3)

			manager.redPoint:addGroup(var_37_3, var_37_2)

			if ActivityCfg[iter_37_3].activity_template == ActivityTemplateConst.MOON_CAKE_MAKE then
				var_37_0 = string.format("%s_%s", RedPointConst.MOON_CAKE_STAGE, iter_37_3)

				local var_37_4 = string.format("%s_%s", RedPointConst.MOON_DELEGATE, iter_37_3)

				manager.redPoint:addGroup(var_37_4, {
					string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, iter_37_3),
					(string.format("%s_%s", RedPointConst.MOON_DELEGATE_REWARD, iter_37_3))
				})
				manager.redPoint:addGroup(var_37_0, {
					string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, iter_37_3),
					string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, iter_37_3),
					var_37_4,
					var_37_3,
					(string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, iter_37_3))
				})
			elseif ActivityCfg[iter_37_3].activity_template == ActivityTemplateConst.MOON_CAKE_PARTY then
				var_37_1 = string.format("%s_%s", RedPointConst.MOON_PARTY_STAGE, iter_37_3)

				manager.redPoint:addGroup(var_37_1, {
					string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, iter_37_3),
					string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, iter_37_3),
					var_37_3,
					(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO))
				})
			end
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.MOON_CAKE, iter_37_1), {
			var_37_0,
			var_37_1
		})
	end
end

function var_0_0.UpdateFillingMakeRedPoint(arg_38_0)
	if not MoonCakeData:GetSelectMakeFillingBtn(arg_38_0) then
		for iter_38_0, iter_38_1 in ipairs(MoonCakeFillingCfg.get_id_list_by_activity[arg_38_0]) do
			local var_38_0 = true

			for iter_38_2, iter_38_3 in ipairs(MoonCakeFillingCfg[iter_38_1].recipe) do
				if ItemTools.getItemNum(iter_38_3[1]) < iter_38_3[2] then
					var_38_0 = false

					break
				end
			end

			if var_38_0 == true then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_38_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_38_0), 0)
end

function var_0_0.UpdateCakeMakeRedPoint(arg_39_0)
	local var_39_0 = 0

	if not MoonCakeData:GetSelectMakeCakeBtn(arg_39_0) then
		for iter_39_0, iter_39_1 in ipairs(MoonCakeCfg.get_id_list_by_activity[arg_39_0]) do
			if ItemTools.getItemNum(MoonCakeFillingCfg[MoonCakeCfg[iter_39_1].patties].patties) > 0 then
				var_39_0 = 1

				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, arg_39_0), var_39_0)
end

function var_0_0.UpdateCakeCollectTaskPoint(arg_40_0)
	local var_40_0 = MoonCakeData:GetUnlockCakeDic(arg_40_0)
	local var_40_1 = MoonCakeData:GetReceivedGroupDic(arg_40_0)
	local var_40_2 = 0

	for iter_40_0, iter_40_1 in ipairs(MoonCakeGroupCfg.get_id_list_by_activity[arg_40_0]) do
		local var_40_3 = true

		for iter_40_2, iter_40_3 in ipairs(MoonCakeGroupCfg[iter_40_1].collect_condition) do
			if not var_40_0[iter_40_3] then
				var_40_3 = false

				break
			end
		end

		if var_40_3 and not var_40_1[iter_40_1] then
			var_40_2 = 1

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, arg_40_0), var_40_2)
end

function var_0_0.UpdateDelegateDispatchPoint(arg_41_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, arg_41_0), (not MoonCakeData:GetSelectDelegateDispatchBtn(arg_41_0) and MoonCakeData:GetTodayDisptachTimes(arg_41_0) < GameSetting.activity_mid_autumn_entrust_release_limit.value[1] and MoonCakeData:GetOwnRunningDelegate(arg_41_0).delegateID == nil or nil) and 1)
end

function var_0_0.UpdateDelegateRewardPoint(arg_42_0)
	local var_42_0 = MoonCakeData:GetOwnRunningDelegate(arg_42_0)

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_REWARD, arg_42_0), (var_42_0.delegateID ~= nil and var_42_0.isCompleted == true and var_42_0.isReceived == false or nil) and 1)
end

function var_0_0.CloseCakeStageRedPoint(arg_43_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_43_0), 0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, arg_43_0), 0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, arg_43_0), 0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, arg_43_0), 0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_DELEGATE_REWARD, arg_43_0), 0)
	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.ACTIVITY_TASK, arg_43_0), 0)
end

function var_0_0.UpdatePartyOpenPoint(arg_44_0)
	local var_44_0 = 0

	if not MoonCakeData:GetOwnPartyData(arg_44_0).isOpened then
		local var_44_1, var_44_2, var_44_3 = MoonCakeTools.CheckPartyPlanValid(arg_44_0, MoonCakeConst.PARTY_TYPE.CAKE)

		if var_44_1 then
			var_44_0 = 1
		else
			local var_44_4, var_44_5, var_44_6 = MoonCakeTools.CheckPartyPlanValid(arg_44_0, MoonCakeConst.PARTY_TYPE.VISIT)

			if var_44_4 then
				var_44_0 = 1
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, arg_44_0), var_44_0)
end

function var_0_0.UpdatePartyRewardPoint(arg_45_0)
	local var_45_1 = MoonCakeData:GetTodayVisitRewardTimes(arg_45_0)

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, arg_45_0), (not var_45_1 or var_45_1 < GameSetting.activity_mid_autumn_present_limit.value[1] or nil) and 1)
end

function var_0_0.ClosePartytageRedPoint(arg_46_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, arg_46_0), 0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, arg_46_0), 0)
	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.ACTIVITY_TASK, arg_46_0), 0)
end

return var_0_0
