local var_0_0 = class("ChallengeRogueTeamIllustratedTreasureItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.bgController_ = arg_1_0.controllerEx_:GetController("treasure")
	arg_1_0.ownController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")

	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.clickCallBack_ then
			arg_2_0.clickCallBack_(arg_2_0.index_)
		end
	end)
	TerminologyTools.AddTerminologyHandler(arg_2_0, arg_2_0.descText_, nil, nil)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2
	arg_5_0.cfg_ = RogueTeamItemCfg[arg_5_0.id_]
	arg_5_0.nameText_.text = arg_5_0.cfg_.name

	local var_5_0 = ChallengeRogueTeamTools.GetTreasureAffix(arg_5_0.id_)
	local var_5_1 = AffixTypeCfg[var_5_0[1]].description[1]

	arg_5_0.iconImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_2))

	arg_5_0.ownController_:SetSelectedState(tostring(arg_5_3 == true))

	local var_5_2 = ""

	if arg_5_0.cfg_.sub_type == 1 and #arg_5_0.cfg_.camp <= 1 then
		arg_5_0.bgController_:SetSelectedState("treasure05")

		var_5_2 = GetCfgDescription(var_5_1, level, 1, 3, true)
	else
		arg_5_0.bgController_:SetSelectedState("treasure01")

		var_5_2 = GetCfgDescription(var_5_1, level, 1, 1, true)
	end

	local var_5_3 = arg_5_0.descText_.color
	local var_5_4 = string.format("#%s", ColorToHex(var_5_3))
	local var_5_5 = string.gsub(var_5_2, "#5C5D60", var_5_4)

	arg_5_0.descText_.text = var_5_5
end

function var_0_0.RefreshSelect(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedState(tostring(arg_6_0.index_ == arg_6_1))
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack_ = arg_7_1
end

return var_0_0
