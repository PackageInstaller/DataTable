local ActivityShopSubmoduleItem = class("ActivityShopSubmoduleItem", ReduxView)

function ActivityShopSubmoduleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.theme_ = ActivityCfg[arg_1_2].activity_theme
	self.shopList_ = shopList

	self:BindCfgUI()
	self:AddListeners()

	self.shopController_ = ControllerUtil.GetController(self.transform_, "name")
end

function ActivityShopSubmoduleItem:OnEnter()
	self:AddTimer()
end

function ActivityShopSubmoduleItem:OnExit()
	self:StopTimer()
end

function ActivityShopSubmoduleItem:Dispose()
	ActivityShopSubmoduleItem.super.Dispose(self)
end

function ActivityShopSubmoduleItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_6_0 = {}
		local var_6_1 = {}

		if ActivityShopCfg.get_id_list_by_activity_theme[self.theme_] == nil then
			return
		end

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[self.theme_]) do
			table.insert(var_6_0, ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)
			table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
		end

		if #var_6_0 <= 0 then
			return
		end

		local var_6_3 = var_6_1[1]

		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			local var_6_4 = ActivityData:GetActivityData(iter_6_3).stopTime - manager.time:GetServerTime()

			if var_6_4 > 0 and (0 == 0 or var_6_4 < 0) then
				var_6_3 = var_6_1[iter_6_2]
			end
		end

		local var_6_6, var_6_7 = ShopTools.IsShopOpen(var_6_3)

		if var_6_6 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_3,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_7 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_7 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
end

function ActivityShopSubmoduleItem:AddTimer()
	self:StopTimer()

	local var_7_0 = {}

	if ActivityShopCfg.get_id_list_by_activity_theme[self.theme_] == nil or self.shopTimeText_ == nil then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[self.theme_]) do
		table.insert(var_7_0, ShopListCfg[ActivityShopCfg[iter_7_1].shop_id].activity_id)
	end

	if #var_7_0 <= 0 then
		return
	end

	local var_7_1

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		local var_7_2 = ActivityData:GetActivityData(iter_7_3).stopTime - manager.time:GetServerTime()

		if var_7_2 > 0 and (0 == 0 or var_7_2 < 0) then
			var_7_1 = iter_7_3
		end
	end

	if var_7_1 == nil then
		self.shopController_:SetSelectedState("off")

		return
	end

	local var_7_4 = ActivityData:GetActivityData(var_7_1).stopTime
	local var_7_5 = var_7_4 - manager.time:GetServerTime()

	if var_7_5 < 0 then
		self.shopController_:SetSelectedState("off")

		return
	end

	local var_7_6 = true
	local var_7_7 = 432000

	if var_7_5 <= 432000 then
		self.shopController_:SetSelectedState("on")

		self.shopTimeText_.text = manager.time:GetLostTimeStr2(var_7_4, nil, true)
	else
		self.shopController_:SetSelectedState("off")

		var_7_6 = false
	end

	self.timer_ = Timer.New(function()
		var_7_5 = var_7_4 - manager.time:GetServerTime()

		if var_7_5 <= var_7_7 then
			if var_7_5 <= 0 then
				self.shopController_:SetSelectedState("off")
				self:StopTimer()
				self:AddTimer()

				return
			end

			if var_7_6 then
				self.shopController_:SetSelectedState("on")

				self.shopTimeText_.text = manager.time:GetLostTimeStr2(var_7_4, nil, true)
				var_7_6 = false
			end

			self.shopTimeText_.text = manager.time:GetLostTimeStr2(var_7_4, nil, true)
		elseif var_7_6 == false then
			self.shopController_:SetSelectedState("off")

			var_7_6 = true
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivityShopSubmoduleItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityShopSubmoduleItem
