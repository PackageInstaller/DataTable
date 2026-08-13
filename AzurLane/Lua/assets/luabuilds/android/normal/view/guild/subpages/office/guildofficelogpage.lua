class = var_0_10000

local var_0_0 = "GuildOfficeLogPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))
local var_0_2 = {}
local var_0_3 = {}

GuildConst = var_3
var_0_3[1] = var_3.TYPE_SUPPLY
GuildConst = var_3
var_0_3[2] = var_3.START_BATTLE
GuildConst = var_3
var_0_3[3] = var_3.TECHNOLOGY
var_0_2[1] = var_0_3

local var_0_4 = {}

GuildConst = var_3
var_0_4[1] = var_3.TYPE_DONATE
GuildConst = var_3
var_0_4[2] = var_3.WEEKLY_TASK
var_0_2[2] = var_0_4

local var_0_5 = {}

GuildConst = var_3
var_0_5[1] = var_3.TECHNOLOGY_OVER
GuildConst = var_3
var_0_5[2] = var_3.SWITCH_TOGGLE
var_0_2[3] = var_0_5

function var_0_1.Flag2Filter(arg_1_0, arg_1_1)
	local var_1_0 = {}

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(var_0_2) do
		bit = var_1_10008
		var_1_10008 = var_1_10008.lshift(1, iter_1_0)
		bit = var_9

		if var_9.band(arg_1_1, var_1_10008) > 0 then
			ipairs = var_9

			for iter_1_2, iter_1_3 in var_9(iter_1_1) do
				table = var_1_10014

				var_1_10014.insert(var_1_0, iter_1_3)
			end
		end
	end

	return var_1_0
end

function var_0_1.getUIName(arg_2_0)
	return "GuildOfficeLogPage"
end

function var_0_1.OnLoaded(arg_3_0)
	UIItemList = var_1_10001

	local var_3_0 = var_1_10001.New
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_2.Find(var_3_1, "frame/window/sliders/list/content")
	local var_3_3 = arg_3_0._tf

	arg_3_0.uilist = var_3_0(var_3_2, var_3.Find(var_3_3, "frame/window/sliders/list/content/tpl"))
	setText = var_1

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_2.Find(var_3_4, "frame/window/top/bg/infomation/title")

	i18n = var_3_4

	var_1(var_3_5, var_3_4("guild_log_title"))

	local var_3_6 = arg_3_0._tf

	arg_3_0.btnAll = var_1.Find(var_3_6, "frame/window/sliders/filter/1")

	local var_3_7 = {}
	local var_3_8 = arg_3_0._tf

	var_3_7[1] = var_2.Find(var_3_8, "frame/window/sliders/filter/2")

	local var_3_9 = arg_3_0._tf

	var_3_7[2] = var_2.Find(var_3_9, "frame/window/sliders/filter/3")

	local var_3_10 = arg_3_0._tf

	var_3_7[3] = var_2.Find(var_3_10, "frame/window/sliders/filter/4")
	arg_3_0.btns = var_3_7

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "frame/window/top/btnBack")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.Close(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "frame")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.Close(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	onButton = var_1_10001

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.btnAll

	local function var_4_10()
		local var_7_0 = arg_4_0

		var_0.SelectAll(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_8, var_4_9, var_4_10, var_5)

	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.btns) do
		onButton = var_1_10006

		local var_4_11 = arg_4_0
		local var_4_12 = iter_4_1

		local function var_4_13()
			if arg_4_0.allFlags ~= arg_4_0.flags then
				bit = var_0

				local var_8_0 = var_0.band
				local var_8_1 = arg_4_0.flags

				bit = var_2_10002

				if var_8_0(var_8_1, var_2_10002.lshift(1, iter_4_0)) > 0 then
					local var_8_2 = arg_4_0

					var_0.UnSelectFlag(var_8_2, iter_4_0, iter_4_1)

					goto label_8_0
				end
			end

			do
				local var_8_3 = arg_4_0

				var_0.SelectFlag(var_8_3, iter_4_0, iter_4_1)
			end

			::label_8_0::

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_4_11, var_4_12, var_4_13, var_1_10010)
	end

	return
end

function var_0_1.SelectAll(arg_9_0)
	arg_9_0.flags = 0
	pairs = var_1

	for iter_9_0, iter_9_1 in var_1(arg_9_0.btns) do
		setActive = var_1_10006

		var_1_10006(iter_9_1:Find("sel"), false)

		bit = var_1_10006
		var_1_10006 = var_1_10006.bor

		local var_9_0 = arg_9_0.flags

		bit = var_8
		arg_9_0.flags = var_1_10006(var_9_0, var_8.lshift(1, iter_9_0))
	end

	setActive = var_1

	local var_9_1 = arg_9_0.btnAll

	var_1(var_2.Find(var_9_1, "sel"), true)
	arg_9_0:Filter()

	return
end

function var_0_1.UnSelectFlag(arg_10_0, arg_10_1, arg_10_2)
	setActive = var_1_10003

	var_1_10003(arg_10_2:Find("sel"), false)

	bit = var_1_10003

	local var_10_0 = var_1_10003.bxor
	local var_10_1 = arg_10_0.flags

	bit = var_5

	if var_10_0(var_10_1, var_5.lshift(1, arg_10_1)) == 0 then
		arg_10_0:SelectAll()
	else
		arg_10_0.flags = var_3

		arg_10_0:Filter()
	end

	return
end

function var_0_1.SelectFlag(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.flags

	local function var_11_1()
		setActive = var_2_10000

		local var_12_0 = arg_11_2

		var_2_10000(var_1.Find(var_12_0, "sel"), true)

		setActive = var_2_10000

		local var_12_1 = arg_11_0.btnAll

		var_2_10000(var_1.Find(var_12_1, "sel"), false)

		local var_12_2 = arg_11_0

		bit = var_1

		local var_12_3 = var_1.bor
		local var_12_4 = arg_11_0.flags

		bit = var_3
		var_12_2.flags = var_12_3(var_12_4, var_3.lshift(1, arg_11_1))

		local var_12_5 = arg_11_0

		var_0.Filter(var_12_5)

		return
	end

	if var_11_0 ~= arg_11_0.allFlags then
		local var_11_2 = arg_11_0.allFlags

		bit = var_1_10006

		local var_11_3 = var_1_10006.bor
		local var_11_4 = arg_11_0.flags

		bit = var_1_10008

		if var_11_2 == var_11_3(var_11_4, var_1_10008.lshift(1, arg_11_1)) then
			arg_11_0:SelectAll()

			goto label_11_0
		end
	end

	if var_11_0 == arg_11_0.allFlags then
		arg_11_0.flags = 0

		var_11_1()
	else
		var_11_1()
	end

	::label_11_0::

	return
end

function var_0_1.Show(arg_13_0, arg_13_1)
	arg_13_0.guild = arg_13_1
	pg = var_1_10002

	local var_13_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_13_0, arg_13_0._tf)

	setActive = var_2

	var_2(arg_13_0._tf, true)

	triggerButton = var_2

	var_2(arg_13_0.btnAll)

	arg_13_0.allFlags = arg_13_0.flags

	return
end

function var_0_1.Filter(arg_14_0)
	local var_14_0 = arg_14_0.guild
	local var_14_1 = var_1.getCapitalLogs(var_14_0)

	arg_14_0.displays = {}

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.Flag2Filter(var_14_2, arg_14_0.flags)

	ipairs = var_14_2

	for iter_14_0, iter_14_1 in var_14_2(var_14_1) do
		if iter_14_1:IsSameType(var_14_3) then
			table = var_9

			var_9.insert(arg_14_0.displays, iter_14_1)
		end
	end

	local var_14_4 = arg_14_0.uilist

	var_4.make(var_14_4, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_14_0.displays[arg_15_1 + 1]

			setText = var_4

			var_4(arg_15_2, var_15_0:getText())
		end

		return
	end)

	local var_14_5 = arg_14_0.uilist

	var_4.align(var_14_5, #arg_14_0.displays)

	return
end

function var_0_1.Close(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0._tf, false)

	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_0, arg_16_0._tf, arg_16_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0:Close()

	return
end

return var_0_1
