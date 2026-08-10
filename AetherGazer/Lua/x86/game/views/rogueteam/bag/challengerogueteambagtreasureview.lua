local var_0_0 = class("ChallengeRogueTeamBagTreasureView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.tabItemList_ = {}
	arg_2_0.treasureList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexTreasureItem), arg_2_0.treasureUIList_, ChallengeRogueTeamBagTreasureItem)
	arg_2_0.campSkill_ = ChallengeRogueTeamBagTreasureCampSkillItem.New(arg_2_0.campSkillGo_)
	arg_2_0.tabItemList_ = {}
end

function var_0_0.OnEnter(arg_3_0, arg_3_1)
	arg_3_0.tabIndex_ = arg_3_1.tabIndex or 1
	arg_3_0.campId_ = arg_3_1.campId or 0
	arg_3_0.activityID = ChallengeRogueTeamData:GetActivityID()
	arg_3_0.templateID_ = ChallengeRogueTeamData:GetActiveTemplateID()

	local var_3_0 = RogueTeamCfg[arg_3_0.templateID_].item_temp

	arg_3_0.allTreasureID_, arg_3_0.tabDataList_ = ChallengeRogueTeamTools:GetAllSuitSkillIDList()
end

function var_0_0.IndexTabItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.tabDataList_[arg_4_1], arg_4_0.tabIndex_)
	arg_4_2:SetCallBack(function(arg_5_0)
		if arg_4_0.tabIndex_ == arg_5_0 then
			return
		end

		arg_4_0.tabIndex_ = arg_5_0
		arg_4_0.campId_ = arg_4_0.tabDataList_[arg_5_0]

		for iter_5_0, iter_5_1 in ipairs(arg_4_0.tabItemList_) do
			iter_5_1:RefreshSelect(arg_4_0.tabIndex_)

			arg_4_0.treasureDataList_ = ChallengeRogueTeamData:TreasureGetListByCampList({
				arg_4_0.tabDataList_[arg_5_0]
			})

			arg_4_0.treasureList_:StartScroll(#arg_4_0.treasureDataList_)
			arg_4_0.campSkill_:RefreshUI(arg_4_0.tabDataList_[arg_5_0])
		end
	end)
end

function var_0_0.IndexTreasureItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.treasureDataList_[arg_6_1])
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = RogueTeamCfg[arg_7_0.templateID_].item_temp

	arg_7_0.treasureDataList_ = ChallengeRogueTeamData:TreasureGetListByCampList({
		arg_7_0.campId_
	})

	table.sort(arg_7_0.treasureDataList_, function(arg_8_0, arg_8_1)
		if arg_8_0.rare ~= arg_8_1.rare then
			return arg_8_0.rare > arg_8_1.rare
		else
			return arg_8_0.id < arg_8_1.id
		end
	end)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.tabDataList_) do
		if not arg_7_0.tabItemList_[iter_7_0] then
			local var_7_1 = Object.Instantiate(arg_7_0.tabItemGo_, arg_7_0.tabContent_)

			arg_7_0.tabItemList_[iter_7_0] = ChallengeRogueTeamBagTreasureTabItem.New(var_7_1)
		end

		arg_7_0:IndexTabItem(iter_7_0, arg_7_0.tabItemList_[iter_7_0])
		SetActive(arg_7_0.tabItemList_[iter_7_0].gameObject_, true)
	end

	for iter_7_2 = #arg_7_0.tabItemList_, #arg_7_0.tabDataList_ + 1, -1 do
		SetActive(arg_7_0.tabItemList_[iter_7_2].gameObject_, false)
	end

	arg_7_0.treasureList_:StartScroll(#arg_7_0.treasureDataList_)
	arg_7_0.campSkill_:RefreshUI(arg_7_0.tabDataList_[arg_7_0.tabIndex_])
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.tabItemList_ then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.tabItemList_) do
			iter_10_1:Dispose()
		end

		arg_10_0.tabItemList_ = nil
	end

	if arg_10_0.treasureList_ then
		arg_10_0.treasureList_:Dispose()

		arg_10_0.treasureList_ = nil
	end

	if arg_10_0.campSkill_ then
		arg_10_0.campSkill_:Dispose()

		arg_10_0.campSkill_ = nil
	end
end

return var_0_0
