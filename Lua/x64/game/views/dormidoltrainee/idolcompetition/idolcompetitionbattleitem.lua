local var_0_0 = class("IdolCompetitionBattleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.winLineController_ = arg_2_0.lineController_:GetController("state")
	arg_2_0.head1StateController_ = arg_2_0.p1Controller_:GetController("state")
	arg_2_0.head2StateController_ = arg_2_0.p2Controller_:GetController("state")
	arg_2_0.head1MeController_ = arg_2_0.p1Controller_:GetController("position")
	arg_2_0.head2MeController_ = arg_2_0.p2Controller_:GetController("position")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.p1Btn_, nil, function()
		if arg_3_0.click_ then
			arg_3_0.click_()
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.p2Btn_, nil, function()
		if arg_3_0.click_ then
			arg_3_0.click_()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	arg_6_0.click_ = arg_6_7

	if arg_6_1 then
		arg_6_0.winLineController_:SetSelectedState("normal")
		arg_6_0.head1StateController_:SetSelectedState("pending")
		arg_6_0.head2StateController_:SetSelectedState("pending")
		arg_6_0.head1MeController_:SetSelectedState("off")
		arg_6_0.head2MeController_:SetSelectedState("off")

		return
	end

	if arg_6_2 then
		arg_6_0.winLineController_:SetSelectedState(arg_6_5 == 1 and "up" or "under")
		arg_6_0.head1StateController_:SetSelectedState(arg_6_5 == 1 and "win" or "lose")
		arg_6_0.head2StateController_:SetSelectedState(arg_6_5 == 2 and "win" or "lose")
	else
		arg_6_0.winLineController_:SetSelectedState("normal")
		arg_6_0.head1StateController_:SetSelectedState("inconclusive")
		arg_6_0.head2StateController_:SetSelectedState("inconclusive")
	end

	local var_6_0 = IdolCompetitionData:GetRacePlayerInfo(arg_6_6, arg_6_3)
	local var_6_1 = IdolCompetitionData:GetRacePlayerInfo(arg_6_6, arg_6_4)

	if var_6_0.npc == 0 then
		arg_6_0.p1HeadImg_.sprite = ItemTools.getItemSprite(var_6_0.head)
	else
		arg_6_0.p1HeadImg_.spriteSync = "TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_6_0.head
	end

	if var_6_1.npc == 0 then
		arg_6_0.p2HeadImg_.sprite = ItemTools.getItemSprite(var_6_1.head)
	else
		arg_6_0.p2HeadImg_.spriteSync = "TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_6_1.head
	end

	arg_6_0.p1NameText_.text = var_6_0.name
	arg_6_0.p2NameText_.text = var_6_1.name

	arg_6_0.head1MeController_:SetSelectedState("off")
	arg_6_0.head2MeController_:SetSelectedState("off")

	if arg_6_3 == USER_ID then
		arg_6_0.head1MeController_:SetSelectedState("on")
	elseif arg_6_4 == USER_ID then
		arg_6_0.head2MeController_:SetSelectedState("on")
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
