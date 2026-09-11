local var_0_0 = singletonClass("SkinTrialData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	arg_1_0.skinTrialStateList_ = {}
	arg_1_0.completedSkinTrialIDList_ = {}
	arg_1_0.stageIDToSkinTrialID_ = {}
end

function var_0_0:InitData(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info) do
		if ActivitySkinTrialCfg[iter_2_1.id] ~= nil then
			self.skinTrialStateList_[iter_2_1.id] = iter_2_1.state
			var_2_0[iter_2_1.id] = var_2_0[iter_2_1.id] or 0

			if iter_2_1.state == 1 then
				if table.keyof(self.completedSkinTrialIDList_, iter_2_1.id) == nil then
					table.insert(self.completedSkinTrialIDList_, iter_2_1.id)
				end
			else
				var_2_0[iter_2_1.id] = 1
			end
		end
	end

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, iter_2_2), iter_2_3)
	end
end

function var_0_0:OnRewardSuccess(arg_3_1)
	self.skinTrialStateList_[arg_3_1] = 1

	if table.keyof(self.completedSkinTrialIDList_, arg_3_1) == nil then
		table.insert(self.completedSkinTrialIDList_, arg_3_1)
	end

	self:SetSelectSkinTrialID(arg_3_1)
end

function var_0_0:GetSkinTrialStateList()
	return self.skinTrialStateList_
end

function var_0_0:SetSelectSkinTrialID(arg_5_1)
	saveData("SkinTrial", string.format("select_%s_%s", ActivitySkinTrialCfg[arg_5_1].activity_id, arg_5_1), true)

	if self:GetSkinTrialStatus(arg_5_1) ~= 2 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_5_1), 0)
	end
end

function var_0_0.GetSelectSkinTrialID(arg_6_0, arg_6_1)
	return getData("SkinTrial", string.format("select_%s_%s", ActivitySkinTrialCfg[arg_6_1].activity_id, arg_6_1))
end

function var_0_0:IsCompleted(arg_7_1)
	if table.keyof(self.completedSkinTrialIDList_, arg_7_1) then
		return true
	else
		return false
	end
end

function var_0_0:SaveStageID(arg_8_1)
	self.stageIDToSkinTrialID_[ActivitySkinTrialCfg[arg_8_1].stage_id] = arg_8_1
end

function var_0_0:GetSkinTrialID(arg_9_1)
	return self.stageIDToSkinTrialID_[arg_9_1]
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

function var_0_0:GetSkinTrialMainScrollPos(arg_13_1)
	if arg_13_1 == "Global" then
		return self.selectTrialPos
	elseif arg_13_1 == "Back" then
		return self.backTrialPos
	end
end

function var_0_0:GetSkinTrialStatus(arg_14_1)
	return self.skinTrialStateList_[arg_14_1] or 0
end

return var_0_0
