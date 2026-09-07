local NewBattleResultPlayerAniamtion = class("NewBattleResultPlayerAniamtion")

function NewBattleResultPlayerAniamtion:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.playerLv = arg_1_1
	self.playerExp = arg_1_2
	self.playerExpBar = arg_1_3
	self.newPlayer = arg_1_4
	self.oldPlayer = arg_1_5

	return
end

function NewBattleResultPlayerAniamtion:SetUp(arg_2_1)
	parallelAsync({
		function(arg_3_0)
			self:LevelAnimation(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:ExpAnimation(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:ExpBarAnimation(arg_5_0)

			return
		end
	}, arg_2_1)

	return
end

function NewBattleResultPlayerAniamtion:LevelAnimation(arg_6_1)
	if self.oldPlayer.level == self.newPlayer.level then
		self.playerLv.text = "Lv." .. self.newPlayer.level

		arg_6_1()

		return
	end

	LeanTween.value(self.playerLv.gameObject, self.oldPlayer.level, self.newPlayer.level, 1.5):setOnUpdate(System.Action_float(function(arg_7_0)
		self.playerLv.text = "Lv." .. math.ceil(arg_7_0)

		return
	end)):setOnComplete(System.Action(arg_6_1))

	return
end

function NewBattleResultPlayerAniamtion:ExpAnimation(arg_8_1)
	LeanTween.value(self.playerExp.gameObject, 0, NewBattleResultUtil.GetPlayerExpOffset(self.oldPlayer, self.newPlayer), 1.5):setOnUpdate(System.Action_float(function(arg_9_0)
		self.playerExp.text = "+" .. math.ceil(arg_9_0)

		return
	end)):setOnComplete(System.Action(arg_8_1))

	return
end

local function var_0_1(arg_10_0, arg_10_1)
	local var_10_0 = getConfigFromLevel1(pg.user_level, arg_10_0.newPlayer.level).exp_interval

	LeanTween.value(arg_10_0.playerExpBar.gameObject, arg_10_0.oldPlayer.exp, arg_10_0.newPlayer.exp, 1.5):setOnUpdate(System.Action_float(function(arg_11_0)
		arg_10_0.playerExpBar.fillAmount = arg_11_0 / var_10_0

		return
	end)):setOnComplete(System.Action(arg_10_1))

	return
end

local function var_0_2(arg_12_0, arg_12_1)
	LeanTween.value(arg_12_0.playerExpBar.gameObject, arg_12_0.oldPlayer.exp / getConfigFromLevel1(pg.user_level, arg_12_0.oldPlayer.level).exp_interval, 1, 1):setOnUpdate(System.Action_float(function(arg_13_0)
		arg_12_0.playerExpBar.fillAmount = arg_13_0

		return
	end)):setOnComplete(System.Action(arg_12_1))

	return
end

local function var_0_3(arg_14_0, arg_14_1)
	LeanTween.value(arg_14_0.playerExpBar.gameObject, 0, arg_14_0.newPlayer.exp / getConfigFromLevel1(pg.user_level, arg_14_0.newPlayer.level).exp_interval, 1):setOnUpdate(System.Action_float(function(arg_15_0)
		arg_14_0.playerExpBar.fillAmount = arg_15_0

		return
	end)):setOnComplete(System.Action(arg_14_1))

	return
end

local function var_0_4(arg_16_0, arg_16_1)
	LeanTween.value(arg_16_0.playerExpBar.gameObject, 0, 1, 1):setOnUpdate(System.Action_float(function(arg_17_0)
		arg_16_0.playerExpBar.fillAmount = arg_17_0

		return
	end)):setRepeat(arg_16_0.newPlayer.level - (arg_16_0.oldPlayer.level + 1)):setOnComplete(System.Action(arg_16_1))

	return
end

local function var_0_5(arg_18_0, arg_18_1)
	local var_18_0 = {}

	table.insert(var_18_0, function(arg_19_0)
		var_0_2(arg_18_0, arg_19_0)

		return
	end)

	if arg_18_0.oldPlayer.level + 1 ~= arg_18_0.newPlayer.level then
		table.insert(var_18_0, function(arg_20_0)
			var_0_4(arg_18_0, arg_20_0)

			return
		end)
	end

	table.insert(var_18_0, function(arg_21_0)
		var_0_3(arg_18_0, arg_21_0)

		return
	end)
	seriesAsync(var_18_0, arg_18_1)

	return
end

function NewBattleResultPlayerAniamtion:ExpBarAnimation(arg_22_1)
	if self.oldPlayer.level == self.newPlayer.level then
		var_0_1(self, arg_22_1)
	else
		var_0_5(self, arg_22_1)
	end

	return
end

function NewBattleResultPlayerAniamtion:Dispose()
	for iter_23_0, iter_23_1 in ipairs({
		"playerLv",
		"playerExp",
		"playerExpBar"
	}) do
		if LeanTween.isTweening(self[iter_23_1].gameObject) then
			LeanTween.cancel(self[iter_23_1].gameObject)
		end
	end

	return
end

return NewBattleResultPlayerAniamtion
