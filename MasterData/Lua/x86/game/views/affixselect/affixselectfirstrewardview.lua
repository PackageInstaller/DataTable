local AffixSelectFirstRewardView = class("AffixSelectFirstRewardView", ReduxView)

function AffixSelectFirstRewardView:UIName()
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillFirstRewardUI"
end

function AffixSelectFirstRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function AffixSelectFirstRewardView:OnCtor()
	return
end

function AffixSelectFirstRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectFirstRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AffixSelectRewardItemView)
	self.btnController_ = self.btnCon_:GetController("state")
end

function AffixSelectFirstRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, nil, self.idList_[arg_6_1], true)
end

function AffixSelectFirstRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnReceiveAll_, nil, function()
		ActivityAffixSelectAction.GetAllFirsrtRewards(self.allRewards_)
	end)
end

function AffixSelectFirstRewardView:AddEventListeners()
	self:RegistEventListener(AFFIX_SELECT_FIRST_BONUS_UPDATE, function()
		self:UpdateList()
	end)
end

function AffixSelectFirstRewardView:OnTop()
	self:UpdateBar()
end

function AffixSelectFirstRewardView:OnBehind()
	manager.windowBar:HideBar()
end

function AffixSelectFirstRewardView:UpdateBar()
	manager.windowBar:HideBar()
end

function AffixSelectFirstRewardView:OnEnter()
	self.activityId = self.params_.affixActivityId

	self:AddEventListeners()
	self:UpdateList()
end

function AffixSelectFirstRewardView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AffixSelectFirstRewardView:UpdateList()
	self.idList_ = deepClone(ActivityCfg[self.activityId].sub_activity_list)

	table.sort(self.idList_, function(arg_18_0, arg_18_1)
		local var_18_0 = ActivityAffixSelectData:GetSubActivityData(arg_18_0) or {
			clearState = 1
		}
		local var_18_1 = ActivityAffixSelectData:GetSubActivityData(arg_18_1) or {
			clearState = 1
		}

		if var_18_0.clearState ~= var_18_1.clearState then
			return var_18_0.clearState % 3 > var_18_1.clearState % 3
		end

		return arg_18_0 < arg_18_1
	end)
	self.uiList_:StartScroll(#self.idList_)

	self.allRewards_ = ActivityAffixSelectData:GetAllFirstRewards()

	self.btnController_:SetSelectedState(#self.allRewards_ <= 0 and "hide" or "show")
end

function AffixSelectFirstRewardView:OnMainHomeViewTop()
	return
end

function AffixSelectFirstRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AffixSelectFirstRewardView.super.Dispose(self)
end

return AffixSelectFirstRewardView
