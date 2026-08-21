local var_0_0 = class("IslandAchvDetailPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAchvDetailUI"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_achievement_title"))
	setText(arg_2_0._tf:Find("total/Text"), i18n("island_achv_total"))

	arg_2_0.totalTF = arg_2_0._tf:Find("total/value")

	local var_2_0 = arg_2_0._tf:Find("toggles/content")

	arg_2_0.typeUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	setActive(arg_2_0._tf:Find("tpl"), false)
	setText(arg_2_0._tf:Find("tpl/status/get/Text"), i18n("handbook_claim"))
	setText(arg_2_0._tf:Find("tpl/status/got/Text"), i18n("handbook_finished"))

	arg_2_0.scrollRect = arg_2_0._tf:Find("view"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("top/back"), function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	arg_5_0.typeUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventInit then
			arg_5_0:InitToggle(arg_7_1, arg_7_2)
		elseif arg_7_0 == UIItemList.EventUpdate then
			arg_5_0:UpdateToggle(arg_7_1, arg_7_2)
		end

		return
	end)

	arg_5_0.typeIds = pg.island_achievement_group.all
	arg_5_0.cards = {}

	return
end

function var_0_0.InitToggle(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.typeIds[arg_8_1 + 1]

	arg_8_2.name = arg_8_0.typeIds[arg_8_1 + 1]

	LoadImageSpriteAtlasAsync("islandachievement", pg.island_achievement_group[arg_8_0.typeIds[arg_8_1 + 1]].icon, arg_8_2:Find("icon"), true)
	setText(arg_8_2:Find("name"), pg.island_achievement_group[arg_8_0.typeIds[arg_8_1 + 1]].name)
	onToggle(arg_8_0, arg_8_2, function(arg_9_0)
		if arg_9_0 then
			arg_8_2:GetComponent(typeof(Animation)):Play()

			arg_8_0.showType = var_8_0

			arg_8_0:FlushDetail()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateToggle(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(pg.island_achievement_group[arg_10_0.typeIds[arg_10_1 + 1]].achievement_list) do
		local var_10_0 = arg_10_0.achvAgency:GetGroup(iter_10_1)

		for iter_10_2, iter_10_3 in ipairs(var_10_0:GetSortAchvList()) do
			table.insert({}, iter_10_3)
		end
	end

	setActive(arg_10_2:Find("name/tip"), (underscore.any({}, function(arg_11_0)
		return arg_11_0:GetStatus() == IslandAchievement.STATUS.GET
	end)))

	return
end

function var_0_0.AddListeners(arg_12_0)
	arg_12_0:AddListener(GAME.ISLAND_GET_ACHV_AWARD_DONE, arg_12_0.OnGetAchvAwardDone)

	return
end

function var_0_0.RemoveListeners(arg_13_0)
	arg_13_0:RemoveListener(GAME.ISLAND_GET_ACHV_AWARD_DONE, arg_13_0.OnGetAchvAwardDone)

	return
end

function var_0_0.OnShow(arg_14_0, arg_14_1)
	arg_14_0.showType = arg_14_1 or pg.island_achievement_group.all[1]

	arg_14_0:Flush()

	return
end

function var_0_0.Flush(arg_15_0)
	arg_15_0.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	setText(arg_15_0.totalTF, #arg_15_0.achvAgency:GetGotList() .. "/" .. arg_15_0.achvAgency:GetTotalCnt())
	arg_15_0.typeUIList:align(#arg_15_0.typeIds)
	triggerToggle(arg_15_0.typeUIList.container:Find(tostring(arg_15_0.showType)), true)

	return
end

function var_0_0.FlushDetail(arg_16_0)
	arg_16_0.showGroupIds = pg.island_achievement_group[arg_16_0.showType].achievement_list
	arg_16_0.showAchvList = underscore.map(arg_16_0.showGroupIds, function(arg_17_0)
		local var_17_0 = underscore.select(arg_16_0.achvAgency:GetGroup(arg_17_0):GetSortAchvList(), function(arg_18_0)
			return not arg_18_0:IsHideType() or arg_18_0:GetStatus() == IslandAchievement.STATUS.GET
		end)

		return underscore.detect(var_17_0, function(arg_19_0)
			return arg_19_0:GetStatus() ~= IslandAchievement.STATUS.GOT
		end) or var_17_0[#var_17_0]
	end)

	table.sort(arg_16_0.showAchvList, CompareFuncs({
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

	arg_16_0.scrollRect.enabled = true

	arg_16_0.scrollRect:SetTotalCount(#arg_16_0.showAchvList, 0)

	return
end

function var_0_0.OnInitItem(arg_23_0, arg_23_1)
	local var_23_0 = IslandAchievementCard.New(arg_23_1, arg_23_0)

	arg_23_0.cards[arg_23_1] = var_23_0

	onButton(arg_23_0, var_23_0.getBtn, function()
		var_23_0._tf:GetComponent(typeof(Animation)):Play()
		arg_23_0:emit(IslandMediator.GET_ACHIEVEMENT_AWARD, {
			var_23_0.achv.id
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.cards[arg_25_2]

	if not arg_25_0.cards[arg_25_2] then
		arg_25_0:OnInitItem(arg_25_2)

		var_25_0 = arg_25_0.cards[arg_25_2]
	end

	local var_25_1 = arg_25_0.showAchvList[arg_25_1 + 1]

	if arg_25_0.showAchvList[arg_25_1 + 1] then
		var_25_0:Update(var_25_1)
	end

	return
end

function var_0_0.OnGetAchvAwardDone(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.id

	local function var_26_1()
		for iter_27_0, iter_27_1 in pairs(arg_26_0.cards) do
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
		arg_26_0.achvAgency = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

		setText(arg_26_0.totalTF, #arg_26_0.achvAgency:GetGotList() .. "/" .. arg_26_0.achvAgency:GetTotalCnt())
		arg_26_0.typeUIList:align(#arg_26_0.typeIds)
		arg_26_0:FlushDetail()

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_30_0)
	ClearLScrollrect(arg_30_0.scrollRect)

	for iter_30_0, iter_30_1 in pairs(arg_30_0.cards) do
		iter_30_1:Dispose()
	end

	arg_30_0.cards = {}

	return
end

return var_0_0
