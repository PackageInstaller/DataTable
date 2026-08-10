local var_0_0 = class("ActivitySkinDrawEntraceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:OnClickBtn()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.OnClickBtn(arg_7_0)
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW == ActivityTools.GetActivityType(arg_7_0.activityID_) then
		ActivitySkinDrawTools.OnJumpToSkinDraw(arg_7_0.activityID_)
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == ActivityTools.GetActivityType(arg_7_0.activityID_) then
		local var_7_0 = ActivityData:GetActivityData(arg_7_0.activityID_)

		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and var_7_0:IsActivitying() then
			local var_7_1 = ActivityOathDrawAction.GetNowSkinKey(arg_7_0.activityID_)

			if not getData("OathDrawNew", var_7_1) then
				saveData("OathDrawNew", var_7_1, 1)
				manager.redPoint:setTip(RedPointConst.OATH_DRAW_NEW, 0, RedPointStyle.SHOW_NEW_TAG)
			end

			JumpTools.OpenPageByJump("/activityOathDrawMainView", {
				activityID = arg_7_0.activityID_
			})
		else
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.SKIN_DRAW, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW)))
		end
	end
end

function var_0_0.GetLoadGoPath(arg_8_0)
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW == ActivityTools.GetActivityType(arg_8_0.activityID_) then
		return T0SkinDrawCfg[arg_8_0.activityID_].enterItem
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == ActivityTools.GetActivityType(arg_8_0.activityID_) then
		return WeddingSkinDrawCfg[arg_8_0.activityID_].enterItem
	end

	return nil
end

function var_0_0.Refresh(arg_9_0, arg_9_1)
	arg_9_0.activityID_ = arg_9_1

	if not arg_9_0.activitySkinItem_ then
		local var_9_0 = arg_9_0:GetLoadGoPath()
		local var_9_1 = Asset.Load(var_9_0)

		if not isNil(var_9_1) then
			arg_9_0.activitySkinItem_ = GameObject.Instantiate(var_9_1, arg_9_0.transform_, false)
			arg_9_0.activitySkinItem_.transform.anchoredPosition = Vector2.New(0, 0)
		end
	end

	arg_9_0:BindRedPointUI()
end

function var_0_0.BindRedPointUI(arg_10_0)
	if ActivityData:GetActivityIsOpen(arg_10_0.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and arg_10_0.redPointPanel_ then
		manager.redPoint:bindUIandKey(arg_10_0.redPointPanel_, RedPointConst.ACTIVITY_DRAW .. "_" .. arg_10_0.activityID_)
	end
end

function var_0_0.UnbindRedPointUI(arg_11_0)
	if arg_11_0.redPointPanel_ then
		manager.redPoint:unbindUIandKey(arg_11_0.redPointPanel_, RedPointConst.ACTIVITY_DRAW .. "_" .. arg_11_0.activityID_)
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:UnbindRedPointUI()
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
