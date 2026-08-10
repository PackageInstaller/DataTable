local var_0_0 = singletonClass("SkinTrialData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	arg_1_0.skinTrialStateList_ = {}
	arg_1_0.completedSkinTrialIDList_ = {}
	arg_1_0.stageIDToSkinTrialID_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info) do
		local var_2_1 = iter_2_1.id

		if ActivitySkinTrialCfg[var_2_1] ~= nil then
			arg_2_0.skinTrialStateList_[var_2_1] = iter_2_1.state

			if not var_2_0[var_2_1] then
				var_2_0[var_2_1] = 0
			end

			if iter_2_1.state == 1 then
				if table.keyof(arg_2_0.completedSkinTrialIDList_, var_2_1) == nil then
					table.insert(arg_2_0.completedSkinTrialIDList_, var_2_1)
				end
			else
				var_2_0[var_2_1] = 1
			end
		end
	end

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, iter_2_2), iter_2_3)
	end
end

function var_0_0.OnRewardSuccess(arg_3_0, arg_3_1)
	arg_3_0.skinTrialStateList_[arg_3_1] = 1

	if table.keyof(arg_3_0.completedSkinTrialIDList_, arg_3_1) == nil then
		table.insert(arg_3_0.completedSkinTrialIDList_, arg_3_1)
	end

	arg_3_0:SetSelectSkinTrialID(arg_3_1)
end

function var_0_0.GetSkinTrialStateList(arg_4_0)
	return arg_4_0.skinTrialStateList_
end

function var_0_0.SetSelectSkinTrialID(arg_5_0, arg_5_1)
	local var_5_0 = ActivitySkinTrialCfg[arg_5_1].activity_id

	saveData("SkinTrial", string.format("select_%s_%s", var_5_0, arg_5_1), true)

	local var_5_1 = ActivitySkinTrialCfg[arg_5_1]

	if arg_5_0:GetSkinTrialStatus(arg_5_1) ~= 2 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_5_1), 0)
	end
end

function var_0_0.GetSelectSkinTrialID(arg_6_0, arg_6_1)
	local var_6_0 = ActivitySkinTrialCfg[arg_6_1].activity_id

	return getData("SkinTrial", string.format("select_%s_%s", var_6_0, arg_6_1))
end

function var_0_0.IsCompleted(arg_7_0, arg_7_1)
	if table.keyof(arg_7_0.completedSkinTrialIDList_, arg_7_1) then
		return true
	else
		return false
	end
end

function var_0_0.SaveStageID(arg_8_0, arg_8_1)
	local var_8_0 = ActivitySkinTrialCfg[arg_8_1].stage_id

	arg_8_0.stageIDToSkinTrialID_[var_8_0] = arg_8_1
end

function var_0_0.GetSkinTrialID(arg_9_0, arg_9_1)
	return arg_9_0.stageIDToSkinTrialID_[arg_9_1]
end

function var_0_0.SaveRoute(arg_10_0, arg_10_1)
	var_0_1 = deepClone(arg_10_1)
end

function var_0_0.GetRoute(arg_11_0)
	return var_0_1
end

function var_0_0.SaveSkinTrialMainScrollPos(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == "Global" then
		arg_12_0.selectTrialPos = arg_12_1
	elseif arg_12_2 == "Back" then
		arg_12_0.backTrialPos = arg_12_1
	end
end

function var_0_0.GetSkinTrialMainScrollPos(arg_13_0, arg_13_1)
	if arg_13_1 == "Global" then
		return arg_13_0.selectTrialPos
	elseif arg_13_1 == "Back" then
		return arg_13_0.backTrialPos
	end
end

function var_0_0.GetSkinTrialStatus(arg_14_0, arg_14_1)
	return arg_14_0.skinTrialStateList_[arg_14_1] or 0
end

return var_0_0
