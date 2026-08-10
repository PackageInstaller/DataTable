local var_0_0 = class("SPKailiChallengeRollView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.nodeList = {}

	arg_1_0:AddListeners()

	arg_1_0.btnConfirmController = arg_1_0.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("btn_confirm")
	arg_1_0.imgBossConfirmController = arg_1_0.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("imgBoss")
	arg_1_0.imgBublleController = arg_1_0.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("imgBublle")
	arg_1_0.tipsDesController = arg_1_0.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("tipsDes")
	arg_1_0.affixDesController = arg_1_0.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("affixDes")
	arg_1_0.affixActiveController = arg_1_0.itemaffixcardControllerexcollection_:GetController("active")
	arg_1_0.rollController = arg_1_0.shashwatui_3_6_kalifistuiControllerexcollection_:GetController("rollState")
end

function var_0_0.IndexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetData(arg_2_0.pointlist[arg_2_1])
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.UIName(arg_5_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kaliFistUI"
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_confirmBtn_, nil, function()
		if SpKaliTool.IsHaveRolled(arg_6_0.activityID) then
			JumpTools.OpenPageByJump("/SpKaliChallenge", {
				activityID_ = arg_6_0.activityID
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.clickBtn_, nil, function()
		if arg_6_0.isInAnimation then
			return
		end

		local var_8_0 = GameSetting.activity_kali_cost_item.value[1]
		local var_8_1 = ItemTools.getItemNum(var_8_0)
		local var_8_2 = GameSetting.activity_kali_cost_item.value[2]

		if arg_6_0.isFree then
			arg_6_0.effectID = false

			arg_6_0.imgBublleController:SetSelectedState("state1")
			arg_6_0.rollController:SetSelectedState("hide")
			SPKaliChallengeAction.RollAffix(arg_6_0.activityID)
			manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_FREE_ROLL, 0)

			arg_6_0.isInAnimation = true
		else
			if var_8_1 < var_8_2 then
				local var_8_3 = ItemCfg[var_8_0].name

				ShowTips(string.format(GetTips("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH"), var_8_3))

				return
			end

			arg_6_0.imgBublleController:SetSelectedState("state1")
			arg_6_0.rollController:SetSelectedState("hide")

			arg_6_0.effectID = false

			SPKaliChallengeAction.RollAffix(arg_6_0.activityID)

			arg_6_0.isInAnimation = true
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnlookBtn_, nil, function()
		arg_6_0:SetTips1Show(true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:SetTips1Show(false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.mask2Btn_, nil, function()
		arg_6_0:SetAffixShow(false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.affixrowBtn_, nil, function()
		if SpKaliTool.IsHaveRolled(arg_6_0.activityID) then
			-- block empty
		end
	end)
end

function var_0_0.SetTips1Show(arg_13_0, arg_13_1)
	arg_13_0.tipsDesController:SetSelectedState(arg_13_1 and "show" or "hide")
end

function var_0_0.SetAffixShow(arg_14_0, arg_14_1)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.gameobjectTrs_)
	end, {})
	arg_14_0.affixDesController:SetSelectedState(arg_14_1 and "show" or "hide")
end

function var_0_0.UpdateData(arg_16_0, arg_16_1)
	arg_16_0.pointlist = SPKaliChallengeData:GetShowPointList(arg_16_1) or {}
end

function var_0_0.RefreshStageList(arg_17_0)
	arg_17_0.stageList_:StartScroll(#arg_17_0.pointlist)
end

function var_0_0.StartRollAction(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {
		58.5,
		150.5,
		242.5,
		334.5,
		426.5
	}

	if arg_18_0.timelist == nil then
		arg_18_0.timelist = {}
	end

	if arg_18_0.tweenList == nil then
		arg_18_0.tweenList = {}
	end

	if arg_18_0.timelist[arg_18_1.name] == nil then
		arg_18_0.timelist[arg_18_1.name] = {
			index = 1,
			timeScale = 1
		}
	end

	arg_18_0.timelist[arg_18_1.name].index = 1
	arg_18_0.timelist[arg_18_1.name].timeScale = 1

	if arg_18_0.timelist[arg_18_1.name].time then
		arg_18_0.timelist[arg_18_1.name].time:Stop()
	end

	arg_18_0.timelist[arg_18_1.name].time = Timer.New(function()
		arg_18_0.timelist[arg_18_1.name].timeScale = arg_18_0.timelist[arg_18_1.name].timeScale - 1

		if arg_18_0.timelist[arg_18_1.name].timeScale == 0 then
			local var_19_0 = arg_18_1.childCount

			for iter_19_0 = 0, var_19_0 - 1 do
				local var_19_1 = arg_18_1:GetChild(iter_19_0)
				local var_19_2 = iter_19_0 + 1 + arg_18_0.timelist[arg_18_1.name].index
				local var_19_3 = var_19_2 % #var_18_0 == 0 and #var_18_0 or var_19_2 % #var_18_0
				local var_19_4 = var_18_0[var_19_3]
				local var_19_5 = LeanTween.moveLocalX(var_19_1.gameObject, var_19_4, 0.04)

				if var_19_3 == 0 or var_19_3 == 5 then
					var_19_1.gameObject:SetActive(false)
				else
					var_19_1.gameObject:SetActive(true)
				end

				table.insert(arg_18_0.tweenList, var_19_5)
			end

			arg_18_0.timelist[arg_18_1.name].index = arg_18_0.timelist[arg_18_1.name].index + 1
		end

		if arg_18_0.timelist[arg_18_1.name].index < 20 and arg_18_0.timelist[arg_18_1.name].timeScale == 0 then
			arg_18_0.timelist[arg_18_1.name].timeScale = 1
		elseif arg_18_0.timelist[arg_18_1.name].index <= 25 and arg_18_0.timelist[arg_18_1.name].timeScale <= 0 then
			arg_18_0.timelist[arg_18_1.name].timeScale = 2
		elseif arg_18_0.timelist[arg_18_1.name].index <= 30 and arg_18_0.timelist[arg_18_1.name].timeScale <= 0 then
			arg_18_0.timelist[arg_18_1.name].time:Stop()

			local var_19_6 = arg_18_1.childCount

			arg_18_0.affixrowAni_:Play("UI_icons_cx")

			for iter_19_1 = 0, var_19_6 - 1 do
				local var_19_7 = arg_18_1:GetChild(iter_19_1)
				local var_19_8 = iter_19_1 + 1
				local var_19_9 = var_18_0[iter_19_1 + 1]

				var_19_7.transform.localPosition = Vector3.New(var_19_9, -50, 0)

				if var_19_8 == 0 or var_19_8 == 5 then
					var_19_7.gameObject:SetActive(false)
				else
					var_19_7.gameObject:SetActive(true)
				end
			end
		end
	end, 0.02, -1)

	arg_18_0.timelist[arg_18_1.name].time:Start()
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.gameoverGo_:SetActive(false)

	arg_20_0.activityID = arg_20_0.params_ and arg_20_0.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_FIGHT

	var_0_0.super.OnEnter(arg_20_0)
	arg_20_0.rootAni_:Play("UI_root_fd")
	arg_20_0.imgBublleController:SetSelectedState("state1")
	arg_20_0:RefreshAffixDes()
	arg_20_0.affixrowAni_:Play("UI_icons_Idle")
	arg_20_0:RegistEventListener(ACTIVITY_KALI_INFO, function()
		arg_20_0:RefreshAffixDes()
		arg_20_0.imgBossConfirmController:SetSelectedState("state0")
		AnimatorTools.PlayAnimationWithCallback(arg_20_0.rootAni2_, "UI_fistTarget_cx", function()
			return
		end)

		if arg_20_0.effectID then
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_roll_plus")
		else
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_roll_normal")
		end

		arg_20_0.affixrowAni_:Play("UI_icons_Idle")
		arg_20_0:StartRollAction(arg_20_0.content1Trs_)
		arg_20_0:StartRollAction(arg_20_0.content2Trs_)
		arg_20_0:StartRollAction(arg_20_0.contentTrs_)

		arg_20_0.timer2 = TimeTools.StartAfterSeconds(0.5, function()
			arg_20_0.imgBossConfirmController:SetSelectedState("state1")
		end, {})
		arg_20_0.timer = TimeTools.StartAfterSeconds(1.5, function()
			if arg_20_0.effectID then
				arg_20_0.gameoverGo_:SetActive(true)
			end

			arg_20_0.rollController:SetSelectedState("show")
			arg_20_0.imgBublleController:SetSelectedState(arg_20_0.isRolled and "state0" or "state1")
			arg_20_0.rootAni2_:Play("idel")

			arg_20_0.isInAnimation = false
		end, {})

		AnimatorTools.PlayAnimationWithCallback(arg_20_0.gameoverAni_, "UI_Game over_cx", function()
			arg_20_0.gameoverGo_:SetActive(false)
		end)
	end)

	arg_20_0.messagetextText_.text = GetTips("ACTIVITY_KALI_LUCK_DES_TIP")
	arg_20_0.iconresImg_.sprite = ItemTools.getItemLittleSprite(GameSetting.activity_kali_cost_item.value[1])

	arg_20_0:ShowAffixBox(0.5)
	arg_20_0.rollController:SetSelectedState("show")
end

function var_0_0.ShowAffixBox(arg_26_0, arg_26_1)
	if arg_26_0.timer1 then
		arg_26_0.timer1:Stop()

		arg_26_0.timer1 = nil
	end

	arg_26_0.timer1 = TimeTools.StartAfterSeconds(arg_26_1 or 0.5, function()
		arg_26_0.imgBublleController:SetSelectedState(arg_26_0.isRolled and "state0" or "state1")
	end, {})
end

function var_0_0.OnTop(arg_28_0)
	arg_28_0:ChangeBar()

	arg_28_0.isInAnimation = false
end

function var_0_0.GetPlayBackwardsAnimator(arg_29_0)
	return {
		{
			arg_29_0.rootAni_,
			"UI_root_sx",
			false
		}
	}, handler(arg_29_0, arg_29_0.PlayBackwardsAnimatorFun)
end

function var_0_0.PlayBackwardsAnimatorFun(arg_30_0)
	manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_roll_close")
end

function var_0_0.OnExit(arg_31_0)
	var_0_0.super.OnExit(arg_31_0)

	if arg_31_0.timer then
		arg_31_0.timer:Stop()

		arg_31_0.timer = nil
	end

	if arg_31_0.timer1 then
		arg_31_0.timer1:Stop()

		arg_31_0.timer1 = nil
	end

	if arg_31_0.timer2 then
		arg_31_0.timer2:Stop()

		arg_31_0.timer2 = nil
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0.timelist or {}) do
		if iter_31_1 and iter_31_1.time then
			iter_31_1.time:Stop()
		end
	end

	AnimatorTools.Stop()
end

function var_0_0.ChangeBar(arg_32_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		SpKaliConst.ItemConst.coinID2
	})
	manager.windowBar:SetBarCanClick(SpKaliConst.ItemConst.coinID2, true)
end

function var_0_0.RefreshAffixDes(arg_33_0)
	local var_33_0 = SPKaliChallengeData:GetSPChallengeData(arg_33_0.activityID)

	arg_33_0.luckvalueText_.text = string.format(GetTips("ACTIVITY_KALI_LUCK_DES"), var_33_0 and var_33_0.lucky or 0, GameSetting.activity_kali_lucky_Max.value[1])

	local var_33_1 = SPKaliChallengeData:GetKaliAffix(arg_33_0.activityID)

	if var_33_0 and var_33_0.free == 1 then
		arg_33_0.textcostnumText_.text = GetTips("ACTIVITY_KALI_DESC_4")
	else
		arg_33_0.textcostnumText_.text = SpKaliTool.GetRollCostDes()
	end

	arg_33_0.isFree = var_33_0 and var_33_0.free == 1

	for iter_33_0 = 1, 3 do
		if ActivityAffixPoolCfg[var_33_1[iter_33_0]] then
			local var_33_2 = SpKaliTool.GetAffixID(var_33_1[iter_33_0])

			arg_33_0["iconaffix" .. iter_33_0 .. "Img_"].sprite = getAffixSprite(ActivityAffixPoolCfg[var_33_1[iter_33_0]].affix)
			arg_33_0["titletext" .. iter_33_0 .. "Text_"].text = ActivityAffixPoolCfg[var_33_1[iter_33_0]].name
			arg_33_0["messagetext" .. iter_33_0 .. "Text_"].text = getAffixDesc(ActivityAffixPoolCfg[var_33_1[iter_33_0]].affix)
		end
	end

	local var_33_3 = SPKaliChallengeData:GetNowAffixEffect(arg_33_0.activityID)

	arg_33_0.isRolled = SpKaliTool.IsHaveRolled(arg_33_0.activityID)

	arg_33_0.btnConfirmController:SetSelectedState(arg_33_0.isRolled and "active" or "unactive")

	if var_33_3 then
		arg_33_0.effectID = true

		local var_33_4 = ActivitykaliaffixCfg[var_33_3].affix_id

		if ActivityAffixPoolCfg[var_33_4] then
			arg_33_0.textaffixeffectText_.text = getAffixDesc(ActivityAffixPoolCfg[var_33_4].affix)
			arg_33_0.textaffixnameText_.text = ActivityAffixPoolCfg[var_33_4].name
			arg_33_0.iconaffix_lImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[var_33_4].affix)

			arg_33_0.affixActiveController:SetSelectedState("active")
		else
			arg_33_0.affixActiveController:SetSelectedState("unactive")
		end
	else
		arg_33_0.affixActiveController:SetSelectedState("unactive")
	end
end

function var_0_0.Dispose(arg_34_0)
	var_0_0.super.Dispose(arg_34_0)
	var_0_0.super.Dispose(arg_34_0)
end

return var_0_0
