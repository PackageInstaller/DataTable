local var_0_0 = class("IdolCompetitionResultItem", ReduxView)

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

	arg_3_0.winController_ = arg_3_0.mainControllerEx_:GetController("win")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = IdolTraineePvpBattleCfg[arg_5_1.stageID]

	if var_5_0 then
		local var_5_1 = IdolStageSceneCfg[var_5_0.scene_id]

		if var_5_1 then
			arg_5_0.stageImg_.spriteSync = SpritePathCfg.IdolStageIcon.path .. var_5_1.stage_picture
			arg_5_0.stageText_.text = var_5_1.scene_show_name
		end
	end

	arg_5_0.p1scoreText_.text = arg_5_1.player1Info.score
	arg_5_0.p2scoreText_.text = arg_5_1.player2Info.score

	if arg_5_1.player1Info.npc then
		arg_5_0.p1nameText_.text = IdolPveNpcCfg[arg_5_1.player1Info.heroID].name
		arg_5_0.p1headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", IdolPveNpcCfg[arg_5_1.player1Info.heroID].icon)
	else
		arg_5_0.p1nameText_.text = HeroCfg[arg_5_1.player1Info.heroID].suffix
		arg_5_0.p1headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", arg_5_1.player1Info.heroID)
	end

	if arg_5_1.player2Info.npc then
		arg_5_0.p2nameText_.text = IdolPveNpcCfg[arg_5_1.player2Info.heroID].name
		arg_5_0.p2headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", IdolPveNpcCfg[arg_5_1.player2Info.heroID].icon)
	else
		arg_5_0.p2nameText_.text = HeroCfg[arg_5_1.player2Info.heroID].suffix
		arg_5_0.p2headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", arg_5_1.player2Info.heroID)
	end

	arg_5_0.winController_:SetSelectedState(arg_5_1.result == 1 and "L" or "R")
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
