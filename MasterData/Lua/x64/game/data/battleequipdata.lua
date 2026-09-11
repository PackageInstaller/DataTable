local var_0_0 = singletonClass("BattleEquipData")
local var_0_1 = {
	upSuitId = 0,
	baseStageId = 0,
	EquipNewTagKey = "BattleEquipNewTag_",
	guaranteeNum = {}
}

function var_0_0:InitBattleEquipData(arg_1_1)
	var_0_1.baseStageId = arg_1_1.stage_base_id
	var_0_1.upSuitId = arg_1_1.equip_suit_id
	var_0_1.next_refresh_time = arg_1_1.next_refresh_time

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.insure_list) do
		var_0_1.guaranteeNum[iter_1_1.difficulty] = iter_1_1.insure_times
	end

	self:InitNewTagData()
end

function var_0_0.ChangeUpSuitId(arg_2_0, arg_2_1)
	var_0_1.upSuitId = arg_2_1
end

function var_0_0.SetGuaranteeNum(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.guaranteeNum[arg_3_1] = arg_3_2
end

function var_0_0.AddGuaranteeNum(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.guaranteeNum[arg_4_1] = (var_0_1.guaranteeNum[arg_4_1] or 0) + arg_4_2
end

function var_0_0.GetBattleEquipData(arg_5_0)
	return var_0_1
end

function var_0_0.GetGuaranteeNum(arg_6_0)
	return var_0_1.guaranteeNum
end

function var_0_0.AlreadyPlayOnce(arg_7_0, arg_7_1)
	if var_0_1.guaranteeNum[arg_7_1] ~= nil then
		return true
	end

	return false
end

function var_0_0:InitNewTagData()
	if SystemData:ServerSystemIsLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP) then
		return
	end

	local var_8_0 = var_0_1.baseStageId
	local var_8_3
	local var_8_2
	local var_8_1

	if not var_0_1.baseStageId or var_8_0 == 0 then
		do return end

		var_8_1 = getData("battleEquipNewTag", "newTag") or {}
		var_8_2 = {}
		var_8_3 = 1
	end

	for iter_8_0, iter_8_1 in ipairs(StageGroupCfg[var_8_0].stage_list) do
		if BattleStageData:GetStageIsOpen(iter_8_1) then
			if var_8_1[iter_8_0] ~= nil then
				if self:AlreadyPlayOnce(iter_8_0) then
					var_8_2[iter_8_0] = false
				else
					var_8_2[iter_8_0] = var_8_1[iter_8_0]
				end
			else
				var_8_2[iter_8_0] = not self:AlreadyPlayOnce(iter_8_0)
			end

			var_8_3 = iter_8_0
		end
	end

	self:AppendRedKey(var_8_3)
	self:ClearNewTag(var_8_3)
	saveData("battleEquipNewTag", "newTag", var_8_2)
	self:DispatchNewTag()
end

function var_0_0:OnSystemUnlock(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1 == ViewConst.SYSTEM_ID.BATTLE_EQUIP then
			self:InitNewTagData()

			break
		end
	end
end

function var_0_0.DispatchNewTag(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(getData("battleEquipNewTag", "newTag") or {}) do
		if iter_10_1 then
			manager.redPoint:setTip(var_0_1.EquipNewTagKey .. iter_10_0, 1, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.AppendRedKey(arg_11_0, arg_11_1)
	for iter_11_0 = 1, arg_11_1 do
		manager.redPoint:appendGroup(RedPointConst.BATTLE_EQUIP, var_0_1.EquipNewTagKey .. iter_11_0)
	end
end

function var_0_0.ClearNewTag(arg_12_0, arg_12_1)
	for iter_12_0 = 1, arg_12_1 do
		manager.redPoint:setTip(var_0_1.EquipNewTagKey .. iter_12_0, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.CancelNewTag(arg_13_0, arg_13_1)
	local var_13_0 = getData("battleEquipNewTag", "newTag")

	if arg_13_1 and var_13_0 and var_13_0[arg_13_1] == true then
		var_13_0[arg_13_1] = false

		manager.redPoint:setTip(var_0_1.EquipNewTagKey .. arg_13_1, 0, RedPointStyle.SHOW_NEW_TAG)
		saveData("battleEquipNewTag", "newTag", var_13_0)
	end
end

function var_0_0.GetNewRedPrefix(arg_14_0)
	return var_0_1.EquipNewTagKey
end

return var_0_0
