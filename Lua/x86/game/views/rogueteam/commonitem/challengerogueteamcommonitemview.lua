ChallengeRogueTeamCommonItemData = {
	needShowCampFlag = false,
	selectFlag = false,
	id = 0,
	rare = 1,
	descRaycastFlag = false
}

local var_0_0 = class("ChallengeRogueTeamCommonItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.info_ = {}
	arg_1_0.campView_ = {}

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectController_ = arg_2_0.controllerEx_:GetController("select")
	arg_2_0.ownController_ = arg_2_0.controllerEx_:GetController("own")
	arg_2_0.typeController_ = arg_2_0.controllerEx_:GetController("type")
	arg_2_0.rareController_ = arg_2_0.controllerEx_:GetController("treasure")
	arg_2_0.campController_ = arg_2_0.controllerEx_:GetController("numberstate")
	arg_2_0.campCntController_ = arg_2_0.campControllerEx_:GetController("state01")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.info_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.GetData(arg_4_0)
	return arg_4_0.info_
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.info_ == nil then
		arg_5_0.typeController_:SetSelectedState("empty")

		return
	end

	arg_5_0:RefreshIcon()
	arg_5_0:RefreshText()
	arg_5_0:RefreshSelectState(arg_5_0.info_.selectFlag)
	arg_5_0:RefreshOwnState(arg_5_0.info_.ownFlag)
	arg_5_0:RefreshDescTextRaycast(arg_5_0.info_.descRaycastFlag)
	arg_5_0:RefreshCamp()
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if arg_6_0.info_.clickFun then
			arg_6_0.info_.clickFun(arg_6_0.info_)
		end
	end)
	TerminologyTools.AddTerminologyHandler(arg_6_0, arg_6_0.descText_, nil, nil)
end

function var_0_0.RefreshIcon(arg_8_0)
	local var_8_0 = arg_8_0.info_.id
	local var_8_1 = RogueTeamItemCfg[var_8_0]

	arg_8_0.iconImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_8_0))

	if var_8_1.type == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
		arg_8_0.typeController_:SetSelectedState("Mechanis")
	else
		arg_8_0.typeController_:SetSelectedState("Normal")
	end

	if var_8_1.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		local var_8_2 = ChallengeRogueTeamTools.GetItemRare(var_8_0, arg_8_0.info_.rare)

		if var_8_1.sub_type == 2 or #var_8_1.camp > 1 then
			arg_8_0.rareController_:SetSelectedState("treasure01")
		elseif var_8_2 == 1 then
			arg_8_0.rareController_:SetSelectedState("treasure04")
		elseif var_8_2 == 2 then
			arg_8_0.rareController_:SetSelectedState("treasure03")
		elseif var_8_2 == 3 then
			arg_8_0.rareController_:SetSelectedState("treasure02")
		end
	else
		arg_8_0.rareController_:SetSelectedState("treasure05")
	end
end

function var_0_0.RefreshText(arg_9_0)
	local var_9_0 = arg_9_0.info_.id
	local var_9_1 = RogueTeamItemCfg[var_9_0]

	arg_9_0.nameText_.text = var_9_1.name
	arg_9_0.descText_.text = ChallengeRogueTeamTools.GetItemDesc(var_9_0, arg_9_0.info_.rare, arg_9_0.descText_.color)
end

function var_0_0.RefreshSelectState(arg_10_0, arg_10_1)
	if arg_10_1 == true then
		arg_10_0.selectController_:SetSelectedState("true")
	else
		arg_10_0.selectController_:SetSelectedState("false")
	end

	arg_10_0.info_.selectFlag = arg_10_1
end

function var_0_0.RefreshOwnState(arg_11_0, arg_11_1)
	if arg_11_1 == true then
		arg_11_0.ownController_:SetSelectedState("true")
	else
		arg_11_0.ownController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshCamp(arg_12_0)
	local var_12_0 = arg_12_0.info_.id
	local var_12_1 = RogueTeamItemCfg[var_12_0]

	if var_12_1.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and arg_12_0.info_.needShowCampFlag then
		arg_12_0.campController_:SetSelectedState("state1")

		for iter_12_0, iter_12_1 in ipairs(var_12_1.camp) do
			arg_12_0.campView_[iter_12_0] = ChallengeRogueTeamTreasureSkillItem.New(arg_12_0[string.format("campGo%s_", iter_12_0)])

			arg_12_0.campView_[iter_12_0]:SetData(iter_12_1)
		end

		if #var_12_1.camp >= 2 then
			arg_12_0.campCntController_:SetSelectedState("state1")
		else
			arg_12_0.campCntController_:SetSelectedState("state0")
		end
	else
		arg_12_0.campController_:SetSelectedState("state0")
	end
end

function var_0_0.RefreshDescTextRaycast(arg_13_0, arg_13_1)
	arg_13_0.descText_.raycastTarget = arg_13_1
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_0.PlayAnimator(arg_15_0)
	arg_15_0.animator_:Play("UI_SelectItem_cx", -1, 0)
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.campView_) do
		iter_16_1:Dispose()
	end

	arg_16_0.campView_ = nil

	var_0_0.super.Dispose(arg_16_0)

	arg_16_0.transform_ = nil
	arg_16_0.gameObject_ = nil
end

return var_0_0
