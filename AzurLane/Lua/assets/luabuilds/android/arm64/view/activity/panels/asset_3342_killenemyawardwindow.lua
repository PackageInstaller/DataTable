class = var_0_10000

local var_0_0 = "KillEnemyAwardWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PtAwardWindow"))

local function var_0_2(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_0.UIlist

	var_4.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_1[arg_2_1 + 1]
			local var_2_1 = arg_1_2[arg_2_1 + 1]

			setText = var_5

			var_5(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)

			setActive = var_5

			var_5(arg_2_2:Find("target/Text"), false)

			setText = var_5

			var_5(arg_2_2:Find("target/title"), var_2_1)

			setActive = var_5

			var_5(arg_2_2:Find("target/icon"), false)

			local var_2_2 = {
				type = var_2_0[1],
				id = var_2_0[2],
				count = var_2_0[3]
			}

			updateDrop = var_6

			var_6(arg_2_2:Find("award"), var_2_2, {
				hideName = true
			})

			onButton = var_6

			local var_2_3 = arg_1_0.binder
			local var_2_4 = arg_2_2
			local var_2_5 = arg_2_2.Find(var_2_4, "award")

			local function var_2_6()
				local var_3_0 = arg_1_0.binder
				local var_3_1 = var_0.emit

				BaseUI = var_3_10003

				var_3_1(var_3_0, var_3_10003.ON_DROP, var_2_2)

				return
			end

			SFX_PANEL = var_2_4

			var_6(var_2_3, var_2_5, var_2_6, var_2_4)

			setActive = var_6

			var_6(arg_2_2:Find("award/mask"), arg_2_1 + 1 <= arg_1_3)
		end

		return
	end)

	local var_1_1 = arg_1_0.UIlist

	var_4.align(var_1_1, #arg_1_1)

	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.dropList
	local var_4_1 = arg_4_1.descs
	local var_4_2 = arg_4_1.finishedIndex

	var_0_2(arg_4_0, var_4_0, var_4_1, var_4_2)

	setActive = var_5

	var_5(arg_4_0.ptTF, false)

	setActive = var_5

	var_5(arg_4_0._tf, true)

	return
end

return var_0_1
