local QWorldBookletLevelItem = class("QWorldBookletLevelItem", ReduxView)

function QWorldBookletLevelItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldBookletLevelItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldBookletLevelItem:InitUI()
	self:BindCfgUI()

	self.commonItemList_ = {
		CommonItemView.New(self.awardItem1Obj_),
		CommonItemView.New(self.awardItem2Obj_),
		CommonItemView.New(self.awardItem3Obj_)
	}
	self.controller_ = self.allBtnController_:GetController("all")
end

function QWorldBookletLevelItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward({
			self.ID_
		})
	end)
end

function QWorldBookletLevelItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.ID_ = arg_6_1
	self.titleText.text = arg_6_2 > 9 and arg_6_2 or "0" .. arg_6_2
	self.titleText_.text = arg_6_2 > 9 and arg_6_2 or "0" .. arg_6_2

	self.controller_:SetSelectedState(arg_6_3)

	self.descText_.text = GetTipsF("QWORLD_BOOKLET_POINTREWARD_TASKTIPS", arg_6_2)

	for iter_6_0 = 1, 3 do
		if ActivityPointRewardCfg[arg_6_1].reward_item_list[iter_6_0] then
			local var_6_0 = cfgToItemTemplate(ActivityPointRewardCfg[arg_6_1].reward_item_list[iter_6_0])

			var_6_0.grayFlag = arg_6_3 == "complete"

			function var_6_0.clickFun(arg_7_0)
				ShowPopItem(POP_ITEM, arg_7_0)
			end

			self.commonItemList_[iter_6_0]:SetData(var_6_0)
		end
	end
end

function QWorldBookletLevelItem:Dispose()
	QWorldBookletLevelItem.super.Dispose(self)

	for iter_8_0 = 1, #self.commonItemList_ do
		if self.commonItemList_[iter_8_0] then
			self.commonItemList_[iter_8_0]:Dispose()

			self.commonItemList_[iter_8_0] = nil
		end
	end
end

return QWorldBookletLevelItem
