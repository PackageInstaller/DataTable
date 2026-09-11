local DormLinkGameActivityView = class("DormLinkGameActivityView", ReduxView)

function DormLinkGameActivityView:UIName()
	return "Widget/Version/Alone_LinkGame/Alone_LGStagePopUI"
end

function DormLinkGameActivityView:UIParent()
	return manager.ui.uiPop.transform
end

function DormLinkGameActivityView:OnCtor()
	return
end

function DormLinkGameActivityView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormLinkGameActivityView:InitUI()
	self:BindCfgUI()

	self.clearController = self.controllerExCollection_:GetController("clear")
	self.activityScroll = LuaList.New(handler(self, self.indexActivityItemList), self.uilistGo_, DormLinkGameActivityItem)
end

function DormLinkGameActivityView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.clearBtn_, nil, function()
		DormLinkGameAction:GetMultiplyLevelAward(self.completeList)
	end)
end

function DormLinkGameActivityView:OnEnter()
	self.activity = self.params_.activityID

	self:RegisterEvents()
	self:RefreshView()

	self.canGetAward = true
end

function DormLinkGameActivityView:RegisterEvents()
	self:RegistEventListener(DORM_LINK_REFRESH_LEVEL_AWARD, function()
		self.canGetAward = true

		self:RefreshView()
		DormLinkGameData:CheckUnReciveLevelReward()
	end)
end

function DormLinkGameActivityView:indexActivityItemList(arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(self.activityList[arg_12_1])
	arg_12_2:GetLevelAward(function(arg_13_0)
		if self.canGetAward then
			self.canGetAward = false

			DormLinkGameAction:GetLevelAward(arg_13_0)
		end
	end)
end

function DormLinkGameActivityView:RefreshView()
	local var_14_0 = {}

	if self.activity then
		for iter_14_0, iter_14_1 in ipairs((DormLinkGameTools:GetLevelActivityList(self.activity))) do
			for iter_14_2, iter_14_3 in ipairs(ActivityLinkGameRewardCfg.get_id_list_by_activity_id[iter_14_1]) do
				table.insert(var_14_0, iter_14_3)
			end
		end
	else
		for iter_14_4, iter_14_5 in ipairs(ActivityLinkGameRewardCfg.all) do
			table.insert(var_14_0, iter_14_5)
		end
	end

	local var_14_1 = {}

	for iter_14_6, iter_14_7 in ipairs(var_14_0) do
		if DormLinkGameData:CheckLevelRewardState(iter_14_7) == DormLinkGameConst.RewardItemState.complete then
			table.insert(var_14_1, iter_14_7)
		end
	end

	self.activityList = var_14_0
	self.completeList = var_14_1

	CommonTools.UniversalSortEx(self.activityList, {
		ascend = true,
		map = function(arg_15_0)
			local var_15_0 = DormLinkGameData:CheckLevelRewardState(arg_15_0)

			if var_15_0 == DormLinkGameConst.RewardItemState.unComplete then
				return 2
			elseif var_15_0 == DormLinkGameConst.RewardItemState.complete then
				return 1
			elseif var_15_0 == DormLinkGameConst.RewardItemState.received then
				return 3
			end
		end
	}, {
		ascend = true,
		map = function(arg_16_0)
			return arg_16_0
		end
	})

	if #var_14_1 > 0 then
		self.clearController:SetSelectedState("show")
	else
		self.clearController:SetSelectedState("hide")
	end

	self.activityScroll:StartScroll(#self.activityList)
end

function DormLinkGameActivityView:OnExit()
	self:RemoveAllEventListener()
end

function DormLinkGameActivityView:OnExitInput()
	JumpTools.Back()

	return true
end

function DormLinkGameActivityView:Dispose()
	if self.activityScroll then
		self.activityScroll:Dispose()
	end

	DormLinkGameActivityView.super.Dispose(self)
end

return DormLinkGameActivityView
