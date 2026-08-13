class = var_0_10000

local var_0_0 = "WorldBossRankPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldBossRankUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.numberTF1 = var_1.Find(var_2_0, "frame/list/number1")
	setActive = var_1

	var_1(arg_2_0.numberTF1, false)

	local var_2_1 = arg_2_0._tf

	arg_2_0.numberTF2 = var_1.Find(var_2_1, "frame/list/number2")
	setActive = var_1

	var_1(arg_2_0.numberTF2, false)

	local var_2_2 = arg_2_0._tf

	arg_2_0.numberTF3 = var_1.Find(var_2_2, "frame/list/number3")
	setActive = var_1

	var_1(arg_2_0.numberTF3, false)

	local var_2_3 = arg_2_0._tf

	arg_2_0.numberTF4 = var_1.Find(var_2_3, "frame/list/number4")
	setActive = var_1

	var_1(arg_2_0.numberTF4, false)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Update(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.bossProxy = arg_5_1
	arg_5_0.bossId = arg_5_2

	arg_5_0:Show()
	arg_5_0:UpdateRankList()

	return
end

function var_0_1.UpdateRankList(arg_6_0)
	local var_6_0 = arg_6_0.bossId
	local var_6_1 = arg_6_0.bossProxy

	if var_2.GetRank(var_6_1, var_6_0) == nil then
		local var_6_2 = arg_6_0
		local var_6_3 = arg_6_0.emit

		WorldBossMediator = var_1_10007

		var_6_3(var_6_2, var_1_10007.ON_RANK_LIST, var_6_0)
	else
		arg_6_0:UpdateRanks(var_3)
	end

	return
end

function var_0_1.UpdateRanks(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 3 do
		local var_7_0 = arg_7_1[iter_7_0]
		local var_7_1 = arg_7_0["numberTF" .. iter_7_0]

		setActive = var_8

		var_8(var_7_1, var_7_0)

		if var_7_0 then
			arg_7_0:UpdateRank(var_7_1, var_7_0)
		end
	end

	getProxy = var_2
	PlayerProxy = var_4

	local var_7_2 = var_2(var_4)
	local var_7_3 = var_2.getRawData(var_7_2).id
	local var_7_4

	ipairs = var_7_2

	for iter_7_1, iter_7_2 in var_7_2(arg_7_1) do
		if iter_7_2.id == var_7_3 then
			var_7_4 = iter_7_2
			var_7_4.number = iter_7_1

			break
		end
	end

	if var_7_4 then
		arg_7_0:UpdateMyRank(arg_7_0.numberTF4, var_7_4)
	else
		setActive = var_4

		var_4(arg_7_0.numberTF4, false)
	end

	return
end

function var_0_1.UpdateRank(arg_8_0, arg_8_1, arg_8_2)
	setText = var_1_10003

	var_1_10003(arg_8_1:Find("Text"), arg_8_2.name)

	setText = var_1_10003

	var_1_10003(arg_8_1:Find("damage/Text"), arg_8_2.damage)

	setActive = var_1_10003

	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.Find(var_8_0, "view")
	local var_8_2 = arg_8_2.id

	getProxy = var_8_0
	PlayerProxy = var_1_10009

	local var_8_3 = var_8_0(var_1_10009)

	var_1_10003(var_8_1, var_8_2 ~= var_7.getRawData(var_8_3).id)

	onButton = var_1_10003

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_1
	local var_8_6 = arg_8_1.Find(var_8_5, "view")

	local function var_8_7()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		WorldBossMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.FETCH_RANK_FORMATION, arg_8_2.id, arg_8_0.bossId)

		return
	end

	SFX_PANEL = var_8_5

	var_1_10003(var_8_4, var_8_6, var_8_7, var_8_5)

	return
end

function var_0_1.UpdateMyRank(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:UpdateRank(arg_10_1, arg_10_2)

	setText = var_3

	var_3(arg_10_1:Find("number"), arg_10_2.number)

	return
end

function var_0_1.isActive(arg_11_0)
	isActive = var_1_10001

	return var_1_10001(arg_11_0._tf)
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
