local var_0_0 = class("HodurMainlineContentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.eventController_ = arg_2_0.mainControllerEx_:GetController("Event")
	arg_2_0.stageController_ = arg_2_0.mainControllerEx_:GetController("Checkpoint")
	arg_2_0.stageItem_ = nil
	arg_2_0.eventItem_ = nil
	arg_2_0.stageID_ = nil
	arg_2_0.eventID_ = nil
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.stageID_ = arg_3_1
	arg_3_0.eventID_ = arg_3_2
	arg_3_0.pos_ = arg_3_3
	arg_3_0.last_ = arg_3_4
	arg_3_0.chapterID_ = arg_3_5

	arg_3_0:RefreshUI()
end

function var_0_0.SetCallback(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.stageHandler_ = arg_4_1
	arg_4_0.eventHandler_ = arg_4_2

	if arg_4_0.stageItem_ then
		arg_4_0.stageItem_:SetClickHandler(arg_4_0.stageHandler_)
	end

	if arg_4_0.eventItem_ then
		arg_4_0.eventItem_:SetClickHandler(arg_4_0.eventHandler_)
	end
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.stageID_ then
		if arg_5_0.stageItem_ == nil then
			arg_5_0.stageItem_ = HodurMainlineStageItem.New(arg_5_0.stageItemGo_)
		end

		arg_5_0.stageItem_:SetData(arg_5_0.stageID_, arg_5_0.pos_, arg_5_0.last_, arg_5_0.chapterID_)
	end

	if arg_5_0.eventID_ and HodurTools.GetEventUnlock(arg_5_0.eventID_, arg_5_0.chapterID_) then
		if arg_5_0.eventItem_ == nil then
			arg_5_0.eventItem_ = HodurMainlineEventItem.New(arg_5_0.eventItemGo_)
		end

		arg_5_0.eventItem_:SetData(arg_5_0.eventID_, arg_5_0.chapterID_)
		arg_5_0.eventController_:SetSelectedState("on")
	else
		arg_5_0.eventController_:SetSelectedState("off")
	end
end

function var_0_0.SetSelect(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == HodurConst.INFO_VIEW_TYPE.STAGE then
		if arg_6_0.stageID_ == arg_6_2 then
			arg_6_0.stageItem_:SetSelected(true)

			return true
		else
			arg_6_0.stageItem_:SetSelected(false)
		end
	elseif arg_6_0.eventItem_ then
		if arg_6_0.eventID_ == arg_6_2 then
			arg_6_0.eventItem_:SetSelected(true)

			return true
		else
			arg_6_0.eventItem_:SetSelected(false)
		end
	end

	return false
end

function var_0_0.SetSelectFalse(arg_7_0)
	if arg_7_0.stageItem_ then
		arg_7_0.stageItem_:SetSelected(false)
	end

	if arg_7_0.eventItem_ then
		arg_7_0.eventItem_:SetSelected(false)
	end
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.stageItem_ then
		arg_9_0.stageItem_:Dispose()

		arg_9_0.stageItem_ = nil
	end

	if arg_9_0.eventItem_ then
		arg_9_0.eventItem_:Dispose()

		arg_9_0.eventItem_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
