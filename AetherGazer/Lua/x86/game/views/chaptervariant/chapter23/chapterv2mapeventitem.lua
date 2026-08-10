local var_0_0 = class("ChapterV2MapEventItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.typeControl_ = arg_1_0.conEx_:GetController("information")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.selectBtn_, nil, function()
		if arg_2_0.isTrack_ then
			manager.notify:Invoke(CHAPTER_MAP_TRACK_EVENT_CLICK, arg_2_0.eventId_)
		else
			manager.notify:Invoke(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_2_0.eventId_)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.eventId_ = arg_4_1
	arg_4_0.isTrack_ = arg_4_2
	arg_4_0.isSelect_ = arg_4_3
	arg_4_0.gameObject_.name = tostring(arg_4_1)

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ChapterV2MapEventCfg[arg_5_0.eventId_]

	if arg_5_0.isTrack_ then
		local var_5_1, var_5_2 = ChapterV2MapTools.IsEventInteractable(arg_5_0.eventId_)

		if var_5_1 then
			arg_5_0.text_.text = var_5_0.trace_text
		elseif var_5_2 then
			arg_5_0.text_.text = ConditionCfg[var_5_2].desc
		else
			arg_5_0.text_.text = GetTips("ERROR_USER_NOT_ACHIEVE_CONDITION")
		end
	else
		arg_5_0.text_.text = var_5_0.name
	end

	if var_5_0.type == ChapterV2MapConst.MapEventType.MAIN then
		arg_5_0.typeControl_:SetSelectedState("main")
	elseif var_5_0.type == ChapterV2MapConst.MapEventType.SIDE then
		arg_5_0.typeControl_:SetSelectedState("side")
	elseif var_5_0.type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
		arg_5_0.typeControl_:SetSelectedState("clue")
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil
end

return var_0_0
