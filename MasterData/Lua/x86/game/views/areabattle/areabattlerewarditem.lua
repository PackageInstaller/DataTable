local AreaBattleRewardItem = class("AreaBattleRewardItem", ReduxView)

function AreaBattleRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AreaBattleRewardItem:Init()
	self:InitUI()
end

function AreaBattleRewardItem:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controller_:GetController("status")

	self:AddUIListener()

	self.commonItem1 = CommonItemView.New(self.rewardItem1_)
	self.commonItem2 = CommonItemView.New(self.rewardItem2_)
	self.commonItem3 = CommonItemView.New(self.rewardItem3_)
	self.commonData1 = clone(ItemTemplateData)
	self.commonData2 = clone(ItemTemplateData)
	self.commonData3 = clone(ItemTemplateData)
end

function AreaBattleRewardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		AreaBattleAction.GetReward(self.activityID, {
			self.cfg[1]
		})
	end)
end

function AreaBattleRewardItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.index = arg_6_1
	self.cfg = arg_6_2
	self.data = arg_6_3
	self.activityID = arg_6_4

	self:UpdateView()
end

function AreaBattleRewardItem:UpdateView()
	self.descText_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_REWARD_DESC"), self.cfg[1])

	self.controller_:SetSelectedState("state2")

	for iter_7_0 = 1, 3 do
		SetActive(self["rewardItem" .. iter_7_0 .. "_"], self.cfg[2][iter_7_0] ~= nil)

		if self.cfg[2][iter_7_0] then
			self["commonData" .. iter_7_0].id = self.cfg[2][iter_7_0][1]
			self["commonData" .. iter_7_0].number = self.cfg[2][iter_7_0][2]
			self["commonData" .. iter_7_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			self["commonItem" .. iter_7_0]:SetData(self["commonData" .. iter_7_0])
		end
	end

	if self.data.allChallengeValue >= self.cfg[1] then
		self.controller_:SetSelectedState("state1")

		if self.data.gotChallengeRewardList[self.cfg[1]] then
			self.controller_:SetSelectedState("state3")
		end
	end
end

function AreaBattleRewardItem:OnEnter()
	self:UpdateView()
end

function AreaBattleRewardItem:Dispose()
	if self.commonItem1 then
		self.commonItem1:Dispose()

		self.commonItem1 = nil
	end

	if self.commonItem2 then
		self.commonItem2:Dispose()

		self.commonItem2 = nil
	end

	if self.commonItem3 then
		self.commonItem3:Dispose()

		self.commonItem3 = nil
	end

	AreaBattleRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleRewardItem
