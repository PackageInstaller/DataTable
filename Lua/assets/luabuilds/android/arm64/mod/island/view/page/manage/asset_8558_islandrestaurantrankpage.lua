local IslandRestaurantRankPage = class("IslandRestaurantRankPage", import("...base.IslandBasePage"))

function IslandRestaurantRankPage:getUIName()
	return "IslandRestaurantRankUI"
end

function IslandRestaurantRankPage:OnLoaded()
	self.viewTF = self._tf:Find("window/view")

	local var_2_0 = self.viewTF:Find("content")
	local var_2_1 = var_2_0:Find("tpl")

	setText(var_2_1:Find("info/top/exp/name"), i18n("island_manage_need_ext"))
	setText(var_2_1:Find("info/top/finished/Text"), i18n("island_manage_reach"))
	setText(var_2_1:Find("info/bottom/content/shelf/info/name"), i18n("island_manage_slot"))
	setText(var_2_1:Find("info/bottom/content/capacity/info/name"), i18n("island_manage_food_cnt"))
	setText(var_2_1:Find("info/bottom/content/percent/info/name"), i18n("island_manage_sale_ratio"))
	setText(var_2_1:Find("info/bottom/content/assistant/info/name"), i18n("island_manage_worker_cnt"))

	self.uiList = UIItemList.New(var_2_0, var_2_1)

	return
end

function IslandRestaurantRankPage:OnInit()
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("window/close"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			self:InitItem(arg_6_1, arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			self:UpdataItem(arg_6_1, arg_6_2)
		end

		return
	end)

	self.rankIds = pg.island_manage_rank.all

	table.sort(self.rankIds)

	return
end

function IslandRestaurantRankPage:InitItem(arg_7_1, arg_7_2)
	arg_7_2.name = pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].id

	LoadImageSpriteAsync("island/islandrestaurant/" .. pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].icon, arg_7_2:Find("icon"))
	setText(arg_7_2:Find("info/top/name"), pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].name)

	local var_7_0 = arg_7_2:Find("info/bottom/content")

	setText(var_7_0:Find("shelf/info/value"), pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].slot_num[1])
	setText(var_7_0:Find("capacity/info/value"), pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].slot_num[2])
	setText(var_7_0:Find("percent/info/value"), pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].bonus_coefficient / 100 .. "%")
	setText(var_7_0:Find("assistant/info/value"), pg.island_manage_rank[self.rankIds[arg_7_1 + 1]].assistant_num)
	setActive(arg_7_2:Find("dot/silder"), arg_7_1 + 1 ~= #self.rankIds)

	return
end

function IslandRestaurantRankPage:UpdataItem(arg_8_1, arg_8_2)
	local var_8_0 = self.rankIds[arg_8_1]
	local var_8_1 = self.expData[self.rankIds[arg_8_1 + 1]]
	local var_8_2 = self.rankIds[arg_8_1 + 1] <= self.level

	setActive(arg_8_2:Find("dot/finished"), self.rankIds[arg_8_1 + 1] <= self.level)
	setActive(arg_8_2:Find("info/top/finished"), var_8_2)
	setActive(arg_8_2:Find("info/top/exp"), not var_8_2)

	local var_8_3 = self.expData[var_8_0] or 0

	setSlider(arg_8_2:Find("dot/silder"), 0, 1, (var_8_1 ~= var_8_3 or nil) and (self.sales - var_8_3) / (var_8_1 - var_8_3))
	setText(arg_8_2:Find("info/top/exp/value"), self.sales .. "/" .. var_8_3)

	return
end

function IslandRestaurantRankPage:OnShow(arg_9_1)
	self:BlurPanel()

	self.rest = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(arg_9_1)
	self.level = self.rest:GetRankLevel()
	self.sales = self.rest:GetSales()
	self.expData = IslandRestaurant.GET_RNAK_EXPS(arg_9_1)

	self.uiList:align(#self.rankIds)

	local var_9_0 = {}

	self.uiList:eachActive(function(arg_10_0, arg_10_1)
		arg_10_1:GetComponent(typeof(CanvasGroup)).alpha = 0

		table.insert(var_9_0, function(arg_11_0)
			arg_10_1:GetComponent(typeof(CanvasGroup)).alpha = 1

			arg_10_1:GetComponent(typeof(Animation)):Play()
			self:managedTween(LeanTween.delayedCall, function()
				arg_11_0()

				return
			end, 0.03, nil)

			return
		end)

		return
	end)
	seriesAsync(var_9_0, function()
		scrollTo(self.viewTF, 0, 1 - (self.level - 1) / (#self.rankIds - 3))

		return
	end)

	return
end

function IslandRestaurantRankPage:OnHide()
	self:UnBlurPanel()

	return
end

function IslandRestaurantRankPage:OnDestroy()
	self:OnHide()

	return
end

return IslandRestaurantRankPage
