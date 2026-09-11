local DormLinkGameBubbleItem = class("DormLinkGameBubbleItem", ReduxView)

function DormLinkGameBubbleItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_3)
	self.transform_ = self.gameObject_.transform
	self.customerID = arg_1_2

	self:Init()
end

function DormLinkGameBubbleItem:Init()
	self:InitUI()

	self.materialScroll = LuaList.New(handler(self, self.indexMaterialList), self.uilistGo_, DormLinkGameMaterialItem)

	self:InitSatiety()
	self:RefreshSatiety()

	self.animator = self.bubbleGo_:GetComponent("Animation")
end

function DormLinkGameBubbleItem:InitUI()
	self:BindCfgUI()
end

function DormLinkGameBubbleItem:InitSatiety()
	self.slider.minValue = ActivityLinkGameCustomerCfg[self.customerID].satiety_limit[1]
	self.slider.maxValue = ActivityLinkGameCustomerCfg[self.customerID].satiety_limit[2]
	self.image2Img_.fillAmount = (ActivityLinkGameCustomerCfg[self.customerID].satiety_limit[2] - ActivityLinkGameCustomerCfg[self.customerID].satiety_score_up[3][2][1]) / ActivityLinkGameCustomerCfg[self.customerID].satiety_limit[2]
	self.image1Img_.fillAmount = (ActivityLinkGameCustomerCfg[self.customerID].satiety_limit[2] - ActivityLinkGameCustomerCfg[self.customerID].satiety_score_up[2][2][1]) / ActivityLinkGameCustomerCfg[self.customerID].satiety_limit[2]

	self:RefreshSatiety()
end

function DormLinkGameBubbleItem:RefreshBubbleInfo(arg_5_1)
	self.foodID = DormLinkGameData:GetCustomerInfo(self.customerID).curPreference
	self.materilaList = ActivityLinkGameComposeCfg[self.foodID].compose_list

	self.materialScroll:StartScroll(#self.materilaList)

	if arg_5_1 then
		self.animator:Play()
	end
end

function DormLinkGameBubbleItem:RefreshSatiety()
	self.slider.value = DormLinkGameData:GetCustomerInfo(self.customerID).satietyNum
end

function DormLinkGameBubbleItem:RefreshTransPosition()
	DormLinkGameData:GetCustomerInfo(self.customerID):RefreshCustomerBubble(self.transform_)
end

function DormLinkGameBubbleItem:indexMaterialList(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(self.materilaList[arg_8_1])
end

function DormLinkGameBubbleItem:SetActive(arg_9_1)
	self.gameObject_:SetActive(arg_9_1)
end

function DormLinkGameBubbleItem:Dispose()
	if self.materialScroll then
		self.materialScroll:Dispose()

		self.materialScroll = nil
	end

	DormLinkGameBubbleItem.super.Dispose(self)
end

return DormLinkGameBubbleItem
