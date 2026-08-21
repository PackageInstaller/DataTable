local var_0_0 = class("ChallengeRogueTeamBagTreasureItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controller_:GetController("state")
	arg_1_0.progressItem_ = {}
	arg_1_0.progressController_ = {}

	for iter_1_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		arg_1_0.progressItem_[iter_1_0] = ChallengeRogueTeamCampItem.New(arg_1_0["scheduleItemGo" .. iter_1_0 .. "_"])
	end
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	arg_2_0.progressController_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.descText_, nil, nil)
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.itemTemp_ = RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp
	arg_4_0.skillID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(arg_4_0.itemTemp_, arg_4_1)
	arg_4_0.cfg_ = RogueTeamItemCfg[arg_4_0.skillID_]

	if arg_4_1 == 0 then
		if ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
			local var_4_0 = ChallengeRogueTeamData:SuitSkillGetID()
			local var_4_1 = ChallengeRogueTeamTools.GetItemIDByCampID(var_4_0)

			arg_4_0.cfg_ = RogueTeamItemCfg[var_4_1]
			arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_4_1))
			arg_4_0.nameText_.text = arg_4_0.cfg_.name
			arg_4_0.descText_.text = ChallengeRogueTeamTools.GetItemDesc(var_4_1, nil, arg_4_0.descText_.color)

			arg_4_0.stateController_:SetSelectedState("unlock")
		else
			arg_4_0.stateController_:SetSelectedState("lock")
		end

		return
	end

	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_0.skillID_))
	arg_4_0.nameText_.text = arg_4_0.cfg_.name
	arg_4_0.descText_.text = ChallengeRogueTeamTools.GetItemDesc(arg_4_0.skillID_, nil, arg_4_0.descText_.color)

	arg_4_0:RefreshState()
end

function var_0_0.RefreshState(arg_5_0)
	local var_5_0 = ChallengeRogueTeamData:TreasureGetListByCampList(arg_5_0.cfg_.camp)
	local var_5_1 = ChallengeRogueTeamData:GetTreasureIDListByTempAndCampList(arg_5_0.itemTemp_, arg_5_0.cfg_.camp)
	local var_5_2

	var_5_2 = #var_5_0 > 0

	local var_5_3

	var_5_3 = #var_5_0 >= 6

	if ChallengeRogueTeamData:SuitSkillGetID() ~= 0 and ChallengeRogueTeamData:SuitSkillGetID() ~= arg_5_0.cfg_.camp[1] then
		arg_5_0.stateController_:SetSelectedState("hasother")
	elseif ChallengeRogueTeamData:SuitSkillGetID() == arg_5_0.cfg_.camp[1] then
		arg_5_0.stateController_:SetSelectedState("unlock")
	else
		arg_5_0.stateController_:SetSelectedState("progress")
		arg_5_0:RefeshUnlockState()
	end
end

function var_0_0.RefeshUnlockState(arg_6_0)
	local var_6_0 = ChallengeRogueTeamData:GetTreasureIDListByTempAndCampList(arg_6_0.itemTemp_, arg_6_0.cfg_.camp)
	local var_6_1 = ChallengeRogueTeamData:TreasureGetListByCampList(arg_6_0.cfg_.camp)

	for iter_6_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		arg_6_0.progressItem_[iter_6_0]:RefreshState(iter_6_0 <= #var_6_1)
	end
end

return var_0_0
