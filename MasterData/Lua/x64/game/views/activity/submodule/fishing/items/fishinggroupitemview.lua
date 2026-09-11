local FishingGroupItemView = class("FishingGroupItemView", ReduxView)

function FishingGroupItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingGroupItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function FishingGroupItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.fishList_ = LuaList.New(handler(self, self.indexFishItem), self.fishListGo_, FishIcon)
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.bonusListGo_, CommonItem)
end

function FishingGroupItemView:indexItem(arg_4_1, arg_4_2)
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

function FishingGroupItemView:indexFishItem(arg_6_1, arg_6_2)
	arg_6_2:SetNeedUpdateHave(true)

	local var_6_1 = FishingData:GetFish(self.cfg_.group[1][arg_6_1])

	arg_6_2:SetId(self.cfg_.group[1][arg_6_1], 1, (var_6_1 or nil) and var_6_1.num)
end

function FishingGroupItemView:AddUIListener()
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		FishingAction.GetConstituteFishBonus(ActivityConst.SUMMER_FISHING, self.groupId_)
	end)
end

function FishingGroupItemView:AddEventListeners()
	self:RegistEventListener(RARE_FISH_CHANGE, function(arg_10_0)
		if table.indexof(self.cfg_.group[1], arg_10_0) or arg_10_0 == 0 then
			self:UpdateView()
		end
	end)
end

function FishingGroupItemView:OnTop()
	self:UpdateBar()
end

function FishingGroupItemView:UpdateBar()
	return
end

function FishingGroupItemView:SetId(arg_13_1)
	self.groupId_ = arg_13_1
	self.cfg_ = ActivitySummerFishGroupCfg[arg_13_1]

	self:UpdateView()
end

function FishingGroupItemView:UpdateView()
	self.groupNameLabel_.text = GetI18NText(self.cfg_.name)

	self.fishList_:StartScroll(#self.cfg_.group[1])
	self.uiList_:StartScroll(#self.cfg_.reward_item_list)

	local var_14_0 = true

	for iter_14_0, iter_14_1 in ipairs(self.cfg_.group[1]) do
		local var_14_2 = FishingData:GetActivityData().fish_infos[iter_14_1]

		if not (var_14_2 and var_14_2.num > 0) then
			var_14_0 = false

			break
		end
	end

	if table.indexof(FishingData:GetActivityData().received_constitute_list, self.cfg_.id) then
		self.statusController_:SetSelectedState("haveGet")
	elseif not var_14_0 then
		self.statusController_:SetSelectedState("cannotGet")
	else
		self.statusController_:SetSelectedState("canGet")
	end
end

function FishingGroupItemView:OnEnter()
	return
end

function FishingGroupItemView:OnExit()
	return
end

function FishingGroupItemView:OnMainHomeViewTop()
	return
end

function FishingGroupItemView:Dispose()
	self:RemoveAllEventListener()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.fishList_ then
		self.fishList_:Dispose()

		self.fishList_ = nil
	end

	FishingGroupItemView.super.Dispose(self)
end

return FishingGroupItemView
