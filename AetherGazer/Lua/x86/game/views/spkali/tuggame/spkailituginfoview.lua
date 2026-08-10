local var_0_0 = class("SPKailiTugInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailiTugGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.skillIcon = {}

	local var_5_0 = {
		"btn_skillaBtn_",
		"btn_skillbBtn_",
		"btn_skillcBtn_"
	}

	for iter_5_0 = 1, 3 do
		arg_5_0.skillIcon[iter_5_0] = SpKaliSkill.New(arg_5_0[var_5_0[iter_5_0]].gameObject)
	end

	arg_5_0.eventControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("event")
	arg_5_0.rightstateControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("rightstate")
	arg_5_0.leftstateControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("leftstate")
	arg_5_0.enemyPowerControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("enemyPower")
	arg_5_0.selfPowerControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("selfPower")
	arg_5_0.prepareControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("prepare")
	arg_5_0.showIconControl = arg_5_0.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("showIcon")
	arg_5_0.selfTipsControl = arg_5_0.kaliangertxt2Controllerexcollection_:GetController("state")
	arg_5_0.enemyTipsControl = arg_5_0.kaliangertxt1Controllerexcollection_:GetController("state")
	arg_5_0.eventTipsControl = arg_5_0.kaliangertxt3Controllerexcollection_:GetController("state")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.gameManager = TugGame.GetInstance()

	arg_6_0.eventControl:SetSelectedState("off")
	arg_6_0.rightstateControl:SetSelectedState("hide")
	SetActive(arg_6_0.kaliangertxt2Go_, false)

	arg_6_0.showIconIndex = 0

	arg_6_0:RefreshBar()

	arg_6_0.prepareTime = 0

	arg_6_0:RegistEventListener(ACTIVITY_KALI_UPDATE_TUGGAME, function(arg_7_0, arg_7_1)
		arg_6_0:OnUpdateSkillInfo(arg_7_0)
		arg_6_0:OnUpdatePosInfo(arg_7_1)
	end)
	arg_6_0:RegistEventListener(ACTIVITY_KALI_UPDATE_TUGICON, function(arg_8_0, arg_8_1)
		if arg_8_0 ~= 0 then
			arg_6_0.showIconIndex = arg_8_0
			arg_6_0.addAnger = arg_8_1

			arg_6_0.eventControl:SetSelectedState("on")
			arg_6_0.showIconControl:SetSelectedState("icon" .. arg_8_0)
		else
			arg_6_0.eventControl:SetSelectedState("off")
		end
	end)
	arg_6_0:RegistEventListener(ACTIVITY_KALI_UPDATE__PARETIME, function(arg_9_0, arg_9_1)
		if arg_9_0 == 1 then
			arg_6_0:ShowPrepareTime(arg_9_1)
		end
	end)
end

function var_0_0.ShowPrepareTime(arg_10_0, arg_10_1)
	SetActive(arg_10_0.kaliangertxt2Go_, false)

	arg_10_0.prepareTime = arg_10_1
	arg_10_0.textText_.text = string.format("%d", arg_10_1)

	arg_10_0.prepareControl:SetSelectedState(arg_10_1 <= 0 and "hide" or "show")
end

function var_0_0.OnUpdateSkillInfo(arg_11_0, arg_11_1)
	arg_11_0.skillInfo = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.skillIcon) do
		local var_11_0 = arg_11_1[iter_11_0]

		arg_11_0.skillIcon[iter_11_0]:UpdateFillValue(var_11_0)
	end
end

function var_0_0.OnUpdatePosInfo(arg_12_0, arg_12_1)
	local var_12_0 = {
		{
			showIcon = arg_12_0.enmeygroupGo_,
			showProcess = arg_12_0.sliself01Img_,
			stateControl = arg_12_0.leftstateControl,
			angerTxt = arg_12_0.text02Text_,
			showProcess2 = arg_12_0.sliself02Img_
		},
		{
			showIcon = arg_12_0.selfgroupGo_,
			showProcess = arg_12_0.sli02Img_,
			stateControl = arg_12_0.rightstateControl,
			angerTxt = arg_12_0.text01Text_
		},
		{
			showIcon = arg_12_0.showGo_
		}
	}
	local var_12_1 = {
		{
			x = 360,
			y = 150
		},
		{
			x = 150,
			y = 150
		},
		{
			x = 0,
			y = 450
		}
	}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = arg_12_1[iter_12_0]

		if iter_12_0 == 3 then
			arg_12_0:SetPosition(var_12_2.pos.x, var_12_2.pos.y, var_12_2.pos.z, iter_12_1.showIcon.transform, {
				x = var_12_1[iter_12_0].x,
				y = var_12_1[iter_12_0].y
			})
		end

		if iter_12_1.stateControl and var_12_2.state and var_12_2.state ~= 0 then
			iter_12_1.stateControl:SetSelectedState("state" .. var_12_2.state)
		end

		if iter_12_1.stateControl and not var_12_2.canEffect and iter_12_0 == 1 then
			iter_12_1.stateControl:SetSelectedState("state5")
		end

		if var_12_2.value and iter_12_1.showProcess then
			iter_12_1.showProcess.fillAmount = var_12_2.value
		end

		if var_12_2.value and iter_12_1.showProcess2 then
			iter_12_1.showProcess2.fillAmount = var_12_2.value
		end

		if var_12_2.anger and iter_12_1.angerTxt then
			iter_12_1.angerTxt.text = string.format("%d", var_12_2.anger)
		end
	end
end

function var_0_0.UpdateSkillStateInfo(arg_13_0, arg_13_1)
	return
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.RefreshBar(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_15_0.gameManager:PauseGame(true)
		arg_15_0.prepareControl:SetSelectedState("hide")
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("BLISTER_TASK_DES2"),
			OkCallback = function()
				SDKTools.SendMessageToSDK("activity_combat_over", {
					result = 3,
					activity_id = arg_15_0.params_ and arg_15_0.params_.activityID or 0,
					stage_id = arg_15_0.params_ and arg_15_0.params_.stageID or 0,
					reward_list = {},
					use_seconds = arg_15_0.gameManager:GetUseTime()
				})
				DestroyLua()
				LuaExchangeHelper.GoToMain()
			end,
			CancelCallback = function()
				arg_15_0.gameManager:PauseGame(false)
				arg_15_0:Back()
			end
		})
	end)
end

function var_0_0.SetPosition(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = manager.ui.mainCameraCom_
	local var_19_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_19_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_19_0, Vector3.New(arg_19_1, arg_19_2, arg_19_3))
	local var_19_3, var_19_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_19_4.parent, var_19_2, var_19_1, nil)

	arg_19_4.localPosition = Vector3.New(var_19_4.x + (arg_19_5.x or 0), var_19_4.y + (arg_19_5.y or 0), var_19_4.z)
end

function var_0_0.RegisterEvents(arg_20_0)
	return
end

function var_0_0.AddUIListener(arg_21_0)
	arg_21_0:AddBtnListener(arg_21_0.btn_skillaBtn_, nil, function()
		local var_22_0, var_22_1, var_22_2 = arg_21_0.gameManager:SkillA()

		if not var_22_0 then
			return
		end

		if not var_22_1 then
			arg_21_0.ndstamina02Ani_:Play("UI_ndstamina02_loop", 0, 0)

			return
		end

		if var_22_0 and var_22_1 and var_22_2 then
			arg_21_0.selfTipsControl:SetSelectedState("reduce")

			arg_21_0.selfAngerTxt.text = arg_21_0.skillInfo[1] and arg_21_0.skillInfo[1].cost or 0

			SetActive(arg_21_0.kaliangertxt2Go_, true)
			arg_21_0.kaliangertxt2Ani_:Update(0)
			arg_21_0.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
		end
	end)
	arg_21_0:AddBtnListener(arg_21_0.btn_skillbBtn_, nil, function()
		local var_23_0, var_23_1, var_23_2, var_23_3, var_23_4 = arg_21_0.gameManager:SkillB()

		if not var_23_0 then
			return
		end

		if not var_23_1 then
			arg_21_0.ndstamina02Ani_:Play("UI_ndstamina02_loop", 0, 0)

			return
		end

		if var_23_0 and var_23_1 then
			animatorInfo = arg_21_0.rightskillAni_:GetCurrentAnimatorStateInfo(0)

			if var_23_2 then
				arg_21_0.rightstateControl:SetSelectedState("green")
				arg_21_0.selfTipsControl:SetSelectedState("reduce")

				arg_21_0.selfAngerTxt.text = arg_21_0.skillInfo[2] and arg_21_0.skillInfo[2].cost or 0

				Dorm.DormEntityManager.StopAllCmd(1)
				Dorm.DormEntityManager.SendDoActionCMD(1, "bahe_dizzy", false)
				arg_21_0.gameManager:SetSelfState(3)
				arg_21_0.gameManager:SetMonterState(4)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_pop_sword")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")
				arg_21_0.rightskillAni_:Update(0)
				AnimatorTools.PlayAnimationWithCallback(arg_21_0.rightskillAni_, "UI_rightskill_cx", function()
					arg_21_0.gameManager:SetSelfState(5)
					arg_21_0.rightstateControl:SetSelectedState("hide")
					arg_21_0.gameManager:StarBaAni1()
					arg_21_0.gameManager:SetMonterState(3)
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop_stop")
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop_stop")
				end)
			end

			if var_23_3 then
				arg_21_0.gameManager:SetSelfState(6)
				arg_21_0.gameManager:SetMonterState(1)
				Dorm.DormEntityManager.StopAllCmd(2)
				Dorm.DormEntityManager.SendDoActionCMD(2, "bahe_dizzy", false)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")

				if not animatorInfo:IsName("UI_rightskill_cx") then
					arg_21_0.kaliangertxt2Ani_:Update(0)
					arg_21_0.rightstateControl:SetSelectedState("green")
					AnimatorTools.PlayAnimationWithCallback(arg_21_0.rightskillAni_, "UI_rightskill_cx_01", function()
						arg_21_0.rightstateControl:SetSelectedState("hide")
					end)
				end
			end
		end

		if var_23_4 then
			arg_21_0.selfAngerTxt.text = arg_21_0.skillInfo[2] and arg_21_0.skillInfo[2].cost or 0

			SetActive(arg_21_0.kaliangertxt2Go_, true)
			arg_21_0.kaliangertxt2Ani_:Update(0)
			arg_21_0.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
		end
	end)
	arg_21_0:AddBtnListener(arg_21_0.btn_skillcBtn_, nil, function()
		local var_26_0, var_26_1, var_26_2, var_26_3, var_26_4 = arg_21_0.gameManager:SkillC()

		if not var_26_0 then
			return
		end

		if not var_26_1 then
			arg_21_0.ndstamina02Ani_:Play("UI_ndstamina02_loop", 0, 0)

			return
		end

		if var_26_0 and var_26_1 then
			animatorInfo = arg_21_0.rightskillAni_:GetCurrentAnimatorStateInfo(0)

			if var_26_2 then
				arg_21_0.selfTipsControl:SetSelectedState("reduce")
				arg_21_0.rightstateControl:SetSelectedState("blue")
				arg_21_0.rightskillAni_:Update(0)
				Dorm.DormEntityManager.StopAllCmd(1)
				arg_21_0.gameManager:SetSelfState(3)
				arg_21_0.gameManager:SetMonterState(4)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_pop_shield")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")
				Dorm.DormEntityManager.SendDoActionCMD(1, "bahe_dizzy", false)
				AnimatorTools.PlayAnimationWithCallback(arg_21_0.rightskillAni_, "UI_rightskill_cx", function()
					arg_21_0.gameManager:SetSelfState(5)
					arg_21_0.rightstateControl:SetSelectedState("hide")
					arg_21_0.gameManager:StarBaAni1()
					arg_21_0.gameManager:SetMonterState(3)
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop_stop")
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop_stop")
				end)
			end

			if var_26_3 then
				arg_21_0.gameManager:SetSelfState(6)
				arg_21_0.gameManager:SetMonterState(1)
				Dorm.DormEntityManager.StopAllCmd(2)
				Dorm.DormEntityManager.SendDoActionCMD(2, "bahe_dizzy", false)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")

				if not animatorInfo:IsName("UI_rightskill_cx") then
					arg_21_0.rightstateControl:SetSelectedState("blue")
					AnimatorTools.PlayAnimationWithCallback(arg_21_0.rightskillAni_, "UI_rightskill_cx_01", function()
						arg_21_0.rightstateControl:SetSelectedState("hide")
					end)
				end
			end
		end

		if var_26_4 then
			arg_21_0.selfAngerTxt.text = arg_21_0.skillInfo[3] and arg_21_0.skillInfo[3].cost or 0

			SetActive(arg_21_0.kaliangertxt2Go_, true)
			arg_21_0.kaliangertxt2Ani_:Update(0)
			arg_21_0.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
		end
	end)

	for iter_21_0 = 1, 3 do
		arg_21_0:AddBtnListener(arg_21_0["icon" .. iter_21_0 .. "Btn_"], nil, function()
			arg_21_0:ClickIcon(iter_21_0)
		end)
	end
end

function var_0_0.ShowAngerTips(arg_30_0)
	return
end

function var_0_0.ClickIcon(arg_31_0, arg_31_1)
	if arg_31_0.showIconIndex == 0 then
		return
	end

	local var_31_0 = "UI_powerI_cx"

	if arg_31_0.showIconIndex == arg_31_1 then
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_end")
		arg_31_0.gameManager:AddAnger()

		var_31_0 = "UI_powerI_cx"
		arg_31_0.selfAngerTxt.text = arg_31_0.addAnger or 0

		arg_31_0.selfTipsControl:SetSelectedState("add")
		arg_31_0.kaliangertxt2Ani_:Update(0)
		SetActive(arg_31_0.kaliangertxt2Go_, true)
		arg_31_0.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
	else
		var_31_0 = "UI_powerI_red"

		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_ui_warn_empty")
	end

	arg_31_0.showIconIndex = 0

	arg_31_0.showAni_:Update(0)
	arg_31_0.showAni_:Play(var_31_0)

	arg_31_0.iconAniTimer = TimeTools.StartAfterSeconds(0.4, function()
		SetActive(arg_31_0.kaliangertxt2Go_, false)
		arg_31_0.eventControl:SetSelectedState("off")
		arg_31_0.gameManager:RemoveIconAnger()
	end, {})
end

function var_0_0.StopGame(arg_33_0)
	arg_33_0.startGameFlag = false

	arg_33_0:ResetTimer()

	if arg_33_0.mistakeList then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0.mistakeList) do
			Object.Destroy(iter_33_1.go)
		end

		arg_33_0.mistakeList = nil
	end
end

function var_0_0.OnTop(arg_34_0)
	arg_34_0.prepareControl:SetSelectedState(arg_34_0.prepareTime <= 0 and "hide" or "show")
end

function var_0_0.ExitGame(arg_35_0)
	manager.audio:StopEffect()
	arg_35_0.game:Abort()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/spHeroChallengeMainView", {})
end

function var_0_0.Dispose(arg_36_0)
	var_0_0.super.Dispose(arg_36_0)

	if arg_36_0.iconAniTimer then
		arg_36_0.iconAniTimer:Stop()

		arg_36_0.iconAniTimer = nil
	end

	AnimatorTools.Stop()
end

return var_0_0
