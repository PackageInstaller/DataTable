local FishingGroupPageView = class("FishingGroupPageView", ReduxView)

function FishingGroupPageView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingGroupPageView:Init()
	self.idList_ = ActivitySummerFishGroupCfg.all

	self:InitUI()
	self:AddUIListener()
end

function FishingGroupPageView:SortData()
	local var_3_0 = FishingData:GetActivityData().received_constitute_list

	table.sort(self.idList_, function(arg_4_0, arg_4_1)
		local var_4_0 = ActivitySummerFishGroupCfg[arg_4_0]
		local var_4_1 = ActivitySummerFishGroupCfg[arg_4_1]
		local var_4_2 = table.indexof(var_3_0, ActivitySummerFishGroupCfg[arg_4_0].id) or 0
		local var_4_3 = table.indexof(var_3_0, ActivitySummerFishGroupCfg[arg_4_1].id) or 0

		if (var_4_2 == 0 or var_4_3 == 0) and var_4_2 ~= var_4_3 then
			return var_4_2 < var_4_3
		end

		local var_4_4 = 1

		for iter_4_0, iter_4_1 in ipairs(var_4_0.group[1]) do
			local var_4_6 = FishingData:GetActivityData().fish_infos[iter_4_1]

			if not (var_4_6 and var_4_6.num > 0) then
				var_4_4 = 0

				break
			end
		end

		local var_4_7 = 1

		for iter_4_2, iter_4_3 in ipairs(var_4_1.group[1]) do
			local var_4_9 = FishingData:GetActivityData().fish_infos[iter_4_3]

			if not (var_4_9 and var_4_9.num > 0) then
				var_4_7 = 0

				break
			end
		end

		if var_4_7 ~= var_4_4 then
			return var_4_7 < var_4_4
		end

		return arg_4_0 < arg_4_1
	end)
end

function FishingGroupPageView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, FishingGroupItemView)
end

function FishingGroupPageView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetId(self.idList_[arg_6_1])
end

function FishingGroupPageView:AddUIListener()
	return
end

function FishingGroupPageView:AddEventListeners()
	self:RegistEventListener(FISHING_GROUP_REWARD_CHANGE, function()
		self:UpdateView()
	end)
end

function FishingGroupPageView:OnTop()
	self:UpdateBar()
end

function FishingGroupPageView:UpdateBar()
	return
end

function FishingGroupPageView:OnEnter()
	self:AddEventListeners()
	self:UpdateView()
end

function FishingGroupPageView:UpdateView()
	self:SortData()
	self.uiList_:StartScroll(#self.idList_)
end

function FishingGroupPageView:OnExit()
	self:RemoveAllEventListener()
end

function FishingGroupPageView:OnMainHomeViewTop()
	return
end

function FishingGroupPageView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingGroupPageView.super.Dispose(self)
end

return FishingGroupPageView
