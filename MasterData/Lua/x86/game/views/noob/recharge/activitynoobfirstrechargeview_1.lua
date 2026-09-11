local ActivityNoobFirstRechargeView_1 = class("ActivityNoobFirstRechargeView_1", ReduxView)

function ActivityNoobFirstRechargeView_1:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.type_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function ActivityNoobFirstRechargeView_1:GetUIName(arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieRechargeUI_new"
	else
		return "Widget/System/Activitynewbie/NewbieRechargeUI_old"
	end
end

function ActivityNoobFirstRechargeView_1:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	ActivityNoobFirstRechargeView_1.super.Dispose(self)
end

function ActivityNoobFirstRechargeView_1:AddListeners()
	self:AddBtnListener(self.sourceBtn_, nil, function()
		JumpTools.JumpToPage2(GameSetting.newbie_first_charge_reward_6.value[2])
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(1, 0, function()
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

function ActivityNoobFirstRechargeView_1:SetData()
	self.rewardCfg_ = GameSetting.newbie_first_charge_reward_6.value[3]

	if not self.commonItem_ then
		local var_10_0 = clone(ItemTemplateData)

		var_10_0.id = self.rewardCfg_[1]
		var_10_0.number = self.rewardCfg_[2]

		function var_10_0:clickFun()
			if self.status_ == 1 then
				ActivityNewbieTools.ReceiveRechargeReward(1, 0, function()
					self:SetData()
				end)
			else
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.commonItem_ = CommonItemView.New(self.commonGo_)

		self.commonItem_:SetData(var_10_0)
	end

	local var_10_1 = ActivityNewbieTools.GetFirstRechargeStatus()

	self.status_ = var_10_1.firstGearStatus

	self.statusController_:SetSelectedIndex(var_10_1.firstGearStatus)

	if self.typeController_ then
		self.typeController_:SetSelectedIndex(self.type_)
	end

	ActivityNewbieTools.SetSelectFirstRecharge(1)
end

function ActivityNoobFirstRechargeView_1:SetActive(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

return ActivityNoobFirstRechargeView_1
