class = var_0_10000

local var_0_0 = "CommanderHomeSelCatteryStylePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderHomeSelCatteryStylePage"
end

function var_0_1.OnCatteryUpdate(arg_2_0, arg_2_1)
	arg_2_0.cattery = arg_2_1

	arg_2_0:Update(arg_2_0.home, arg_2_1)

	return
end

function var_0_1.OnCatteryStyleUpdate(arg_3_0, arg_3_1)
	arg_3_0:OnCatteryUpdate(arg_3_1)

	return
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "scrollrect")

	arg_4_0.scrollrect = var_1.GetComponent(var_4_1, "LScrollRect")

	local var_4_2 = arg_4_0._tf

	arg_4_0.okBtn = var_1.Find(var_4_2, "ok_button")
	setActive = var_1

	var_1(arg_4_0._tf, true)

	return
end

function var_0_1.OnInit(arg_5_0)
	arg_5_0.cards = {}

	function arg_5_0.scrollrect.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.OnInitItem(var_6_0, arg_6_0)

		return
	end

	local var_5_0 = arg_5_0.scrollrect

	function var_5_0.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.OnUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	onButton = var_5_0

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.okBtn

	local function var_5_3()
		if arg_5_0.selectedID then
			local var_8_0 = arg_5_0
			local var_8_1 = var_0.emit

			CommanderHomeMediator = var_2_10003

			var_8_1(var_8_0, var_2_10003.ON_CHANGE_STYLE, arg_5_0.cattery.id, arg_5_0.selectedID)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_1, var_5_2, var_5_3, var_1_10006)

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	CatteryStyleCard = var_1_10002

	local var_9_0 = var_1_10002.New(arg_9_1)

	onButton = var_1_10003

	local var_9_1 = arg_9_0
	local var_9_2 = var_9_0._tf

	local function var_9_3()
		local var_10_0 = var_9_0.style

		if not var_0.IsOwn(var_10_0) then
			pg = var_0

			local var_10_1 = var_0.TipsMgr.GetInstance()
			local var_10_2 = var_0.ShowTips

			i18n = var_2_10003

			var_10_2(var_10_1, var_2_10003("cathome_style_unlock"))

			return
		end

		local var_10_3 = var_9_0.style.id

		arg_9_0.selectedID = var_10_3

		local var_10_4 = arg_9_0
		local var_10_5 = var_1.emit

		CatteryDescPage = var_2_10004

		var_10_5(var_10_4, var_2_10004.CHANGE_STYLE, var_10_3)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_9_1, var_9_2, var_9_3, var_1_10008)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)

		var_11_0 = arg_11_0.cards[arg_11_2]
	end

	local var_11_1 = arg_11_0.displays[arg_11_1 + 1]
	local var_11_2 = arg_11_0.cattery
	local var_11_3 = var_5.GetStyle(var_11_2) == var_11_1.id

	var_11_0:Update(var_11_1, var_11_3)

	return
end

function var_0_1.Update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:Show()

	arg_12_0.home = arg_12_1
	arg_12_0.cattery = arg_12_2
	arg_12_0.displays = {}

	local var_12_0 = arg_12_1:GetOwnStyles()

	ipairs = var_1_10004
	pg = var_1_10006

	for iter_12_0, iter_12_1 in var_1_10004(var_1_10006.commander_home_style.all) do
		table = var_1_10009
		var_1_10009 = var_1_10009.contains(var_12_0, iter_12_1)
		CatteryStyle = var_1_10010
		var_1_10010 = var_1_10010.New({
			id = iter_12_1,
			own = var_1_10009
		})
		table = var_11

		var_11.insert(arg_12_0.displays, var_1_10010)
	end

	local var_12_1 = arg_12_0.scrollrect

	var_4.SetTotalCount(var_12_1, #arg_12_0.displays)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.cards) do
		iter_13_1:Dispose()
	end

	return
end

return var_0_1
