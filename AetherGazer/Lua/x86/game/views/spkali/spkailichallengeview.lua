local var_0_0 = class("SPKailiChallengeView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.nodeList = {}

	arg_1_0:AddListeners()

	arg_1_0.stageList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uilistUilist_, SpKaliStageItem)
end

function var_0_0.IndexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetData(arg_2_0.pointlist[arg_2_1], arg_2_1, #arg_2_0.pointlist, arg_2_0)
	arg_2_2:SetRcommond(arg_2_0.effectID)
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.UIName(arg_5_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kaliFistLevelUI"
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnlookBtn_, nil, function()
		saveData("SPKALI", "COLLECT_AFFIX", 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_AFFIX, 0)
		arg_6_0:Go("SPKailiChallengeIllustratedView", {
			activityID = arg_6_0.activityID
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.ndaffixBtn_, nil, function()
		JumpTools.OpenPageByJump("SPKailiChallengeRollView", {
			activityID_ = arg_6_0.acitvityID
		})
	end)
end

function var_0_0.UpdateData(arg_9_0, arg_9_1)
	arg_9_0.pointlist = SpKaliTool.GetChanllengeStageData(arg_9_1) or {}
end

function var_0_0.RefreshStageList(arg_10_0)
	local var_10_0 = Vector2.zero

	if SPKaliChallengeData.pos1 then
		var_10_0 = Vector2.New(SPKaliChallengeData.pos1, 0)
	end

	arg_10_0.stageList_:StartScrollByPosition(#arg_10_0.pointlist, var_10_0)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID = arg_11_0.params_ and arg_11_0.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_FIGHT

	arg_11_0:RegistEventListener(ACTIVITY_KALI_INFO, function()
		arg_11_0.effectID = nil

		arg_11_0:RefreshAffixDes()
		arg_11_0:UpdateData(arg_11_0.activityID)
		arg_11_0:RefreshStageList()
	end)
	var_0_0.super.OnEnter(arg_11_0)
	arg_11_0:UpdateData(arg_11_0.activityID)

	local var_11_0 = SPKaliChallengeData:GetSPChallengeData(arg_11_0.activityID)

	arg_11_0:RefreshAffixDes()
	arg_11_0:RefreshStageList()

	if not SpKaliTool.IsHaveRolled(arg_11_0.activityID) and not arg_11_0.isPop then
		arg_11_0.isPop = true

		JumpTools.OpenPageByJump("SPKailiChallengeRollView", {
			activityID_ = fightActivityID
		})
	end

	manager.redPoint:bindUIandKey(arg_11_0.btnlookBtn_.transform, RedPointConst.ACTIVITY_KALI_AFFIX)
	manager.redPoint:bindUIandKey(arg_11_0.ndaffixBtn_.transform, RedPointConst.ACTIVITY_KALI_FREE_ROLL)
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0.uilistSr_.enabled = true

	if arg_13_0.selectIndex then
		local var_13_0 = arg_13_0.stageList_:GetItemByIndex(arg_13_0.selectIndex)

		if var_13_0 then
			var_13_0:SetSelect(false)
		end

		arg_13_0:RefreshStageList()
	end

	arg_13_0.isStopAni = false

	arg_13_0:ChangeBar()
	arg_13_0.imgbubbleAni_:Update(0)
	SetActive(arg_13_0.imgbubbleGo_, arg_13_0.isShowEffect and true or false)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.labelTrs_)
end

function var_0_0.OnBehind(arg_14_0)
	SetActive(arg_14_0.imgbubbleGo_, false)
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)

	if arg_15_0.timer then
		arg_15_0.timer:Stop()

		arg_15_0.timer = nil
	end

	if arg_15_0.timer1 then
		arg_15_0.timer1:Stop()

		arg_15_0.timer1 = nil
	end

	manager.redPoint:unbindUIandKey(arg_15_0.btnlookBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_15_0.ndaffixBtn_.transform)
end

function var_0_0.ChangeBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshAffixDes(arg_17_0)
	local var_17_0 = SPKaliChallengeData:GetKaliAffix(arg_17_0.activityID)

	for iter_17_0 = 1, 3 do
		if ActivityAffixPoolCfg[var_17_0[iter_17_0]] then
			local var_17_1 = SpKaliTool.GetAffixID(var_17_0[iter_17_0])

			arg_17_0["iconaffix" .. iter_17_0 .. "Img_"].sprite = getAffixSprite(ActivityAffixPoolCfg[var_17_0[iter_17_0]].affix)
		end
	end

	local var_17_2 = SPKaliChallengeData:GetNowAffixEffect(arg_17_0.activityID)

	arg_17_0.isShowEffect = var_17_2

	if var_17_2 then
		local var_17_3 = ActivitykaliaffixCfg[var_17_2].affix_id

		if ActivityAffixPoolCfg[var_17_3] then
			arg_17_0.effectID = var_17_3
			arg_17_0.textaffixeffectText_.text = getAffixDesc(ActivityAffixPoolCfg[var_17_3].affix)
			arg_17_0.textaffixnameText_.text = ActivityAffixPoolCfg[var_17_3].name
			arg_17_0.iconaffixImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[var_17_3].affix)

			local var_17_4 = ActivityKaliStageCfg.all
			local var_17_5 = {}

			for iter_17_1, iter_17_2 in ipairs(var_17_4) do
				local var_17_6 = ActivityKaliStageCfg[iter_17_2]
				local var_17_7 = var_17_6 and var_17_6.recommend or {}

				if table.indexof(var_17_7, var_17_3) and not table.indexof(var_17_5, iter_17_2) then
					table.insert(var_17_5, iter_17_2)
				end
			end

			for iter_17_3 = 1, 2 do
				if arg_17_0[string.format("label%sGo_", iter_17_3)] then
					SetActive(arg_17_0[string.format("label%sGo_", iter_17_3)], var_17_5[iter_17_3] and true or false)

					if var_17_5[iter_17_3] then
						arg_17_0[string.format("textaffixname%sText_", iter_17_3)].text = string.format(GetTips("ACTIVITY_KALI_DESC_3"), GetTips("NUM_" .. var_17_5[iter_17_3]))
					end
				end
			end
		end
	end
end

function var_0_0.StopLeanTween(arg_18_0)
	if arg_18_0.moveLeanTween_ then
		arg_18_0.moveLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_18_0.moveLeanTween_.id)

		arg_18_0.moveLeanTween_ = nil
	end
end

function var_0_0.SetSelect(arg_19_0, arg_19_1)
	if arg_19_0.selectIndex then
		local var_19_0 = arg_19_0.stageList_:GetItemByIndex(arg_19_0.selectIndex)

		if var_19_0 then
			var_19_0:SetSelect(false)
		end
	end

	arg_19_0.selectIndex = arg_19_1

	local var_19_1 = arg_19_0.stageList_:GetItemByIndex(arg_19_0.selectIndex)

	if var_19_1 then
		var_19_1:SetSelect(true)
	end

	local var_19_2 = arg_19_0.viewport2Trs_.rect.width
	local var_19_3 = arg_19_0.selectIndex * 500
	local var_19_4 = var_19_3 - var_19_2 / 2

	if arg_19_0.isStopAni then
		var_19_4 = math.min(math.max(var_19_3 - var_19_2 / 2, 0), #arg_19_0.pointlist * 500 - var_19_2 / 2)
		arg_19_0.isStopAni = false
	end

	arg_19_0.moveLeanTween_ = LeanTween.moveLocalX(arg_19_0.contentTrs_.gameObject, -var_19_4, 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		arg_19_0:StopLeanTween()
	end))

	local var_19_5 = (arg_19_0.selectIndex - 1) * 500 - 250
	local var_19_6 = arg_19_0.contentTrs_.sizeDelta.x - var_19_2

	SPKaliChallengeData:SaveChanlengePointPos(Mathf.Clamp(var_19_5 / var_19_6, 0, 1))
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
	arg_21_0.stageList_:Dispose()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
