local SailBoatBgControl = class("SailBoatBgControl")
local var_0_1

function SailBoatBgControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._followTarget = nil
	self._backGrounds = {}
	self._bgs = {}
	self._bgPool = {}
	self._bgMoveSpeed = Vector2(0, 0)
	self._bgMoveAmount = Vector2(0, 0)

	return
end

function SailBoatBgControl:start()
	for iter_2_0 = #self._bgs, 1, -1 do
		local var_2_0 = table.remove(self._bgs, iter_2_0)

		var_2_0:clear()
		table.insert(self._bgPool, var_2_0)
	end

	self._bgMoveAmount = Vector2(0, 0)

	self:initBgRound()

	for iter_2_1 = 1, #self._bgs do
		self._bgs[iter_2_1]:start()
	end

	self._bgMoveSpeed.x = var_0_1.moveAmount.x
	self._bgMoveSpeed.y = var_0_1.moveAmount.y

	var_0_1.SetGameBgs(self._bgs)

	return
end

function SailBoatBgControl:step(arg_3_1)
	local var_3_0 = var_0_1.GetSceneSpeed()

	self._bgMoveAmount.x = self._bgMoveAmount.x + var_3_0.x
	self._bgMoveAmount.y = self._bgMoveAmount.y + var_3_0.y

	for iter_3_0 = 1, #self._bgs do
		self._bgs[iter_3_0]:setMoveAmount(self._bgMoveAmount)
		self._bgs[iter_3_0]:step()
	end

	return
end

function SailBoatBgControl:setTarget(arg_4_1)
	self._followTarget = arg_4_1

	return
end

function SailBoatBgControl:setBackGround(arg_5_1)
	return
end

function SailBoatBgControl:clear()
	return
end

function SailBoatBgControl:getBgRoundData(arg_7_1)
	for iter_7_0 = 1, #SailBoatGameConst.game_bg_round do
		if SailBoatGameConst.game_bg_round[iter_7_0].round == arg_7_1 then
			return Clone(SailBoatGameConst.game_bg_round[iter_7_0])
		end
	end

	return nil
end

function SailBoatBgControl:initBgRound()
	local var_8_0 = var_0_1.GetRoundData()

	if not var_8_0 then
		return
	end

	for iter_8_0 = 1, #var_8_0.bg_rule do
		table.insert(self._bgs, (self:createAndInitBg(SailBoatGameConst.bg_rule[var_8_0.bg_rule[iter_8_0]])))
	end

	return
end

function SailBoatBgControl:createAndInitBg(arg_9_1)
	local var_9_0

	if self._bgPool and #self._bgPool > 0 then
		var_9_0 = table.remove(self._bgPool, 1)
	end

	var_9_0 = var_9_0 or SailBoatBg.New(self._tf, self._event)

	var_9_0:setRuleData(arg_9_1)

	return var_9_0
end

function SailBoatBgControl:useTestBgMove()
	return
end

function SailBoatBgControl:dispose()
	return
end

return SailBoatBgControl
