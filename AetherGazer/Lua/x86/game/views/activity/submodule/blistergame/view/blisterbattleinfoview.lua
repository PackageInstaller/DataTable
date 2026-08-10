local var_0_0 = class("BlisterBattleInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_BlisterGame/BlisterGame02"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.waterEffectList = {}

	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.nodeList = {}
	arg_5_0.waterDic = {}
	arg_5_0.score = 0
	arg_5_0.leftNum = 0
	arg_5_0.hitNum = 0
	arg_5_0.pointlist = {}
end

function var_0_0.AddListeners(arg_6_0)
	return
end

function var_0_0.ChangeBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_7_0.isEnded or BlisterGameLuaBridge.IsInAnim() then
			return
		end

		BlisterGameLuaBridge.PauseGame()

		local function var_8_0()
			if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
				ChessBoardAction.GoBackFromSmallGame(1, 0)

				return
			end

			local var_9_0 = BlisterGameData:GetStarByScore(arg_7_0.stageId, arg_7_0.score)

			SDKTools.SendMessageToSDK("activity_combat_over", {
				result = 3,
				activity_id = BlisterGameData.activityID,
				stage_id = arg_7_0.stageId,
				score = arg_7_0.score,
				hit_num = arg_7_0.hitNum,
				remain = arg_7_0.leftNum,
				combat_star = var_9_0
			})
			BlisterGameTool.ExitGame()
		end

		BlisterGameTool.GoToBlisterMessageView("onlydetail", var_8_0, arg_7_0)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		arg_7_0:GotoHelp()
	end)
end

function var_0_0.GotoHelp(arg_11_0)
	local var_11_0 = ActivityBubbleCfg[arg_11_0.stageId]
	local var_11_1 = BlisterGameData.activityID
	local var_11_2 = ""

	if var_11_1 == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		local var_11_3 = BlisterGameTool.GetSession(ActivityConst.SUMMER_CHESS_BOARD_BUBBLE, 1)

		var_11_2 = "blister_game_describe" .. (var_11_3 == var_11_0.session and 1 or 2)
	else
		local var_11_4 = ActivityCfg[BlisterGameData:GetActivityId()].sub_activity_list

		var_11_2 = table.indexof(var_11_4, var_11_0.activity_id) == 1 and "blister_game_4_3_describe_normal" or "blister_game_4_3_describe_special"
	end

	local var_11_5 = GameSetting[var_11_2] and GameSetting[var_11_2].value or {}

	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = var_11_5
	})
end

function var_0_0.UpdateLeftNum(arg_12_0, arg_12_1)
	arg_12_0.textText_.text = arg_12_1
	arg_12_0.isReset = false
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.isEnded = false
	arg_13_0.animatorNumList = {}
	arg_13_0.delayTimeList = {}

	SetActive(arg_13_0.effect, false)
	arg_13_0:ChangeBar()
	arg_13_0:UpdateScore(arg_13_0.score)

	arg_13_0.stageId = BlisterGameData.passId

	local var_13_0 = ActivityBubbleCfg[arg_13_0.stageId]

	arg_13_0:RegistEventListener(BLISTERGAME_UpdateteNum, function(arg_14_0)
		arg_13_0:UpdateLeftNum(arg_14_0)
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_UpdateteScore, function(arg_15_0, arg_15_1)
		local var_15_0 = false
		local var_15_1 = 0
		local var_15_2 = true

		if arg_15_0 == 1 then
			arg_13_0.score = arg_13_0.score + arg_15_1 * GameSetting.activity_bubble_left_point.value[1]
			arg_13_0.leftNum = arg_15_1
			var_15_0 = true
			var_15_1 = 0.6
		elseif arg_15_0 == 2 then
			arg_13_0.score = arg_13_0.score + arg_15_1 * GameSetting.activity_bubble_splash_point.value[1]

			manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_bubble_break", "")

			var_15_0 = true
			var_15_1 = 0.1
		elseif arg_15_0 == 3 then
			arg_13_0.hitNum = math.max(arg_13_0.hitNum, arg_15_1)
			arg_13_0.scoretextText_.text = arg_13_0.score
		elseif arg_15_0 == 4 then
			arg_13_0.score = arg_15_1
			arg_13_0.isReset = true
			var_15_0 = false
			var_15_2 = false
		elseif arg_15_0 == 5 then
			local var_15_3 = math.max(arg_15_1 - 1, 0)

			arg_13_0.score = arg_13_0.score + GameSetting.activity_bubble_combo_point.value[1] * var_15_3
			var_15_0 = true
			var_15_1 = arg_13_0.isEnded and 0.8 or 0.1
		end

		if arg_15_0 ~= 3 then
			arg_13_0:UpdateScore(arg_13_0.score, var_15_0, var_15_1, var_15_2)
		end

		arg_13_0:RefreshScoreState()
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_GAMEEND, function(arg_16_0)
		arg_13_0.isEnded = true

		local var_16_0 = BlisterGameData:GetStarByScore(arg_13_0.stageId, arg_13_0.score)
		local var_16_1 = deferred.new()
		local var_16_2 = deferred.new()

		if arg_16_0 then
			BlisterGameAction.SendBlisterGameResult(BlisterGameData:GetActivityId(), arg_13_0.stageId, arg_13_0.score, var_16_0, function(arg_17_0)
				var_16_1:resolve(arg_17_0)
			end)
		else
			var_16_1:resolve()
		end

		SDKTools.SendMessageToSDK("activity_combat_over", {
			activity_id = BlisterGameData.activityID,
			stage_id = arg_13_0.stageId,
			result = arg_16_0 and 1 or 2,
			score = arg_13_0.score,
			hit_num = arg_13_0.hitNum,
			remain = arg_13_0.leftNum,
			combat_star = var_16_0
		})
		arg_13_0:PlayEndEffect(arg_13_0.leftNum)

		local var_16_3 = TimeTools.StartAfterSeconds(1.2, function()
			arg_13_0.isEnded = false

			var_16_2:resolve()
		end, {})

		deferred.all({
			var_16_1,
			var_16_2
		}):next(function(arg_19_0)
			local var_19_0 = nullable(arg_19_0, 1, "result") or TipsCfg.get_id_list_by_define.SUCCESS

			BlisterGameTool.GoToBlisterResultView(arg_13_0.stageId, arg_13_0.score, var_16_0, arg_16_0, not isSuccess(var_19_0))
		end)
		table.insert(arg_13_0.delayTimeList, var_16_3)
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_UpdateCombo, function(arg_20_0)
		arg_13_0:UpdateCombo(math.max(arg_20_0, 0))
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_ONWATERRING, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		arg_13_0:AddWaterEffect(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_BIGNODE, function()
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_bubble_big", "")
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_ADD_ANIM, function()
		arg_13_0:PlayAddEffect()
	end)
	arg_13_0:RegistEventListener(BLISTERGAME_REDUCE_ANIM, function()
		arg_13_0:PlayReduceEffect()
	end)
	SetActive(arg_13_0.comboattackGo_, false)
	arg_13_0:RefreshScoreState()
	var_0_0.super.OnEnter(arg_13_0)
	arg_13_0:ResetAnimate()

	if (var_13_0.pre == 0 or var_13_0.id == BlisterGameData:GetSecondPhaseFirstStage()) and not getData("BlisterGame3", "showHelp" .. arg_13_0.stageId) then
		arg_13_0:GotoHelp()
		saveData("BlisterGame3", "showHelp" .. arg_13_0.stageId, 1)
	end
end

function var_0_0.RefreshScoreState(arg_25_0)
	local var_25_0 = ActivityBubbleCfg[arg_25_0.stageId]

	for iter_25_0 = 1, 3 do
		if not arg_25_0.nodeList[iter_25_0] then
			arg_25_0.nodeList[iter_25_0] = BlisterGoalItem.New(arg_25_0[string.format("ndnum0%sGo_", iter_25_0)])
		end

		local var_25_1 = arg_25_0.score >= var_25_0.score_level[iter_25_0]

		arg_25_0.nodeList[iter_25_0]:SetData(var_25_1, var_25_0.score_level[iter_25_0] or 0)
	end
end

function var_0_0.ResetAnimate(arg_26_0)
	SetActive(arg_26_0.comboattackGo_, false)

	if arg_26_0.scorebigAni_ then
		arg_26_0.scorebigAni_:Play("Fx_scoretext_idle")
	end

	for iter_26_0, iter_26_1 in pairs(arg_26_0.waterEffectList or {}) do
		if iter_26_1 and iter_26_1.ResetAnimate then
			iter_26_1:ResetAnimate(1)
		end
	end

	if arg_26_0.scoretextAni_ then
		arg_26_0.scoretextAni_:Play("Fx_scoretext_cx", 0, 1)
	end
end

function var_0_0.ChangeTab(arg_27_0, arg_27_1)
	arg_27_0.tabController_:SetSelectedState("state" .. arg_27_1 - 1)
end

function var_0_0.PlayEndEffect(arg_28_0, arg_28_1)
	arg_28_0.textText1_.text = "+" .. arg_28_1 * GameSetting.activity_bubble_left_point.value[1]

	if arg_28_0.scorebigAni_ then
		arg_28_0.scorebigAni_:Play("Fx_scorebig_blow")
	end
end

function var_0_0.OnTop(arg_29_0)
	arg_29_0:ResetAnimate()
	arg_29_0:ChangeBar()

	arg_29_0.isEnded = false
end

function var_0_0.PlayAddWaterEffect(arg_30_0, arg_30_1)
	if arg_30_0.effect then
		arg_30_0.effect.transform.position = arg_30_0.startpositionTrs_.position

		SetActive(arg_30_0.effect, true)
		arg_30_0:RemoveTween()

		arg_30_0.tween_ = LeanTween.move(arg_30_0.effect, arg_30_0.endpositionTrs_.position, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			SetActive(arg_30_0.effect, false)

			if not arg_30_0.isEnded and not arg_30_0.isReset then
				arg_30_0.scorebigAni_:Play("Fx_scorebig_cx", 0, 0)
			end

			arg_30_0.textText_.text = arg_30_1
		end))
	end

	arg_30_0:ChangeBar()
end

function var_0_0.RemoveTween(arg_32_0)
	if arg_32_0.tween_ then
		arg_32_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_32_0.tween_.id)

		arg_32_0.tween_ = nil
	end
end

function var_0_0.OnTask(arg_33_0)
	return
end

function var_0_0.UpdateCombo(arg_34_0, arg_34_1)
	arg_34_0:AddNumAnimator(arg_34_1)
	arg_34_0:CheckNumAnimator()
end

function var_0_0.AddNumAnimator(arg_35_0, arg_35_1)
	table.insert(arg_35_0.animatorNumList, arg_35_1)
end

function var_0_0.CheckNumAnimator(arg_36_0)
	if not arg_36_0.isNumAni then
		local var_36_0 = table.remove(arg_36_0.animatorNumList, 1)

		if var_36_0 then
			arg_36_0.isNumAni = true

			arg_36_0:DoComboAniamtion(var_36_0)
		else
			arg_36_0.isNumAni = false
		end
	end
end

function var_0_0.DoComboAniamtion(arg_37_0, arg_37_1)
	SetActive(arg_37_0.comboattackGo_, true)

	if arg_37_0.comboattackAni_ then
		arg_37_0.comboattackAni_:Play("Fx_comboattack_cx", 0, 0)
	end

	if arg_37_1 ~= 0 then
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_bubble_breakui", "")

		arg_37_0.combotextText_.text = arg_37_1

		local var_37_0 = TimeTools.StartAfterSeconds(0.12, function()
			arg_37_0.isNumAni = false

			arg_37_0:CheckNumAnimator()
		end, {})

		table.insert(arg_37_0.delayTimeList, var_37_0)
	else
		arg_37_0.isNumAni = false

		SetActive(arg_37_0.comboattackGo_, false)
	end
end

function var_0_0.UpdateScore(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = arg_39_3 or 0

	arg_39_0.now = arg_39_0.scoretextText_.text

	if arg_39_2 and tonumber(arg_39_0.now) < arg_39_0.score - 600 then
		if not arg_39_0.timer_ and tonumber(arg_39_0.now) < arg_39_0.score then
			local var_39_1 = math.floor((arg_39_0.score - arg_39_0.now) / 5)

			arg_39_0.timer_ = Timer.New(function()
				arg_39_0.now = math.min(arg_39_0.now + var_39_1, arg_39_0.score)
				arg_39_0.scoretextText_.text = arg_39_0.now

				if arg_39_0.now >= arg_39_0.score then
					arg_39_0:StopTime()
				end

				if arg_39_0.scoretextAni_ and arg_39_0.scoretextAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					arg_39_0.scoretextAni_:Play("Fx_scoretext_cx", 0, 0)
				end
			end, 0.01, -1)

			local var_39_2 = TimeTools.StartAfterSeconds(var_39_0, function()
				if arg_39_0.timer_ then
					arg_39_0.timer_:Start()
				end
			end, {})

			table.insert(arg_39_0.delayTimeList, var_39_2)
		end
	else
		if arg_39_0.scoretextAni_ and arg_39_4 then
			arg_39_0.scoretextAni_:Play("Fx_scoretext_cx", 0, 0)
		end

		arg_39_0.scoretextText_.text = arg_39_1
	end
end

function var_0_0.StopTime(arg_42_0)
	if arg_42_0.timer_ ~= nil then
		arg_42_0.timer_:Stop()

		arg_42_0.timer_ = nil
	end
end

function var_0_0.AddWaterEffect(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	if not arg_43_0.waterDic[arg_43_1] then
		arg_43_0.waterDic[arg_43_1] = {}
	end

	local var_43_0 = arg_43_0.waterDic[arg_43_1][arg_43_2]

	if not var_43_0 then
		local var_43_1 = Object.Instantiate(arg_43_0.waterGo_, arg_43_0.bubleanimatorTrs_)

		item = BlisterScoreItem.New(var_43_1)

		table.insert(arg_43_0.waterEffectList, item)

		arg_43_0.waterDic[arg_43_1][arg_43_2] = #arg_43_0.waterEffectList
		var_43_0 = #arg_43_0.waterEffectList
	end

	item = arg_43_0.waterEffectList[var_43_0]

	item:SetPosition(arg_43_1, arg_43_2, arg_43_3, arg_43_4, function()
		return
	end)
end

function var_0_0.PlayAddEffect(arg_45_0)
	SetActive(arg_45_0.rainAnimGo_, false)
	SetActive(arg_45_0.rainAnimGo_, true)
	manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_bubble_break02", "")
	Timer.New(function()
		SetActive(arg_45_0.rainAnimGo_, false)
	end, 1, 1):Start()
end

function var_0_0.PlayReduceEffect(arg_47_0)
	SetActive(arg_47_0.evaporationAnimGo_, false)
	SetActive(arg_47_0.evaporationAnimGo_, true)
	manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_bubble_break01", "")
	Timer.New(function()
		SetActive(arg_47_0.evaporationAnimGo_, false)
	end, 1, 1):Start()
end

function var_0_0.OnExit(arg_49_0)
	var_0_0.super.OnExit(arg_49_0)
	manager.windowBar:HideBar()

	local var_49_0 = BlisterGameTool.GetSubActiveID(BlisterGameData:GetActivityId())

	BlisterGameData:SavePointIndx(table.indexof(var_49_0, ActivityBubbleCfg[arg_49_0.stageId].activity_id))
	arg_49_0:StopTime()

	for iter_49_0, iter_49_1 in pairs(arg_49_0.delayTimeList) do
		if iter_49_1 and iter_49_1.Stop then
			iter_49_1:Stop()
		end
	end

	arg_49_0.delayTimeList = {}

	arg_49_0:RemoveTween()
end

function var_0_0.Dispose(arg_50_0)
	var_0_0.super.Dispose(arg_50_0)

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.waterEffectList) do
		iter_50_1:Dispose()
	end

	for iter_50_2, iter_50_3 in ipairs(arg_50_0.nodeList) do
		iter_50_3:Dispose()
	end

	arg_50_0.nodeList = {}
	arg_50_0.waterEffectList = {}
end

return var_0_0
