local var_0_0 = {}

manager.net:Bind(76001, function(arg_1_0)
	KagutsuchiWorkData:InitData(arg_1_0)
	Timer.New(function()
		KagutsuchiTalentAction:InitRedPoint(arg_1_0)
		KagutsuchiWorkAction:InitRedPoint(arg_1_0)
	end, 1, 0):Start()
end)

function var_0_0.StartEntrust(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	manager.net:SendWithLoadingNew(76002, {
		activity_id = KagutsuchiWorkData:GetServerActivityID(),
		grid_id = arg_3_1,
		hero_list = arg_3_2
	}, 76003, function(arg_4_0, arg_4_1)
		if not isSuccess(arg_4_0.result) then
			ShowTips(arg_4_0.result)

			return
		end

		arg_3_0:UpdateEntrustedHeros(arg_4_1.hero_list)
		arg_3_0:UpdateEntrustGridClearState(arg_4_1.grid_id)
		arg_3_3(arg_4_0)
	end)
end

function var_0_0.UpdateEntrustedHeros(arg_5_0, arg_5_1)
	KagutsuchiWorkData:UpdateEntrustedHeros(arg_5_1)
end

function var_0_0.UpdateEntrustGridClearState(arg_6_0, arg_6_1)
	KagutsuchiWorkData:SetGridClear(arg_6_1)
end

function var_0_0:InitRedPoint(arg_7_1)
	self.BannedRedPoint_ = self.BannedRedPoint_ or {}

	self:UpdateRedPoint(arg_7_1.activity_id)
end

function var_0_0:UpdateRedPoint(arg_8_1)
	local var_8_0 = ActivityTools.GetParentActivityID(arg_8_1)
	local var_8_1 = ActivityTools.GetRedPointKey(arg_8_1) .. arg_8_1
	local var_8_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_8_1)
	local var_8_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_8_1)
	local var_8_4 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_HANAFUDA, var_8_1)
	local var_8_5 = string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, (HanafudaData:GetActivityID()))
	local var_8_6 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, var_8_1)
	local var_8_7 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, var_8_1)
	local var_8_8 = {}

	table.insert(var_8_8, var_8_2)
	table.insert(var_8_8, var_8_5)
	manager.redPoint:addGroup(var_8_1, var_8_8)

	local var_8_9 = {}

	table.insert(var_8_9, var_8_4)
	table.insert(var_8_9, var_8_5)
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, var_8_1), var_8_9)

	local var_8_10 = {}

	table.insert(var_8_10, var_8_6)
	table.insert(var_8_10, var_8_7)
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, var_8_1), var_8_10)

	if not ActivityData:GetActivityIsOpen(arg_8_1) then
		manager.redPoint:setTip(var_8_2, 0)
		manager.redPoint:setTip(var_8_3, 0)
		manager.redPoint:setTip(var_8_4, 0)

		return
	end

	local var_8_11 = KagutsuchiWorkData:IsAllClear()
	local var_8_12 = KagutsuchiGachaData:GetPoolIds(ActivityConst.KAGUTSUCHI_ACTIVITY_REWARD)[1]
	local var_8_13 = KagutsuchiGachaData:GetPoolRemains(var_8_12) > 0

	if self.BannedRedPoint_[var_8_2] then
		manager.redPoint:setTip(var_8_2, 0)
	else
		manager.redPoint:setTip(var_8_2, not var_8_11 and var_8_13 and 1 or 0)
	end

	local var_8_14 = KagutsuchiWorkData:GetStamina() >= GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1]

	if self.BannedRedPoint_[var_8_3] then
		manager.redPoint:setTip(var_8_3, 0)
	else
		manager.redPoint:setTip(var_8_3, KagutsuchiFishingEventData:GetRestGameCount() > 0 and not var_8_14 and not var_8_11 and var_8_13 and 1 or 0)
	end

	if self.BannedRedPoint_[var_8_4] then
		manager.redPoint:setTip(var_8_4, 0)
	else
		manager.redPoint:setTip(var_8_4, not var_8_14 and not var_8_11 and var_8_13 and 1 or 0)
	end

	local var_8_15 = KagutsuchiGachaData:GetMaxDrawTimes(var_8_12)

	manager.redPoint:setTip(var_8_6, var_8_15 == 1 and 1 or 0)
	manager.redPoint:setTip(var_8_7, var_8_15 > 1 and 1 or 0)
end

function var_0_0:BanRedPoint(arg_9_1)
	self.BannedRedPoint_[arg_9_1] = true
end

return var_0_0
