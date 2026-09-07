local TargetObject = class("TargetObject", import("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function TargetObject:CellPassability()
	return false
end

function TargetObject:FirePassability()
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

function TargetObject:TryDrop(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	local var_4_0 = var_0_1(arg_4_1)

	if var_4_0 then
		var_4_0.drop = arg_4_2
		var_4_0.pos = {
			self.pos.x,
			self.pos.y
		}

		self.responder:Create(var_4_0)
	end

	return
end

return TargetObject
