local var_0_0 = class("SequentialBattleBuffInfoCondition", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = SequentialBattleBuffCfg[arg_3_3]

	arg_3_0.descText_.text = GetI18NText(var_3_0.type_desc[arg_3_4])

	if arg_3_2 then
		local var_3_1 = table.keyof(SequentialBattleChapterCfg[arg_3_1].stage_id, arg_3_2)
		local var_3_2 = arg_3_0:GetHeroList(arg_3_1, var_3_1)
		local var_3_3 = SequentialBattleBuffCfg[arg_3_3].type
		local var_3_4 = SequentialBattleTools.GetConditionStatus(var_3_2, var_3_3)

		if var_3_4[arg_3_4] >= var_3_3[arg_3_4][3] then
			arg_3_0.cntText_.text = string.format("<color=#6AA788>%s/%s</color>", var_3_4[arg_3_4], var_3_3[arg_3_4][3])
		else
			arg_3_0.cntText_.text = string.format("<color=#F96763>%s/%s</color>", var_3_4[arg_3_4], var_3_3[arg_3_4][3])
		end
	else
		arg_3_0.cntText_.text = ""
	end

	arg_3_0:Show(true)
end

function var_0_0.GetHeroList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE, arg_4_1, arg_4_2, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[arg_4_1].stage_id[arg_4_2],
		activityID = arg_4_1
	})

	return (ReserveTools.GetHeroList(var_4_0))
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

return var_0_0
