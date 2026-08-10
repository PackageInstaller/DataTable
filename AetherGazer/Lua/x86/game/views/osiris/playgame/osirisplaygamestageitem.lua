local var_0_0 = class("OsirisPlayGameStageItem", ReduxView)
local var_0_1 = {
	[1] = "IS_CAPTAIN",
	[2] = "IS_SUPPORT"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
	arg_3_0.typeCon_ = arg_3_0.typeControllerEx_:GetController("type")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = ActivityGeneralityStageCfg[arg_4_0.stageId]
		local var_5_1 = var_5_0 and var_5_0.pre_stage or 1

		if OsirisPlayGameData:IsPassStagesByStageId(var_5_1) or var_5_1 == 0 then
			OsirisPlayGameData:InitTempHeroData()
			JumpTools.OpenPageByJump("/osirisPlayGameSectionSelectHeroView", {
				section = var_5_0.stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME,
				activityID = var_5_0.activity_id,
				heroDataType = HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME
			})
		else
			ShowTips("CAPTURE_GAME_PRE_SECTION_UNREACHED")
		end
	end)
end

function var_0_0.RefreshView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.stageId = arg_6_1

	local var_6_0 = ActivityGeneralityStageCfg[arg_6_1]
	local var_6_1 = var_6_0.unlock_charactor

	if var_6_0.pre_stage == 0 then
		arg_6_0.stateCon_:SetSelectedIndex(OsirisPlayGameData:IsPassStagesByStageId(var_6_0.stage_id) and 2 or 1)

		if not ActivityGeneralityCharactorCfg[var_6_1] then
			arg_6_0.stateCon_:SetSelectedIndex(OsirisPlayGameData:IsPassStagesByStageId(var_6_0.stage_id) and 5 or 4)
		end
	elseif OsirisPlayGameData:IsPassStagesByStageId(var_6_0.pre_stage) and OsirisPlayGameData:IsPassStagesByStageId(var_6_0.stage_id) then
		if var_6_0.stage_id == arg_6_2 and arg_6_3 == false and OsirisPlayGameData:GetPassStageClearTimesByStageId(var_6_0.stage_id) == 0 then
			if OsirisPlayGameData:IsPassStagesByStageId(var_6_0.pre_stage) then
				arg_6_0.stateCon_:SetSelectedIndex(1)

				if not ActivityGeneralityCharactorCfg[var_6_1] then
					arg_6_0.stateCon_:SetSelectedIndex(4)
				end
			end

			arg_6_0.timer_ = Timer.New(function()
				arg_6_0.stateCon_:SetSelectedIndex(2)

				if not ActivityGeneralityCharactorCfg[var_6_1] then
					arg_6_0.stateCon_:SetSelectedIndex(5)
				end

				arg_6_0.animGo_:Play("UI_complete_cx", -1, 0)
				arg_6_0.animGo_:Update(0)
				arg_6_0:StopTimer()
			end, 2.5, 1)

			arg_6_0.timer_:Start()
		else
			arg_6_0.stateCon_:SetSelectedIndex(2)

			if not ActivityGeneralityCharactorCfg[var_6_1] then
				arg_6_0.stateCon_:SetSelectedIndex(5)
			end
		end
	elseif OsirisPlayGameData:IsPassStagesByStageId(var_6_0.pre_stage) then
		arg_6_0.stateCon_:SetSelectedIndex(1)

		if not ActivityGeneralityCharactorCfg[var_6_1] then
			arg_6_0.stateCon_:SetSelectedIndex(4)
		end
	else
		arg_6_0.stateCon_:SetSelectedIndex(0)

		if not ActivityGeneralityCharactorCfg[var_6_1] then
			arg_6_0.stateCon_:SetSelectedIndex(3)
		end
	end

	arg_6_0.skillNameTxt_.text = GetI18NText(var_6_0.name)
	arg_6_0.skillDescTxt_.text = GetI18NText(var_6_0.desc)

	if ActivityGeneralityCharactorCfg[var_6_1] then
		arg_6_0.typeTxt_.text = GetTips(var_0_1[ActivityGeneralityCharactorCfg[var_6_1].charactor_type])
		arg_6_0.heroIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_6_1)

		local var_6_2 = HeroCfg[var_6_1].race
		local var_6_3 = string.format("com_white_icon_group_%d_c", var_6_2)

		arg_6_0.campIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_6_3)
		arg_6_0.descTxt_.text = HeroTools.GetHeroFullName(var_6_1)

		arg_6_0.typeCon_:SetSelectedIndex(ActivityGeneralityCharactorCfg[var_6_1].charactor_type == 1 and 1 or 0)
	end
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopTimer()
	arg_9_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
