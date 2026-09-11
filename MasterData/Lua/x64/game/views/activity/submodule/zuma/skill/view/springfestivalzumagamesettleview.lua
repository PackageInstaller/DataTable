local SpringFestivalZumaGameSettleView = class("SpringFestivalZumaGameSettleView", ReduxView)

function SpringFestivalZumaGameSettleView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaResultPopup"
end

function SpringFestivalZumaGameSettleView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalZumaGameSettleView:OnTop()
	manager.windowBar:SwitchBar({})
end

function SpringFestivalZumaGameSettleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpringFestivalZumaGameSettleView:InitUI()
	self:BindCfgUI()

	self.stateController = self.controllerexcollection_:GetController("state")
	self.diffcultController = self.controllerexcollection_:GetController("diffcult")
	self.conditionList = {}

	for iter_5_0 = 1, 3 do
		self.conditionList[iter_5_0] = ZumaConditionItem.New(self[string.format("condition%sGo_", iter_5_0)])
	end

	self.rewardIcon_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function SpringFestivalZumaGameSettleView:AddUIListener()
	self:AddBtnListener(self.confirmbtnBtn_, nil, function()
		DestroyLua()
		LaunchQWorld(true)
	end)
	self:AddBtnListener(self.reChallengeBtn_, nil, function()
		ZumaAction.ReChallengeZumaGame()
		self:Back()
	end)
end

function SpringFestivalZumaGameSettleView:OnEnter()
	self:RefreshUI()
end

function SpringFestivalZumaGameSettleView:OnExit()
	return
end

function SpringFestivalZumaGameSettleView:RefreshUI()
	local var_11_0 = self.params_.isWin or false

	if ActivityZumaLevelCfg[ZumaData:GetZumaGameId()].difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_11_0 = true
	end

	self.stateController:SetSelectedState(var_11_0 and "win" or "lose")
	self:RefreshInfo()

	if var_11_0 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	else
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end

	self:SendSDK(var_11_0)
	self:SendProto(var_11_0)
end

function SpringFestivalZumaGameSettleView:SendProto(arg_12_1)
	local var_12_0 = ZumaData:GetZumaGameId()

	ZumaAction.QueryZumaCompelet(ActivityZumaLevelCfg[var_12_0].main_activity_id, var_12_0, arg_12_1 and 1 or 2, ZumaData:GetZumaScore(), (ZumaToLuaBridge.GetZumaGamePlayTime()))
end

function SpringFestivalZumaGameSettleView:SendSDK(arg_13_1)
	local var_13_0 = ActivityZumaLevelCfg[ZumaData:GetZumaGameId()]
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(ZumaData:GetTalentList()) do
		if iter_13_1 then
			table.insert(var_13_1, iter_13_0)
		end
	end

	table.sort(var_13_1)

	local var_13_2, var_13_3 = ZumaData:GetRecordPointData()
	local var_13_4 = {}
	local var_13_5 = ZumaData:GetZumaSkillID()

	if var_13_5 > 0 then
		var_13_4 = string.format("[%s,%s]", var_13_5, var_13_3)
	end

	local var_13_6 = ""

	for iter_13_2, iter_13_3 in pairs(var_13_2) do
		local var_13_7 = iter_13_3[2]

		if not score then
			local var_13_8 = iter_13_2 - 1

			var_13_7 = var_13_8 > 0 and ZumaData:GetZumaScore() - ((var_13_2[iter_13_2 - 1] or nil) and (var_13_2[var_13_8][2] or 0)) or ZumaData:GetZumaScore()
		end

		var_13_6 = iter_13_2 == 1 and string.format("[%s,%s]", iter_13_3[1], var_13_7) or string.format("%s,[%s,%s]", var_13_6, iter_13_3[1], var_13_7)
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_13_0.main_activity_id,
		stage_id = var_13_0.id,
		result = arg_13_1 and 1 or 2,
		use_seconds = ZumaToLuaBridge.GetZumaGamePlayTime(),
		score = ZumaData:GetZumaScore(),
		activity_talent_list = var_13_1,
		skill_list = var_13_4,
		total_score = ZumaData:GetEndlessScore(),
		sequence_id = #var_13_2,
		other_data = var_13_6
	})
end

function SpringFestivalZumaGameSettleView:RefreshInfo()
	local var_14_0 = ZumaData:GetZumaScore()
	local var_14_1 = ZumaData:GetZumaGameId()
	local var_14_2 = ActivityZumaLevelCfg[var_14_1]
	local var_14_3, var_14_4 = ZumaData:GetZumaFinishPointList(var_14_0, ActivityZumaLevelCfg[var_14_1].activity_point_reward)
	local var_14_6 = ZumaData:GetZumaStageScore(var_14_1)
	local var_14_7, var_14_8 = ZumaData:GetZumaFinishPointList(var_14_6 or 0, ActivityZumaLevelCfg[var_14_1].activity_point_reward)
	local var_14_9 = math.max(var_14_4 - var_14_8, 0)

	self:UpdateTaskList(var_14_2.activity_point_reward, var_14_0 or 0)

	self.scoreTxt_.text = var_14_0
	self.rewardNumsTxt_.text = var_14_6 == nil and var_14_2.first_reward + var_14_9 or var_14_2.repeat_reward + var_14_9

	if var_14_2.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		self.diffcultController:SetSelectedState("endless")
	else
		self.diffcultController:SetSelectedState("normal")
	end
end

function SpringFestivalZumaGameSettleView:UpdateTaskList(arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		self.conditionList[iter_15_0]:RefreshConditionState(iter_15_1, arg_15_2)
	end
end

function SpringFestivalZumaGameSettleView:Dispose()
	for iter_16_0, iter_16_1 in pairs(self.conditionList) do
		iter_16_1:Dispose()
	end

	SpringFestivalZumaGameSettleView.super.Dispose(self)
end

return SpringFestivalZumaGameSettleView
