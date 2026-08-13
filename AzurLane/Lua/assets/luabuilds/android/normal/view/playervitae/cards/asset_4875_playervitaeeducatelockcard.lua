class = var_0_10000

local var_0_0 = "PlayerVitaeEducateLockCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PlayerVitaeEducateBaseCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	setText = var_3

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.Find(var_1_0, "desc/Text")

	i18n = var_1_0

	var_3(var_1_1, var_1_0("flagship_educate_slot_lock_tip"))

	onButton = var_3

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_1:Find("go")

	local function var_1_4()
		LOCK_NEW_EDUCATE_SYSTEM = var_2_10000

		if var_2_10000 then
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.emit

			PlayerVitaeMediator = var_2_10002
			var_2_10002 = var_2_10002.GO_SCENE
			SCENE = var_2_10003

			var_2_1(var_2_0, var_2_10002, var_2_10003.EDUCATE)
		else
			local var_2_2 = arg_1_0
			local var_2_3 = var_0.emit

			PlayerVitaeMediator = var_2_10002

			local var_2_4 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_2_3(var_2_2, var_2_4, var_2_10003.NEW_EDUCATE_SELECT)
		end

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_2, var_1_3, var_1_4, var_7)

	return
end

return var_0_1
