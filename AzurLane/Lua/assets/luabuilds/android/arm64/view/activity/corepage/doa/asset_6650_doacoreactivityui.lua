class = var_0_10000

local var_0_0 = "DOACoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.MoscowUR.MoscowURCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "DOACoreActivityUI"
end

function var_0_1.loadingQueue(arg_2_0)
	local var_2_0 = "play_jiarihangxianshanyaohaibin"

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_2_1 = var_1_10002(var_1_10004)
	local var_2_2 = var_2_0 .. var_2.getPlayerId(var_2_1)

	PlayerPrefs = var_2

	if var_2.GetInt(var_2_2, 0) == 1 then
		return nil
	else
		return function(arg_3_0)
			pg = var_2_10001

			local var_3_0 = var_2_10001.SceneAnimMgr.GetInstance()

			var_1.CommonSceneChange(var_3_0, "jiarihangxianshanyaohaibin", function(arg_4_0)
				return arg_3_0(function()
					PlayerPrefs = var_4_10000

					var_4_10000.SetInt(var_2_2, 1)

					existCall = var_0

					var_0(arg_4_0)

					return
				end)
			end)

			return
		end
	end

	return
end

function var_0_1.OnAnimations(arg_6_0, arg_6_1, arg_6_2)
	SetActive = var_1_10003

	local var_6_0 = arg_6_0._tf

	var_1_10003(var_5.Find(var_6_0, "adapt/logo2"), arg_6_2.id == 16 or arg_6_2.id == 12)

	SetActive = var_1_10003

	local var_6_1 = arg_6_0._tf

	var_1_10003(var_5.Find(var_6_1, "adapt/logo"), arg_6_2.id ~= 16 and arg_6_2.id ~= 12)

	SetActive = var_1_10003

	local var_6_2 = arg_6_0._tf

	var_1_10003(var_5.Find(var_6_2, "left_bg"), arg_6_2.id == 9)

	SetActive = var_1_10003

	local var_6_3 = arg_6_0._tf

	var_1_10003(var_5.Find(var_6_3, "decorate"), arg_6_2.id == 9)

	return
end

function var_0_1.OnToggleName(arg_7_0, arg_7_1, arg_7_2)
	return
end

return var_0_1
