local var_0_0 = singletonClass("proposalData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.InitProposal(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_0_1[iter_2_1.id] = {}
		var_0_1[iter_2_1.id].proposal_id = iter_2_1.id
		var_0_1[iter_2_1.id].proposal_name = iter_2_1.name
		var_0_1[iter_2_1.id].equip_list = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.equip) do
			var_0_1[iter_2_1.id].equip_list[iter_2_2] = {
				pos = iter_2_3.pos,
				equip_id = iter_2_3.equip_id
			}

			if iter_2_3.equip_id ~= 0 then
				if not var_0_2[iter_2_3.equip_id] then
					var_0_2[iter_2_3.equip_id] = 1
				else
					var_0_2[iter_2_3.equip_id] = var_0_2[iter_2_3.equip_id] + 1
				end
			end
		end
	end
end

function var_0_0.IsProposalMax(arg_3_0)
	local var_3_0 = GameSetting.equip_proposal_num_max.value[1]
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		var_3_1 = var_3_1 + 1
	end

	return var_3_0 <= var_3_1
end

function var_0_0.HaveProposal(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.Tools.SetEquipListFormat(arg_4_1)

	for iter_4_0, iter_4_1 in pairs(var_0_1) do
		if table.equal(iter_4_1.equip_list, var_4_0, "all") then
			return true
		end
	end

	return false
end

function var_0_0.GetProposalByID(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1]
end

function var_0_0.ModifyProposal(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not var_0_1[arg_6_3] then
		error("似乎发生了错误")
	end

	var_0_1[arg_6_3].proposal_name = arg_6_2
end

function var_0_0.AddProposal(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_1[arg_7_3] = {}
	var_0_1[arg_7_3].proposal_id = arg_7_3
	var_0_1[arg_7_3].proposal_name = arg_7_2
	var_0_1[arg_7_3].equip_list = {}

	local var_7_0 = HeroTools.GetHeroEquipS(arg_7_1)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		var_0_1[arg_7_3].equip_list[iter_7_0] = {
			pos = iter_7_1.pos,
			equip_id = iter_7_1.equip_id
		}

		if iter_7_1.equip_id ~= 0 then
			if not var_0_2[iter_7_1.equip_id] then
				var_0_2[iter_7_1.equip_id] = 1
			else
				var_0_2[iter_7_1.equip_id] = var_0_2[iter_7_1.equip_id] + 1
			end
		end
	end
end

function var_0_0.AddProposalCommon(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	var_0_1[arg_8_3] = {}
	var_0_1[arg_8_3].proposal_id = arg_8_3
	var_0_1[arg_8_3].proposal_name = arg_8_2
	var_0_1[arg_8_3].equip_list = {}
	arg_8_1 = var_0_0.Tools.SetEquipListFormat(arg_8_1)

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		var_0_1[arg_8_3].equip_list[iter_8_1.pos] = {
			pos = iter_8_1.pos,
			equip_id = iter_8_1.equip_id
		}

		if iter_8_1.equip_id ~= 0 then
			if not var_0_2[iter_8_1.equip_id] then
				var_0_2[iter_8_1.equip_id] = 1
			else
				var_0_2[iter_8_1.equip_id] = var_0_2[iter_8_1.equip_id] + 1
			end
		end
	end
end

function var_0_0.DeleteProposal(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1[arg_9_1].equip_list

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1.equip_id ~= 0 then
			var_0_2[iter_9_1.equip_id] = var_0_2[iter_9_1.equip_id] - 1

			if var_0_2[iter_9_1.equip_id] == 0 then
				var_0_2[iter_9_1.equip_id] = nil
			end
		end
	end

	var_0_1[arg_9_1] = nil
end

function var_0_0.GetProposalData(arg_10_0)
	return var_0_1
end

function var_0_0.GetEquipMap(arg_11_0)
	return var_0_2
end

var_0_0.Tools = {}

function var_0_0.Tools.SetEquipListFormat(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		var_12_0[iter_12_1.pos] = {
			equip_id = iter_12_1.equip_id,
			pos = iter_12_1.pos
		}
	end

	for iter_12_2 = 1, 6 do
		if not var_12_0[iter_12_2] then
			var_12_0[iter_12_2] = {
				equip_id = 0,
				pos = iter_12_2
			}
		end
	end

	return var_12_0
end

function var_0_0.RemoveProposalByEquip(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(var_0_1) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1.equip_list) do
			if iter_13_3.equip_id ~= 0 and table.keyof(arg_13_1, iter_13_3.equip_id) then
				iter_13_1.proposal_id = nil
				var_0_2[iter_13_3.equip_id] = var_0_2[iter_13_3.equip_id] - 1
			end
		end
	end

	local var_13_0 = {}

	for iter_13_4, iter_13_5 in ipairs(var_0_1) do
		if iter_13_5.proposal_id ~= nil then
			var_13_0[#var_13_0 + 1] = deepClone(iter_13_5)
			var_13_0[#var_13_0].proposal_id = #var_13_0
		end
	end

	var_0_1 = var_13_0
end

return var_0_0
