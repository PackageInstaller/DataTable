local ZumaConditionItem = class("ZumaConditionItem", ReduxView)
local var_0_1 = {
	showState = {
		unFinish = "state0",
		name = "clear",
		finish = "state1"
	}
}

function ZumaConditionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function ZumaConditionItem:InitUI()
	self:BindCfgUI()

	self.showStateController = self.controllerEx_:GetController(var_0_1.showState.name)
end

function ZumaConditionItem:RefreshConditionState(arg_3_1, arg_3_2)
	self.descText_.text = string.format(GetTips("ACTIVITY_ZUMA_LEVEL_TARGET_DESC"), ActivityPointRewardCfg[arg_3_1].need)

	if self.rewardValueText_ then
		self.rewardValueText_.text = ActivityPointRewardCfg[arg_3_1].reward_item_list[1][2]
	end

	if self.imageImg_ then
		self.imageImg_.sprite = ItemTools.getItemSprite(ActivityPointRewardCfg[arg_3_1].reward_item_list[1][1])

		local var_3_0

		if arg_3_2 < ActivityPointRewardCfg[arg_3_1].need then
			var_3_0 = var_0_1.showState.unFinish or var_0_1.showState.finish
		end
	end

	self.showStateController:SetSelectedState(var_3_0)
end

function ZumaConditionItem:Dispose()
	ZumaConditionItem.super.Dispose(self)
end

return ZumaConditionItem
