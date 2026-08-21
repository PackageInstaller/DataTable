local var_0_0 = class("ChapterV2MapSubTagItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("state")
	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		arg_2_0:OnClickSubTag(arg_2_0, arg_2_0.tagId_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.tagId_ = arg_4_1
	arg_4_0.isSelect_ = arg_4_2

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.tagCfg_ = ChapterV2MapTagCfg[arg_5_0.tagId_]

	if arg_5_0.isSelect_ then
		arg_5_0.text_.text = "->" .. arg_5_0.tagCfg_.tag_name
	else
		arg_5_0.text_.text = arg_5_0.tagCfg_.tag_name
	end

	local var_5_0 = ChapterV2MapConst.ICONTYPE.NONE

	if arg_5_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
		local var_5_1 = arg_5_0.tagId_
		local var_5_2 = ChapterV2MapData:GetLocationActiveTagList(var_5_1)[1]
		local var_5_3 = ChapterV2MapTagCfg[var_5_2]

		if var_5_3 then
			local var_5_4 = ChapterV2MapEventCfg[var_5_3.behaviour_parameters[1]]

			if var_5_4 then
				var_5_0 = var_5_4.type
			end
		end
	else
		local var_5_5 = ChapterV2MapEventCfg[arg_5_0.tagCfg_.behaviour_parameters[1]]

		if var_5_5 then
			var_5_0 = var_5_5.type
		end
	end

	arg_5_0.stateController_:SetSelectedState(tostring(var_5_0))
	arg_5_0.selectController_:SetSelectedState(tostring(arg_5_0.isSelect_))
	arg_5_0:BindRedPoint()
end

function var_0_0.SetSelectedState(arg_6_0, arg_6_1)
	arg_6_0.isSelect_ = arg_6_1

	arg_6_0.selectController_:SetSelectedState(tostring(arg_6_0.isSelect_))
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack_ = arg_7_1
end

function var_0_0.OnClickSubTag(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.clickCallBack_ then
		arg_8_0.clickCallBack_(arg_8_1, arg_8_2)
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_9_0)

	arg_9_0.gameObject_ = nil
	arg_9_0.transform_ = nil
end

function var_0_0.BindRedPoint(arg_10_0)
	local var_10_0

	if arg_10_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
		var_10_0 = arg_10_0.tagCfg_.behaviour_parameters[1]
	elseif arg_10_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
		local var_10_1 = arg_10_0.tagId_

		var_10_0 = ChapterV2MapTools.GetLocationEvents(var_10_1)[1]
	end

	if var_10_0 and var_10_0 ~= 0 then
		manager.redPoint:bindUIandKey(arg_10_0.text_.transform, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_EVENT, var_10_0))
	else
		arg_10_0:UnbindRedPoint()
	end
end

function var_0_0.UnbindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.text_.transform)
end

return var_0_0
