module("frameworkext.camera.CameraTarget", package.seeall)

local var_0_0 = class("CameraTarget")

function var_0_0.Get(arg_1_0)
	return Astral.LuaComponentContainer.Add(arg_1_0, var_0_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1.gameObject
	arg_2_0._tag = arg_2_0._go.tag
	arg_2_0._ctrls = {}
	arg_2_0._activeCtrls = {}
end

function var_0_0.Awake(arg_3_0)
	arg_3_0._camera = arg_3_0._go:GetComponent("Camera")
	arg_3_0._cameraTrs = arg_3_0._go.transform

	CameraTargetMgr.instance:addTarget(arg_3_0)
end

function var_0_0.OnDestroy(arg_4_0)
	CameraTargetMgr.instance:removeTarget(arg_4_0)

	arg_4_0._go = nil
	arg_4_0._tag = nil
	arg_4_0._camera = nil
	arg_4_0._cameraTrs = nil
	arg_4_0._cameraData = nil

	arg_4_0:removeAllCtrls()

	arg_4_0._ctrls = nil
	arg_4_0._activeCtrls = nil
end

function var_0_0.getGO(arg_5_0)
	return arg_5_0._go
end

function var_0_0.getTag(arg_6_0)
	return arg_6_0._tag
end

function var_0_0.getCamera(arg_7_0)
	return arg_7_0._camera
end

function var_0_0.getCameraTrs(arg_8_0)
	return arg_8_0._cameraTrs
end

function var_0_0.getCameraData(arg_9_0)
	if arg_9_0._camera == nil then
		return
	end

	if arg_9_0._cameraData == nil then
		arg_9_0._cameraData = UnityEngine.Rendering.Universal.CameraExtensions.GetUniversalAdditionalCameraData(arg_9_0._camera)
	end

	return arg_9_0._cameraData
end

function var_0_0.addCtrl(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.New(arg_10_0)
	local var_10_1 = var_10_0:getGroup()
	local var_10_2 = arg_10_0._ctrls[var_10_1]

	if not var_10_2 then
		var_10_2 = {}
		arg_10_0._ctrls[var_10_1] = var_10_2
	end

	table.insert(var_10_2, var_10_0)

	return var_10_0
end

function var_0_0.removeCtrl(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getGroup()
	local var_11_1 = arg_11_0._ctrls[var_11_0]

	if var_11_1 then
		table.remove(var_11_1, arg_11_1)
		arg_11_1:onDestroy()
	end
end

function var_0_0.removeAllCtrls(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._ctrls) do
		local var_12_0 = #iter_12_1

		for iter_12_2 = 1, var_12_0 do
			iter_12_1[iter_12_2]:onDestroy()
		end
	end

	arg_12_0._ctrls = {}
	arg_12_0._activeCtrls = {}
end

function var_0_0.removeGroupCtrls(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._ctrls[arg_13_1]

	if var_13_0 then
		local var_13_1 = arg_13_0._activeCtrls[arg_13_1]

		if var_13_1 then
			var_13_1:onInactive()
		end

		local var_13_2 = #var_13_0

		for iter_13_0 = 1, var_13_2 do
			var_13_0[iter_13_0]:onDestroy()
		end

		arg_13_0._ctrls[arg_13_1] = nil
		arg_13_0._activeCtrls[arg_13_1] = nil
	end
end

function var_0_0.setActive(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getGroup()
	local var_14_1 = arg_14_0._activeCtrls[var_14_0]

	if var_14_1 == arg_14_1 then
		return
	end

	if var_14_1 then
		var_14_1:onInactive()
	end

	arg_14_0._activeCtrls[var_14_0] = arg_14_1

	arg_14_1:onActive()
end

function var_0_0.getActiveCtrl(arg_15_0, arg_15_1)
	return arg_15_0._activeCtrls[arg_15_1]
end

function var_0_0.setInactive(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getGroup()
	local var_16_1 = arg_16_0._activeCtrls[var_16_0]

	if var_16_1 == arg_16_1 then
		var_16_1:onInactive()

		arg_16_0._activeCtrls[var_16_0] = nil
	end
end

function var_0_0.setGroupInactive(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getGroup()
	local var_17_1 = arg_17_0._activeCtrls[var_17_0]

	if var_17_1 then
		var_17_1:onInactive()

		arg_17_0._activeCtrls[var_17_0] = nil
	end
end

function var_0_0.setAllInactive(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._activeCtrls) do
		iter_18_1:onInactive()
	end

	arg_18_0._activeCtrls = {}
end

function var_0_0.addCameraStack(arg_19_0, arg_19_1)
	if arg_19_1 == nil or arg_19_0._cameraData == nil then
		return
	end

	if arg_19_0._cameraData.cameraStack:Contains(arg_19_1) then
		return
	end

	arg_19_0._cameraData.cameraStack:Add(arg_19_1)
end

function var_0_0.setRenderScale(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getCameraData()

	var_20_0.isUseCustomRenderScale = true
	var_20_0.customRenderScale = arg_20_1
end

function var_0_0.closeRenderScale(arg_21_0)
	local var_21_0 = arg_21_0:getCameraData()

	var_21_0.isUseCustomRenderScale = false
	var_21_0.customRenderScale = 1
end

return var_0_0
