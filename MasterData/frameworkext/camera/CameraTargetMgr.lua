module("frameworkext.camera.CameraTargetMgr", package.seeall)

local var_0_0 = class("CameraTargetMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._targets = {}
	arg_1_0._taggedTargets = {}
	arg_1_0._mainCameraTarget = nil
	arg_1_0._uiCameraTarget = nil
end

function var_0_0.getMainCameraTarget(arg_2_0)
	return arg_2_0._mainCameraTarget
end

function var_0_0.getUICameraTarget(arg_3_0)
	return arg_3_0._uiCameraTarget
end

function var_0_0.getTargetByTag(arg_4_0, arg_4_1)
	return arg_4_0._taggedTargets[arg_4_1]
end

function var_0_0.addTarget(arg_5_0, arg_5_1)
	if table.indexof(arg_5_0._targets, arg_5_1) == false then
		table.insert(arg_5_0._targets, arg_5_1)

		local var_5_0 = arg_5_1:getTag()

		if var_5_0 ~= "Untagged" then
			if arg_5_0._taggedTargets[var_5_0] then
				printWarn("Camera target with same tag=", var_5_0)
			end

			arg_5_0._taggedTargets[var_5_0] = arg_5_1

			if var_5_0 == TagType.MainCameraTag then
				arg_5_0._mainCameraTarget = arg_5_1
			elseif var_5_0 == TagType.UICameraTag then
				arg_5_0._uiCameraTarget = arg_5_1
			end
		end
	end

	return arg_5_1
end

function var_0_0.removeTarget(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getTag()

	if var_6_0 ~= "Untagged" then
		arg_6_0._taggedTargets[var_6_0] = nil
	end

	if arg_6_0._mainCameraTarget == arg_6_1 then
		arg_6_0._mainCameraTarget = nil
	elseif arg_6_0._uiCameraTarget == arg_6_1 then
		arg_6_0._uiCameraTarget = nil
	end

	table.removebyvalue(arg_6_0._targets, arg_6_1)
end

function var_0_0.setRenderScaleByTag(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getTargetByTag(arg_7_1)

	if var_7_0 then
		var_7_0:setRenderScale(arg_7_2)
	end
end

function var_0_0.setRenderScaleByTarget(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		arg_8_1:setRenderScale(arg_8_2)
	end
end

function var_0_0.closeRenderScaleByTag(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getTargetByTag(arg_9_1)

	if var_9_0 then
		var_9_0:closeRenderScale()
	end
end

function var_0_0.closeRenderScaleByTarget(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_1:closeRenderScale()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
