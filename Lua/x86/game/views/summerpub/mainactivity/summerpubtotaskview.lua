local var_0_0 = class("SummerPubToTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_HeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.criMovie_ = arg_3_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criplayer_ = arg_3_0.criMovie_.player

	arg_3_0.criplayer_:SetMaxPictureDataSize(300000)

	arg_3_0.doorOpenCriMovie_ = arg_3_0.doorOpenMovieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.doorOpenCriplayer_ = arg_3_0.doorOpenCriMovie_.player

	arg_3_0.doorOpenCriplayer_:SetMaxPictureDataSize(300000)

	arg_3_0.loopCriMovie_ = arg_3_0.loopMovieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.loopCriplayer_ = arg_3_0.loopCriMovie_.player

	arg_3_0.loopCriplayer_:SetMaxPictureDataSize(300000)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeWritter = arg_4_0.talkText_.transform:GetComponent("UITypewriterEffect")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.roleBtn_, nil, function()
		arg_5_0:PlayCG()
		SetActive(arg_5_0.guideGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.cgBtn_, nil, function()
		if arg_5_0.currentIndex == #arg_5_0.moviePath then
			SetActive(arg_5_0.cgBtnGo_, false)
			arg_5_0:OnPlayEnd()
		else
			SetActive(arg_5_0.cgBtnGo_, false)
			arg_5_0.loopCriplayer_:Loop(false)

			arg_5_0.loopMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

			JumpTools.OpenPageByJump("summerPubToTaskDialogPopView", {
				cfg = SummerPubHeroCfg[arg_5_0.eventId],
				callback = function()
					arg_5_0.currentIndex = arg_5_0.currentIndex + 1

					SetActive(arg_5_0.mainPanelGo_, false)
					arg_5_0:PlayMovie(arg_5_0.currentIndex)
				end
			})
		end
	end)
end

function var_0_0.PlayCG(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0.criMovie_:Stop()

	arg_9_0.moviePath = {}
	arg_9_0.isSetOpenCg = false

	if arg_9_0.cfg.open_cg_id and arg_9_0.cfg.open_cg_id ~= "" then
		SetFile(arg_9_0.criplayer_, nil, "SofdecAsset/activity/" .. arg_9_0.cfg.open_cg_id .. ".usm", CriMana.Player.SetMode.New)

		arg_9_0.isSetOpenCg = true
	end

	if arg_9_0.cfg.taste_cg_id and arg_9_0.cfg.taste_cg_id ~= "" then
		table.insert(arg_9_0.moviePath, "SofdecAsset/activity/" .. arg_9_0.cfg.taste_cg_id .. ".usm")
	end

	if arg_9_0.cfg.sign_cg_id and arg_9_0.cfg.sign_cg_id ~= "" then
		table.insert(arg_9_0.moviePath, "SofdecAsset/activity/" .. arg_9_0.cfg.sign_cg_id .. ".usm")
	end

	arg_9_0.loopCriMovie_:Stop()

	arg_9_0.loopMoviePath = {}

	if arg_9_0.cfg.taste_cg_id_loop and arg_9_0.cfg.taste_cg_id_loop ~= "" then
		table.insert(arg_9_0.loopMoviePath, "SofdecAsset/activity/" .. arg_9_0.cfg.taste_cg_id_loop .. ".usm")
	end

	if arg_9_0.cfg.sign_cg_id_loop and arg_9_0.cfg.sign_cg_id_loop ~= "" then
		table.insert(arg_9_0.loopMoviePath, "SofdecAsset/activity/" .. arg_9_0.cfg.sign_cg_id_loop .. ".usm")
	end

	arg_9_0.doorOpenCriMovie_:Stop()

	arg_9_0.doorOpenMoviePath = {}

	if #arg_9_0.moviePath == 0 then
		SummerPubAction.FinishCook(arg_9_0.cookDishId, SummerPubConst.COOK_STATE.VIEW_CG)
	end

	arg_9_0.movieGo_.transform.localPosition = Vector3(0, 0, 0)
	arg_9_0.currentIndex = 1

	arg_9_0:PlayMovie(arg_9_0.currentIndex)
end

function var_0_0.OnPlayEnd(arg_10_0)
	SummerPubAction.FinishCook(arg_10_0.cookDishId, SummerPubConst.COOK_STATE.VIEW_CG, function()
		arg_10_0.criMovie_:Stop()

		arg_10_0.movieGo_.transform.localPosition = Vector3(9999, 9999, 0)
	end)
end

function var_0_0.PlayMovie(arg_12_0, arg_12_1)
	if not arg_12_0.criplayer_ then
		Debug.LogError("品菜CG CriWare player not initialized")

		return
	end

	if not arg_12_0.loopCriplayer_ then
		Debug.LogError("品菜CG CriWare player not initialized")

		return
	end

	SetActive(arg_12_0.cgBtnGo_, false)

	local var_12_0 = arg_12_0.moviePath[arg_12_1]

	if arg_12_0.isSetOpenCg then
		SetFile(arg_12_0.criplayer_, nil, var_12_0, CriMana.Player.SetMode.Append)
	else
		SetFile(arg_12_0.criplayer_, nil, var_12_0, CriMana.Player.SetMode.New)
	end

	arg_12_0.loopCriplayer_:Stop()

	local var_12_1 = arg_12_0.loopMoviePath[arg_12_1]

	SetFile(arg_12_0.loopCriplayer_, nil, var_12_1, CriMana.Player.SetMode.New)
	arg_12_0.loopCriplayer_:Prepare()
	arg_12_0.loopCriplayer_:Loop(true)
	arg_12_0.loopCriplayer_:SetVolume(manager.audio:GetEffectVolume())
	arg_12_0.criplayer_:Start()
	arg_12_0.criplayer_:SetVolume(manager.audio:GetEffectVolume())

	local var_12_2

	if arg_12_1 == 1 then
		SDKTools.SendMessageToSDK("activity_illustration", {
			illustration_type = 1,
			type = 1,
			activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
			food_id = arg_12_0.cookDishId,
			button_name = arg_12_0.cfg.taste_cg_id
		})
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.movieGo_.transform.localPosition = Vector3(9999, 9999, 0)

	SetActive(arg_13_0.guideGo_, false)

	arg_13_0.cookDishId = arg_13_0.params_.cookDishId
	arg_13_0.cfg = SummerPubCookCfg[arg_13_0.cookDishId]
	arg_13_0.eventId = arg_13_0.cfg.hero_id
	arg_13_0.talk = SummerPubHeroCfg[arg_13_0.eventId].food_text
	arg_13_0.talkText_.text = arg_13_0.talk or ""

	arg_13_0:SetCriStatusCallBack()
end

function var_0_0.SetCriStatusCallBack(arg_14_0)
	function arg_14_0.criplayer_.statusChangeCallback(arg_15_0)
		local var_15_0 = tostring(arg_15_0)

		if var_15_0 == "PlayEnd" then
			arg_14_0.loopCriplayer_:Start()

			arg_14_0.loopMovieGo_.transform.localPosition = Vector3(0, 0, 0)

			SetActive(arg_14_0.cgBtnGo_, true)
		elseif var_15_0 == "Stop" then
			arg_14_0.criMovie_:Stop()
		elseif var_15_0 == "Error" then
			arg_14_0.criMovie_:Stop()
		end
	end

	function arg_14_0.loopCriplayer_.statusChangeCallback(arg_16_0)
		local var_16_0 = tostring(arg_16_0)

		if var_16_0 == "PlayEnd" then
			arg_14_0.loopCriplayer_:Stop()
		elseif var_16_0 == "Stop" then
			arg_14_0.loopCriplayer_:Stop()
		elseif var_16_0 == "Error" then
			arg_14_0.loopCriplayer_:Stop()
		end
	end

	function arg_14_0.doorOpenCriplayer_.statusChangeCallback(arg_17_0)
		local var_17_0 = tostring(arg_17_0)

		if var_17_0 == "PlayEnd" then
			arg_14_0:StopTimer()

			arg_14_0.openTimer_ = Timer.New(function()
				arg_14_0:UpdateText()

				arg_14_0.doorOpenMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

				arg_14_0.timer:Start()
			end, 0.66, 1)

			arg_14_0.openTimer_:Start()

			arg_14_0.timer = Timer.New(function()
				arg_14_0:StopTimer()
				SetActive(arg_14_0.guideGo_, true)
			end, 4, 1)

			arg_14_0.timer:Start()
			arg_14_0.doorOpenCriplayer_:Stop()
		elseif var_17_0 == "Playing" then
			SummerPubTool:LoadScene(arg_14_0.eventId, SetActive(arg_14_0.mainPanelGo_, true))
		elseif var_17_0 == "Stop" then
			arg_14_0.doorOpenMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

			arg_14_0.doorOpenCriMovie_:Stop()
		elseif var_17_0 == "Error" then
			arg_14_0.doorOpenMovieGo_.transform.localPosition = Vector3(9999, 9999, 0)

			arg_14_0.doorOpenCriMovie_:Stop()
		end
	end
end

function var_0_0.OnEnterOver(arg_20_0)
	if arg_20_0.cookDishId == SummerPubConst.COOK_FIRST_STAGE then
		manager.windowBar:HideBar()
		SummerPubTool:LoadScene(arg_20_0.eventId, function()
			SetActive(arg_20_0.mainPanelGo_, true)
		end)
		arg_20_0:UpdateText()

		arg_20_0.guideTimer_ = Timer.New(function()
			arg_20_0:StopTimer()
			SetActive(arg_20_0.guideGo_, true)
		end, 4, 1)

		arg_20_0.guideTimer_:Start()
	else
		local var_20_0 = "SofdecAsset/activity/activity_4_3_00_door.usm"

		SetFile(arg_20_0.doorOpenCriplayer_, nil, var_20_0, CriMana.Player.SetMode.New)
		arg_20_0.doorOpenCriplayer_:Prepare()
		FrameTimer.New(function()
			arg_20_0:PlayDoorOpenMovie()
		end, 1, 1):Start()
	end
end

function var_0_0.PlayDoorOpenMovie(arg_24_0)
	manager.windowBar:HideBar()

	arg_24_0.doorOpenMovieGo_.transform.localPosition = Vector3(0, 0, 0)

	arg_24_0.doorOpenCriMovie_:Play()
	arg_24_0.doorOpenCriplayer_:SetVolume(manager.audio:GetEffectVolume())
end

function var_0_0.StopTimer(arg_25_0)
	if arg_25_0.timer then
		arg_25_0.timer:Stop()

		arg_25_0.timer = nil
	end

	if arg_25_0.openTimer_ then
		arg_25_0.openTimer_:Stop()

		arg_25_0.openTimer_ = nil
	end

	if arg_25_0.guideTimer_ then
		arg_25_0.guideTimer_:Stop()

		arg_25_0.guideTimer_ = nil
	end
end

function var_0_0.UpdateBar(arg_26_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		local var_27_0, var_27_1 = ChapterResidentTools.GetResidentMainActTime(ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
		local var_27_2 = manager.time:GetServerTime()

		if var_27_0 and var_27_1 and var_27_1 <= var_27_2 then
			JumpTools.GoToSystem("/chapterMap", {
				chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
				activityID = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
			})
		else
			ActivityTools.JumpBackToActivityMainViewByActivityID(ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
		end
	end)
end

function var_0_0.UpdateText(arg_28_0)
	local var_28_0 = GameSetting.nya_summer_taste_typespeed.value[1] or 20
	local var_28_1 = utf8len(arg_28_0.talk) / var_28_0
	local var_28_2 = 0
	local var_28_3 = 0

	arg_28_0.timer = Timer.New(function()
		var_28_2 = var_28_2 + 0.01
		var_28_3 = Mathf.Lerp(0, 1, var_28_2 / var_28_1)

		if arg_28_0.typeWritter.percent < var_28_3 then
			arg_28_0.typeWritter.percent = var_28_3

			arg_28_0.typeWritter:SetDirty()
		end

		if var_28_2 >= var_28_1 and arg_28_0.timer then
			arg_28_0.timer:Stop()

			arg_28_0.timer = nil
		end
	end, 0.01, -1)

	arg_28_0.timer:Start()
end

function var_0_0.OnExit(arg_30_0)
	arg_30_0:StopTimer()
	arg_30_0.super.OnExit(arg_30_0)

	arg_30_0.typeWritter.percent = 0

	if arg_30_0.criplayer_ then
		arg_30_0.criplayer_.statusChangeCallback = nil
	end

	if arg_30_0.criMovie_ then
		arg_30_0.criMovie_:Stop()
	end

	if arg_30_0.doorOpenCriplayer_ then
		arg_30_0.doorOpenCriplayer_.statusChangeCallback = nil
	end

	if arg_30_0.doorOpenCriMovie_ then
		arg_30_0.doorOpenCriMovie_:Stop()
	end

	if arg_30_0.timer then
		arg_30_0.timer:Stop()

		arg_30_0.timer = nil
	end

	SummerPubTool:OnLogout()
end

function var_0_0.Dispose(arg_31_0)
	if arg_31_0.criplayer_ then
		arg_31_0.criplayer_:Dispose()

		arg_31_0.criplayer_ = nil
	end

	if arg_31_0.doorOpenCriplayer_ then
		arg_31_0.doorOpenCriplayer_:Dispose()

		arg_31_0.doorOpenCriplayer_ = nil
	end

	if arg_31_0.loopCriplayer_ then
		arg_31_0.loopCriplayer_:Dispose()

		arg_31_0.loopCriplayer_ = nil
	end

	var_0_0.super.Dispose(arg_31_0)
end

return var_0_0
