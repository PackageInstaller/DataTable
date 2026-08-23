local var_0_0 = g.core.model.User.knightsData
local BlazingArenaFormationStruct = class("BlazingArenaFormationStruct", (require("app.view.module.lineUp.model.MulFormationStruct")))

function BlazingArenaFormationStruct:ctor(arg_1_1, arg_1_2)
	BlazingArenaFormationStruct.super.ctor(self, arg_1_1, arg_1_2)
end

function BlazingArenaFormationStruct:lineupKnight(arg_2_1, arg_2_2)
	if not self:canLineUpKnight(arg_2_1) then
		return
	end

	BlazingArenaFormationStruct.super:lineUp(arg_2_1, arg_2_2)
end

function BlazingArenaFormationStruct:canLineUpKnight(arg_3_1)
	if not self:isSidValid(self._knightSidArr[arg_3_1]) then
		local var_3_0 = 0

		for iter_3_0, iter_3_1 in ipairs(self._knightSidArr) do
			if self:isSidValid(iter_3_1) then
				var_3_0 = var_3_0 + 1
			end
		end

		return var_3_0 < self._index
	end

	local var_3_1 = var_0_0:getKnightById(self._knightSidArr[arg_3_1])

	if var_3_1 and var_3_1:isElementLeader() then
		return false
	end

	return true
end

return BlazingArenaFormationStruct
