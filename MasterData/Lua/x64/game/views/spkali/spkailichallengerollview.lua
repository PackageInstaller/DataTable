local SPKailiChallengeRollView = class("SPKailiChallengeRollView", ReduxView)

function SPKailiChallengeRollView:Init()
	self:BindCfgUI()

	self.nodeList = {}

	self:AddListeners()

	self.btnConfirmController = self.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("btn_confirm")
	self.imgBossConfirmController = self.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("imgBoss")
	self.imgBublleController = self.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("imgBublle")
	self.tipsDesController = self.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("tipsDes")
	self.affixDesController = self.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("affixDes")
	self.affixActiveController = self.itemaffixcardControllerexcollection_:GetController("active")
	self.rollController = self.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("rollState")
end

function SPKailiChallengeRollView:IndexItem(arg_2_1, arg_2_2)
	arg_2_2:SetData(self.pointlist[arg_2_1])
end

function SPKailiChallengeRollView:UIParent()
	return manager.ui.uiMain.transform
end

function SPKailiChallengeRollView:OnCtor()
	return
end

function SPKailiChallengeRollView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kaliFistUI"
end

function SPKailiChallengeRollView:AddListeners()
	self:AddBtnListener(self.btn_confirmBtn_, nil, function()
		if SpKaliTool.IsHaveRolled(self.activityID) then
			JumpTools.OpenPageByJump("/SpKaliChallenge", {
				activityID_ = self.activityID
			})
		end
	end)
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.isInAnimation then
			return
		end

		local var_8_0 = GameSetting.activity_kali_cost_item.value[1]

		if self.isFree then
			self.effectID = false

			self.imgBublleController:SetSelectedState("state1")
			self.rollController:SetSelectedState("hide")
			SPKaliChallengeAction.RollAffix(self.activityID)
			manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_FREE_ROLL, 0)

			self.isInAnimation = true
		else
			if ItemTools.getItemNum(GameSetting.activity_kali_cost_item.value[1]) < GameSetting.activity_kali_cost_item.value[2] then
				ShowTips(string.format(GetTips("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH"), ItemCfg[var_8_0].name))

				return
			end

			self.imgBublleController:SetSelectedState("state1")
			self.rollController:SetSelectedState("hide")

			self.effectID = false

			SPKaliChallengeAction.RollAffix(self.activityID)

			self.isInAnimation = true
		end
	end)
	self:AddBtnListener(self.btnlookBtn_, nil, function()
		self:SetTips1Show(true)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:SetTips1Show(false)
	end)
	self:AddBtnListener(self.mask2Btn_, nil, function()
		self:SetAffixShow(false)
	end)
	self:AddBtnListener(self.affixrowBtn_, nil, function()
		if SpKaliTool.IsHaveRolled(self.activityID) then
			-- block empty
		end
	end)
end

function SPKailiChallengeRollView:SetTips1Show(arg_13_1)
	self.tipsDesController:SetSelectedState(arg_13_1 and "show" or "hide")
end

function SPKailiChallengeRollView:SetAffixShow(arg_14_1)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gameobjectTrs_)
	end, {})
	self.affixDesController:SetSelectedState(arg_14_1 and "show" or "hide")
end

function SPKailiChallengeRollView:UpdateData(arg_16_1)
	self.pointlist = SPKaliChallengeData:GetShowPointList(arg_16_1) or {}
end

function SPKailiChallengeRollView:RefreshStageList()
	self.stageList_:StartScroll(#self.pointlist)
end

function SPKailiChallengeRollView:StartRollAction(arg_18_1, arg_18_2)
	local var_18_0 = {
		58.5,
		150.5,
		242.5,
		334.5,
		426.5
	}

	if self.timelist == nil then
		self.timelist = {}
	end

	if self.tweenList == nil then
		self.tweenList = {}
	end

	if self.timelist[arg_18_1.name] == nil then
		self.timelist[arg_18_1.name] = {
			index = 1,
			timeScale = 1
		}
	end

	self.timelist[arg_18_1.name].index = 1
	self.timelist[arg_18_1.name].timeScale = 1

	if self.timelist[arg_18_1.name].time then
		self.timelist[arg_18_1.name].time:Stop()
	end

	self.timelist[arg_18_1.name].time = Timer.New(function()
		self.timelist[arg_18_1.name].timeScale = self.timelist[arg_18_1.name].timeScale - 1

		if self.timelist[arg_18_1.name].timeScale == 0 then
			for iter_19_0 = 0, arg_18_1.childCount - 1 do
				local var_19_0 = arg_18_1:GetChild(iter_19_0)
				local var_19_1

				if (iter_19_0 + 1 + self.timelist[arg_18_1.name].index) % #var_18_0 == 0 then
					var_19_1 = #var_18_0 or (iter_19_0 + 1 + self.timelist[arg_18_1.name].index) % #var_18_0
				end

				local var_19_2 = LeanTween.moveLocalX(var_19_0.gameObject, var_18_0[var_19_1], 0.04)

				if var_19_1 == 0 or var_19_1 == 5 then
					var_19_0.gameObject:SetActive(false)
				else
					var_19_0.gameObject:SetActive(true)
				end

				table.insert(self.tweenList, var_19_2)
			end

			self.timelist[arg_18_1.name].index = self.timelist[arg_18_1.name].index + 1
		end

		if self.timelist[arg_18_1.name].index < 20 and self.timelist[arg_18_1.name].timeScale == 0 then
			self.timelist[arg_18_1.name].timeScale = 1
		elseif self.timelist[arg_18_1.name].index <= 25 and self.timelist[arg_18_1.name].timeScale <= 0 then
			self.timelist[arg_18_1.name].timeScale = 2
		elseif self.timelist[arg_18_1.name].index <= 30 and self.timelist[arg_18_1.name].timeScale <= 0 then
			self.timelist[arg_18_1.name].time:Stop()
			self.affixrowAni_:Play("UI_icons_cx")

			for iter_19_1 = 0, arg_18_1.childCount - 1 do
				local var_19_3 = arg_18_1:GetChild(iter_19_1)

				var_19_3.transform.localPosition = Vector3.New(var_18_0[iter_19_1 + 1], -50, 0)

				if iter_19_1 + 1 == 0 or iter_19_1 + 1 == 5 then
					var_19_3.gameObject:SetActive(false)
				else
					var_19_3.gameObject:SetActive(true)
				end
			end
		end
	end, 0.02, -1)

	self.timelist[arg_18_1.name].time:Start()
end

function SPKailiChallengeRollView:OnEnter()
	self.gameoverGo_:SetActive(false)

	if self.params_ then
		self.activityID = self.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_FIGHT
	end

	SPKailiChallengeRollView.super.OnEnter(self)
	self.rootAni_:Play("UI_root_fd")
	self.imgBublleController:SetSelectedState("state1")
	self:RefreshAffixDes()
	self.affixrowAni_:Play("UI_icons_Idle")
	self:RegistEventListener(ACTIVITY_KALI_INFO, function()
		self:RefreshAffixDes()
		self.imgBossConfirmController:SetSelectedState("state0")
		AnimatorTools.PlayAnimationWithCallback(self.rootAni2_, "UI_fistTarget_cx", function()
			return
		end)

		if self.effectID then
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_roll_plus")
		else
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_roll_normal")
		end

		self.affixrowAni_:Play("UI_icons_Idle")
		self:StartRollAction(self.content1Trs_)
		self:StartRollAction(self.content2Trs_)
		self:StartRollAction(self.contentTrs_)

		self.timer2 = TimeTools.StartAfterSeconds(0.5, function()
			self.imgBossConfirmController:SetSelectedState("state1")
		end, {})
		self.timer = TimeTools.StartAfterSeconds(1.5, function()
			if self.effectID then
				self.gameoverGo_:SetActive(true)
			end

			self.rollController:SetSelectedState("show")
			self.imgBublleController:SetSelectedState(self.isRolled and "state0" or "state1")
			self.rootAni2_:Play("idel")

			self.isInAnimation = false
		end, {})

		AnimatorTools.PlayAnimationWithCallback(self.gameoverAni_, "UI_Game over_cx", function()
			self.gameoverGo_:SetActive(false)
		end)
	end)

	self.messagetextText_.text = GetTips("ACTIVITY_KALI_LUCK_DES_TIP")
	self.iconresImg_.sprite = ItemTools.getItemLittleSprite(GameSetting.activity_kali_cost_item.value[1])

	self:ShowAffixBox(0.5)
	self.rollController:SetSelectedState("show")
end

function SPKailiChallengeRollView:ShowAffixBox(arg_26_1)
	if self.timer1 then
		self.timer1:Stop()

		self.timer1 = nil
	end

	self.timer1 = TimeTools.StartAfterSeconds(arg_26_1 or 0.5, function()
		self.imgBublleController:SetSelectedState(self.isRolled and "state0" or "state1")
	end, {})
end

function SPKailiChallengeRollView:OnTop()
	self:ChangeBar()

	self.isInAnimation = false
end

function SPKailiChallengeRollView:GetPlayBackwardsAnimator()
	return {
		{
			self.rootAni_,
			"UI_root_sx",
			false
		}
	}, handler(self, self.PlayBackwardsAnimatorFun)
end

function SPKailiChallengeRollView:PlayBackwardsAnimatorFun()
	manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_roll_close")
end

function SPKailiChallengeRollView:OnExit()
	SPKailiChallengeRollView.super.OnExit(self)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.timer1 then
		self.timer1:Stop()

		self.timer1 = nil
	end

	if self.timer2 then
		self.timer2:Stop()

		self.timer2 = nil
	end

	for iter_31_0, iter_31_1 in pairs(self.timelist or {}) do
		if iter_31_1 and iter_31_1.time then
			iter_31_1.time:Stop()
		end
	end

	AnimatorTools.Stop()
end

function SPKailiChallengeRollView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		SpKaliConst.ItemConst.coinID2
	})
	manager.windowBar:SetBarCanClick(SpKaliConst.ItemConst.coinID2, true)
end

function SPKailiChallengeRollView:RefreshAffixDes()
	local var_33_0 = SPKaliChallengeData:GetSPChallengeData(self.activityID)

	self.luckvalueText_.text = string.format(GetTips("ACTIVITY_KALI_LUCK_DES"), (var_33_0 or nil) and (var_33_0.lucky or 0), GameSetting.activity_kali_lucky_Max.value[1])

	local var_33_2 = SPKaliChallengeData:GetKaliAffix(self.activityID)

	self.textcostnumText_.text = var_33_0 and var_33_0.free == 1 and GetTips("ACTIVITY_KALI_DESC_4") or SpKaliTool.GetRollCostDes()
	self.isFree = var_33_0 and var_33_0.free == 1

	for iter_33_0 = 1, 3 do
		if ActivityAffixPoolCfg[var_33_2[iter_33_0]] then
			local var_33_3 = SpKaliTool.GetAffixID(var_33_2[iter_33_0])

			self["iconaffix" .. iter_33_0 .. "Img_"].sprite = getAffixSprite(ActivityAffixPoolCfg[var_33_2[iter_33_0]].affix)
			self["titletext" .. iter_33_0 .. "Text_"].text = ActivityAffixPoolCfg[var_33_2[iter_33_0]].name
			self["messagetext" .. iter_33_0 .. "Text_"].text = getAffixDesc(ActivityAffixPoolCfg[var_33_2[iter_33_0]].affix)
		end
	end

	local var_33_4 = SPKaliChallengeData:GetNowAffixEffect(self.activityID)

	self.isRolled = SpKaliTool.IsHaveRolled(self.activityID)

	self.btnConfirmController:SetSelectedState(self.isRolled and "active" or "unactive")

	if var_33_4 then
		self.effectID = true

		if ActivityAffixPoolCfg[ActivitykaliaffixCfg[var_33_4].affix_id] then
			self.textaffixeffectText_.text = getAffixDesc(ActivityAffixPoolCfg[ActivitykaliaffixCfg[var_33_4].affix_id].affix)
			self.textaffixnameText_.text = ActivityAffixPoolCfg[ActivitykaliaffixCfg[var_33_4].affix_id].name
			self.iconaffix_lImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[ActivitykaliaffixCfg[var_33_4].affix_id].affix)

			self.affixActiveController:SetSelectedState("active")
		else
			self.affixActiveController:SetSelectedState("unactive")
		end
	else
		self.affixActiveController:SetSelectedState("unactive")
	end
end

function SPKailiChallengeRollView:Dispose()
	SPKailiChallengeRollView.super.Dispose(self)
	SPKailiChallengeRollView.super.Dispose(self)
end

return SPKailiChallengeRollView
