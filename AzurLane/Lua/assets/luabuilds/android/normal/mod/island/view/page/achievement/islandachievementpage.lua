class = var_0_10000

local var_0_0 = "IslandAchievementPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAchievementUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "top/title/Text")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_achievement_title"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "top/total/Text")

	i18n = var_2_2

	var_1_10001(var_2_3, var_2_2("island_achv_total"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.totalTF = var_1.Find(var_2_4, "top/total/value")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "view/content")

	UIItemList = var_2_5
	arg_2_0.uiList = var_2_5.New(var_2_6, var_2_6:Find("tpl"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	local var_3_4 = arg_3_0.uiList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_3_0

			var_3.InitItem(var_5_0, arg_5_1, arg_5_2)
		else
			UIItemList = var_3

			if arg_5_0 == var_3.EventUpdate then
				local var_5_1 = arg_3_0

				var_3.UpdateItem(var_5_1, arg_5_1, arg_5_2)
			end
		end

		return
	end)

	pg = var_1
	arg_3_0.typeIds = var_1.island_achievement_group.all

	return
end

function var_0_1.OnShow(arg_6_0)
	arg_6_0:Flush()

	return
end

function var_0_1.AddListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.AddListener

	GAME = var_1_10003

	var_7_1(var_7_0, var_1_10003.ISLAND_GET_ACHV_AWARD_DONE, arg_7_0.Flush)

	return
end

function var_0_1.RemoveListeners(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.RemoveListener

	GAME = var_1_10003

	var_8_1(var_8_0, var_1_10003.ISLAND_GET_ACHV_AWARD_DONE, arg_8_0.Flush)

	return
end

function var_0_1.Flush(arg_9_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.GetIsland(var_9_0)

	arg_9_0.achvAgency = var_1.GetAchievementAgency(var_9_1)
	setText = var_1

	local var_9_2 = arg_9_0.totalTF
	local var_9_3 = arg_9_0.achvAgency
	local var_9_4 = #var_3.GetGotList(var_9_3)
	local var_9_5 = "/"
	local var_9_6 = arg_9_0.achvAgency

	var_1(var_9_2, var_9_4 .. var_9_5 .. var_5.GetTotalCnt(var_9_6))

	local var_9_7 = arg_9_0.uiList

	var_1.align(var_9_7, #arg_9_0.typeIds)

	return
end

function var_0_1.InitItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2.name = arg_10_0.typeIds[arg_10_1 + 1]
	pg = var_4

	local var_10_0 = var_4.island_achievement_group[var_3]

	LoadImageSpriteAtlasAsync = var_1_10005

	var_1_10005("islandachievement", var_10_0.icon, arg_10_2:Find("icon"), true)

	setText = var_1_10005

	var_1_10005(arg_10_2:Find("name"), var_10_0.name)

	onButton = var_1_10005

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_2

	local function var_10_3()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.OpenPage

		IslandAchvDetailPage = var_2_10002

		var_11_1(var_11_0, var_2_10002, var_0)

		return
	end

	SFX_PANEL = var_9

	var_1_10005(var_10_1, var_10_2, var_10_3, var_9)

	return
end

function var_0_1.UpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.typeIds[arg_12_1 + 1]

	pg = var_4

	local var_12_1 = var_4.island_achievement_group[var_12_0].achievement_list
	local var_12_2 = {}

	ipairs = var_1_10006

	for iter_12_0, iter_12_1 in var_1_10006(var_12_1) do
		local var_12_3 = arg_12_0.achvAgency
		local var_12_4 = var_11.GetGroup(var_12_3, iter_12_1)

		ipairs = var_12_3

		for iter_12_2, iter_12_3 in var_12_3(var_12_4:GetSortAchvList()) do
			table = var_1_10017

			var_1_10017.insert(var_12_2, iter_12_3)
		end
	end

	underscore = var_6

	local var_12_5 = var_6.reduce(var_12_2, 0, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1
		local var_13_1 = arg_13_1.GetStatus(var_13_0)

		IslandAchievement = var_13_0

		return arg_13_0 + (var_13_1 == var_13_0.STATUS.GOT and 1 or 0)
	end)

	underscore = var_7

	local var_12_6 = var_7.reduce(var_12_2, 0, function(arg_14_0, arg_14_1)
		return arg_14_0 + (arg_14_1:IsHideType() and 0 or 1)
	end)

	setText = var_8

	var_8(arg_12_2:Find("progress/cur"), var_12_5)

	setText = var_8

	var_8(arg_12_2:Find("progress/all"), "/" .. var_12_6)

	local var_12_7 = arg_12_2:Find("bar")
	local var_12_8 = var_8.GetComponent

	typeof = var_10
	Image = var_11
	var_12_8(var_12_7, var_10(var_11)).fillAmount = var_12_5 / var_12_6

	local var_12_9 = var_12_5 == var_12_6

	setActive = var_9

	var_9(arg_12_2:Find("bg"), not var_12_9)

	setActive = var_9

	var_9(arg_12_2:Find("bg_all"), var_12_9)

	underscore = var_9

	local var_12_10 = var_9.any(var_12_2, function(arg_15_0)
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.GetStatus(var_15_0)

		IslandAchievement = var_15_0

		return var_15_1 == var_15_0.STATUS.GET
	end)

	setActive = var_10

	var_10(arg_12_2:Find("name/tip"), var_12_10)

	return
end

return var_0_1
