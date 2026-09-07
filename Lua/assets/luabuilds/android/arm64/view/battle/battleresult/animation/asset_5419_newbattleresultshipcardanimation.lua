local NewBattleResultShipCardAnimation = class("NewBattleResultShipCardAnimation")

function NewBattleResultShipCardAnimation:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.isExpMode = arg_1_2
	self.maxOutput = arg_1_6
	self.ship = arg_1_3
	self.newShip = arg_1_4
	self.statistic = arg_1_5 or {}
	self.label1 = arg_1_1:Find("atk"):GetComponent(typeof(Text))
	self.label2 = arg_1_1:Find("killCount"):GetComponent(typeof(Text))
	self.damagebar = arg_1_1:Find("dmg/bar"):GetComponent(typeof(Image))

	return
end

function NewBattleResultShipCardAnimation:SetUp(arg_2_1)
	self:Clear()

	if self.isExpMode then
		self:DoExpAnimation(arg_2_1)
	else
		self:DoOutputAnimation(arg_2_1)
	end

	return
end

function NewBattleResultShipCardAnimation:DoExpAnimation(arg_3_1)
	parallelAsync({
		function(arg_4_0)
			self:ExpAnimation(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:LevelAnimation(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:ExpBarAnimation(arg_6_0)

			return
		end
	}, arg_3_1)

	return
end

function NewBattleResultShipCardAnimation:ExpAnimation(arg_7_1)
	LeanTween.value(self.label1.gameObject, 0, NewBattleResultUtil.GetShipExpOffset(self.ship, self.newShip), 1):setOnUpdate(System.Action_float(function(arg_8_0)
		self.label1.text = "EXP" .. "<color=#FFDE38>+" .. math.ceil(arg_8_0) .. "</color>"

		return
	end)):setOnComplete(System.Action(arg_7_1))

	return
end

function NewBattleResultShipCardAnimation:LevelAnimation(arg_9_1)
	if self.ship.level == self.newShip.level then
		self.label2.text = "Lv." .. self.newShip.level

		arg_9_1()

		return
	end

	LeanTween.value(self.label2.gameObject, self.ship.level, self.newShip.level, 1):setOnUpdate(System.Action_float(function(arg_10_0)
		self.label2.text = "Lv." .. math.ceil(arg_10_0)

		return
	end)):setOnComplete(System.Action(arg_9_1))

	return
end

local function var_0_1(arg_11_0, arg_11_1)
	local var_11_0 = getExpByRarityFromLv1(arg_11_0.newShip:getConfig("rarity"), arg_11_0.newShip.level)

	LeanTween.value(arg_11_0.damagebar.gameObject, arg_11_0.ship:getExp(), arg_11_0.newShip:getExp(), 1):setOnUpdate(System.Action_float(function(arg_12_0)
		arg_11_0.damagebar.fillAmount = arg_12_0 / var_11_0

		return
	end)):setOnComplete(System.Action(arg_11_1))

	return
end

local function var_0_2(arg_13_0, arg_13_1)
	LeanTween.value(arg_13_0.damagebar.gameObject, arg_13_0.ship:getExp() / getExpByRarityFromLv1(arg_13_0.ship:getConfig("rarity"), arg_13_0.ship.level), 1, 0.5):setOnUpdate(System.Action_float(function(arg_14_0)
		arg_13_0.damagebar.fillAmount = arg_14_0

		return
	end)):setOnComplete(System.Action(arg_13_1))

	return
end

local function var_0_3(arg_15_0, arg_15_1)
	LeanTween.value(arg_15_0.damagebar.gameObject, 0, arg_15_0.newShip:getExp() / getExpByRarityFromLv1(arg_15_0.newShip:getConfig("rarity"), arg_15_0.newShip.level), 0.5):setOnUpdate(System.Action_float(function(arg_16_0)
		arg_15_0.damagebar.fillAmount = arg_16_0

		return
	end)):setOnComplete(System.Action(arg_15_1))

	return
end

local function var_0_4(arg_17_0, arg_17_1)
	LeanTween.value(arg_17_0.damagebar.gameObject, 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_18_0)
		arg_17_0.damagebar.fillAmount = arg_18_0

		return
	end)):setRepeat(arg_17_0.newShip.level - (arg_17_0.ship.level + 1)):setOnComplete(System.Action(arg_17_1))

	return
end

local function var_0_5(arg_19_0, arg_19_1)
	local var_19_0 = {}

	table.insert(var_19_0, function(arg_20_0)
		var_0_2(arg_19_0, arg_20_0)

		return
	end)

	if arg_19_0.ship.level + 1 ~= arg_19_0.newShip.level then
		table.insert(var_19_0, function(arg_21_0)
			var_0_4(arg_19_0, arg_21_0)

			return
		end)
	end

	table.insert(var_19_0, function(arg_22_0)
		var_0_3(arg_19_0, arg_22_0)

		return
	end)
	seriesAsync(var_19_0, arg_19_1)

	return
end

function NewBattleResultShipCardAnimation:ExpBarAnimation(arg_23_1)
	if self.ship.level == self.newShip.level then
		var_0_1(self, arg_23_1)
	else
		var_0_5(self, arg_23_1)
	end

	return
end

function NewBattleResultShipCardAnimation:DoOutputAnimation(arg_24_1)
	parallelAsync({
		function(arg_25_0)
			self:KillCntAnimation(arg_25_0)

			return
		end,
		function(arg_26_0)
			self:OutputAnimation(arg_26_0)

			return
		end,
		function(arg_27_0)
			self:OutputBarAnimation(arg_27_0)

			return
		end
	}, arg_24_1)

	return
end

function NewBattleResultShipCardAnimation:KillCntAnimation(arg_28_1)
	LeanTween.value(self.label2.gameObject, 0, self.statistic.kill_count or 0, 1):setOnUpdate(System.Action_float(function(arg_29_0)
		self.label2.text = math.ceil(arg_29_0)

		return
	end)):setOnComplete(System.Action(arg_28_1))

	return
end

function NewBattleResultShipCardAnimation:OutputAnimation(arg_30_1)
	LeanTween.value(self.label1.gameObject, 0, self.statistic.output or 0, 1):setOnUpdate(System.Action_float(function(arg_31_0)
		self.label1.text = math.ceil(arg_31_0)

		return
	end)):setOnComplete(System.Action(arg_30_1))

	return
end

function NewBattleResultShipCardAnimation:OutputBarAnimation(arg_32_1)
	LeanTween.value(self.damagebar.gameObject, 0, (self.statistic.output or 0) / self.maxOutput, 1):setOnUpdate(System.Action_float(function(arg_33_0)
		self.damagebar.fillAmount = arg_33_0

		return
	end)):setOnComplete(System.Action(arg_32_1))

	return
end

function NewBattleResultShipCardAnimation:Clear()
	for iter_34_0, iter_34_1 in ipairs({
		"label1",
		"label2",
		"damagebar"
	}) do
		if LeanTween.isTweening(self[iter_34_1].gameObject) then
			LeanTween.cancel(self[iter_34_1].gameObject)
		end
	end

	return
end

function NewBattleResultShipCardAnimation:Dispose()
	self:Clear()

	return
end

return NewBattleResultShipCardAnimation
