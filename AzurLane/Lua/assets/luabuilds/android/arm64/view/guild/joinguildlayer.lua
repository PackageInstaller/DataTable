local var_0_0 = class("JoinGuildLayer", import("..base.BaseUI"))
local var_0_1 = i18n("guild_search_list_max_count", 30)

function var_0_0.getUIName(arg_1_0)
	return "JoinGuildUI"
end

function var_0_0.setGuildVOs(arg_2_0, arg_2_1)
	arg_2_0.guildVOs = arg_2_1

	return
end

function var_0_0.setPlayerVO(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.guildViewRect = arg_4_0._tf:Find("add_panel/view")
	arg_4_0.refreshBtn = arg_4_0._tf:Find("add_panel/center/refresh")
	arg_4_0.searchBtn = arg_4_0._tf:Find("add_panel/center/search")
	arg_4_0.searchBar = arg_4_0._tf:Find("add_panel/center/search_bar"):GetComponent(typeof(InputField))
	arg_4_0.backBtn = arg_4_0._tf:Find("blur_panel/adapt/top/back")
	arg_4_0.sortBtn = arg_4_0._tf:Find("add_panel/center/sort_button")
	arg_4_0.sortBtnContainer = arg_4_0._tf:Find("add_panel/sort_panel/mask/content")
	arg_4_0.sortBtnTpl = arg_4_0:getTpl("add_panel/sort_panel/mask/content/tpl")
	arg_4_0.sortPanel = arg_4_0._tf:Find("add_panel/sort_panel")
	arg_4_0.applyRedPage = GuildApplyRedPage.New(arg_4_0._tf, arg_4_0.event)
	arg_4_0.applyBluePage = GuildApplyBluePage.New(arg_4_0._tf, arg_4_0.event)
	arg_4_0.listEmptyTF = arg_4_0._tf:Find("empty")

	setActive(arg_4_0.listEmptyTF, false)

	arg_4_0.listEmptyTxt = arg_4_0.listEmptyTF:Find("Text")

	setText(arg_4_0.listEmptyTxt, i18n("list_empty_tip_joinguildui"))
	setText(arg_4_0._tf:Find("tip"), var_0_1)

	arg_4_0.viewRect = arg_4_0.guildViewRect:GetComponent("LScrollRect")

	function arg_4_0.viewRect.onInitItem(arg_5_0)
		arg_4_0:onInitItem(arg_5_0)

		return
	end

	function arg_4_0.viewRect.onUpdateItem(arg_6_0, arg_6_1)
		arg_4_0:onUpdateItem(arg_6_0, arg_6_1)

		return
	end

	arg_4_0.items = {}

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.refreshBtn, function()
		arg_7_0:emit(JoinGuildMediator.REFRESH)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(arg_7_0, arg_7_0.searchBtn, function()
		arg_7_0:emit(JoinGuildMediator.SEARCH, arg_7_0.searchBar.text)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.sortBtn, function()
		if go(arg_7_0.sortPanel).activeSelf then
			arg_7_0:closeSortPanel()
		else
			arg_7_0:openSortPanel()
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.sortPanel, function()
		arg_7_0:closeSortPanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.openSortPanel(arg_13_0)
	arg_13_0.isOpenSortPanel = true

	setActive(arg_13_0.sortPanel, true)

	if not arg_13_0.isInitSort then
		arg_13_0.isInitSort = true

		arg_13_0:initSort()
	end

	return
end

local var_0_2 = {
	{
		"index_all"
	},
	{
		"index_blhx",
		{
			"faction",
			GuildConst.FACTION_TYPE_BLHX
		}
	},
	{
		"index_cszz",
		{
			"faction",
			GuildConst.FACTION_TYPE_CSZZ
		}
	},
	{
		"index_power",
		{
			"policy",
			GuildConst.POLICY_TYPE_POWER
		}
	},
	{
		"index_relax",
		{
			"policy",
			GuildConst.POLICY_TYPE_RELAXATION
		}
	}
}
local var_0_3 = {}

function var_0_0.initSort(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(var_0_2) do
		local var_14_0 = cloneTplTo(arg_14_0.sortBtnTpl, arg_14_0.sortBtnContainer)

		setImageSprite(var_14_0:Find("Image"), GetSpriteFromAtlas("ui/joinguildui_atlas", iter_14_1[1]), true)
		onToggle(arg_14_0, var_14_0, function(arg_15_0)
			if arg_15_0 then
				arg_14_0:filter(iter_14_1)
				setActive(arg_14_0.sortPanel, false)
			end

			return
		end)
	end

	for iter_14_2, iter_14_3 in ipairs(var_0_3) do
		local var_14_1 = cloneTplTo(arg_14_0.sortBtnTpl, arg_14_0.sortBtnContainer)

		setText(var_14_1:Find("Text"), iter_14_3[2])
		onToggle(arg_14_0, var_14_1, function(arg_16_0)
			if arg_16_0 then
				arg_14_0:sortGuilds(iter_14_3[1])
			end

			return
		end)
	end

	return
end

function var_0_0.closeSortPanel(arg_17_0)
	arg_17_0.isOpenSortPanel = nil

	setActive(arg_17_0.sortPanel, false)

	return
end

function var_0_0.onInitItem(arg_18_0, arg_18_1)
	arg_18_0.items[arg_18_1] = GuildApplyCard.New(arg_18_1)

	onButton(arg_18_0, arg_18_0.items[arg_18_1].applyBtn, function()
		if arg_18_0.playerVO:inGuildCDTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_leave_cd_time"))

			return
		end

		arg_18_0:showApply(arg_18_0.items[arg_18_1].guildVO)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.items[arg_20_2] then
		arg_20_0:onInitItem(arg_20_2)
	end

	arg_20_0.items[arg_20_2]:Update(arg_20_0.sortVOs[arg_20_1 + 1])

	return
end

function var_0_0.sortGuilds(arg_21_0, arg_21_1)
	arg_21_0.sortVOs = arg_21_0.guildVOs or {}

	table.sort(arg_21_0.sortVOs, function(arg_22_0, arg_22_1)
		if not arg_21_1 then
			return arg_22_0.id < arg_22_1.id
		elseif arg_22_0[arg_21_1] == arg_22_1[arg_21_1] then
			return arg_22_0.id < arg_22_1.id
		else
			return arg_22_0[arg_21_1] > arg_22_1[arg_21_1]
		end

		return
	end)
	arg_21_0.viewRect:SetTotalCount(#arg_21_0.sortVOs, 0)
	setActive(arg_21_0.listEmptyTF, #arg_21_0.sortVOs <= 0)

	return
end

function var_0_0.filter(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 or arg_23_0.contextData.filterData

	arg_23_0.sortVOs = {}

	if not var_23_0 or #var_23_0 < 2 then
		arg_23_0.sortVOs = arg_23_0.guildVOs or {}

		setImageSprite(arg_23_0.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/joinguildui_atlas", "index_all"), true)
	else
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.guildVOs) do
			if iter_23_1[var_23_0[2][1]] == var_23_0[2][2] then
				table.insert(arg_23_0.sortVOs, iter_23_1)
			end
		end

		setImageSprite(arg_23_0.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/joinguildui_atlas", var_23_0[1]), true)
	end

	local var_23_1 = _.all(arg_23_0.sortVOs, function(arg_24_0)
		return arg_24_0:getFaction() == GuildConst.FACTION_TYPE_CSZZ
	end)
	local var_23_2 = _.all(arg_23_0.sortVOs, function(arg_25_0)
		return arg_25_0:getFaction() == GuildConst.FACTION_TYPE_BLHX
	end)

	arg_23_0.contextData.filterData = var_23_0

	arg_23_0.viewRect:SetTotalCount(#arg_23_0.sortVOs, 0)
	setActive(arg_23_0.listEmptyTF, #arg_23_0.sortVOs <= 0)

	return
end

function var_0_0.showApply(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:getFaction()

	if var_26_0 == GuildConst.FACTION_TYPE_BLHX then
		arg_26_0.page = arg_26_0.applyBluePage
	elseif var_26_0 == GuildConst.FACTION_TYPE_CSZZ then
		arg_26_0.page = arg_26_0.applyRedPage
	end

	arg_26_0.page:ExecuteAction("Show", arg_26_1)

	return
end

function var_0_0.CloseApply(arg_27_0)
	if arg_27_0.page and arg_27_0.page:GetLoaded() and arg_27_0.page:isShowing() then
		arg_27_0.page:Hide()
	end

	return
end

function var_0_0.onBackPressed(arg_28_0)
	if arg_28_0.isOpenSortPanel then
		arg_28_0:closeSortPanel()
	elseif arg_28_0.page and arg_28_0.page:GetLoaded() and arg_28_0.page:isShowing() then
		arg_28_0.page:Hide()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		arg_28_0:emit(var_0_0.ON_CLOSE)
	end

	return
end

function var_0_0.willExit(arg_29_0)
	arg_29_0.applyBluePage:Destroy()
	arg_29_0.applyRedPage:Destroy()
	PoolMgr.GetInstance():DestroySprite("ui/JoinGuildUI_atlas")

	return
end

return var_0_0
