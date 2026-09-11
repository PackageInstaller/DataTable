local AshSystemTrustViewItem = class("AshSystemTrustViewItem", ReduxView)

function AshSystemTrustViewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AshSystemTrustViewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AshSystemTrustViewItem:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.allBtnController_:GetController("all")

	for iter_3_0 = 1, 3 do
		self["item" .. iter_3_0 .. "_"] = CommonItemView.New(self["awardItem" .. iter_3_0 .. "Obj_"])
	end
end

function AshSystemTrustViewItem:SetData(arg_4_1, arg_4_2)
	self.rewardID_ = arg_4_1
	self.index = arg_4_2
	self.cfg_ = ActivityPointRewardCfg[self.rewardID_]

	self:RefreshUI()
end

function AshSystemTrustViewItem:RefreshUI()
	local var_5_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)

	self.indexText_.text = self.index or 1
	self.desc_.text = string.format(GetTips("ASH_PERMANENT_MISSION_DESC"), self.cfg_.need)

	if self.cfg_.need <= var_5_0 then
		self.progressText_.text = self.cfg_.need .. "/" .. self.cfg_.need
		self.progressBar_.value = 1

		if AshSystemData:GetPointRewardIsGet(self.rewardID_) then
			self.btnController_:SetSelectedState("complete")
		else
			self.btnController_:SetSelectedState("receive")
		end
	else
		self.progressText_.text = var_5_0 .. "/" .. self.cfg_.need
		self.progressBar_.value = var_5_0 / self.cfg_.need

		self.btnController_:SetSelectedState("lock")
	end

	for iter_5_0 = 1, 3 do
		if self.cfg_.reward_item_list[iter_5_0] then
			local var_5_1 = clone(ItemTemplateData)

			var_5_1.id = self.cfg_.reward_item_list[iter_5_0][1]
			var_5_1.number = self.cfg_.reward_item_list[iter_5_0][2]
			var_5_1.grayFlag = not not AshSystemData:GetPointRewardIsGet(self.rewardID_)

			function var_5_1:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			self["item" .. iter_5_0 .. "_"]:SetData(var_5_1)
		else
			self["item" .. iter_5_0 .. "_"]:SetData(nil)
		end
	end
end

function AshSystemTrustViewItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id) >= self.cfg_.need then
			if AshSystemData:GetPointRewardIsGet(self.rewardID_) then
				-- block empty
			else
				ActivityPointAction.ReceivePointReward({
					self.rewardID_
				})
			end

			AshSystemData:UpdateTaskRedPoint()
		end
	end)
end

function AshSystemTrustViewItem:OnExit()
	return
end

function AshSystemTrustViewItem:Dispose()
	AshSystemTrustViewItem.super.Dispose(self)
end

return AshSystemTrustViewItem
