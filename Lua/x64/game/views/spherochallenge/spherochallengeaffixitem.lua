local var_0_0 = class("SPHeroChallengeAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = arg_3_0.controller:GetController("state")
	arg_3_0.showTipsController = arg_3_0.controller:GetController("showTips")

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		if arg_4_0.clickCallback then
			arg_4_0.clickCallback()
		end

		arg_4_0:OpenCloseTimer()
	end)
end

function var_0_0.SetClickListener(arg_6_0, arg_6_1)
	arg_6_0.clickCallback = arg_6_1
end

function var_0_0.OpenCloseTimer(arg_7_0)
	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end

	arg_7_0.showTipsController:SetSelectedState("show")
	arg_7_0:RefreshDesc()

	arg_7_0.timer = Timer.New(function()
		arg_7_0:CloseAffix()
	end, 3, 1)

	arg_7_0.timer:Start()
end

function var_0_0.CloseAffix(arg_9_0)
	arg_9_0.showTipsController:SetSelectedState("close")

	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.activityID = SPHeroChallengeData:GetActivityID()

	local var_10_0 = ActivityHeroChallengeCfg[arg_10_0.activityID]

	arg_10_0.showTipsController:SetSelectedState("close")

	if var_10_0 then
		local var_10_1 = SpHeroChallengeConst.trainIndex[arg_10_1]
		local var_10_2 = var_10_0["affix_group_" .. var_10_1][arg_10_2]
		local var_10_3 = SPHeroChallengeData:GetCurActivityInfo():GetTrainNumByType(arg_10_1)

		arg_10_0.affixID = var_10_2[2]
		arg_10_0.nameText.text = GetTips("TIP_CLEARTIMES") .. var_10_2[1]
		arg_10_0.skillText.text = ActivityAffixPoolCfg[var_10_2[2]].name
		arg_10_0.skillIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. PublicBuffCfg[var_10_2[2]].icon)

		if var_10_3 < var_10_2[1] then
			arg_10_0.stateController:SetSelectedState("lock")
		else
			arg_10_0.stateController:SetSelectedState("unlock")
		end
	end
end

function var_0_0.RefreshDesc(arg_11_0)
	arg_11_0.name.text = ActivityAffixPoolCfg[arg_11_0.affixID].name

	local var_11_0 = GetCfgDescription(AffixTypeCfg[arg_11_0.affixID].description[1])

	arg_11_0.desc.text = var_11_0
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	arg_12_0.gameObject_ = nil
	arg_12_0.transform_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
