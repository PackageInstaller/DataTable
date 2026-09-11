local ActivityMatrixOriginView = class("ActivityMatrixOriginView", (import("game.views.matrixOver.MatrixOverView")))

function ActivityMatrixOriginView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityBattleMatrixOverUI"
end

function ActivityMatrixOriginView:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}

	for iter_2_0 = 1, 3 do
		self.heroItemList_[iter_2_0] = ActivityMatrixOverHeroItem.New(self[string.format("heroItem%s_", iter_2_0)])
	end

	self.affixList_ = LuaList.New(handler(self, self.AffixIndexItem), self.m_affixList, MatrixOverAffixItem)
	self.treasureList_ = LuaList.New(handler(self, self.ArtifactIndexItem), self.m_treasureList, MatrixOverArtifactItem)
	self.beaconList_ = LuaList.New(handler(self, self.BeaconIndexItem), self.m_beaconList, MatrixOverBeaconItem)
	self.resultController_ = ControllerUtil.GetController(self.transform_, "result")
	self.difficultyController_ = ControllerUtil.GetController(self.transform_, "difficulty")
end

function ActivityMatrixOriginView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
				main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(self.matrix_activity_id),
				matrix_activity_id = self.matrix_activity_id
			})
		else
			ActivityMatrixAction.QueryMatrixOver(self.matrix_activity_id)
		end
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsActivityMatrixOver", {
			matrix_activity_id = self.matrix_activity_id
		})
	end)
end

function ActivityMatrixOriginView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	for iter_6_0 = 1, 3 do
		self.heroItemList_[iter_6_0]:SetMatrixActivityId(self.matrix_activity_id)
	end

	self:Refresh()

	if self:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		local var_6_0

		if ActivityMatrixCfg[self.matrix_activity_id] then
			var_6_0 = ActivityMatrixCfg[self.matrix_activity_id].after_story_id or {}
		end

		local var_6_1 = false

		for iter_6_1, iter_6_2 in ipairs(var_6_0) do
			if iter_6_2 and not manager.story:IsStoryPlayed(iter_6_2) then
				var_6_1 = true

				break
			end
		end

		if var_6_1 then
			self.storyList = clone(var_6_0)

			manager.story:StartStoryById(self.storyList[1], function(arg_7_0)
				self:CheckStoryPlay()
			end)
		end
	end
end

function ActivityMatrixOriginView:CheckStoryPlay()
	PlayerAction.ChangeStoryList(self.storyList[1])
	table.remove(self.storyList, 1)

	if #self.storyList > 0 then
		manager.story:StartStoryById(self.storyList[1], function(arg_9_0)
			self:CheckStoryPlay()
		end)
	end
end

function ActivityMatrixOriginView:Refresh()
	ActivityMatrixOriginView.super.Refresh(self)

	self.m_clueText.text = ActivityMatrixData:GetMatrixIsFirstClear(self.matrix_activity_id) and string.format(GetTips("ACTIVITY_VOLUME_MATRIX_CLUE"), (ActivityMatrixData:GetMatrixClueCount(ActivityMatrixData:GetMainActivityId(self.matrix_activity_id), self.matrix_activity_id))) or ""
end

function ActivityMatrixOriginView:OnMatrixUserUpdate()
	local var_11_0 = MatrixData:GetGameState()

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_11_0 then
		-- block empty
	elseif MatrixConst.STATE_TYPE.SUCCESS ~= var_11_0 and MatrixConst.STATE_TYPE.FAIL == var_11_0 then
		-- block empty
	end
end

function ActivityMatrixOriginView:GetGameState()
	return ActivityMatrixData:GetGameState(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetCurrentClearTime()
	return ActivityMatrixData:GetCurrentClearTime(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetMinClearTime()
	return ActivityMatrixData:GetMinClearTime(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetEvaluateList()
	return {}
end

function ActivityMatrixOriginView:GetTierDes()
	local var_16_0 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(self.matrix_activity_id)]

	return string.format("%s-%s", var_16_0.tier, var_16_0.level)
end

function ActivityMatrixOriginView:GetAffixList()
	return {}
end

function ActivityMatrixOriginView:GetArtifactList()
	return ActivityMatrixData:GetArtifactList(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetUseBeaconList()
	return {}
end

function ActivityMatrixOriginView:GetMatrixCurrencyList()
	return ActivityMatrixData:GetMatrixCurrencyList(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetMatrixHeroTeam()
	return ActivityMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetMatrixOverScore()
	return ActivityMatrixData:GetMatrixOverPoint(self.matrix_activity_id)
end

function ActivityMatrixOriginView:GetDifficulty()
	return 1
end

function ActivityMatrixOriginView:GetRegularAffix()
	return {}
end

function ActivityMatrixOriginView:GetCustomAffix()
	return {}
end

return ActivityMatrixOriginView
