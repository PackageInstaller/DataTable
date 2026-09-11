local FishingIllustratedItemView = class("FishingIllustratedItemView", ReduxView)

function FishingIllustratedItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingIllustratedItemView:Init()
	self:GetTmpCorners()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function FishingIllustratedItemView:InitUI()
	self:BindCfgUI()

	self.iconController_ = ControllerUtil.GetController(self.gameObject_.transform, "icon")
	self.upController_ = ControllerUtil.GetController(self.gameObject_.transform, "up")
	self.fishIcon_ = FishIcon.New(self.fishIconGo_)
end

function FishingIllustratedItemView:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		local var_5_0 = ActivityData:GetActivityData(ActivityConst.SUMMER_FISHING)

		if manager.time:GetServerTime() < var_5_0.startTime + self.cfg_.open_time then
			ShowTips((string.format(GetTips("PURCHASE_SYSTEM_NOT_OPEN"), tostring(manager.time:GetLostTimeStr(var_5_0.startTime + self.cfg_.open_time)))))

			return
		end

		JumpTools.OpenPageByJump("fishingBuy", {
			fishId = self.id_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("fishingInfoPop", {
			rect = self:GetScreenRect(self.container_),
			id = self.id_
		})
	end)
end

function FishingIllustratedItemView:AddEventListeners()
	self:RegistEventListener(FISHING_BUY_SUCCESS, function(arg_8_0)
		if arg_8_0 == self.id_ then
			self:UpdateView()
		end
	end)
end

function FishingIllustratedItemView:OnTop()
	self:UpdateBar()
end

function FishingIllustratedItemView:UpdateBar()
	return
end

function FishingIllustratedItemView:SetData(arg_11_1, arg_11_2)
	self.index_ = arg_11_1
	self.id_ = arg_11_2
	self.cfg_ = RareFishCfg[arg_11_2]

	self:UpdateView()
end

function FishingIllustratedItemView:UpdateView()
	if self.index_ % 2 == 1 then
		self.upController_:SetSelectedState("false")
	else
		self.upController_:SetSelectedState("true")
	end

	self.fishNameLabel_.text = GetI18NText(self.cfg_.name)

	local var_12_1 = FishingData:GetFish(self.id_)

	if var_12_1 ~= nil then
		self.haveValueLabel_.text = var_12_1.num
	end

	if FishingData:GetFish(self.id_) ~= nil then
		self.iconController_:SetSelectedState("false")
	else
		self.iconController_:SetSelectedState("not")
	end

	self.fishIcon_:SetId(self.id_)

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	self.pic_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishRole/" .. self.id_)

	self.pic_:SetNativeSize()

	self.priceLabel_.text = RareFishCfg[self.id_].price
end

function FishingIllustratedItemView:OnEnter()
	return
end

function FishingIllustratedItemView:OnExit()
	return
end

function FishingIllustratedItemView:OnMainHomeViewTop()
	return
end

function FishingIllustratedItemView:GetScreenRect(arg_16_1)
	local var_16_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_16_1:GetWorldCorners(self.corners)

	local var_16_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, self.corners[0])

	return (UnityEngine.Rect.New(var_16_1, UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, self.corners[2]) - var_16_1))
end

function FishingIllustratedItemView:GetTmpCorners()
	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function FishingIllustratedItemView:Dispose()
	self:RemoveAllEventListener()

	if self.fishIcon_ then
		self.fishIcon_:Dispose()

		self.fishIcon_ = nil
	end

	FishingIllustratedItemView.super.Dispose(self)
end

return FishingIllustratedItemView
