local var_0_0 = class("CourtYardFurnitureAnimatorAgent", import(".CourtYardAgent"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.maskSpineAnimUIs = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.masks) do
		table.insert(arg_1_0.maskSpineAnimUIs, (GetOrAddComponent(iter_1_1:Find("spine"), typeof(SpineAnimUI))))
	end

	arg_1_0.spineTF = arg_1_0._tf:Find("spine_icon")
	arg_1_0.spineAnimUI = GetOrAddComponent(arg_1_0.spineTF:Find("spine"), typeof(SpineAnimUI))

	arg_1_0:SetState(CourtYardFurniture.STATE_IDLE)

	return
end

function var_0_0.State2Action(arg_2_0, arg_2_1)
	if arg_2_1 == CourtYardFurniture.STATE_IDLE then
		return arg_2_0.data:GetFirstSlot():GetSpineDefaultAction(), true
	elseif arg_2_1 == CourtYardFurniture.STATE_TOUCH then
		return arg_2_0.data:GetTouchAction()
	elseif arg_2_1 == CourtYardFurniture.STATE_TOUCH_PREPARE then
		return arg_2_0.data:GetTouchPrepareAction()
	elseif arg_2_1 == CourtYardFurniture.STATE_PLAY_MUSIC then
		return arg_2_0.data:GetMusicData().action, true
	end

	return
end

function var_0_0.SetState(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:State2Action(arg_3_1)

	if not var_3_0 or var_3_0 == "" then
		return
	end

	arg_3_0:_PlayAction(var_3_0, var_3_1, function()
		arg_3_0:OnAnimtionFinish(arg_3_1)

		return
	end)

	if arg_3_1 == CourtYardFurniture.STATE_IDLE then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.maskSpineAnimUIs) do
			iter_3_1:SetAction(var_3_0, 0)
		end
	end

	return
end

function var_0_0.GetNormalAnimationName(arg_5_0)
	return arg_5_0:State2Action(CourtYardFurniture.STATE_IDLE)
end

function var_0_0.RestartAnimation(arg_6_0, arg_6_1)
	arg_6_0.spineAnimUI:SetAction(arg_6_1, 0)

	return
end

function var_0_0._PlayAction(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_2 then
		local function var_7_0(arg_8_0)
			if arg_8_0 == "finish" then
				arg_7_0.spineAnimUI:SetActionCallBack(nil)
				arg_7_3()
			end

			return
		end

		if not function(arg_8_0)
			if arg_8_0 == "finish" then
				arg_7_0.spineAnimUI:SetActionCallBack(nil)
				arg_7_3()
			end

			return
		end then
			var_7_0 = nil
		end

		arg_7_0.spineAnimUI:SetActionCallBack(var_7_0)
		arg_7_0.spineAnimUI:SetAction(arg_7_1, 0)

		return
	end
end

function var_0_0.PlayInteractioAnim(arg_9_0, arg_9_1)
	parallelAsync({
		function(arg_10_0)
			arg_9_0:PlayMaskAction(arg_9_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			arg_9_0:_PlayAction(arg_9_1, false, arg_11_0)

			return
		end
	}, function()
		arg_9_0:OnAnimtionFinish(CourtYardFurniture.STATE_INTERACT)

		return
	end)

	return
end

function var_0_0.PlayMaskAction(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.maskSpineAnimUIs) do
		table.insert({}, function(arg_14_0)
			iter_13_1:SetActionCallBack(function(arg_15_0)
				if arg_15_0 == "finish" then
					iter_13_1:SetActionCallBack(nil)
					arg_14_0()
				end

				return
			end)
			iter_13_1:SetAction(arg_13_1, 0)

			return
		end)
	end

	parallelAsync({}, arg_13_2)

	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.spineAnimUI:SetActionCallBack(nil)
	Object.Destroy(arg_16_0.spineAnimUI)

	arg_16_0.spineAnimUI = nil

	Object.Destroy(arg_16_0.spineTF.gameObject)

	arg_16_0.spineTF = nil

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.maskSpineAnimUIs) do
		iter_16_1:SetActionCallBack(nil)
		Object.Destroy(iter_16_1)
	end

	arg_16_0.maskSpineAnimUIs = nil

	var_0_0.super.Dispose()

	return
end

return var_0_0
