local IslandAchvDetailPage = class("IslandAchvDetailPage", import("...base.IslandBasePage"))

function IslandAchvDetailPage:getUIName()
	return "IslandAchvDetailUI"
end

function IslandAchvDetailPage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_achievement_title"))
	setText(self._tf:Find("total/Text"), i18n("island_achv_total"))

	self.totalTF = self._tf:Find("total/value")

	local var_2_0 = self._tf:Find("toggles/content")

	self.typeUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	setActive(self._tf:Find("tpl"), false)
	setText(self._tf:Find("tpl/status/get/Text"), i18n("handbook_claim"))
	setText(self._tf:Find("tpl/status/got/Text"), i18n("handbook_finished"))

	self.scrollRect = self._tf:Find("view"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandAchvDetailPage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.typeUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventInit then
			self:InitToggle(arg_7_1, arg_7_2)
		elseif arg_7_0 == UIItemList.EventUpdate then
			self:UpdateToggle(arg_7_1, arg_7_2)
		end

		return
	end)

	self.typeIds = pg.island_achievement_group.all
	self.cards = {}

	return
end

function IslandAchvDetailPage:InitToggle(arg_8_1, arg_8_2)
	local var_8_0 = self.typeIds[arg_8_1 + 1]

	arg_8_2.name = self.typeIds[arg_8_1 + 1]

	LoadImageSpriteAtlasAsync("islandachievement", pg.island_achievement_group[self.typeIds[arg_8_1 + 1]].icon, arg_8_2:Find("icon"), true)
	setText(arg_8_2:Find("name"), pg.island_achievement_group[self.typeIds[arg_8_1 + 1]].name)
	onToggle(self, arg_8_2, function(arg_9_0)
		if arg_9_0 then
			arg_8_2:GetComponent(typeof(Animation)):Play()

			self.showType = var_8_0

			self:FlushDetail()
		end

		return
	end, SFX_PANEL)

	return
end

function IslandAchvDetailPage:UpdateToggle(arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(pg.island_achievement_group[self.typeIds[arg_10_1 + 1]].achievement_list) do
		for iter_10_2, iter_10_3 in ipairs(self.achvAgency:GetGroup(iter_10_1):GetSortAchvList()) do
			table.insert(var_10_0, iter_10_3)
		end
	end

	setActive(arg_10_2:Find("name/tip"), (underscore.any(var_10_0, function(arg_11_0)
		return arg_11_0:GetStatus() == IslandAchievement.STATUS.GET
	end)))

	return
end

function IslandAchvDetailPage:AddListeners()
	self:AddListener(GAME.ISLAND_GET_ACHV_AWARD_DONE, self.OnGetAchvAwardDone)

	return
end

function IslandAchvDetailPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_GET_ACHV_AWARD_DONE, self.OnGetAchvAwardDone)

	return
end

function IslandAchvDetailPage:OnShow(arg_14_1)
	self.showType = arg_14_1 or pg.island_achievement_group.all[1]

	self:Flush()

	return
end

function IslandAchvDetailPage:Flush()
	self.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	setText(self.totalTF, #self.achvAgency:GetGotList() .. "/" .. self.achvAgency:GetTotalCnt())
	self.typeUIList:align(#self.typeIds)
	triggerToggle(self.typeUIList.container:Find(tostring(self.showType)), true)

	return
end

function IslandAchvDetailPage:FlushDetail()
	self.showGroupIds = pg.island_achievement_group[self.showType].achievement_list
	self.showAchvList = underscore.map(self.showGroupIds, function(arg_17_0)
		local var_17_0 = underscore.select(self.achvAgency:GetGroup(arg_17_0):GetSortAchvList(), function(arg_18_0)
			return not arg_18_0:IsHideType() or arg_18_0:GetStatus() == IslandAchievement.STATUS.GET
		end)

		return underscore.detect(var_17_0, function(arg_19_0)
			return arg_19_0:GetStatus() ~= IslandAchievement.STATUS.GOT
		end) or var_17_0[#var_17_0]
	end)

	table.sort(self.showAchvList, CompareFuncs({
		function(arg_20_0)
			return arg_20_0:GetStatus() == IslandAchievement.STATUS.GET and 0 or 1
		end,
		function(arg_21_0)
			return arg_21_0:GetStatus() == IslandAchievement.STATUS.GOT and 1 or 0
		end,
		function(arg_22_0)
			return arg_22_0.id
		end
	}))

	self.scrollRect.enabled = true

	self.scrollRect:SetTotalCount(#self.showAchvList, 0)

	return
end

function IslandAchvDetailPage:OnInitItem(arg_23_1)
	local var_23_0 = IslandAchievementCard.New(arg_23_1, self)

	self.cards[arg_23_1] = var_23_0

	onButton(self, var_23_0.getBtn, function()
		var_23_0._tf:GetComponent(typeof(Animation)):Play()
		self:emit(IslandMediator.GET_ACHIEVEMENT_AWARD, {
			var_23_0.achv.id
		})

		return
	end, SFX_PANEL)

	return
end

function IslandAchvDetailPage:OnUpdateItem(arg_25_1, arg_25_2)
	local var_25_0 = self.cards[arg_25_2]

	if not self.cards[arg_25_2] then
		self:OnInitItem(arg_25_2)

		var_25_0 = self.cards[arg_25_2]
	end

	if self.showAchvList[arg_25_1 + 1] then
		var_25_0:Update(self.showAchvList[arg_25_1 + 1])
	end

	return
end

function IslandAchvDetailPage:OnGetAchvAwardDone(arg_26_1)
	local var_26_0 = arg_26_1.id

	local function var_26_1()
		for iter_27_0, iter_27_1 in pairs(self.cards) do
			if iter_27_1.achv.id == var_26_0 then
				return iter_27_1
			end
		end

		return
	end

	seriesAsync({
		function(arg_28_0)
			local var_28_0 = var_26_1()

			if var_28_0 then
				var_28_0:PlayStageAnim(var_26_0, arg_28_0)
			else
				arg_28_0()
			end

			return
		end
	}, function()
		self.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

		setText(self.totalTF, #self.achvAgency:GetGotList() .. "/" .. self.achvAgency:GetTotalCnt())
		self.typeUIList:align(#self.typeIds)
		self:FlushDetail()

		return
	end)

	return
end

function IslandAchvDetailPage:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	for iter_30_0, iter_30_1 in pairs(self.cards) do
		iter_30_1:Dispose()
	end

	self.cards = {}

	return
end

return IslandAchvDetailPage
