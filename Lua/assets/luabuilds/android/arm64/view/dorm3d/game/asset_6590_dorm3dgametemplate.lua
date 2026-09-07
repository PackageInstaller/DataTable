local Dorm3dGameTemplate = class("Dorm3dGameTemplate", import("view.base.BaseUI"))

function Dorm3dGameTemplate:forceGC()
	return true
end

function Dorm3dGameTemplate:loadingQueue()
	return function(arg_3_0)
		pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_4_0)
			return arg_3_0(arg_4_0)
		end)

		return
	end
end

function Dorm3dGameTemplate:getUIName()
	return nil
end

function Dorm3dGameTemplate:SetApartment(arg_6_1)
	self.apartment = arg_6_1

	return
end

function Dorm3dGameTemplate:ShowResultUI(arg_7_1)
	return nil
end

return Dorm3dGameTemplate
