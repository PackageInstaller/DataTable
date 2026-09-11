local IndiaNianStageInfoView = class("IndiaNianStageInfoView", ReduxView)

function IndiaNianStageInfoView:Init()
	self:InitUI()
end

function IndiaNianStageInfoView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianStageInforUI"
end

function IndiaNianStageInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function IndiaNianStageInfoView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.dropList_, CommonItem)
end

function IndiaNianStageInfoView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
		self.params_.callback()
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.cost_ > ItemTools.getItemNum(IndiaNianData:GetSelectedStageCost()[1]) then
			self:PopCurrencyWindow()
		else
			self:OnClickBtn()
		end
	end)
end

function IndiaNianStageInfoView:IndexItem(arg_8_1, arg_8_2)
	local var_8_0 = rewardToItemTemplate(self.rewardList_[arg_8_1])

	arg_8_2:RefreshData(var_8_0)
	arg_8_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_8_0)
	end)
end

function IndiaNianStageInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		sectionType = self.stageType_,
		activityID = IndiaNianData:GetActivityID(),
		destID = IndiaNianData:GetSelectedDestID()
	})
end

function IndiaNianStageInfoView:PopCurrencyWindow()
	ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemCfg[IndiaNianData:GetSelectedStageCost()[1]].name))
end

function IndiaNianStageInfoView:OnEnter()
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType

	manager.windowBar:RegistBackCallBack(function()
		if self.params_.callback then
			self:Back()
			self.params_.callback()
		end
	end)
	self:RefreshData()
end

function IndiaNianStageInfoView:RefreshData()
	self.drop_lib_id_ = BattleIndiaNianCfg[self.stageID_].drop_lib_id
	self.isFirstClear_ = true
	self.cost_ = IndiaNianData:GetSelectedStageCost()[2] or 0
	self.rewardList_ = getRewardFromDropCfg(self.drop_lib_id_, self.isFirstClear_)

	self:RefreshStageInfo()
end

function IndiaNianStageInfoView:RefreshStageInfo()
	if self.oldCfgID_ ~= BattleIndiaNianCfg[self.stageID_].id then
		self.sectionName_.text = BattleIndiaNianCfg[self.stageID_].name
		self.textStory_.text = BattleIndiaNianCfg[self.stageID_].tips
		self.oldCfgID_ = BattleIndiaNianCfg[self.stageID_].id
		self.costImg_.sprite = ItemTools.getItemLittleSprite(IndiaNianData:GetSelectedStageCost()[1])
		self.costText_.text = "x" .. self.cost_
	end

	self.itemList_:StartScroll(#self.rewardList_)
end

function IndiaNianStageInfoView:Dispose()
	IndiaNianStageInfoView.super.Dispose(self)

	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end
end

return IndiaNianStageInfoView
