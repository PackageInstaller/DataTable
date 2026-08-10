local var_0_0 = class("ChallengeRogueTeamBagItemSelectItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.rareController_ = arg_1_0.controllerEx_:GetController("quality")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECTED_ITEM, arg_3_0.itemData_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.id

	arg_5_0.itemData_ = arg_5_1

	local var_5_1 = RogueTeamItemCfg[var_5_0]

	arg_5_0.nameText_.text = var_5_1.name
	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_5_0))

	arg_5_0:RefreshSelectState(arg_5_1.isSelect)

	if var_5_1.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		local var_5_2 = ChallengeRogueTeamTools.GetItemRare(var_5_0, arg_5_1.rare)

		if var_5_1.sub_type == 2 or #var_5_1.camp > 1 then
			arg_5_0.rareController_:SetSelectedState("orange")
		elseif var_5_2 == 1 then
			arg_5_0.rareController_:SetSelectedState("green")
		elseif var_5_2 == 2 then
			arg_5_0.rareController_:SetSelectedState("blue")
		elseif var_5_2 == 3 then
			arg_5_0.rareController_:SetSelectedState("purple")
		end
	else
		arg_5_0.rareController_:SetSelectedState("relic")
	end
end

function var_0_0.RefreshSelectState(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("on")
	else
		arg_6_0.selectController_:SetSelectedState("off")
	end
end

return var_0_0
