class = var_0_10000

local var_0_0 = "NewEducateRankLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateBaseUI"))
local var_0_2 = {}

PowerRank = var_2
var_0_2.ATTR = var_2.TYPE_TB_ATTR_SUM
PowerRank = var_2
var_0_2.ENDLESS = var_2.TYPE_TB_ENDLESS_WAVE
var_0_1.TYPE = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "NewEducateRankUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "window")

	setText = var_2_0

	local var_2_2 = var_2_1
	local var_2_3 = var_2_1.Find(var_2_2, "tip")

	i18n = var_2_2

	var_2_0(var_2_3, var_2_2("child2_rank_refresh_tip"))

	local var_2_4 = var_2_1
	local var_2_5 = var_2_1.Find(var_2_4, "header")

	setText = var_2_4

	local var_2_6 = var_2_5
	local var_2_7 = var_2_5.Find(var_2_6, "rank")

	i18n = var_2_6

	var_2_4(var_2_7, var_2_6("child2_rank_header_rank"))

	setText = var_2_4

	local var_2_8 = var_2_5
	local var_2_9 = var_2_5.Find(var_2_8, "info")

	i18n = var_2_8

	var_2_4(var_2_9, var_2_8("child2_rank_header_info"))

	arg_2_0.headerValueTF = var_2_5:Find("value")
	arg_2_0.toggleTFs = {}

	local var_2_10 = arg_2_0.toggleTFs

	var_2_10[var_0_1.TYPE.ATTR] = var_2_1:Find("toggles/attr")
	setText = var_2_10

	local var_2_11 = var_2_1
	local var_2_12 = var_2_1.Find(var_2_11, "toggles/attr/Text")

	i18n = var_2_11

	var_2_10(var_2_12, var_2_11("child2_rank_toggle_attr"))

	local var_2_13 = arg_2_0.toggleTFs

	var_2_13[var_0_1.TYPE.ENDLESS] = var_2_1:Find("toggles/endless")
	setText = var_2_13

	local var_2_14 = var_2_1
	local var_2_15 = var_2_1.Find(var_2_14, "toggles/endless/Text")

	i18n = var_2_14

	var_2_13(var_2_15, var_2_14("child2_rank_toggle_endless"))

	arg_2_0.playerRankTF = var_2_1:Find("player")

	local var_2_16 = var_2_1:Find("view/content")

	arg_2_0.rankRect = var_3.GetComponent(var_2_16, "LScrollRect")

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		groupDelta = 1
	})

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "mask")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_0, var_3_2, var_3_3, var_5)

	pairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.toggleTFs) do
		onToggle = var_1_10006

		local var_3_4 = arg_3_0
		local var_3_5 = iter_3_1

		local function var_3_6(arg_5_0)
			if arg_5_0 and (not arg_3_0.curType or arg_3_0.curType ~= iter_3_0) then
				arg_3_0.curType = iter_3_0
				var_2_10002 = arg_3_0

				var_1.UpdateView(var_2_10002)
			end

			local var_5_0 = arg_5_0 and "Anim_NewEducateRankUI_sel" or "Anim_NewEducateRankUI_sel2"

			quickPlayAnimation = var_2_10002

			var_2_10002(iter_3_1, var_5_0)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_3_4, var_3_5, var_3_6, var_1_10010)
	end

	function arg_3_0.rankRect.onInitItem(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.OnInitItem(var_6_0, arg_6_0)

		return
	end

	local var_3_7 = arg_3_0.rankRect

	function var_3_7.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_3_0

		var_2.OnUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	NewEducateRankCard = var_3_7

	local var_3_8 = var_3_7.New
	local var_3_9 = arg_3_0.playerRankTF

	NewEducateRankCard = var_3
	arg_3_0.playerCard = var_3_8(var_3_9, var_3.TYPE_SELF, arg_3_0)

	arg_3_0:InitData()

	triggerToggle = var_1

	var_1(arg_3_0.toggleTFs[var_0_1.TYPE.ATTR], true)

	NewEducateGuideSequence = var_1

	var_1.CheckGuide(arg_3_0.__cname)

	return
end

function var_0_1.InitData(arg_8_0)
	arg_8_0.cards = {}
	arg_8_0.rankVOs = {}
	arg_8_0.playerRankVOs = {}
	arg_8_0.charId = arg_8_0.contextData.char.id

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	NewEducateRankCard = var_1_10002

	local var_9_0 = var_1_10002.New
	local var_9_1 = arg_9_1

	NewEducateRankCard = var_1_10004

	local var_9_2 = var_9_0(var_9_1, var_1_10004.TYPE_OTHER, arg_9_0)

	arg_9_0.cards[arg_9_1] = var_9_2

	return
end

function var_0_1.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_0.displayRankVOs[arg_10_1 + 1]

	var_10_0:Update(var_10_1, arg_10_0.curType)

	return
end

function var_0_1.UpdateView(arg_11_0)
	if arg_11_0.curType == var_0_1.TYPE.ATTR then
		i18n = var_11_0

		local var_11_0

		if not var_11_0("child2_rank_header_attr") then
			i18n = var_11_0
			var_11_0 = var_11_0("child2_rank_header_wave")
		end

		setText = var_2

		var_2(arg_11_0.headerValueTF, var_11_0)

		if arg_11_0.rankVOs[arg_11_0.curType] then
			getProxy = var_3
			BillboardProxy = var_4

			local var_11_1 = var_3(var_4)

			if var_3.canFetch(var_11_1, arg_11_0.curType, arg_11_0.charId) then
				local var_11_2 = arg_11_0
				local var_11_3 = arg_11_0.emit

				NewEducateRankMediator = var_1_10005

				var_11_3(var_11_2, var_1_10005.ON_GET_RANK, arg_11_0.curType, arg_11_0.charId)
			else
				arg_11_0:UpdataRankList()
			end

			return
		end
	end
end

function var_0_1.UpdataRankList(arg_12_0)
	arg_12_0.displayRankVOs = {}

	local var_12_0 = arg_12_0.rankVOs[arg_12_0.curType]

	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_0.rankVOs[arg_12_0.curType]) do
		table = var_1_10007

		var_1_10007.insert(arg_12_0.displayRankVOs, iter_12_1)
	end

	local var_12_1 = arg_12_0.rankRect

	var_2.SetTotalCount(var_12_1, #arg_12_0.displayRankVOs)

	local var_12_2 = arg_12_0.playerRankVOs[arg_12_0.curType]

	setActive = var_3

	var_3(arg_12_0.playerRankTF, var_12_2)

	if var_12_2 then
		local var_12_3 = arg_12_0.playerCard

		var_3.Update(var_12_3, var_12_2, arg_12_0.curType)
	end

	return
end

function var_0_1.OnGetRankDone(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0.rankVOs[arg_13_1] = arg_13_3
	arg_13_0.playerRankVOs[arg_13_1] = arg_13_4

	arg_13_0:UpdataRankList()

	return
end

function var_0_1.willExit(arg_14_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_14_0.rankRect)

	ipairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.cards) do
		iter_14_1:Dispose()
	end

	arg_14_0.cards = nil

	local var_14_0 = arg_14_0.playerCard

	var_1.Dispose(var_14_0)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_1
