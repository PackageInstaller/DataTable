local var_0_0 = {}

manager.net:Bind(76001, function(arg_1_0)
	KagutsuchiTalentData:InitData(arg_1_0)
end)

function var_0_0.UpgradeTalent(arg_2_0, arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(76004, {
		activity_id = KagutsuchiWorkData:GetServerActivityID(),
		talent_id = arg_2_1
	}, 76005, function(arg_3_0, arg_3_1)
		arg_2_0:OnUpgradeTalent(arg_3_0, arg_3_1, arg_2_2)
	end)
end

function var_0_0.OnUpgradeTalent(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not isSuccess(arg_4_1.result) then
		ShowTips(arg_4_1.result)

		return
	end

	KagutsuchiTalentData:UpgradeTalent(arg_4_2.talent_id)
	arg_4_3(arg_4_1, arg_4_2)
end

function var_0_0.InitRedPoint(arg_5_0, arg_5_1)
	arg_5_0.BannedRedPoint_ = arg_5_0.BannedRedPoint_ or {}

	local var_5_0 = manager.time:GetServerTime()

	if arg_5_0.lastFreshTime_ and var_5_0 < arg_5_0.lastFreshTime_ then
		arg_5_0.BannedRedPoint_ = {}
	end

	arg_5_0.lastFreshTime_ = manager.time:GetNextFreshTime()

	local var_5_1 = arg_5_1.activity_id

	arg_5_0:UpdateRedPoint(var_5_1)
end

function var_0_0.UpdateRedPoint(arg_6_0, arg_6_1)
	local var_6_0 = ActivityTools.GetRedPointKey(arg_6_1) .. arg_6_1
	local var_6_1 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, var_6_0)
	local var_6_2 = ActivityData:GetActivityData(arg_6_1)

	if not ActivityData:GetActivityIsOpen(arg_6_1) then
		manager.redPoint:setTip(var_6_1, 0)

		return
	end

	if arg_6_0.BannedRedPoint_[var_6_1] then
		manager.redPoint:setTip(var_6_1, 0)

		return
	end

	local var_6_3 = false

	for iter_6_0, iter_6_1 in ipairs(KagutsuchiTalentData:GetTalentIdList()) do
		if KagutsuchiTalentData:CanUpgrade(iter_6_1) then
			var_6_3 = true

			break
		end
	end

	manager.redPoint:setTip(var_6_1, var_6_3 and 1 or 0)
end

function var_0_0.BanRedPoint(arg_7_0, arg_7_1)
	arg_7_0.BannedRedPoint_[arg_7_1] = true
end

return var_0_0
