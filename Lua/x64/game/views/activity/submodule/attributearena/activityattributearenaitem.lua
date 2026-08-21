local var_0_0 = class("ActivityAttributeArenaItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.teamList = LuaList.New(handler(arg_3_0, arg_3_0.IndexTeamItem), arg_3_0.m_teamList, ActivityAttributeArenaHeroItem)
	arg_3_0.rankTeamList = LuaList.New(handler(arg_3_0, arg_3_0.IndexRankTeamItem), arg_3_0.m_rankList, ActivityAttributeArenaHeroItem)
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
	arg_3_0.scoreController = ControllerUtil.GetController(arg_3_0.transform_, "score")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.rankController = ControllerUtil.GetController(arg_3_0.transform_, "rank")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_clickBtn, function()
		if arg_4_0.score > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_ATTRIBUTE_ARENE_RESET"),
				OkCallback = function()
					ActivityAttributeArenaAction.QueryResetScore(arg_4_0.activity_id, arg_4_0.attribute_arena_id)
				end
			})
		else
			local var_5_0 = ActivityAttributeArenaCfg[arg_4_0.attribute_arena_id]

			arg_4_0:Go("/sectionSelectHero", {
				section = var_5_0.stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA,
				activityID = arg_4_0.activity_id,
				arena_index = arg_4_0.index,
				attribute_arena_id = arg_4_0.attribute_arena_id,
				reserveParams = arg_4_0.reserveParams_
			})
		end
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_rankBtn, function()
		JumpTools.OpenPageByJump("/activityAttributeArenaRank", {
			rank_activity_id = arg_4_0.rank_activity_id,
			index = arg_4_0.index
		})
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.activity_id = arg_8_2
	arg_8_0.rank_activity_id = arg_8_3
	arg_8_0.index = arg_8_1.index
	arg_8_0.attribute_arena_id = arg_8_1.id
	arg_8_0.score = arg_8_1.score

	arg_8_0:GetHeroTeam()
	arg_8_0:RefreshUI()
end

function var_0_0.GetHeroTeam(arg_9_0)
	local var_9_0 = ActivityAttributeArenaCfg[arg_9_0.attribute_arena_id]

	arg_9_0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA, arg_9_0.attribute_arena_id, nil, {
		stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA,
		stageID = var_9_0.stage_id,
		attribute_arena_id = arg_9_0.attribute_arena_id,
		activityID = arg_9_0.activity_id
	})
	arg_9_0.heroList_, arg_9_0.trialList_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA):GetArenaHeroList(arg_9_0.attribute_arena_id)

	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.heroList_) do
		if iter_9_1 == 0 then
			break
		end

		var_9_1 = var_9_1 + 1
	end

	arg_9_0.heroCount_ = var_9_1
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = ActivityAttributeArenaCfg[arg_10_0.attribute_arena_id]

	arg_10_0.m_monsterIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ArenaUI/Boss/" .. var_10_0.stage_id)
	arg_10_0.m_attributeIcon.sprite = HeroTools.GetSkillAttributeIcon(var_10_0.attribute)

	if arg_10_0.score == 0 then
		arg_10_0.scoreController:SetSelectedIndex(0)
	else
		arg_10_0.scoreController:SetSelectedIndex(1)

		arg_10_0.m_score.text = arg_10_0.score

		arg_10_0.teamList:StartScroll(arg_10_0.heroCount_)
	end

	local var_10_1 = RankData:GetActivityRank(arg_10_0.rank_activity_id, arg_10_0.index)

	if var_10_1 and #var_10_1.rankList > 0 then
		arg_10_0.rankController:SetSelectedIndex(1)

		local var_10_2 = var_10_1.rankList[1]

		arg_10_0.commonPortrait_:RenderHead(var_10_2.portrait)
		arg_10_0.commonPortrait_:RenderFrame(var_10_2.frame)

		arg_10_0.m_rankScore.text = var_10_2.score
		arg_10_0.m_rankLab.text = var_10_2.rank
		arg_10_0.rankHeroList = var_10_2:GetSingleSelectHeroList()

		arg_10_0.rankTeamList:StartScroll(#arg_10_0.rankHeroList)
	else
		arg_10_0.rankController:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonPortrait_:Dispose()
	arg_11_0.teamList:Dispose()
	arg_11_0.rankTeamList:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.IndexTeamItem(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.trialList_[arg_12_1] ~= 0 then
		local var_12_0 = HeroStandardSystemCfg[arg_12_0.trialList_[arg_12_1]]

		arg_12_2:SetData(var_12_0.skin_id)
	else
		arg_12_2:SetData(HeroTools.HeroUsingSkinInfo(arg_12_0.heroList_[arg_12_1]).id)
	end
end

function var_0_0.IndexRankTeamItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.rankHeroList[arg_13_1]
	local var_13_1 = var_13_0.skin_id

	if var_13_1 == 0 then
		var_13_1 = var_13_0.hero_id
	end

	arg_13_2:SetData(var_13_1)
end

return var_0_0
