class = var_0_10000

local var_0_0 = "GuildRequestLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GuildRequestUI"
end

function var_0_1.setRequest(arg_2_0, arg_2_1)
	arg_2_0.requestVOs = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.viewRect = var_1.Find(var_3_0, "request_panel/view")

	local var_3_1 = arg_3_0._tf

	arg_3_0.listEmptyTF = var_1.Find(var_3_1, "main/frame/empty")

	local var_3_2 = arg_3_0._tf

	arg_3_0.listEmptyTF = var_1.Find(var_3_2, "empty")
	setActive = var_1

	var_1(arg_3_0.listEmptyTF, false)

	local var_3_3 = arg_3_0.listEmptyTF

	arg_3_0.listEmptyTxt = var_1.Find(var_3_3, "Text")
	setText = var_1

	local var_3_4 = arg_3_0.listEmptyTxt

	i18n = var_3

	var_1(var_3_4, var_3("list_empty_tip_guildrequestui"))

	local var_3_5 = arg_3_0.viewRect

	arg_3_0.scrollRect = var_1.GetComponent(var_3_5, "LScrollRect")

	return
end

function var_0_1.didEnter(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.GuildPaintingMgr.GetInstance()

	var_1.Hide(var_4_0)

	return
end

function var_0_1.initRequests(arg_5_0)
	arg_5_0.requestCards = {}

	function arg_5_0.scrollRect.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.onInitItem(var_6_0, arg_6_0)

		return
	end

	function arg_5_0.scrollRect.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.onUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	arg_5_0:SetTotalCount()

	return
end

function var_0_1.onInitItem(arg_8_0, arg_8_1)
	GuildRequestCard = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	onButton = var_3

	local var_8_1 = arg_8_0
	local var_8_2 = var_8_0.accpetBtn

	local function var_8_3()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		GuildRequestMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.ACCPET, var_8_0.requestVO.player.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_8_1, var_8_2, var_8_3, var_1_10007)

	onButton = var_3

	local var_8_4 = arg_8_0
	local var_8_5 = var_8_0.rejectBtn

	local function var_8_6()
		local var_10_0 = arg_8_0
		local var_10_1 = var_0.emit

		GuildRequestMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.REJECT, var_8_0.requestVO.player.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_8_4, var_8_5, var_8_6, var_1_10007)

	arg_8_0.requestCards[arg_8_1] = var_8_0

	return
end

function var_0_1.onUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.requestCards[arg_11_2] then
		arg_11_0:onInitItem(arg_11_2)

		var_11_0 = arg_11_0.requestCards[arg_11_2]
	end

	local var_11_1 = arg_11_0.requestVOs[arg_11_1 + 1]

	var_11_0:Update(var_11_1)

	return
end

function var_0_1.SetTotalCount(arg_12_0)
	table = var_1_10001

	var_1_10001.sort(arg_12_0.requestVOs, function(arg_13_0, arg_13_1)
		return arg_13_0.timestamp < arg_13_1.timestamp
	end)

	local var_12_0 = arg_12_0.scrollRect

	var_1.SetTotalCount(var_12_0, #arg_12_0.requestVOs, 0)

	setActive = var_1

	var_1(arg_12_0.listEmptyTF, #arg_12_0.requestVOs <= 0)

	return
end

function var_0_1.addRequest(arg_14_0, arg_14_1)
	table = var_1_10002

	var_1_10002.insert(arg_14_0.requestVOs, arg_14_1)
	arg_14_0:SetTotalCount()

	return
end

function var_0_1.deleteRequest(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.requestVOs) do
		if iter_15_1.player.id == arg_15_1 then
			table = var_7

			var_7.remove(arg_15_0.requestVOs, iter_15_0)

			break
		end
	end

	arg_15_0:SetTotalCount()

	return
end

function var_0_1.onBackPressed(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.CriMgr.GetInstance()
	local var_16_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_16_1(var_16_0, var_1_10003)
	arg_16_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.requestCards) do
		iter_17_1:Dispose()
	end

	return
end

return var_0_1
