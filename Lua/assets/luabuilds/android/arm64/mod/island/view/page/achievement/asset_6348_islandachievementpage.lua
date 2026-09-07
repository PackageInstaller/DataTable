local IslandAchievementPage = class("IslandAchievementPage", import("...base.IslandBasePage"))

function IslandAchievementPage:getUIName()
	return "IslandAchievementUI"
end

function IslandAchievementPage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_achievement_title"))
	setText(self._tf:Find("top/total/Text"), i18n("island_achv_total"))

	self.totalTF = self._tf:Find("top/total/value")

	local var_2_0 = self._tf:Find("view/content")

	self.uiList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	return
end

function IslandAchievementPage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			self:InitItem(arg_5_1, arg_5_2)
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_5_1, arg_5_2)
		end

		return
	end)

	self.typeIds = pg.island_achievement_group.all

	return
end

function IslandAchievementPage:OnShow()
	self:Flush()

	return
end

function IslandAchievementPage:AddListeners()
	self:AddListener(GAME.ISLAND_GET_ACHV_AWARD_DONE, self.Flush)

	return
end

function IslandAchievementPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_GET_ACHV_AWARD_DONE, self.Flush)

	return
end

function IslandAchievementPage:Flush()
	self.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	setText(self.totalTF, #self.achvAgency:GetGotList() .. "/" .. self.achvAgency:GetTotalCnt())
	self.uiList:align(#self.typeIds)

	return
end

function IslandAchievementPage:InitItem(arg_10_1, arg_10_2)
	local var_10_0 = self.typeIds[arg_10_1 + 1]

	arg_10_2.name = self.typeIds[arg_10_1 + 1]

	LoadImageSpriteAtlasAsync("islandachievement", pg.island_achievement_group[self.typeIds[arg_10_1 + 1]].icon, arg_10_2:Find("icon"), true)
	setText(arg_10_2:Find("name"), pg.island_achievement_group[self.typeIds[arg_10_1 + 1]].name)
	onButton(self, arg_10_2, function()
		self:OpenPage(IslandAchvDetailPage, var_10_0)

		return
	end, SFX_PANEL)

	return
end

function IslandAchievementPage:UpdateItem(arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(pg.island_achievement_group[self.typeIds[arg_12_1 + 1]].achievement_list) do
		for iter_12_2, iter_12_3 in ipairs(self.achvAgency:GetGroup(iter_12_1):GetSortAchvList()) do
			table.insert(var_12_0, iter_12_3)
		end
	end

	local var_12_1 = underscore.reduce(var_12_0, 0, function(arg_13_0, arg_13_1)
		return arg_13_0 + (arg_13_1:GetStatus() == IslandAchievement.STATUS.GOT and 1 or 0)
	end)
	local var_12_2 = underscore.reduce(var_12_0, 0, function(arg_14_0, arg_14_1)
		return arg_14_0 + (arg_14_1:IsHideType() and 0 or 1)
	end)

	setText(arg_12_2:Find("progress/cur"), var_12_1)
	setText(arg_12_2:Find("progress/all"), "/" .. var_12_2)

	arg_12_2:Find("bar"):GetComponent(typeof(Image)).fillAmount = var_12_1 / var_12_2

	local var_12_3 = var_12_1 == var_12_2

	setActive(arg_12_2:Find("bg"), not (var_12_1 == var_12_2))
	setActive(arg_12_2:Find("bg_all"), var_12_3)
	setActive(arg_12_2:Find("name/tip"), (underscore.any(var_12_0, function(arg_15_0)
		return arg_15_0:GetStatus() == IslandAchievement.STATUS.GET
	end)))

	return
end

return IslandAchievementPage
