local var_0_0 = class("ChapterV2MapTestEvent", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		manager.notify:Invoke(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_2_0.eventId_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.eventId_ = arg_4_1
	arg_4_0.isSelect_ = arg_4_2

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ChapterV2MapEventCfg[arg_5_0.eventId_]

	if arg_5_0.isSelect_ then
		arg_5_0.text_.text = "->" .. var_5_0.name
	else
		arg_5_0.text_.text = var_5_0.name
	end

	arg_5_0.text_.text = arg_5_0.text_.text .. " " .. var_5_0.id

	arg_5_0:BindRedPoint()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil
end

function var_0_0.BindRedPoint(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.transform_, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_EVENT, arg_7_0.eventId_))
end

function var_0_0.UnbindRedPoint(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.transform_)
end

return var_0_0
