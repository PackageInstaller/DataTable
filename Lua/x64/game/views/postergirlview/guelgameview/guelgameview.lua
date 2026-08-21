local var_0_0 = class("GuelGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main_T0SceneGame/102003/102003_Match3GameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.tilePool = {}
	arg_3_0.tileList = {}
	arg_3_0.tween = {}
	arg_3_0.curTimeline = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.countDownController = arg_4_0.match3gameuiControllerexcollection_:GetController("countDown")
	arg_4_0.mockingController = arg_4_0.match3gameuiControllerexcollection_:GetController("mocking")
	arg_4_0.skillController = arg_4_0.match3gameuiControllerexcollection_:GetController("ultimateSkill")
	arg_4_0.resultController = arg_4_0.match3gameuiControllerexcollection_:GetController("result")
	arg_4_0.selfRoleController = arg_4_0.match3gameuiControllerexcollection_:GetController("selfRole")
	arg_4_0.enemyTauntSpine = arg_4_0.spineTauntGo_.transform:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.selfSkillIconController = arg_4_0.selfSkillController_:GetController("skill")
	arg_4_0.selfSkillStateController = arg_4_0.selfSkillController_:GetController("state")
	arg_4_0.enemySkillIconController = arg_4_0.enemySkillController_:GetController("skill")
	arg_4_0.enemySkillStateController = arg_4_0.enemySkillController_:GetController("state")
	arg_4_0.enterAniControlller = arg_4_0.match3gameuiControllerexcollection_:GetController("fullScreen")
	arg_4_0.cutsceneSubView = TZeroGameChangeView.BaseView.New(arg_4_0.cutsceneSubView_)

	arg_4_0:AddListeners()
end

function var_0_0.InitSpine(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_1.AnimationState:ClearTracks()
		arg_5_1:Initialize(true)
		arg_5_1:Update(0)
	end
end

function var_0_0.ResetSpine(arg_6_0)
	arg_6_0:InitSpine(arg_6_0.selfSpineFx)
	arg_6_0:InitSpine(arg_6_0.enemySpineFx)
end

function var_0_0.SetSpineParent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		"spine1Go_",
		"spine2Go_"
	}
	local var_7_1 = {
		"fxSpine1Go_",
		"fxSpine2Go_"
	}
	local var_7_2 = {
		"rolepos1Go_",
		"rolepos2Go_"
	}
	local var_7_3 = {
		"fxPos1Go_",
		"fxPos2Go_"
	}
	local var_7_4 = var_7_0[arg_7_1] and var_7_0[arg_7_1] or var_7_0[1]
	local var_7_5 = var_7_1[arg_7_1] and var_7_1[arg_7_1] or var_7_1[1]
	local var_7_6 = var_7_2[arg_7_2] and var_7_2[arg_7_2] or var_7_2[1]
	local var_7_7 = var_7_3[arg_7_2] and var_7_3[arg_7_2] or var_7_3[1]

	arg_7_0[var_7_4].transform:SetParent(arg_7_0[var_7_6].transform)

	arg_7_0[var_7_4].transform.localPosition = Vector3(0, 0, 0)
	arg_7_0[var_7_4].transform.localScale = Vector3(arg_7_2 == 1 and 1 or -1, 1, 1)

	arg_7_0[var_7_5].transform:SetParent(arg_7_0[var_7_7].transform)

	arg_7_0[var_7_5].transform.localPosition = Vector3(0, 0, 0)
	arg_7_0[var_7_5].transform.localScale = Vector3(arg_7_2 == 1 and 1 or -1, 1, 1)

	if arg_7_2 == 1 then
		arg_7_0.selfSpine = arg_7_0[var_7_4].transform:GetComponent("Spine.Unity.SkeletonGraphic")
		arg_7_0.selfSpineFx = arg_7_0[var_7_5].transform:GetComponent("Spine.Unity.SkeletonGraphic")

		arg_7_0:InitSpine(arg_7_0.selfSpineFx)

		arg_7_0.selfHitAni = arg_7_0[var_7_4].transform:GetComponent("Animator")

		if var_7_4 == "spine1Go_" then
			arg_7_0.selfSpineName = "kali_"
			arg_7_0.enemySpineName = "parvati_"
			arg_7_0.selfRoleName_.text = HeroCfg[1056].suffix
			arg_7_0.enemyRoleName_.text = HeroCfg[1089].suffix

			arg_7_0.selfRoleController:SetSelectedState("kali")
			arg_7_0.selfSkillIconController:SetSelectedState("1156")
			arg_7_0.enemySkillIconController:SetSelectedState("1089")
		else
			arg_7_0.selfSpineName = "parvati_"
			arg_7_0.enemySpineName = "kali_"
			arg_7_0.selfRoleName_.text = HeroCfg[1089].suffix
			arg_7_0.enemyRoleName_.text = HeroCfg[1056].suffix

			arg_7_0.selfRoleController:SetSelectedState("parvati")
			arg_7_0.selfSkillIconController:SetSelectedState("1089")
			arg_7_0.enemySkillIconController:SetSelectedState("1156")
		end
	else
		arg_7_0.enemySpine = arg_7_0[var_7_4].transform:GetComponent("Spine.Unity.SkeletonGraphic")
		arg_7_0.enemySpineFx = arg_7_0[var_7_5].transform:GetComponent("Spine.Unity.SkeletonGraphic")

		arg_7_0:InitSpine(arg_7_0.enemySpineFx)

		arg_7_0.enemyHitAni = arg_7_0[var_7_4].transform:GetComponent("Animator")
	end
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.skillBtn1_, nil, function()
		if arg_8_0.gameManager.canClickSkill and arg_8_0.gameManager.gameData.globalState == GueGameConst.GameState.playing and arg_8_0.gameManager.gameData.playerState == GueGameConst.GameState.playing then
			arg_8_0.gameManager:DOSkill(1)
		end
	end)
end

function var_0_0.ChangeBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_10_0.gameManager:PauseGame(true)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_BLOOD_CARD_GAME_GIVE_UP_CONFIRMATION"),
			OkCallback = function()
				GuelGameManager.GetInstance():RecordLog(GuelGameManager.GameResult.Canceled)
				GuelGameAcion.ExitGame()
				manager.posterGirl:SetStateCanChange(true)
				JumpTools.Back(2)
			end,
			CancelCallback = function()
				arg_10_0.gameManager:PauseGame(false)
			end
		})
	end)
	manager.windowBar:RegistInfoCallBack(function()
		arg_10_0.gameManager:PauseGame(true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = GameSetting.brahma_t0_desc3.value,
			exitCallback = function()
				arg_10_0.gameManager:PauseGame(false)
			end
		})
	end)
end

function var_0_0.ShowReult(arg_16_0, arg_16_1)
	local var_16_0 = {
		"win",
		"lose",
		"none"
	}

	if arg_16_1 == 1 then
		arg_16_0:ShowAnimation(true, 7)
		arg_16_0:ShowAnimation(false, 6)
	elseif arg_16_1 == 2 then
		arg_16_0:ShowAnimation(true, 6)
		arg_16_0:ShowAnimation(false, 7)
	end

	arg_16_0.resultController:SetSelectedState(var_16_0[arg_16_1] or "none")
end

function var_0_0.OnTop(arg_17_0)
	arg_17_0:ChangeBar()
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:StopPlayable()
	arg_18_0:StopTime()

	arg_18_0.chooseIndex = arg_18_0.params_.chooseIndex or 1

	arg_18_0:SetSpineParent(1, arg_18_0.chooseIndex)
	arg_18_0:SetSpineParent(2, arg_18_0.chooseIndex == 1 and 2 or 1)

	arg_18_0.gameManager = GuelGameManager.GetInstance()

	arg_18_0.gameManager:InitData(arg_18_0, arg_18_0.chooseIndex)

	arg_18_0.effectNum = 0

	arg_18_0:StartIdle()
	arg_18_0:ShowReult(3)
	arg_18_0.gameManager:UpdateTime()
	arg_18_0.gameManager:UpdateBattleInfo()

	arg_18_0.timer = Timer.New(function()
		if manager.guide:IsPlaying() then
			return
		end

		if arg_18_0.gameManager.gameData.globalState == GueGameConst.GameState.pause then
			return
		end

		arg_18_0:StartEffect()

		arg_18_0.gameManager.gameData.startingAni = true

		if arg_18_0.timer then
			arg_18_0.timer:Stop()

			arg_18_0.timer = nil
		end
	end, 1, -1)

	arg_18_0.timer:Start()

	arg_18_0.startTimer = Timer.New(function()
		if manager.guide:IsPlaying() then
			return
		end

		if arg_18_0.gameManager.gameData.globalState == GueGameConst.GameState.pause then
			return
		end

		arg_18_0.gameManager.gameData.startingAni = false

		arg_18_0.gameManager:StartGame()

		if arg_18_0.startTimer then
			arg_18_0.startTimer:Stop()

			arg_18_0.startTimer = nil
		end
	end, 4, -1)

	arg_18_0.startTimer:Start()
	arg_18_0.enterAniControlller:SetSelectedState("false")

	function arg_18_0.cutsceneSubView.onScreenFullyBlockedCallback()
		arg_18_0.enterAniControlller:SetSelectedState("false")
	end

	function arg_18_0.cutsceneSubView.onFinishCallback()
		arg_18_0:ChangeBar()
		arg_18_0.cutsceneSubView.gameObject_:SetActive(false)
	end

	arg_18_0.destoryTimerList = {}
end

function var_0_0.StopTime(arg_23_0)
	if arg_23_0.timer then
		arg_23_0.timer:Stop()

		arg_23_0.timer = nil
	end

	if arg_23_0.startTimer then
		arg_23_0.startTimer:Stop()

		arg_23_0.startTimer = nil
	end

	if arg_23_0.destoryTimerList then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.destoryTimerList) do
			if iter_23_1 then
				iter_23_1:Stop()

				iter_23_1 = nil
			end
		end

		arg_23_0.destoryTimerList = {}
	end
end

function var_0_0.PauseTimer(arg_24_0, arg_24_1)
	if arg_24_0.countDownAni_ then
		arg_24_0.countDownAni_.speed = arg_24_1 and 0 or 1
	end

	if arg_24_0.selfHitAni then
		arg_24_0.selfHitAni.speed = arg_24_1 and 0 or 1
	end

	if arg_24_0.enemyHitAni then
		arg_24_0.enemyHitAni.speed = arg_24_1 and 0 or 1
	end

	if arg_24_0.selfUltimateAni_ then
		arg_24_0.selfUltimateAni_.speed = arg_24_1 and 0 or 1
	end

	if arg_24_0.enemyUltimateAni_ then
		arg_24_0.enemyUltimateAni_.speed = arg_24_1 and 0 or 1
	end

	if arg_24_0.startTimer then
		arg_24_0.startTimer.running = not arg_24_1
	end

	if arg_24_0.selfTimer_ then
		arg_24_0.selfTimer_.running = not arg_24_1
	end

	if arg_24_0.enemyTimer_ then
		arg_24_0.enemyTimer_.running = not arg_24_1
	end

	if arg_24_0.time then
		arg_24_0.time.running = not arg_24_1
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.destoryTimerList) do
		if iter_24_1 then
			iter_24_1.running = not arg_24_1
		end
	end

	if arg_24_0.selfSpine then
		arg_24_0.selfSpine.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if arg_24_0.enemySpine then
		arg_24_0.enemySpine.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if arg_24_0.enemyTauntSpine then
		arg_24_0.enemyTauntSpine.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if arg_24_0.enemyTauntSpine then
		arg_24_0.selfSpineFx.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if arg_24_0.enemyTauntSpine then
		arg_24_0.enemySpineFx.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end
end

function var_0_0.StartEffect(arg_25_0)
	arg_25_0.countDownAni_:Play("default", -1, 0)

	arg_25_0.countDownAni_.speed = 1

	arg_25_0.countDownAni_:Update(0)
	manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_start", "")
	SetActive(arg_25_0.spineTauntGo_, false)
end

function var_0_0.OnExit(arg_26_0)
	var_0_0.super.OnExit(arg_26_0)

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.tileList[1]) do
		if iter_26_1 then
			iter_26_1:Dispose()
			arg_26_0:DestroyTileObj(iter_26_1.gameObject_, true)
		end
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.tileList[2]) do
		if iter_26_3 then
			iter_26_3:Dispose()
			arg_26_0:DestroyTileObj(iter_26_3.gameObject_, true)
		end
	end

	arg_26_0.tileList[2] = {}
	arg_26_0.tileList[1] = {}

	arg_26_0:StopTime()
	arg_26_0:StopIdleTimer()
	arg_26_0:StopPlayable()
	arg_26_0.gameManager:PauseGame(false, true)
	arg_26_0.cutsceneSubView:OnExit()
	arg_26_0.gameManager:Dispose()
	arg_26_0:StopAnimator()
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
end

function var_0_0.CreateOrGetTileItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = #arg_27_0.tilePool > 0 and table.remove(arg_27_0.tilePool) or GameObject.Instantiate(arg_27_0.coloritemGo_1, arg_27_1.transform)

	SetActive(var_27_0, true)
	var_27_0.transform:SetParent(arg_27_1.transform)

	var_27_0.transform.localScale = Vector3.New(1, 1, 1)

	return var_27_0
end

function var_0_0.StopAnimator(arg_28_0)
	arg_28_0.selfHitAni:Play("spine_hit_normal", -1, 0)
	arg_28_0.enemyHitAni:Play("spine_hit_normal", -1, 0)
	SetActive(arg_28_0.selfUltimateAni_, true)
	SetActive(arg_28_0.enemyUltimateAni_, true)
	arg_28_0.selfUltimateAni_:Play("ultimateSkill00", -1, 0)
	arg_28_0.selfUltimateAni_:Update(0)
	arg_28_0.enemyUltimateAni_:Play("ultimateSkill00", -1, 0)
	arg_28_0.enemyUltimateAni_:Update(0)
	SetActive(arg_28_0.selfUltimateAni_, false)
	SetActive(arg_28_0.enemyUltimateAni_, false)
end

function var_0_0.ProcessTileList(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if not arg_29_0.tileList[arg_29_2] then
		arg_29_0.tileList[arg_29_2] = {}
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0 = arg_29_0.tileList[arg_29_2][iter_29_1.index] or GuelGameTileItem.New(arg_29_0:CreateOrGetTileItem(arg_29_3, iter_29_1.index))

		var_29_0:SetData(iter_29_1)

		var_29_0.gameObject_.name = "item" .. iter_29_1.index
		iter_29_1.canclick = arg_29_2 == 1

		var_29_0:SetPosition((iter_29_1.index - 1) * 130)

		arg_29_0.tileList[arg_29_2][iter_29_1.index] = var_29_0
	end
end

function var_0_0.ShowTileList(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:ProcessTileList(arg_30_1, 1, arg_30_0.coloritemgroup1Go_)
	arg_30_0:ProcessTileList(arg_30_2, 2, arg_30_0.coloritemgroup2Go_)
end

function var_0_0.ShowHitAni(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1 and arg_31_0.selfHitAni or arg_31_0.enemyHitAni
	local var_31_1 = "spine_hit"

	if not var_31_0:GetCurrentAnimatorStateInfo(0):IsName(var_31_1) then
		var_31_0:Play(var_31_1, 0, 0)
	end
end

function var_0_0.ShowTileListWithAnimation(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {
		{
			listIndex = 1,
			dataList = arg_32_1,
			parent = arg_32_0.coloritemgroup1Go_
		},
		{
			listIndex = 2,
			dataList = arg_32_2,
			parent = arg_32_0.coloritemgroup2Go_
		}
	}
	local var_32_1 = 12

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		-- block empty
	end

	local var_32_2 = var_32_0[arg_32_3 or 1]
	local var_32_3 = arg_32_0.tileList[var_32_2.listIndex] and #arg_32_0.tileList[var_32_2.listIndex] or 0
	local var_32_4 = arg_32_0.tileList[var_32_2.listIndex][var_32_3]:GetPositionX()

	for iter_32_2, iter_32_3 in ipairs(var_32_2.dataList) do
		if not arg_32_0.tileList[var_32_2.listIndex] then
			arg_32_0.tileList[var_32_2.listIndex] = {}
		end

		local var_32_5 = arg_32_0.tileList[var_32_2.listIndex][iter_32_3.index]

		if not var_32_5 then
			local var_32_6 = arg_32_0:CreateOrGetTileItem(var_32_2.parent)

			var_32_6.transform:SetSiblingIndex(iter_32_3.index - 1)

			var_32_5 = GuelGameTileItem.New(var_32_6)

			var_32_5:SetPosition(var_32_4 + 116 * (iter_32_3.index - var_32_3))
		end

		var_32_5:SetData(iter_32_3)

		var_32_5.gameObject_.name = "item" .. iter_32_3.index
		iter_32_3.canclick = var_32_2.listIndex == 1

		local var_32_7 = (iter_32_3.index - 1) * 130
		local var_32_8 = var_32_5:GetPositionX()
		local var_32_9 = LeanTween.value(var_32_8, var_32_7, 0.3)

		var_32_9:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
			var_32_5:SetPosition(arg_33_0, 0)
		end)):setOnComplete(LuaHelper.VoidAction(function()
			if var_32_9 then
				var_32_9:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
				LeanTween.cancel(var_32_9.id)
			end
		end)):setEase(LeanTweenType.easeOutQuad)
		table.insert(arg_32_0.tween, var_32_9)

		arg_32_0.tileList[var_32_2.listIndex][iter_32_3.index] = var_32_5
	end
end

function var_0_0.DestroyTile(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1 and arg_35_0.tileList[1] or arg_35_0.tileList[2]
	local var_35_1 = table.remove(var_35_0, arg_35_2)

	if not var_35_1 then
		return
	end

	local var_35_2 = var_35_1.gameObject_

	var_35_1:ShowEffect(true)
	arg_35_0:DestroyTileObj(var_35_2)
end

function var_0_0.DestroyTileObj(arg_36_0, arg_36_1, arg_36_2)
	if isNil(arg_36_1) or not arg_36_1 then
		return
	end

	if arg_36_2 then
		arg_36_1.transform:SetParent(arg_36_0.poolTrs_)

		arg_36_1.transform.localScale = Vector3.New(1, 1, 1)

		SetActive(arg_36_1, false)
		table.insert(arg_36_0.tilePool, arg_36_1)
		table.remove(arg_36_0.destoryTimerList, time)
	else
		local var_36_0 = Timer.New(function()
			arg_36_1.transform:SetParent(arg_36_0.poolTrs_)

			arg_36_1.transform.localScale = Vector3.New(1, 1, 1)

			SetActive(arg_36_1, false)
			table.insert(arg_36_0.tilePool, arg_36_1)
		end, 0.23, 1)

		var_36_0:Start()
		table.insert(arg_36_0.destoryTimerList, var_36_0)
	end
end

function var_0_0.RemoveTween(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.tween) do
		if iter_38_1 then
			iter_38_1:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(iter_38_1.id)
		end
	end

	arg_38_0.tween = {}
end

function var_0_0.Dispose(arg_39_0)
	var_0_0.super.Dispose(arg_39_0)
	AnimatorTools.Stop()

	arg_39_0.tilePool = nil

	arg_39_0:RemoveTween()
	arg_39_0:StopTime()
	arg_39_0.cutsceneSubView:Dispose()
end

function var_0_0.StartIdle(arg_40_0)
	arg_40_0:ShowAnimation(true, 1)
	arg_40_0:ShowAnimation(false, 1)
	arg_40_0:SetIdleTimer()
end

local var_0_1 = {
	"charge_mild",
	"charge_hold",
	"charge_start",
	"charge_pro",
	"ult"
}

function var_0_0.ShowAnimation(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {
		"idle",
		"charge_mild",
		"charge_hold",
		"taunt",
		"ult",
		"fail",
		"victory",
		"charge_pro",
		"charge_start"
	}
	local var_41_1 = arg_41_1 and arg_41_0.selfSpineName or arg_41_0.enemySpineName
	local var_41_2 = arg_41_1 and arg_41_0.selfSpine or arg_41_0.enemySpine
	local var_41_3 = arg_41_1 and arg_41_0.selfSpineFx or arg_41_0.enemySpineFx
	local var_41_4 = var_41_0[arg_41_2]
	local var_41_5

	if var_41_1 == "kali_" then
		if var_41_4 == "charge_mild" then
			var_41_5 = "ui_scene_102003_sanxiao_1156_attack01"
		elseif var_41_4 == "charge_pro" then
			var_41_5 = "ui_scene_102003_sanxiao_1156_attack02"
		elseif var_41_4 == "ult" then
			var_41_5 = "ui_scene_102003_sanxiao_1156_attack03"
		elseif var_41_4 == "charge_hold" then
			var_41_5 = "ui_scene_102003_sanxiao_1156_attack_loop"
		end
	elseif var_41_1 == "parvati_" then
		if var_41_4 == "charge_mild" then
			var_41_5 = "ui_scene_102003_sanxiao_1089_attack01"
		elseif var_41_4 == "charge_pro" then
			var_41_5 = "ui_scene_102003_sanxiao_1089_attack02"
		elseif var_41_4 == "ult" then
			var_41_5 = "ui_scene_102003_sanxiao_1089_attack03"
		elseif var_41_4 == "charge_hold" then
			var_41_5 = "ui_scene_102003_sanxiao_1089_attack_loop"
		end
	end

	if var_41_4 == "victory" then
		var_41_5 = "ui_scene_102003_sanxiao_win"
	elseif var_41_4 == "fail" then
		var_41_5 = "ui_scene_102003_sanxiao_lose"
	end

	local var_41_6 = var_41_2.AnimationState:GetCurrent(0)

	if var_41_6 then
		local var_41_7 = var_41_6.Animation.Name

		Debug.Log("当前动画：" .. var_41_7 .. " 要播放的动画：" .. var_41_1 .. var_41_4)

		if var_41_7 == var_41_1 .. var_41_4 and var_41_7 ~= var_41_1 .. "charge_hold" or var_41_7 == var_41_1 .. "charge_hold" and var_41_4 == "charge_start" then
			return
		end
	end

	if var_41_5 then
		manager.audio:PlayEffect("ui_scene_102003", var_41_5, "")
	end

	local var_41_8 = var_41_2.AnimationState:SetAnimation(0, var_41_1 .. var_41_4, false)

	if table.indexof(var_0_1, var_41_4) then
		var_41_3.AnimationState:SetAnimation(0, var_41_1 .. var_41_4, false)
	else
		arg_41_0:InitSpine(var_41_3)
	end
end

function var_0_0.ShowCry(arg_42_0)
	SetActive(arg_42_0.spineTauntGo_, true)
	SetActive(arg_42_0.maskGo_, true)
	arg_42_0.enemyTauntSpine.AnimationState:SetAnimation(0, "ultimate", false)
	manager.audio:PlayEffect("vo_sys_102003", "v_s_102003_tv_game_102", true)

	arg_42_0.time = TimeTools.StartAfterSeconds(3, function()
		SetActive(arg_42_0.spineTauntGo_, false)
		SetActive(arg_42_0.maskGo_, false)
	end, {})
end

function var_0_0.ShowTaunt(arg_44_0)
	SetActive(arg_44_0.spineTauntGo_, true)
	SetActive(arg_44_0.maskGo_, true)
	arg_44_0.enemyTauntSpine.AnimationState:SetAnimation(0, "laugh", false)
	manager.audio:PlayEffect("vo_sys_102003", "v_s_102003_tv_game_103", true)

	arg_44_0.time = TimeTools.StartAfterSeconds(3, function()
		SetActive(arg_44_0.spineTauntGo_, false)
		SetActive(arg_44_0.maskGo_, false)
	end, {})
end

function var_0_0.ShowSelfUltimate(arg_46_0)
	SetActive(arg_46_0.maskGo_, true)

	if arg_46_0.chooseIndex == 2 then
		SetActive(arg_46_0.enemyUltimateAni_.transform.gameObject, true)
		arg_46_0.enemyUltimateAni_:Play("ultimateSkill04", 0, 0)
		arg_46_0.enemyUltimateAni_:Update(0)
	else
		SetActive(arg_46_0.selfUltimateAni_.transform.gameObject, true)
		arg_46_0.selfUltimateAni_:Play("ultimateSkill01", 0, 0)
		arg_46_0.selfUltimateAni_:Update(0)
	end

	arg_46_0.time = TimeTools.StartAfterSeconds(1.2, function()
		SetActive(arg_46_0.maskGo_, false)
		arg_46_0:ShowAnimation(true, 5)
	end, {})
end

function var_0_0.ShowEnemyUltimate(arg_48_0)
	SetActive(arg_48_0.maskGo_, true)

	if arg_48_0.chooseIndex == 2 then
		SetActive(arg_48_0.selfUltimateAni_.transform.gameObject, true)
		arg_48_0.selfUltimateAni_:Play("ultimateSkill03", 0, 0)
		arg_48_0.selfUltimateAni_:Update(0)
	else
		SetActive(arg_48_0.enemyUltimateAni_.transform.gameObject, true)
		arg_48_0.enemyUltimateAni_:Play("ultimateSkill02", 0, 0)
		arg_48_0.enemyUltimateAni_:Update(0)
	end

	arg_48_0.time = TimeTools.StartAfterSeconds(1.2, function()
		SetActive(arg_48_0.maskGo_, false)
		arg_48_0:ShowAnimation(false, 5)
	end, {})
end

function var_0_0.StopIdleTimer(arg_50_0)
	if arg_50_0.selfTimer_ then
		arg_50_0.selfTimer_:Stop()

		arg_50_0.selfTimer_ = nil
	end

	if arg_50_0.enemyTimer_ then
		arg_50_0.enemyTimer_:Stop()

		arg_50_0.enemyTimer_ = nil
	end
end

function var_0_0.GetSpineName(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1 and arg_51_0.selfSpine or arg_51_0.enemySpine
	local var_51_1 = arg_51_1 and arg_51_0.selfSpineName or arg_51_0.enemySpineName
	local var_51_2 = var_51_0.AnimationState:GetCurrent(0)

	if var_51_2 then
		local var_51_3 = var_51_2.Animation.Name

		return string.match(var_51_3, "^" .. var_51_1 .. "(.+)$") or ""
	end

	return ""
end

function var_0_0.SetIdleTimer(arg_52_0)
	local function var_52_0(arg_53_0, arg_53_1, arg_53_2)
		local var_53_0 = arg_53_0.AnimationState:GetCurrent(0)

		if not var_53_0 then
			return false
		end

		local var_53_1 = var_53_0.Animation.Name
		local var_53_2 = string.match(var_53_1, "^" .. arg_53_2 .. "(.+)$") or ""

		if var_53_2 ~= "idle" and var_53_0.IsComplete then
			if var_53_2 ~= "charge_hold" then
				arg_52_0:InitSpine(arg_53_1)
			end

			if var_53_2 == "victory" or var_53_2 == "fail" then
				return false
			end

			if var_53_2 == "charge_hold" then
				arg_52_0:ShowAnimation(arg_53_0 == arg_52_0.selfSpine, 3)

				return true
			end

			if var_53_2 == "charge_start" then
				arg_53_0.AnimationState:SetAnimation(0, arg_53_2 .. "charge_hold", false)
				arg_52_0:ShowAnimation(arg_53_0 == arg_52_0.selfSpine, 3)

				return true
			end

			arg_53_0.AnimationState:SetAnimation(0, arg_53_2 .. "idle", true)

			return true
		end

		return false
	end

	arg_52_0:StopIdleTimer()

	arg_52_0.selfTimer_ = FrameTimer.New(function()
		var_52_0(arg_52_0.selfSpine, arg_52_0.selfSpineFx, arg_52_0.selfSpineName)
	end, 0.33, -1)
	arg_52_0.enemyTimer_ = FrameTimer.New(function()
		var_52_0(arg_52_0.enemySpine, arg_52_0.enemySpineFx, arg_52_0.enemySpineName)
	end, 0.33, -1)

	arg_52_0.selfSpine.AnimationState:SetAnimation(0, arg_52_0.selfSpineName .. "idle", true)
	arg_52_0.enemySpine.AnimationState:SetAnimation(0, arg_52_0.enemySpineName .. "idle", true)
	arg_52_0.selfTimer_:Start()
	arg_52_0.enemyTimer_:Start()
end

function var_0_0.StopPlayable(arg_56_0)
	SetActive(arg_56_0.spineTauntGo_, false)
	SetActive(arg_56_0.maskGo_, false)
	SetActive(arg_56_0.selfUltimateAni_.transform.gameObject, false)
	SetActive(arg_56_0.enemyUltimateAni_.transform.gameObject, false)

	if arg_56_0.time then
		arg_56_0.time:Stop()

		arg_56_0.time = nil
	end
end

local var_0_2 = import("manager.posterGirl.tgame.GuelGame.States.Include")

function var_0_0.GetPlayBackwardsAnimator(arg_57_0)
	return arg_57_0.cutsceneSubView:GetPlayBackwardsAnimator(function()
		arg_57_0.enterAniControlller:SetSelectedState("true")

		local var_58_0 = manager.posterGirl.actor

		if var_58_0 then
			local var_58_1 = var_58_0:GetCurrentState()

			if var_58_1.gameInst and not var_58_1.gameInst.exit then
				var_58_1.gameInst:GoToState(var_0_2.ExitState)
			end
		end
	end, function()
		arg_57_0:StopTime()
		arg_57_0:StopIdleTimer()
		arg_57_0:StopPlayable()
		arg_57_0.gameManager:PauseGame(false, true)
		manager.audio:Stop("effect", true)
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_game_in", "")
	end)
end

return var_0_0
