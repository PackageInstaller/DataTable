local IdolCompetitionSignSelectView = class("IdolCompetitionSignSelectView", ReduxView)

function IdolCompetitionSignSelectView:UIName()
	return "Widget/BackHouseUI/Competition/IdolCompetitionSelUI"
end

function IdolCompetitionSignSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolCompetitionSignSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionSignSelectView:InitUI()
	self:BindCfgUI()

	self.saveClick_ = nil
	self.infoPage_ = IdolTraineeTrainInfoPage.New(self.heroInfoSubView_)
	self.heroList_ = {}
	self.selected_ = {}
	self.curHeroID_ = 0
	self.curHeroIndex_ = 0
	self.heroUIList_ = LuaList.New(handler(self, self.IndexItem), self.heroListGo_, IdolTraineeHeadItem)
	self.stageInfoPage = IdolTraineeStageInfoPage.New(self.stageInfo)

	self.stageInfoPage:ShowPage(true)

	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function IdolCompetitionSignSelectView:AddUIListener()
	self:AddBtnListener(self.saveBtn_, nil, function()
		if self.curHeroID_ ~= self.params_.info.heroID and self.selected_[self.curHeroID_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("IDOL_COMPETITION_SELECTED_CONFLICT"),
				OkCallback = function()
					if self.saveClick_ then
						self.saveClick_(self.curHeroID_)
					end

					self:Back()
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		if self.saveClick_ then
			self.saveClick_(self.curHeroID_)
		end

		self:Back()
	end)
end

function IdolCompetitionSignSelectView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.heroList_[arg_9_1], self.curHeroID_, function()
		if self.curHeroID_ ~= 0 and self.curHeroIndex_ ~= 0 then
			local var_10_0 = self.heroUIList_:GetItemByIndex(self.curHeroIndex_)

			if var_10_0 then
				var_10_0:SelectOff()
			end
		end

		self.curHeroIndex_ = arg_9_1

		arg_9_2:SelectOn()
		self:UpdateView(self.heroList_[arg_9_1])
	end, {
		competitionSel = self.selected_[self.heroList_[arg_9_1]]
	})
end

function IdolCompetitionSignSelectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)

	self.saveClick_ = self.params_.onClick
	self.heroList_ = IdolTraineeData:GetIdolHeroList(true) or {}

	table.sort(self.heroList_, function(arg_12_0, arg_12_1)
		if HeroTools.GetHeroIsUnlock(arg_12_0) and HeroTools.GetHeroIsUnlock(arg_12_1) then
			local var_12_0 = 0
			local var_12_1 = 0

			for iter_12_0, iter_12_1 in ipairs(IdolTraineeData:GetIdolHeroData(arg_12_0)) do
				var_12_0 = var_12_0 + iter_12_1
			end

			for iter_12_2, iter_12_3 in ipairs(IdolTraineeData:GetIdolHeroData(arg_12_1)) do
				var_12_1 = var_12_1 + iter_12_3
			end

			return var_12_1 < var_12_0
		elseif HeroTools.GetHeroIsUnlock(arg_12_0) then
			return true
		elseif HeroTools.GetHeroIsUnlock(arg_12_1) then
			return false
		else
			return arg_12_0 < arg_12_1
		end
	end)

	self.curHeroID_ = self.params_.info.heroID
	self.selected_ = self.params_.selected or {}

	if self.curHeroID_ == 0 then
		self.curHeroID_ = self.heroList_[1]
		self.curHeroIndex_ = 1
	else
		self.curHeroIndex_ = table.keyof(self.heroList_, self.curHeroID_)
	end

	self.infoPage_:RegisterEvents()
	self:UpdateView(self.curHeroID_)
	self.heroUIList_:StartScroll(#self.heroList_)
	self.stageInfoPage:SetParams({
		pvpBattle = false,
		idolCompetition = true,
		stageID = self.params_.info.stageID
	})
	self.stageInfoPage:OnEnter()
end

function IdolCompetitionSignSelectView:UpdateView(arg_13_1)
	self.curHeroID_ = arg_13_1

	self.infoPage_:RefreshUI((IdolTraineeTools:GetHeroBattleInfoTemplate(self.curHeroID_)))

	if HeroTools.GetHeroIsUnlock(arg_13_1) then
		self.lockController_:SetSelectedState("false")
	else
		self.lockController_:SetSelectedState("true")
	end
end

function IdolCompetitionSignSelectView:OnExit()
	self.infoPage_:RemoveAllEventListener()
	manager.windowBar:HideBar()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
end

function IdolCompetitionSignSelectView:Dispose()
	if self.heroUIList_ then
		self.heroUIList_:Dispose()

		self.heroUIList_ = nil
	end

	if self.infoPage_ then
		self.infoPage_:Dispose()

		self.infoPage_ = nil
	end

	if self.stageInfoPage then
		self.stageInfoPage:Dispose()

		self.stageInfoPage = nil
	end

	IdolCompetitionSignSelectView.super.Dispose(self)
end

return IdolCompetitionSignSelectView
