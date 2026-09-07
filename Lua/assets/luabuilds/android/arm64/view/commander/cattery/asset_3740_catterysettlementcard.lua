local CatterySettlementCard = class("CatterySettlementCard")
local var_0_1 = 1

function CatterySettlementCard:Ctor(arg_1_1)
	self.tr = arg_1_1
	self.go = arg_1_1.gameObject
	self.emptyTF = findTF(self.tr, "empty")
	self.commanderTF = findTF(self.tr, "commander")
	self.nameTxt = findTF(self.commanderTF, "name"):GetComponent(typeof(Text))
	self.char = findTF(self.commanderTF, "mask/char")
	self.expTxt = findTF(self.commanderTF, "exp/Text"):GetComponent(typeof(Text))
	self.slider = findTF(self.commanderTF, "exp_bar"):GetComponent(typeof(Slider))
	self.levelTxt = findTF(self.commanderTF, "level"):GetComponent(typeof(Text))

	return
end

function CatterySettlementCard:Update(arg_2_1, arg_2_2)
	self.cattery = arg_2_1
	self.exp = arg_2_2

	local var_2_0 = arg_2_1:ExistCommander()

	if var_2_0 then
		self:UpdateCommander()
	end

	setActive(self.emptyTF, not var_2_0)
	setActive(self.commanderTF, var_2_0)

	return
end

function CatterySettlementCard:UpdateCommander()
	local var_3_0 = self.cattery:GetCommander()
	local var_3_1 = self:GetOldCommander(var_3_0, self.exp)

	self.oldCommander = var_3_1
	self.commander = var_3_0

	self:LoadCommander(var_3_0)

	self.slider.value = var_3_1.exp / var_3_1:getNextLevelExp()
	self.levelTxt.text = "LV." .. var_3_1:getLevel()
	self.expTxt.text = var_3_1.exp .. "/" .. var_3_1:getNextLevelExp()
	self.nameTxt.text = var_3_1:getName()

	return
end

function CatterySettlementCard:InitAnim(arg_4_1)
	local var_4_0 = self.commander:getNextLevelExp()
	local var_4_1 = self.commander.exp / var_4_0

	if self.oldCommander:getLevel() < self.commander:getLevel() then
		table.insert(arg_4_1, function(arg_5_0)
			self:DoUpgradeAnim(arg_5_0)

			return
		end)
	else
		table.insert(arg_4_1, function(arg_6_0)
			self:AddExpAnim(self.slider.value, var_4_1, self.oldCommander.exp, self.commander.exp, var_4_0, arg_6_0)

			return
		end)
	end

	return
end

function CatterySettlementCard:Action(arg_7_1)
	if not self.commander then
		arg_7_1()

		return
	end

	local var_7_0 = {}

	self:InitAnim(var_7_0)
	parallelAsync(var_7_0, arg_7_1)

	return
end

function CatterySettlementCard:DoUpgradeAnim(arg_8_1)
	local var_8_0 = self.oldCommander:getLevel()
	local var_8_1 = var_8_0
	local var_8_2 = self.commander:getNextLevelExp()
	local var_8_3 = self.commander.exp / var_8_2

	local function var_8_4()
		var_8_1 = var_8_1 + 1
		self.levelTxt.text = "LV." .. var_8_1

		return
	end

	local var_8_5 = {}
	local var_8_6 = var_8_0 + 1

	table.insert(var_8_5, function(arg_10_0)
		local var_10_0 = self.oldCommander:getNextLevelExp()

		self:AddExpAnim(self.slider.value, 1, self.oldCommander.exp, var_10_0, var_10_0, function()
			var_8_4()
			arg_10_0()

			return
		end)

		return
	end)

	while var_8_6 ~= self.commander:getLevel() do
		var_8_6 = var_8_6 + 1

		table.insert(var_8_5, function(arg_12_0)
			local var_12_0 = self.oldCommander:getConfigExp(var_8_1)

			self:AddExpAnim(0, 1, 0, var_12_0, var_12_0, function()
				var_8_4()
				arg_12_0()

				return
			end)

			return
		end)
	end

	table.insert(var_8_5, function(arg_14_0)
		self:AddExpAnim(0, var_8_3, 0, self.commander.exp, var_8_2, arg_14_0)

		return
	end)
	seriesAsync(var_8_5, arg_8_1)

	return
end

function CatterySettlementCard:LoadCommander(arg_15_1)
	self:ReturnCommander()

	self.painting = arg_15_1:getPainting()

	setCommanderPaintingPrefab(self.char, self.painting, "result")

	return
end

function CatterySettlementCard:ReturnCommander()
	if self.painting then
		retCommanderPaintingPrefab(self.char, self.painting)

		self.painting = nil
	end

	return
end

function CatterySettlementCard:Clear()
	if LeanTween.isTweening(go(self.slider)) then
		LeanTween.cancel(go(self.slider))
	end

	if LeanTween.isTweening(go(self.expTxt)) then
		LeanTween.cancel(go(self.expTxt))
	end

	return
end

function CatterySettlementCard:Dispose()
	self:Clear()
	self:ReturnCommander()

	return
end

function CatterySettlementCard:GetOldCommander(arg_19_1, arg_19_2)
	local var_19_0 = Clone(arg_19_1)

	var_19_0:ReduceExp(arg_19_2)

	return var_19_0
end

function CatterySettlementCard:AddExpAnim(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	parallelAsync({
		function(arg_21_0)
			LeanTween.value(go(self.slider), arg_20_1, arg_20_2, var_0_1):setOnUpdate(System.Action_float(function(arg_22_0)
				self.slider.value = arg_22_0

				return
			end)):setOnComplete(System.Action(arg_21_0))

			return
		end,
		function(arg_23_0)
			LeanTween.value(go(self.expTxt), arg_20_3, arg_20_4, var_0_1):setOnUpdate(System.Action_float(function(arg_24_0)
				self.expTxt.text = "<color=#94d53eFF>" .. math.ceil(arg_24_0) .. "/</color>" .. "<color=" .. self:GetColor() .. ">" .. arg_20_5 .. "</color>"

				return
			end)):setOnComplete(System.Action(arg_23_0))

			return
		end
	}, function()
		if arg_20_6 then
			arg_20_6()
		end

		return
	end)

	return
end

function CatterySettlementCard:GetColor()
	return "#9f9999"
end

return CatterySettlementCard
