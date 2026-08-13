class = var_0_10000

local var_0_0 = var_0_10000("SpineAnimChar")
local var_0_1 = "normal"

var_0_0.state_init = 1
var_0_0.state_loading = 2
var_0_0.state_complete = 3
var_0_0.state_dispose = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		pg = var_1_10002
		arg_1_0.config = var_1_10002.ship_skin_template[arg_1_1]
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
		local var_4_0 = arg_4_0._model.transform

		var_2.SetSiblingIndex(var_4_0, arg_4_1)
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
		PoolMgr = var_3

		local var_6_0 = var_3.GetInstance()

		var_3.GetSpineChar(var_6_0, arg_6_0.prefab, arg_6_0.sync, function(arg_7_0)
			if arg_7_0 then
				local var_7_0 = arg_6_0

				if var_1.isDispose(var_7_0) then
					PoolMgr = var_1

					local var_7_1 = var_1.GetInstance()

					var_1.ReturnSpineChar(var_7_1, arg_6_0.prefab, arg_7_0)
				else
					local var_7_2 = arg_6_0

					var_1.start(var_7_2, arg_7_0)

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
		tf = var_2
		var_2(arg_8_0._model).pivot = arg_8_1
	end

	return
end

function var_0_0.SetSizeDelta(arg_9_0, arg_9_1)
	if arg_9_0:isComplete() then
		tf = var_2
		var_2(arg_9_0._model).sizeDelta = arg_9_1
	end

	return
end

function var_0_0.SetParent(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:isComplete() then
		arg_10_0.loadedParent = arg_10_1

		return
	end

	SetParent = var_3

	var_3(arg_10_0._model, arg_10_1, arg_10_2 and true or false)

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

	if not arg_12_0.modelScale then
		tf = var_5
		arg_12_0.modelScale = var_5(arg_12_0._model).localScale
	end

	local var_12_2
	local var_12_4

	if var_12_1 then
		math = var_12_4

		local var_12_3 = var_12_4.abs(arg_12_0.modelScale.x)

		tf = var_12_4
		var_12_4 = var_12_4(arg_12_0._model)
		Vector3 = var_1_10007
		var_12_4.localScale = var_1_10007(var_12_3, arg_12_0.modelScale.y, arg_12_0.modelScale.z)
	else
		math = var_12_4

		local var_12_5 = var_12_4.sign(arg_12_0.modelScale.x)

		tf = var_6
		var_6(arg_12_0._model).localScale = arg_12_0.modelScale
	end

	local var_12_6 = arg_12_0._animUI

	var_6.SetAction(var_12_6, var_12_0, arg_12_2)

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
	local var_15_0 = arg_15_0._animUI

	var_2.SetActionCallBack(var_15_0, arg_15_1)

	return
end

function var_0_0.GetLocalScale(arg_16_0)
	if arg_16_0:isComplete() then
		tf = var_1

		return var_1(arg_16_0._model).localScale
	end

	return
end

function var_0_0.SetLocalScale(arg_17_0, arg_17_1)
	if arg_17_0:isComplete() then
		math = var_2
		arg_17_0.direct = var_2.sign(arg_17_1.x)
		tf = var_2
		var_2(arg_17_0._model).localScale = arg_17_1
		arg_17_0.modelScale = arg_17_1

		arg_17_0:updateCharDirect()
	end

	return
end

function var_0_0.SetLocalPosition(arg_18_0, arg_18_1)
	if arg_18_0:isComplete() then
		tf = var_2
		var_2(arg_18_0._model).localPosition = arg_18_1
	end

	return
end

function var_0_0.SetAnchoredPosition(arg_19_0, arg_19_1)
	if arg_19_0:isComplete() then
		tf = var_2
		var_2(arg_19_0._model).anchoredPosition = arg_19_1
	end

	return
end

function var_0_0.GetAnchoredPosition(arg_20_0)
	if arg_20_0:isComplete() then
		tf = var_1

		return var_1(arg_20_0._model).anchoredPosition
	end

	return
end

function var_0_0.SetLayer(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0

	if arg_21_0.isComplete(var_21_0) then
		pg = var_2

		local var_21_1 = var_2.ViewUtils.SetLayer

		tf = var_21_0

		var_21_1(var_21_0(arg_21_0._model), arg_21_1)
	end

	return
end

function var_0_0.SetAnchoredPosition3D(arg_22_0, arg_22_1)
	if arg_22_0:isComplete() then
		tf = var_2
		var_2(arg_22_0._model).anchoredPosition3D = arg_22_1
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
		local var_25_0 = arg_25_0._animUI

		return var_1.GetAnimationState(var_25_0)
	end

	return nil
end

function var_0_0.GetModel(arg_26_0)
	return arg_26_0._model
end

function var_0_0.Resume(arg_27_0)
	if arg_27_0._animUI then
		local var_27_0 = arg_27_0._animUI

		return var_1.Resume(var_27_0)
	end

	return
end

function var_0_0.Pause(arg_28_0)
	if arg_28_0._animUI then
		local var_28_0 = arg_28_0._animUI

		return var_1.Pause(var_28_0)
	end

	return
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.state == var_0_0.state_complete then
		arg_29_0:SetActionCallBack(nil)

		PoolMgr = var_1

		local var_29_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_29_0, arg_29_0.prefab, arg_29_0._model)
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

	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.GetComponent

	typeof = var_1_10005
	SpineAnimUI = var_1_10007
	arg_30_0._animUI = var_30_1(var_30_0, var_1_10005(var_1_10007))
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
	if not arg_33_0.direct then
		math = var_2

		local var_33_0 = var_2.sign

		tf = var_1_10004
		arg_33_0.direct = var_33_0(var_1_10004(arg_33_0._model).localScale.x)
	end

	local var_33_1 = arg_33_0.direct == 1 and "_R" or "_L"
	local var_33_2 = arg_33_1 .. var_33_1
	local var_33_3 = arg_33_0._skeletonGraphic.SkeletonData

	if var_4.FindAnimation(var_33_3, var_33_2) then
		return var_33_2, true
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
