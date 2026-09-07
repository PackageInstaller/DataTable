local IslandRestaurantUpgradePage = class("IslandRestaurantUpgradePage", import("...base.IslandBasePage"))

function IslandRestaurantUpgradePage:getUIName()
	return "IslandRestaurantUpgradeUI"
end

function IslandRestaurantUpgradePage:OnLoaded()
	self.titleTF = self._tf:Find("title/name/Text")

	local var_2_0 = self._tf:Find("window/summary")

	setText(var_2_0:Find("title/Text"), i18n("island_manage_result_3"))

	self.shelfTF = var_2_0:Find("shelf/info/value")

	setText(var_2_0:Find("shelf/info/name"), i18n("island_manage_slot"))

	self.capacityTF = var_2_0:Find("capacity/info/value")

	setText(var_2_0:Find("capacity/info/name"), i18n("island_manage_food_cnt"))

	self.percentTF = var_2_0:Find("percent/info/value")

	setText(var_2_0:Find("percent/info/name"), i18n("island_manage_sale_ratio"))

	self.assistantTF = var_2_0:Find("assistant/info/value")

	setText(var_2_0:Find("assistant/info/name"), i18n("island_manage_worker_cnt"))

	self.viewTF = self._tf:Find("window/rank")
	self.uiList = UIItemList.New(self.viewTF:Find("content"), self.viewTF:Find("content/tpl"))

	setText(self._tf:Find("tip"), i18n("child_close_tip"))

	return
end

function IslandRestaurantUpgradePage:OnInit()
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_5_2.name = pg.island_manage_rank[self.rankIds[arg_5_1 + 1]].id

			LoadImageSpriteAsync("island/islandrestaurant/" .. pg.island_manage_rank[self.rankIds[arg_5_1 + 1]].icon, arg_5_2:Find("icon"))
			setActive(arg_5_2:Find("dot/silder"), arg_5_1 + 1 ~= #self.rankIds)
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:UpdataItem(arg_5_1, arg_5_2)
		end

		return
	end)

	self.rankIds = pg.island_manage_rank.all

	table.sort(self.rankIds)

	return
end

function IslandRestaurantUpgradePage:OnShow(arg_6_1, arg_6_2)
	self:BlurPanel()

	self.callback = arg_6_2
	self.restId = arg_6_1.restId
	self.oldSale = arg_6_1.oldSale
	self.rest = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(self.restId)
	self.level = self.rest:GetRankLevel()
	self.sales = self.rest:GetSales()
	self.expData = IslandRestaurant.GET_RNAK_EXPS(self.restId)

	setText(self.titleTF, self.rest:getConfig("name"))
	self:UpdataSummary()
	self.uiList:align(#self.rankIds)
	scrollTo(self.viewTF, (self.level - 1) / (#self.rankIds - 3), 0)

	return
end

function IslandRestaurantUpgradePage:UpdataItem(arg_7_1, arg_7_2)
	local var_7_0 = self.rankIds[arg_7_1]
	local var_7_1 = self.expData[self.rankIds[arg_7_1 + 1]]

	setActive(arg_7_2:Find("dot/finished"), self.rankIds[arg_7_1 + 1] <= self.level)

	local var_7_2 = self.expData[var_7_0] or 0

	setSlider(arg_7_2:Find("dot/silder"), 0, 1, (var_7_1 ~= var_7_2 or nil) and (self.sales - var_7_2) / (var_7_1 - var_7_2))

	return
end

function IslandRestaurantUpgradePage:UpdataSummary()
	local var_8_0 = pg.island_manage_rank[self.level]
	local var_8_1 = pg.island_manage_rank[self.level - 1]

	setText(self.shelfTF:Find("base"), pg.island_manage_rank[self.level - 1].slot_num[1])
	setText(self.shelfTF:Find("add"), (var_8_0.slot_num[1] - var_8_1.slot_num[1] > 0 or nil) and ("+" .. var_8_0.slot_num[1] - var_8_1.slot_num[1] or ""))
	setText(self.capacityTF:Find("base"), var_8_1.slot_num[2])
	setText(self.capacityTF:Find("add"), (var_8_0.slot_num[2] - var_8_1.slot_num[2] > 0 or nil) and ("+" .. var_8_0.slot_num[2] - var_8_1.slot_num[2] or ""))
	setText(self.percentTF:Find("base"), var_8_1.bonus_coefficient / 100 .. "%")
	setText(self.percentTF:Find("add"), ((var_8_0.bonus_coefficient - var_8_1.bonus_coefficient) / 100 > 0 or nil) and ("+" .. (var_8_0.bonus_coefficient - var_8_1.bonus_coefficient) / 100 .. "%" or ""))
	setText(self.assistantTF:Find("base"), var_8_1.assistant_num)
	setText(self.assistantTF:Find("add"), (var_8_0.assistant_num - var_8_1.assistant_num > 0 or nil) and ("+" .. var_8_0.assistant_num - var_8_1.assistant_num or ""))

	return
end

function IslandRestaurantUpgradePage:OnHide()
	self:UnBlurPanel()
	existCall(self.callback)

	self.callback = nil

	return
end

function IslandRestaurantUpgradePage:OnDestroy()
	self:UnBlurPanel()

	return
end

return IslandRestaurantUpgradePage
