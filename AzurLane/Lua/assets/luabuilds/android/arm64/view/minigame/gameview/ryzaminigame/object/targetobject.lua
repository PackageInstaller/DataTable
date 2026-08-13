class = var_0_10000

local var_0_0 = "TargetObject"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function var_0_1.CellPassability(arg_1_0)
	return false
end

function var_0_1.FirePassability(arg_2_0)
	return 2
end

local function var_0_2(arg_3_0)
	math = var_1_10001

	local var_3_0 = var_1_10001.random()

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0) do
		if var_3_0 < iter_3_1[2] then
			return {
				name = "Item",
				type = iter_3_1[1]
			}
		else
			var_3_0 = var_3_0 - iter_3_1[2]
		end
	end

	return
end

function var_0_1.TryDrop(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	if var_0_2(arg_4_1) then
		var_3.drop = arg_4_2
		var_3.pos = {
			arg_4_0.pos.x,
			arg_4_0.pos.y
		}

		local var_4_0 = arg_4_0.responder

		var_4.Create(var_4_0, var_3)
	end

	return
end

return var_0_1
