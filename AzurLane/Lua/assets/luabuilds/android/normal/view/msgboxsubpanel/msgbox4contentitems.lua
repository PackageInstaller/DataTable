class = var_0_10000

local var_0_0 = "Msgbox4ContentItems"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "Msgbox4ContentItems"
end

function var_0_1.OnRefresh(arg_2_0, arg_2_1)
	rtf = var_1_10002

	local var_2_0 = var_1_10002(arg_2_0.viewParent._window)

	Vector2 = var_3
	var_2_0.sizeDelta = var_3.New(1000, 638)
	setText = var_2_0

	local var_2_1 = arg_2_0._tf

	var_2_0(var_3.Find(var_2_1, "content"), arg_2_1.content)

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "list")

	UIItemList = var_2_2

	local var_2_4 = var_2_2.New(var_2_3, var_2_3:GetChild(0))

	var_3.make(var_2_4, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			var_3(arg_3_2, arg_2_1.items[arg_3_1])

			setActive = var_3

			var_3(arg_3_2:Find("name"), false)

			setActive = var_3

			var_3(arg_3_2:Find("name_mask"), false)

			setScrollText = var_3

			local var_3_0 = arg_3_2
			local var_3_1 = arg_3_2.Find(var_3_0, "name_mask/name")

			getText = var_3_0

			var_3(var_3_1, var_3_0(arg_3_2:Find("name")))
		end

		return
	end)
	var_3:align(#arg_2_1.items)

	return
end

return var_0_1
