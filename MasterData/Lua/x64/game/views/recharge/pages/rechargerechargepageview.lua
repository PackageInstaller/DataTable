local RechargeRechargePageView = class("RechargeRechargePageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeRechargePageView:Init(...)
	self:InitConfig()
	RechargeRechargePageView.super.Init(self, ...)
end

function RechargeRechargePageView:InitConfig()
	self.rechargeDataList_ = {}

	for iter_2_0, iter_2_1 in ipairs(RechargeCfg.all) do
		table.insert(self.rechargeDataList_, RechargeCfg[iter_2_1])
	end
end

function RechargeRechargePageView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, RechargeRechargeItemView)
end

function RechargeRechargePageView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.rechargeDataList_[arg_4_1], {})
end

function RechargeRechargePageView:AddUIListener()
	self:AddBtnListener(self.fundsettlementmethodBtn_, nil, function()
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
	end)
	self:AddBtnListener(self.commercialBtn_, nil, function()
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
	end)

	if SDKTools.GetIsInputServer("kr") then
		self:AddBtnListener(self.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end
end

function RechargeRechargePageView:OnTop()
	return
end

function RechargeRechargePageView:OnEnter()
	self.list_:StartScroll(#self.rechargeDataList_)
	SetActive(self.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(self.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(self.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(self.refundbtn_.gameObject, self.curPageIndex_ ~= 4 and self.curPageIndex_ ~= 6)
	end
end

function RechargeRechargePageView:OnExit()
	return
end

function RechargeRechargePageView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RechargeRechargePageView.super.Dispose(self)
end

return RechargeRechargePageView
