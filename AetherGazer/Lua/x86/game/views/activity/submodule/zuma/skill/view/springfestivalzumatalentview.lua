local var_0_0 = class("SpringFestivalZumaTalentView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaTalentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.middleBeginPos = arg_4_0.middleTrs_.anchoredPosition

	local var_4_0 = handler(arg_4_0, arg_4_0.ClickSkillItem)

	arg_4_0.talentGroupList = {}

	local var_4_1 = ZumaData:GetSkillBaseTalentIDList()

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		local var_4_2 = arg_4_0[string.format("groupGo%s_", iter_4_0)]

		if var_4_2 then
			arg_4_0.talentGroupList[iter_4_0] = SpringFestivalZumaGroupItem.New(var_4_2, iter_4_1)

			arg_4_0.talentGroupList[iter_4_0]:SetClickCallBack(var_4_0)
		end
	end

	arg_4_0.talentInfo = SpringFestivalZumaTalentInfoView.New(arg_4_0.talentInfoObj_)

	arg_4_0:AddBtnListener(arg_4_0.resetbtnBtn_, nil, function()
		arg_4_0:OnResetBtn()
	end)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:RefreshZumaTalentSelectInfo()
	end)
	arg_4_0:AddBtnListener(arg_4_0.currencyBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			isHideNum_ = true,
			id = ZumaConst.TalentCostID
		})
	end)

	arg_4_0.specialTalent = SpringFestivalBuffItem.New(arg_4_0.specialGo_, ZumaData:GetFinallyTalentID())

	arg_4_0.specialTalent:SetClickCallBack(var_4_0)

	arg_4_0.tokeniconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	arg_4_0.tokenImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	arg_4_0.resetStateController = arg_4_0.controller_:GetController("resetState")
end

function var_0_0.OnResetBtn(arg_8_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_3_11_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	if arg_8_0:GetIsShowNoReset() then
		ShowTips("ACTIVITY_ZUMA_TALENT_RESET_EMPTY")

		return
	end

	JumpTools.OpenPageByJump("springFestivalZumaTipsView", {
		textContent = GetTips("ACTIVITY_ZUMA_TALENT_RESET"),
		titleContent = GetTips("ACTIVITY_ZUMA_TALENT_RESET_TITLE"),
		sureCallback = function()
			ZumaAction.ResetZumaTalent()
			JumpTools.Back()
		end,
		cancelCallback = function()
			JumpTools.Back()
		end
	})
end

function var_0_0.ClickSkillItem(arg_11_0, arg_11_1)
	arg_11_0:RefreshZumaTalentSelectInfo(arg_11_1)
end

function var_0_0.RefreshZumaTalentSelectInfo(arg_12_0, arg_12_1)
	if arg_12_1 then
		if arg_12_1 == arg_12_0.selectTalentID then
			return
		end

		if arg_12_0.selectTalentID then
			arg_12_0:UpdateTalentItemSelect(arg_12_0.selectTalentID, false)
		end

		arg_12_0.selectTalentID = arg_12_1

		arg_12_0.talentInfo:RefreshTalentInfoUI(arg_12_1)
		arg_12_0:UpdateTalentItemSelect(arg_12_0.selectTalentID, true)
		arg_12_0:ShowInfoAni(true)
	else
		if arg_12_0.selectTalentID then
			arg_12_0:UpdateTalentItemSelect(arg_12_0.selectTalentID, false)
		end

		arg_12_0.selectTalentID = nil

		arg_12_0:ShowInfoAni(false)
	end
end

function var_0_0.ShowInfoAni(arg_13_0, arg_13_1)
	SetActive(arg_13_0.talentInfoObj_, arg_13_1)
	arg_13_0:RemoveTween()

	local var_13_0 = arg_13_0.middleTrs_.anchoredPosition
	local var_13_1 = arg_13_0.middleBeginPos

	if arg_13_1 == true then
		var_13_1 = Vector2(arg_13_0.middleBeginPos.x - 200, 0)
	end

	arg_13_0.tween_ = LeanTween.value(arg_13_0.middleTrs_.gameObject, var_13_0, var_13_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
		arg_13_0.middleTrs_.anchoredPosition = Vector2(arg_14_0, 0)
	end)):setOnComplete(System.Action(function()
		arg_13_0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function var_0_0.UpdateTalentItemSelect(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_1 == arg_16_0.specialTalent:GetTalentID() then
		var_16_0 = arg_16_0.specialTalent
	else
		for iter_16_0, iter_16_1 in pairs(arg_16_0.talentGroupList) do
			var_16_0 = iter_16_1:GetTargetTalentItem(arg_16_1)

			if var_16_0 then
				break
			end
		end
	end

	if var_16_0 then
		var_16_0:UpdateSelectState(arg_16_2)
	end
end

function var_0_0.RemoveTween(arg_17_0)
	if arg_17_0.tween_ then
		arg_17_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_17_0.tween_.id)

		arg_17_0.tween_ = nil
	end
end

function var_0_0.GetIsShowNoReset(arg_18_0)
	local var_18_0 = true

	for iter_18_0, iter_18_1 in pairs(ZumaData:GetTalentList() or {}) do
		if iter_18_0 ~= 2002 and iter_18_1 == true then
			var_18_0 = false
		end
	end

	return var_18_0
end

function var_0_0.RefreshGroupView(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.talentGroupList) do
		iter_19_1:RefreshUI()
	end

	arg_19_0.specialTalent:RefreshUI()

	local var_19_0 = ZumaData:GetTalentList()

	if arg_19_0:GetIsShowNoReset() then
		arg_19_0.resetStateController:SetSelectedState("noReset")
	else
		arg_19_0.resetStateController:SetSelectedState("canReset")
	end
end

function var_0_0.PlayTalentUnLockAni(arg_20_0, arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.talentGroupList) do
		var_20_0 = iter_20_1:GetTargetTalentItem(arg_20_1)

		if var_20_0 then
			break
		end
	end

	if var_20_0 then
		var_20_0:PlayUnLockAni()
	end
end

function var_0_0.RefreshZumaTalentView(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_0.selectTalentID then
		arg_21_0.talentInfo:RefreshTalentInfoUI(arg_21_0.selectTalentID)
		arg_21_0:RefreshGroupView()
		arg_21_0:UpdateCurrencyShow()
		arg_21_0:PlayTalentUnLockAni(arg_21_1)
	else
		arg_21_0:RefreshZumaTalentSelectInfo()
		arg_21_0:RefreshGroupView()
		arg_21_0:UpdateCurrencyShow()
	end
end

function var_0_0.UpdateCurrencyShow(arg_22_0)
	arg_22_0.currencyTxt_.text = ZumaData:GetZumaCoin()
end

function var_0_0.OnTop(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0:RefreshGroupView()
	arg_24_0:UpdateCurrencyShow()
end

function var_0_0.OnExit(arg_25_0)
	ZumaData:SetTalentReadList()
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:RemoveTween()

	for iter_26_0, iter_26_1 in pairs(arg_26_0.talentGroupList) do
		if iter_26_1 then
			iter_26_1:Dispose()
		end
	end

	if arg_26_0.talentInfo then
		arg_26_0.talentInfo:Dispose()

		arg_26_0.talentInfo = nil
	end

	if arg_26_0.specialTalent then
		arg_26_0.specialTalent:Dispose()
	end

	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
