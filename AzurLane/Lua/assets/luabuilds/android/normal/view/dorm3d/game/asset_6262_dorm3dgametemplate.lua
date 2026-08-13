class = var_0_10000

local var_0_0 = "Dorm3dGameTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.forceGC(arg_1_0)
	return true
end

function var_0_1.loadingQueue(arg_2_0)
	return function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.SceneAnimMgr.GetInstance()

		var_1.Dorm3DSceneChange(var_3_0, function(arg_4_0)
			return arg_3_0(arg_4_0)
		end)

		return
	end
end

function var_0_1.getUIName(arg_5_0)
	return nil
end

function var_0_1.SetApartment(arg_6_0, arg_6_1)
	arg_6_0.apartment = arg_6_1

	return
end

function var_0_1.ShowResultUI(arg_7_0, arg_7_1)
	return nil
end

return var_0_1
