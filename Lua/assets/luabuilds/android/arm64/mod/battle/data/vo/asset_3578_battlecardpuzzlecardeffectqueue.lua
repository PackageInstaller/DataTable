ys = ys or {}

local var_0_0 = ys
local BattleCardPuzzleCardEffectQueue = class("BattleCardPuzzleCardEffectQueue")

ys.Battle.BattleCardPuzzleCardEffectQueue = BattleCardPuzzleCardEffectQueue
BattleCardPuzzleCardEffectQueue.__name = "BattleCardPuzzleCardEffectQueue"
BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_NORMAL = "normal"
BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN = "return"

function BattleCardPuzzleCardEffectQueue:Ctor(arg_1_1)
	self._card = arg_1_1
	self._holdForInputMark = false
	self._condition = nil
	self._moveAfterCast = nil
	self._effectList = {}
	self._headEffect = nil

	return
end

function BattleCardPuzzleCardEffectQueue:SetQueueType(arg_2_1)
	self._queueType = arg_2_1

	return
end

function BattleCardPuzzleCardEffectQueue:GetQueueType()
	return self._queueType
end

function BattleCardPuzzleCardEffectQueue:ConfigData(arg_4_1)
	self._condition = arg_4_1.condition
	self._branch = arg_4_1.branch

	local var_4_0 = #arg_4_1
	local var_4_1 = -1

	while var_4_0 > 0 do
		local var_4_2 = arg_4_1[var_4_0]

		assert(var_0_0.Battle[arg_4_1[var_4_0].type] ~= nil, "找不到对应的卡牌效果类型>>" .. arg_4_1[var_4_0].type .. "<<，检查卡牌ID：" .. self._card:GetCardID())

		local var_4_3 = var_0_0.Battle[var_4_2.type].New(var_4_2)

		if var_4_3:HoldForInput() then
			self._holdForInputMark = true
		end

		if var_4_3:MoveCardAfterCast() ~= self._moveAfterCast then
			self._moveAfterCast = var_4_3:MoveCardAfterCast()
		end

		var_4_3:ConfigCard(self._card)
		var_4_3:SetQueue(self)

		self._effectList[var_4_3] = var_4_1
		var_4_0 = var_4_0 - 1
		var_4_1 = var_4_3
	end

	self._headEffect = var_4_1

	return
end

function BattleCardPuzzleCardEffectQueue:Start()
	if self._headEffect == -1 then
		self._card:QueueFinish(self)
	else
		self._headEffect:Execute()
	end

	return
end

function BattleCardPuzzleCardEffectQueue:EffectFinale(arg_6_1)
	if self._effectList[arg_6_1] == -1 then
		self._card:QueueFinish(self)
	else
		self._effectList[arg_6_1]:Execute()
	end

	return
end

function BattleCardPuzzleCardEffectQueue:GetBranch()
	return self._branch
end

function BattleCardPuzzleCardEffectQueue:GetHoldForInputMark()
	return self._holdForInputMark
end

function BattleCardPuzzleCardEffectQueue:GetMoveAfterCast()
	return self._moveAfterCast
end

function BattleCardPuzzleCardEffectQueue:GetCondition()
	return self._condition
end

return
