local ActivityNewWarChessRewardView = class("ActivityNewWarChessRewardView", ReduxView)

function ActivityNewWarChessRewardView:UIName()
	if self.params_.mainActivityID == ActivityConst.ACTIVITY_NEWWARCHESS_2_6 then
		return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionNewWarChessRewardUI"
	elseif self.params_.mainActivityID == ActivityConst.ACTIVITY_2_10_NEWWARCHESS then
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10NewWarChessRewardUI"
	end
end

function ActivityNewWarChessRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityNewWarChessRewardView:OnCtor()
	return
end

function ActivityNewWarChessRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityNewWarChessRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, ActivityNewWarChessRewardItem)
end

function ActivityNewWarChessRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.activityIds_[arg_6_1])
end

function ActivityNewWarChessRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ActivityNewWarChessRewardView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityIds_ = self.params_.activityIDList

	self.uiList_:StartScroll(#self.activityIds_, (self:GetCurScrollIndex()))
end

function ActivityNewWarChessRewardView:GetCurScrollIndex()
	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(self.activityIds_) do
		local var_10_1 = NewWarChessData:GetExploreValue(NewWarChessLevelCfg.get_id_list_by_activity[iter_10_1][1])

		for iter_10_2, iter_10_3 in pairs(NewWarChessLevelCfg[NewWarChessLevelCfg.get_id_list_by_activity[iter_10_1][1]].explore) do
			if iter_10_3 <= var_10_1 and not NewWarChessData:GetRewardIsGet(NewWarChessLevelCfg.get_id_list_by_activity[iter_10_1][1], iter_10_3) then
				var_10_0 = iter_10_0

				return iter_10_0
			end
		end
	end

	return var_10_0
end

function ActivityNewWarChessRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	ActivityNewWarChessRewardView.super.Dispose(self)
end

return ActivityNewWarChessRewardView
