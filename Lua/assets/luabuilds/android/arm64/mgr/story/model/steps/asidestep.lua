local var_0_0 = class("AsideStep", import(".StoryStep"))

var_0_0.ASIDE_TYPE_HRZ = 1
var_0_0.ASIDE_TYPE_VEC = 2
var_0_0.ASIDE_TYPE_LEFTBOTTOMVEC = 3
var_0_0.ASIDE_TYPE_CENTERWITHFRAME = 4
var_0_0.SHOW_MODE_DEFAUT = 1
var_0_0.SHOW_MODE_BUBBLE = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.sequence = arg_1_1.sequence
	arg_1_0.asideType = arg_1_1.asideType or var_0_0.ASIDE_TYPE_HRZ
	arg_1_0.signDate = arg_1_1.signDate
	arg_1_0.hideBgAlpha = arg_1_1.hideBgAlpha
	arg_1_0.rectOffset = arg_1_1.rectOffset
	arg_1_0.rectMargin = arg_1_1.rectMargin
	arg_1_0.rectAlpha = arg_1_1.rectAlpha or 1
	arg_1_0.spacing = arg_1_1.spacing
	arg_1_0.typewriterSpeed = arg_1_1.typewriterTime
	arg_1_0.actor = arg_1_1.actor or -1
	arg_1_0.showMode = arg_1_0.asideType == var_0_0.ASIDE_TYPE_LEFTBOTTOMVEC and not arg_1_1.showMode and var_0_0.SHOW_MODE_BUBBLE or arg_1_1.showMode or var_0_0.SHOW_MODE_DEFAUT

	if arg_1_0.asideType == var_0_0.ASIDE_TYPE_CENTERWITHFRAME then
		arg_1_0.hideBgAlpha = true
	end

	return
end

function var_0_0.GetPainting(arg_2_0)
	local var_2_0

	if arg_2_0.actor < 0 then
		do return nil end

		var_2_0 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[arg_2_0.actor].ship_group)
	end

	return pg.ship_skin_template[arg_2_0.actor].painting
end

function var_0_0.GetMode(arg_3_0)
	return Story.MODE_ASIDE
end

function var_0_0.GetTypewriterSpeed(arg_4_0)
	return arg_4_0.typewriterSpeed or 0.1
end

function var_0_0.GetSequence(arg_5_0)
	local var_5_0 = arg_5_0:ShouldReplacePlayer()
	local var_5_1 = arg_5_0.sequence or {}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = var_5_0 and arg_5_0:ReplacePlayerName(iter_5_1[1]) or iter_5_1[1]

		if arg_5_0:ShouldReplaceCar2026() then
			var_5_2 = arg_5_0:ReplaceCar2026Name(var_5_2)
		end

		table.insert({}, {
			HXSet.hxLan(var_5_2),
			iter_5_1[2]
		})
	end

	return {}
end

function var_0_0.GetAsideType(arg_6_0)
	return arg_6_0.asideType
end

function var_0_0.GetDateSign(arg_7_0)
	return arg_7_0.signDate
end

function var_0_0.GetShowMode(arg_8_0)
	return arg_8_0.showMode
end

function var_0_0.ShouldHideBGAlpha(arg_9_0)
	return arg_9_0.hideBgAlpha
end

function var_0_0.ShouldUpdateSpacing(arg_10_0)
	return arg_10_0.spacing ~= nil
end

function var_0_0.GetSpacing(arg_11_0)
	return arg_11_0.spacing
end

function var_0_0.ShouldUpdatePadding(arg_12_0)
	if arg_12_0:ShouldUpdateMargin() then
		return false
	end

	return arg_12_0.rectOffset ~= nil
end

function var_0_0.ShouldUpdateMargin(arg_13_0)
	return arg_13_0.rectMargin ~= nil
end

function var_0_0.GetMargin(arg_14_0)
	local var_14_0 = arg_14_0.rectMargin[1] or 0
	local var_14_1 = arg_14_0.rectMargin[2] or 0
	local var_14_2 = arg_14_0.rectMargin[3] or 0
	local var_14_3 = arg_14_0.rectMargin[4] or 0

	return var_14_0, var_14_1, var_14_2, var_14_3
end

function var_0_0.GetPadding(arg_15_0)
	local var_15_0 = arg_15_0.rectOffset[1] or 0
	local var_15_1 = arg_15_0.rectOffset[2] or 0
	local var_15_2 = arg_15_0.rectOffset[3] or 0
	local var_15_3 = arg_15_0.rectOffset[4] or 0

	return var_15_0, var_15_1, var_15_2, var_15_3
end

function var_0_0.GetRectAlpha(arg_16_0)
	return arg_16_0.rectAlpha
end

return var_0_0
