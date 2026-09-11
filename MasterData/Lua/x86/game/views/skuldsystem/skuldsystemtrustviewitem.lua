local SkuldSystemTrustViewItem = class("SkuldSystemTrustViewItem", ReduxView)

function SkuldSystemTrustViewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkuldSystemTrustViewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SkuldSystemTrustViewItem:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.allBtnController_:GetController("all")

	for iter_3_0 = 1, 3 do
		self["item" .. iter_3_0 .. "_"] = CommonItemView.New(self["awardItem" .. iter_3_0 .. "Obj_"])
	end
end

function SkuldSystemTrustViewItem:SetData(arg_4_1)
	self.rewardID_ = arg_4_1
	self.cfg_ = ActivityPointRewardCfg[self.rewardID_]

	self:RefreshUI()
end

function SkuldSystemTrustViewItem:RefreshUI()
	local var_5_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)

	self.titleText_.text = string.format(GetTips("SKULD_ICON_NEED"), self.cfg_.need)

	if self.cfg_.need <= var_5_0 then
		self.progressText_.text = self.cfg_.need .. "/" .. self.cfg_.need
		self.progressBar_.value = 1

		if SkuldSystemData:GetPointRewardIsGet(self.rewardID_) then
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
			var_5_1.grayFlag = not not SkuldSystemData:GetPointRewardIsGet(self.rewardID_)

			function var_5_1:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
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

function SkuldSystemTrustViewItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) < self.cfg_.need or SkuldSystemData:GetPointRewardIsGet(self.rewardID_) then
			-- block empty
		else
			ActivityAction.ReceivePointReward({
				self.rewardID_
			})
		end
	end)
end

function SkuldSystemTrustViewItem:OnExit()
	return
end

function SkuldSystemTrustViewItem:Dispose()
	SkuldSystemTrustViewItem.super.Dispose(self)
end

return SkuldSystemTrustViewItem
