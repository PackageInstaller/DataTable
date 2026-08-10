local var_0_0 = class("AutoChessOpenCardInfoPopRecordView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	arg_1_0.pageShowCount = 5
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.recordScrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexRecordItem), arg_2_0.recordList_, AutoChessOpenCardPopRecordItem)
	arg_2_0.leftArrowController_ = arg_2_0.controllerEx_:GetController("leftArrowGrey")
	arg_2_0.rightArrowController_ = arg_2_0.controllerEx_:GetController("rightArrowGrey")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.rightBtn_, nil, function()
		if arg_3_0.pageNum_ * arg_3_0.pageShowCount + 1 <= AutoChessCardData:GetOpenCardRecordNum() then
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

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.txtTips_.text = GetTipsF("AUTO_CHESS_2_HISTORY_TIP", GameSetting.auto_chess_2_pack_history_num.value[1])
	arg_6_0.txtLabel_.text = GetTips("AUTO_CHESS_2_HISTORY_TIP2")
	arg_6_0.txtTips1_.text = GetTips("AUTO_CHESS_2_HISTORY_TIP3")
	arg_6_0.txtTips2_.text = GetTips("AUTO_CHESS_2_HISTORY_TIP4")
end

function var_0_0.RefreshRecord(arg_7_0)
	arg_7_0.pageNum_ = 1

	arg_7_0:RefreshRecordUI()
end

function var_0_0.RefreshRecordUI(arg_8_0)
	arg_8_0.pagenumText_.text = arg_8_0.pageNum_
	arg_8_0.recordItemList_ = {}

	local var_8_0 = AutoChessCardData:GetOpenCardRecordNum()
	local var_8_1 = math.min(arg_8_0.pageNum_ * arg_8_0.pageShowCount, var_8_0)

	for iter_8_0 = (arg_8_0.pageNum_ - 1) * arg_8_0.pageShowCount + 1, var_8_1 do
		table.insert(arg_8_0.recordItemList_, iter_8_0)
	end

	arg_8_0.recordScrollHelper_:StartScroll(#arg_8_0.recordItemList_)
	arg_8_0.leftArrowController_:SetSelectedState(arg_8_0.pageNum_ > 1 and "not_grey" or "grey")
	arg_8_0.rightArrowController_:SetSelectedState(var_8_0 >= arg_8_0.pageNum_ * arg_8_0.pageShowCount + 1 and "not_grey" or "grey")
end

function var_0_0.IndexRecordItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(arg_9_0.recordItemList_[arg_9_1], arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.recordScrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
