local SpringFestivalZumaTalentView = class("SpringFestivalZumaTalentView", ReduxView)

function SpringFestivalZumaTalentView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaTalentUI"
end

function SpringFestivalZumaTalentView:UIParent()
	return manager.ui.uiMain.transform
end

function SpringFestivalZumaTalentView:Init()
	self:InitUI()
end

function SpringFestivalZumaTalentView:InitUI()
	self:BindCfgUI()

	self.middleBeginPos = self.middleTrs_.anchoredPosition

	local var_4_0 = handler(self, self.ClickSkillItem)

	self.talentGroupList = {}

	for iter_4_0, iter_4_1 in pairs((ZumaData:GetSkillBaseTalentIDList())) do
		local var_4_1 = self[string.format("groupGo%s_", iter_4_0)]

		if var_4_1 then
			self.talentGroupList[iter_4_0] = SpringFestivalZumaGroupItem.New(var_4_1, iter_4_1)

			self.talentGroupList[iter_4_0]:SetClickCallBack(var_4_0)
		end
	end

	self.talentInfo = SpringFestivalZumaTalentInfoView.New(self.talentInfoObj_)

	self:AddBtnListener(self.resetbtnBtn_, nil, function()
		self:OnResetBtn()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:RefreshZumaTalentSelectInfo()
	end)
	self:AddBtnListener(self.currencyBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			isHideNum_ = true,
			id = ZumaConst.TalentCostID
		})
	end)

	self.specialTalent = SpringFestivalBuffItem.New(self.specialGo_, ZumaData:GetFinallyTalentID())

	self.specialTalent:SetClickCallBack(var_4_0)

	self.tokeniconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	self.tokenImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	self.resetStateController = self.controller_:GetController("resetState")
end

function SpringFestivalZumaTalentView:OnResetBtn()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_3_11_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	if self:GetIsShowNoReset() then
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

function SpringFestivalZumaTalentView:ClickSkillItem(arg_11_1)
	self:RefreshZumaTalentSelectInfo(arg_11_1)
end

function SpringFestivalZumaTalentView:RefreshZumaTalentSelectInfo(arg_12_1)
	if arg_12_1 then
		if arg_12_1 == self.selectTalentID then
			return
		end

		if self.selectTalentID then
			self:UpdateTalentItemSelect(self.selectTalentID, false)
		end

		self.selectTalentID = arg_12_1

		self.talentInfo:RefreshTalentInfoUI(arg_12_1)
		self:UpdateTalentItemSelect(self.selectTalentID, true)
		self:ShowInfoAni(true)
	else
		if self.selectTalentID then
			self:UpdateTalentItemSelect(self.selectTalentID, false)
		end

		self.selectTalentID = nil

		self:ShowInfoAni(false)
	end
end

function SpringFestivalZumaTalentView:ShowInfoAni(arg_13_1)
	SetActive(self.talentInfoObj_, arg_13_1)
	self:RemoveTween()

	self.tween_ = LeanTween.value(self.middleTrs_.gameObject, self.middleTrs_.anchoredPosition, (arg_13_1 == true or nil) and Vector2(self.middleBeginPos.x - 200, 0), 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
		self.middleTrs_.anchoredPosition = Vector2(arg_14_0, 0)
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function SpringFestivalZumaTalentView:UpdateTalentItemSelect(arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_1 == self.specialTalent:GetTalentID() then
		var_16_0 = self.specialTalent
	else
		for iter_16_0, iter_16_1 in pairs(self.talentGroupList) do
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

function SpringFestivalZumaTalentView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function SpringFestivalZumaTalentView:GetIsShowNoReset()
	local var_18_0 = true

	for iter_18_0, iter_18_1 in pairs(ZumaData:GetTalentList() or {}) do
		if iter_18_0 ~= 2002 and iter_18_1 == true then
			var_18_0 = false
		end
	end

	return var_18_0
end

function SpringFestivalZumaTalentView:RefreshGroupView()
	for iter_19_0, iter_19_1 in pairs(self.talentGroupList) do
		iter_19_1:RefreshUI()
	end

	self.specialTalent:RefreshUI()

	local var_19_0 = ZumaData:GetTalentList()

	if self:GetIsShowNoReset() then
		self.resetStateController:SetSelectedState("noReset")
	else
		self.resetStateController:SetSelectedState("canReset")
	end
end

function SpringFestivalZumaTalentView:PlayTalentUnLockAni(arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in pairs(self.talentGroupList) do
		var_20_0 = iter_20_1:GetTargetTalentItem(arg_20_1)

		if var_20_0 then
			break
		end
	end

	if var_20_0 then
		var_20_0:PlayUnLockAni()
	end
end

function SpringFestivalZumaTalentView:RefreshZumaTalentView(arg_21_1)
	if arg_21_1 and self.selectTalentID then
		self.talentInfo:RefreshTalentInfoUI(self.selectTalentID)
		self:RefreshGroupView()
		self:UpdateCurrencyShow()
		self:PlayTalentUnLockAni(arg_21_1)
	else
		self:RefreshZumaTalentSelectInfo()
		self:RefreshGroupView()
		self:UpdateCurrencyShow()
	end
end

function SpringFestivalZumaTalentView:UpdateCurrencyShow()
	self.currencyTxt_.text = ZumaData:GetZumaCoin()
end

function SpringFestivalZumaTalentView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SpringFestivalZumaTalentView:OnEnter()
	self:RefreshGroupView()
	self:UpdateCurrencyShow()
end

function SpringFestivalZumaTalentView:OnExit()
	ZumaData:SetTalentReadList()
end

function SpringFestivalZumaTalentView:Dispose()
	self:RemoveTween()

	for iter_26_0, iter_26_1 in pairs(self.talentGroupList) do
		if iter_26_1 then
			iter_26_1:Dispose()
		end
	end

	if self.talentInfo then
		self.talentInfo:Dispose()

		self.talentInfo = nil
	end

	if self.specialTalent then
		self.specialTalent:Dispose()
	end

	SpringFestivalZumaTalentView.super.Dispose(self)
end

return SpringFestivalZumaTalentView
