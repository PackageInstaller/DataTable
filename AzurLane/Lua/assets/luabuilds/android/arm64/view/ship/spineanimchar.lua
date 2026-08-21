local var_0_0 = class("SpineAnimChar")
local var_0_1 = "normal"

var_0_0.state_init = 1
var_0_0.state_loading = 2
var_0_0.state_complete = 3
var_0_0.state_dispose = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0.config = pg.ship_skin_template[arg_1_1]
		arg_1_0.prefab = arg_1_0.config.prefab
	end

	arg_1_0.state = var_0_0.state_init
	arg_1_0.normalAction = var_0_1

	return
end

function var_0_0.GetCharModel(arg_2_0)
	return arg_2_0._model
end

function var_0_0.SetName(arg_3_0, arg_3_1)
	if arg_3_0:isComplete() then
		arg_3_0._model.name = arg_3_1
	end

	return
end

function var_0_0.SetSiblingIndex(arg_4_0, arg_4_1)
	if arg_4_0:isComplete() then
		arg_4_0._model.transform:SetSiblingIndex(arg_4_1)
	end

	return
end

function var_0_0.SetPaint(arg_5_0, arg_5_1)
	arg_5_0.prefab = arg_5_1

	return
end

function var_0_0.Load(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.state == var_0_0.state_init then
		arg_6_0.state = var_0_0.state_loading

		PoolMgr.GetInstance():GetSpineChar(arg_6_0.prefab, arg_6_0.sync, function(arg_7_0)
			if arg_7_0 then
				if arg_6_0:isDispose() then
					PoolMgr.GetInstance():ReturnSpineChar(arg_6_0.prefab, arg_7_0)
				else
					arg_6_0:start(arg_7_0)

					if arg_6_2 then
						arg_6_2(arg_6_0)
					end
				end
			else
				arg_6_0.state = var_0_0.state_init
			end

			return
		end)
	end

	return
end

function var_0_0.SetPivot(arg_8_0, arg_8_1)
	if arg_8_0:isComplete() then
		tf(arg_8_0._model).pivot = arg_8_1
	end

	return
end

function var_0_0.SetSizeDelta(arg_9_0, arg_9_1)
	if arg_9_0:isComplete() then
		tf(arg_9_0._model).sizeDelta = arg_9_1
	end

	return
end

function var_0_0.SetParent(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:isComplete() then
		arg_10_0.loadedParent = arg_10_1

		return
	end

	SetParent(arg_10_0._model, arg_10_1, arg_10_2 and true or false)

	return
end

function var_0_0.SetNormalAction(arg_11_0, arg_11_1)
	arg_11_0.normalAction = arg_11_1

	return
end

function var_0_0.SetAction(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or 0
	arg_12_0.actionName = arg_12_1

	local var_12_0, var_12_1 = arg_12_0:getDirectActonName(arg_12_1)

	arg_12_0.modelScale = arg_12_0.modelScale or tf(arg_12_0._model).localScale

	if var_12_1 then
		tf(arg_12_0._model).localScale = Vector3(math.abs(arg_12_0.modelScale.x), arg_12_0.modelScale.y, arg_12_0.modelScale.z)
	else
		local var_12_3 = math.sign(arg_12_0.modelScale.x)

		tf(arg_12_0._model).localScale = arg_12_0.modelScale
	end

	arg_12_0._animUI:SetAction(var_12_0, arg_12_2)

	return
end

function var_0_0.SetActionOnce(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0:SetActionCallBack(nil)
	arg_13_0:SetActionCallBack(function(arg_14_0)
		if arg_14_0 == "action" then
			if arg_13_3 then
				arg_13_3()
			end
		elseif arg_14_0 == "finish" and arg_13_4 then
			arg_13_4()
		end

		return
	end)
	arg_13_0:SetAction(arg_13_1, arg_13_2)

	return
end

function var_0_0.SetActionCallBack(arg_15_0, arg_15_1)
	arg_15_0._animUI:SetActionCallBack(arg_15_1)

	return
end

function var_0_0.GetLocalScale(arg_16_0)
	if arg_16_0:isComplete() then
		return tf(arg_16_0._model).localScale
	end

	return
end

function var_0_0.SetLocalScale(arg_17_0, arg_17_1)
	if arg_17_0:isComplete() then
		arg_17_0.direct = math.sign(arg_17_1.x)
		tf(arg_17_0._model).localScale = arg_17_1
		arg_17_0.modelScale = arg_17_1

		arg_17_0:updateCharDirect()
	end

	return
end

function var_0_0.SetLocalPosition(arg_18_0, arg_18_1)
	if arg_18_0:isComplete() then
		tf(arg_18_0._model).localPosition = arg_18_1
	end

	return
end

function var_0_0.SetAnchoredPosition(arg_19_0, arg_19_1)
	if arg_19_0:isComplete() then
		tf(arg_19_0._model).anchoredPosition = arg_19_1
	end

	return
end

function var_0_0.GetAnchoredPosition(arg_20_0)
	if arg_20_0:isComplete() then
		return tf(arg_20_0._model).anchoredPosition
	end

	return
end

function var_0_0.SetLayer(arg_21_0, arg_21_1)
	if arg_21_0:isComplete() then
		pg.ViewUtils.SetLayer(tf(arg_21_0._model), arg_21_1)
	end

	return
end

function var_0_0.SetAnchoredPosition3D(arg_22_0, arg_22_1)
	if arg_22_0:isComplete() then
		tf(arg_22_0._model).anchoredPosition3D = arg_22_1
	end

	return
end

function var_0_0.GetPauseStatue(arg_23_0)
	if arg_23_0._animUI then
		return arg_23_0._animUI.Pause
	end

	return nil
end

function var_0_0.GetSkeletonGraphic(arg_24_0)
	return arg_24_0._skeletonGraphic
end

function var_0_0.GetAnimationState(arg_25_0)
	if arg_25_0._animUI then
		return arg_25_0._animUI:GetAnimationState()
	end

	return nil
end

function var_0_0.GetModel(arg_26_0)
	return arg_26_0._model
end

function var_0_0.Resume(arg_27_0)
	if arg_27_0._animUI then
		return arg_27_0._animUI:Resume()
	end

	return
end

function var_0_0.Pause(arg_28_0)
	if arg_28_0._animUI then
		return arg_28_0._animUI:Pause()
	end

	return
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.state == var_0_0.state_complete then
		arg_29_0:SetActionCallBack(nil)
		PoolMgr.GetInstance():ReturnSpineChar(arg_29_0.prefab, arg_29_0._model)
	end

	arg_29_0._animUI = nil
	arg_29_0.prefab = nil
	arg_29_0._model = nil
	arg_29_0.state = var_0_0.state_dispose
	arg_29_0.parent = nil

	return
end

function var_0_0.start(arg_30_0, arg_30_1)
	arg_30_0.state = var_0_0.state_complete
	arg_30_0._model = arg_30_1
	arg_30_0._animUI = arg_30_1:GetComponent(typeof(SpineAnimUI))
	arg_30_0._skeletonGraphic = arg_30_1:GetComponent("SkeletonGraphic")

	if arg_30_0.loadedParent then
		arg_30_0:setParent(arg_30_1, arg_30_0.parent)

		arg_30_0.loadedParent = nil
	end

	if arg_30_0.loadedScale then
		arg_30_0:setScale(arg_30_0.loadedScale)

		arg_30_0.loadedScale = nil
	end

	if arg_30_0.loadedPosition then
		arg_30_0:setPosition(arg_30_0.loadedPosition)

		arg_30_0.loadedPosition = nil
	end

	return
end

function var_0_0.updateCharDirect(arg_31_0)
	if arg_31_0.normalAction == arg_31_0.actionName then
		arg_31_0:SetAction(arg_31_0.actionName, 0, -1)
	end

	return
end

function var_0_0.GetActionName(arg_32_0)
	return arg_32_0.actionName
end

function var_0_0.getDirectActonName(arg_33_0, arg_33_1)
	local var_33_0

	if not arg_33_0.direct then
		arg_33_0.direct = math.sign(tf(arg_33_0._model).localScale.x)
		var_33_0 = arg_33_1
	end

	local var_33_1 = var_33_0 .. (arg_33_0.direct == 1 and "_R" or "_L")

	if arg_33_0._skeletonGraphic.SkeletonData:FindAnimation(var_33_0 .. (arg_33_0.direct == 1 and "_R" or "_L")) then
		return var_33_1, true
	end

	return arg_33_1, false
end

function var_0_0.isComplete(arg_34_0)
	return arg_34_0.state == var_0_0.state_complete
end

function var_0_0.isDispose(arg_35_0)
	return arg_35_0.state == var_0_0.state_dispose
end

return var_0_0
