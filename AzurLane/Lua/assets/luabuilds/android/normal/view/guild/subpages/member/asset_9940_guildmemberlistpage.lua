class = var_0_10000

local var_0_0 = "GuildMemberListPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.GuildBasePage"))

function var_0_1.getTargetUI(arg_1_0)
	return "GuildMemberListBlueUI", "GuildMemberListRedUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rectView = var_1.Find(var_2_0, "scroll")

	local var_2_1 = arg_2_0.rectView

	arg_2_0.rectRect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf

	arg_2_0.rankBtn = var_1.Find(var_2_2, "rank")

	local var_2_3 = arg_2_0._tf

	arg_2_0.blurBg = var_1.Find(var_2_3, "blur_bg")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rankBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.contextData.rankPage

		var_0.ExecuteAction(var_4_0, "Flush", arg_3_0.ranks)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	pg = var_1_10001

	local var_3_3 = var_1_10001.UIMgr.GetInstance()
	local var_3_4 = var_1.OverlayPanel
	local var_3_5 = arg_3_0._tf
	local var_3_6 = {
		pbList = {
			arg_3_0.blurBg
		}
	}

	LayerWeightConst = var_5
	var_3_6.overlayType = var_5.OVERLAY_UI_ADAPT

	var_3_4(var_3_3, var_3_5, var_3_6)

	arg_3_0.items = {}

	function arg_3_0.rectRect.onInitItem(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.OnInitItem(var_5_0, arg_5_0)

		return
	end

	function arg_3_0.rectRect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:Show()
	arg_7_0:Flush(arg_7_1, arg_7_2, arg_7_3)

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.ranks = arg_8_3
	arg_8_0.memberVOs = arg_8_2
	arg_8_0.guildVO = arg_8_1

	arg_8_0:SetTotalCount()

	return
end

function var_0_1.SetTotalCount(arg_9_0)
	table = var_1_10001

	var_1_10001.sort(arg_9_0.memberVOs, function(arg_10_0, arg_10_1)
		if arg_10_0.duty ~= arg_10_1.duty then
			return arg_10_0.duty < arg_10_1.duty
		else
			return arg_10_0.liveness > arg_10_1.liveness
		end

		return
	end)

	local var_9_0 = arg_9_0.rectRect

	var_1.SetTotalCount(var_9_0, #arg_9_0.memberVOs, 0)

	return
end

function var_0_1.OnInitItem(arg_11_0, arg_11_1)
	GuildMemberCard = var_1_10002

	local var_11_0 = var_1_10002.New(arg_11_1)

	onButton = var_3

	local var_11_1 = arg_11_0
	local var_11_2 = var_11_0.tf

	local function var_11_3()
		if arg_11_0.selected == var_11_0 then
			return
		end

		if arg_11_0.selected then
			local var_12_0 = arg_11_0.selected

			var_0.SetSelected(var_12_0, false)
		end

		arg_11_0.selected = var_11_0

		local var_12_1 = arg_11_0.selected

		var_0.SetSelected(var_12_1, true)

		arg_11_0.selectedId = var_11_0.memberVO.id

		if arg_11_0.OnClickMember then
			arg_11_0.OnClickMember(var_11_0.memberVO)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_11_1, var_11_2, var_11_3, var_1_10007)

	arg_11_0.items[arg_11_1] = var_11_0

	return
end

function var_0_1.OnUpdateItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if not arg_13_0.items[arg_13_2] then
		arg_13_0:OnInitItem(arg_13_2)

		var_13_0 = arg_13_0.items[arg_13_2]
	end

	local var_13_1 = arg_13_0.memberVOs[arg_13_1 + 1]

	var_13_0:Update(var_13_1, arg_13_0.guildVO)

	local var_13_2 = var_13_0
	local var_13_3 = var_13_0.SetSelected
	local var_13_4

	if arg_13_0.selectedId then
		var_13_4 = arg_13_0.selectedId == var_13_1.id
	end

	var_13_3(var_13_2, var_13_4)

	if not arg_13_0.selected and arg_13_1 == 0 then
		triggerButton = var_5

		var_5(var_13_0.tf)
	end

	return
end

function var_0_1.TriggerFirstCard(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.items) do
		if iter_14_1.memberVO.id == arg_14_0.memberVOs[1].id then
			triggerButton = var_6

			var_6(iter_14_1.tf)

			break
		end
	end

	return
end

function var_0_1.OnDestroy(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf, arg_15_0._parentTf)

	pairs = var_1

	for iter_15_0, iter_15_1 in var_1(arg_15_0.items) do
		iter_15_1:Dispose()
	end

	return
end

return var_0_1
