class = var_0_10000

local var_0_0 = "CommanderHomeLevelInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderHomeLevelUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.close = var_1.Find(var_2_0, "bg/frame/close_btn")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "bg/frame/scrollrect")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_2, "LScrollRect")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "bg/frame/level/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.descPanel = var_1.Find(var_2_6, "desc_panel")

	local var_2_7 = arg_2_0.descPanel
	local var_2_8 = var_1.Find(var_2_7, "frame/level")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descLevelTxt = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0.descPanel
	local var_2_11 = var_1.Find(var_2_10, "frame/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "bg/frame/level/exp")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.expTxt = var_2_15(var_2_14, var_4(var_1_10006))
	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "bg/frame/level/label")

	i18n = var_4

	var_1(var_2_17, var_4("commander_home_level_label"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.cards = {}

	function arg_3_0.scrollrect.onInitItem(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnInitItem(var_4_0, arg_4_0)

		return
	end

	local var_3_0 = arg_3_0.scrollrect

	function var_3_0.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.OnUpdateItem(var_5_0, arg_5_0, arg_5_1)

		return
	end

	onButton = var_3_0

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.descPanel

	local function var_3_3()
		local var_6_0 = arg_3_0

		var_0.CloseDescWindow(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_3_0

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	local function var_3_6()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_3_0

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.close

	local function var_3_9()
		local var_8_0 = arg_3_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_7, var_3_8, var_3_9, var_1_10006)

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	CommanderHomeLevelCard = var_1_10002

	local var_9_0 = var_1_10002.New(arg_9_1, arg_9_0)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_1.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_0.displays[arg_10_1 + 1]

	var_10_0:Update(arg_10_0.home, var_10_1)

	return
end

function var_0_1.Show(arg_11_0, arg_11_1)
	var_0_1.super.Show(arg_11_0)

	arg_11_0.home = arg_11_1

	arg_11_0:InitMainView()

	return
end

function var_0_1.InitMainView(arg_12_0)
	local var_12_0 = arg_12_0.home

	arg_12_0.levelTxt.text = "LV." .. var_12_0:GetLevel()

	if var_12_0:IsMaxLevel() then
		arg_12_0.expTxt.text = "EXP MAX"
	else
		arg_12_0.expTxt.text = "EXP " .. var_12_0.exp .. "/" .. var_12_0:GetNextLevelExp()
	end

	local var_12_1 = var_12_0
	local var_12_2 = var_12_0.GetAllLevel(var_12_1)

	arg_12_0.displays = {}

	local var_12_3 = var_12_0:bindConfigTable()

	ipairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(var_12_2) do
		local var_12_4 = var_12_3[iter_12_1]
		local var_12_5 = var_12_0:GetTargetExpForLevel(iter_12_1)

		table = var_1_10011

		var_1_10011.insert(arg_12_0.displays, {
			level = var_12_4.level,
			totalExp = var_12_5,
			tail = iter_12_0 == #var_12_2,
			exp = var_12_4.home_exp,
			desc = var_12_3[iter_12_1].desc
		})
	end

	local var_12_6 = arg_12_0.scrollrect

	var_4.SetTotalCount(var_12_6, #arg_12_0.displays)

	return
end

function var_0_1.ShowDescWindow(arg_13_0, arg_13_1, arg_13_2)
	setActive = var_1_10003

	var_1_10003(arg_13_0.descPanel, true)

	arg_13_0.descTxt.text = arg_13_1
	arg_13_0.descLevelTxt.text = "LV." .. arg_13_2

	return
end

function var_0_1.CloseDescWindow(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.descPanel, false)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.cards) do
		iter_15_1:Dispose()
	end

	return
end

return var_0_1
