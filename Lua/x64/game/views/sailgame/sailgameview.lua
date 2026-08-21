local var_0_0 = class("SailBuildingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.coinIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
	arg_4_0.animTimerList_ = {}
	arg_4_0.maxTime_ = GameSetting.activity_skadi_sea_total_time.value[1]
	arg_4_0.pauseHandler_ = handler(arg_4_0, arg_4_0.OnPause)
	arg_4_0.triggerEventHandler_ = handler(arg_4_0, arg_4_0.OnTriggerEvent)
	arg_4_0.triggerTipsHandler_ = handler(arg_4_0, arg_4_0.OnTriggerTips)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activityID_ = arg_5_0.params_.activityID

	if isNil(SailGameManager.Instance) then
		SailGameTools.GoToGameView(arg_5_0.activityID_)
	end

	manager.ui:SetMainCamera("sailGame")

	manager.ui.mainCameraCom_.orthographic = true

	arg_5_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_5_0, arg_5_0.OnActivityUpdate))
end

function var_0_0.OnTop(arg_6_0)
	SetActive(arg_6_0.eventTriggerGo_, false)
	SetActive(arg_6_0.tipsGo_, false)
	SetActive(arg_6_0.coinVaryGo_, false)
	arg_6_0:GameStart()

	arg_6_0.curGameData_ = SailGameData:GetCurGameData(arg_6_0.activityID_)

	arg_6_0:UpdateBar()

	local var_6_0 = SailGameData:GetEventEndMark(arg_6_0.activityID_)

	if var_6_0.isEnd == true then
		arg_6_0:OnEventEnd(var_6_0)
	end
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	arg_7_0:StopAllAnimTimer()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	arg_7_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.backBtn_, nil, function()
		SailGameManager.Instance:SetGamePause(true)

		local var_9_0 = arg_8_0.activityID_

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKADI_SEA_BE_OUT_EXIT"),
			OkCallback = function()
				SailGameAction.GiveUp(var_9_0)
			end,
			CancelCallback = function()
				SailGameManager.Instance:SetGamePause(false)
			end,
			MaskCallback = function()
				SailGameManager.Instance:SetGamePause(false)
			end
		})
	end)
end

function var_0_0.UpdateBar(arg_13_0)
	arg_13_0.coinNumText_.text = SailGameData:GetTempCurrency(arg_13_0.activityID_).lastNum
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.tween_ then
		arg_14_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_14_0.tween_.id)

		arg_14_0.tween_ = nil
	end

	arg_14_0:StopAllAnimTimer()
	SailGameTools.ShutDown()

	arg_14_0.pauseHandler_ = nil
	arg_14_0.triggerEventHandler_ = nil
	arg_14_0.triggerTipsHandler_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.InitGame(arg_15_0)
	SailGameManager.Instance:SetGamePauseHandler(arg_15_0.pauseHandler_)
	SailGameManager.Instance:SetTriggerEventHandler(arg_15_0.triggerEventHandler_)
	SailGameManager.Instance:SetTriggerTipsHandler(arg_15_0.triggerTipsHandler_)
end

function var_0_0.GameStart(arg_16_0)
	if not SailGameManager.Instance:IsRunning() then
		arg_16_0:InitGame()
		SailGameManager.Instance:GameStart()
	else
		SailGameManager.Instance:SetGamePause(false)
	end

	arg_16_0:RecoverAnim()
end

function var_0_0.GoToEventView(arg_17_0)
	local var_17_0 = arg_17_0.curGameData_.curStageIndex
	local var_17_1 = arg_17_0.curGameData_.eventList[var_17_0].id
	local var_17_2 = 0

	if SailGameEventCfg[var_17_1] then
		var_17_2 = SailGameEventCfg[var_17_1].type
	else
		var_17_2 = 0
	end

	local var_17_3 = SailGameConst.EVENT_VIEW_ROUTE[var_17_2]

	JumpTools.OpenPageByJump(var_17_3, {
		activityID = arg_17_0.activityID_,
		stageIndex = var_17_0,
		eventID = var_17_1
	})
end

function var_0_0.OnPause(arg_18_0, arg_18_1)
	if arg_18_1 == true then
		arg_18_0:PauseAnim()
	else
		arg_18_0:RecoverAnim()
	end
end

function var_0_0.OnTriggerTips(arg_19_0, arg_19_1)
	if SailGameConst.GAME_TIME_TIPS[arg_19_1] then
		arg_19_0.gameTipsText_.text = GetTips(SailGameConst.GAME_TIME_TIPS[arg_19_1])

		arg_19_0:PlayTipsAnim()
	end
end

function var_0_0.OnTriggerEvent(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.curGameData_.curStageIndex
	local var_20_1 = var_20_0 == #arg_20_0.curGameData_.eventList and 0 or arg_20_0.curGameData_.eventList[var_20_0].id

	arg_20_0:PlayEventAnim(var_20_1, function()
		arg_20_0:GoToEventView()
	end)
end

function var_0_0.OnEventEnd(arg_22_0, arg_22_1)
	arg_22_0:UpdateCurrency()

	local var_22_0 = arg_22_1.tipsIndex

	if var_22_0 then
		local var_22_1 = arg_22_1.stageIndex
		local var_22_2 = arg_22_0.curGameData_.eventList[var_22_1].id

		arg_22_0.gameTipsText_.text = SailGameEventCfg[var_22_2].tip[var_22_0]

		arg_22_0:PlayTipsAnim()
	end
end

function var_0_0.UpdateCurrency(arg_23_0)
	local var_23_0 = SailGameData:GetTempCurrency(arg_23_0.activityID_)
	local var_23_1 = var_23_0.lastNum
	local var_23_2 = var_23_0.curNum - var_23_1

	if var_23_2 > 0 then
		arg_23_0.coinVaryText_.text = "+" .. var_23_2

		SetActive(arg_23_0.coinVaryGo_, true)

		arg_23_0.coinAnim_.enabled = true

		arg_23_0:PlayAnim("XH3rdVoyagesGameUI_text", arg_23_0.coinAnim_, function()
			SetActive(arg_23_0.coinVaryGo_, false)
			arg_23_0:PlayCurrencyRollAnim()
			arg_23_0:PlayAnim("XH3rdVoyagesGameUI_coin", arg_23_0.coinAnim_, function()
				arg_23_0.coinAnim_.enabled = false
			end)
		end)
	end
end

function var_0_0.PlayCurrencyRollAnim(arg_26_0)
	local var_26_0 = SailGameData:GetTempCurrency(arg_26_0.activityID_)
	local var_26_1 = var_26_0.lastNum
	local var_26_2 = var_26_0.curNum

	if arg_26_0.tween_ then
		arg_26_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_26_0.tween_.id)

		arg_26_0.tween_ = nil
	end

	arg_26_0.tween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
		local var_27_0 = var_26_1 or 0
		local var_27_1 = var_26_2
		local var_27_2 = math.floor(var_27_0 + (var_27_1 - var_27_0) * arg_27_0)

		arg_26_0.coinNumText_.text = tostring(var_27_2)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if arg_26_0.tween_ then
			arg_26_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			arg_26_0.tween_ = nil
		end

		arg_26_0.coinNumText_.text = var_26_2
	end)):setEase(LeanTweenType.easeOutQuad)
end

function var_0_0.PlayEventAnim(arg_29_0, arg_29_1, arg_29_2)
	SetActive(arg_29_0.eventTriggerGo_, true)
	SetActive(arg_29_0.tipsGo_, false)

	arg_29_0.tipsAnim_.enabled = false

	if arg_29_1 ~= 0 then
		arg_29_0.eventRoleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. SailGameEventCfg[arg_29_1].picture)
	else
		local var_29_0 = GameDisplayCfg.activity_skadi_sea_box_picture.value[1]
		local var_29_1 = GameDisplayCfg.activity_skadi_sea_box_picture.value[2]

		arg_29_0.eventRoleImg_.sprite = getSprite(var_29_0, var_29_1)
	end

	arg_29_0.eventRoleImg_:SetNativeSize()

	local var_29_2 = "XH3rdVoyagesUI_role"

	arg_29_0:PlayAnim(var_29_2, arg_29_0.eventAnim_, arg_29_2)
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_pop1", "")
end

function var_0_0.PlayTipsAnim(arg_30_0)
	SetActive(arg_30_0.tipsGo_, true)

	arg_30_0.tipsAnim_.enabled = true

	local var_30_0 = "XH3rdVoyagesUI_pop"

	arg_30_0:PlayAnim(var_30_0, arg_30_0.tipsAnim_, function()
		SetActive(arg_30_0.tipsGo_, false)

		arg_30_0.tipsAnim_.enabled = false
	end)
end

function var_0_0.PlayAnim(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_2 then
		return
	end

	arg_32_2:Play(arg_32_1, -1, 0)
	arg_32_2:Update(0)
	arg_32_0:StopAnimTimer(arg_32_1)

	arg_32_0.animTimerList_[arg_32_1] = Timer.New(function()
		local var_33_0 = arg_32_2:GetCurrentAnimatorStateInfo(0)

		if var_33_0:IsName(arg_32_1) and var_33_0.normalizedTime >= 1 then
			arg_32_0:StopAnimTimer(arg_32_1)

			if arg_32_3 then
				arg_32_3()

				arg_32_3 = nil
			end
		end
	end, 0.033, -1)

	arg_32_0.animTimerList_[arg_32_1]:Start()
end

function var_0_0.PauseAnim(arg_34_0)
	arg_34_0.tipsAnim_.speed = 0
	arg_34_0.coinAnim_.speed = 0

	if arg_34_0.tween_ then
		LeanTween.pause(arg_34_0.tween_.id)
	end
end

function var_0_0.RecoverAnim(arg_35_0)
	arg_35_0.tipsAnim_.speed = 1
	arg_35_0.coinAnim_.speed = 1

	if arg_35_0.tween_ then
		LeanTween.resume(arg_35_0.tween_.id)
	end
end

function var_0_0.StopAllAnimTimer(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.animTimerList_) do
		arg_36_0.animTimerList_[iter_36_0]:Stop()

		arg_36_0.animTimerList_[iter_36_0] = nil
	end
end

function var_0_0.StopAnimTimer(arg_37_0, arg_37_1)
	if arg_37_0.animTimerList_[arg_37_1] then
		arg_37_0.animTimerList_[arg_37_1]:Stop()

		arg_37_0.animTimerList_[arg_37_1] = nil
	end
end

function var_0_0.OnActivityUpdate(arg_38_0, arg_38_1)
	if arg_38_1 == arg_38_0.activityID_ and not ActivityData:GetActivityIsOpen(arg_38_1) then
		ShowTips("TIME_OVER")
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = arg_38_0.activityID_
		})
	end
end

return var_0_0
