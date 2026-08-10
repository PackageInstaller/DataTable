local var_0_0 = class("SequentialBattleBossInfoItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.skillList_ = {}
	arg_1_0.scrollRectCast_ = arg_1_0:FindCom("ScrollRectCast", "", arg_1_0.scrollView_.transform)

	arg_1_0.scrollRectCast_:SetParent(arg_1_0.parentGo_)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.skillList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.skillList_ = nil
end

function var_0_0.SetBossID(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.bossIDList_ = arg_3_1

	local var_3_0

	for iter_3_0, iter_3_1 in pairs(arg_3_0.bossIDList_) do
		if var_3_0 == nil then
			var_3_0 = tostring(iter_3_1)
		else
			var_3_0 = var_3_0 .. tostring(iter_3_1)
		end
	end

	arg_3_0.portraitImage_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", var_3_0))

	local var_3_1 = MonsterCfg[arg_3_0.bossIDList_[1]]

	arg_3_0.nameText_.text = GetMonsterName(arg_3_0.bossIDList_)
	arg_3_0.tagText_.text = GetTips("RACE_TYPE_" .. var_3_1.race)

	local var_3_2 = GetMonsterSkillDesList(arg_3_0.bossIDList_)
	local var_3_3 = 1

	for iter_3_2 = 1, 6 do
		if var_3_2[iter_3_2] then
			if not arg_3_0.skillList_[var_3_3] then
				arg_3_0.skillList_[var_3_3] = BattleBossChallengeSkillItem.New(arg_3_0.skillItem_, arg_3_0.skillParent_)
			end

			arg_3_0.skillList_[var_3_3]:RefreshUI(var_3_2[iter_3_2])

			var_3_3 = var_3_3 + 1
		end
	end

	for iter_3_3 = var_3_3, #arg_3_0.skillList_ do
		arg_3_0.skillList_[iter_3_3]:Hide()
	end

	arg_3_0.lvText_.text = NumberTools.IntToRomam(arg_3_2)
end

return var_0_0
