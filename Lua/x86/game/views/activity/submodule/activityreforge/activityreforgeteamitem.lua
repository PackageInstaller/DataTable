local var_0_0 = class("ActivityReforgeTeamItem", ReduxView)

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

	arg_3_0.levelUpController_ = arg_3_0.controllerEx_:GetController("levelUp")
	arg_3_0.usingcontroller_ = arg_3_0.controllerEx_:GetController("using")
	arg_3_0.recommendcontroller_ = arg_3_0.controllerEx_:GetController("recommend")
	arg_3_0.curSelectcontroller_ = arg_3_0.controllerEx_:GetController("curSelect")
	arg_3_0.heroHeadItemList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.heroHeadItemList_[iter_3_0] = ActivityReforgeHeroHeadItem.New(arg_3_0["heroHeadGo" .. iter_3_0 .. "_"])
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.resetTeamLevelBtn_, nil, function()
		if arg_4_0.teamInfo_ and arg_4_0.teamInfo_.level > 1 then
			ActivityReforgeAction.ResetTeamLevel(arg_4_0.chapterActivityID_, arg_4_0.levelID_, arg_4_0.teamInfo_.teamID)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_NO_LEVELUP")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.teamLevelUpBtn_, nil, function()
		local var_6_0 = #arg_4_0.teamCfg_.team_info

		if arg_4_0.teamInfo_ and var_6_0 > arg_4_0.teamInfo_.level then
			ActivityReforgeAction.TeamLevelUp(arg_4_0.chapterActivityID_, arg_4_0.levelID_, arg_4_0.teamInfo_.teamID, function()
				arg_4_0.teamInfoAni_:Play("LevelUp")
			end)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_MAX")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.curWaveID_ == arg_4_0.curUsingWaveID_ then
			return
		end

		if arg_4_0.curUsingWaveID_ ~= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_REFORGE_TEAM_USED"),
				OkCallback = function()
					ActivityReforgeAction.SetWaveTeam(arg_4_0.chapterActivityID_, arg_4_0.levelID_, arg_4_0.curWaveID_, arg_4_0.teamInfo_.teamID, function()
						JumpTools.Back()
					end)
				end
			})
		else
			ActivityReforgeAction.SetWaveTeam(arg_4_0.chapterActivityID_, arg_4_0.levelID_, arg_4_0.curWaveID_, arg_4_0.teamInfo_.teamID, function()
				JumpTools.Back()
			end)
		end
	end)
end

function var_0_0.SetData(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_0.chapterActivityID_ = arg_12_1
	arg_12_0.levelID_ = arg_12_2
	arg_12_0.curWaveID_ = arg_12_3
	arg_12_0.teamID_ = arg_12_4
	arg_12_0.teamInfo_ = ActivityReforgeData:GetTeamInfo(arg_12_0.teamID_)
	arg_12_0.teamCfg_ = ActivityReforgeTeamCfg[arg_12_0.teamID_]
	arg_12_0.curUsingWaveID_ = ActivityReforgeData:GetTeamCurUsingWaveID(arg_12_0.teamID_)

	arg_12_0:UpdateView()
end

function var_0_0.UpdateView(arg_13_0)
	local var_13_0 = ActivityReforgeTeamCfg[arg_13_0.teamInfo_.teamID].team_info[arg_13_0.teamInfo_.level]
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		table.insert(var_13_1, iter_13_1)
	end

	for iter_13_2 = 1, 3 do
		arg_13_0.heroHeadItemList_[iter_13_2]:SetData(var_13_0[iter_13_2])
		arg_13_0.heroHeadItemList_[iter_13_2]:SetClickCallBack(function(arg_14_0)
			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				hid = arg_14_0,
				type = HeroConst.HERO_DATA_TYPE.TRIAL,
				tempHeroList = var_13_1
			})
		end)
	end

	arg_13_0.levelText_.text = arg_13_0.teamInfo_.level
	arg_13_0.levelDesText.text = arg_13_0.teamCfg_.description

	if arg_13_0.teamCfg_.combo_skill_id > 0 then
		SetActive(arg_13_0.comboSkillGo_, true)

		local var_13_2 = arg_13_0.teamCfg_.combo_skill_id
		local var_13_3 = ComboSkillCfg[var_13_2]
		local var_13_4 = HeroSkillCfg[var_13_3.skill_id]

		arg_13_0.comboName_.text = GetI18NText(var_13_4.name)
		arg_13_0.comboLevelText_.text = var_13_3.maxLevel
		arg_13_0.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", var_13_3.skill_id)
	else
		SetActive(arg_13_0.comboSkillGo_, false)
	end

	arg_13_0.teamLevelUpCost_.text = arg_13_0.teamCfg_.cost[arg_13_0.teamInfo_.level]

	local var_13_5 = #arg_13_0.teamCfg_.team_info

	if arg_13_0.teamInfo_.level == 1 then
		arg_13_0.levelUpController_:SetSelectedState("noDown")
	elseif var_13_5 <= arg_13_0.teamInfo_.level then
		arg_13_0.levelUpController_:SetSelectedState("noUp")
	else
		arg_13_0.levelUpController_:SetSelectedState("mid")
	end

	if table.indexof(ActivityReforgeWaveCfg[arg_13_0.curWaveID_].recommend_team, arg_13_0.teamID_) then
		arg_13_0.recommendcontroller_:SetSelectedState("true")
	else
		arg_13_0.recommendcontroller_:SetSelectedState("false")
	end

	if arg_13_0.curUsingWaveID_ == 0 then
		arg_13_0.usingcontroller_:SetSelectedState("false")
		arg_13_0.curSelectcontroller_:SetSelectedState("false")
	elseif arg_13_0.curWaveID_ == arg_13_0.curUsingWaveID_ then
		arg_13_0.usingcontroller_:SetSelectedState("false")
		arg_13_0.curSelectcontroller_:SetSelectedState("true")
	else
		arg_13_0.usingcontroller_:SetSelectedState("true")
		arg_13_0.curSelectcontroller_:SetSelectedState("false")

		local var_13_6 = table.indexof(ActivityReforgeLevelCfg[arg_13_0.levelID_].wave_list, arg_13_0.curUsingWaveID_)

		arg_13_0.usingWaveText_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE_USED"), var_13_6)
	end
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0 = 1, 3 do
		arg_15_0.heroHeadItemList_[iter_15_0]:Dispose()

		arg_15_0.heroHeadItemList_[iter_15_0] = nil
	end

	arg_15_0.heroHeadItemList_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
