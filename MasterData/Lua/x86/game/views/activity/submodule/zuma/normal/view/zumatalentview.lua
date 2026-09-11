local ZumaTalentView = class("ZumaTalentView", ReduxView)

function ZumaTalentView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaTalentUI"
end

function ZumaTalentView:UIParent()
	return manager.ui.uiMain.transform
end

function ZumaTalentView:Init()
	self.selectTalentID = 0

	self:InitUI()
end

function ZumaTalentView:InitUI()
	self:BindCfgUI()

	self.leftRootTrsCanvas = self.leftRootTrs_:GetComponent(typeof(CanvasGroup))
	self.middleBeginPos = self.middleTrs_.anchoredPosition
	self.talentInfoView = ZumaTalentInfoView.New(self.chaptersectioninfouiGo_)

	self:InitTreeList()
	self:AddBtnListener(self.resetbtnBtn_, nil, function()
		self:OnResetBtn()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:RefreshZumaTalentSelectInfo()
	end)
	self:AddBtnListener(self.currencyBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			ZumaConst.TalentCostID
		})
	end)

	self.tokeniconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	self.tokenImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function ZumaTalentView:OnResetBtn()
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

function ZumaTalentView:RefreshZumaTalentSelectInfo(arg_11_1)
	if arg_11_1 then
		if arg_11_1 == self.selectTalentID then
			return
		end

		if self.selectTalentID then
			self:UpdateTalentItemSelect(self.selectTalentID, false)
		end

		self.selectTalentID = arg_11_1

		self.talentInfoView:RefreshTalentInfoUi(arg_11_1)
		self:UpdateTalentItemSelect(self.selectTalentID, true)
		self:ShowInfoAni(true)

		self.leftRootTrsCanvas.blocksRaycasts = false
	else
		if self.selectTalentID then
			self:UpdateTalentItemSelect(self.selectTalentID, false)
		end

		self.selectTalentID = nil

		self:ShowInfoAni(false)

		self.leftRootTrsCanvas.blocksRaycasts = true
	end
end

function ZumaTalentView:ShowInfoAni(arg_12_1)
	SetActive(self.rootGo_, arg_12_1)
	self:RemoveTween()

	self.tween_ = LeanTween.value(self.middleTrs_.gameObject, self.middleTrs_.anchoredPosition, (arg_12_1 == false or nil) and Vector2(self.middleBeginPos.x + 200, 0), 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
		self.middleTrs_.anchoredPosition = Vector2(arg_13_0, 0)
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function ZumaTalentView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ZumaTalentView:RefreshZumaTalentView(arg_16_1)
	if arg_16_1 then
		self:UpdateTalentList(arg_16_1)
		self.talentInfoView:RefreshTalentInfoUi(self.selectTalentID)
		self:UpdateCurrencyShow()
	else
		self:UpdateTalentList()
		self:RefreshZumaTalentSelectInfo()
		self:UpdateCurrencyShow()
	end
end

function ZumaTalentView:UpdateTalentItemSelect(arg_17_1, arg_17_2)
	if self.talentList[self.talentIDToIndex[arg_17_1]] then
		self.talentList[self.talentIDToIndex[arg_17_1]]:RefreshSelectState(arg_17_2)
	end
end

function ZumaTalentView:InitTreeList()
	self.talentTreeList = ZumaData:GetTalentTreeCfg()
	self.treeResList = {
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
	self.talentIDToIndex = {}
	self.talentTreePosList = {}

	self:InitTreeItemPos(0, 0)

	self.talentList = {}

	for iter_18_0, iter_18_1 in pairs(self.talentTreePosList) do
		local var_18_0, var_18_1 = self:CreateTalentItem(iter_18_0)

		self.talentList[iter_18_0] = ZumaTalentItem.New(var_18_0, var_18_1, iter_18_1)
		self.talentIDToIndex[iter_18_1] = iter_18_0
	end

	self:DefaultSelectTalent()
end

function ZumaTalentView:DefaultSelectTalent()
	self:RefreshZumaTalentSelectInfo()
end

function ZumaTalentView:InitTreeItemPos(arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in pairs(self.treeResList[arg_20_1] or {}) do
		self:InitTreeItemPos(iter_20_1, self.talentTreeList[arg_20_2][iter_20_0])
	end

	if targetIndex == 0 or arg_20_2 == 0 then
		return
	end

	self.talentTreePosList[arg_20_1] = arg_20_2
end

function ZumaTalentView:CreateTalentItem(arg_21_1)
	local var_21_0 = self.easystageTrs_:GetChild(arg_21_1 - 1)

	return var_21_0:GetChild(0).gameObject, (var_21_0:GetChild(1))
end

function ZumaTalentView:UpdateTalentList(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self.talentList) do
		if arg_22_1 then
			if iter_22_1 and iter_22_1:GetTalentID() and iter_22_1:GetTalentID() == arg_22_1 then
				iter_22_1:RefreshTalentState()
			end
		else
			iter_22_1:RefreshTalentState()
		end
	end
end

function ZumaTalentView:UpdateCurrencyShow()
	self.currencyTxt_.text = ZumaData:GetZumaCoin()
end

function ZumaTalentView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ZumaTalentView:OnEnter()
	self:UpdateTalentList()
	self:UpdateCurrencyShow()
end

function ZumaTalentView:OnExit()
	ZumaData:SetTalentReadList()
end

function ZumaTalentView:Dispose()
	self:RemoveTween()

	for iter_27_0, iter_27_1 in pairs(self.talentList) do
		iter_27_1:Dispose()
	end

	self.talentInfoView:Dispose()
	ZumaTalentView.super.Dispose(self)
end

function ZumaTalentView:Cacheable()
	return false
end

return ZumaTalentView
