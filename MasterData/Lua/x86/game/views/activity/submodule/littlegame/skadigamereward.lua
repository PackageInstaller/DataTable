local SkadiGameReward = class("SkadiGameReward", ReduxView)

function SkadiGameReward:UIName()
	return "UI/VersionUI/SummerUI/SummeChallengePop"
end

function SkadiGameReward:UIParent()
	return manager.ui.uiMain.transform
end

function SkadiGameReward:Init()
	self.itemList_ = {}

	self:BindCfgUI()
	self:AddUIListener()

	self.scrollerHelper_ = LuaList.New(handler(self, self.IndexItem), self.uilistGo_, SkadiGameRewardItem)
end

function SkadiGameReward:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function SkadiGameReward:OnEnter()
	manager.windowBar:HideBar()

	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function SkadiGameReward:OnExit()
	return
end

function SkadiGameReward:RefreshUI()
	self:UpdateDate()
	self.scrollerHelper_:StartScroll(#self.itemList_)

	self.numText_.text = SummerLittleGameData:GetSkadiRewardNum() .. "/" .. #self.itemList_ * 3
end

function SkadiGameReward:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(self.itemList_[arg_9_1])
end

function SkadiGameReward:UpdateDate()
	self.itemList_ = deepClone(ActivityCrossWaveCfg.all)

	table.sort(self.itemList_, function(arg_11_0, arg_11_1)
		local var_11_0 = #SummerLittleGameData:GetSkadiReward(arg_11_0) < #SummerLittleGameData:GetSkadiStars(arg_11_0)
		local var_11_1 = #SummerLittleGameData:GetSkadiReward(arg_11_1) < #SummerLittleGameData:GetSkadiStars(arg_11_1)

		if var_11_0 and not var_11_1 then
			return true
		end

		if not var_11_0 and var_11_1 then
			return false
		end

		return arg_11_0 < arg_11_1
	end)
end

function SkadiGameReward:OnGetSkadiReward()
	self.scrollerHelper_:Refresh()

	self.numText_.text = SummerLittleGameData:GetSkadiRewardNum() .. "/" .. #self.itemList_ * 3
end

function SkadiGameReward:Dispose()
	self.scrollerHelper_:Dispose()
	SkadiGameReward.super.Dispose(self)
end

return SkadiGameReward
