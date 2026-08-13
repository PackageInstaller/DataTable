class = var_0_10000

local var_0_0 = "GuideHideUIPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuidePlayer"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.OnExecution(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetHideNodes()
	local var_1_1 = {}

	ipairs = var_1_10005

	for iter_1_0, iter_1_1 in var_1_10005(var_1_0) do
		table = var_1_10010

		var_1_10010.insert(var_1_1, function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.SearchWithoutDelay(var_2_0, iter_1_1, function(arg_3_0)
				if not arg_3_0 then
					pg = var_3_10001

					local var_3_0 = var_3_10001.NewGuideMgr.GetInstance()

					var_1.Stop(var_3_0)

					return
				end

				local var_3_1 = arg_1_0
				local var_3_2 = var_1.SetActive
				local var_3_3 = arg_3_0
				local var_3_4 = not iter_1_1.hideFlag

				defaultValue = var_3_10005

				var_3_2(var_3_1, var_3_3, var_3_4, var_3_10005(iter_1_1.type, var_0_2))
				arg_2_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_5

	var_5(var_1_1, arg_1_2)

	return
end

function var_0_1.SetActive(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 == var_0_2 then
		setActive = var_4

		var_4(arg_4_1, arg_4_2)
	elseif arg_4_3 == var_0_3 then
		GetOrAddComponent = var_4

		local var_4_0 = arg_4_1

		typeof = var_1_10006
		CanvasGroup = var_1_10007

		local var_4_1 = var_4(var_4_0, var_1_10006(var_1_10007))

		var_4_1.alpha = arg_4_2 and 1 or 0
		var_4_1.blocksRaycasts = arg_4_2
	end

	return
end

function var_0_1.RegisterEvent(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2()

	return
end

return var_0_1
