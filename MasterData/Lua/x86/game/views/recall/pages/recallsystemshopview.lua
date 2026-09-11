local RecallSystemShopView = class("RecallSystemShopView", (import("game.views.recall.pages.RecallPageBase")))

function RecallSystemShopView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemShopView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RecallSystemShopItem)

	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_3_0, arg_3_1)
		self:UpdateView(arg_3_0, arg_3_1)
	end)
	self:RegistEventListener(MATERIAL_MODIFY, function(arg_4_0)
		self:UpdateView()
	end)

	self.shopID = ActivityRecallData:GetDataByPara("shopID")
end

function RecallSystemShopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.shopData[arg_5_1])
end

function RecallSystemShopView:OnTop()
	return
end

function RecallSystemShopView:UpdateView()
	ActivityRecallData:UpdateShopData()

	self.shopID = ActivityRecallData:GetDataByPara("shopID")
	self.shopData = ActivityRecallData:GetDataByPara("shopData")

	self.list_:StartScroll(#self.shopData)

	self.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("shopTime")
end

function RecallSystemShopView:OnEnter()
	self:UpdateView()
	self:OnTop()
end

function RecallSystemShopView:OnExit()
	return
end

function RecallSystemShopView:Hide()
	RecallSystemShopView.super.Hide(self)
end

function RecallSystemShopView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RecallSystemShopView.super.Dispose(self)
end

return RecallSystemShopView
