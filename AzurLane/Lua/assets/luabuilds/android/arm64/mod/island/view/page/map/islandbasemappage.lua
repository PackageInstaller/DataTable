class = var_0_10000

local var_0_0 = "IslandBaseMapPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

var_0_1.HIDE_DESC = "IslandBaseMapPage:HIDE_DESC"
var_0_1.CLOSE = "IslandBaseMapPage:CLOSE"

function var_0_1.getUIName(arg_1_0)
	return "IslandMapUI"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.maps = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	arg_2_0:InitMaps()

	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "adapt/title/Text")

	i18n = var_4

	var_1(var_2_2, var_4("island_map_title"))

	return
end

function var_0_1.InitMaps(arg_3_0)
	eachChild = var_1_10001

	var_1_10001(arg_3_0.bg, function(arg_4_0)
		local var_4_0 = arg_4_0.name

		if var_1.sub(var_4_0, -1) ~= "$" then
			tonumber = var_1

			local var_4_1 = var_1(arg_4_0.name)

			arg_3_0.maps[var_4_1] = arg_4_0
		end

		return
	end)

	return
end

function var_0_1.OnInit(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.maps) do
		onButton = var_1_10006

		local var_5_0 = arg_5_0
		local var_5_1 = iter_5_1

		local function var_5_2()
			local var_6_0 = arg_5_0

			if not var_0.CheckUnlock(var_6_0, iter_5_0) then
				return
			end

			local var_6_1 = arg_5_0

			var_0.ShowDesc(var_6_1, iter_5_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_5_0, var_5_1, var_5_2, var_1_10011)
	end

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_4.Find(var_5_4, "bg")

	local function var_5_6()
		if arg_5_0.selectedId then
			local var_7_0 = arg_5_0

			var_0.HideSelected(var_7_0)
		end

		return
	end

	SFX_PANEL = var_5_4

	var_1(var_5_3, var_5_5, var_5_6, var_5_4)

	onButton = var_1

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0._tf
	local var_5_9 = var_4.Find(var_5_8, "adapt/back")

	local function var_5_10()
		local var_8_0 = arg_5_0

		var_0.ClosePage(var_8_0, arg_5_0.class)

		return
	end

	SFX_PANEL = var_5_8

	var_1(var_5_7, var_5_9, var_5_10, var_5_8)

	onButton = var_1

	local var_5_11 = arg_5_0
	local var_5_12 = arg_5_0._tf
	local var_5_13 = var_4.Find(var_5_12, "adapt/home")

	local function var_5_14()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		BaseUI = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_5_12

	var_1(var_5_11, var_5_13, var_5_14, var_5_12)
	arg_5_0:bind(var_0_1.HIDE_DESC, function()
		local var_10_0 = arg_5_0

		var_0.HideSelected(var_10_0)

		return
	end)
	arg_5_0:bind(var_0_1.CLOSE, function()
		local var_11_0 = arg_5_0

		var_0.ClosePage(var_11_0, arg_5_0.class)

		return
	end)

	return
end

function var_0_1.OnShow(arg_12_0)
	arg_12_0:Flush()

	return
end

function var_0_1.Flush(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.maps) do
		setActive = var_1_10006

		var_1_10006(iter_13_1:Find("selcted"), false)

		var_1_10006 = arg_13_0:CheckUnlock(iter_13_0)
		setActive = var_1_10007

		var_1_10007(iter_13_1:Find("lock"), not var_1_10006)

		setActive = var_1_10007

		var_1_10007(iter_13_1:Find("full"), false)

		setActive = var_1_10007

		var_1_10007(iter_13_1:Find("finish"), false)

		setActive = var_1_10007

		var_1_10007(iter_13_1:Find("fetch"), false)

		setActive = var_1_10007

		var_1_10007(iter_13_1:Find("icon"), var_1_10006)
	end

	return
end

function var_0_1.CheckUnlock(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetIsland()
	local var_14_1 = var_2.GetAblityAgency(var_14_0)

	return (var_2.IsUnlockMap(var_14_1, arg_14_1))
end

function var_0_1.ShowDesc(arg_15_0, arg_15_1)
	if arg_15_0.selectedId then
		arg_15_0:HideSelected(arg_15_0.selectedId)
	end

	local var_15_0 = arg_15_0.maps[arg_15_1]

	setActive = var_1_10003

	var_1_10003(var_15_0:Find("selcted"), true)
	arg_15_0:GoDesc(arg_15_1)

	arg_15_0.selectedId = arg_15_1

	return
end

function var_0_1.HideSelected(arg_16_0)
	local var_16_0 = arg_16_0.selectedId

	if arg_16_0.maps[var_16_0] == nil then
		return
	end

	local var_16_1 = var_2:Find("selcted")
	local var_16_2 = var_3.GetComponent

	typeof = var_1_10007
	DftAniEvent = var_1_10009

	local var_16_3 = var_16_2(var_16_1, var_1_10007(var_1_10009))

	dftAniEvent = dftAniEvent

	var_4:SetEndEvent(function()
		dftAniEvent = var_2_10000

		var_2_10000:SetEndEvent(nil)

		setActive = var_0

		var_0(var_0, false)

		return
	end)

	local var_16_4 = var_3
	local var_16_5 = var_3.GetComponent

	typeof = var_7
	Animation = var_1_10009

	local var_16_6 = var_16_5(var_16_4, var_7(var_1_10009))

	var_4.Play(var_16_6, "IslandMapUI_selectedout")

	arg_16_0.selectedId = nil

	return
end

function var_0_1.GoDesc(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.OpenPage

	IslandBaseMapDescPage = var_1_10005

	var_18_1(var_18_0, var_1_10005, arg_18_1)

	return
end

return var_0_1
