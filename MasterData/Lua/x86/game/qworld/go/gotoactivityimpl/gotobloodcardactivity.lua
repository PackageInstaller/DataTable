GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoBloodCardActivity = class("GotoBloodCardActivity", GotoActivityBase)

function GotoBloodCardActivity:OnEnter(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2[2] and arg_1_2[2] == 1

	if QWorldData:GetIsBackQWorld() then
		if var_1_0 then
			gameContext:UpdateUrlHistory("/bloodCardEntrace", {
				params = {
					params = arg_1_1,
					optionParams = arg_1_2
				}
			})
		end

		local var_1_2 = {}

		var_1_2.selectNpc = BloodCardData:GetSelectNpc() or arg_1_2[1]
		var_1_2.isAllNpc = arg_1_2[2] and arg_1_2[2] == 1
		var_1_2.posX = arg_1_2[3]
		var_1_2.posY = arg_1_2[4]
		var_1_2.posZ = arg_1_2[5]
		var_1_2.rotationX = arg_1_2[6]
		var_1_2.rotationY = arg_1_2[7]
		var_1_2.rotationZ = arg_1_2[8]

		JumpTools.OpenPageByJump("/bloodCardSelectNpc", var_1_2)
	elseif var_1_0 then
		JumpTools.OpenPageByJump("/bloodCardEntrace", {
			params = arg_1_1,
			optionParams = arg_1_2
		})
	else
		local var_1_3 = {
			selectNpc = arg_1_2[1]
		}

		var_1_3.isAllNpc = arg_1_2[2] and arg_1_2[2] == 1
		var_1_3.posX = arg_1_2[3]
		var_1_3.posY = arg_1_2[4]
		var_1_3.posZ = arg_1_2[5]
		var_1_3.rotationX = arg_1_2[6]
		var_1_3.rotationY = arg_1_2[7]
		var_1_3.rotationZ = arg_1_2[8]

		JumpTools.OpenPageByJump("/bloodCardSelectNpc", var_1_3)
	end
end

return GotoBloodCardActivity
