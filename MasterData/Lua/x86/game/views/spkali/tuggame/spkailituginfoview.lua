local SPKailiTugInfoView = class("SPKailiTugInfoView", ReduxView)

function SPKailiTugInfoView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailiTugGameUI"
end

function SPKailiTugInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function SPKailiTugInfoView:OnCtor()
	return
end

function SPKailiTugInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPKailiTugInfoView:InitUI()
	self:BindCfgUI()

	self.skillIcon = {}

	local var_5_0 = {
		"btn_skillaBtn_",
		"btn_skillbBtn_",
		"btn_skillcBtn_"
	}

	for iter_5_0 = 1, 3 do
		self.skillIcon[iter_5_0] = SpKaliSkill.New(self[var_5_0[iter_5_0]].gameObject)
	end

	self.eventControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("event")
	self.rightstateControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("rightstate")
	self.leftstateControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("leftstate")
	self.enemyPowerControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("enemyPower")
	self.selfPowerControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("selfPower")
	self.prepareControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("prepare")
	self.showIconControl = self.shashwatui_3_6_kailituggameuiControllerexcollection_:GetController("showIcon")
	self.selfTipsControl = self.kaliangertxt2Controllerexcollection_:GetController("state")
	self.enemyTipsControl = self.kaliangertxt1Controllerexcollection_:GetController("state")
	self.eventTipsControl = self.kaliangertxt3Controllerexcollection_:GetController("state")
end

function SPKailiTugInfoView:OnEnter()
	self.gameManager = TugGame.GetInstance()

	self.eventControl:SetSelectedState("off")
	self.rightstateControl:SetSelectedState("hide")
	SetActive(self.kaliangertxt2Go_, false)

	self.showIconIndex = 0

	self:RefreshBar()

	self.prepareTime = 0

	self:RegistEventListener(ACTIVITY_KALI_UPDATE_TUGGAME, function(arg_7_0, arg_7_1)
		self:OnUpdateSkillInfo(arg_7_0)
		self:OnUpdatePosInfo(arg_7_1)
	end)
	self:RegistEventListener(ACTIVITY_KALI_UPDATE_TUGICON, function(arg_8_0, arg_8_1)
		if arg_8_0 ~= 0 then
			self.showIconIndex = arg_8_0
			self.addAnger = arg_8_1

			self.eventControl:SetSelectedState("on")
			self.showIconControl:SetSelectedState("icon" .. arg_8_0)
		else
			self.eventControl:SetSelectedState("off")
		end
	end)
	self:RegistEventListener(ACTIVITY_KALI_UPDATE__PARETIME, function(arg_9_0, arg_9_1)
		if arg_9_0 == 1 then
			self:ShowPrepareTime(arg_9_1)
		end
	end)
end

function SPKailiTugInfoView:ShowPrepareTime(arg_10_1)
	SetActive(self.kaliangertxt2Go_, false)

	self.prepareTime = arg_10_1
	self.textText_.text = string.format("%d", arg_10_1)

	self.prepareControl:SetSelectedState(arg_10_1 <= 0 and "hide" or "show")
end

function SPKailiTugInfoView:OnUpdateSkillInfo(arg_11_1)
	self.skillInfo = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(self.skillIcon) do
		self.skillIcon[iter_11_0]:UpdateFillValue(arg_11_1[iter_11_0])
	end
end

function SPKailiTugInfoView:OnUpdatePosInfo(arg_12_1)
	local var_12_0 = {
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

	for iter_12_0, iter_12_1 in ipairs({
		{
			showIcon = self.enmeygroupGo_,
			showProcess = self.sliself01Img_,
			stateControl = self.leftstateControl,
			angerTxt = self.text02Text_,
			showProcess2 = self.sliself02Img_
		},
		{
			showIcon = self.selfgroupGo_,
			showProcess = self.sli02Img_,
			stateControl = self.rightstateControl,
			angerTxt = self.text01Text_
		},
		{
			showIcon = self.showGo_
		}
	}) do
		if iter_12_0 == 3 then
			self:SetPosition(arg_12_1[iter_12_0].pos.x, arg_12_1[iter_12_0].pos.y, arg_12_1[iter_12_0].pos.z, iter_12_1.showIcon.transform, {
				x = var_12_0[iter_12_0].x,
				y = var_12_0[iter_12_0].y
			})
		end

		if iter_12_1.stateControl and arg_12_1[iter_12_0].state and arg_12_1[iter_12_0].state ~= 0 then
			iter_12_1.stateControl:SetSelectedState("state" .. arg_12_1[iter_12_0].state)
		end

		if iter_12_1.stateControl and not arg_12_1[iter_12_0].canEffect and iter_12_0 == 1 then
			iter_12_1.stateControl:SetSelectedState("state5")
		end

		if arg_12_1[iter_12_0].value and iter_12_1.showProcess then
			iter_12_1.showProcess.fillAmount = arg_12_1[iter_12_0].value
		end

		if arg_12_1[iter_12_0].value and iter_12_1.showProcess2 then
			iter_12_1.showProcess2.fillAmount = arg_12_1[iter_12_0].value
		end

		if arg_12_1[iter_12_0].anger and iter_12_1.angerTxt then
			iter_12_1.angerTxt.text = string.format("%d", arg_12_1[iter_12_0].anger)
		end
	end
end

function SPKailiTugInfoView:UpdateSkillStateInfo(arg_13_1)
	return
end

function SPKailiTugInfoView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SPKailiTugInfoView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.gameManager:PauseGame(true)
		self.prepareControl:SetSelectedState("hide")
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("BLISTER_TASK_DES2"),
			OkCallback = function()
				local var_17_0 = "activity_combat_over"
				local var_17_1 = {
					result = 3
				}

				if self.params_ then
					var_17_1.activity_id = self.params_.activityID or 0
				end

				if self.params_ then
					var_17_1.stage_id = self.params_.stageID or 0
				end

				var_17_1.reward_list = {}
				var_17_1.use_seconds = self.gameManager:GetUseTime()

				SDKTools.SendMessageToSDK(var_17_0, var_17_1)
				DestroyLua()
				LuaExchangeHelper.GoToMain()
			end,
			CancelCallback = function()
				self.gameManager:PauseGame(false)
				self:Back()
			end
		})
	end)
end

function SPKailiTugInfoView:SetPosition(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0, var_19_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_19_4.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Vector3.New(arg_19_1, arg_19_2, arg_19_3)), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	arg_19_4.localPosition = Vector3.New(var_19_1.x + (arg_19_5.x or 0), var_19_1.y + (arg_19_5.y or 0), var_19_1.z)
end

function SPKailiTugInfoView:RegisterEvents()
	return
end

function SPKailiTugInfoView:AddUIListener()
	self:AddBtnListener(self.btn_skillaBtn_, nil, function()
		local var_22_0, var_22_1, var_22_2 = self.gameManager:SkillA()

		if not var_22_0 then
			return
		end

		if not var_22_1 then
			self.ndstamina02Ani_:Play("UI_ndstamina02_loop", 0, 0)

			return
		end

		if var_22_0 and var_22_1 and var_22_2 then
			self.selfTipsControl:SetSelectedState("reduce")

			if self.skillInfo[1] then
				self.selfAngerTxt.text = self.skillInfo[1].cost or 0
			end

			SetActive(self.kaliangertxt2Go_, true)
			self.kaliangertxt2Ani_:Update(0)
			self.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
		end
	end)
	self:AddBtnListener(self.btn_skillbBtn_, nil, function()
		local var_23_0, var_23_1, var_23_2, var_23_3, var_23_4 = self.gameManager:SkillB()

		if not var_23_0 then
			return
		end

		if not var_23_1 then
			self.ndstamina02Ani_:Play("UI_ndstamina02_loop", 0, 0)

			return
		end

		if var_23_0 and var_23_1 then
			animatorInfo = self.rightskillAni_:GetCurrentAnimatorStateInfo(0)

			if var_23_2 then
				self.rightstateControl:SetSelectedState("green")
				self.selfTipsControl:SetSelectedState("reduce")

				if self.skillInfo[2] then
					self.selfAngerTxt.text = self.skillInfo[2].cost or 0
				end

				Dorm.DormEntityManager.StopAllCmd(1)
				Dorm.DormEntityManager.SendDoActionCMD(1, "bahe_dizzy", false)
				self.gameManager:SetSelfState(3)
				self.gameManager:SetMonterState(4)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_pop_sword")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")
				self.rightskillAni_:Update(0)
				AnimatorTools.PlayAnimationWithCallback(self.rightskillAni_, "UI_rightskill_cx", function()
					self.gameManager:SetSelfState(5)
					self.rightstateControl:SetSelectedState("hide")
					self.gameManager:StarBaAni1()
					self.gameManager:SetMonterState(3)
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop_stop")
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop_stop")
				end)
			end

			if var_23_3 then
				self.gameManager:SetSelfState(6)
				self.gameManager:SetMonterState(1)
				Dorm.DormEntityManager.StopAllCmd(2)
				Dorm.DormEntityManager.SendDoActionCMD(2, "bahe_dizzy", false)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")

				if not animatorInfo:IsName("UI_rightskill_cx") then
					self.kaliangertxt2Ani_:Update(0)
					self.rightstateControl:SetSelectedState("green")
					AnimatorTools.PlayAnimationWithCallback(self.rightskillAni_, "UI_rightskill_cx_01", function()
						self.rightstateControl:SetSelectedState("hide")
					end)
				end
			end
		end

		if var_23_4 then
			if self.skillInfo[2] then
				self.selfAngerTxt.text = self.skillInfo[2].cost or 0
			end

			SetActive(self.kaliangertxt2Go_, true)
			self.kaliangertxt2Ani_:Update(0)
			self.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
		end
	end)
	self:AddBtnListener(self.btn_skillcBtn_, nil, function()
		local var_26_0, var_26_1, var_26_2, var_26_3, var_26_4 = self.gameManager:SkillC()

		if not var_26_0 then
			return
		end

		if not var_26_1 then
			self.ndstamina02Ani_:Play("UI_ndstamina02_loop", 0, 0)

			return
		end

		if var_26_0 and var_26_1 then
			animatorInfo = self.rightskillAni_:GetCurrentAnimatorStateInfo(0)

			if var_26_2 then
				self.selfTipsControl:SetSelectedState("reduce")
				self.rightstateControl:SetSelectedState("blue")
				self.rightskillAni_:Update(0)
				Dorm.DormEntityManager.StopAllCmd(1)
				self.gameManager:SetSelfState(3)
				self.gameManager:SetMonterState(4)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_pop_shield")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")
				Dorm.DormEntityManager.SendDoActionCMD(1, "bahe_dizzy", false)
				AnimatorTools.PlayAnimationWithCallback(self.rightskillAni_, "UI_rightskill_cx", function()
					self.gameManager:SetSelfState(5)
					self.rightstateControl:SetSelectedState("hide")
					self.gameManager:StarBaAni1()
					self.gameManager:SetMonterState(3)
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop_stop")
					manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop_stop")
				end)
			end

			if var_26_3 then
				self.gameManager:SetSelfState(6)
				self.gameManager:SetMonterState(1)
				Dorm.DormEntityManager.StopAllCmd(2)
				Dorm.DormEntityManager.SendDoActionCMD(2, "bahe_dizzy", false)
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop")
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop")

				if not animatorInfo:IsName("UI_rightskill_cx") then
					self.rightstateControl:SetSelectedState("blue")
					AnimatorTools.PlayAnimationWithCallback(self.rightskillAni_, "UI_rightskill_cx_01", function()
						self.rightstateControl:SetSelectedState("hide")
					end)
				end
			end
		end

		if var_26_4 then
			if self.skillInfo[3] then
				self.selfAngerTxt.text = self.skillInfo[3].cost or 0
			end

			SetActive(self.kaliangertxt2Go_, true)
			self.kaliangertxt2Ani_:Update(0)
			self.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
		end
	end)

	for iter_21_0 = 1, 3 do
		self:AddBtnListener(self["icon" .. iter_21_0 .. "Btn_"], nil, function()
			self:ClickIcon(iter_21_0)
		end)
	end
end

function SPKailiTugInfoView:ShowAngerTips()
	return
end

function SPKailiTugInfoView:ClickIcon(arg_31_1)
	if self.showIconIndex == 0 then
		return
	end

	local var_31_0 = "UI_powerI_cx"

	if self.showIconIndex == arg_31_1 then
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_end")
		self.gameManager:AddAnger()

		var_31_0 = "UI_powerI_cx"
		self.selfAngerTxt.text = self.addAnger or 0

		self.selfTipsControl:SetSelectedState("add")
		self.kaliangertxt2Ani_:Update(0)
		SetActive(self.kaliangertxt2Go_, true)
		self.kaliangertxt2Ani_:Play("UI_KaliAngerTxt1", 0, 0)
	else
		var_31_0 = "UI_powerI_red"

		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_ui_warn_empty")
	end

	self.showIconIndex = 0

	self.showAni_:Update(0)
	self.showAni_:Play(var_31_0)

	self.iconAniTimer = TimeTools.StartAfterSeconds(0.4, function()
		SetActive(self.kaliangertxt2Go_, false)
		self.eventControl:SetSelectedState("off")
		self.gameManager:RemoveIconAnger()
	end, {})
end

function SPKailiTugInfoView:StopGame()
	self.startGameFlag = false

	self:ResetTimer()

	if self.mistakeList then
		for iter_33_0, iter_33_1 in ipairs(self.mistakeList) do
			Object.Destroy(iter_33_1.go)
		end

		self.mistakeList = nil
	end
end

function SPKailiTugInfoView:OnTop()
	self.prepareControl:SetSelectedState(self.prepareTime <= 0 and "hide" or "show")
end

function SPKailiTugInfoView:ExitGame()
	manager.audio:StopEffect()
	self.game:Abort()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/spHeroChallengeMainView", {})
end

function SPKailiTugInfoView:Dispose()
	SPKailiTugInfoView.super.Dispose(self)

	if self.iconAniTimer then
		self.iconAniTimer:Stop()

		self.iconAniTimer = nil
	end

	AnimatorTools.Stop()
end

return SPKailiTugInfoView
