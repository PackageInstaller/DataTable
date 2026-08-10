local var_0_0 = class("ChallengeRogueTeamBagRelicItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.statusController_ = arg_1_0.controller_:GetController("status")
	arg_1_0.selectController_ = arg_1_0.controller_:GetController("select")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0.isViewed_ = ChallengeRogueTeamData:IsIllustratedViewd(arg_3_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_3_0.id_)
		arg_3_0.isUnlock_ = ChallengeRogueTeamData:IsIllustratedUnlock(arg_3_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_3_0.id_)

		if arg_3_0.isUnlock_ and not arg_3_0.isViewed_ then
			ChallengeRogueTeamAction.RequestViewCollectionItem(arg_3_0.templateID_, {
				arg_3_0.id_
			}, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)

			arg_3_0.isViewed_ = true

			arg_3_0:RefreshState()
		end

		manager.notify:Invoke(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, arg_3_0.id_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1
	arg_5_0.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()

	local var_5_0 = RogueTeamItemCfg[arg_5_1]

	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_1))
	arg_5_0.name_.text = var_5_0.name
	arg_5_0.isViewed_ = ChallengeRogueTeamData:IsIllustratedViewd(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_5_0.id_)

	arg_5_0:RefreshState()
	arg_5_0:Show(true)
	arg_5_0.selectController_:SetSelectedState(tostring(arg_5_0.id_ == arg_5_0.selectID_))
end

function var_0_0.SetSelectID(arg_6_0, arg_6_1)
	arg_6_0.selectID_ = arg_6_1

	arg_6_0.selectController_:SetSelectedState(tostring(arg_6_0.id_ == arg_6_1))
end

function var_0_0.RefreshState(arg_7_0)
	arg_7_0.isObtained_ = ChallengeRogueTeamData:IsIllustratedObtained(arg_7_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_7_0.id_)
	arg_7_0.isUnlock_ = ChallengeRogueTeamData:IsIllustratedUnlock(arg_7_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_7_0.id_)

	if arg_7_0.isObtained_ then
		arg_7_0.statusController_:SetSelectedState("on")
	elseif arg_7_0.isUnlock_ then
		arg_7_0.statusController_:SetSelectedState("gray")
	else
		arg_7_0.statusController_:SetSelectedState("black")

		arg_7_0.name_.text = "???"
	end

	manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, arg_7_0.isUnlock_ and not arg_7_0.isViewed_)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
