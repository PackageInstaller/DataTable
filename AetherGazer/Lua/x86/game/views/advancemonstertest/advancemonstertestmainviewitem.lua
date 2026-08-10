local var_0_0 = class("AdvanceMonsterTestMainViewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.stageID_ = arg_4_1

	arg_4_0:UpdateView()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/advanceMonsterAffixView", {
			stageID = arg_5_0.stageID_
		})
	end)
end

function var_0_0.UpdateView(arg_7_0)
	if ActivityAdvanceMonsterTestCfg[arg_7_0.stageID_].type == 1 then
		arg_7_0:UpdateCurrentUI()
	else
		arg_7_0:UpdateLookBackUI()
	end
end

function var_0_0.UpdateCurrentUI(arg_8_0)
	local var_8_0 = ActivityAdvanceMonsterTestCfg[arg_8_0.stageID_]
	local var_8_1 = BattleActivityAdvanceMonsterTestCfg[var_8_0.stage_id]

	arg_8_0.nameText_.text = GetI18NText(var_8_1.name)
	arg_8_0.pointText_.text = AdvanceMonsterTestData:GetStagePoint(arg_8_0.stageID_)

	local var_8_2 = ""

	for iter_8_0, iter_8_1 in pairs(var_8_0.boss_list) do
		var_8_2 = var_8_2 .. iter_8_1
	end

	arg_8_0.image_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_8_2)
end

function var_0_0.UpdateLookBackUI(arg_9_0)
	local var_9_0 = ActivityAdvanceMonsterTestCfg[arg_9_0.stageID_]
	local var_9_1 = BattleActivityAdvanceMonsterTestCfg[var_9_0.stage_id]

	arg_9_0.nameText_.text = GetI18NText(var_9_1.name)
	arg_9_0.descText_.text = GetI18NText(var_9_1.tips)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
