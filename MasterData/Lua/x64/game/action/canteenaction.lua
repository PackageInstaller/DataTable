local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = {
		pos = arg_1_0.pos,
		extra_reward = arg_1_0.extra_reward,
		entrustID = CanteenEntrustData:GetEntrustByPos(arg_1_0.pos).id
	}
	local var_1_1 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternAwardAdd, nil, arg_1_0.pos)
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.reward_list) do
		local var_1_3 = {
			id = iter_1_1.id,
			num = iter_1_1.num
		}

		if arg_1_0.extra_reward == 1 then
			var_1_3.extraNum = iter_1_1.num - math.ceil(iter_1_1.num / ((100 + GameSetting.canteen_task_success.value[1]) / 100))
		end

		table.insert(var_1_2, var_1_3)
	end

	var_1_0.rewardList = var_1_2

	return var_1_0
end

local function var_0_2(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0 or CanteenEntrustData:GetEntrustList()) do
		if nullable(BackHomeCanteenTaskCfg, iter_2_1.id) and not CanteenEntrustData:IsEntrustStarted(iter_2_1) then
			table.insert(var_2_0, iter_2_1)
		end
	end

	CommonTools.UniversalSortEx(var_2_0, {
		map = function(self)
			return nullable(BackHomeCanteenTaskCfg, self.id, "task_level") or 0
		end
	})

	local var_2_1 = {}
	local var_2_2 = {}

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		local var_2_3 = CanteenTools.AutoSelectEntrustHero(iter_2_3, nil, var_2_1)

		if var_2_3 then
			for iter_2_4, iter_2_5 in ipairs(var_2_3) do
				var_2_1[DormData:GetHeroArchiveID(iter_2_5)] = true
			end

			var_2_2[iter_2_3] = var_2_3
		end
	end

	return var_2_2
end

function var_0_0.BatchSendTaskDispatchInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0 = arg_4_0 or DormConst.CANTEEN_ID

	local var_4_0 = var_0_2(arg_4_1)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_2 = nullable(arg_4_2, iter_4_0.pos) or CanteenEntrustData:GetTaskTimeLevel(iter_4_0.pos)

		table.insert(var_4_1, {
			pos = iter_4_0.pos,
			hero_list = iter_4_1,
			duration = BackHomeCanteenTaskCfg[iter_4_0.id].time[var_4_2][1]
		})
	end

	if #var_4_1 > 0 then
		manager.net:SendWithLoadingNew(58100, {
			architecture_id = arg_4_0,
			entrust_list = var_4_1
		}, 58101, var_0_0.OnBatchSendTaskDispatchInfo)
	elseif not CanteenTools.AnyAvailableEntrustHero() then
		ShowTips("DORM_CANTEEN_TASK_CANT_FIT")
	else
		local var_4_3 = false

		if not CanteenEntrustData.NoEntrustDispatched() then
			ShowTips("CANTEEN_TASK_DISPATCH_FAIL")
		else
			for iter_4_2, iter_4_3 in pairs(var_4_0) do
				if CanteenTools.AutoSelectEntrustHero(iter_4_2) then
					var_4_3 = true
				end
			end

			if var_4_3 then
				ShowTips("CANTEEN_TASK_DISPATCH_FAIL")
			else
				ShowTips("DORM_CANTEEN_TASK_CANT_FIT")
			end
		end
	end
end

function var_0_0:OnBatchSendTaskDispatchInfo(arg_5_1)
	if isSuccess(self.result) then
		ShowTips("CANTEEN_TASK_DISPATCH")

		for iter_5_0, iter_5_1 in ipairs(arg_5_1.entrust_list) do
			CanteenEntrustData:ConfirmEntrustListCallBack(iter_5_1)
		end
	else
		ShowTips(self.result)
	end
end

function var_0_0.SendTaskDispatchInfo(arg_6_0, arg_6_1)
	local var_6_0 = {}

	if arg_6_1.heroList == nil then
		var_6_0 = nil
	else
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.heroList) do
			table.insert(var_6_0, iter_6_1)
		end
	end

	manager.net:SendWithLoadingNew(58102, {
		architecture_id = arg_6_1.sceneID,
		pos = arg_6_1.pos,
		hero_list = var_6_0,
		duration = (arg_6_1.timeLevel or nil) and BackHomeCanteenTaskCfg[CanteenEntrustData:GetEntrustByPos(arg_6_1.pos).id].time[arg_6_1.timeLevel][1]
	}, 58103, var_0_0.OnSolveTaskDispatchCallBack)
end

function var_0_0:OnSolveTaskDispatchCallBack(arg_7_1)
	if isSuccess(self.result) then
		if arg_7_1.hero_list then
			ShowTips("CANTEEN_TASK_DISPATCH")
		else
			ShowTips("CANTEEN_TASK_DISPATCH_CANCEL")
		end

		CanteenEntrustData:ConfirmEntrustListCallBack(arg_7_1)
	else
		ShowTips(self.result)
		CanteenEntrustData:ClearDispatchCharacterList()
	end
end

function var_0_0.SetCharacterJob(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	manager.net:SendWithLoadingNew(58104, {
		architecture_id = DormConst.CANTEEN_ID,
		type = arg_8_1,
		hero_id = arg_8_2[1]
	}, 58105, function(arg_9_0, arg_9_1)
		var_0_0.OnSetCharacterJobCallBack(arg_9_0, arg_9_1)

		if arg_8_3 then
			arg_8_3()
		end
	end)
end

function var_0_0:OnSetCharacterJobCallBack(arg_10_1)
	if isSuccess(self.result) then
		local var_10_0 = CanteenHeroTools:GetCurWorkIDListByJobType(arg_10_1.type)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if DormNpcTools:CheckIDIsNpc(iter_10_1) then
				BackHomeNpcData:GetNpcInfoById(iter_10_1):SetJob(nil)
			else
				DormData:GetHeroInfo(iter_10_1):BackToDorm()
			end
		end

		if arg_10_1.hero_id > 0 then
			if DormNpcTools:CheckIDIsNpc(arg_10_1.hero_id) then
				BackHomeNpcData:GetNpcInfoById(arg_10_1.hero_id):SetJob(arg_10_1.type)
			else
				local var_10_1 = DormData:GetHeroTemplateInfo(arg_10_1.hero_id)

				var_10_1:SetCurHeroID(arg_10_1.hero_id)
				var_10_1:SetJob(arg_10_1.type)
				var_10_1:GoToCanteen()
			end
		elseif arg_10_1.hero_id == 0 and not DormNpcTools:CheckIDIsNpc(var_10_0[1]) then
			BackHomeNpcData:GetNpcInfoById(DormNpcTools:GetNpcInfoListByConstJobType(arg_10_1.type)[1]):SetJob(arg_10_1.type)
		end

		CanteenHeroTools:RefreshCanteenJobList()

		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
			manager.notify:Invoke(DORM_RESTAURANT_UPDATE_CHARACTER_BY_TYPE, DormEnum.RestaurantJobToClientMap[arg_10_1.type])
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
		end

		manager.notify:Invoke(CANTEEN_SET_JOG_SUCCESS)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReceiveCanteenAutoAward(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(58106, {
		architecture_id = arg_11_1
	}, 58107, var_0_0.OnCanteenAutoAwardCallBack)
end

function var_0_0:OnCanteenAutoAwardCallBack(arg_12_1)
	if isSuccess(self.result) then
		CanteenData:ReceiveCurPenEarSuccess(self.earnings, DormEnum.RestaurantMode.RestaurantAuto)
		manager.notify:Invoke(BACKHOME_CATEEN_AWARD_UPDATE)
		DormRedPointTools:CheckAutoAwardNumRedPoint()
	else
		ShowTips(self.result)
	end
end

local var_0_3

function var_0_0.ChangeCanteenMode(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0

	var_0_3 = arg_13_3

	if arg_13_2 == DormEnum.RestaurantMode.RestaurantAuto then
		var_13_0 = 0
	elseif arg_13_2 == DormEnum.RestaurantMode.RestaurantManual then
		var_13_0 = 1
	end

	if var_13_0 then
		manager.net:SendWithLoadingNew(58108, {
			architecture_id = arg_13_1,
			cmd = var_13_0
		}, 58109, var_0_0.ChangeCanteenModeCallBack)
	end
end

function var_0_0:ChangeCanteenModeCallBack(arg_14_1)
	if isSuccess(self.result) then
		local var_14_0 = {}

		if arg_14_1.cmd == 0 then
			var_14_0 = DormEnum.RestaurantMode.RestaurantAuto
		elseif arg_14_1.cmd == 1 then
			var_14_0 = DormEnum.RestaurantMode.RestaurantManual
		end

		CanteenData:ChangeCanteenStateSusscee(var_14_0, var_0_3)

		var_0_3 = nil
	else
		ShowTips(self.result)
	end
end

function var_0_0.RefreshEntrust(arg_15_0, arg_15_1, arg_15_2)
	manager.net:SendWithLoadingNew(58012, {
		architecture_id = arg_15_1,
		pos = arg_15_2
	}, 58013, var_0_0.RefreshEntrustCallBack)
end

function var_0_0:RefreshEntrustCallBack(arg_16_1)
	if isSuccess(self.result) then
		CanteenEntrustData:InitEntrustData(self.entrust)
		manager.notify:Invoke(CANTEEN_REFRESH_ENTRUST_CALLBACK, self.entrust.pos)
	else
		ShowTips(self.result)
	end
end

function var_0_0.SendSignFoodInfo(arg_17_0, arg_17_1, arg_17_2)
	manager.net:SendWithLoadingNew(58114, {
		architecture_id = DormConst.CANTEEN_ID,
		food_id = arg_17_1,
		sell_num = arg_17_2
	}, 58115, var_0_0.SetSignFoodCallBack)
end

function var_0_0:SetSignFoodCallBack(arg_18_1)
	if isSuccess(self.result) then
		if arg_18_1.sell_num > 0 then
			CanteenFoodData:PushFoodToSignList(arg_18_1.food_id, arg_18_1.sell_num)
		else
			CanteenFoodData:PushFoodToSignList(arg_18_1.food_id)
		end

		manager.notify:Invoke(CANTEEN_SET_SIGNFOOD_SUCCESS)
	else
		ShowTips(self.result)
	end
end

function var_0_0.CanteenFurnitureUpgrade(arg_19_0, arg_19_1)
	manager.net:SendWithLoadingNew(58116, {
		uid = arg_19_1
	}, 58117, var_0_0.CanteenFurnitureUpgradeCallBack)
end

function var_0_0:CanteenFurnitureUpgradeCallBack(arg_20_1)
	if isSuccess(self.result) then
		CanteenData:FurLevelUpCallBack(arg_20_1.uid)
		DormSkillData:CalCanSignFoodNum()
		DormSkillData:CalInComeStorageMaxNum()
		DormRedPointTools:CheckUnLockFoodRedPoint()
		manager.notify:Invoke(CANTEEN_FUR_LEVEL_UP)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReceiveEntrustAward(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_2) do
		table.insert(var_21_0, iter_21_1)
	end

	manager.net:SendWithLoadingNew(58018, {
		architecture_id = arg_21_1,
		pos = var_21_0
	}, 58019, var_0_0.ReceiveEntrustAwardCallBack)
end

function var_0_0:ReceiveEntrustAwardCallBack(arg_22_1)
	if isSuccess(self.result) then
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in ipairs(self.extra_reward) do
			local var_22_1 = CanteenEntrustData:GetEntrustByPos(iter_22_1.pos).id

			table.insert(var_22_0, (var_0_1(iter_22_1)))
		end

		for iter_22_2, iter_22_3 in ipairs(self.fatigue_list) do
			local var_22_2 = DormData:GetHeroInfo(iter_22_3.archives_id)

			var_22_2:SetFatigue(iter_22_3.fatigue)
			var_22_2:BackToDorm()
		end

		manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)
		CanteenEntrustData:EntrustFinish(var_22_0, self.entrust)
	else
		ShowTips(self.result)
	end
end

function var_0_0.CanteenManualSettlement(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_2) do
		table.insert(var_23_0, {
			food_id = iter_23_1.food_id,
			quality = iter_23_1.quality,
			guest_uid = iter_23_1.guest_uid,
			guest_id = iter_23_1.guest_id,
			special_event = iter_23_1.special_event,
			evaluate = iter_23_1.evaluate
		})
	end

	manager.net:SendWithLoadingNew(58120, {
		architecture_id = arg_23_1,
		oper_list = var_23_0
	}, 58121, var_0_0.CanteenManualSettlementCallBack)
end

function var_0_0:CanteenManualSettlementCallBack(arg_24_1)
	if isSuccess(self.result) then
		CanteenFoodData:GetManualAward(arg_24_1)
		manager.notify:Invoke(CANTEEN_MANUAL_REWARD_CALLBACK)
	else
		ShowTips(self.result)
	end
end

manager.net:Bind(58023, function(arg_25_0)
	CanteenData:RefreshAutoAwardInfo(arg_25_0)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.fatigue_list) do
		if iter_25_1 then
			local var_25_0 = DormData:GetHeroInfo(iter_25_1.archives_id)

			if var_25_0 then
				var_25_0:SetFatigue(iter_25_1.fatigue)
			end
		end
	end

	manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)

	for iter_25_2, iter_25_3 in ipairs(arg_25_0.signature_dish) do
		if iter_25_3 then
			CanteenFoodData:ReviseSignFoodInfo(iter_25_3)
		end
	end

	for iter_25_4, iter_25_5 in ipairs(arg_25_0.food) do
		if iter_25_5 then
			CanteenFoodData:UpdataFoodProficiency(iter_25_5)
		end
	end

	local var_25_1

	for iter_25_6, iter_25_7 in ipairs(arg_25_0.npc_change) do
		if iter_25_7 then
			local var_25_2 = BackHomeNpcData:GetNpcInfoById(iter_25_7)

			var_25_2:SetJob(var_25_2.constJobType)

			var_25_1 = true
		end
	end

	if var_25_1 then
		CanteenHeroTools:RefreshCanteenJobList()
		manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
	end

	DormRedPointTools:UpdateCanteenNotify()
	manager.notify:Invoke(DORM_RESTAURANT_UPDATE_FINISH)
end)

function var_0_0.UnLockEntrust(arg_26_0, arg_26_1)
	manager.net:SendWithLoadingNew(58024, {
		pos = arg_26_1
	}, 58025, var_0_0.UnLockEntrustCallBack)
end

function var_0_0:UnLockEntrustCallBack(arg_27_1)
	if isSuccess(self.result) then
		CanteenEntrustData:InitEntrustData(self.entrust)
		DormRedPointTools:CheckUnLockEntrustRedPoint()
		manager.notify:Invoke(CANTEEN_REFRESH_ENTRUST_CALLBACK, self.entrust.pos)
	else
		ShowTips(self.result)
	end
end

manager.net:Bind(58027, function(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.fatigue_list) do
		local var_28_0 = DormData:GetHeroInfo(iter_28_1.archives_id)

		if var_28_0 then
			var_28_0:SetFatigue(iter_28_1.fatigue)
		end

		for iter_28_2, iter_28_3 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
			if not CanteenHeroTools:HasJobAssignedToHero(iter_28_3) then
				manager.notify:Invoke(CANTEEN_UPDATE_STATE)

				break
			end
		end
	end

	manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)
end)

return var_0_0
