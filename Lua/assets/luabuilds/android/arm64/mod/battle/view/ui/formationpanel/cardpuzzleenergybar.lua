ys = ys or {}
ys.Battle.CardPuzzleEnergyBar = class("CardPuzzleEnergyBar")
ys.Battle.CardPuzzleEnergyBar.__name = "CardPuzzleEnergyBar"

function ys.Battle.CardPuzzleEnergyBar.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0._currentLabel = arg_1_0._tf:Find("count_label/count/current")
	arg_1_0._shadeLabel = arg_1_0._tf:Find("count_label/count/current")
	arg_1_0._maxLabel = arg_1_0._tf:Find("count_label/max")
	arg_1_0._recoverBlockList = arg_1_0._tf:Find("block_list")

	return
end

function ys.Battle.CardPuzzleEnergyBar.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1
	arg_2_0._energyInfo = arg_2_0._info:GetEnergy()
	arg_2_0._blockTFList = {}
	arg_2_0._max = arg_2_0._energyInfo:GetMaxEnergy()

	for iter_2_0 = 1, arg_2_0._max do
		local var_2_0 = arg_2_0._recoverBlockList:Find("block_" .. iter_2_0)

		table.insert(arg_2_0._blockTFList, {
			full = var_2_0:Find("full"),
			recover = var_2_0:Find("recover")
		})
	end

	arg_2_0._lastPoint = 0

	arg_2_0:activeRecoverBlock(arg_2_0._blockTFList[arg_2_0._lastPoint + 1])

	return
end

function ys.Battle.CardPuzzleEnergyBar.Update(arg_3_0)
	arg_3_0:updateEnergyPoint()
	arg_3_0:updateEnergyProgress()

	return
end

function ys.Battle.CardPuzzleEnergyBar.updateEnergyProgress(arg_4_0)
	local var_4_0 = arg_4_0._energyInfo:GetCurrentEnergy()

	if arg_4_0._lastPoint == var_4_0 then
		if var_4_0 >= arg_4_0._max then
			-- block empty
		else
			arg_4_0:updateRecoverBlock(arg_4_0._blockTFList[var_4_0 + 1])
		end
	else
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._blockTFList) do
			if iter_4_0 - 1 < var_4_0 then
				arg_4_0:updateSingleBlock(arg_4_0._blockTFList[iter_4_0], true)
			elseif iter_4_0 - 1 == var_4_0 then
				arg_4_0:activeRecoverBlock(arg_4_0._blockTFList[iter_4_0])
				arg_4_0:updateRecoverBlock(arg_4_0._blockTFList[iter_4_0])
			elseif var_4_0 < iter_4_0 - 1 then
				arg_4_0:updateSingleBlock(arg_4_0._blockTFList[iter_4_0], false)
			end
		end
	end

	arg_4_0._lastPoint = var_4_0

	return
end

function ys.Battle.CardPuzzleEnergyBar.updateEnergyPoint(arg_5_0)
	setText(arg_5_0._currentLabel, arg_5_0._energyInfo:GetCurrentEnergy())
	setText(arg_5_0._shadeLabel, arg_5_0._energyInfo:GetCurrentEnergy())
	setText(arg_5_0._maxLabel, arg_5_0._energyInfo:GetMaxEnergy())

	return
end

function ys.Battle.CardPuzzleEnergyBar.activeRecoverBlock(arg_6_0, arg_6_1)
	setActive(arg_6_1.full, false)
	setActive(arg_6_1.recover, true)

	return
end

function ys.Battle.CardPuzzleEnergyBar.updateRecoverBlock(arg_7_0, arg_7_1)
	arg_7_1.recover:GetComponent(typeof(Image)).fillAmount = arg_7_0._energyInfo:GetGeneratingProcess()

	return
end

function ys.Battle.CardPuzzleEnergyBar.updateSingleBlock(arg_8_0, arg_8_1, arg_8_2)
	setActive(arg_8_1.full, arg_8_2)
	setActive(arg_8_1.recover, false)

	return
end

function ys.Battle.CardPuzzleEnergyBar.Dispose(arg_9_0)
	arg_9_0._currentLabel = nil
	arg_9_0._maxLabel = nil
	arg_9_0._recoverBlockList = nil

	return
end

return
