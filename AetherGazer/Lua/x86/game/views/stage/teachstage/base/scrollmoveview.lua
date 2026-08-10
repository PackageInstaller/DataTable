local var_0_0 = class("ScrollMoveView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.parentView_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.fixWidth = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:AddListeners()

	arg_1_0.needInitScroll_ = true
end

function var_0_0.OnExit(arg_2_0)
	arg_2_0.scrollView_.enabled = true
	arg_2_0.needInitScroll_ = true
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveListeners()

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		arg_5_0.drag_ = true
	end))
	arg_5_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		arg_5_0.drag_ = false
	end))
	arg_5_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		if not arg_5_0.tween_ then
			arg_5_0.scrollView_.enabled = true
		end
	end))
	arg_5_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if not arg_9_1.dragging and arg_5_0.parentView_:IsOpenSectionInfo() then
			arg_5_0.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end))
	arg_5_0.scrollView_.onValueChanged:AddListener(function(arg_10_0)
		if arg_5_0.isOpenInfoView_ and math.abs(arg_5_0.horizontalNormalizedPosition_ - arg_5_0.scrollView_.horizontalNormalizedPosition) >= 0.001 then
			arg_5_0.isOpenInfoView_ = false

			if arg_5_0.parentView_:IsOpenSectionInfo() then
				LeanTween.cancel(arg_5_0.gameObject_)
				JumpTools.Back()
			end
		end

		if arg_5_0.parentView_.OnScrollValueChanged then
			arg_5_0.parentView_:OnScrollValueChanged()
		end
	end)
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_11_0.scrollView_.onValueChanged:RemoveAllListeners()
end

function var_0_0.InitScrollPosition(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = BattleFieldData:GetStoryBackFlag()

	if arg_12_0.needInitScroll_ and arg_12_0.contentRect_.rect.width < arg_12_0.viewportRect_.rect.width then
		arg_12_0:RemoveTween()

		if var_12_0 == true then
			arg_12_0:StopMove(0)

			return
		end

		if arg_12_2 then
			local var_12_1 = arg_12_0.contentRect_.localPosition

			arg_12_0.contentRect_.localPosition = Vector3(0, var_12_1.y, var_12_1.z)
		else
			arg_12_0.tween_ = LeanTween.value(arg_12_0.gameObject_, arg_12_0.viewportRect_.rect.width, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
				if arg_12_0.drag_ then
					arg_12_0:RemoveTween()

					return
				end

				local var_13_0 = arg_12_0.contentRect_.localPosition

				arg_12_0.contentRect_.localPosition = Vector3(arg_13_0, var_13_0.y, var_13_0.z)
			end)):setOnComplete(System.Action(function()
				arg_12_0:RemoveTween()
			end)):setEase(LeanTweenType.easeOutSine)
		end

		arg_12_0.needInitScroll_ = false

		return
	end

	if arg_12_0.needInitScroll_ then
		arg_12_0.scrollView_.horizontalNormalizedPosition = 0
	end

	local var_12_2 = (arg_12_1 - arg_12_0.viewportRect_.rect.width / 2 + 200) / (arg_12_0.contentRect_.rect.width - arg_12_0.viewportRect_.rect.width)

	if var_12_2 < 0 then
		var_12_2 = 0

		if arg_12_0.needInitScroll_ then
			arg_12_0.scrollView_.horizontalNormalizedPosition = -1
		end
	elseif var_12_2 > 1 then
		var_12_2 = 1
	end

	arg_12_0:RemoveTween()

	if var_12_0 == true then
		arg_12_0:StopMove(var_12_2)

		return
	end

	if arg_12_2 then
		arg_12_0.horizontalNormalizedPosition_ = var_12_2
		arg_12_0.scrollView_.horizontalNormalizedPosition = var_12_2
	else
		arg_12_0.tween_ = LeanTween.value(arg_12_0.gameObject_, arg_12_0.scrollView_.horizontalNormalizedPosition, var_12_2, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
			if arg_12_0.drag_ then
				arg_12_0:RemoveTween()

				return
			end

			arg_12_0.horizontalNormalizedPosition_ = arg_15_0
			arg_12_0.scrollView_.horizontalNormalizedPosition = arg_15_0
		end)):setOnComplete(System.Action(function()
			arg_12_0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end

	arg_12_0.needInitScroll_ = false
end

function var_0_0.ScrollPosition(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0.parentView_:IsOpenSectionInfo() then
		if arg_17_0.contentRect_.rect.width < arg_17_0.viewportRect_.rect.width then
			arg_17_0.contentRect_.sizeDelta = Vector2(arg_17_0.viewportRect_.rect.width, 648)
		end

		local var_17_0 = arg_17_1 - arg_17_0.viewportRect_.rect.width / 2 + 200

		if arg_17_3 then
			var_17_0 = var_17_0 + arg_17_3
		end

		arg_17_0:RemoveTween()

		arg_17_0.scrollView_.enabled = false

		if arg_17_2 then
			local var_17_1 = var_17_0 / (arg_17_0.contentRect_.rect.width - arg_17_0.viewportRect_.rect.width)

			arg_17_0.horizontalNormalizedPosition_ = var_17_1
			arg_17_0.scrollView_.horizontalNormalizedPosition = var_17_1

			if arg_17_0.parentView_:IsOpenSectionInfo() then
				arg_17_0.isOpenInfoView_ = true
			end
		else
			arg_17_0.tween_ = LeanTween.value(arg_17_0.gameObject_, arg_17_0.scrollView_.horizontalNormalizedPosition, var_17_0 / (arg_17_0.contentRect_.rect.width - arg_17_0.viewportRect_.rect.width), 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
				arg_17_0.horizontalNormalizedPosition_ = arg_18_0
				arg_17_0.scrollView_.horizontalNormalizedPosition = arg_18_0

				if arg_17_0.parentView_.OnScrollValueChanged then
					arg_17_0.parentView_:OnScrollValueChanged()
				end
			end)):setOnComplete(System.Action(function()
				if arg_17_0.parentView_:IsOpenSectionInfo() then
					arg_17_0.isOpenInfoView_ = true
				end

				if arg_17_0.parentView_.OnScrollValueChanged then
					arg_17_0.parentView_:OnScrollValueChanged()
				end

				arg_17_0:RemoveTween()
			end)):setEase(LeanTweenType.easeOutSine)
		end
	else
		if not arg_17_0.fixWidth then
			arg_17_0:CalcuteScrollWidth()
		end

		arg_17_0.scrollView_.enabled = true
	end
end

function var_0_0.ScrollVector(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_4 = arg_20_4 or 0.5

	if arg_20_0.parentView_:IsOpenSectionInfo() then
		if arg_20_0.contentRect_.rect.width < arg_20_0.viewportRect_.rect.width then
			arg_20_0.contentRect_.sizeDelta = Vector2(0, 648)
		end

		arg_20_1.x = arg_20_1.x - arg_20_0.viewportRect_.rect.width / 2 + 200
		arg_20_1 = arg_20_1 * -1

		arg_20_0:RemoveTween()

		arg_20_0.scrollView_.enabled = false
		arg_20_0.horizontalNormalizedPosition_ = arg_20_0.scrollView_.horizontalNormalizedPosition

		if arg_20_2 then
			arg_20_0.contentRect_.localPosition = arg_20_1

			if arg_20_0.parentView_:IsOpenSectionInfo() then
				arg_20_0.isOpenInfoView_ = true
			end
		else
			arg_20_0.tween_ = LeanTween.moveLocal(arg_20_0.contentRect_.gameObject, arg_20_1, arg_20_4):setOnComplete(System.Action(function()
				if arg_20_0.parentView_:IsOpenSectionInfo() then
					arg_20_0.isOpenInfoView_ = true
				end

				arg_20_0:RemoveTween()

				if arg_20_3 then
					arg_20_3()
				end
			end)):setEase(LeanTweenType.easeOutSine)
		end
	else
		if not arg_20_0.fixWidth then
			arg_20_0:CalcuteScrollWidth()
		end

		arg_20_0.scrollView_.enabled = true
	end
end

function var_0_0.ScrollVector2(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_4 = arg_22_4 or 0.5

	arg_22_0:RemoveTween()

	arg_22_0.scrollView_.enabled = false
	arg_22_0.horizontalNormalizedPosition_ = arg_22_0.scrollView_.horizontalNormalizedPosition

	if arg_22_2 then
		arg_22_0.contentRect_.localPosition = arg_22_1
		arg_22_0.scrollView_.enabled = true

		if arg_22_3 then
			arg_22_3()
		end
	else
		arg_22_0.tween_ = LeanTween.moveLocal(arg_22_0.contentRect_.gameObject, arg_22_1, arg_22_4):setOnComplete(System.Action(function()
			arg_22_0:RemoveTween()

			arg_22_0.scrollView_.enabled = true

			if arg_22_3 then
				arg_22_3()
			end
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function var_0_0.ScrollForceVector(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_3 = arg_24_3 or 0.5

	arg_24_0:RemoveTween()

	arg_24_0.scrollView_.enabled = false
	arg_24_0.horizontalNormalizedPosition_ = arg_24_0.scrollView_.horizontalNormalizedPosition

	if arg_24_1.x * -1 > arg_24_0.contentRect_.rect.width - arg_24_0.viewportRect_.rect.width then
		arg_24_1.x = arg_24_0.contentRect_.rect.width * -1 + arg_24_0.viewportRect_.rect.width
	end

	if arg_24_1.x >= 0 then
		arg_24_1.x = 0
	end

	if arg_24_2 then
		arg_24_0.contentRect_.localPosition = arg_24_1
	else
		arg_24_0.tween_ = LeanTween.moveLocal(arg_24_0.contentRect_.gameObject, arg_24_1, arg_24_3):setOnComplete(System.Action(function()
			arg_24_0.scrollView_.enabled = true

			arg_24_0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function var_0_0.StopMove(arg_26_0, arg_26_1)
	BattleFieldData:SetStoryBackFlag(false)

	arg_26_0.horizontalNormalizedPosition_ = arg_26_1
	arg_26_0.scrollView_.horizontalNormalizedPosition = arg_26_1
end

function var_0_0.RemoveTween(arg_27_0)
	if arg_27_0.tween_ then
		arg_27_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_27_0.tween_.id)

		arg_27_0.tween_ = nil
	end
end

function var_0_0.CalcuteScrollWidth(arg_28_0)
	arg_28_0.contentRect_.sizeDelta = Vector2(arg_28_0.scrollWidth_ - arg_28_0.viewportRect_.rect.width + arg_28_0.viewportRect_.rect.width / 4, 648)
end

function var_0_0.RefreshUI(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0.scrollWidth_ = arg_29_2

	arg_29_0:CalcuteScrollWidth()
	arg_29_0:InitScrollPosition(arg_29_1, arg_29_3)
	arg_29_0:ScrollPosition(arg_29_1, arg_29_3)
end

function var_0_0.SetHorizontalNormalizedPosition(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.needInitScroll_ = false
	arg_30_0.scrollWidth_ = arg_30_2

	arg_30_0:CalcuteScrollWidth()

	arg_30_0.scrollView_.horizontalNormalizedPosition = arg_30_1
end

function var_0_0.GetHorizontalNormalizedPosition(arg_31_0)
	return arg_31_0.scrollView_.horizontalNormalizedPosition
end

return var_0_0
