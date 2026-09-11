local FishingRewardItemView = class("FishingRewardItemView", ReduxView)

function FishingRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function FishingRewardItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.bonusListGo_, CommonItem)
end

function FishingRewardItemView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id
		})
	end)
	arg_4_2:RefreshData({
		id = self.cfg_.reward_item_list[arg_4_1][1],
		number = self.cfg_.reward_item_list[arg_4_1][2]
	})
end

function FishingRewardItemView:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		FishingAction.GetBonus(ActivityConst.SUMMER_FISHING, self.id_)
	end)
end

function FishingRewardItemView:AddEventListeners()
	return
end

function FishingRewardItemView:OnTop()
	self:UpdateBar()
end

function FishingRewardItemView:UpdateBar()
	return
end

function FishingRewardItemView:SetId(arg_11_1)
	self.id_ = arg_11_1
	self.cfg_ = ActivityPointRewardCfg[arg_11_1]

	self:UpdateView()
end

function FishingRewardItemView:UpdateView()
	self.uiList_:StartScroll(#self.cfg_.reward_item_list)

	self.conditionLabel_.text = tostring(self.cfg_.need)

	local var_12_1 = FishingData:GetActivityData()

	if ((var_12_1 or nil) and var_12_1.score) < self.cfg_.need then
		self.statusController_:SetSelectedState("cannotGet")
	elseif table.indexof(FishingData:GetActivityData().received_award_list, self.cfg_.id) then
		self.statusController_:SetSelectedState("haveGet")
	else
		self.statusController_:SetSelectedState("canGet")
	end
end

function FishingRewardItemView:OnEnter()
	return
end

function FishingRewardItemView:OnExit()
	return
end

function FishingRewardItemView:OnMainHomeViewTop()
	return
end

function FishingRewardItemView:Dispose()
	self:RemoveAllEventListener()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingRewardItemView.super.Dispose(self)
end

return FishingRewardItemView
