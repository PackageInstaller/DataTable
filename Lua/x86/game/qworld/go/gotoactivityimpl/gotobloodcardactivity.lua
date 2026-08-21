GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local var_0_0 = class("GotoBloodCardActivity", GotoActivityBase)

function var_0_0.OnEnter(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = QWorldData:GetIsBackQWorld()
	local var_1_1 = arg_1_2[2] and arg_1_2[2] == 1

	if var_1_0 then
		local var_1_2

		if var_1_1 then
			gameContext:UpdateUrlHistory("/bloodCardEntrace", {
				params = {
					params = arg_1_1,
					optionParams = arg_1_2
				}
			})
		end

		JumpTools.OpenPageByJump("/bloodCardSelectNpc", {
			selectNpc = BloodCardData:GetSelectNpc() or arg_1_2[1],
			isAllNpc = arg_1_2[2] and arg_1_2[2] == 1,
			posX = arg_1_2[3],
			posY = arg_1_2[4],
			posZ = arg_1_2[5],
			rotationX = arg_1_2[6],
			rotationY = arg_1_2[7],
			rotationZ = arg_1_2[8]
		})
	elseif var_1_1 then
		JumpTools.OpenPageByJump("/bloodCardEntrace", {
			params = arg_1_1,
			optionParams = arg_1_2
		})
	else
		JumpTools.OpenPageByJump("/bloodCardSelectNpc", {
			selectNpc = arg_1_2[1],
			isAllNpc = arg_1_2[2] and arg_1_2[2] == 1,
			posX = arg_1_2[3],
			posY = arg_1_2[4],
			posZ = arg_1_2[5],
			rotationX = arg_1_2[6],
			rotationY = arg_1_2[7],
			rotationZ = arg_1_2[8]
		})
	end
end

return var_0_0
