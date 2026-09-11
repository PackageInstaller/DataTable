local ActivityNoobBpRechargeView = class("ActivityNoobBpRechargeView", ReduxView)

function ActivityNoobBpRechargeView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.type_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.rewardCfgList_ = {}
end

function ActivityNoobBpRechargeView:GetUIName(arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieBpRechargeUI"
	else
		return "Widget/System/Activitynewbie/NewbieBpRechargeUI_old"
	end
end

function ActivityNoobBpRechargeView:Dispose()
	ActivityNoobBpRechargeView.super.Dispose(self)

	for iter_3_0, iter_3_1 in ipairs(self.rewardItemList_) do
		iter_3_1:Dispose()
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ActivityNoobBpRechargeView:AddListeners()
	self:AddBtnListener(self.sourceBtn_, nil, function()
		if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
			ShowTips("SYSTEM_LOCK")

			return
		end

		if TimeMgr.GetInstance():GetServerTime() >= PassportData:GetEndTimestamp() then
			ShowTips("NO_ACTIVE_BATTLEPASS")

			return
		end

		JumpTools.JumpToPage2(GameSetting.first_battle_pass_reward.value[3])
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(3, 0, function(arg_7_0)
			self:RefreshStatus()
		end)
	end)
end

function ActivityNoobBpRechargeView:SetData()
	self.rewardCfgList_ = {}

	for iter_8_0 = 1, #GameSetting.first_battle_pass_reward.value - 1 do
		self.rewardCfgList_[#self.rewardCfgList_ + 1] = GameSetting.first_battle_pass_reward.value[iter_8_0]
	end

	for iter_8_1, iter_8_2 in ipairs(self.rewardCfgList_) do
		if not self.rewardItemList_[iter_8_1] then
			self.rewardItemList_[iter_8_1] = CommonItemView.New(self.rewardPanelTrans_:GetChild(iter_8_1 - 1).gameObject, true)
			self.itemDataList_[iter_8_1] = clone(ItemTemplateData)
			self.itemDataList_[iter_8_1].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemDataList_[iter_8_1].id = iter_8_2[1]
		self.itemDataList_[iter_8_1].number = iter_8_2[2]

		self.rewardItemList_[iter_8_1]:Show(true)
		self.rewardItemList_[iter_8_1]:SetData(self.itemDataList_[iter_8_1])
	end

	self:RefreshStatus()

	if self.typeController_ then
		self.typeController_:SetSelectedIndex(self.type_)
	end

	ActivityNewbieTools.SetSelectBpRecharge()
end

function ActivityNoobBpRechargeView:RefreshStatus()
	self.status_ = ActivityNewbieTools.GetBpRewardStatus()

	self.statusController_:SetSelectedIndex(self.status_)
end

function ActivityNoobBpRechargeView:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return ActivityNoobBpRechargeView
