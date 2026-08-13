class = var_0_10000

local var_0_0 = "GuildRankPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.GuildBasePage"))

function var_0_1.getTargetUI(arg_1_0)
	return "GuildRankBluePage", "GuildRankRedPage"
end

local var_0_2 = {
	"commit",
	"task",
	"battle"
}
local var_0_3 = {}

i18n = var_3
var_0_3[1] = var_3("guild_member_rank_title_donate")
i18n = var_3
var_0_3[2] = var_3("guild_member_rank_title_finish_cnt")
i18n = var_3
var_0_3[3] = var_3("guild_member_rank_title_join_cnt")

function var_0_1.PageId2RankLabel(arg_2_0)
	return var_0_3[arg_2_0]
end

function var_0_1.GetRank(arg_3_0, arg_3_1)
	return arg_3_0.ranks[arg_3_1]
end

function var_0_1.OnUpdateRankList(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		table = var_1_10003

		if var_1_10003.getCount(arg_4_2) > 0 then
			arg_4_0.ranks[arg_4_1] = arg_4_2

			if arg_4_0.pageId == arg_4_1 then
				arg_4_0:SwitchPage(arg_4_1)
			end
		end
	end

	return
end

function var_0_1.OnLoaded(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.tabContainer = var_1.Find(var_5_0, "frame/bg/tab")

	local var_5_1 = arg_5_0._tf

	arg_5_0.ranTypeTF = var_1.Find(var_5_1, "frame/bg/week")

	local var_5_2 = arg_5_0._tf

	arg_5_0.closeBtn = var_1.Find(var_5_2, "frame/close")

	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_1.Find(var_5_3, "frame/bg/title/Text")
	local var_5_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.rankLabel = var_5_5(var_5_4, var_4(var_1_10006))

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_1.Find(var_5_6, "frame/bg/scrollrect")

	arg_5_0.scrollrect = var_1.GetComponent(var_5_7, "LScrollRect")

	local var_5_8 = arg_5_0.scrollrect

	function var_5_8.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	setActive = var_5_8

	local var_5_9 = arg_5_0.ranTypeTF

	var_5_8(var_3.Find(var_5_9, "month"), true)

	setActive = var_5_8

	local var_5_10 = arg_5_0.ranTypeTF

	var_5_8(var_3.Find(var_5_10, "total"), true)

	return
end

function var_0_1.OnInit(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._tf

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.closeBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	local function var_7_6()
		if arg_7_0.pageId then
			local var_10_0 = arg_7_0

			var_0.SwitchPage(var_10_0, arg_7_0.pageId)
		end

		local var_10_1 = arg_7_0.ranTypeTF
		local var_10_2 = var_0.Find(var_10_1, "month")
		local var_10_3 = var_0.GetComponent

		typeof = var_3
		Image = var_2_10005
		var_10_3(var_10_2, var_3(var_2_10005)).enabled = arg_7_0.ranType == 0

		local var_10_4 = arg_7_0.ranTypeTF
		local var_10_5 = var_0.Find(var_10_4, "total")
		local var_10_6 = var_0.GetComponent

		typeof = var_3
		Image = var_2_10005
		var_10_6(var_10_5, var_3(var_2_10005)).enabled = arg_7_0.ranType == 2

		local var_10_7 = arg_7_0.ranTypeTF
		local var_10_8 = var_0.GetComponent

		typeof = var_3
		Image = var_2_10005
		var_10_8(var_10_7, var_3(var_2_10005)).enabled = arg_7_0.ranType == 1

		return
	end

	arg_7_0.ranType = 0
	onButton = var_2

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0.ranTypeTF

	local function var_7_9()
		arg_7_0.ranType = (arg_7_0.ranType + 1) % 3

		var_7_6()

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_7_7, var_7_8, var_7_9, var_1_10007)
	arg_7_0:InitTags()
	var_7_6()

	return
end

function var_0_1.InitTags(arg_12_0)
	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(var_0_2) do
		local var_12_0 = arg_12_0.tabContainer
		local var_12_1 = var_6.Find(var_12_0, iter_12_1)

		onToggle = var_1_10007

		local var_12_2 = arg_12_0
		local var_12_3 = var_12_1

		local function var_12_4(arg_13_0)
			if arg_13_0 then
				local var_13_0 = arg_12_0

				var_1.SwitchPage(var_13_0, iter_12_0)
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_12_2, var_12_3, var_12_4, var_1_10012)
	end

	return
end

function var_0_1.Flush(arg_14_0, arg_14_1)
	arg_14_0.ranks = arg_14_1
	pg = var_1_10002

	local var_14_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_14_0, arg_14_0._tf)
	arg_14_0:Show()

	local var_14_1 = arg_14_0._tf

	var_2.SetAsLastSibling(var_14_1)

	triggerToggle = var_2

	local var_14_2 = arg_14_0.tabContainer

	var_2(var_4.Find(var_14_2, "commit"), true)

	return
end

function var_0_1.SwitchPage(arg_15_0, arg_15_1)
	arg_15_0.pageId = arg_15_1

	local var_15_0 = arg_15_0.scrollrect

	var_2.SetTotalCount(var_15_0, 0)

	if arg_15_0:GetRank(arg_15_1) then
		getProxy = var_1_10003
		GuildProxy = var_5

		local var_15_1 = var_1_10003(var_5)

		if var_1_10003.ShouldRefreshRank(var_15_1, arg_15_1) then
			local var_15_2 = arg_15_0

			var_1_10003 = arg_15_0.emit
			GuildMemberMediator = var_1_10006

			var_1_10003(var_15_2, var_1_10006.GET_RANK, arg_15_1)
		else
			assert = var_1_10003

			var_1_10003(var_2)
			arg_15_0:InitRank(var_2)
		end

		arg_15_0.rankLabel.text = var_0_1.PageId2RankLabel(arg_15_1)

		return
	end
end

function var_0_1.InitRank(arg_16_0, arg_16_1)
	arg_16_0.displays = {}
	pairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_1) do
		table = var_1_10007

		var_1_10007.insert(arg_16_0.displays, iter_16_1)
	end

	table = var_2

	var_2.sort(arg_16_0.displays, function(arg_17_0, arg_17_1)
		return arg_17_0:GetScore(arg_16_0.ranType) > arg_17_1:GetScore(arg_16_0.ranType)
	end)

	local var_16_0 = arg_16_0.scrollrect

	var_2.SetTotalCount(var_16_0, #arg_16_0.displays)

	return
end

function var_0_1.OnUpdateItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.displays[arg_18_1 + 1]

	setText = var_4
	tf = var_1_10006

	local var_18_1 = var_1_10006(arg_18_2)

	var_4(var_6.Find(var_18_1, "number"), arg_18_1 + 1)

	setText = var_4
	tf = var_6

	local var_18_2 = var_6(arg_18_2)

	var_4(var_6.Find(var_18_2, "name"), var_18_0:GetName())

	setText = var_4
	tf = var_6

	local var_18_3 = var_6(arg_18_2)

	var_4(var_6.Find(var_18_3, "score"), var_18_0:GetScore(arg_18_0.ranType))

	return
end

function var_0_1.Hide(arg_19_0)
	if arg_19_0:isShowing() then
		pg = var_1

		local var_19_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_19_0, arg_19_0._tf, arg_19_0._parentTf)
	end

	var_0_1.super.Hide(arg_19_0)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	arg_20_0:Hide()

	return
end

return var_0_1
