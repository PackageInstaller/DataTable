local var_0_0 = class("SoloChallengeBossInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	if ActivityTools.GetActivityTheme(arg_1_0.params_.activityID) == ActivityConst.THEME.TYR then
		return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeBossInfoUI"
	else
		return "UI/MardukUI/SoloChallenge/MardukSoloChallengeBoss"
	end
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.itemList_ = {}
	arg_3_0.skillList_ = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = MonsterCfg[arg_7_0.id_]

	arg_7_0.nameText_.text = GetMonsterName({
		arg_7_0.id_
	})
	arg_7_0.raceText_.text = GetTips("RACE_TYPE_" .. var_7_0.race)
	arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", arg_7_0.id_))
	arg_7_0.riskText_.text = NumberTools.IntToRomam(var_7_0.type + 1)

	arg_7_0:UpdateData()
	arg_7_0:RefreshSkill()
end

function var_0_0.RefreshSkill(arg_8_0)
	for iter_8_0 = 1, 6 do
		arg_8_0:UpdateItem(iter_8_0, arg_8_0.skillList_[iter_8_0])
	end

	for iter_8_1 = 1, 6 do
		if string.len(arg_8_0.skillList_[iter_8_1].name) == 0 then
			arg_8_0.itemList_[iter_8_1]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.contentTrs_)
end

function var_0_0.UpdateItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.itemList_[arg_9_1] then
		local var_9_0 = Object.Instantiate(arg_9_0.itemGo_, arg_9_0.contentTrs_)

		arg_9_0.itemList_[arg_9_1] = SoloChallengeBossInfoItem.New(var_9_0)
	end

	arg_9_0.itemList_[arg_9_1]:RefreshUI(arg_9_2)
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:HideBar()

	arg_10_0.id_ = arg_10_0.params_.bossID

	arg_10_0:RefreshUI()
end

function var_0_0.UpdateData(arg_11_0)
	arg_11_0.skillList_ = {}

	for iter_11_0 = 1, 6 do
		arg_11_0.skillList_[iter_11_0] = {
			isLock = false,
			name = MonsterCfg[arg_11_0.id_]["skill" .. iter_11_0],
			info = MonsterCfg[arg_11_0.id_]["skill_desc" .. iter_11_0]
		}
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.itemList_) do
		iter_12_1:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
