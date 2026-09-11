local MoonBoRewardItem = class("MoonBoRewardItem", ReduxView)

function MoonBoRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function MoonBoRewardItem:Init()
	self:InitUI()
end

function MoonBoRewardItem:InitUI()
	self:BindCfgUI()

	self.awardList_ = LuaList.New(handler(self, self.AwardIndexItem), self.listGo_, CommonItem)
end

function MoonBoRewardItem:AwardIndexItem(arg_4_1, arg_4_2)
	local var_4_0 = self.curAwardsList_[arg_4_1]

	arg_4_2:RefreshData(formatReward(self.curAwardsList_[arg_4_1]))

	local var_4_1 = ControllerUtil.GetController(arg_4_2.transform_, "received")

	if MoonBoData:GetRewardIsShow(MoonBoCfg[self.levelNum_].reward_level, var_4_0[1]) then
		var_4_1:SetSelectedState("false")
	else
		var_4_1:SetSelectedState("true")
	end

	arg_4_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_4_0)
	end)

	arg_4_2.countText_.text = string.format("%s/%s", MoonBoData:GetCurCanGetRewardCount(MoonBoCfg[self.levelNum_].reward_level, var_4_0[1]), MoonBoData:GetCfgRewardsCount(self.levelNum_, var_4_0[1]))
end

function MoonBoRewardItem:RefreshUI(arg_6_1, arg_6_2)
	self.levelNum_ = MoonBoCfg.get_id_list_by_activity_id[arg_6_2][#MoonBoCfg.get_id_list_by_activity_id[arg_6_2] - arg_6_1 + 1]
	self.need_.text = MoonBoData:LevelNumToLanguage(self.levelNum_ % 100)
	self.curAwardsList_ = MoonBoData:GetCfgRewards(self.levelNum_)

	self.awardList_:StartScroll(#self.curAwardsList_)
end

function MoonBoRewardItem:OnExit()
	return
end

function MoonBoRewardItem:Dispose()
	self:RemoveAllListeners()

	if self.awardList_ then
		self.awardList_:Dispose()

		self.awardList_ = nil
	end

	MoonBoRewardItem.super.Dispose(self)
end

return MoonBoRewardItem
