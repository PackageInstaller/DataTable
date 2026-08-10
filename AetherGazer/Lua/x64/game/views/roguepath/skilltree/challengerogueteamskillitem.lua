local var_0_0 = class("ChallengeRogueTeamSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.typeController_ = arg_1_0.controllerEx_:GetController("type")
	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("state")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.skillID_ = arg_2_2
	arg_2_0.index_ = arg_2_1
	arg_2_0.clickcCallBack_ = arg_2_3

	arg_2_0:RefreshUI()
end

function var_0_0.SelectorItem(arg_3_0, arg_3_1)
	local var_3_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if arg_3_0.skillID_ == arg_3_1 then
		arg_3_0.selectController_:SetSelectedState("true")
	else
		arg_3_0.selectController_:SetSelectedState("false")
	end

	if ChallengeRogueTeamData:IsHasSkill(var_3_0, arg_3_0.skillID_) then
		arg_3_0.stateController_:SetSelectedState("activated")
	elseif ChallengeRogueTeamData:CanSelectSkill(var_3_0, arg_3_0.skillID_) then
		arg_3_0.stateController_:SetSelectedState("normal")
	else
		arg_3_0.stateController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.transform_, arg_4_0.skillRedPointStr_)
	Object.Destroy(arg_4_0.gameObject_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		arg_5_0:OnClick()
	end)
end

function var_0_0.SetHandler(arg_7_0, arg_7_1)
	arg_7_0.handler_ = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.skillRedPointStr_ = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, arg_8_0.skillID_)

	manager.redPoint:bindUIandKey(arg_8_0.transform_, arg_8_0.skillRedPointStr_)

	local var_8_0 = RogueTeamSkillTreeCfg[arg_8_0.skillID_]
	local var_8_1 = ChallengeRogueTeamData:GetSkillByLevel(var_8_0.level)
	local var_8_2 = table.indexof(var_8_1, arg_8_0.skillID_)
	local var_8_3 = ChallengeRogueTeamData:GetCacheTemplateID()

	arg_8_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_8_0.icon)
	arg_8_0.transform_.localPosition = Vector3(var_8_0.level * 400, (var_8_2 - math.ceil(#var_8_1 / 2)) * 200, 0)

	if var_8_0.node_type == 0 then
		arg_8_0.typeController_:SetSelectedState("small")
	else
		arg_8_0.typeController_:SetSelectedState("big")
	end

	arg_8_0:Show(true)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.GetLocalPosition(arg_10_0)
	return arg_10_0.transform_.localPosition
end

function var_0_0.OnClick(arg_11_0)
	arg_11_0:Go("challengeRogueTeamSkillInfo", {
		skillID = arg_11_0.skillID_,
		handler = arg_11_0.handler_
	})

	if arg_11_0.clickcCallBack_ then
		arg_11_0.clickcCallBack_()
	end

	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECT_SKILL_ITEM, arg_11_0.skillID_)
end

function var_0_0.IsOpenSectionInfo(arg_12_0)
	return arg_12_0:IsOpenRoute("challengeRogueTeamSkillInfo")
end

return var_0_0
