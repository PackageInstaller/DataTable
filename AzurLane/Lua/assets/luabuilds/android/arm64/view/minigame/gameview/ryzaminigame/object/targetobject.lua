local var_0_0 = class("TargetObject", import("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function var_0_0.CellPassability(arg_1_0)
	return false
end

function var_0_0.FirePassability(arg_2_0)
	return 2
end

local function var_0_1(arg_3_0)
	local var_3_0 = math.random()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
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

function var_0_0.TryDrop(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	local var_4_0 = var_0_1(arg_4_1)

	if var_4_0 then
		var_4_0.drop = arg_4_2
		var_4_0.pos = {
			arg_4_0.pos.x,
			arg_4_0.pos.y
		}

		arg_4_0.responder:Create(var_4_0)
	end

	return
end

return var_0_0
