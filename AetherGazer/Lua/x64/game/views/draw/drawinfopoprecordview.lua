local var_0_0 = class("DrawInfoPopRecordView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	arg_1_0.pageShowCount = 5
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.recordScrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexRecordItem), arg_2_0.recordList_, DrawInfoPopRecordItem)
	arg_2_0.leftArrowController_ = arg_2_0.controllerEx_:GetController("leftArrowGrey")
	arg_2_0.rightArrowController_ = arg_2_0.controllerEx_:GetController("rightArrowGrey")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.rightBtn_, nil, function()
		if arg_3_0.pageNum_ * arg_3_0.pageShowCount + 1 <= #arg_3_0.record_list then
			arg_3_0.pageNum_ = arg_3_0.pageNum_ + 1

			arg_3_0:RefreshRecordUI()
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.leftBtn_, nil, function()
		if arg_3_0.pageNum_ > 1 then
			arg_3_0.pageNum_ = arg_3_0.pageNum_ - 1

			arg_3_0:RefreshRecordUI()
		end
	end)
end

function var_0_0.RefreshRecord(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.poolId = arg_6_1

	local var_6_0 = DrawData:GetDrawRecord(arg_6_1)

	arg_6_0.pageNum_ = 1

	if var_6_0 then
		arg_6_0.times = var_6_0.ssr_draw_times
		arg_6_0.record_list = var_6_0.draw_record_list

		arg_6_0:RefreshRecordUI()
	else
		DrawAction.RequestRecord(arg_6_1)
	end
end

function var_0_0.OnRefreshRecord(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = DrawData:GetDrawRecord(arg_7_2.id)

	if var_7_0 then
		arg_7_0.times = var_7_0.ssr_draw_times
		arg_7_0.record_list = var_7_0.draw_record_list or {}

		arg_7_0:RefreshRecordUI()
	end
end

function var_0_0.RefreshRecordUI(arg_8_0)
	arg_8_0.pagenumText_.text = arg_8_0.pageNum_
	arg_8_0.recordItemList_ = {}

	local var_8_0 = math.min(arg_8_0.pageNum_ * arg_8_0.pageShowCount, #arg_8_0.record_list)

	for iter_8_0 = (arg_8_0.pageNum_ - 1) * arg_8_0.pageShowCount + 1, var_8_0 do
		table.insert(arg_8_0.recordItemList_, arg_8_0.record_list[iter_8_0])
	end

	arg_8_0.recordScrollHelper_:StartScroll(#arg_8_0.recordItemList_)
	arg_8_0.leftArrowController_:SetSelectedState(arg_8_0.pageNum_ > 1 and "not_grey" or "grey")
	arg_8_0.rightArrowController_:SetSelectedState(arg_8_0.pageNum_ * arg_8_0.pageShowCount + 1 <= #arg_8_0.record_list and "not_grey" or "grey")
end

function var_0_0.IndexRecordItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(arg_9_0.recordItemList_[arg_9_1], arg_9_0.poolId, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.recordScrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
