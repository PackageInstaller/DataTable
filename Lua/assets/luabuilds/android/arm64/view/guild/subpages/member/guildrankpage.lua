local var_0_0 = class("GuildRankPage", import("...base.GuildBasePage"))

function var_0_0.getTargetUI(arg_1_0)
	return "GuildRankBluePage", "GuildRankRedPage"
end

local var_0_1 = {
	"commit",
	"task",
	"battle"
}
local var_0_2 = {
	i18n("guild_member_rank_title_donate"),
	i18n("guild_member_rank_title_finish_cnt"),
	i18n("guild_member_rank_title_join_cnt")
}

function var_0_0.PageId2RankLabel(arg_2_0)
	return var_0_2[arg_2_0]
end

function var_0_0.GetRank(arg_3_0, arg_3_1)
	return arg_3_0.ranks[arg_3_1]
end

function var_0_0.OnUpdateRankList(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 and table.getCount(arg_4_2) > 0 then
		arg_4_0.ranks[arg_4_1] = arg_4_2

		if arg_4_0.pageId == arg_4_1 then
			arg_4_0:SwitchPage(arg_4_1)
		end
	end

	return
end

function var_0_0.OnLoaded(arg_5_0)
	arg_5_0.tabContainer = arg_5_0._tf:Find("frame/bg/tab")
	arg_5_0.ranTypeTF = arg_5_0._tf:Find("frame/bg/week")
	arg_5_0.closeBtn = arg_5_0._tf:Find("frame/close")
	arg_5_0.rankLabel = arg_5_0._tf:Find("frame/bg/title/Text"):GetComponent(typeof(Text))
	arg_5_0.scrollrect = arg_5_0._tf:Find("frame/bg/scrollrect"):GetComponent("LScrollRect")

	function arg_5_0.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		arg_5_0:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	setActive(arg_5_0.ranTypeTF:Find("month"), true)
	setActive(arg_5_0.ranTypeTF:Find("total"), true)

	return
end

function var_0_0.OnInit(arg_7_0)
	onButton(arg_7_0, arg_7_0._tf, function()
		arg_7_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.closeBtn, function()
		arg_7_0:Hide()

		return
	end, SFX_PANEL)

	local function var_7_0()
		if arg_7_0.pageId then
			arg_7_0:SwitchPage(arg_7_0.pageId)
		end

		local var_10_0 = arg_7_0.ranTypeTF:Find("month")

		var_10_0:GetComponent(typeof(Image)).enabled = arg_7_0.ranType == 0

		local var_10_1 = arg_7_0.ranTypeTF:Find("total")

		var_10_1:GetComponent(typeof(Image)).enabled = arg_7_0.ranType == 2
		arg_7_0.ranTypeTF:GetComponent(typeof(Image)).enabled = arg_7_0.ranType == 1

		return
	end

	arg_7_0.ranType = 0

	onButton(arg_7_0, arg_7_0.ranTypeTF, function()
		arg_7_0.ranType = (arg_7_0.ranType + 1) % 3

		var_7_0()

		return
	end, SFX_PANEL)
	arg_7_0:InitTags()
	;(function()
		if arg_7_0.pageId then
			arg_7_0:SwitchPage(arg_7_0.pageId)
		end

		local var_10_0 = arg_7_0.ranTypeTF:Find("month")

		var_10_0:GetComponent(typeof(Image)).enabled = arg_7_0.ranType == 0

		local var_10_1 = arg_7_0.ranTypeTF:Find("total")

		var_10_1:GetComponent(typeof(Image)).enabled = arg_7_0.ranType == 2
		arg_7_0.ranTypeTF:GetComponent(typeof(Image)).enabled = arg_7_0.ranType == 1

		return
	end)()

	return
end

function var_0_0.InitTags(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(var_0_1) do
		onToggle(arg_12_0, arg_12_0.tabContainer:Find(iter_12_1), function(arg_13_0)
			if arg_13_0 then
				arg_12_0:SwitchPage(iter_12_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.Flush(arg_14_0, arg_14_1)
	arg_14_0.ranks = arg_14_1

	pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf)
	arg_14_0:Show()
	arg_14_0._tf:SetAsLastSibling()
	triggerToggle(arg_14_0.tabContainer:Find("commit"), true)

	return
end

function var_0_0.SwitchPage(arg_15_0, arg_15_1)
	arg_15_0.pageId = arg_15_1

	arg_15_0.scrollrect:SetTotalCount(0)

	local var_15_0 = arg_15_0:GetRank(arg_15_1)

	if var_15_0 then
		if getProxy(GuildProxy):ShouldRefreshRank(arg_15_1) then
			arg_15_0:emit(GuildMemberMediator.GET_RANK, arg_15_1)
		else
			assert(var_15_0)
			arg_15_0:InitRank(var_15_0)
		end

		arg_15_0.rankLabel.text = var_0_0.PageId2RankLabel(arg_15_1)

		return
	end
end

function var_0_0.InitRank(arg_16_0, arg_16_1)
	arg_16_0.displays = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		table.insert(arg_16_0.displays, iter_16_1)
	end

	table.sort(arg_16_0.displays, function(arg_17_0, arg_17_1)
		return arg_17_0:GetScore(arg_16_0.ranType) > arg_17_1:GetScore(arg_16_0.ranType)
	end)
	arg_16_0.scrollrect:SetTotalCount(#arg_16_0.displays)

	return
end

function var_0_0.OnUpdateItem(arg_18_0, arg_18_1, arg_18_2)
	setText(tf(arg_18_2):Find("number"), arg_18_1 + 1)
	setText(tf(arg_18_2):Find("name"), arg_18_0.displays[arg_18_1 + 1]:GetName())
	setText(tf(arg_18_2):Find("score"), arg_18_0.displays[arg_18_1 + 1]:GetScore(arg_18_0.ranType))

	return
end

function var_0_0.Hide(arg_19_0)
	if arg_19_0:isShowing() then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0._tf, arg_19_0._parentTf)
	end

	var_0_0.super.Hide(arg_19_0)

	return
end

function var_0_0.OnDestroy(arg_20_0)
	arg_20_0:Hide()

	return
end

return var_0_0
