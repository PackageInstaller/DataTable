local var_0_0 = class("Dorm3dGameTemplate", import("view.base.BaseUI"))

function var_0_0.forceGC(arg_1_0)
	return true
end

function var_0_0.loadingQueue(arg_2_0)
	return function(arg_3_0)
		pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_4_0)
			return arg_3_0(arg_4_0)
		end)

		return
	end
end

function var_0_0.getUIName(arg_5_0)
	return nil
end

function var_0_0.SetApartment(arg_6_0, arg_6_1)
	arg_6_0.apartment = arg_6_1

	return
end

function var_0_0.ShowResultUI(arg_7_0, arg_7_1)
	return nil
end

return var_0_0
