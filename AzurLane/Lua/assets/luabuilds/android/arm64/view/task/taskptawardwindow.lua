class = var_0_10000

local var_0_0 = "TaskPtAwardWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..activity.Panels.PtAwardWindow"))

function var_0_1.UpdateList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert = var_1_10004

	var_1_10004(#arg_1_1 == #arg_1_2)

	local var_1_0 = arg_1_0.UIlist

	var_4.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_1[arg_2_1 + 1]
			local var_2_1 = arg_1_0

			var_4.UpdateDrop(var_2_1, arg_2_2:Find("award"), var_2_0[1])

			local var_2_2 = arg_1_0

			var_4.UpdateDrop(var_2_2, arg_2_2:Find("award1"), var_2_0[2])

			local var_2_3 = arg_1_2[arg_2_1 + 1]

			setText = var_5

			var_5(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)

			setText = var_5

			var_5(arg_2_2:Find("target/Text"), var_2_3)

			setText = var_5

			var_5(arg_2_2:Find("target/title"), arg_1_0.resTitle)

			setActive = var_5

			var_5(arg_2_2:Find("award/mask"), arg_2_1 + 1 <= arg_1_3)

			setActive = var_5

			var_5(arg_2_2:Find("award1/mask"), arg_2_1 + 1 <= arg_1_3)

			if arg_2_2:Find("target/icon") then
				if arg_1_0.resIcon == "" then
					arg_1_0.resIcon = nil
				end

				if arg_1_0.resIcon then
					LoadImageSpriteAsync = var_5

					var_5(arg_1_0.resIcon, arg_2_2:Find("target/icon"), false)
				end

				setActive = var_5

				var_5(arg_2_2:Find("target/icon"), arg_1_0.resIcon)

				setActive = var_5

				var_5(arg_2_2:Find("target/mark"), arg_1_0.resIcon)
			end
		end

		return
	end)

	local var_1_1 = arg_1_0.UIlist

	var_4.align(var_1_1, #arg_1_1)

	return
end

function var_0_1.UpdateDrop(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		setActive = var_1_10003

		var_1_10003(arg_3_1, true)

		var_1_10003 = {
			type = arg_3_2[1],
			id = arg_3_2[2],
			count = arg_3_2[3]
		}
		updateDrop = var_4

		var_4(arg_3_1, var_1_10003, {
			hideName = true
		})

		onButton = var_4

		local var_3_0 = arg_3_0.binder
		local var_3_1 = arg_3_1

		local function var_3_2()
			local var_4_0 = arg_3_0.binder
			local var_4_1 = var_0.emit

			BaseUI = var_2_10003

			var_4_1(var_4_0, var_2_10003.ON_DROP, var_1_10003)

			return
		end

		SFX_PANEL = var_1_10009

		var_4(var_3_0, var_3_1, var_3_2, var_1_10009)
	else
		setActive = var_1_10003

		var_1_10003(arg_3_1, false)
	end

	return
end

return var_0_1
