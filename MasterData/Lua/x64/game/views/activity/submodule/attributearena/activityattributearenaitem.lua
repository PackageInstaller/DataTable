local ActivityAttributeArenaItem = class("ActivityAttributeArenaItem", ReduxView)

function ActivityAttributeArenaItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityAttributeArenaItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaItem:InitUI()
	self:BindCfgUI()

	self.teamList = LuaList.New(handler(self, self.IndexTeamItem), self.m_teamList, ActivityAttributeArenaHeroItem)
	self.rankTeamList = LuaList.New(handler(self, self.IndexRankTeamItem), self.m_rankList, ActivityAttributeArenaHeroItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.scoreController = ControllerUtil.GetController(self.transform_, "score")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.rankController = ControllerUtil.GetController(self.transform_, "rank")
end

function ActivityAttributeArenaItem:AddUIListener()
	self:AddBtnListener(nil, self.m_clickBtn, function()
		if self.score > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_ATTRIBUTE_ARENE_RESET"),
				OkCallback = function()
					ActivityAttributeArenaAction.QueryResetScore(self.activity_id, self.attribute_arena_id)
				end
			})
		else
			local var_5_0 = {}

			var_5_0.section = ActivityAttributeArenaCfg[self.attribute_arena_id].stage_id
			var_5_0.sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA
			var_5_0.activityID = self.activity_id
			var_5_0.arena_index = self.index
			var_5_0.attribute_arena_id = self.attribute_arena_id
			var_5_0.reserveParams = self.reserveParams_

			self:Go("/sectionSelectHero", var_5_0)
		end
	end)
	self:AddBtnListener(nil, self.m_rankBtn, function()
		JumpTools.OpenPageByJump("/activityAttributeArenaRank", {
			rank_activity_id = self.rank_activity_id,
			index = self.index
		})
	end)
end

function ActivityAttributeArenaItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.activity_id = arg_8_2
	self.rank_activity_id = arg_8_3
	self.index = arg_8_1.index
	self.attribute_arena_id = arg_8_1.id
	self.score = arg_8_1.score

	self:GetHeroTeam()
	self:RefreshUI()
end

function ActivityAttributeArenaItem:GetHeroTeam()
	self.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA, self.attribute_arena_id, nil, {
		stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA,
		stageID = ActivityAttributeArenaCfg[self.attribute_arena_id].stage_id,
		attribute_arena_id = self.attribute_arena_id,
		activityID = self.activity_id
	})
	self.heroList_, self.trialList_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA):GetArenaHeroList(self.attribute_arena_id)

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self.heroList_) do
		if iter_9_1 == 0 then
			break
		end

		var_9_0 = var_9_0 + 1
	end

	self.heroCount_ = var_9_0
end

function ActivityAttributeArenaItem:RefreshUI()
	self.m_monsterIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ArenaUI/Boss/" .. ActivityAttributeArenaCfg[self.attribute_arena_id].stage_id)
	self.m_attributeIcon.sprite = HeroTools.GetSkillAttributeIcon(ActivityAttributeArenaCfg[self.attribute_arena_id].attribute)

	if self.score == 0 then
		self.scoreController:SetSelectedIndex(0)
	else
		self.scoreController:SetSelectedIndex(1)

		self.m_score.text = self.score

		self.teamList:StartScroll(self.heroCount_)
	end

	local var_10_0 = RankData:GetActivityRank(self.rank_activity_id, self.index)

	if var_10_0 and #var_10_0.rankList > 0 then
		self.rankController:SetSelectedIndex(1)
		self.commonPortrait_:RenderHead(var_10_0.rankList[1].portrait)
		self.commonPortrait_:RenderFrame(var_10_0.rankList[1].frame)

		self.m_rankScore.text = var_10_0.rankList[1].score
		self.m_rankLab.text = var_10_0.rankList[1].rank
		self.rankHeroList = var_10_0.rankList[1]:GetSingleSelectHeroList()

		self.rankTeamList:StartScroll(#self.rankHeroList)
	else
		self.rankController:SetSelectedIndex(0)
	end
end

function ActivityAttributeArenaItem:Dispose()
	self.commonPortrait_:Dispose()
	self.teamList:Dispose()
	self.rankTeamList:Dispose()
	ActivityAttributeArenaItem.super.Dispose(self)
end

function ActivityAttributeArenaItem:IndexTeamItem(arg_12_1, arg_12_2)
	if self.trialList_[arg_12_1] ~= 0 then
		arg_12_2:SetData(HeroStandardSystemCfg[self.trialList_[arg_12_1]].skin_id)
	else
		arg_12_2:SetData(HeroTools.HeroUsingSkinInfo(self.heroList_[arg_12_1]).id)
	end
end

function ActivityAttributeArenaItem:IndexRankTeamItem(arg_13_1, arg_13_2)
	arg_13_2:SetData((self.rankHeroList[arg_13_1].skin_id == 0 or nil) and self.rankHeroList[arg_13_1].hero_id)
end

return ActivityAttributeArenaItem
