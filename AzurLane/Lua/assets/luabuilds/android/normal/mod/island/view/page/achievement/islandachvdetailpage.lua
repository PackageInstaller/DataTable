class = var_0_10000

local var_0_0 = "IslandAchvDetailPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAchvDetailUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "top/title/Text")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_achievement_title"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "total/Text")

	i18n = var_2_2

	var_1_10001(var_2_3, var_2_2("island_achv_total"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.totalTF = var_1.Find(var_2_4, "total/value")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "toggles/content")

	UIItemList = var_2_5
	arg_2_0.typeUIList = var_2_5.New(var_2_6, var_2_6:Find("tpl"))
	setActive = var_2

	local var_2_7 = arg_2_0._tf

	var_2(var_3.Find(var_2_7, "tpl"), false)

	setText = var_2

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "tpl/status/get/Text")

	i18n = var_2_8

	var_2(var_2_9, var_2_8("handbook_claim"))

	setText = var_2

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "tpl/status/got/Text")

	i18n = var_2_10

	var_2(var_2_11, var_2_10("handbook_finished"))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "view")

	arg_2_0.scrollRect = var_2.GetComponent(var_2_13, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "top/back")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	local var_5_4 = arg_5_0.typeUIList

	var_1.make(var_5_4, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventInit then
			local var_7_0 = arg_5_0

			var_3.InitToggle(var_7_0, arg_7_1, arg_7_2)
		else
			UIItemList = var_3

			if arg_7_0 == var_3.EventUpdate then
				local var_7_1 = arg_5_0

				var_3.UpdateToggle(var_7_1, arg_7_1, arg_7_2)
			end
		end

		return
	end)

	pg = var_1
	arg_5_0.typeIds = var_1.island_achievement_group.all
	arg_5_0.cards = {}

	return
end

function var_0_1.InitToggle(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2.name = arg_8_0.typeIds[arg_8_1 + 1]
	pg = var_4

	local var_8_0 = var_4.island_achievement_group[var_3]

	LoadImageSpriteAtlasAsync = var_1_10005

	var_1_10005("islandachievement", var_8_0.icon, arg_8_2:Find("icon"), true)

	setText = var_1_10005

	var_1_10005(arg_8_2:Find("name"), var_8_0.name)

	onToggle = var_1_10005

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_2

	local function var_8_3(arg_9_0)
		if arg_9_0 then
			local var_9_0 = arg_8_2
			local var_9_1 = var_1.GetComponent

			typeof = var_2_10003
			Animation = var_2_10004

			local var_9_2 = var_9_1(var_9_0, var_2_10003(var_2_10004))

			var_1.Play(var_9_2)

			arg_8_0.showType = var_0

			local var_9_3 = arg_8_0

			var_1.FlushDetail(var_9_3)
		end

		return
	end

	SFX_PANEL = var_9

	var_1_10005(var_8_1, var_8_2, var_8_3, var_9)

	return
end

function var_0_1.UpdateToggle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.typeIds[arg_10_1 + 1]

	pg = var_4

	local var_10_1 = var_4.island_achievement_group[var_10_0].achievement_list
	local var_10_2 = {}

	ipairs = var_1_10006

	for iter_10_0, iter_10_1 in var_1_10006(var_10_1) do
		local var_10_3 = arg_10_0.achvAgency
		local var_10_4 = var_11.GetGroup(var_10_3, iter_10_1)

		ipairs = var_10_3

		for iter_10_2, iter_10_3 in var_10_3(var_10_4:GetSortAchvList()) do
			table = var_1_10017

			var_1_10017.insert(var_10_2, iter_10_3)
		end
	end

	underscore = var_6

	local var_10_5 = var_6.any(var_10_2, function(arg_11_0)
		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.GetStatus(var_11_0)

		IslandAchievement = var_11_0

		return var_11_1 == var_11_0.STATUS.GET
	end)

	setActive = var_7

	var_7(arg_10_2:Find("name/tip"), var_10_5)

	return
end

function var_0_1.AddListeners(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.AddListener

	GAME = var_1_10003

	var_12_1(var_12_0, var_1_10003.ISLAND_GET_ACHV_AWARD_DONE, arg_12_0.OnGetAchvAwardDone)

	return
end

function var_0_1.RemoveListeners(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.RemoveListener

	GAME = var_1_10003

	var_13_1(var_13_0, var_1_10003.ISLAND_GET_ACHV_AWARD_DONE, arg_13_0.OnGetAchvAwardDone)

	return
end

function var_0_1.OnShow(arg_14_0, arg_14_1)
	local var_14_0

	if not arg_14_1 then
		::label_14_0::

		pg = var_14_0
		var_14_0 = var_14_0.island_achievement_group.all[1]
	end

	arg_14_0.showType = var_14_0

	arg_14_0:Flush()

	return
end

function var_0_1.Flush(arg_15_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.GetIsland(var_15_0)

	arg_15_0.achvAgency = var_1.GetAchievementAgency(var_15_1)
	setText = var_1

	local var_15_2 = arg_15_0.totalTF
	local var_15_3 = arg_15_0.achvAgency
	local var_15_4 = #var_3.GetGotList(var_15_3)
	local var_15_5 = "/"
	local var_15_6 = arg_15_0.achvAgency

	var_1(var_15_2, var_15_4 .. var_15_5 .. var_5.GetTotalCnt(var_15_6))

	local var_15_7 = arg_15_0.typeUIList

	var_1.align(var_15_7, #arg_15_0.typeIds)

	triggerToggle = var_1

	local var_15_8 = arg_15_0.typeUIList.container
	local var_15_9 = var_2.Find

	tostring = var_15_5

	var_1(var_15_9(var_15_8, var_15_5(arg_15_0.showType)), true)

	return
end

function var_0_1.FlushDetail(arg_16_0)
	pg = var_1_10001
	arg_16_0.showGroupIds = var_1_10001.island_achievement_group[arg_16_0.showType].achievement_list
	underscore = var_1
	arg_16_0.showAchvList = var_1.map(arg_16_0.showGroupIds, function(arg_17_0)
		local var_17_0 = arg_16_0.achvAgency
		local var_17_1 = var_1.GetGroup(var_17_0, arg_17_0)
		local var_17_2 = var_1.GetSortAchvList(var_17_1)

		underscore = var_17_1

		local var_17_3 = var_17_1.select(var_17_2, function(arg_18_0)
			local var_18_2

			if arg_18_0:IsHideType() then
				local var_18_0 = arg_18_0
				local var_18_1 = arg_18_0.GetStatus(var_18_0)

				IslandAchievement = var_18_0

				if var_18_1 ~= var_18_0.STATUS.GET then
					var_18_2 = false

					goto label_18_0
				end
			end

			var_18_2 = true

			::label_18_0::

			return var_18_2
		end)

		underscore = var_4

		local var_17_4

		if not var_4.detect(var_17_3, function(arg_19_0)
			local var_19_0 = arg_19_0
			local var_19_1 = arg_19_0.GetStatus(var_19_0)

			IslandAchievement = var_19_0

			return var_19_1 ~= var_19_0.STATUS.GOT
		end) then
			var_17_4 = var_17_3[#var_17_3]
		end

		return var_17_4
	end)
	table = var_1

	local var_16_0 = var_1.sort
	local var_16_1 = arg_16_0.showAchvList

	CompareFuncs = var_3

	var_16_0(var_16_1, var_3({
		function(arg_20_0)
			local var_20_0 = arg_20_0
			local var_20_1 = arg_20_0.GetStatus(var_20_0)

			IslandAchievement = var_20_0

			return var_20_1 == var_20_0.STATUS.GET and 0 or 1
		end,
		function(arg_21_0)
			local var_21_0 = arg_21_0
			local var_21_1 = arg_21_0.GetStatus(var_21_0)

			IslandAchievement = var_21_0

			return var_21_1 == var_21_0.STATUS.GOT and 1 or 0
		end,
		function(arg_22_0)
			return arg_22_0.id
		end
	}))

	arg_16_0.scrollRect.enabled = true

	local var_16_2 = arg_16_0.scrollRect

	var_1.SetTotalCount(var_16_2, #arg_16_0.showAchvList, 0)

	return
end

function var_0_1.OnInitItem(arg_23_0, arg_23_1)
	IslandAchievementCard = var_1_10002

	local var_23_0 = var_1_10002.New(arg_23_1, arg_23_0)
	local var_23_1 = arg_23_0.cards

	var_23_1[arg_23_1] = var_23_0
	onButton = var_23_1

	local var_23_2 = arg_23_0
	local var_23_3 = var_23_0.getBtn

	local function var_23_4()
		local var_24_0 = var_23_0._tf
		local var_24_1 = var_0.GetComponent

		typeof = var_2_10002
		Animation = var_2_10003

		local var_24_2 = var_24_1(var_24_0, var_2_10002(var_2_10003))

		var_0.Play(var_24_2)

		local var_24_3 = arg_23_0
		local var_24_4 = var_0.emit

		IslandMediator = var_2

		var_24_4(var_24_3, var_2.GET_ACHIEVEMENT_AWARD, {
			var_23_0.achv.id
		})

		return
	end

	SFX_PANEL = var_1_10007

	var_23_1(var_23_2, var_23_3, var_23_4, var_1_10007)

	return
end

function var_0_1.OnUpdateItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0

	if not arg_25_0.cards[arg_25_2] then
		arg_25_0:OnInitItem(arg_25_2)

		var_25_0 = arg_25_0.cards[arg_25_2]
	end

	if arg_25_0.showAchvList[arg_25_1 + 1] then
		var_25_0:Update(var_4)
	end

	return
end

function var_0_1.OnGetAchvAwardDone(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.id

	local function var_26_1()
		pairs = var_2_10000

		for iter_27_0, iter_27_1 in var_2_10000(arg_26_0.cards) do
			if iter_27_1.achv.id == var_26_0 then
				return iter_27_1
			end
		end

		return
	end

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_28_0)
			if var_26_1() then
				var_1:PlayStageAnim(var_26_0, arg_28_0)
			else
				arg_28_0()
			end

			return
		end
	}, function()
		local var_29_0 = arg_26_0

		getProxy = var_2_10001
		IslandProxy = var_2_10002

		local var_29_1 = var_2_10001(var_2_10002)
		local var_29_2 = var_1.GetIsland(var_29_1)

		var_29_0.achvAgency = var_1.GetAchievementAgency(var_29_2)
		setText = var_29_0

		local var_29_3 = arg_26_0.totalTF
		local var_29_4 = arg_26_0.achvAgency
		local var_29_5 = #var_2.GetGotList(var_29_4)
		local var_29_6 = "/"
		local var_29_7 = arg_26_0.achvAgency

		var_29_0(var_29_3, var_29_5 .. var_29_6 .. var_4.GetTotalCnt(var_29_7))

		local var_29_8 = arg_26_0.typeUIList

		var_0.align(var_29_8, #arg_26_0.typeIds)

		local var_29_9 = arg_26_0

		var_0.FlushDetail(var_29_9)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_30_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_30_0.scrollRect)

	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.cards) do
		iter_30_1:Dispose()
	end

	arg_30_0.cards = {}

	return
end

return var_0_1
