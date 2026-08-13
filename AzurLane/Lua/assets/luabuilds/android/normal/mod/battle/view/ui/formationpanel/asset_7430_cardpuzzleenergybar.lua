ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.CardPuzzleEnergyBar = var_0_10003("CardPuzzleEnergyBar")

local var_0_3 = var_0.Battle.CardPuzzleEnergyBar

var_0_3.__name = "CardPuzzleEnergyBar"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._currentLabel = var_2.Find(var_1_0, "count_label/count/current")

	local var_1_1 = arg_1_0._tf

	arg_1_0._shadeLabel = var_2.Find(var_1_1, "count_label/count/current")

	local var_1_2 = arg_1_0._tf

	arg_1_0._maxLabel = var_2.Find(var_1_2, "count_label/max")

	local var_1_3 = arg_1_0._tf

	arg_1_0._recoverBlockList = var_2.Find(var_1_3, "block_list")

	return
end

function var_0_3.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1

	local var_2_0 = arg_2_0._info

	arg_2_0._energyInfo = var_2.GetEnergy(var_2_0)
	arg_2_0._blockTFList = {}

	local var_2_1 = arg_2_0._energyInfo

	arg_2_0._max = var_2.GetMaxEnergy(var_2_1)

	for iter_2_0 = 1, arg_2_0._max do
		local var_2_2 = arg_2_0._recoverBlockList
		local var_2_3 = var_6.Find(var_2_2, "block_" .. iter_2_0)
		local var_2_4 = var_6.Find(var_2_3, "full")
		local var_2_5 = var_6:Find("recover")
		local var_2_6 = {
			full = var_2_4,
			recover = var_2_5
		}

		table = var_10

		var_10.insert(arg_2_0._blockTFList, var_2_6)
	end

	arg_2_0._lastPoint = 0

	local var_2_7 = arg_2_0._blockTFList[arg_2_0._lastPoint + 1]

	arg_2_0:activeRecoverBlock(var_2_7)

	return
end

function var_0_3.Update(arg_3_0)
	arg_3_0:updateEnergyPoint()
	arg_3_0:updateEnergyProgress()

	return
end

function var_0_3.updateEnergyProgress(arg_4_0)
	local var_4_0 = arg_4_0._energyInfo
	local var_4_1 = var_1.GetCurrentEnergy(var_4_0)

	if arg_4_0._lastPoint == var_4_1 then
		if var_4_1 >= arg_4_0._max then
			-- block empty
		else
			local var_4_2 = arg_4_0._blockTFList[var_4_1 + 1]

			var_1_10004 = arg_4_0

			arg_4_0.updateRecoverBlock(var_1_10004, var_4_2)
		end
	else
		local var_4_3 = arg_4_0._max
		local var_4_4 = arg_4_0._blockTFList

		ipairs = var_1_10004

		for iter_4_0, iter_4_1 in var_1_10004(var_4_4) do
			local var_4_5 = arg_4_0._blockTFList[iter_4_0]

			if iter_4_0 - 1 < var_4_1 then
				arg_4_0:updateSingleBlock(var_4_5, true)
			elseif var_10 == var_4_1 then
				arg_4_0:activeRecoverBlock(var_4_5)
				arg_4_0:updateRecoverBlock(var_4_5)
			elseif var_4_1 < var_10 then
				arg_4_0:updateSingleBlock(var_4_5, false)
			end
		end
	end

	arg_4_0._lastPoint = var_4_1

	return
end

function var_0_3.updateEnergyPoint(arg_5_0)
	setText = var_1_10001

	local var_5_0 = arg_5_0._currentLabel
	local var_5_1 = arg_5_0._energyInfo

	var_1_10001(var_5_0, var_3.GetCurrentEnergy(var_5_1))

	setText = var_1_10001

	local var_5_2 = arg_5_0._shadeLabel
	local var_5_3 = arg_5_0._energyInfo

	var_1_10001(var_5_2, var_3.GetCurrentEnergy(var_5_3))

	setText = var_1_10001

	local var_5_4 = arg_5_0._maxLabel
	local var_5_5 = arg_5_0._energyInfo

	var_1_10001(var_5_4, var_3.GetMaxEnergy(var_5_5))

	return
end

function var_0_3.activeRecoverBlock(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_1.full, false)

	setActive = var_1_10002

	var_1_10002(arg_6_1.recover, true)

	return
end

function var_0_3.updateRecoverBlock(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.full
	local var_7_1 = arg_7_1.recover
	local var_7_2 = var_3.GetComponent

	typeof = var_1_10006
	Image = var_1_10007

	local var_7_3 = var_7_2(var_7_1, var_1_10006(var_1_10007))
	local var_7_4 = arg_7_0._energyInfo

	var_7_3.fillAmount = var_5.GetGeneratingProcess(var_7_4)

	return
end

function var_0_3.updateSingleBlock(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.full
	local var_8_1 = arg_8_1.recover

	setActive = var_1_10005

	var_1_10005(var_8_0, arg_8_2)

	setActive = var_1_10005

	var_1_10005(var_8_1, false)

	return
end

function var_0_3.Dispose(arg_9_0)
	arg_9_0._currentLabel = nil
	arg_9_0._maxLabel = nil
	arg_9_0._recoverBlockList = nil

	return
end

return
