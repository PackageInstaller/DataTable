local var_0_0 = class("SummerChessBoardExploreNoteView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_ExploreNotePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.toggleList_ = {}
	arg_3_0.noteItemList_ = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.noteItemList_[iter_3_0] = SummerChessBoardExploreNoteItem.New(arg_3_0[string.format("item%s_", iter_3_0)])
	end

	arg_3_0.switchPageHandler_ = handler(arg_3_0, arg_3_0.SwitchPage)
	arg_3_0.firstEnter_ = true
end

function var_0_0.OnEnter(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.videoGo_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO)
	manager.notify:RegistListener(SUMMER_CHESS_BOARD_EXPLORE_NOTE_SWITCH, arg_4_0.switchPageHandler_)

	arg_4_0.taskIDList_ = SummerChessBoardTools.GetFinishExploreNoteList()

	for iter_4_0 = 1, #arg_4_0.taskIDList_ do
		arg_4_0.toggleList_[iter_4_0] = arg_4_0.toggleList_[iter_4_0] or SummerChessBoardExploreNoteToggle.New(arg_4_0.toggleItem_, arg_4_0.toggleParent_, iter_4_0)

		arg_4_0.toggleList_[iter_4_0]:OnEnter(arg_4_0.taskIDList_[iter_4_0])
	end

	for iter_4_1, iter_4_2 in ipairs(arg_4_0.noteItemList_) do
		iter_4_2:OnEnter()
	end

	if #arg_4_0.taskIDList_ <= 0 then
		return
	end

	if arg_4_0.firstEnter_ == true then
		arg_4_0.selectIndex_ = #arg_4_0.taskIDList_
		arg_4_0.firstEnter_ = false
	end

	arg_4_0.toggleList_[arg_4_0.selectIndex_]:IsOn(true)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.videoGo_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO)
	manager.notify:RemoveListener(SUMMER_CHESS_BOARD_EXPLORE_NOTE_SWITCH, arg_5_0.switchPageHandler_)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.noteItemList_) do
		iter_5_1:OnExit()
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.toggleList_) do
		iter_5_3:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.switchPageHandler_ = nil
	arg_6_0.selectIndex_ = nil
	arg_6_0.firstEnter_ = true

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.toggleList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.toggleList_ = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.noteItemList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.noteItemList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.videoBtn_, nil, function()
		saveData("SUMMER_3.5_NOTE", "IS_CLICK", 1)
		manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO, 0)
		gameContext:Go("/blank")
		manager.audio:Pause("music", true)

		local var_9_0 = GameSetting.summer_note_video

		manager.video:Play(var_9_0.value[3], function(arg_10_0)
			gameContext:Back()
			manager.audio:Pause("music", false)
		end, nil, nil, nil, var_9_0.value[2])
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	SetActive(arg_11_0.videoGo_, false)

	local var_11_0 = arg_11_0.taskIDList_[arg_11_0.selectIndex_]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1 == 1 then
			arg_11_0.noteItemList_[iter_11_0]:Show(false)
			SetActive(arg_11_0.videoGo_, true)

			arg_11_0.videoGo_.transform.localPosition = arg_11_0.noteItemList_[iter_11_0].transform_.localPosition
		else
			arg_11_0.noteItemList_[iter_11_0]:SetData(iter_11_1)
		end
	end

	for iter_11_2 = #var_11_0 + 1, 4 do
		arg_11_0.noteItemList_[iter_11_2]:Show(false)
	end
end

function var_0_0.SwitchPage(arg_12_0, arg_12_1)
	arg_12_0.selectIndex_ = arg_12_1

	arg_12_0:RefreshUI()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.toggleList_) do
		iter_12_1:RefreshRedPoint()
	end
end

return var_0_0
