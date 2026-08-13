class = var_0_10000

local var_0_0 = "AsideStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryStep"))

var_0_1.ASIDE_TYPE_HRZ = 1
var_0_1.ASIDE_TYPE_VEC = 2
var_0_1.ASIDE_TYPE_LEFTBOTTOMVEC = 3
var_0_1.ASIDE_TYPE_CENTERWITHFRAME = 4
var_0_1.SHOW_MODE_DEFAUT = 1
var_0_1.SHOW_MODE_BUBBLE = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.sequence = arg_1_1.sequence

	local var_1_0

	if not arg_1_1.asideType then
		var_1_0 = var_0_1.ASIDE_TYPE_HRZ
	end

	arg_1_0.asideType = var_1_0
	arg_1_0.signDate = arg_1_1.signDate
	arg_1_0.hideBgAlpha = arg_1_1.hideBgAlpha
	arg_1_0.rectOffset = arg_1_1.rectOffset
	arg_1_0.rectMargin = arg_1_1.rectMargin

	local var_1_1

	if not arg_1_1.rectAlpha then
		var_1_1 = 1
	end

	arg_1_0.rectAlpha = var_1_1
	arg_1_0.spacing = arg_1_1.spacing
	arg_1_0.typewriterSpeed = arg_1_1.typewriterTime

	local var_1_2

	if not arg_1_1.actor then
		var_1_2 = -1
	end

	arg_1_0.actor = var_1_2

	if arg_1_0.asideType == var_0_1.ASIDE_TYPE_LEFTBOTTOMVEC and not arg_1_1.showMode then
		arg_1_0.showMode = var_0_1.SHOW_MODE_BUBBLE
	else
		local var_1_3

		if not arg_1_1.showMode then
			var_1_3 = var_0_1.SHOW_MODE_DEFAUT
		end

		arg_1_0.showMode = var_1_3
	end

	if arg_1_0.asideType == var_0_1.ASIDE_TYPE_CENTERWITHFRAME then
		arg_1_0.hideBgAlpha = true
	end

	return
end

function var_0_1.GetPainting(arg_2_0)
	if arg_2_0.actor < 0 then
		return nil
	end

	pg = var_1

	local var_2_0 = var_1.ship_skin_template[arg_2_0.actor].ship_group

	ShipGroup = var_1_10003

	local var_2_1 = var_1_10003.getDefaultShipConfig(var_2_0)

	return var_1.painting
end

function var_0_1.GetMode(arg_3_0)
	Story = var_1_10001

	return var_1_10001.MODE_ASIDE
end

function var_0_1.GetTypewriterSpeed(arg_4_0)
	local var_4_0

	if not arg_4_0.typewriterSpeed then
		var_4_0 = 0.1
	end

	return var_4_0
end

function var_0_1.GetSequence(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.ShouldReplacePlayer(var_5_1)

	ipairs = var_5_1

	local var_5_3

	if not arg_5_0.sequence then
		var_5_3 = {}
	end

	for iter_5_0, iter_5_1 in var_5_1(var_5_3) do
		if var_5_2 then
			var_1_10009 = arg_5_0

			local var_5_4

			if not arg_5_0.ReplacePlayerName(var_1_10009, iter_5_1[1]) then
				var_5_4 = iter_5_1[1]
			end

			table = var_1_10009
			var_1_10009 = var_1_10009.insert

			local var_5_5 = var_5_0
			local var_5_6 = {}

			HXSet = var_1_10012
			var_5_6[1] = var_1_10012.hxLan(var_5_4)
			var_5_6[2] = iter_5_1[2]

			var_1_10009(var_5_5, var_5_6)
		end
	end

	return var_5_0
end

function var_0_1.GetAsideType(arg_6_0)
	return arg_6_0.asideType
end

function var_0_1.GetDateSign(arg_7_0)
	return arg_7_0.signDate
end

function var_0_1.GetShowMode(arg_8_0)
	return arg_8_0.showMode
end

function var_0_1.ShouldHideBGAlpha(arg_9_0)
	return arg_9_0.hideBgAlpha
end

function var_0_1.ShouldUpdateSpacing(arg_10_0)
	return arg_10_0.spacing ~= nil
end

function var_0_1.GetSpacing(arg_11_0)
	return arg_11_0.spacing
end

function var_0_1.ShouldUpdatePadding(arg_12_0)
	if arg_12_0:ShouldUpdateMargin() then
		return false
	end

	return arg_12_0.rectOffset ~= nil
end

function var_0_1.ShouldUpdateMargin(arg_13_0)
	return arg_13_0.rectMargin ~= nil
end

function var_0_1.GetMargin(arg_14_0)
	local var_14_0

	if not arg_14_0.rectMargin[1] then
		var_14_0 = 0
	end

	local var_14_1

	if not var_1[2] then
		var_14_1 = 0
	end

	local var_14_2

	if not var_1[3] then
		var_14_2 = 0
	end

	local var_14_3

	if not var_1[4] then
		var_14_3 = 0
	end

	return var_14_0, var_14_1, var_14_2, var_14_3
end

function var_0_1.GetPadding(arg_15_0)
	local var_15_0

	if not arg_15_0.rectOffset[1] then
		var_15_0 = 0
	end

	local var_15_1

	if not var_1[2] then
		var_15_1 = 0
	end

	local var_15_2

	if not var_1[3] then
		var_15_2 = 0
	end

	local var_15_3

	if not var_1[4] then
		var_15_3 = 0
	end

	return var_15_0, var_15_1, var_15_2, var_15_3
end

function var_0_1.GetRectAlpha(arg_16_0)
	return arg_16_0.rectAlpha
end

return var_0_1
