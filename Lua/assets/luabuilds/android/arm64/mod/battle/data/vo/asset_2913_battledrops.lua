ys = ys or {}

local var_0_0 = ys
local BattleDrops = class("BattleDrops")

ys.Battle.BattleDrops = BattleDrops
BattleDrops.__name = "BattleDrops"

function BattleDrops:Ctor(arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._dropList = arg_1_1
	self._resourceCount = 0
	self._itemCount = 0

	return
end

function BattleDrops:CreateDrops(arg_2_1)
	local var_2_0 = {}

	if self._dropList[arg_2_1] ~= nil and #self._dropList[arg_2_1] > 0 then
		var_2_0 = self._dropList[arg_2_1][#self._dropList[arg_2_1]]
		self._dropList[arg_2_1][#self._dropList[arg_2_1]] = nil
	end

	if var_2_0.resourceCount ~= nil then
		self._resourceCount = self._resourceCount + var_2_0.resourceCount
	end

	if var_2_0.itemCount ~= nil then
		self._itemCount = self._itemCount + var_2_0.itemCount
	end

	return var_2_0
end

function BattleDrops:GetDropped()
	return self._resourceCount, self._itemCount
end

function BattleDrops:Dispose()
	var_0_0.EventDispatcher.DetachEventDispatcher(self)

	return
end

return
