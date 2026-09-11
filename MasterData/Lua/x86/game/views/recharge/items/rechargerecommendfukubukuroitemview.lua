local RechargeRecommendFukubukuroItemView = class("RechargeRecommendFukubukuroItemView", RechargeRecommendBgItemView)

function RechargeRecommendFukubukuroItemView:InitUI()
	RechargeRecommendFukubukuroItemView.super.InitUI(self)

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItemView)
end

function RechargeRecommendFukubukuroItemView:AddUIListener()
	RechargeRecommendFukubukuroItemView.super.AddUIListener(self)
	self:AddBtnListener(nil, self.m_rareBtn, function()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = self.itemId
		})
	end)
end

function RechargeRecommendFukubukuroItemView:UpdateView()
	RechargeRecommendFukubukuroItemView.super.UpdateView(self)

	self.itemId = self.cfg_ and self.cfg_.params ~= "" and (self.cfg_.params[1] or 0) or 0
	self.items = ItemCfg[self.itemId].param

	self.list:StartScroll(#self.items)
end

function RechargeRecommendFukubukuroItemView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.items[arg_5_1][1]
	var_5_0.number = self.items[arg_5_1][2]

	function var_5_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_0.id
		})
	end

	arg_5_2:SetData(var_5_0)
	arg_5_2:Show(true)
end

function RechargeRecommendFukubukuroItemView:Dispose()
	self.list:Dispose()
	RechargeRecommendFukubukuroItemView.super.Dispose(self)
end

return RechargeRecommendFukubukuroItemView
