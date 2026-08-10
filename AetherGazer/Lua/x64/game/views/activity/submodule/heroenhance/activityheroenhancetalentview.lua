local var_0_0 = class("ActivityHeroEnhanceTalentView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.talentGroups_ = {}

	local var_2_0 = 4

	for iter_2_0 = 1, var_2_0 do
		local var_2_1 = ActivityHeroEnhanceTalentGroupView.New(arg_2_0["talentGroupGo_" .. iter_2_0])

		table.insert(arg_2_0.talentGroups_, var_2_1)
	end

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.talentGroups_) do
		iter_3_1:SetClickHandler(function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
			if arg_3_0.onClickTalenCallback_ then
				arg_3_0.onClickTalenCallback_(iter_3_1, iter_3_0, arg_4_0, arg_4_1, arg_4_2, arg_4_3)
			end
		end)
	end
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.cfgId_ = arg_7_1
end

function var_0_0.SelectGroupIdx(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.selectGroupIdx_ == arg_8_1 and (arg_8_1 <= 0 or arg_8_0.talentGroups_[arg_8_1].selectIdx_ == arg_8_2) then
		return
	end

	arg_8_0.selectGroupIdx_ = arg_8_1

	if arg_8_1 > 0 then
		arg_8_0.talentGroups_[arg_8_1]:SelectIdx(arg_8_2)
	end
end

function var_0_0.SetClickTalentHandler(arg_9_0, arg_9_1)
	arg_9_0.onClickTalenCallback_ = arg_9_1
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = ActivityHeroEnhanceCfg[arg_10_0.cfgId_]
	local var_10_1 = var_10_0.activity_id
	local var_10_2 = var_10_0.hero_id
	local var_10_3 = {
		1139,
		1049,
		1042
	}

	if ActivityTools.GetActivityTheme(var_10_1) == ActivityConst.THEME.ACTIVITY_3_5 and table.indexof(var_10_3, var_10_2) then
		arg_10_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Version/SummerUI_3_5/SummerUI_3_5_HeroEnhanceUI/SummerUI3_5_" .. var_10_2)
	else
		arg_10_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_10_2)
	end

	arg_10_0.heroImage_:SetNativeSize()

	local var_10_4 = ActivityHeroEnhanceTools.GetCfgTalentDict(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.talentGroups_) do
		local var_10_5 = iter_10_0
		local var_10_6 = var_10_4[var_10_5]

		iter_10_1:SetData(arg_10_0.cfgId_, var_10_5, var_10_6)
		iter_10_1:SetSelected(arg_10_0.selectGroupIdx_ == iter_10_0)
		iter_10_1:RefreshUI()
	end
end

function var_0_0.RefreshUI_SelectState(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.talentGroups_) do
		iter_11_1:SetSelected(arg_11_0.selectGroupIdx_ == iter_11_0)
		iter_11_1:RefreshUI_SelectState()
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.talentGroups_) do
		iter_12_1:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
