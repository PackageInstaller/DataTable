local OathDetailsView = class("OathDetailsView", ReduxView)

function OathDetailsView:UIName()
	return "Widget/System/Hero_Oath/OathDetailsView/HeroOathDetailsViewUI"
end

function OathDetailsView:UIParent()
	return manager.ui.uiMain.transform
end

function OathDetailsView:Init()
	self:InitUI()
end

function OathDetailsView:AddListeners()
	self:AddBtnListener(self.changeBtn_, nil, function()
		self:UpdateContentShow(self.selectModeState == self.staticContext.task.state and self.staticContext.detail.state or self.staticContext.task.state)
	end)
	self:AddBtnListener(self.goTaskBtn_, nil, function()
		self:UpdateContentShow(self.staticContext.task.state)
	end)
	self:AddBtnListener(self.closeTaskBtn_, nil, function()
		self:UpdateContentShow(self.staticContext.detail.state)
	end)
end

function OathDetailsView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.modecontroller_ = self.controller_:GetController("mode")
	self.lvInfo_ = OathLvInfo.New(self.lvGo_)
	self.taskContent_ = OathDetailsTaskContent.New(self.taskContentGo_)
	self.collectionContent = OathCollectionContentView.New(self.collectionContentGo_)
	self.staticContext = {
		task = {
			state = "task",
			entity = self.taskContent_
		},
		detail = {
			state = "detail",
			entity = self.collectionContent
		}
	}
end

function OathDetailsView:AddEventListeners()
	self:RegistEventListener(OATH_HERO_LEVEL_UP, handler(self, self.CheckHeroOathLevelUp))
end

function OathDetailsView:CheckHeroOathLevelUp()
	local var_10_0, var_10_1 = OathCollectionContentData:HasNewLevelUpdateMsg(self.selectHeroID)

	if var_10_1 then
		JumpTools.OpenPageByJump("oathLevelUpPop", {
			heroID = var_10_0,
			level = var_10_1
		})
	end
end

function OathDetailsView:GetIsHaveTaskUnFinish()
	local var_11_0, var_11_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, 1)

	if var_11_0 < var_11_1 then
		return true
	else
		local var_11_2, var_11_3 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, 2)

		if var_11_3 > var_11_2 then
			return true
		end
	end

	return false
end

function OathDetailsView:DefaultSelect()
	local var_12_0

	if not gameContext:IsRouteBack() then
		if self.params_ and self.params_.selectModeState then
			var_12_0, self.params_.selectModeState = self.params_.selectModeState
		else
			var_12_0 = self.staticContext.detail.state
		end
	end

	if var_12_0 == nil then
		var_12_0 = self.modecontroller_:GetSelectedState() == "task" and self.staticContext.task.state or self.staticContext.detail.state
	end

	self:UpdateContentShow(var_12_0)
	self:UpdateHeroInfoUI()
end

function OathDetailsView:UpdateContentShow(arg_13_1)
	local var_13_1

	var_13_1, self.selectModeState = self.selectModeState, arg_13_1

	self.modecontroller_:SetSelectedState(arg_13_1)

	for iter_13_0, iter_13_1 in pairs(self.staticContext) do
		if iter_13_1.state == var_13_1 and iter_13_1.entity then
			iter_13_1.entity:OnHide()
		end

		if iter_13_1.state == arg_13_1 and iter_13_1.entity then
			iter_13_1.entity:RefreshUI(self.heroID)
			iter_13_1.entity:OnShow()
		end
	end

	self:RefreshBar()
end

function OathDetailsView:UpdateHeroInfoUI()
	self.nameText_.text = HeroTools.GetHeroName(self.heroID)
end

function OathDetailsView:OnEnter()
	self:AddEventListeners()

	self.heroID = self.params_.heroID

	for iter_15_0, iter_15_1 in pairs(self.staticContext) do
		if iter_15_1.entity and iter_15_1.entity.OnEnter then
			iter_15_1.entity:OnEnter(self.params_)
		end
	end

	self:DefaultSelect()
	self.lvInfo_:SetData(self.heroID)

	self.heroImg_.sprite = OathTools.GetOathCharacterSprite(self.heroID)

	self:CheckHeroOathLevelUp()
	manager.redPoint:bindUIandKey(self.goTaskBtn_.transform, RedPointConst.OATH_TASK_FINISH .. self.heroID)
end

function OathDetailsView:OnTop()
	self:RefreshBar()
end

function OathDetailsView:OnWinStoryEnd()
	if gameContext:GetLastOpenPageHandler() == self then
		self:RefreshBar()
	end
end

function OathDetailsView:OnBehind()
	manager.windowBar:HideBar()
end

function OathDetailsView:RefreshBar()
	if self.selectModeState == self.staticContext.detail.state then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	elseif self.selectModeState == self.staticContext.task.state then
		manager.windowBar:SwitchBar({})
	end
end

function OathDetailsView:OnExit()
	manager.redPoint:unbindUIandKey(self.goTaskBtn_.transform, RedPointConst.OATH_TASK_FINISH .. self.heroID)

	for iter_20_0, iter_20_1 in pairs(self.staticContext) do
		if iter_20_1.entity and iter_20_1.entity.OnExit then
			iter_20_1.entity:OnExit()
		end
	end

	self.lvInfo_:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function OathDetailsView:Dispose()
	for iter_21_0, iter_21_1 in pairs(self.staticContext) do
		if iter_21_1.entity and iter_21_1.entity.Dispose then
			iter_21_1.entity:Dispose()

			iter_21_1.entity = nil
		end
	end

	if self.lvInfo_ then
		self.lvInfo_:Dispose()

		self.lvInfo_ = nil
	end

	self.super.Dispose(self)
end

return OathDetailsView
