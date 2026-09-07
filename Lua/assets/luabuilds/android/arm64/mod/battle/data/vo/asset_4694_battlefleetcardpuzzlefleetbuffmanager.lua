ys = ys or {}

local BattleFleetCardPuzzleFleetBuffManager = class("BattleFleetCardPuzzleFleetBuffManager")

ys.Battle.BattleFleetCardPuzzleFleetBuffManager = BattleFleetCardPuzzleFleetBuffManager
BattleFleetCardPuzzleFleetBuffManager.__name = "BattleFleetCardPuzzleFleetBuffManager"

function BattleFleetCardPuzzleFleetBuffManager:Ctor(arg_1_1)
	self._client = arg_1_1

	self:init()

	return
end

function BattleFleetCardPuzzleFleetBuffManager:Trigger(arg_2_1, arg_2_2)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(self._buffList) do
		if iter_2_1:IsResponTo(arg_2_1) then
			table.insert(var_2_0, iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		iter_2_3:onTrigger(arg_2_1, arg_2_2)
	end

	return
end

function BattleFleetCardPuzzleFleetBuffManager:Update(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self._buffList) do
		iter_3_1:Update(arg_3_1)
	end

	return
end

function BattleFleetCardPuzzleFleetBuffManager:AttachCardPuzzleBuff(arg_4_1)
	local var_4_0 = arg_4_1:GetID()
	local var_4_1 = self:GetCardPuzzleBuff(var_4_0)

	if var_4_1 then
		var_4_1:Stack()
	else
		self._buffList[var_4_0] = arg_4_1

		arg_4_1:Attach(self._client)
	end

	return
end

function BattleFleetCardPuzzleFleetBuffManager:GetCardPuzzleBuff(arg_5_1)
	return self._buffList[arg_5_1]
end

function BattleFleetCardPuzzleFleetBuffManager:GetCardPuzzleBuffList()
	return self._buffList
end

function BattleFleetCardPuzzleFleetBuffManager:init()
	self._buffList = {}

	return
end

return
