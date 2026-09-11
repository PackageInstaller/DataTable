local ActivityNoobFirstRechargeView_2 = class("ActivityNoobFirstRechargeView_2", ReduxView)

function ActivityNoobFirstRechargeView_2:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.type_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.rechargeUpdateHandler_ = handler(self, self.SetData)

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, self.rechargeUpdateHandler_)

	self.signItemList_ = {}
end

function ActivityNoobFirstRechargeView_2:GetUIName(arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieRecharge2UI_new"
	else
		return "Widget/System/Activitynewbie/NewbieRecharge2UI_old"
	end
end

function ActivityNoobFirstRechargeView_2:Dispose()
	ActivityNoobFirstRechargeView_2.super.Dispose(self)
	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, self.rechargeUpdateHandler_)

	self.rechargeUpdateHandler_ = nil

	for iter_3_0, iter_3_1 in ipairs(self.signItemList_) do
		iter_3_1:Dispose()
	end

	self.signItemList_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ActivityNoobFirstRechargeView_2:AddListeners()
	self:AddBtnListener(self.sourceBtn_, nil, function()
		JumpTools.JumpToPage2(GameSetting.newbie_first_charge_reward_18.value[2])
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(1, 1, function(arg_7_0)
			self:SetData()
		end)
	end)

	if self.heroBtn_ then
		self:AddBtnListener(self.heroBtn_, nil, function()
			if ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].id
				})
			elseif ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].type == ItemConst.ITEM_TYPE.GIFT then
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].param[1][1]
				})
			end
		end)
	end

	if self.heroBtn2_ then
		self:AddBtnListener(self.heroBtn2_, nil, function()
			if ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].id
				})
			elseif ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].type == ItemConst.ITEM_TYPE.GIFT and #ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].param > 1 then
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]].param[2][1]
				})
			end
		end)
	end
end

function ActivityNoobFirstRechargeView_2:SetData()
	self.rewardCfg_ = GameSetting.newbie_first_charge_reward_18.value[3]

	for iter_10_0, iter_10_1 in ipairs(self.rewardCfg_) do
		self.signItemList_[iter_10_0] = self.signItemList_[iter_10_0] or NoobRechargeSignItem.New(self.signItemGo_, self.contentTrans_)

		self.signItemList_[iter_10_0]:SetData(iter_10_0, iter_10_1)
	end

	local var_10_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if not var_10_0.secondGearStatus then
		self.statusController_:SetSelectedState("recharge")
	elseif var_10_0.signTimes < #self.rewardCfg_ and var_10_0.lastSignTimestamp < manager.time:GetTodayFreshTime() then
		self.statusController_:SetSelectedState("complete")
	else
		self.statusController_:SetSelectedState("received")
	end

	if self.typeController_ then
		self.typeController_:SetSelectedIndex(self.type_)
	end

	ActivityNewbieTools.SetSelectFirstRecharge(2)
end

function ActivityNoobFirstRechargeView_2:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return ActivityNoobFirstRechargeView_2
