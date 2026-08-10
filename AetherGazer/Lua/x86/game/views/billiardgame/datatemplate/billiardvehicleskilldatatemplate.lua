local var_0_0 = class("BilliardVehicleSkillDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.buffIdList = {}
	arg_1_0.level = 1
	arg_1_0.index = 0
	arg_1_0.graphId = 0
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.buffIdList = arg_2_1.buffIdList or {}
	arg_2_0.mainBuffId = arg_2_0.buffIdList[1]
	arg_2_0.level = arg_2_1.level or 1
	arg_2_0.index = arg_2_1.index or 0
	arg_2_0.isCombine_ = arg_2_0.buffIdList and #arg_2_0.buffIdList > 1

	arg_2_0:UpdateGraphId()
end

function var_0_0.AddLevel(arg_3_0, arg_3_1)
	BilliardGameLuaBridge.RemoveBuff(arg_3_0.graphId, BilliardGameMgr:GetHero())

	arg_3_0.level = arg_3_0.level + arg_3_1

	arg_3_0:UpdateGraphId()
end

function var_0_0.UpdateGraphId(arg_4_0)
	local var_4_0 = MergeBallBuffCfg[arg_4_0.mainBuffId]

	if var_4_0 then
		arg_4_0.graphId = var_4_0.skill_id[arg_4_0.level]
	end
end

return var_0_0
