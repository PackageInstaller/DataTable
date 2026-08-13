class = var_0_10000

local var_0_0 = "CourtYardRightPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "main/rightPanel"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.buffBtn = var_1.Find(var_2_0, "buff")

	local var_2_1 = arg_2_0._tf

	arg_2_0.oneKeyBtn = var_1.Find(var_2_1, "onekey")
	CourtYardBuffPage = var_1
	arg_2_0.buffPage = var_1.New(arg_2_0._tf.parent.parent, arg_2_0.parent)

	return
end

function var_0_1.GenBuffData(arg_3_0)
	local var_3_0 = {}

	ipairs = var_1_10002
	BuffHelper = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10002(var_1_10004.GetBackYardPlayerBuffs()) do
		if iter_3_1:isActivate() then
			table = var_7

			var_7.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_1.OnRegister(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.buffBtn

	local function var_4_2()
		local var_5_1

		if not arg_4_0.buffList then
			local var_5_0 = arg_4_0

			var_5_1 = var_0.GenBuffData(var_5_0)
		end

		if #var_5_1 > 0 then
			local var_5_2 = arg_4_0.buffPage

			var_1.ExecuteAction(var_5_2, "Show", var_5_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.oneKeyBtn

	local function var_4_5()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		CourtYardMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.ONE_KEY)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	return
end

function var_0_1.OnVisitRegister(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0._tf, false)

	return
end

function var_0_1.OnFlush(arg_8_0, arg_8_1)
	if not arg_8_1 then
		bit = var_1_10002

		local var_8_0 = var_1_10002.bor

		BackYardConst = var_1_10004

		local var_8_1 = var_1_10004.DORM_UPDATE_TYPE_LEVEL

		BackYardConst = var_1_10005

		local var_8_2 = var_1_10005.DORM_UPDATE_TYPE_USEFOOD

		BackYardConst = var_1_10006
		arg_8_1 = var_8_0(var_8_1, var_8_2, var_1_10006.DORM_UPDATE_TYPE_SHIP)
	end

	local var_8_3 = arg_8_0.dorm

	bit = var_1_10003

	local var_8_4 = var_1_10003.band
	local var_8_5 = arg_8_1

	BackYardConst = var_1_10006

	local var_8_7

	if var_8_4(var_8_5, var_1_10006.DORM_UPDATE_TYPE_USEFOOD) > 0 and arg_8_0:IsInner() then
		arg_8_0.buffList = arg_8_0:GenBuffData()
		setActive = var_3

		local var_8_6 = arg_8_0.buffBtn

		var_8_7 = #arg_8_0.buffList > 0

		var_3(var_8_6, var_8_7)
	end

	bit = var_3

	local var_8_8 = var_3.band
	local var_8_9 = arg_8_1

	BackYardConst = var_8_7

	if var_8_8(var_8_9, var_8_7.DORM_UPDATE_TYPE_SHIP) > 0 then
		setActive = var_3

		var_3(arg_8_0.oneKeyBtn, var_8_3:AnyShipExistIntimacyOrMoney())
	end

	return
end

function var_0_1.GetMoveX(arg_9_0)
	return {
		{
			arg_9_0._tf,
			1
		}
	}
end

function var_0_1.OnDispose(arg_10_0)
	if arg_10_0.buffPage then
		local var_10_0 = arg_10_0.buffPage

		var_1.Destroy(var_10_0)

		arg_10_0.buffPage = nil
	end

	return
end

return var_0_1
