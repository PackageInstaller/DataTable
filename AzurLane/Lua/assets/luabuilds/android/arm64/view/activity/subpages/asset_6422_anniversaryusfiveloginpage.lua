class = var_0_10000

local var_0_0 = "AnniversaryUSFiveLoginPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	setActive = var_1_10001

	var_1_10001(arg_1_0.item, false)

	local var_1_0 = arg_1_0.itemList

	var_1.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_2_2:Find("item")
			local var_2_1 = arg_1_0.config.front_drops[arg_2_1 + 1]
			local var_2_2 = {
				type = var_2_1[1],
				id = var_2_1[2],
				count = var_2_1[3]
			}

			updateDrop = var_6

			var_6(var_2_0, var_2_2)

			onButton = var_6

			local var_2_3 = arg_1_0
			local var_2_4 = arg_2_2

			local function var_2_5()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.emit

				BaseUI = var_3_10003

				var_3_1(var_3_0, var_3_10003.ON_DROP, var_2_2)

				return
			end

			SFX_PANEL = var_2_10011

			var_6(var_2_3, var_2_4, var_2_5, var_2_10011)

			local var_2_6 = arg_2_2
			local var_2_7 = arg_2_2.Find(var_2_6, "got")

			setActive = var_2_10007

			var_2_10007(var_2_7, arg_2_1 < arg_1_0.nday)

			local var_2_8 = arg_2_2:Find("day/Text")

			IsNil = var_2_6

			if not var_2_6(var_2_8) then
				setText = var_8

				local var_2_9 = var_2_8

				if arg_2_1 < arg_1_0.nday then
					i18n = var_2_10

					local var_2_10

					if not var_2_10("word_status_inEventFinished") then
						i18n = var_2_10
						var_2_10 = var_2_10("which_day_2", arg_2_1 + 1)
					end

					var_8(var_2_9, var_2_10)

					return
				end
			end
		end
	end)

	return
end

return var_0_1
