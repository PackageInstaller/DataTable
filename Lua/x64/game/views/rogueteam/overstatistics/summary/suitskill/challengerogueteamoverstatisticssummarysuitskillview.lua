local var_0_0 = class("ChallengeRogueTeamOverStatisticsSummarySuitSkillView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.emptyController_ = arg_1_0.controllerEx_:GetController("empty")
	arg_1_0.unlockSuitSkillController_ = arg_1_0.controllerEx_:GetController("unlockSuitSkill")
	arg_1_0.suitSkillItemList_ = {}

	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.suitSkillItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.suitSkillItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ChallengeRogueTeamData:SuitSkillGetID()

	if var_4_0 == 0 then
		arg_4_0.unlockSuitSkillController_:SetSelectedState("false")
	else
		arg_4_0.unlockSuitSkillController_:SetSelectedState("true")

		local var_4_1 = ChallengeRogueTeamTools.GetItemIDByCampID(var_4_0)

		arg_4_0.suitSkillNameText_.text = RogueTeamItemCfg[var_4_1].name
	end

	local var_4_2 = ChallengeRogueTeamData:TreasureGetList()

	arg_4_0.treasureDataList_ = ChallengeRogueTeamTools.TreasureGroup(var_4_2)

	local var_4_3 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_4_4 = RogueTeamCfg[var_4_3].item_temp

	for iter_4_0, iter_4_1 in ipairs(RogueTeamItemCfg.get_id_list_by_item_temp_type[var_4_4][ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL]) do
		local var_4_5 = RogueTeamItemCfg[iter_4_1].camp[1]

		table.insert(arg_4_0.suitSkillItemList_, ChallengeRogueTeamOverStatisticsSummarySuitSkillItem.New(arg_4_0.item_, arg_4_0.parent_, iter_4_1, table.length(arg_4_0.treasureDataList_[var_4_5])))
	end
end

function var_0_0.GetHeight(arg_5_0)
	return arg_5_0.rectTransform_.rect.height
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.animator_.enabled = arg_6_1

	if arg_6_1 == false then
		arg_6_0.canvasGroup_.alpha = 0
	end
end

return var_0_0
