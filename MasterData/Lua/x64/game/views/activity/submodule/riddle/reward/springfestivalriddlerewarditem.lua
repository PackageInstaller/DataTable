local SpringFestivalRiddleRewardItem = class("SpringFestivalRiddleRewardItem", ReduxView)

function SpringFestivalRiddleRewardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1

	self:BindCfgUI()

	self.rewardUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, CommonItem)
	self.controller_ = ControllerUtil.GetController(self.btnTf_, "switchBtn")
end

function SpringFestivalRiddleRewardItem:SetData(arg_2_1, arg_2_2)
	self.id_ = arg_2_2

	local var_2_0 = ActivityPointRewardCfg[arg_2_2]

	self.descText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH_CNT"), ActivityPointRewardCfg[arg_2_2].need)

	if table.keyof(SpringFestivalRiddleData:GetReceiveList(arg_2_1), arg_2_2) then
		self.controller_:SetSelectedState("complete")
	else
		self.controller_:SetSelectedState("not")
	end

	self.rewardUIList_:StartScroll(#var_2_0.reward_item_list)
end

function SpringFestivalRiddleRewardItem:Dispose()
	if self.rewardUIList_ then
		self.rewardUIList_:Dispose()

		self.rewardUIList_ = nil
	end

	SpringFestivalRiddleRewardItem.super.Dispose(self)
end

function SpringFestivalRiddleRewardItem:RefreshItem(arg_4_1, arg_4_2)
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
	arg_4_2:RefreshData((formatReward(ActivityPointRewardCfg[self.id_].reward_item_list[arg_4_1])))
end

return SpringFestivalRiddleRewardItem
