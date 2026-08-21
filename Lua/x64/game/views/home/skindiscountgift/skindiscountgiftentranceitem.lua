local var_0_0 = class("SkinDiscountGiftEntranceItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	arg_2_0:DestroyItem()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "homepage_banner_activity_" .. arg_3_0.activityID_
		})
		JumpTools.GoToSystem("/skinDiscountGiftMain", {
			activityID = arg_3_0.activityID_
		}, ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT)
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	SkinDiscountGiftAction.RefresRedPointNewTag(arg_5_1)

	if arg_5_0.activityID_ ~= arg_5_1 and arg_5_0.activitySkinItem_ then
		arg_5_0:UnbindRedPointUI()
		arg_5_0:DestroyItem()
	end

	arg_5_0.activityID_ = arg_5_1

	arg_5_0:BindRedPointUI()

	if not arg_5_0.activitySkinItem_ then
		local var_5_0 = Asset.Load(SkinDiscountGiftTools.GetEntramceItemPrefabPath(arg_5_0.activityID_))

		if not isNil(var_5_0) then
			arg_5_0.activitySkinItem_ = GameObject.Instantiate(var_5_0, arg_5_0.transform_, false)
			arg_5_0.activitySkinItem_.transform.anchoredPosition = Vector2.New(0, 0)
		end
	end
end

function var_0_0.DestroyItem(arg_6_0)
	if arg_6_0.activitySkinItem_ then
		Object.Destroy(arg_6_0.activitySkinItem_)

		arg_6_0.activitySkinItem_ = nil
	end
end

function var_0_0.BindRedPointUI(arg_7_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT) then
		manager.redPoint:bindUIandKey(arg_7_0.redPointPanel_, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. arg_7_0.activityID_)
	end
end

function var_0_0.UnbindRedPointUI(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.redPointPanel_, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. arg_8_0.activityID_)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:UnbindRedPointUI()
end

return var_0_0
