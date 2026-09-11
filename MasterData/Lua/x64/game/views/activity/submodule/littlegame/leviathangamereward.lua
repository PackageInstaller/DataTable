local LeviathanGameReward = class("LeviathanGameReward", ReduxView)

function LeviathanGameReward:UIName()
	return "UI/VersionUI/SummerUI/SummerQuestEewardsPop"
end

function LeviathanGameReward:UIParent()
	return manager.ui.uiMain.transform
end

function LeviathanGameReward:Init()
	self.itemList_ = {}

	self:BindCfgUI()
	self:AddUIListener()

	self.scrollerHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, LeviathanGameRewardItem)
end

function LeviathanGameReward:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function LeviathanGameReward:OnEnter()
	self.activityID_ = self.params_.activityID

	self:UpdateDate()
	self.scrollerHelper_:StartScroll(#self.itemList_)
end

function LeviathanGameReward:OnExit()
	return
end

function LeviathanGameReward:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(self.itemList_[arg_8_1])
end

function LeviathanGameReward:UpdateDate()
	self.itemList_ = deepClone(ActivityBubblesCfg.all)

	table.sort(self.itemList_, function(arg_10_0, arg_10_1)
		local var_10_0 = SummerLittleGameData:GetLeviathanState(arg_10_0)
		local var_10_1 = SummerLittleGameData:GetLeviathanState(arg_10_1)

		if var_10_0 == var_10_1 then
			return arg_10_0 < arg_10_1
		end

		local var_10_2 = {
			[0] = 2,
			1,
			3
		}

		return var_10_2[var_10_0] < var_10_2[var_10_1]
	end)
end

function LeviathanGameReward:Dispose()
	self.scrollerHelper_:Dispose()
	LeviathanGameReward.super.Dispose(self)
end

function LeviathanGameReward:OnGetLeviathanReward()
	self:UpdateDate()
	self.scrollerHelper_:Refresh()
end

return LeviathanGameReward
