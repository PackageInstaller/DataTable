local ActivityPointTaskCommonItem = class("ActivityPointTaskCommonItem", ReduxView)

function ActivityPointTaskCommonItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityPointTaskCommonItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityPointTaskCommonItem:InitUI()
	self:BindCfgUI()

	self.descText_ = self.descText_ or self.titleText_
	self.commonItemList_ = {
		CommonItemView.New(self.awardItem1Obj_),
		CommonItemView.New(self.awardItem2Obj_),
		CommonItemView.New(self.awardItem3Obj_)
	}
	self.controller_ = self.allBtnController_:GetController("all")
end

function ActivityPointTaskCommonItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward({
			self.ID_
		})
	end)
end

function ActivityPointTaskCommonItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.ID_ = arg_6_1
	self.titleText_.text = arg_6_2 > 9 and arg_6_2 or "0" .. arg_6_2

	self.controller_:SetSelectedState(arg_6_3)

	self.descText_.text = TipsCfg.get_id_list_by_define["ACTIVITY_POINT_TASK_COMMON_NAME_" .. arg_6_4] and GetTipsF("ACTIVITY_POINT_TASK_COMMON_NAME_" .. arg_6_4, arg_6_2) or arg_6_2

	local var_6_0 = ActivityPointRewardCfg[arg_6_1]

	for iter_6_0 = 1, 3 do
		if var_6_0.reward_item_list[iter_6_0] then
			local var_6_1 = cfgToItemTemplate(var_6_0.reward_item_list[iter_6_0])

			var_6_1.grayFlag = arg_6_3 == "complete"

			function var_6_1.clickFun(arg_7_0)
				ShowPopItem(POP_ITEM, arg_7_0)
			end

			self.commonItemList_[iter_6_0]:SetData(var_6_1)
		end
	end
end

function ActivityPointTaskCommonItem:Dispose()
	ActivityPointTaskCommonItem.super.Dispose(self)

	for iter_8_0 = 1, #self.commonItemList_ do
		if self.commonItemList_[iter_8_0] then
			self.commonItemList_[iter_8_0]:Dispose()

			self.commonItemList_[iter_8_0] = nil
		end
	end
end

return ActivityPointTaskCommonItem
