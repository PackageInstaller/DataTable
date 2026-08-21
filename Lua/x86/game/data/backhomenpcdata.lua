BackHomeNpcTemplate = class("BackHomeNpcTemplate")

function BackHomeNpcTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.npcID = arg_1_1.id
	arg_1_0.fatigue = -1
	arg_1_0.jobType = arg_1_1.jobType
	arg_1_0.constJobType = arg_1_1.constJobType
end

function BackHomeNpcTemplate.SetJob(arg_2_0, arg_2_1)
	if not arg_2_1 then
		arg_2_0.jobType = arg_2_1
	elseif BackHomeNpcCfg[arg_2_0.npcID].npc_work > 0 then
		if BackHomeNpcCfg[arg_2_0.npcID].npc_work == arg_2_1 then
			arg_2_0.jobType = arg_2_1
		else
			print("设置npc职业和设置职业不符")

			return
		end
	else
		arg_2_0.jobType = arg_2_1
	end

	arg_2_0:DisposeRunSkill()
	arg_2_0:OpenHeroSkill()
end

function BackHomeNpcTemplate.DisposeRunSkill(arg_3_0)
	if arg_3_0.npcID then
		if not BackHomeNpcCfg[arg_3_0.npcID] then
			return
		end

		local var_3_0 = BackHomeNpcCfg[arg_3_0.npcID].skill_list

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if DormSkillData:CheckSkillIsRun(arg_3_0.npcID, iter_3_1, DormEnum.EntityType.Character) then
				DormSkillData:DisposeSkillComponent(arg_3_0.npcID, iter_3_1, DormEnum.EntityType.Character)
			end
		end
	end
end

function BackHomeNpcTemplate.OpenHeroSkill(arg_4_0)
	if arg_4_0.npcID then
		local var_4_0 = BackHomeNpcCfg[arg_4_0.npcID].skill_list

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if DormSkillData:CheckSkillIsOpen(arg_4_0.npcID, iter_4_1, DormEnum.EntityType.Character) then
				DormSkillData:AddSkillComponent(arg_4_0.npcID, iter_4_1, DormEnum.EntityType.Character)
			end
		end
	end
end

function BackHomeNpcTemplate.GetCurRoomID(arg_5_0)
	if arg_5_0.jobType then
		return DormConst.CANTEEN_ID
	end
end

function BackHomeNpcTemplate.GetHeroState(arg_6_0)
	if arg_6_0.jobType then
		return DormEnum.DormHeroState.InCanteenJob
	end
end

local var_0_0 = singletonClass("BackHomeNpcData")
local var_0_1

function var_0_0.InitNpcInfo(arg_7_0, arg_7_1)
	var_0_1 = {}

	for iter_7_0, iter_7_1 in ipairs(BackHomeNpcCfg.all) do
		local var_7_0 = {
			id = iter_7_1,
			constJobType = BackHomeNpcCfg[iter_7_1].npc_work
		}
		local var_7_1 = BackHomeNpcTemplate.New(var_7_0)

		var_0_1[iter_7_1] = var_7_1
	end
end

function var_0_0.GetBackHomeNpcInfoList(arg_8_0)
	return var_0_1
end

function var_0_0.GetNpcInfoById(arg_9_0, arg_9_1)
	if var_0_1 then
		return var_0_1[arg_9_1]
	end
end

function var_0_0.CheckNpsIsWorkInCanteen(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(var_0_1) do
		if iter_10_1.jobType then
			table.insert(var_10_0, iter_10_1)
		end
	end

	if #var_10_0 > 0 then
		return true, var_10_0
	else
		return false
	end
end

return var_0_0
