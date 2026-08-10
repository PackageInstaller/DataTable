local var_0_0 = class("ZumaTalentView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaTalentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectTalentID = 0

	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.leftRootTrsCanvas = arg_4_0.leftRootTrs_:GetComponent(typeof(CanvasGroup))
	arg_4_0.middleBeginPos = arg_4_0.middleTrs_.anchoredPosition
	arg_4_0.talentInfoView = ZumaTalentInfoView.New(arg_4_0.chaptersectioninfouiGo_)

	arg_4_0:InitTreeList()
	arg_4_0:AddBtnListener(arg_4_0.resetbtnBtn_, nil, function()
		arg_4_0:OnResetBtn()
	end)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:RefreshZumaTalentSelectInfo()
	end)
	arg_4_0:AddBtnListener(arg_4_0.currencyBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			ZumaConst.TalentCostID
		})
	end)

	arg_4_0.tokeniconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	arg_4_0.tokenImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function var_0_0.OnResetBtn(arg_8_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	local var_8_0 = ZumaData:GetTalentList()

	if not var_8_0 or not next(var_8_0) then
		ShowTips("ACTIVITY_ZUMA_TALENT_RESET_EMPTY")

		return
	end

	JumpTools.OpenPageByJump("ZumaTips", {
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

function var_0_0.RefreshZumaTalentSelectInfo(arg_11_0, arg_11_1)
	if arg_11_1 then
		if arg_11_1 == arg_11_0.selectTalentID then
			return
		end

		if arg_11_0.selectTalentID then
			arg_11_0:UpdateTalentItemSelect(arg_11_0.selectTalentID, false)
		end

		arg_11_0.selectTalentID = arg_11_1

		arg_11_0.talentInfoView:RefreshTalentInfoUi(arg_11_1)
		arg_11_0:UpdateTalentItemSelect(arg_11_0.selectTalentID, true)
		arg_11_0:ShowInfoAni(true)

		arg_11_0.leftRootTrsCanvas.blocksRaycasts = false
	else
		if arg_11_0.selectTalentID then
			arg_11_0:UpdateTalentItemSelect(arg_11_0.selectTalentID, false)
		end

		arg_11_0.selectTalentID = nil

		arg_11_0:ShowInfoAni(false)

		arg_11_0.leftRootTrsCanvas.blocksRaycasts = true
	end
end

function var_0_0.ShowInfoAni(arg_12_0, arg_12_1)
	SetActive(arg_12_0.rootGo_, arg_12_1)
	arg_12_0:RemoveTween()

	local var_12_0 = arg_12_0.middleTrs_.anchoredPosition
	local var_12_1 = arg_12_0.middleBeginPos

	if arg_12_1 == false then
		var_12_1 = Vector2(arg_12_0.middleBeginPos.x + 200, 0)
	end

	arg_12_0.tween_ = LeanTween.value(arg_12_0.middleTrs_.gameObject, var_12_0, var_12_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
		arg_12_0.middleTrs_.anchoredPosition = Vector2(arg_13_0, 0)
	end)):setOnComplete(System.Action(function()
		arg_12_0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function var_0_0.RemoveTween(arg_15_0)
	if arg_15_0.tween_ then
		arg_15_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_15_0.tween_.id)

		arg_15_0.tween_ = nil
	end
end

function var_0_0.RefreshZumaTalentView(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0:UpdateTalentList(arg_16_1)
		arg_16_0.talentInfoView:RefreshTalentInfoUi(arg_16_0.selectTalentID)
		arg_16_0:UpdateCurrencyShow()
	else
		arg_16_0:UpdateTalentList()
		arg_16_0:RefreshZumaTalentSelectInfo()
		arg_16_0:UpdateCurrencyShow()
	end
end

function var_0_0.UpdateTalentItemSelect(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.talentIDToIndex[arg_17_1]
	local var_17_1 = arg_17_0.talentList[var_17_0]

	if var_17_1 then
		var_17_1:RefreshSelectState(arg_17_2)
	end
end

function var_0_0.InitTreeList(arg_18_0)
	arg_18_0.talentTreeList = ZumaData:GetTalentTreeCfg()
	arg_18_0.treeResList = {
		[0] = {
			1
		},
		{
			3,
			2,
			4
		},
		{
			5
		},
		{
			6
		},
		{
			7
		},
		{
			8
		},
		{
			9
		},
		{
			10
		}
	}
	arg_18_0.talentIDToIndex = {}
	arg_18_0.talentTreePosList = {}

	arg_18_0:InitTreeItemPos(0, 0)

	arg_18_0.talentList = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0.talentTreePosList) do
		local var_18_0, var_18_1 = arg_18_0:CreateTalentItem(iter_18_0)

		arg_18_0.talentList[iter_18_0] = ZumaTalentItem.New(var_18_0, var_18_1, iter_18_1)
		arg_18_0.talentIDToIndex[iter_18_1] = iter_18_0
	end

	arg_18_0:DefaultSelectTalent()
end

function var_0_0.DefaultSelectTalent(arg_19_0)
	arg_19_0:RefreshZumaTalentSelectInfo()
end

function var_0_0.InitTreeItemPos(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.treeResList[arg_20_1]
	local var_20_1 = arg_20_0.talentTreeList[arg_20_2]

	for iter_20_0, iter_20_1 in pairs(var_20_0 or {}) do
		arg_20_0:InitTreeItemPos(iter_20_1, var_20_1[iter_20_0])
	end

	if targetIndex == 0 or arg_20_2 == 0 then
		return
	end

	arg_20_0.talentTreePosList[arg_20_1] = arg_20_2
end

function var_0_0.CreateTalentItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.easystageTrs_:GetChild(arg_21_1 - 1)
	local var_21_1 = var_21_0:GetChild(0).gameObject
	local var_21_2 = var_21_0:GetChild(1)

	return var_21_1, var_21_2
end

function var_0_0.UpdateTalentList(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.talentList) do
		if arg_22_1 then
			if iter_22_1 and iter_22_1:GetTalentID() and iter_22_1:GetTalentID() == arg_22_1 then
				iter_22_1:RefreshTalentState()
			end
		else
			iter_22_1:RefreshTalentState()
		end
	end
end

function var_0_0.UpdateCurrencyShow(arg_23_0)
	arg_23_0.currencyTxt_.text = ZumaData:GetZumaCoin()
end

function var_0_0.OnTop(arg_24_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_25_0)
	arg_25_0:UpdateTalentList()
	arg_25_0:UpdateCurrencyShow()
end

function var_0_0.OnExit(arg_26_0)
	ZumaData:SetTalentReadList()
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:RemoveTween()

	for iter_27_0, iter_27_1 in pairs(arg_27_0.talentList) do
		iter_27_1:Dispose()
	end

	arg_27_0.talentInfoView:Dispose()
	var_0_0.super.Dispose(arg_27_0)
end

function var_0_0.Cacheable(arg_28_0)
	return false
end

return var_0_0
