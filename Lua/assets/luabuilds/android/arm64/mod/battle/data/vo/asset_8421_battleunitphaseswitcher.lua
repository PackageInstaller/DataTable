ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst.BossPhaseSwitchType

ys.Battle.BattleUnitPhaseSwitcher = class("BattleUnitPhaseSwitcher")
ys.Battle.BattleUnitPhaseSwitcher.__name = "BattleUnitPhaseSwitcher"

function ys.Battle.BattleUnitPhaseSwitcher:Ctor(arg_1_1)
	self._client = arg_1_1

	self._client:AddPhaseSwitcher(self)

	self._randomWeaponList = {}

	return
end

function ys.Battle.BattleUnitPhaseSwitcher:Update()
	local var_2_0 = true
	local var_2_1

	for iter_2_0, iter_2_1 in ipairs(self._currentPhaseSwitchParam) do
		if iter_2_1.type == var_0_1.DURATION then
			if iter_2_1.param < pg.TimeMgr.GetInstance():GetCombatTime() - self._phaseStartTime then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		elseif iter_2_1.type == var_0_1.POSITION_X_GREATER then
			if iter_2_1.param < self._client:GetPosition().x then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		elseif iter_2_1.type == var_0_1.POSITION_X_LESS then
			if iter_2_1.param > self._client:GetPosition().x then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		elseif iter_2_1.type == var_0_1.OXYGEN and iter_2_1.param >= self._client:GetCuurentOxygen() then
			var_2_1 = iter_2_1.to
			iter_2_1.andFlag = false
		end

		var_2_0 = var_2_0 and not iter_2_1.andFlag
	end

	if var_2_1 and var_2_0 then
		self:switch(var_2_1)
	end

	return
end

function ys.Battle.BattleUnitPhaseSwitcher:UpdateHP(arg_3_1)
	local var_3_0 = true
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs(self._currentPhaseSwitchParam) do
		if iter_3_1.type == var_0_1.HP and arg_3_1 < iter_3_1.param then
			var_3_1 = iter_3_1.to
			iter_3_1.andFlag = false
		end

		var_3_0 = var_3_0 and not iter_3_1.andFlag
	end

	if var_3_1 and var_3_0 then
		self:switch(var_3_1)
	end

	return
end

function ys.Battle.BattleUnitPhaseSwitcher:SetTemplateData(arg_4_1)
	self._phaseList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self._phaseList[iter_4_1.index] = iter_4_1
	end

	self:switch(0)

	return
end

function ys.Battle.BattleUnitPhaseSwitcher:ForceSwitch(arg_5_1)
	self:switch(arg_5_1)

	return
end

function ys.Battle.BattleUnitPhaseSwitcher:switch(arg_6_1)
	if arg_6_1 == -1 or self._phaseList[arg_6_1] == nil then
		return
	end

	local var_6_0 = self._phaseList[arg_6_1]
	local var_6_1 = {}

	if self._phaseList[arg_6_1].removeWeapon then
		var_6_1 = Clone(var_6_0.removeWeapon)
	end

	if var_6_0.removeRandomWeapon then
		for iter_6_0, iter_6_1 in ipairs(self._randomWeaponList) do
			table.insert(var_6_1, iter_6_1)
		end

		self._randomWeaponList = {}
	end

	local var_6_2 = {}

	if var_6_0.addWeapon then
		var_6_2 = Clone(var_6_0.addWeapon)
	end

	if var_6_0.addRandomWeapon then
		for iter_6_2, iter_6_3 in ipairs(var_6_0.addRandomWeapon[math.random(#var_6_0.addRandomWeapon)]) do
			table.insert(var_6_2, iter_6_3)
			table.insert(self._randomWeaponList, iter_6_3)
		end
	end

	self._currentPhase = var_6_0

	self:packagePhaseSwitchParam(var_6_0)
	self._client:ShiftWeapon(var_6_1, var_6_2)

	if var_6_0.removeBuff then
		for iter_6_4, iter_6_5 in ipairs(var_6_0.removeBuff) do
			self._client:RemoveBuff(iter_6_5)
		end
	end

	if var_6_0.addBuff then
		for iter_6_6, iter_6_7 in ipairs(var_6_0.addBuff) do
			self._client:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_6_7, 1, self._client)))
		end
	end

	if var_6_0.dive then
		self._client:ChangeOxygenState(var_6_0.dive)
	end

	if var_6_0.setAI then
		self._client:SetAI(var_6_0.setAI)
	end

	if var_6_0.story then
		pg.NewStoryMgr.GetInstance():Play(var_6_0.story)
	end

	if var_6_0.guide then
		if var_6_0.guide.type == 1 then
			if pg.SeriesGuideMgr.GetInstance():isEnd() then
				goto label_6_0
			end
		end

		if var_6_0.guide.event == nil then
			pg.NewGuideMgr.GetInstance():Play(var_6_0.guide.step)
		else
			pg.NewGuideMgr.GetInstance():Play(var_6_0.guide.step, {
				var_6_0.guide.event
			})
		end
	end

	::label_6_0::

	self._phaseStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	if var_6_0.retreat == true then
		self._client:Retreat()
	end

	return
end

function ys.Battle.BattleUnitPhaseSwitcher:packagePhaseSwitchParam(arg_7_1)
	self._currentPhaseSwitchParam = {}

	local var_7_0 = type(arg_7_1.switchType)

	if var_7_0 == "table" then
		local var_7_1 = arg_7_1.switchType
		local var_7_2 = arg_7_1.switchParam
		local var_7_3 = arg_7_1.switchTo
		local var_7_4 = type(arg_7_1.switchTo) == "number"
		local var_7_5 = 1

		while var_7_5 <= #arg_7_1.switchType do
			local var_7_6 = {
				type = var_7_1[var_7_5],
				param = var_7_2[var_7_5]
			}

			if var_7_4 then
				var_7_6.to = var_7_3
				var_7_6.andFlag = true
			else
				var_7_6.to = var_7_3[var_7_5]
			end

			table.insert(self._currentPhaseSwitchParam, var_7_6)

			var_7_5 = var_7_5 + 1
		end
	elseif var_7_0 == "number" then
		local var_7_7 = {
			type = arg_7_1.switchType
		}

		var_7_7.param = arg_7_1.switchParamFunc and arg_7_1.switchParamFunc() or arg_7_1.switchParam
		var_7_7.to = arg_7_1.switchTo

		table.insert(self._currentPhaseSwitchParam, var_7_7)
	end

	return
end

return
