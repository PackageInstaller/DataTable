ys = ys or {}
ys.Battle.CardPuzzleEnergyBar = class("CardPuzzleEnergyBar")
ys.Battle.CardPuzzleEnergyBar.__name = "CardPuzzleEnergyBar"

function ys.Battle.CardPuzzleEnergyBar:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = self._go.transform
	self._currentLabel = self._tf:Find("count_label/count/current")
	self._shadeLabel = self._tf:Find("count_label/count/current")
	self._maxLabel = self._tf:Find("count_label/max")
	self._recoverBlockList = self._tf:Find("block_list")

	return
end

function ys.Battle.CardPuzzleEnergyBar:SetCardPuzzleComponent(arg_2_1)
	self._info = arg_2_1
	self._energyInfo = self._info:GetEnergy()
	self._blockTFList = {}
	self._max = self._energyInfo:GetMaxEnergy()

	for iter_2_0 = 1, self._max do
		local var_2_0 = self._recoverBlockList:Find("block_" .. iter_2_0)

		table.insert(self._blockTFList, {
			full = var_2_0:Find("full"),
			recover = var_2_0:Find("recover")
		})
	end

	self._lastPoint = 0

	self:activeRecoverBlock(self._blockTFList[self._lastPoint + 1])

	return
end

function ys.Battle.CardPuzzleEnergyBar:Update()
	self:updateEnergyPoint()
	self:updateEnergyProgress()

	return
end

function ys.Battle.CardPuzzleEnergyBar:updateEnergyProgress()
	local var_4_0 = self._energyInfo:GetCurrentEnergy()

	if self._lastPoint == var_4_0 then
		if var_4_0 >= self._max then
			-- block empty
		else
			self:updateRecoverBlock(self._blockTFList[var_4_0 + 1])
		end
	else
		for iter_4_0, iter_4_1 in ipairs(self._blockTFList) do
			if iter_4_0 - 1 < var_4_0 then
				self:updateSingleBlock(self._blockTFList[iter_4_0], true)
			elseif iter_4_0 - 1 == var_4_0 then
				self:activeRecoverBlock(self._blockTFList[iter_4_0])
				self:updateRecoverBlock(self._blockTFList[iter_4_0])
			elseif var_4_0 < iter_4_0 - 1 then
				self:updateSingleBlock(self._blockTFList[iter_4_0], false)
			end
		end
	end

	self._lastPoint = var_4_0

	return
end

function ys.Battle.CardPuzzleEnergyBar:updateEnergyPoint()
	setText(self._currentLabel, self._energyInfo:GetCurrentEnergy())
	setText(self._shadeLabel, self._energyInfo:GetCurrentEnergy())
	setText(self._maxLabel, self._energyInfo:GetMaxEnergy())

	return
end

function ys.Battle.CardPuzzleEnergyBar.activeRecoverBlock(arg_6_0, arg_6_1)
	setActive(arg_6_1.full, false)
	setActive(arg_6_1.recover, true)

	return
end

function ys.Battle.CardPuzzleEnergyBar:updateRecoverBlock(arg_7_1)
	arg_7_1.recover:GetComponent(typeof(Image)).fillAmount = self._energyInfo:GetGeneratingProcess()

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
