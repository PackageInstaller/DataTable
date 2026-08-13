class = var_0_10000

local var_0_0 = "JoinGuildLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 30

i18n = var_2

local var_0_3 = var_2("guild_search_list_max_count", var_0_2)

function var_0_1.getUIName(arg_1_0)
	return "JoinGuildUI"
end

function var_0_1.setGuildVOs(arg_2_0, arg_2_1)
	arg_2_0.guildVOs = arg_2_1

	return
end

function var_0_1.setPlayerVO(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.guildViewRect = var_1.Find(var_4_0, "add_panel/view")

	local var_4_1 = arg_4_0._tf

	arg_4_0.refreshBtn = var_1.Find(var_4_1, "add_panel/center/refresh")

	local var_4_2 = arg_4_0._tf

	arg_4_0.searchBtn = var_1.Find(var_4_2, "add_panel/center/search")

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "add_panel/center/search_bar")
	local var_4_5 = var_1.GetComponent

	typeof = var_3
	InputField = var_1_10004
	arg_4_0.searchBar = var_4_5(var_4_4, var_3(var_1_10004))

	local var_4_6 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_6, "blur_panel/adapt/top/back")

	local var_4_7 = arg_4_0._tf

	arg_4_0.sortBtn = var_1.Find(var_4_7, "add_panel/center/sort_button")

	local var_4_8 = arg_4_0._tf

	arg_4_0.sortBtnContainer = var_1.Find(var_4_8, "add_panel/sort_panel/mask/content")
	arg_4_0.sortBtnTpl = arg_4_0:getTpl("add_panel/sort_panel/mask/content/tpl")

	local var_4_9 = arg_4_0._tf

	arg_4_0.sortPanel = var_1.Find(var_4_9, "add_panel/sort_panel")
	GuildApplyRedPage = var_1
	arg_4_0.applyRedPage = var_1.New(arg_4_0._tf, arg_4_0.event)
	GuildApplyBluePage = var_1
	arg_4_0.applyBluePage = var_1.New(arg_4_0._tf, arg_4_0.event)

	local var_4_10 = arg_4_0._tf

	arg_4_0.listEmptyTF = var_1.Find(var_4_10, "empty")
	setActive = var_1

	var_1(arg_4_0.listEmptyTF, false)

	local var_4_11 = arg_4_0.listEmptyTF

	arg_4_0.listEmptyTxt = var_1.Find(var_4_11, "Text")
	setText = var_1

	local var_4_12 = arg_4_0.listEmptyTxt

	i18n = var_3

	var_1(var_4_12, var_3("list_empty_tip_joinguildui"))

	setText = var_1

	local var_4_13 = arg_4_0._tf

	var_1(var_2.Find(var_4_13, "tip"), var_0_3)

	local var_4_14 = arg_4_0.guildViewRect

	arg_4_0.viewRect = var_1.GetComponent(var_4_14, "LScrollRect")

	function arg_4_0.viewRect.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.onInitItem(var_5_0, arg_5_0)

		return
	end

	function arg_4_0.viewRect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.onUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	arg_4_0.items = {}

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.refreshBtn

	local function var_7_2()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		JoinGuildMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.REFRESH)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.backBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.emit(var_9_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.searchBtn

	local function var_7_8()
		local var_10_0 = arg_7_0.searchBar.text
		local var_10_1 = arg_7_0
		local var_10_2 = var_1.emit

		JoinGuildMediator = var_2_10003

		var_10_2(var_10_1, var_2_10003.SEARCH, var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.sortBtn

	local function var_7_11()
		go = var_2_10000

		if var_2_10000(arg_7_0.sortPanel).activeSelf then
			local var_11_0 = arg_7_0

			var_0.closeSortPanel(var_11_0)
		else
			local var_11_1 = arg_7_0

			var_0.openSortPanel(var_11_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	onButton = var_1_10001

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.sortPanel

	local function var_7_14()
		local var_12_0 = arg_7_0

		var_0.closeSortPanel(var_12_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_12, var_7_13, var_7_14, var_1_10005)

	return
end

function var_0_1.openSortPanel(arg_13_0)
	arg_13_0.isOpenSortPanel = true
	setActive = var_1

	var_1(arg_13_0.sortPanel, true)

	if not arg_13_0.isInitSort then
		arg_13_0.isInitSort = true

		arg_13_0:initSort()
	end

	return
end

local var_0_4 = {
	{
		"index_all"
	}
}
local var_0_5 = {
	"index_blhx"
}
local var_0_6 = {
	"faction"
}

GuildConst = var_0_10006
var_0_6[2] = var_0_10006.FACTION_TYPE_BLHX
var_0_5[2] = var_0_6
var_0_4[2] = var_0_5

local var_0_7 = {
	"index_cszz"
}
local var_0_8 = {
	"faction"
}

GuildConst = var_6
var_0_8[2] = var_6.FACTION_TYPE_CSZZ
var_0_7[2] = var_0_8
var_0_4[3] = var_0_7

local var_0_9 = {
	"index_power"
}
local var_0_10 = {
	"policy"
}

GuildConst = var_6
var_0_10[2] = var_6.POLICY_TYPE_POWER
var_0_9[2] = var_0_10
var_0_4[4] = var_0_9

local var_0_11 = {
	"index_relax"
}
local var_0_12 = {
	"policy"
}

GuildConst = var_6
var_0_12[2] = var_6.POLICY_TYPE_RELAXATION
var_0_11[2] = var_0_12
var_0_4[5] = var_0_11

local var_0_13 = {}

function var_0_1.initSort(arg_14_0)
	ipairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(var_0_4) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_14_0.sortBtnTpl, arg_14_0.sortBtnContainer)
		GetSpriteFromAtlas = var_7

		local var_14_0 = var_7("ui/joinguildui_atlas", iter_14_1[1])

		setImageSprite = var_8

		var_8(var_1_10006:Find("Image"), var_14_0, true)

		onToggle = var_8

		var_8(arg_14_0, var_1_10006, function(arg_15_0)
			if arg_15_0 then
				local var_15_0 = arg_14_0

				var_1.filter(var_15_0, iter_14_1)

				setActive = var_1

				var_1(arg_14_0.sortPanel, false)
			end

			return
		end)
	end

	ipairs = var_1

	for iter_14_2, iter_14_3 in var_1(var_0_13) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_14_0.sortBtnTpl, arg_14_0.sortBtnContainer)
		setText = var_7

		var_7(var_1_10006:Find("Text"), iter_14_3[2])

		onToggle = var_7

		var_7(arg_14_0, var_1_10006, function(arg_16_0)
			if arg_16_0 then
				local var_16_0 = arg_14_0

				var_1.sortGuilds(var_16_0, iter_14_3[1])
			end

			return
		end)
	end

	return
end

function var_0_1.closeSortPanel(arg_17_0)
	arg_17_0.isOpenSortPanel = nil
	setActive = var_1

	var_1(arg_17_0.sortPanel, false)

	return
end

function var_0_1.onInitItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.items

	GuildApplyCard = var_1_10003
	var_18_0[arg_18_1] = var_1_10003.New(arg_18_1)
	onButton = var_18_0

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.items[arg_18_1].applyBtn

	local function var_18_3()
		local var_19_0 = arg_18_0.playerVO

		if var_0.inGuildCDTime(var_19_0) then
			pg = var_0

			local var_19_1 = var_0.TipsMgr.GetInstance()
			local var_19_2 = var_0.ShowTips

			i18n = var_2_10002

			var_19_2(var_19_1, var_2_10002("guild_leave_cd_time"))

			return
		end

		local var_19_3 = arg_18_0

		var_0.showApply(var_19_3, arg_18_0.items[arg_18_1].guildVO)

		return
	end

	SFX_PANEL = var_1_10006

	var_18_0(var_18_1, var_18_2, var_18_3, var_1_10006)

	return
end

function var_0_1.onUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if not arg_20_0.items[arg_20_2] then
		arg_20_0:onInitItem(arg_20_2)

		var_20_0 = arg_20_0.items[arg_20_2]
	end

	local var_20_1 = arg_20_0.sortVOs[arg_20_1 + 1]

	var_20_0:Update(var_20_1)

	return
end

function var_0_1.sortGuilds(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_0.guildVOs then
		var_21_0 = {}
	end

	arg_21_0.sortVOs = var_21_0
	table = var_21_0

	var_21_0.sort(arg_21_0.sortVOs, function(arg_22_0, arg_22_1)
		if not arg_21_1 then
			return arg_22_0.id < arg_22_1.id
		elseif arg_22_0[arg_21_1] == arg_22_1[arg_21_1] then
			return arg_22_0.id < arg_22_1.id
		else
			return arg_22_0[arg_21_1] > arg_22_1[arg_21_1]
		end

		return
	end)

	local var_21_1 = arg_21_0.viewRect

	var_2.SetTotalCount(var_21_1, #arg_21_0.sortVOs, 0)

	setActive = var_2

	var_2(arg_21_0.listEmptyTF, #arg_21_0.sortVOs <= 0)

	return
end

function var_0_1.filter(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 or arg_23_0.contextData.filterData

	arg_23_0.sortVOs = {}

	local var_23_1

	if not var_23_0 or #var_23_0 < 2 then
		if not arg_23_0.guildVOs then
			var_23_1 = {}
		end

		arg_23_0.sortVOs = var_23_1
		GetSpriteFromAtlas = var_23_1
		var_23_1 = var_23_1("ui/joinguildui_atlas", "index_all")
		setImageSprite = var_4

		local var_23_2 = arg_23_0.sortBtn

		var_4(var_5.Find(var_23_2, "Image"), var_23_1, true)
	else
		ipairs = var_23_1

		for iter_23_0, iter_23_1 in var_23_1(arg_23_0.guildVOs) do
			if iter_23_1[var_23_0[2][1]] == var_23_0[2][2] then
				table = var_8

				var_8.insert(arg_23_0.sortVOs, iter_23_1)
			end
		end

		GetSpriteFromAtlas = var_23_1
		var_23_1 = var_23_1("ui/joinguildui_atlas", var_23_0[1])
		setImageSprite = var_4

		local var_23_3 = arg_23_0.sortBtn

		var_4(var_5.Find(var_23_3, "Image"), var_23_1, true)
	end

	_ = var_23_1

	local var_23_4 = var_23_1.all(arg_23_0.sortVOs, function(arg_24_0)
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.getFaction(var_24_0)

		GuildConst = var_24_0

		return var_24_1 == var_24_0.FACTION_TYPE_CSZZ
	end)

	_ = var_4

	local var_23_5 = var_4.all(arg_23_0.sortVOs, function(arg_25_0)
		local var_25_0 = arg_25_0
		local var_25_1 = arg_25_0.getFaction(var_25_0)

		GuildConst = var_25_0

		return var_25_1 == var_25_0.FACTION_TYPE_BLHX
	end)

	arg_23_0.contextData.filterData = var_23_0

	local var_23_6 = arg_23_0.viewRect

	var_5.SetTotalCount(var_23_6, #arg_23_0.sortVOs, 0)

	setActive = var_5

	var_5(arg_23_0.listEmptyTF, #arg_23_0.sortVOs <= 0)

	return
end

function var_0_1.showApply(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1
	local var_26_1 = arg_26_1.getFaction(var_26_0)

	GuildConst = var_26_0

	if var_26_1 == var_26_0.FACTION_TYPE_BLHX then
		arg_26_0.page = arg_26_0.applyBluePage
	else
		GuildConst = var_3

		if var_26_1 == var_3.FACTION_TYPE_CSZZ then
			arg_26_0.page = arg_26_0.applyRedPage
		end
	end

	local var_26_2 = arg_26_0.page

	var_3.ExecuteAction(var_26_2, "Show", arg_26_1)

	return
end

function var_0_1.CloseApply(arg_27_0)
	if arg_27_0.page then
		local var_27_0 = arg_27_0.page

		if var_1.GetLoaded(var_27_0) then
			local var_27_1 = arg_27_0.page

			if var_1.isShowing(var_27_1) then
				local var_27_2 = arg_27_0.page

				var_1.Hide(var_27_2)
			end
		end
	end

	return
end

function var_0_1.onBackPressed(arg_28_0)
	if arg_28_0.isOpenSortPanel then
		arg_28_0:closeSortPanel()
	else
		if arg_28_0.page then
			local var_28_0 = arg_28_0.page

			if var_1.GetLoaded(var_28_0) then
				local var_28_1 = arg_28_0.page

				if var_1.isShowing(var_28_1) then
					local var_28_2 = arg_28_0.page

					var_1.Hide(var_28_2)

					goto label_28_0
				end
			end
		end

		pg = var_1

		local var_28_3 = var_1.CriMgr.GetInstance()
		local var_28_4 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10003

		var_28_4(var_28_3, var_1_10003)
		arg_28_0:emit(var_0_1.ON_CLOSE)
	end

	::label_28_0::

	return
end

function var_0_1.willExit(arg_29_0)
	local var_29_0 = arg_29_0.applyBluePage

	var_1.Destroy(var_29_0)

	local var_29_1 = arg_29_0.applyRedPage

	var_1.Destroy(var_29_1)

	PoolMgr = var_1

	local var_29_2 = var_1.GetInstance()

	var_1.DestroySprite(var_29_2, "ui/JoinGuildUI_atlas")

	return
end

return var_0_1
