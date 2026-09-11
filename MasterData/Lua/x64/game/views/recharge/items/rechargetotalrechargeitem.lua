local RechargeVoucherItem = class("RechargeVoucherItem", ReduxView)

function RechargeVoucherItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RechargeVoucherItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeVoucherItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.transCon_:GetController("status")
	self.lastController_ = self.transCon_:GetController("last")
	self.itemList_ = {}
	self.itemParentList_ = {}
	self.rewardControllerList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = self.transCon_:GetController("reward" .. iter_3_0)

		if self["itemGo_" .. iter_3_0] then
			self.itemList_[iter_3_0] = CommonItemView.New(self["itemGo_" .. iter_3_0])
		end

		if self["itemParent_" .. iter_3_0] then
			self.itemParentList_[iter_3_0] = self["itemParent_" .. iter_3_0]
		end

		if var_3_0 then
			self.rewardControllerList_[iter_3_0] = var_3_0
		end
	end
end

function RechargeVoucherItem:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		if self.isVersion_ then
			PayAction.GetVersionRechargeBonus({
				self.cfg_.id
			})
		else
			PayAction.GetTotalRechargeBonus({
				self.cfg_.id
			})
		end
	end)
end

function RechargeVoucherItem:OnEnter()
	return
end

function RechargeVoucherItem:OnExit()
	return
end

function RechargeVoucherItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1.index
	self.isReceive_ = arg_8_1.isReceive
	self.isVersion_ = arg_8_2

	if arg_8_2 then
		self.cfg_ = VersionRechargeCfg[arg_8_1.id] or TotalRechargeCfg[arg_8_1.id]
	end

	if arg_8_3 then
		self.nextNum_ = TotalRechargeCfg[arg_8_3.id].num or 0
	end

	if self.lastController_ then
		self.lastController_:SetSelectedState(tostring(arg_8_3 == nil))
	end

	self:UpdateView()
end

function RechargeVoucherItem:UpdateView()
	self.nameLabel_.text = string.format("%02d", self.index_)
	self.numText_.text = self.cfg_.num

	for iter_9_0 = 1, self.isVersion_ and 2 or 4 do
		local var_9_0 = ((self.isVersion_ or nil) and (self.cfg_.reward or self.cfg_.reward_show))[iter_9_0]

		if ((self.isVersion_ or nil) and (self.cfg_.reward or self.cfg_.reward_show))[iter_9_0] then
			SetActive(self.itemParentList_[iter_9_0], true)

			local var_9_1 = clone(ItemTemplateData)

			var_9_1.id = var_9_0[1]
			var_9_1.number = var_9_0[2]

			function var_9_1:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			self.itemList_[iter_9_0]:SetData(var_9_1)
		else
			SetActive(self.itemParentList_[iter_9_0], false)
		end

		if not self.isVersion_ then
			self.rewardControllerList_[iter_9_0]:SetSelectedState(var_9_0 and table.indexof(self.cfg_.Important_rewards, iter_9_0) and "show" or "hide")
		end
	end

	if self.isVersion_ then
		local var_9_2 = RechargeData:GetVersionRechargeNum() or RechargeData:GetTotalRechargeNum()

		if not self.isVersion_ and var_9_2 >= self.cfg_.num then
			if self.nextNum_ ~= 0 then
				self.slider_.value = (var_9_2 - self.cfg_.num) / (self.nextNum_ - self.cfg_.num) or 1
			end
		end

		if self.isReceive_ then
			self.statusController_:SetSelectedState("already_received")
		elseif var_9_2 >= self.cfg_.num then
			self.statusController_:SetSelectedState("receive")
		end
	end

	self.statusController_:SetSelectedState("not_reach")
end

function RechargeVoucherItem:Dispose()
	for iter_11_0, iter_11_1 in ipairs(self.itemList_) do
		iter_11_1:Dispose()

		iter_11_1 = nil
	end

	self.itemList_ = nil

	RechargeVoucherItem.super.Dispose(self)
end

return RechargeVoucherItem
