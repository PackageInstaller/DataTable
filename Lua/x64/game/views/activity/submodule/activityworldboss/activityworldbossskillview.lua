local var_0_0 = class("ActivityWorldBossSkillView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/WorldBoss/EDream_WorldBossPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_.bossID

	arg_8_0.bossID_ = var_8_0
	arg_8_0.portraitImage_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", var_8_0))

	local var_8_1 = MonsterCfg[var_8_0]

	arg_8_0.nameText_.text = GetMonsterName({
		arg_8_0.bossID_
	})
	arg_8_0.tagText_.text = GetTips("RACE_TYPE_" .. var_8_1.race)

	local var_8_2 = GetMonsterSkillDesList({
		arg_8_0.bossID_
	})
	local var_8_3 = 1

	for iter_8_0 = 1, 6 do
		if var_8_2[iter_8_0] then
			if not arg_8_0.skillList_[var_8_3] then
				arg_8_0.skillList_[var_8_3] = BattleBossChallengeSkillItem.New(arg_8_0.skillItem_, arg_8_0.skillParent_)
			end

			arg_8_0.skillList_[var_8_3]:RefreshUI(var_8_2[iter_8_0])

			var_8_3 = var_8_3 + 1
		end
	end

	for iter_8_1 = var_8_3, #arg_8_0.skillList_ do
		arg_8_0.skillList_[iter_8_1]:Hide()
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.skillList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.skillList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
