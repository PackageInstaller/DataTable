local RechargeRecommendBgItemView = class("RechargeRecommendBgItemView", ReduxView)

function RechargeRecommendBgItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RechargeRecommendBgItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeRecommendBgItemView:InitUI()
	self:BindCfgUI()
end

function RechargeRecommendBgItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		OperationRecorder.RecordButtonTouch("shop_recommend_right_" .. self.cfg_.goods_id)

		local var_5_0 = self.cfg_.jump

		if self.cfg_.goods_id == 0 then
			-- block empty
		end

		local var_5_1 = self.cfg_
		local var_5_2 = not self.cfg_.time[1] or #self.cfg_.time[1][1] < 3 or #self.cfg_.time[1][2] < 3
		local var_5_3 = var_5_1.time[2]

		if not var_5_1.time[2] or #var_5_3[1] < 3 or #var_5_3[2] < 3 then
			var_5_2 = true
		end

		if not var_5_2 then
			local var_5_4 = TimeMgr.GetInstance():GetServerTime()

			var_5_2 = var_5_4 < TimeMgr.GetInstance():parseTimeFromConfig(var_5_1.time[2]) and TimeMgr.GetInstance():parseTimeFromConfig(var_5_1.time[1]) <= var_5_4
		end

		local var_5_5

		if self.cfg_.jump2 ~= "" then
			if #self.cfg_.jump2 == 5 then
				var_5_5 = self.cfg_.jump2[5]
				var_5_2 = ShopTools.IsGoodCanDisplay(self.cfg_.jump2[5], self.cfg_.jump2[2])
			elseif #self.cfg_.jump2 == 3 then
				var_5_5 = self.cfg_.jump2[3]
				var_5_2 = ShopTools.IsGoodCanDisplay(self.cfg_.jump2[3], self.cfg_.jump2[2])
			end
		end

		if var_5_5 then
			local var_5_6, var_5_7 = ShopTools.IsShopSuspended(var_5_5)

			if var_5_6 then
				ShowTips(var_5_7)

				return
			end
		end

		if var_5_2 then
			JumpTools.JumpToPage2(var_5_0, function()
				if self.cfg_.jump2 ~= nil and self.cfg_.jump2 ~= "" then
					JumpTools.JumpToPage(self.cfg_.jump2)
				end
			end)
		else
			ShowTips("GOODS_HAS_BEEN_REMOVED")
		end
	end)

	if self.infoBtn_ then
		self:AddBtnListener(self.infoBtn_, nil, function()
			local var_7_0 = ""

			if self.cfg_.info_desc[1] == 1 then
				var_7_0 = RechargeShopDescriptionCfg[self.cfg_.info_desc[2]].desc2
			else
				print("未支持对应类型的说明文本", self.cfg_.info_desc[1])
			end

			JumpTools.OpenPageByJump("gameHelp", {
				title = GetTips("SHOP_GIFT_DESCRIBE"),
				content = var_7_0
			})
		end)
	end
end

function RechargeRecommendBgItemView:AddEventListeners()
	return
end

function RechargeRecommendBgItemView:SetData(arg_9_1, arg_9_2)
	self.index_ = arg_9_1
	self.cfg_ = arg_9_2

	self:UpdateView()
end

function RechargeRecommendBgItemView:UpdateView()
	if self.timeGo_ then
		SetActive(self.timeGo_, self.cfg_.show_time ~= "")

		self.timeTxt_.text = self.cfg_.show_time

		if self.dlcImg_ then
			self.dlcImg_.spriteSync = ItemTools.getItemSprite(self.cfg_.new_currency_dlc_icon[1])
		end
	end
end

function RechargeRecommendBgItemView:OnEnter()
	self:AddEventListeners()
end

function RechargeRecommendBgItemView:OnExit()
	self:RemoveAllEventListener()
end

function RechargeRecommendBgItemView:OnMainHomeViewTop()
	return
end

function RechargeRecommendBgItemView:Hide()
	SetActive(self.gameObject_, false)
end

function RechargeRecommendBgItemView:Show()
	SetActive(self.gameObject_, true)
end

function RechargeRecommendBgItemView:Dispose()
	self.data_ = nil

	RechargeRecommendBgItemView.super.Dispose(self)
end

return RechargeRecommendBgItemView
