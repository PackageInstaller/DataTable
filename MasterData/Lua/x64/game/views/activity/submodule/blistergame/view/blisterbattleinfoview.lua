local BlisterBattleInfoView = class("BlisterBattleInfoView", ReduxView)

function BlisterBattleInfoView:UIName()
	return "Widget/System/Summer2024/Summer2024_BlisterGame/BlisterGame02"
end

function BlisterBattleInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function BlisterBattleInfoView:OnCtor()
	return
end

function BlisterBattleInfoView:Init()
	self.waterEffectList = {}

	self:InitUI()
	self:AddListeners()
end

function BlisterBattleInfoView:InitUI()
	self:BindCfgUI()

	self.nodeList = {}
	self.waterDic = {}
	self.score = 0
	self.leftNum = 0
	self.hitNum = 0
	self.pointlist = {}
end

function BlisterBattleInfoView:AddListeners()
	return
end

function BlisterBattleInfoView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.isEnded or BlisterGameLuaBridge.IsInAnim() then
			return
		end

		BlisterGameLuaBridge.PauseGame()
		BlisterGameTool.GoToBlisterMessageView("onlydetail", function()
			local var_9_0

			if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
				ChessBoardAction.GoBackFromSmallGame(1, 0)

				do return end

				var_9_0 = {
					result = 3,
					activity_id = BlisterGameData.activityID,
					stage_id = self.stageId,
					score = self.score,
					hit_num = self.hitNum,
					remain = self.leftNum
				}
			end

			var_9_0.combat_star = BlisterGameData:GetStarByScore(self.stageId, self.score)

			SDKTools.SendMessageToSDK("activity_combat_over", var_9_0)
			BlisterGameTool.ExitGame()
		end, self)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		self:GotoHelp()
	end)
end

function BlisterBattleInfoView:GotoHelp()
	local var_11_0 = ""

	var_11_0 = BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME and "blister_game_describe" .. (BlisterGameTool.GetSession(ActivityConst.SUMMER_CHESS_BOARD_BUBBLE, 1) == ActivityBubbleCfg[self.stageId].session and 1 or 2) or table.indexof(ActivityCfg[BlisterGameData:GetActivityId()].sub_activity_list, ActivityBubbleCfg[self.stageId].activity_id) == 1 and "blister_game_4_3_describe_normal" or "blister_game_4_3_describe_special"

	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = (GameSetting[var_11_0] or nil) and (GameSetting[var_11_0].value or {})
	})
end

function BlisterBattleInfoView:UpdateLeftNum(arg_12_1)
	self.textText_.text = arg_12_1
	self.isReset = false
end

function BlisterBattleInfoView:OnEnter()
	self.isEnded = false
	self.animatorNumList = {}
	self.delayTimeList = {}

	SetActive(self.effect, false)
	self:ChangeBar()
	self:UpdateScore(self.score)

	self.stageId = BlisterGameData.passId

	self:RegistEventListener(BLISTERGAME_UpdateteNum, function(arg_14_0)
		self:UpdateLeftNum(arg_14_0)
	end)
	self:RegistEventListener(BLISTERGAME_UpdateteScore, function(arg_15_0, arg_15_1)
		local var_15_0 = false
		local var_15_1 = 0
		local var_15_2 = true

		if arg_15_0 == 1 then
			self.score = self.score + arg_15_1 * GameSetting.activity_bubble_left_point.value[1]
			self.leftNum = arg_15_1
			var_15_0 = true
			var_15_1 = 0.6
		elseif arg_15_0 == 2 then
			self.score = self.score + arg_15_1 * GameSetting.activity_bubble_splash_point.value[1]

			manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_bubble_break", "")

			var_15_0 = true
			var_15_1 = 0.1
		elseif arg_15_0 == 3 then
			self.hitNum = math.max(self.hitNum, arg_15_1)
			self.scoretextText_.text = self.score
		elseif arg_15_0 == 4 then
			self.score = arg_15_1
			self.isReset = true
			var_15_0 = false
			var_15_2 = false
		elseif arg_15_0 == 5 then
			self.score = self.score + GameSetting.activity_bubble_combo_point.value[1] * math.max(arg_15_1 - 1, 0)
			var_15_0 = true
			var_15_1 = self.isEnded and 0.8 or 0.1
		end

		if arg_15_0 ~= 3 then
			self:UpdateScore(self.score, var_15_0, var_15_1, var_15_2)
		end

		self:RefreshScoreState()
	end)
	self:RegistEventListener(BLISTERGAME_GAMEEND, function(arg_16_0)
		self.isEnded = true

		local var_16_0 = BlisterGameData:GetStarByScore(self.stageId, self.score)
		local var_16_1 = deferred.new()
		local var_16_2 = deferred.new()

		if arg_16_0 then
			BlisterGameAction.SendBlisterGameResult(BlisterGameData:GetActivityId(), self.stageId, self.score, var_16_0, function(arg_17_0)
				var_16_1:resolve(arg_17_0)
			end)
		else
			var_16_1:resolve()
		end

		SDKTools.SendMessageToSDK("activity_combat_over", {
			activity_id = BlisterGameData.activityID,
			stage_id = self.stageId,
			result = arg_16_0 and 1 or 2,
			score = self.score,
			hit_num = self.hitNum,
			remain = self.leftNum,
			combat_star = var_16_0
		})
		self:PlayEndEffect(self.leftNum)
		deferred.all({
			var_16_1,
			var_16_2
		}):next(function(arg_19_0)
			BlisterGameTool.GoToBlisterResultView(self.stageId, self.score, var_16_0, arg_16_0, not isSuccess(nullable(arg_19_0, 1, "result") or TipsCfg.get_id_list_by_define.SUCCESS))
		end)
		table.insert(self.delayTimeList, (TimeTools.StartAfterSeconds(1.2, function()
			self.isEnded = false

			var_16_2:resolve()
		end, {})))
	end)
	self:RegistEventListener(BLISTERGAME_UpdateCombo, function(arg_20_0)
		self:UpdateCombo(math.max(arg_20_0, 0))
	end)
	self:RegistEventListener(BLISTERGAME_ONWATERRING, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		self:AddWaterEffect(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	end)
	self:RegistEventListener(BLISTERGAME_BIGNODE, function()
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_bubble_big", "")
	end)
	self:RegistEventListener(BLISTERGAME_ADD_ANIM, function()
		self:PlayAddEffect()
	end)
	self:RegistEventListener(BLISTERGAME_REDUCE_ANIM, function()
		self:PlayReduceEffect()
	end)
	SetActive(self.comboattackGo_, false)
	self:RefreshScoreState()
	BlisterBattleInfoView.super.OnEnter(self)
	self:ResetAnimate()

	if (ActivityBubbleCfg[self.stageId].pre == 0 or ActivityBubbleCfg[self.stageId].id == BlisterGameData:GetSecondPhaseFirstStage()) and not getData("BlisterGame3", "showHelp" .. self.stageId) then
		self:GotoHelp()
		saveData("BlisterGame3", "showHelp" .. self.stageId, 1)
	end
end

function BlisterBattleInfoView:RefreshScoreState()
	local var_25_0 = ActivityBubbleCfg[self.stageId]

	for iter_25_0 = 1, 3 do
		self.nodeList[iter_25_0] = self.nodeList[iter_25_0] or BlisterGoalItem.New(self[string.format("ndnum0%sGo_", iter_25_0)])

		self.nodeList[iter_25_0]:SetData(self.score >= var_25_0.score_level[iter_25_0], var_25_0.score_level[iter_25_0] or 0)
	end
end

function BlisterBattleInfoView:ResetAnimate()
	SetActive(self.comboattackGo_, false)

	if self.scorebigAni_ then
		self.scorebigAni_:Play("Fx_scoretext_idle")
	end

	for iter_26_0, iter_26_1 in pairs(self.waterEffectList or {}) do
		if iter_26_1 and iter_26_1.ResetAnimate then
			iter_26_1:ResetAnimate(1)
		end
	end

	if self.scoretextAni_ then
		self.scoretextAni_:Play("Fx_scoretext_cx", 0, 1)
	end
end

function BlisterBattleInfoView:ChangeTab(arg_27_1)
	self.tabController_:SetSelectedState("state" .. arg_27_1 - 1)
end

function BlisterBattleInfoView:PlayEndEffect(arg_28_1)
	self.textText1_.text = "+" .. arg_28_1 * GameSetting.activity_bubble_left_point.value[1]

	if self.scorebigAni_ then
		self.scorebigAni_:Play("Fx_scorebig_blow")
	end
end

function BlisterBattleInfoView:OnTop()
	self:ResetAnimate()
	self:ChangeBar()

	self.isEnded = false
end

function BlisterBattleInfoView:PlayAddWaterEffect(arg_30_1)
	if self.effect then
		self.effect.transform.position = self.startpositionTrs_.position

		SetActive(self.effect, true)
		self:RemoveTween()

		self.tween_ = LeanTween.move(self.effect, self.endpositionTrs_.position, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			SetActive(self.effect, false)

			if not self.isEnded and not self.isReset then
				self.scorebigAni_:Play("Fx_scorebig_cx", 0, 0)
			end

			self.textText_.text = arg_30_1
		end))
	end

	self:ChangeBar()
end

function BlisterBattleInfoView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function BlisterBattleInfoView:OnTask()
	return
end

function BlisterBattleInfoView:UpdateCombo(arg_34_1)
	self:AddNumAnimator(arg_34_1)
	self:CheckNumAnimator()
end

function BlisterBattleInfoView:AddNumAnimator(arg_35_1)
	table.insert(self.animatorNumList, arg_35_1)
end

function BlisterBattleInfoView:CheckNumAnimator()
	if not self.isNumAni then
		local var_36_0 = table.remove(self.animatorNumList, 1)

		if var_36_0 then
			self.isNumAni = true

			self:DoComboAniamtion(var_36_0)
		else
			self.isNumAni = false
		end
	end
end

function BlisterBattleInfoView:DoComboAniamtion(arg_37_1)
	SetActive(self.comboattackGo_, true)

	if self.comboattackAni_ then
		self.comboattackAni_:Play("Fx_comboattack_cx", 0, 0)
	end

	if arg_37_1 ~= 0 then
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_bubble_breakui", "")

		self.combotextText_.text = arg_37_1

		table.insert(self.delayTimeList, (TimeTools.StartAfterSeconds(0.12, function()
			self.isNumAni = false

			self:CheckNumAnimator()
		end, {})))
	else
		self.isNumAni = false

		SetActive(self.comboattackGo_, false)
	end
end

function BlisterBattleInfoView:UpdateScore(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	self.now = self.scoretextText_.text

	if arg_39_2 and tonumber(self.now) < self.score - 600 then
		if not self.timer_ and tonumber(self.now) < self.score then
			local var_39_0 = math.floor((self.score - self.now) / 5)

			self.timer_ = Timer.New(function()
				self.now = math.min(self.now + var_39_0, self.score)
				self.scoretextText_.text = self.now

				if self.now >= self.score then
					self:StopTime()
				end

				if self.scoretextAni_ and self.scoretextAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					self.scoretextAni_:Play("Fx_scoretext_cx", 0, 0)
				end
			end, 0.01, -1)

			table.insert(self.delayTimeList, (TimeTools.StartAfterSeconds(arg_39_3 or 0, function()
				if self.timer_ then
					self.timer_:Start()
				end
			end, {})))
		end
	else
		if self.scoretextAni_ and arg_39_4 then
			self.scoretextAni_:Play("Fx_scoretext_cx", 0, 0)
		end

		self.scoretextText_.text = arg_39_1
	end
end

function BlisterBattleInfoView:StopTime()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BlisterBattleInfoView:AddWaterEffect(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	self.waterDic[arg_43_1] = self.waterDic[arg_43_1] or {}

	local var_43_0 = self.waterDic[arg_43_1][arg_43_2]

	if not self.waterDic[arg_43_1][arg_43_2] then
		item = BlisterScoreItem.New((Object.Instantiate(self.waterGo_, self.bubleanimatorTrs_)))

		table.insert(self.waterEffectList, item)

		self.waterDic[arg_43_1][arg_43_2] = #self.waterEffectList
		var_43_0 = #self.waterEffectList
	end

	item = self.waterEffectList[var_43_0]

	item:SetPosition(arg_43_1, arg_43_2, arg_43_3, arg_43_4, function()
		return
	end)
end

function BlisterBattleInfoView:PlayAddEffect()
	SetActive(self.rainAnimGo_, false)
	SetActive(self.rainAnimGo_, true)
	manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_bubble_break02", "")
	Timer.New(function()
		SetActive(self.rainAnimGo_, false)
	end, 1, 1):Start()
end

function BlisterBattleInfoView:PlayReduceEffect()
	SetActive(self.evaporationAnimGo_, false)
	SetActive(self.evaporationAnimGo_, true)
	manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_bubble_break01", "")
	Timer.New(function()
		SetActive(self.evaporationAnimGo_, false)
	end, 1, 1):Start()
end

function BlisterBattleInfoView:OnExit()
	BlisterBattleInfoView.super.OnExit(self)
	manager.windowBar:HideBar()
	BlisterGameData:SavePointIndx(table.indexof(BlisterGameTool.GetSubActiveID(BlisterGameData:GetActivityId()), ActivityBubbleCfg[self.stageId].activity_id))
	self:StopTime()

	for iter_49_0, iter_49_1 in pairs(self.delayTimeList) do
		if iter_49_1 and iter_49_1.Stop then
			iter_49_1:Stop()
		end
	end

	self.delayTimeList = {}

	self:RemoveTween()
end

function BlisterBattleInfoView:Dispose()
	BlisterBattleInfoView.super.Dispose(self)

	for iter_50_0, iter_50_1 in ipairs(self.waterEffectList) do
		iter_50_1:Dispose()
	end

	for iter_50_2, iter_50_3 in ipairs(self.nodeList) do
		iter_50_3:Dispose()
	end

	self.nodeList = {}
	self.waterEffectList = {}
end

return BlisterBattleInfoView
