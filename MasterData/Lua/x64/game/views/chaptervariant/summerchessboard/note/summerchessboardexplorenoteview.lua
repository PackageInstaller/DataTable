local SummerChessBoardExploreNoteView = class("SummerChessBoardExploreNoteView", ReduxView)

function SummerChessBoardExploreNoteView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_ExploreNotePopUI"
end

function SummerChessBoardExploreNoteView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerChessBoardExploreNoteView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.toggleList_ = {}
	self.noteItemList_ = {}

	for iter_3_0 = 1, 4 do
		self.noteItemList_[iter_3_0] = SummerChessBoardExploreNoteItem.New(self[string.format("item%s_", iter_3_0)])
	end

	self.switchPageHandler_ = handler(self, self.SwitchPage)
	self.firstEnter_ = true
end

function SummerChessBoardExploreNoteView:OnEnter()
	manager.redPoint:bindUIandKey(self.videoGo_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO)
	manager.notify:RegistListener(SUMMER_CHESS_BOARD_EXPLORE_NOTE_SWITCH, self.switchPageHandler_)

	self.taskIDList_ = SummerChessBoardTools.GetFinishExploreNoteList()

	for iter_4_0 = 1, #self.taskIDList_ do
		self.toggleList_[iter_4_0] = self.toggleList_[iter_4_0] or SummerChessBoardExploreNoteToggle.New(self.toggleItem_, self.toggleParent_, iter_4_0)

		self.toggleList_[iter_4_0]:OnEnter(self.taskIDList_[iter_4_0])
	end

	for iter_4_1, iter_4_2 in ipairs(self.noteItemList_) do
		iter_4_2:OnEnter()
	end

	if #self.taskIDList_ <= 0 then
		return
	end

	if self.firstEnter_ == true then
		self.selectIndex_ = #self.taskIDList_
		self.firstEnter_ = false
	end

	self.toggleList_[self.selectIndex_]:IsOn(true)
	self:RefreshUI()
end

function SummerChessBoardExploreNoteView:OnExit()
	manager.redPoint:unbindUIandKey(self.videoGo_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO)
	manager.notify:RemoveListener(SUMMER_CHESS_BOARD_EXPLORE_NOTE_SWITCH, self.switchPageHandler_)

	for iter_5_0, iter_5_1 in ipairs(self.noteItemList_) do
		iter_5_1:OnExit()
	end

	for iter_5_2, iter_5_3 in ipairs(self.toggleList_) do
		iter_5_3:OnExit()
	end
end

function SummerChessBoardExploreNoteView:Dispose()
	self.switchPageHandler_ = nil
	self.selectIndex_ = nil
	self.firstEnter_ = true

	for iter_6_0, iter_6_1 in ipairs(self.toggleList_) do
		iter_6_1:Dispose()
	end

	self.toggleList_ = nil

	for iter_6_2, iter_6_3 in ipairs(self.noteItemList_) do
		iter_6_3:Dispose()
	end

	self.noteItemList_ = nil

	SummerChessBoardExploreNoteView.super.Dispose(self)
end

function SummerChessBoardExploreNoteView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.videoBtn_, nil, function()
		saveData("SUMMER_3.5_NOTE", "IS_CLICK", 1)
		manager.redPoint:setTip(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO, 0)
		gameContext:Go("/blank")
		manager.audio:Pause("music", true)
		manager.video:Play(GameSetting.summer_note_video.value[3], function(arg_10_0)
			gameContext:Back()
			manager.audio:Pause("music", false)
		end, nil, nil, nil, GameSetting.summer_note_video.value[2])
	end)
end

function SummerChessBoardExploreNoteView:RefreshUI()
	SetActive(self.videoGo_, false)

	for iter_11_0, iter_11_1 in ipairs(self.taskIDList_[self.selectIndex_]) do
		if iter_11_1 == 1 then
			self.noteItemList_[iter_11_0]:Show(false)
			SetActive(self.videoGo_, true)

			self.videoGo_.transform.localPosition = self.noteItemList_[iter_11_0].transform_.localPosition
		else
			self.noteItemList_[iter_11_0]:SetData(iter_11_1)
		end
	end

	for iter_11_2 = #self.taskIDList_[self.selectIndex_] + 1, 4 do
		self.noteItemList_[iter_11_2]:Show(false)
	end
end

function SummerChessBoardExploreNoteView:SwitchPage(arg_12_1)
	self.selectIndex_ = arg_12_1

	self:RefreshUI()

	for iter_12_0, iter_12_1 in ipairs(self.toggleList_) do
		iter_12_1:RefreshRedPoint()
	end
end

return SummerChessBoardExploreNoteView
