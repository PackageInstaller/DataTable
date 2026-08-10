local var_0_0 = class("ChallengeRogueTeamScoreItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.scoreIDList_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.getController_ = arg_2_0.controller_:GetController("get")
	arg_2_0.commonItem_ = CommonItemView.New(arg_2_0.rewardItem_, true)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.cfg_ = ActivityPointRewardCfg[arg_6_1]
	arg_6_0.levelText_.text = tostring(math.floor(arg_6_0.cfg_.need / ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_PER_VALUE, ChallengeRogueTeamData:GetCacheTemplateID())))
	arg_6_0.reward_ = arg_6_0.cfg_.reward_item_list[1]

	arg_6_0:RefreshUI()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = clone(ItemTemplateData)
	local var_8_1 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_8_2 = arg_8_0.cfg_.need > ItemTools.getItemNum(RogueTeamCfg[var_8_1].point_item)
	local var_8_3 = arg_8_0.cfg_.need <= ItemTools.getItemNum(RogueTeamCfg[var_8_1].point_item)
	local var_8_4 = table.indexof(ChallengeRogueTeamData:GetRewardedScoreList(ChallengeRogueTeamData:GetCacheTemplateID()), arg_8_0.taskID_)

	var_8_0.id = arg_8_0.reward_[1]
	var_8_0.number = arg_8_0.reward_[2]

	function var_8_0.clickFun(arg_9_0)
		if var_8_3 and not var_8_4 then
			local var_9_0 = {}

			for iter_9_0, iter_9_1 in ipairs(arg_8_0.scoreIDList_) do
				local var_9_1 = ActivityPointRewardCfg[iter_9_1].need <= ItemTools.getItemNum(RogueTeamCfg[var_8_1].point_item)
				local var_9_2 = table.indexof(ChallengeRogueTeamData:GetRewardedScoreList(ChallengeRogueTeamData:GetCacheTemplateID()), iter_9_1)

				if var_9_1 and not var_9_2 then
					table.insert(var_9_0, iter_9_1)
				end
			end

			ActivityAction.ReceivePointReward(var_9_0, nil, arg_8_0.callBack_)

			return
		end

		ShowPopItem(POP_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end

	arg_8_0.commonItem_:SetData(var_8_0)

	if var_8_2 then
		if table.indexof(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()), arg_8_0.index_) then
			arg_8_0.getController_:SetSelectedState("bigFalse")
		else
			arg_8_0.getController_:SetSelectedState("false")
		end

		arg_8_0.commonItem_:RefreshCompleted(false)
		arg_8_0.commonItem_:RefreshHighLight(false)
	elseif var_8_4 then
		if table.indexof(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()), arg_8_0.index_) then
			arg_8_0.getController_:SetSelectedState("bigTrue")
		else
			arg_8_0.getController_:SetSelectedState("true")
		end

		arg_8_0.commonItem_:RefreshCompleted(true)
		arg_8_0.commonItem_:RefreshHighLight(false)
	else
		if table.indexof(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID()), arg_8_0.index_) then
			arg_8_0.getController_:SetSelectedState("bigTrue")
		else
			arg_8_0.getController_:SetSelectedState("true")
		end

		arg_8_0.commonItem_:RefreshCompleted(false)
		arg_8_0.commonItem_:RefreshHighLight(true)
	end
end

function var_0_0.SetReveivedHandler(arg_10_0, arg_10_1)
	arg_10_0.callBack_ = arg_10_1
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

return var_0_0
